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
     (* complete the function and keep this wildcard card until it becomes redundant *)
     | _ -> Format.asprintf "(%s)" __FUNCTION__ |> Utils.niy

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
     (* complete the function and keep this wildcard card until it becomes redundant *)
     | _ -> Format.asprintf "%a (%s)" Ast.print_lvalue lv __FUNCTION__ |> Utils.niy

(* Resolves an lvalue to the value it refers to, returning the value
   and the updated state.  This may involve evaluating subexpressions
   with side effects, such as index expressions.
   hint: Use Value.array_get
 *)
and read_lvalue (state : State.t) (lv : lvalue) : Value.t * State.t =
  match lv.l_payload with
  | Var id -> (State.find_value id state, state)
     (* complete the function and keep this wildcard card until it becomes redundant *)
     | _ -> Format.asprintf "(%s)" __FUNCTION__ |> Utils.niy


and eval_chunks (state : State.t) (chunks : chunk list) : State.t =
  List.fold_left eval_chunk state chunks

and eval_chunk (state : State.t) (c : chunk) : State.t =
  match c.c_payload with
  | Exp e ->
      (* we evaluate the expression so that it's side effects are taken
         into account, but the result is dicarded *)
      let _, state = eval_expr state e in
      state
     (* complete the function and keep this wildcard card until it becomes redundant *)
     | _ -> Format.asprintf "%a (%s)" Ast.print_chunk c __FUNCTION__ |> Utils.niy

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
     (* complete the function *)
     | _ -> Format.asprintf "(%s) not implemented" __FUNCTION__ |> Utils.niy

let range = function
   (* complete the function *)
   | _ -> Format.asprintf "(%s) not implemented" __FUNCTION__ |> Utils.niy

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
