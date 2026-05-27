open Domain
open Utils

module Make (D : D) = struct
  module Absvalue = Absvalue.Make (D)

  type non_empty_state = {
    values : Absvalue.t Env.t;
    functions : (Absvalue.t list -> Absvalue.t) StringMap.t;
  }

  (* type of (possibly empty) states *)
  type t = Bot | Nonbot of non_empty_state

  let empty : t = Bot
  let non_empty x : t = Nonbot x
  let is_empty = function Bot -> true | Nonbot _ -> false

  let init runtime =
    Nonbot
      {
        values = Env.empty;
        functions =
          List.fold_left
            (fun acc (name, f) -> StringMap.add name f acc)
            StringMap.empty runtime;
      }

  let print fmt (s : t) =
    match s with
    | Bot -> Format.fprintf fmt "unreachable"
    | Nonbot s -> Format.fprintf fmt "%a" (Env.print Absvalue.print) s.values

  let join (s1 : t) (s2 : t) : t =
    match (s1, s2) with
    | Bot, x | x, Bot -> x
    | Nonbot s1, Nonbot s2 ->
        let values =
          Env.mapi (fun v i -> Absvalue.join i (Env.find v s2.values)) s1.values
        in
        Nonbot { s1 with values }

  let widen (s1 : t) (s2 : t) : t =
    match (s1, s2) with
    | Bot, x | x, Bot -> x
    | Nonbot s1, Nonbot s2 ->
        let values =
          Env.mapi
            (fun v i -> Absvalue.widen i (Env.find v s2.values))
            s1.values
        in
        Nonbot { s1 with values }

  let subset (s1 : t) (s2 : t) : bool =
    match (s1, s2) with
    | Bot, _ -> true
    | Nonbot s1, Nonbot s2 ->
        Env.for_all
          (fun v i -> Absvalue.subset i (Env.find v s2.values))
          s1.values
    | Nonbot _, Bot -> false

  let find_value (id : string) (state : t) : Absvalue.t =
    match state with
    | Bot -> raise Not_found
    | Nonbot state -> Env.find id state.values

  let find_fun (id : string) (state : t) : Absvalue.t list -> Absvalue.t =
    match state with
    | Bot -> raise Not_found
    | Nonbot state -> StringMap.find id state.functions

  let add_value (id : string) (value : Absvalue.t) (state : t) : t =
    match state with
    | Bot -> Bot
    | Nonbot state ->
        Nonbot { state with values = Env.add id value state.values }

  let update_value (id : string) (value : Absvalue.t) (state : t) : t =
    match state with
    | Bot -> Bot
    | Nonbot state ->
        Nonbot { state with values = Env.update id value state.values }

  let enter_scope state =
    match state with
    | Bot -> Bot
    | Nonbot state ->
        Nonbot { state with values = Env.enter_scope state.values }

  let exit_scope state =
    match state with
    | Bot -> Bot
    | Nonbot state -> Nonbot { state with values = Env.exit_scope state.values }
end
