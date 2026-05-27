module Make (I : Domain.Absint) = struct
  module D = struct
    module Absint = I
    module Absstring = Conststring
    module Absarray = Squasharray.Make (I)
  end

  module Analyzer = Absinterpreter.Make (D)
  module Verifier = Safeaccess.Make (D)

  let run ?(show_ast = false) ?(show_annotast = false) ?(pdf = false)
      ?(report = false) file =
    let ast = Fileparser.parse file in
    if show_ast then Format.printf "%a@,%!" Ast.print_program ast;
    let annot_ast = Analyzer.analyze_program ~show_annotast ~pdf ast in
    Verifier.validate_program ~report annot_ast
end

(* const *)
module ConstAnalyzer = Make (Constint)

(* parity *)
module ParityAnalyzer = Make (Parity)

(* intervals *)
module IntervalAnalyzer = Make (Interval)

(* Product *)
module IntervalParityAnalyzer = Make (Productint.Make (IntervalParityProduct.P))
