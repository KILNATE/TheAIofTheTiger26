open Annotast
open Domain

module Make (D : D) = struct
  module Absvalue = Absvalue.Make (D)

  let safe_divisor (itv : D.Absint.t) =
    let open D in
    Absint.ne (Absint.of_int 0) itv |> Absint.truth = True

  let safe_array_access (itv : D.Absint.t) (arr : 'a D.Absarray.t) =
    let open D in
    Absint.lt itv (Absarray.size arr) |> Absint.truth = True
    && Absint.ge itv (Absint.of_int 0) |> Absint.truth = True

  let safe = ref 0
  let unsafe = ref 0
  let out = ref false

  let rec validate_expr (e : ('a, 'b) Annotast.expr) : unit =
    match e.e_payload with
    | ALet (chunks, body) ->
        validate_chunks chunks;
        validate_expr body
    | ASeq exprs -> List.iter validate_expr exprs
    | AAssign (lv, e2) ->
        validate_lvalue lv;
        validate_expr e2
    | ABinop (e1, Div, e2) ->
        (* unreachable access are always safe *)
        if e.e_value = Absvalue.Unreachable then (
          incr safe;
          if !out then
            Format.printf "division in %a is safe\n" Ast.print_location e.e_loc)
        else
          let den = Absvalue.cast_int e2.e_loc e2.e_value in
          if safe_divisor den then (
            incr safe;
            if !out then
              Format.printf "division in %a is safe\n" Ast.print_location
                e.e_loc)
          else (
            incr unsafe;
            if !out then
              Format.printf "division in %a is unsafe\n" Ast.print_location
                e.e_loc);

          validate_expr e1;

          validate_expr e2
    | ABinop (e1, _op, e2) ->
        validate_expr e1;
        validate_expr e2
    | ABoolop (e1, _op, e2) ->
        validate_expr e1;
        validate_expr e2
    | ARelop (e1, _op, e2) ->
        validate_expr e1;
        validate_expr e2
    | AIfThenElse (c, t, None) ->
        validate_expr c;
        validate_expr t
    | AIfThenElse (c, t, Some f) ->
        validate_expr c;
        validate_expr t;
        validate_expr f
    | AWhile (c, b) ->
        validate_expr c;
        validate_expr b
    | AFuncall (_name, args) -> List.iter validate_expr args
    | AArrayInit (_id, sz, v) ->
        validate_expr sz;
        validate_expr v
    | ALval lv -> validate_lvalue lv
    | AConst _ | AString _ -> ()

  and validate_lvalue (lv : ('a, 'b) Annotast.lvalue) : unit =
    match lv.l_payload with
    | AVar _v -> ()
    | ARecordField (lv, _f) -> validate_lvalue lv
    | AArray (arr, r) ->
        validate_lvalue arr;
        validate_expr r;
        (* unreachable access are always safe *)
        if arr.l_value = Absvalue.Unreachable then (
          incr safe;
          if !out then
            Format.printf "access in %a is safe\n" Ast.print_location lv.l_loc)
        else
          let arr = Absvalue.cast_array arr.l_loc arr.l_value in
          let e = Absvalue.cast_int r.e_loc r.e_value in
          if safe_array_access e arr then (
            incr safe;
            if !out then
              Format.printf "access in %a is safe\n" Ast.print_location lv.l_loc)
          else (
            incr unsafe;
            if !out then
              Format.printf "access in %a is unsafe\n" Ast.print_location
                lv.l_loc)

  and validate_chunk (c : ('a, 'b) chunk) : unit =
    match c.c_payload with
    | ATypedec (_v, _t) -> ()
    | AVardec (_v, _t, e) -> validate_expr e
    | AExp e -> validate_expr e

  and validate_chunks (chunks : ('a, 'b) chunk list) : unit =
    List.iter validate_chunk chunks

  let validate_program ?(report = false) (chunks : ('a, 'b) chunk list) =
    safe := 0;
    unsafe := 0;
    out := report;
    validate_chunks chunks;
    (!safe, !unsafe)
end
