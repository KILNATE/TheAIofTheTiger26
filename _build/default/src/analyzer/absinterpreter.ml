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
     Format.asprintf "%s not implemented" __FUNCTION__ |> Utils.niy

  (* Step 2: Analyze a comparison *)
  and analyze_relop (loc : location) (state : State.t) (left : Ast.expr)
      (right : Ast.expr) (op : Ast.relop) =
     Format.asprintf "%s not implemented" __FUNCTION__ |> Utils.niy

  (* Step 2: Analyzes a sequence of expressions in order, threading state
     through each one.  Returns the list of annotated expressions, the
     final state, and the value of the last expression. *)
  and analyze_seq (state : State.t) (exprs : Ast.expr list) :
      (State.t, Value.t) Annotast.expr list * State.t * Value.t =
     Format.asprintf "%s" __FUNCTION__ |> Utils.niy

  (* Step 2: Analyze an assignment.
     Hint: use write_value *)
  and analyze_assign loc (state : State.t) (left : Ast.lvalue)
      (right : Ast.expr) : (State.t, Value.t) Annotast.expr =
     Format.asprintf "%s" __FUNCTION__ |> Utils.niy

  (* Step 2: Analyze an array initialization by evaluating the size and
     content expressions. Returns the annotated expression and result. *)
  and analyze_array_init loc (state : State.t) (id : string) (size : expr)
      (content : expr) : (State.t, Value.t) Annotast.expr =
     Format.asprintf "%s" __FUNCTION__ |> Utils.niy

  (* Step 2: Analyze a function call. Arguments are evaluated from left
     to right *)
  and analyze_funcall (state : State.t) loc (name : string) (args : expr list) :
      (State.t, Value.t) Annotast.expr =
     Format.asprintf "%s" __FUNCTION__ |> Utils.niy

  (* Step 2: Analyze a let-binding *)
  and analyze_let loc state chunks body =
     Format.asprintf "%s" __FUNCTION__ |> Utils.niy

  (* Step 2: Analyze a boolean operation
     - Hint : use State.join *)
  and analyze_boolop (loc : location) (state : State.t) (left : Ast.expr)
      (right : Ast.expr) (op : Ast.boolop) =
     Format.asprintf "%s not implemented" __FUNCTION__ |> Utils.niy

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
     (* replace with your own code *)
     Format.asprintf "%s" __FUNCTION__ |> Utils.niy

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
     (* replace with your own code *)
     Format.asprintf "%s" __FUNCTION__ |> Utils.niy

  (* Step 3: Analyze an if-expression by evaluating the condition and both
     branches. Joins the resulting states and values.
     - Hint : use State.join, Value.join

     Step 5: Filters the abstract state based on the condition's truth
     value, analyzes each branch under the corresponding filtered
     state.
     - Hint: use filter *)
  and analyze_if (state : State.t) (loc : location) (cond : expr) (tbr : expr)
      (fbr : expr option) : (State.t, Value.t) Annotast.expr =
     (* replace with your own code *)
     Format.asprintf "%s" __FUNCTION__ |> Utils.niy

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
     (* replace with your own code *)
     Format.asprintf "%s" __FUNCTION__ |> Utils.niy

  (* Step 6: Analyze of a while-loop by computing a fixed point over the loop body.
     Repeatedly analyzes the condition and body under the filtered true state,
     joins intermediate states to approximate the loop effect, and filters the
     final state with the condition being false to model loop exit.

   Hint: Use the original state if the loop is unreachable; otherwise,
   model loop exit by filtering with condition false.  *)
  and fixpoint_while (state : State.t) (loc : location) (cond : expr)
      (body : expr) : (State.t, Value.t) Annotast.expr =
     (* replace with your own code *)
     Format.asprintf "%s" __FUNCTION__ |> Utils.niy

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
