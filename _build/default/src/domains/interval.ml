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
let join _ _ = Top
let widen _ _ = Top

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
let add _i1 _i2 = Top
let sub _i1 _i2 = Top
let mul _i1 _i2 = Top
let div _i1 _i2 = Top

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
let eq _ _ = maybe_
let ne _ _ = maybe_
let gt _ _ = maybe_
let ge _ _ = maybe_
let lt _ _ = maybe_
let le _ _ = maybe_

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
      let l = max l1 l2 in
      let h = min h1 h2 in
      Range (l, h) |> validate
  | _ -> i1

   let filter_ne i1 i2 = i1
   let filter_gt i1 i2 = i1
   let filter_ge i1 i2 = i1
   let filter_lt i1 i2 = i1
   let filter_le i1 i2 = i1
