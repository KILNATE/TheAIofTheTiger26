open Domain
open Ast

module Make (D : D) = struct
  open D
  module Value = Absvalue.Make (D)
  module State = Absstate.Make (D)
  module Guard = Guard.Make (D)

  exception Max_unroll of State.t

  let boolop_to_fun (op : boolop) =
    match op with And -> Absint.logical_and | Or -> Absint.logical_or

  let num_of_truth = function
    | True -> Absint.of_int 1
    | False -> Absint.of_int 0
    | Unknown -> Absint.join (Absint.of_int 0) (Absint.of_int 1)

  let relop_to_fun (op : relop) (r1 : Value.t) (r2 : Value.t) =
    match (op, r1, r2) with
    | Eq, Int r1, Int r2 -> Absint.eq r1 r2
    | Eq, String s1, String s2 -> Absstring.eq s1 s2 |> num_of_truth
    | Ne, Int r1, Int r2 -> Absint.ne r1 r2
    | Ne, _, _ -> num_of_truth Unknown
    | Lt, Int r1, Int r2 -> Absint.lt r1 r2
    | Le, Int r1, Int r2 -> Absint.le r1 r2
    | Gt, Int r1, Int r2 -> Absint.gt r1 r2
    | Ge, Int r1, Int r2 -> Absint.ge r1 r2
    | _, _, _ ->
        Format.asprintf "invalid comparison : %a %s %a" Value.print r1
          (relop_to_string op) Value.print r2
        |> failwith

  (* Computes a fixed point of function [f] over abstract state [x] with widening.
       Continues applying [f] until the state no longer grows (i.e., reaches stability).
     Hint: use me at step 6 *)
  let rec fix f state =
    let fx = f state in
    if State.subset fx state then state else fix f (State.widen state fx)

  (* [filter] attempts to refine [state] based on the boolean [cond].
     - If [cond] is definitely true or false it returns the original [state] or [Bot] depending on [r].
     - If [cond] is unknown, it tries [Guard.filter_annot]; on failure, it falls back to [state].
     Hint: use me at step 5 *)
  let filter (state : State.t) (cond : (State.t, Value.t) Annotast.expr)
      (r : bool) : State.t =
    match cond.e_value |> Value.cast_bool cond.e_loc with
    | True -> if r then state else Bot
    | False -> if r then Bot else state
    | Unknown -> (
        try Guard.filter_annot state cond r with Guard.Unfiltrable -> state)

  (* Entry point for analyzing an expression.  If the abstract state
     is empty (i.e., unreachable code), annotate the expression
     recursively with an unreachable value.  Otherwise, Analyze an
     expression node and return its annotated version.  The analysis
     may modify the abstract state, which is propagated through
     recursively. *)
  let rec analyze_expr (state : State.t) (e : expr) :
      (State.t, Value.t) Annotast.expr =
    (* local function that operates on non-empty states *)
    let analyze_non_bot_expr (state : State.t) (e : expr) :
        (State.t, Value.t) Annotast.expr =
      let open Annotast in
      match e.e_payload with
      | Const i ->
          let absi = Value.Int (Absint.of_int i) in
          build_expr e.e_loc (AConst i) state absi
      | String s ->
          let abss = Value.String (Absstring.of_string s) in
          build_expr e.e_loc (AString s) state abss
      | Binop (l, op, r) -> analyze_binop e.e_loc state l r op
      | Boolop (l, op, r) -> analyze_boolop e.e_loc state l r op
      | Relop (l, op, r) -> analyze_relop e.e_loc state l r op
      | Funcall (name, args) -> analyze_funcall state e.e_loc name args
      | Assign (left, right) -> analyze_assign e.e_loc state left right
      | ArrayInit (id, size, content) ->
          analyze_array_init e.e_loc state id size content
      | Lval lv ->
          let lv' = read_lvalue state lv in
          build_expr e.e_loc (ALval lv') lv'.l_state lv'.l_value
      | Seq l ->
          let l_annot, s, res = analyze_seq state l in
          build_expr e.e_loc (ASeq l_annot) s res
      | Let (chunks, body) -> analyze_let e.e_loc state chunks body
      | IfThenElse (cond, true_branch, false_branch) ->
          analyze_if state e.e_loc cond true_branch false_branch
      | While (cond, body) -> analyze_while state e.e_loc cond body
    in

    (* If the abstract state is empty then the code is unreachable and
       we annotate the expression and the whole sub-ast with the
       'Unreachable' value. Otherwise, analyze the expression normally
       assuming it is reachable. *)
    if State.is_empty state then Annotast.fill_expr e state Value.Unreachable
    else analyze_non_bot_expr state e

  (* Step 2: Recursively analyzes the operands, applies the abstract
     version of the operator and builds the annotated version of the
     ast node. The analysis should take care of evaluating first the
     left operand and then the right one, propagating the state in
     that order. Both operands must evaluate to an integer (use
     Value.cast_int), and the result should also be an tiger integer
     (Value.Int) *)
  and analyze_binop (loc : location) (state : State.t) (left : Ast.expr)
      (right : Ast.expr) (op : Ast.binop) =
    let open Annotast in
    let left_a = analyze_expr state left in
    let right_a = analyze_expr left_a.e_state right in
    let v1 = Value.cast_int left.e_loc left_a.e_value in
    let v2 = Value.cast_int right.e_loc right_a.e_value in
    let res = match op with
      | Add -> Absint.add v1 v2 | Sub -> Absint.sub v1 v2
      | Mul -> Absint.mul v1 v2 | Div -> Absint.div v1 v2
    in
    build_expr loc (ABinop (left_a, op, right_a)) right_a.e_state (Value.Int res)

  (* Step 2: Analyze a comparison *)
  and analyze_relop (loc : location) (state : State.t) (left : Ast.expr)
      (right : Ast.expr) (op : Ast.relop) =
    let e1 = analyze_expr state left in
    let e2 = analyze_expr e1.e_state right in
    let cmp_result = relop_to_fun op e1.e_value e2.e_value in
    Annotast.build_expr loc (ARelop (e1, op, e2)) e2.e_state (Value.Int cmp_result)

  (* Step 2: Analyzes a sequence of expressions in order, threading state
     through each one.  Returns the list of annotated expressions, the
     final state, and the value of the last expression. *)
  and analyze_seq (state : State.t) (exprs : Ast.expr list) :
      (State.t, Value.t) Annotast.expr list * State.t * Value.t =
    let annotated, st, v =
      List.fold_left
        (fun (acc, s, _) e ->
          let r = analyze_expr s e in
          (acc @ [ r ], r.e_state, r.e_value))
        ([], state, Value.Void) exprs
    in
    (annotated, st, v)

  (* Step 2: Analyze an assignment.
     Hint: use write_value *)
  and analyze_assign loc (state : State.t) (left : Ast.lvalue)
      (right : Ast.expr) : (State.t, Value.t) Annotast.expr =
    let rhs = analyze_expr state right in
    let lv = write_lvalue rhs.e_state left rhs.e_value in
    Annotast.build_expr loc (AAssign (lv, rhs)) lv.l_state Value.Void

  (* Step 2: Analyze an array initialization by evaluating the size and
     content expressions. Returns the annotated expression and result. *)
  and analyze_array_init loc (state : State.t) (id : string) (size : expr)
      (content : expr) : (State.t, Value.t) Annotast.expr =
    let open Annotast in
    let size_a = analyze_expr state size in
    let content_a = analyze_expr size_a.e_state content in
    let n = Value.cast_int size.e_loc size_a.e_value in
    let arr = Value.array_make n content_a.e_value in
    build_expr loc (AArrayInit (id, size_a, content_a)) content_a.e_state arr

  (* Step 2: Analyze a function call. Arguments are evaluated from left
     to right *)
  and analyze_funcall (state : State.t) loc (name : string) (args : expr list) :
      (State.t, Value.t) Annotast.expr =
    let open Annotast in
    let evaluated, s =
      List.fold_left
        (fun (acc, s) arg ->
          let ea = analyze_expr s arg in
          (acc @ [ ea ], ea.e_state))
        ([], state) args
    in
    let f = State.find_fun name s in
    let res = f (List.map (fun e -> e.e_value) evaluated) in
    build_expr loc (AFuncall (name, evaluated)) s res

  (* Step 2: Analyze a let-binding *)
  and analyze_let loc state chunks body =
    let open Annotast in
    let chunks_annot, inner = analyze_chunks (State.enter_scope state) chunks in
    let body_annot = analyze_expr inner body in
    let outer = State.exit_scope body_annot.e_state in
    build_expr loc (ALet (chunks_annot, body_annot)) outer body_annot.e_value

  (* Step 2: Analyze a boolean operation
     - Hint : use State.join *)
  and analyze_boolop (loc : location) (state : State.t) (left : Ast.expr)
      (right : Ast.expr) (op : Ast.boolop) =
    let open Annotast in
    let left_annot = analyze_expr state left in
    let left_val = Value.cast_int left.e_loc left_annot.e_value in
    let short_circuits =
      match (op, Absint.truth left_val) with
      | And, Domain.False -> true
      | Or, Domain.True -> true
      | _ -> false
    in
    if short_circuits then
      let right_annot = analyze_expr State.empty right in
      let v = match op with
        | And -> Absint.of_int 0
        | Or -> Absint.of_int 1
      in
      build_expr loc (ABoolop (left_annot, op, right_annot)) left_annot.e_state
        (Value.Int v)
    else
      let must_eval = match (op, Absint.truth left_val) with
        | And, Domain.True | Or, Domain.False -> true
        | _ -> false
      in
      let right_annot = analyze_expr left_annot.e_state right in
      let right_val = Value.cast_int right.e_loc right_annot.e_value in
      let combined = boolop_to_fun op left_val right_val in
      let final_s =
        if must_eval then right_annot.e_state
        else State.join left_annot.e_state right_annot.e_state
      in
      build_expr loc (ABoolop (left_annot, op, right_annot)) final_s
        (Value.Int combined)

  (* Evaluates an lvalue to read its value.
     - If the lvalue is a variable, retrieves its value from the current state.
     - If it's an array access, recursively reads the base lvalue, evaluates the
       index expression and retrieves the corresponding element from the array. *)
  and read_lvalue state (lv : lvalue) : (State.t, Value.t) Annotast.lvalue =
    let open Annotast in
    match lv.l_payload with
    | Var id ->
        let value = State.find_value id state in
        build_lval lv.l_loc (AVar id) state value
    | Array (lv', idx) ->
        let base = read_lvalue state lv' in
        let idx_annot = analyze_expr base.l_state idx in
        let cells = Value.cast_array lv'.l_loc base.l_value in
        let element =
          Value.array_get cells (Value.cast_int idx.e_loc idx_annot.e_value)
        in
        build_lval lv.l_loc (AArray (base, idx_annot)) idx_annot.e_state element

  (* Evaluates an lvalue to perform a write operation.
     - If the lvalue is a variable, updates its value in the current state.
     - If it's an array access, recursively reads the base lvalue, evaluates
       the index expression, updates the corresponding element in the array,
       and recursively writes the modified array back. *)
  and write_lvalue state (lv : lvalue) (v : Value.t) :
      (State.t, Value.t) Annotast.lvalue =
    let open Annotast in
    match lv.l_payload with
    | Var id ->
        let state = State.update_value id v state in
        build_lval lv.l_loc (AVar id) state Value.Void
    | Array (lv', idx) ->
        let base = read_lvalue state lv' in
        let idx_annot = analyze_expr base.l_state idx in
        let cells = Value.cast_array lv'.l_loc base.l_value in
        let updated =
          Value.array_set cells (Value.cast_int idx.e_loc idx_annot.e_value) v
        in
        write_lvalue idx_annot.e_state lv' updated

  (* Step 3: Analyze an if-expression by evaluating the condition and both
     branches. Joins the resulting states and values.
     - Hint : use State.join, Value.join

     Step 5: Filters the abstract state based on the condition's truth
     value, analyzes each branch under the corresponding filtered
     state.
     - Hint: use filter *)
  and analyze_if (state : State.t) (loc : location) (cond : expr) (tbr : expr)
      (fbr : expr option) : (State.t, Value.t) Annotast.expr =
    let open Annotast in
    let cond_annot = analyze_expr state cond in
    let s_true = filter cond_annot.e_state cond_annot true in
    let s_false = filter cond_annot.e_state cond_annot false in
    let then_annot = analyze_expr s_true tbr in
    match fbr with
    | Some else_expr ->
        let else_annot = analyze_expr s_false else_expr in
        build_expr loc
          (AIfThenElse (cond_annot, then_annot, Some else_annot))
          (State.join then_annot.e_state else_annot.e_state)
          (Value.join then_annot.e_value else_annot.e_value)
    | None ->
        build_expr loc
          (AIfThenElse (cond_annot, then_annot, None))
          (State.join then_annot.e_state s_false)
          Value.Void

  (* [accumulate cond body initial] simulates one additional iteration of a while-loop:
  - It analyzes the loop condition [cond] under the current abstract state [initial].
  - filters this state to keep only the executions where the condition *may be* true
    (i.e., where the loop would proceed).
  - The loop body [body] is analyzed under this filtered state.
  - joins the resulting state with the original [initial] to accumulate
    the effect of one more potential loop iteration.
*)
  and accumulate (cond : expr) (body : expr) (initial : State.t) =
    let cond_annot = analyze_expr initial cond in
    let s' = cond_annot.e_state in
    let s' = filter s' cond_annot true in
    let ab = analyze_expr s' body in
    State.join initial ab.e_state

  (* Step 3: Analyze a while loop by evaluating its condition and body
     repeatedly until the condition can be proven to be statically
     false. Raises Max_unroll if the number of iteration exceeds
     Utils.max_iter.

     Hint: use accumulate
   *)
  and unroll_while (state : State.t) (loc : location) (cond : expr)
      (body : expr) : (State.t, Value.t) Annotast.expr =
    let open Annotast in
    let make_while_node inv =
      let c = analyze_expr inv cond in
      let b = analyze_expr (filter c.e_state c true) body in
      build_expr loc (AWhile (c, b)) (filter c.e_state c false) Value.Void
    in
    let rec iter current n =
      let next = accumulate cond body current in
      if State.subset next current then
        make_while_node current
      else if n >= Utils.max_iter then
        raise (Max_unroll current)
      else
        iter next (n + 1)
    in
    iter state 0

  (* Step 6: Analyze of a while-loop by computing a fixed point over the loop body.
     Repeatedly analyzes the condition and body under the filtered true state,
     joins intermediate states to approximate the loop effect, and filters the
     final state with the condition being false to model loop exit.

   Hint: Use the original state if the loop is unreachable; otherwise,
   model loop exit by filtering with condition false.  *)
  and fixpoint_while (state : State.t) (loc : location) (cond : expr)
      (body : expr) : (State.t, Value.t) Annotast.expr =
    let open Annotast in
    if State.is_empty state then
      let c = analyze_expr state cond in
      let b = analyze_expr state body in
      build_expr loc (AWhile (c, b)) state Value.Void
    else
      let inv = fix (accumulate cond body) state in
      let cond_a = analyze_expr inv cond in
      let body_a = analyze_expr (filter cond_a.e_state cond_a true) body in
      let after_loop = filter cond_a.e_state cond_a false in
      build_expr loc (AWhile (cond_a, body_a)) after_loop Value.Void

  (* [analyze_while state loc cond body] analyzes a while-loop in two phases:
   - First tries to analyze using bounded unrolling (via [unroll_while]).
   - If the loop does not terminate within a bounded number of iterations (Max_unroll raised),
     it falls back to computing a fixpoint over the loop body (via [fixpoint_while]). *)
  and analyze_while (state : State.t) (loc : location) (cond : expr)
      (body : expr) : (State.t, Value.t) Annotast.expr =
    try unroll_while state loc cond body
    with Max_unroll state -> fixpoint_while state loc cond body

  (* Analyze and annotate each chunk in the chunk list. Analyzing a
     chunk may modify the state, so the updated state must be
     propagated to the next chunk.  Returns the list of annotated
     chunks and the final state. *)
  and analyze_chunks (state : State.t) (chunks : Ast.chunk list) :
      (State.t, Value.t) Annotast.chunk list * State.t =
    List.fold_left
      (fun (acc, s) c ->
        let c_annot = analyze_chunk s c in
        (acc @ [ c_annot ], c_annot.c_state))
      ([], state) chunks

  and analyze_chunk state (c : chunk) : (State.t, Value.t) Annotast.chunk =
    let open Annotast in
    match c.c_payload with
    | Typedec (id, typ) -> build_chunk c.c_loc (ATypedec (id, typ)) state
    | Exp e ->
        let e_annot = analyze_expr state e in
        build_chunk c.c_loc (AExp e_annot) e_annot.e_state
    | Vardec (id, typ_opt, e) ->
        let e_annot = analyze_expr state e in
        let state = State.add_value id e_annot.e_value e_annot.e_state in
        build_chunk c.c_loc (AVardec (id, typ_opt, e_annot)) state

  (** entry point of the analyzer *)
  let analyze_program ?(show_annotast = false) ?(pdf = false) (p : Ast.program)
      : (State.t, Value.t) Annotast.program =
    let runtime =
      [
        ( "range",
          function
          | [ Value.Int l; Value.Int h ] -> Value.Int (Absint.range l h)
          | _ -> failwith "type error" );
        ( "print_int",
          function [ Value.Int _x ] -> Value.Void | _ -> failwith "type error"
        );
        ( "concat",
          function
          | [ Value.String s1; Value.String s2 ] ->
              Value.String (Absstring.concat s1 s2)
          | _ -> failwith "type error" );
        ("print", function [ String _x ] -> Void | _ -> failwith "type error");
      ]
    in
    let state = State.init runtime in
    let annotd, _ = analyze_chunks state p in
    let pp_state s = Format.asprintf "%a" State.print s in
    let pp_res r = Format.asprintf "%a" Value.print r in
    (if show_annotast then
       let pp_state fmt (s : State.t) =
         match s with
         | Bot -> Format.fprintf fmt "⊥"
         | Nonbot { values; _ } ->
             if Env.is_empty values then Format.fprintf fmt "∅"
             else State.print fmt s
       in
       Terminalprinter.print_program_and_state pp_state Format.std_formatter
         annotd);
    if pdf then
      Pdfprinter.write_to_file
        ~color_state:(function State.Bot -> "gray" | _ -> "red")
        ~color_expr:(function
          | Value.Int _ -> "green"
          | Value.String _ -> "orange"
          | Value.Unreachable -> "gray"
          | _ -> "blue")
        (Filename.chop_extension !Utils.file ^ ".tex")
        pp_state pp_res annotd;
    annotd
end
