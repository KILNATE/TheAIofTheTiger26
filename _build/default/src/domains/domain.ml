(*
  This module defines interfaces for abstract interpretation
  components used in static program analysis.

  - The `Absint` signature defines an abstract domain for integers,
  supporting arithmetic, comparisons, logical operations, filtering.

  - The `Absarray` signature abstracts arrays parameterized over any
  element type, using a dedicated `num` type for indexing and sizing.

  - The `Absstring` signature abstracts strings, providing operations
  for comparison, concatenation, and widening.  -

 The `D` signature ties together all components (`Absint`,
 `Absstring`, and `Absarray`) into a complete abstract domain. *)

(* static booleans : either we know statically the value (True or
   False), eitheir it is Unknown *)
type truth = True | False | Unknown

(* raised by filtering functions *)
exception Bot_found

(* abstraction for integers *)
module type Absint = sig
  type t

  (* printer *)
  val print : Format.formatter -> t -> unit

  (* set-theoretic operations *)
  val join : t -> t -> t
  val widen : t -> t -> t
  val subset : t -> t -> bool

  (* conversion to truth value *)
  val truth : t -> truth

  (* booolean operation *)
  val logical_and : t -> t -> t
  val logical_or : t -> t -> t

  (* arith *)
  val add : t -> t -> t
  val sub : t -> t -> t
  val mul : t -> t -> t
  val div : t -> t -> t

  (* range (low, sup) abstracts integers between low and sup (inclusive) *)
  val range : t -> t -> t

  (* comparisons *)
  val eq : t -> t -> t
  val ne : t -> t -> t
  val gt : t -> t -> t
  val ge : t -> t -> t
  val lt : t -> t -> t
  val le : t -> t -> t

  (* filtering comparisons *)
  val filter_eq : t -> t -> t
  val filter_ne : t -> t -> t
  val filter_gt : t -> t -> t
  val filter_ge : t -> t -> t
  val filter_lt : t -> t -> t
  val filter_le : t -> t -> t

  (* main entry points *)
  val of_int : int -> t
end

module type Absarray = sig
  type num (* abstraction of indexes/sizes*)

  (* arrays handling *)
  type 'a t

  (* printer *)
  val print :
    (Format.formatter -> 'a -> unit) -> Format.formatter -> 'a t -> unit

  (* set-theoritic operations *)
  val join : ('a -> 'a -> 'a) -> 'a t -> 'a t -> 'a t
  val widen : ('a -> 'a -> 'a) -> 'a t -> 'a t -> 'a t
  val subset : ('a -> 'a -> bool) -> 'a t -> 'a t -> bool

  (* array equality *)
  val eq : 'a t -> 'a t -> truth

  (* array logic *)
  val get : 'a t -> num -> 'a
  val set : ('a -> 'a -> 'a) -> 'a t -> num -> 'a -> 'a t
  val size : 'a t -> num

  (* constructor with size *)
  val make : num -> 'a -> 'a t
end

module type Absstring = sig
  (* string handling *)
  type t

  val eq : t -> t -> truth
  val of_string : string -> t
  val join : t -> t -> t
  val print : Format.formatter -> t -> unit
  val widen : t -> t -> t
  val subset : t -> t -> bool
  val concat : t -> t -> t
end

module type D = sig
  module Absint : Absint
  module Absstring : Absstring

  (* We add a type constraint `type num = Absint.t`.  This enforces
     consistency by requiring that the indexing type for arrays
     matches the abstract integer domain used in the analysis. *)
  module Absarray : Absarray with type num = Absint.t
end

module type IntReduction = sig
  module I1 : Absint
  module I2 : Absint

  val reduce : I1.t * I2.t -> I1.t * I2.t
end
