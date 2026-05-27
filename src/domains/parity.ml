type t = Odd | Even | Top

let print fmt x =
  Format.pp_print_string fmt
    (match x with Odd -> "odd" | Even -> "even" | Top -> "T")

(* arith*)
let add a b =
  match (a, b) with
  | Even, Even | Odd, Odd -> Even
  | Even, Odd | Odd, Even -> Odd
  | _ -> Top

let mul a b =
  match (a, b) with Odd, Odd -> Odd | Even, _ | _, Even -> Even | _ -> Top

let sub = add
let div _ _ = Top
let true_ = Odd
let false_ = Even

(* comparisons *)
let eq _a _b = Top
let ne a b = match (a, b) with Odd, Even | Even, Odd -> true_ | _ -> Top
let gt _a _b = Top
let ge _a _b = Top
let lt _a _b = Top
let le _a _b = Top

(* comparisons filtering *)
let filter_eq a _b = a
let filter_ne a _b = a
let filter_gt a _b = a
let filter_ge a _b = a
let filter_lt a _b = a
let filter_le a _b = a

(* boolean logic *)
let logical_and _a _b = Top
let logical_or _a _b = Top

(* constructors *)
let of_int x = if x mod 2 = 0 then Even else Odd
let range _ _ = Top

(* join *)
let join a b =
  match (a, b) with Odd, Odd -> Odd | Even, Even -> Even | _ -> Top

(* widen *)
let widen a b =
  match (a, b) with Odd, Odd -> Odd | Even, Even -> Even | _ -> Top

let truth = function Odd -> Domain.True | _ -> Domain.Unknown

let subset a b =
  match (a, b) with
  | _, Top -> true
  | Odd, Odd -> true
  | Even, Even -> true
  | _ -> false
