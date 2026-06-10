let file = ref ""
let max_iter = 5

exception NotImplementedYet of string

let niy s = raise (NotImplementedYet s)

module Array = struct
  include Array
  (* arrays handling with nice error message *)

  let get arr i =
    if i >= 0 && i < length arr then get arr i
    else (
      Format.eprintf "Runtime Error: Invalid index %i. Should be in [0; %i]\n" i
        (Array.length arr);
      exit 0)

  let set arr i v =
    if i >= 0 && i < length arr then (
      set arr i v;
      arr)
    else (
      Format.eprintf "Runtime Error: Invalid index %i. Should be in [0; %i]\n" i
        (Array.length arr);
      exit 0)
end

module StringMap = struct
  include Map.Make (String)

  (* TODO: remove me when bumping to > 5.1 *)
  let of_list l = List.fold_left (fun acc (k, e) -> add k e acc) empty l
  let keys m = List.map fst (bindings m)

  let print ?pp_sep pp_elem fmt smap =
    let print_pair fmt (s, v) = Format.fprintf fmt "%s: %a" s pp_elem v in
    Format.fprintf fmt "%a"
      (Format.pp_print_list ?pp_sep print_pair)
      (bindings smap)

  let find k m =
    match find_opt k m with
    | None ->
        failwith
          (Format.asprintf "key '%s' not found (available keys: [%a])" k
             (Format.pp_print_list Format.pp_print_string)
             (keys m))
    | Some v -> v
end

let pp_print_iter ?(pp_sep = Format.pp_print_cut) iter pp_v ppf v =
  let is_first = ref true in
  let pp_v v =
    if !is_first then is_first := false else pp_sep ppf ();
    pp_v ppf v
  in
  iter pp_v v

let pp_print_array ?(pp_sep = Format.pp_print_cut) pp_v ppf v =
  pp_print_iter ~pp_sep Array.iter pp_v ppf v
