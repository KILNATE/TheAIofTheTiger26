module Make (Product : Domain.IntReduction) = struct
  open Product

  type t = I1.t * I2.t

  (* printer *)
  let print (fmt : Format.formatter) ((a, b) : t) : unit =
    Format.fprintf fmt "(%a,%a)" I1.print a I2.print b

  (* set-theoretic operations *)
  let join (a1, b1) (a2, b2) : t =
     (* complete the function *)
      Format.asprintf "(%s) not implemented" __FUNCTION__ |> Utils.niy

  let widen (a1, b1) (a2, b2) : t =
     (* complete the function *)
      Format.asprintf "(%s) not implemented" __FUNCTION__ |> Utils.niy

  let subset (a1, b1) (a2, b2) : bool =
     (* complete the function *)
      Format.asprintf "(%s) not implemented" __FUNCTION__ |> Utils.niy

  (* conversion to truth value *)
  let truth ((a, b) : t) : Domain.truth =
     (* complete the function *)
      Format.asprintf "(%s) not implemented" __FUNCTION__ |> Utils.niy

  (* booolean operation *)
  let logical_and (a1, b1) (a2, b2) : t =
     (* complete the function *)
      Format.asprintf "(%s) not implemented" __FUNCTION__ |> Utils.niy

  let logical_or (a1, b1) (a2, b2) : t =
     (* complete the function *)
      Format.asprintf "(%s) not implemented" __FUNCTION__ |> Utils.niy

  (* arith *)
  let add (a1, b1) (a2, b2) : t = (I1.add a1 a2, I2.add b1 b2)
  let sub (a1, b1) (a2, b2) : t = (I1.sub a1 a2, I2.sub b1 b2)
  let mul (a1, b1) (a2, b2) : t = (I1.mul a1 a2, I2.mul b1 b2)
  let div (a1, b1) (a2, b2) : t = (I1.div a1 a2, I2.div b1 b2)

  (* range (low, sup) abstracts integers between low and sup (inclusive) *)
  let range (a1, b1) (a2, b2) : t = (I1.range a1 a2, I2.range b1 b2)

  (* comparisons *)
  let eq (a1, b1) (a2, b2) : t = (I1.eq a1 a2, I2.eq b1 b2)
  let ne (a1, b1) (a2, b2) : t = (I1.ne a1 a2, I2.ne b1 b2)
  let gt (a1, b1) (a2, b2) : t = (I1.gt a1 a2, I2.gt b1 b2)
  let ge (a1, b1) (a2, b2) : t = (I1.ge a1 a2, I2.ge b1 b2)
  let lt (a1, b1) (a2, b2) : t = (I1.lt a1 a2, I2.lt b1 b2)
  let le (a1, b1) (a2, b2) : t = (I1.le a1 a2, I2.le b1 b2)

  (* filtering comparisons *)
  let filter_eq (a1, b1) (a2, b2) : t =
    (I1.filter_eq a1 a2, I2.filter_eq b1 b2) |> reduce

  let filter_ne (a1, b1) (a2, b2) : t =
    (I1.filter_ne a1 a2, I2.filter_ne b1 b2) |> reduce

  let filter_gt (a1, b1) (a2, b2) : t =
    (I1.filter_gt a1 a2, I2.filter_gt b1 b2) |> reduce

  let filter_ge (a1, b1) (a2, b2) : t =
    (I1.filter_ge a1 a2, I2.filter_ge b1 b2) |> reduce

  let filter_lt (a1, b1) (a2, b2) : t =
    (I1.filter_lt a1 a2, I2.filter_lt b1 b2) |> reduce

  let filter_le (a1, b1) (a2, b2) : t =
    (I1.filter_le a1 a2, I2.filter_le b1 b2) |> reduce

  (* main entry point *)
  let of_int (i : int) : t = (I1.of_int i, I2.of_int i)
end
