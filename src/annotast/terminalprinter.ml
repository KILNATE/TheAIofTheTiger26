open Annotast

let print_program_and_state state_print fmt cl =
  let rec print_chunks fmt cl =
    Format.fprintf fmt "@[<v>%a@]" (Format.pp_print_list print_chunk) cl
  and print_chunk fmt { c_payload; c_state; _ } =
    match c_payload with
    | ATypedec (id, typ) ->
        Format.fprintf fmt "@[<h>type %s = %a@]" id Ast.print_typ typ
    | AVardec (id, None, rvalue) ->
        Format.fprintf fmt "@[<h>var %s := %a\t%a@]" id print_expr rvalue
          state_print c_state
    | AVardec (id, Some ty, rvalue) ->
        Format.fprintf fmt "@[<h>var %s : %a := %a\t%a@]" id Ast.print_typ ty
          print_expr rvalue state_print c_state
    | AExp e -> Format.fprintf fmt "%a" print_expr e
  and print_lvalue fmt l =
    match l.l_payload with
    | AVar v -> Format.fprintf fmt "%s" v
    | AArray (lv, dim) ->
        Format.fprintf fmt "%a[%a]" print_lvalue lv print_expr dim
    | ARecordField _ -> assert false
  and print_expr fmt { e_payload; e_state; _ } =
    match e_payload with
    | AConst i -> Format.fprintf fmt "%i" i
    | ASeq l ->
        Format.fprintf fmt "@[<v 2>(@ %a@]@\n)"
          (Format.pp_print_list
             ~pp_sep:(fun fmt () -> Format.fprintf fmt " ;@,")
             print_expr)
          l
    | AString s -> Format.fprintf fmt "\"%s\"" (String.escaped s)
    | AAssign (left, right) ->
        Format.fprintf fmt "@[<h>%a := %a\t%a@]" print_lvalue left print_expr
          right state_print e_state
    | AFuncall (name, args) ->
        Format.fprintf fmt "@[<h>%s(%a)\t%a@]" name
          (Format.pp_print_list
             ~pp_sep:(fun fmt () -> Format.fprintf fmt ", ")
             print_expr)
          args state_print e_state
    | ABinop (e1, b, e2) ->
        Format.fprintf fmt "(%a %s %a)" print_expr e1 (Ast.binop_to_string b)
          print_expr e2
    | ABoolop (e1, b, e2) ->
        Format.fprintf fmt "(%a %s %a)" print_expr e1 (Ast.boolop_to_string b)
          print_expr e2
    | ARelop (e1, r, e2) ->
        Format.fprintf fmt "(%a %s %a)" print_expr e1 (Ast.relop_to_string r)
          print_expr e2
    | AIfThenElse (cond, tbr, Some fbr) ->
        Format.fprintf fmt
          "@[<v 2>if %a then@, %a\t%a@]@,@[<v 2>else@, %a\t%a@]" print_expr cond
          print_expr tbr state_print tbr.e_state print_expr fbr state_print
          fbr.e_state
    | AIfThenElse (cond, tbr, None) ->
        Format.fprintf fmt "@[<v 2>if %a then@, %a@]" print_expr cond print_expr
          tbr
    | AWhile (cond, ({ e_payload = ASeq _; _ } as body)) ->
        Format.fprintf fmt "@[<v 2>while %a do@ %a@]" print_expr cond print_expr
          body;
        Format.fprintf fmt "\t%a" state_print e_state
    | AWhile (cond, body) ->
        Format.fprintf fmt "@[<v 2>while %a do (@ %a@]@\n)" print_expr cond
          print_expr body;
        Format.fprintf fmt "\t%a" state_print e_state
    | ALval v -> Format.fprintf fmt "%a" print_lvalue v
    | ALet (chunks, body) ->
        Format.fprintf fmt "@[<v 2>let@ %a@]@\n" print_chunks chunks;
        Format.fprintf fmt "@[<v 2>in @ %a@]@\nend" print_expr body;
        Format.fprintf fmt "\t%a" state_print e_state
    | AArrayInit (id, size, content) ->
        Format.fprintf fmt "@[<h>%s[%a] of %a@]" id print_expr size print_expr
          content
  in
  let s = Format.asprintf "%a" print_chunks cl in
  let ll =
    String.split_on_char '\n' s
    |> List.map (String.split_on_char '\t')
    |> List.map (function
         | [] -> []
         | [ h ] -> [ h ]
         | h :: h' :: _ as l ->
             (* T®1cKs *)
             let l' = String.length h' in
             if h'.[l' - 1] = ';' then [ h ^ ";"; String.sub h' 0 (l' - 1) ]
             else l)
  in
  let needed_len =
    List.fold_left
      (fun acc -> function
        | [] | [ _ ] -> acc | s :: _ -> max acc (String.length s))
      0 ll
    + 2
  in
  let cyan = Printf.sprintf "\027[38;2;0;255;255m" in
  List.iter
    (function
      | [] -> Format.fprintf fmt "@\n"
      | [ ast ] -> Format.fprintf fmt "%s@\n" ast
      | ast :: l ->
          Format.fprintf fmt "%s" ast;
          let spacing = needed_len - String.length ast in
          Format.pp_print_string fmt (String.make spacing ' ');
          Format.fprintf fmt "\027[0m%s%s\027[0m@\n" cyan (List.hd (List.rev l)))
    ll
