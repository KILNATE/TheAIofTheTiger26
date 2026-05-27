module Make (I : Domain.Absint) = struct
  type num = I.t

  (* Functional abstraction of arrays, we do not maintain the
     physical structure of a real array. All elements are
     collapsed into a single abstract value. Moreover, because the
     representation is purely functional (each update produces a new
     structure), even if we tracked precise element-wise information,
     we would still lose physical equality (i.e., object identity). *)
  type 'a t = { size : I.t; content : 'a }

  (* We cannot reliably determine equality between two arrays
     in general, and conservatively return Unknown. *)
  let eq _a1 _a2 = Domain.Unknown

  let print print_elm fmt a =
    Format.fprintf fmt "{%a * %a}" print_elm a.content I.print a.size

  (* getter/setter *)
  let get a (_i : num) : 'a = a.content
  let set join a (_i : num) v = { a with content = join a.content v }
  let size a = a.size

  (* construction *)
  let make (size : num) (content : 'a) : 'a t = { size; content }

  (* Computes the join (least upper bound) of two abstract arrays.
     - The size is joined using the abstract integer domain's join.
     - The content is joined using the provided element-wise join function.
     This operation merges the information from both arrays, producing an
     array that conservatively over-approximates both inputs. *)
  let join join_elm a b =
    { size = I.join a.size b.size; content = join_elm a.content b.content }

  (* widening is the same as join, given that is passed a widen function *)
  let widen = join

  (* Checks whether abstract array [a] is included in abstract array [b].
     - This holds if [a]'s content is a subset of [b]'s content (according
       to the provided element-wise subset function), and
     - [a]'s size is a subset of [b]'s size in the abstract integer domain.
  *)
  let subset subset_elm a b =
    subset_elm a.content b.content && I.subset a.size b.size
end
