(*   ,   A           {}
 *  / \, | ,        .--.
 * |    =|= >      /.--.\
 *  \ /` | `       |====|
 *   `   |         |`::`|
 *       |     .-;`\..../`;_.-^-._
 *      /\\/  /  |...::..|`   :   `|
 *      |:'\ |   /'''::''|   .:.   |
 *       \ /\;-,/\   ::  |..:::::..|
 *       |\ <` >  >._::_.| ':::::' |
 *       | `""`  /   ^^  |   ':'   |
 *       |       |       \    :    /
 *       |       |        \   :   /
 *       |       |___/\___|`-.:.-`
 *       |        \_ || _/    `
 *       |        <_ >< _>
 *       |        |  ||  |
 *       |        |  ||  |
 *       |       _\.:||:./_
 *       |      /____/\____\ *)

open Ast

module Make (D : Domain.D) = struct
  module State = Absstate.Make (D)
  module Value = Absvalue.Make (D)
  open D

  (* raised for cases where the condition is too complex or not supported
     for refinement *)
  exception Unfiltrable

  (** utility function to inverse a comparison operator *)
  let inv = function
    | Eq -> Ne
    | Ne -> Eq
    | Lt -> Ge
    | Le -> Gt
    | Gt -> Le
    | Ge -> Lt


  (** utility function to turn a comparison operator to its filtering
      counterpart in the abstract domain *)
  let filter_fun cmp_op =
    match cmp_op with
    | Eq -> Absint.filter_eq
    | Le -> Absint.filter_le
    | Ge -> Absint.filter_ge
    | Lt -> Absint.filter_lt
    | Gt -> Absint.filter_gt
    | Ne -> Absint.filter_ne

  (*
     [compare state lv cmp v] attempts to refine the state [state] by comparing
     a lvalue [lv] with a value [v] using a relational operator [cmp].

     Useful to handle filtering of the form (x < 3, x <> 10 ...)

     If the state is bottom (infeasible), it returns bottom.  Otherwise, it
     tries to refine the value associated with a variable in [lv] if
     possible. If an Bot_found exception is raised, it returns an empty
     state.  *)
  let compare (state : State.t) (lv : ('a, 'b) Annotast.lvalue) (cmp : relop)
      (v : Value.t) : State.t =
    match state with
    | Bot -> Bot
    | _ -> (
        try
          let open Annotast in
          match (lv.l_payload, v) with
          | AVar v, Int x ->
              let v_val = State.find_value v state |> Value.cast_int lv.l_loc in
              let new_v_val = (filter_fun cmp) v_val x in
              State.add_value v (Int new_v_val) state
          | _ -> state
        with Domain.Bot_found -> State.Bot)

  (* Boolean condition refinement:

     [filter_annot state cond r] refines the abstract state [state]
     based on the boolean condition [cond]:
     - If [r = true], it keeps only states where [cond] may hold.
     - If [r = false], it keeps only states where [cond] may be false.

     Raises [Unfiltrable] if the condition is too complex or not supported
     for refinement (e.g., expressions with side-effects ).
  *)

  let rec filter_annot (state : State.t)
      (cond : (State.t, Value.t) Annotast.expr) (r : bool) : State.t =
    match cond.e_payload with
    (* guards of the form [x < c] where [c] is a constant *)
    | ARelop ({ e_payload = ALval id; _ }, cmp, { e_value = v; _ }) ->
        let cmp = if r then cmp else inv cmp in
        compare state id cmp v
    | _ -> raise Unfiltrable
end
