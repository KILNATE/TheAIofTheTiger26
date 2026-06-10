open Ast

(* utilities to convert binary operators to an actual function *)
let binop_to_fun (op : binop) : int -> int -> int =
  match op with Add -> ( + ) | Sub -> ( - ) | Mul -> ( * ) | Div -> ( / )

let relop_to_fun (op : relop) (v1 : Value.t) (v2 : Value.t) =
  let open Value in
  match (op, v1, v2) with
  | Eq, _, _ -> if v1 = v2 then 1 else 0
  | Ne, _, _ -> if v1 <> v2 then 1 else 0
  | Lt, Int r1, Int r2 -> if r1 < r2 then 1 else 0
  | Le, Int r1, Int r2 -> if r1 <= r2 then 1 else 0
  | Gt, Int r1, Int r2 -> if r1 > r2 then 1 else 0
  | Ge, Int r1, Int r2 -> if r1 >= r2 then 1 else 0
  | Lt, String r1, String r2 -> if r1 < r2 then 1 else 0
  | Le, String r1, String r2 -> if r1 <= r2 then 1 else 0
  | Gt, String r1, String r2 -> if r1 > r2 then 1 else 0
  | Ge, String r1, String r2 -> if r1 >= r2 then 1 else 0
  | _, _, _ -> failwith "invalid comparison"

(* Evaluates an expression in a given state.  Returns the result and
   possibly updated state. *)
let rec eval_expr (state : State.t) (e : expr) : Value.t * State.t =
  match e.e_payload with
  | Const i -> (Int i, state)
  | String s -> (String s, state)
  | Lval lv -> read_lvalue state lv
  | Seq exprs ->
      List.fold_left
        (fun (_, current) sub -> eval_expr current sub)
        (Value.Void, state) exprs
  | Assign (target, rhs) ->
      let computed, state = eval_expr state rhs in
      (Value.Void, write_lvalue state target computed)
  | Binop (left, op, right) ->
      let lv, state = eval_expr state left in
      let rv, state = eval_expr state right in
      let result = binop_to_fun op (Value.cast_int left.e_loc lv) (Value.cast_int right.e_loc rv) in
      (Int result, state)
  | Relop (left, op, right) ->
      let lv, state = eval_expr state left in
      let rv, state = eval_expr state right in
      (Int (relop_to_fun op lv rv), state)
  | Boolop (left, op, right) ->
      let lv, state = eval_expr state left in
      let left_int = Value.cast_int left.e_loc lv in
      let short_circuits = match op with And -> left_int = 0 | Or -> left_int <> 0 in
      if short_circuits then (Int (if left_int = 0 then 0 else 1), state)
      else
        let rv, state = eval_expr state right in
        (Int (if Value.cast_int right.e_loc rv <> 0 then 1 else 0), state)
  | IfThenElse (cond, then_branch, else_branch) ->
      let cv, state = eval_expr state cond in
      if Value.cast_int cond.e_loc cv <> 0 then eval_expr state then_branch
      else (
        match else_branch with
        | Some branch -> eval_expr state branch
        | None -> (Value.Void, state))
  | While (cond, body) ->
      let rec loop state =
        let cv, state = eval_expr state cond in
        if Value.cast_int cond.e_loc cv <> 0 then
          let _, state = eval_expr state body in
          loop state
        else (Value.Void, state)
      in
      loop state
  | Let (chunks, body) ->
      let inner = eval_chunks (State.enter_scope state) chunks in
      let result, inner = eval_expr inner body in
      (result, State.exit_scope inner)
  | ArrayInit (_, size, content) ->
      let sv, state = eval_expr state size in
      let cv, state = eval_expr state content in
      (Value.array_make (Value.cast_int size.e_loc sv) cv, state)
  (* evaluation from left to right *)
  | Funcall (name, args) ->
      let state, args =
        List.fold_left
          (fun (s, acc) a ->
            let r, s' = eval_expr s a in
            (s', acc @ [ r ]))
          (state, []) args
      in
      let func = State.find_fun name state in
      (func args, state)

(* Writes a value to the location referred to by the given lvalue,
   returning the updated state.  This may involve evaluating
   subexpressions with side effects (e.g. array indices), and in the
   case of nested lvalues (such as array elements), recursively
   updates the structure.

   hint: Use read_lvalue, Value.array_set
 *)
and write_lvalue (state : State.t) (lv : lvalue) (value : Value.t) : State.t =
  match lv.l_payload with
  | Var id -> State.update_value id value state
  | Array (base, idx) ->
      let base_value, state = read_lvalue state base in
      let idx_value, state = eval_expr state idx in
      let cells = Value.cast_array base.l_loc base_value in
      let _ = Value.array_set cells (Value.cast_int idx.e_loc idx_value) value in
      state

(* Resolves an lvalue to the value it refers to, returning the value
   and the updated state.  This may involve evaluating subexpressions
   with side effects, such as index expressions.
   hint: Use Value.array_get
 *)
and read_lvalue (state : State.t) (lv : lvalue) : Value.t * State.t =
  match lv.l_payload with
  | Var id -> (State.find_value id state, state)
  | Array (base, idx) ->
      let base_value, state = read_lvalue state base in
      let idx_value, state = eval_expr state idx in
      let cells = Value.cast_array base.l_loc base_value in
      (Value.array_get cells (Value.cast_int idx.e_loc idx_value), state)

and eval_chunks (state : State.t) (chunks : chunk list) : State.t =
  List.fold_left eval_chunk state chunks

and eval_chunk (state : State.t) (c : chunk) : State.t =
  match c.c_payload with
  | Exp e ->
      (* we evaluate the expression so that it's side effects are taken
         into account, but the result is dicarded *)
      let _, state = eval_expr state e in
      state
  | Vardec (id, _, rhs) ->
      let computed, state = eval_expr state rhs in
      State.add_value id computed state
  | Typedec _ -> state

open Value

let print_int out = function
  | [ Int x ] ->
      Format.fprintf out "%i%!" x;
      Void
  | [ arg ] ->
      failwith
        (Format.asprintf "type error in %s: was expecting an int but got %a"
           __FUNCTION__ Value.print arg)
  | args ->
      failwith
        (Format.asprintf
           "arity error in %s: was expecting one argument but got %i"
           __FUNCTION__ (List.length args))

let print out = function
  | [ String x ] ->
      Format.fprintf out "%s%!" x;
      Void
  | [ arg ] ->
      failwith
        (Format.asprintf "type error in %s: was expecting a string but got %a"
           __FUNCTION__ Value.print arg)
  | args ->
      failwith
        (Format.asprintf
           "arity error in %s: was expecting one argument but got %i"
           __FUNCTION__ (List.length args))

let concat = function
  | [ String first; String second ] -> String (first ^ second)
  | [ _; _ ] -> failwith (Format.asprintf "type error in %s: was expecting two strings" __FUNCTION__)
  | args ->
      failwith
        (Format.asprintf
           "arity error in %s: was expecting two arguments but got %i"
           __FUNCTION__ (List.length args))

let range = function
  | [ Int low; Int sup ] -> Int (low + Random.int (sup - low + 1))
  | [ _; _ ] -> failwith (Format.asprintf "type error in %s: was expecting two ints" __FUNCTION__)
  | args ->
      failwith
        (Format.asprintf
           "arity error in %s: was expecting two arguments but got %i"
           __FUNCTION__ (List.length args))

(* Evaluates a Tiger program with an optional output formatter.
   Initializes the runtime environment with built-in functions and
   evaluates the program from the initial state. *)
let eval_program ?oc (p : program) : State.t =
  let out = match oc with None -> Format.std_formatter | Some o -> o in
  let runtime =
    [
      ("print_int", print_int out);
      ("print", print out);
      ("concat", concat);
      ("range", range);
    ]
  in
  let start = State.init runtime in
  eval_chunks start p
