type t = Known of int | Top

let print fmt itv =
  match itv with
  | Top -> Format.fprintf fmt "?"
  | Known i -> Format.fprintf fmt "%i" i

let lift f a b : t =
  match (a, b) with Known i1, Known i2 -> Known (f i1 i2) | _ -> Top

let add : t -> t -> t = lift ( + )
let sub : t -> t -> t = lift ( - )

let mul a b : t =
  match (a, b) with Known 0, _ | _, Known 0 -> Known 0 | _ -> lift ( * ) a b

let div a b : t = match b with Known 0 -> Top | _ -> lift ( / ) a b

(* truth handling *)
let false_ = Known 0
let true_ = Known 1
let maybe_ = Top

let truth = function
  | Known 0 -> Domain.False
  | Known 1 -> Domain.True
  | _ -> Domain.Unknown

(* comparisons *)
let eq = lift (fun a b -> if a = b then 1 else 0)
let ne = lift (fun a b -> if a <> b then 1 else 0)
let gt = lift (fun a b -> if a > b then 1 else 0)
let ge = lift (fun a b -> if a >= b then 1 else 0)
let lt i1 i2 = gt i2 i1
let le i1 i2 = ge i2 i1

(* comparisons *)
let filter_eq i1 i2 =
  match (i1, i2) with
  | Known c1, Known c2 -> if c1 = c2 then Known c2 else raise Exit
  | Top, Known c2 -> Known c2
  | _ -> i1

let filter_ne i1 _i2 = i1
let filter_gt i1 _i2 = i1
let filter_ge i1 _i2 = i1
let filter_lt i1 _i2 = i1
let filter_le i1 _i2 = i1

(* boolean logic *)
let logical_and a b =
  match (a, b) with
  | Known a, Known b -> Known (if a = 0 || b = 0 then 0 else 1)
  | Known 0, _ | _, Known 0 -> Known 0
  | _ -> maybe_

let logical_or a b =
  match (a, b) with
  | Known a, Known b -> Known (if a = 0 && b = 0 then 0 else 1)
  | (Known x, _ | _, Known x) when x <> 0 -> Known 1
  | _ -> maybe_

(* constructors *)
let of_int x = Known x

(* join *)
let join a b = if a = b then a else Top

let range (l : t) (h : t) : t =
  match (l, h) with Known l, Known h when l = h -> Known l | _ -> Top

let widen a b =
  match (a, b) with
  | Top, _ | _, Top -> Top
  | Known i1, Known i2 -> if i1 = i2 then a else Top

let subset a b =
  match (a, b) with
  | _, Top -> true
  | Known i1, Known i2 -> i1 = i2
  | _ -> false
