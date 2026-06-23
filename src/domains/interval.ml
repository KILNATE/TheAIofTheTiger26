type itv = int * int

let print_itv fmt (low, sup) =
  if low = sup then Format.fprintf fmt "%i" sup
  else Format.fprintf fmt "[%i;%i]" low sup

type t =
  | Range of itv
  | Minf of int  (** [Minf(up)] is the set of values [x | x <= up] *)
  | Inf of int  (** [Inf(low)] is the set of values [x | x >= low] *)
  | Top

let print fmt itv =
  match itv with
  | Top -> Format.fprintf fmt "]-oo;+oo["
  | Minf u -> Format.fprintf fmt "]-oo;%i]" u
  | Inf l -> Format.fprintf fmt "[%i;+oo[" l
  | Range itv -> print_itv fmt itv

(* join *)
(* Step 4 *)
let join a b =
  match (a, b) with
  | Top, _ | _, Top -> Top
  | Range (l1, h1), Range (l2, h2) -> Range (min l1 l2, max h1 h2)
  | Minf u1, Minf u2 -> Minf (max u1 u2)
  | Inf l1, Inf l2 -> Inf (min l1 l2)
  | Minf _, Inf _ | Inf _, Minf _ -> Top
  | Range (l, h), Minf u | Minf u, Range (l, h) -> Minf (max h u)
  | Range (l, h), Inf lo | Inf lo, Range (l, h) -> Inf (min l lo)

let widen old_v new_v =
  match (old_v, new_v) with
  | Top, _ | _, Top -> Top
  | Range (l1, h1), Range (l2, h2) ->
      let lo = if l2 < l1 then None else Some l1 in
      let hi = if h2 > h1 then None else Some h1 in
      (match (lo, hi) with
       | None, None -> Top
       | None, Some h -> Minf h
       | Some l, None -> Inf l
       | Some l, Some h -> Range (l, h))
  | _ -> Top

let subset a b =
  match (a, b) with
  | _, Top -> true
  | Range (l1, h1), Range (l2, h2) -> l2 <= l1 && h1 <= h2
  | Range (_, u), Minf u' | Minf u, Minf u' -> u <= u'
  | Range (l, _), Inf l' | Inf l, Inf l' -> l >= l'
  | _ -> false

(* arith*)

(** negation of an interval *)
let neg (i : t) : t =
  match i with
  | Top -> Top
  | Inf x -> Minf (-x)
  | Minf x -> Inf (-x)
  | Range (l, u) -> Range (-u, -l)

(* Step 4 *)
let add a b =
  match (a, b) with
  | Range (l1, h1), Range (l2, h2) -> Range (l1 + l2, h1 + h2)
  | Inf l1, Inf l2 -> Inf (l1 + l2)
  | Minf u1, Minf u2 -> Minf (u1 + u2)
  | Range (l, _), Inf lo | Inf lo, Range (l, _) -> Inf (l + lo)
  | Range (_, h), Minf u | Minf u, Range (_, h) -> Minf (h + u)
  | _ -> Top

let sub a b = add a (neg b)

let mul a b =
  match (a, b) with
  | Range (l1, h1), Range (l2, h2) ->
      let products = [l1*l2; l1*h2; h1*l2; h1*h2] in
      Range (List.fold_left min (List.hd products) (List.tl products),
             List.fold_left max (List.hd products) (List.tl products))
  | Range (0, 0), _ | _, Range (0, 0) -> Range (0, 0)
  | _ -> Top

let div a b =
  match (a, b) with
  | Range (l1, h1), Range (l2, h2) when l2 > 0 || h2 < 0 ->
      let candidates = [l1/l2; l1/h2; h1/l2; h1/h2] in
      Range (List.fold_left min (List.hd candidates) (List.tl candidates),
             List.fold_left max (List.hd candidates) (List.tl candidates))
  | _ -> Top

(* truth handling *)
let false_ = Range (0, 0)
let true_ = Range (1, 1)
let maybe_ = Range (0, 1)

let truth = function
  | Range (0, 0) -> Domain.False
  | Range (1, 1) -> Domain.True
  | _ -> Domain.Unknown

(* boolean logic *)
(* Tiger Boolean operators normalize their result to 0 or 1 *)
let logical_and a b =
  if subset a false_ || subset b false_ then false_ else maybe_

let logical_or a b =
  if subset a false_ && subset b false_ then false_ else maybe_

(* comparisons *)
(* Step 4 *)
let get_low = function Range (l, _) -> Some l | Inf l -> Some l | _ -> None
let get_high = function Range (_, h) -> Some h | Minf h -> Some h | _ -> None

let eq a b =
  match (a, b) with
  | Range (l1, h1), Range (l2, h2) ->
      if h1 < l2 || h2 < l1 then false_
      else if l1 = h1 && l2 = h2 && l1 = l2 then true_
      else maybe_
  | _ -> maybe_

let ne _ _ = maybe_

let lt a b =
  match (get_high a, get_low b) with
  | Some ha, Some lb when ha < lb -> true_
  | _ ->
    match (get_low a, get_high b) with
    | Some la, Some hb when la >= hb -> false_
    | _ -> maybe_

let le a b =
  match (get_high a, get_low b) with
  | Some ha, Some lb when ha <= lb -> true_
  | _ ->
    match (get_low a, get_high b) with
    | Some la, Some hb when la > hb -> false_
    | _ -> maybe_

let gt a b = lt b a
let ge a b = le b a

(* constructors *)
let of_int x = Range (x, x)
let range l h = join l h

(* Ensure the interval is non-empty.  If the interval is invalid
   (upper bound less than lower bound), raise Domain.Bot_found to signal
   inconsistency. *)
let validate = function
  | Range (l, h) when h < l -> raise Domain.Bot_found
  | itv -> itv

(* comparisons *)

(* Interval refinement functions for relational constraints.
   Given two intervals, these functions compute a refined interval for the first operand
   that satisfies the given comparison against the second operand.
   - Each function returns a possibly narrowed interval, or raises Domain.Bot_found if the result is empty.
   - Intervals should be validated to ensure they are non-empty after refinement.

   hint: try first to implement the easy case when comparing two
   ranges and default to returning i1 in the other cases as shown
   here:
*)
let filter_eq i1 i2 =
  match (i1, i2) with
  | Range (l1, h1), Range (l2, h2) ->
      Range (max l1 l2, min h1 h2) |> validate
  | _ -> i1

let filter_ne i1 _i2 = i1

let filter_gt i1 i2 =
  match get_low i2 with
  | Some l2 ->
      (match i1 with
       | Range (l, h) -> Range (max l (l2 + 1), h) |> validate
       | Minf u -> Range (l2 + 1, u) |> validate
       | Inf l -> Inf (max l (l2 + 1))
       | Top -> Inf (l2 + 1))
  | None -> i1

let filter_ge i1 i2 =
  match get_low i2 with
  | Some l2 ->
      (match i1 with
       | Range (l, h) -> Range (max l l2, h) |> validate
       | Minf u -> Range (l2, u) |> validate
       | Inf l -> Inf (max l l2)
       | Top -> Inf l2)
  | None -> i1

let filter_lt i1 i2 =
  match get_high i2 with
  | Some h2 ->
      (match i1 with
       | Range (l, h) -> Range (l, min h (h2 - 1)) |> validate
       | Inf l -> Range (l, h2 - 1) |> validate
       | Minf u -> Minf (min u (h2 - 1))
       | Top -> Minf (h2 - 1))
  | None -> i1

let filter_le i1 i2 =
  match get_high i2 with
  | Some h2 ->
      (match i1 with
       | Range (l, h) -> Range (l, min h h2) |> validate
       | Inf l -> Range (l, h2) |> validate
       | Minf u -> Minf (min u h2)
       | Top -> Minf h2)
  | None -> i1
