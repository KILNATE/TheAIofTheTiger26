(* type of values ​​manipulated at runtime *)
type t = Void | Int of int | String of string | Array of t array
(* the runtime value system does not constrain the homogeneity of
     arrays: an array can very well contain an integer, a string, and
     a record. However, this should not happen if the program is well
     typed. *)

(* printer *)
let rec print fmt r =
  match r with
  | Void -> Format.fprintf fmt "()"
  | Int i -> Format.fprintf fmt "%i" i
  | String s -> Format.fprintf fmt "%s" s
  | Array a ->
      Format.fprintf fmt "%a"
        (Utils.pp_print_array
           ~pp_sep:(fun fmt () -> Format.fprintf fmt ", ")
           print)
        a

(*  Dynamic conversions with error handling *)
let cast_int loc = function
  | Int i -> i
  | r ->
      Format.asprintf "%a\n\nWas expecting int but got %a\n%!" Errors.from_loc
        loc print r
      |> Errors.fail

let cast_array loc = function
  | Array a -> a
  | r ->
      Format.asprintf "%a a\n\nWas expecting array but got %a\n%!"
        Errors.from_loc loc print r
      |> Errors.fail

(* wrappers for functionnal array manipulation *)
let array_make (size : int) (content : t) : t = Array (Array.make size content)

let array_set (arr : t array) (idx : int) (value : t) : t =
  Array Utils.(Array.set arr idx value)

let array_get (arr : t array) (idx : int) : t = Array.get arr idx
