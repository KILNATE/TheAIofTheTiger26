(** Other Types *)
type t = Exact_string of String.t | TopString

let print fmt = function
  | Exact_string s -> Format.fprintf fmt "\"%s\"" s
  | TopString -> Format.pp_print_string fmt "\"T\""

let eq s1 s2 =
  match (s1, s2) with
  | Exact_string s1, Exact_string s2 ->
      if s1 = s2 then Domain.True else Domain.False
  | _ -> Domain.Unknown

let of_string x = Exact_string x
let join _a _b = TopString
let widen _ _ = TopString

let subset a b =
  match (a, b) with
  | _, TopString -> true
  | Exact_string s1, Exact_string s2 -> s1 = s2
  | _ -> false

let concat s1 s2 =
  match (s1, s2) with
  | Exact_string s1, Exact_string s2 -> Exact_string (s1 ^ s2)
  | _ -> TopString
