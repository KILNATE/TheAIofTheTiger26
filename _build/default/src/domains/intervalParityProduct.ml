module P = struct
  module I1 = Interval
  module I2 = Parity

  let reduce (i1, p) =
     (* complete the function *)
     Format.asprintf "(%s) not implemented" __FUNCTION__ |> Utils.niy
end

module Absint = Productint.Make (P)
module Absstring = Conststring
module Absarray = Squasharray.Make (Absint)
