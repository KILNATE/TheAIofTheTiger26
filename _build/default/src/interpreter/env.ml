open Utils

(* A scoped environment: a stack of maps representing nested scopes,
   from innermost to outermost. *)
type 'a t = 'a StringMap.t list

(* scope handling *)

(* Enters a new scope by pushing an empty map onto the environment stack. *)
let enter_scope (env : 'a t) = StringMap.empty :: env

(* Exits the current scope by popping the top map from the environment stack. *)
let exit_scope (env : 'a t) = List.tl env

(* empty environment *)
let empty = []

(* utilities *)

(* returns the list of keys that appear in a given environment *)
let keys (env : 'a t) : string list = List.concat (List.map StringMap.keys env)

(* Applies a function to all bindings, keeping track of keys and indices. *)
let mapi f (e : 'a t) = List.map (StringMap.mapi f) e

(* Checks if a predicate holds for all bindings in all scopes. *)
let for_all f (e : 'a t) = List.for_all (StringMap.for_all f) e

(* Returns true if the environment has no bindings. *)
let is_empty x : bool = List.for_all StringMap.is_empty x

(* Recursively looks up a binding by identifier, searching from the
   innermost to outermost scope. *)
let rec find id env =
  let rec loop = function
    | [] ->
        failwith
          (Format.asprintf "key '%s' not found (available keys: [%a])" id
             (Format.pp_print_list Format.pp_print_string)
             (keys env))
    | h :: t -> (
        match StringMap.find_opt id h with Some x -> x | None -> loop t)
  in
  loop env

(* Adds a new binding to the current (topmost) scope. *)
let add id value : 'a t -> 'a t = function
  | [] -> [ StringMap.singleton id value ]
  | h :: t -> StringMap.add id value h :: t

(* Updates an existing binding in the nearest enclosing scope where it
   exists. (The value must have been added before, otherwise a
   Not_found excepetion is raised) *)
let rec update id value = function
  | [] -> raise Not_found
  | h :: t -> (
      match StringMap.find_opt id h with
      | Some _old -> StringMap.add id value h :: t
      | None -> h :: update id value t)

(* printer *)
let print pp_elem fmt (env : 'a t) =
  if is_empty env then Format.fprintf fmt " "
  else
    Format.fprintf fmt "{%a}"
      (Format.pp_print_list
         ~pp_sep:(fun fmt () -> Format.fprintf fmt ", ")
         (StringMap.print
            ~pp_sep:(fun fmt () -> Format.fprintf fmt "; ")
            pp_elem))
      env
