open Utils

(* A memory state is a record with value and functions. Note that
   since we suppose that programs are well typed, we dont need to
   store the actual types (i.e type declarations have no effect) *)
type t = { values : Value.t Env.t; functions : tiger_fun StringMap.t }

(* A Tiger function: takes a list of argument values and returns a result value. *)
and tiger_fun = Value.t list -> Value.t

(* Adds a new value binding to the current state. *)
let add_value (id : string) (value : Value.t) (state : t) =
  { state with values = Env.add id value state.values }

(* Looks up the value bound to an identifier in the current state. *)
let find_value (id : string) (state : t) = Env.find id state.values

(* Updates the value bound to an identifier in the current state. *)
let update_value (id : string) (value : Value.t) (state : t) =
  { state with values = Env.update id value state.values }

(* Retrieves the function associated with the given identifier. *)
let find_fun (id : string) (state : t) : tiger_fun =
  StringMap.find id state.functions

(* Enters a new scope by updating the environment accordingly. *)
let enter_scope (state : t) : t =
  { state with values = Env.enter_scope state.values }

(* Exits the current scope by updating the environment accordingly. *)
let exit_scope (state : t) : t =
  { state with values = Env.exit_scope state.values }

(* Initializes the state with an empty environment and the given runtime functions. *)
let init (runtime : (string * tiger_fun) list) : t =
  {
    values = Env.empty;
    functions =
      List.fold_left
        (fun acc (name, f) -> StringMap.add name f acc)
        StringMap.empty runtime;
  }
