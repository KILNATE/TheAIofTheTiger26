open Annotast

let escape s =
  let buf = Buffer.create (String.length s) in
  String.iter
    (function
      | '{' -> Buffer.add_string buf "\\{"
      | '}' -> Buffer.add_string buf "\\}"
      | '_' -> Buffer.add_string buf "\\_"
      | '%' -> Buffer.add_string buf "\\%"
      | '#' -> Buffer.add_string buf "\\#"
      | '$' -> Buffer.add_string buf "\\$"
      | '&' -> Buffer.add_string buf "\\&"
      | ' ' -> Buffer.add_string buf "\\ "
      | '[' -> Buffer.add_string buf "\\lbrack"
      | ']' -> Buffer.add_string buf "\\rbrack"
      | c -> Buffer.add_char buf c)
    s;
  Buffer.contents buf

let relop_to_latex (op : Ast.relop) =
  match op with
  | Ast.Eq -> "\\texttt{=}"
  | Ast.Ne -> "\\neq"
  | Ast.Lt -> "<"
  | Ast.Le -> "\\leq"
  | Ast.Gt -> ">"
  | Ast.Ge -> "\\geq"

let boolop_to_latex (op : Ast.boolop) =
  match op with Ast.And -> "\\land" | Ast.Or -> "\\lor"

let rec tikz_of_expr pp_state pp_res (e : ('a, 'b) Annotast.expr) : string =
  match e.e_payload with
  | ALet (chunks, body) ->
      Format.asprintf "[let, label=below:{$ %s $} [%s] [%s]]" (pp_res e.e_value)
        (tikz_of_chunks pp_state pp_res chunks)
        (tikz_of_expr pp_state pp_res body)
  | ASeq exprs ->
      Format.asprintf "[seq, label=below:{$ %s,%s $} %s]" (pp_state e.e_state)
        (pp_res e.e_value)
        (String.concat " " (List.map (tikz_of_expr pp_state pp_res) exprs))
  | AAssign ({ l_payload = AVar id; _ }, { e_payload = AConst c; _ }) ->
      Format.asprintf "[%s:=%i, label=below:{$ %s $}]" id c (pp_state e.e_state)
  | AAssign (lv, e2) ->
      Format.asprintf "[assign, label=below:{$ %s $} [%s] [%s]]"
        (pp_state e.e_state)
        (tikz_of_lvalue pp_state pp_res lv false)
        (tikz_of_expr pp_state pp_res e2)
  | ABinop (e1, op, e2) ->
      Format.asprintf "[%s, label=below:{$ %s $} %s %s]"
        (escape (Ast.binop_to_string op))
        (pp_res e.e_value)
        (tikz_of_expr pp_state pp_res e1)
        (tikz_of_expr pp_state pp_res e2)
  | ABoolop (e1, op, e2) ->
      Format.asprintf "[$%s$, label=below:{$ %s $} %s %s]"
        (escape (boolop_to_latex op))
        (pp_res e.e_value)
        (tikz_of_expr pp_state pp_res e1)
        (tikz_of_expr pp_state pp_res e2)
  | ARelop (e1, op, e2) ->
      Format.asprintf "[$%s$, label=below:{$ %s $}  %s %s]" (relop_to_latex op)
        (pp_res e.e_value)
        (tikz_of_expr pp_state pp_res e1)
        (tikz_of_expr pp_state pp_res e2)
  | AIfThenElse (c, t, None) ->
      Format.asprintf
        "[ifthen, label=below:{$ %s $} %s [then, label=below:{$ %s $} %s]]"
        (pp_state e.e_state)
        (tikz_of_expr pp_state pp_res c)
        (pp_state t.e_state)
        (tikz_of_expr pp_state pp_res t)
  | AIfThenElse (c, t, Some f) ->
      Format.asprintf
        "[ifthenelse, label=below:{$ %s $} %s [then, label=below:{$ %s $} %s] \
         [else, label=below:{$ %s $} %s] ]"
        (pp_state e.e_state)
        (tikz_of_expr pp_state pp_res c)
        (pp_state t.e_state)
        (tikz_of_expr pp_state pp_res t)
        (pp_state f.e_state)
        (tikz_of_expr pp_state pp_res f)
  | AWhile (c, b) ->
      Format.asprintf "[while, label=below:{$ %s $} %s %s]" (pp_state e.e_state)
        (tikz_of_expr pp_state pp_res c)
        (tikz_of_expr pp_state pp_res b)
  | AFuncall (name, args) ->
      Format.asprintf "[call(%s), label=below:{$ %s $} %s]" (escape name)
        (pp_res e.e_value)
        (String.concat " " (List.map (tikz_of_expr pp_state pp_res) args))
  | AArrayInit (id, sz, v) ->
      Format.sprintf "@[<v 2>[Array(%s), label=below:{$ %s $}@,%s@,%s@]@,]"
        (escape id) (pp_res e.e_value)
        (tikz_of_expr pp_state pp_res sz)
        (tikz_of_expr pp_state pp_res v)
  | ALval lv -> tikz_of_lvalue pp_state pp_res lv true
  | AConst i -> Format.asprintf "[%d]" i
  | AString _s ->
      Format.asprintf "[string, label=below:{$ %s $}]" (pp_res e.e_value)

and tikz_of_lvalue pp_state pp_res (lv : ('a, 'b) lvalue) read : string =
  match lv.l_payload with
  | AVar v ->
      Format.asprintf "[%s, label=below:{$%s$}]" v
        (if read then pp_res lv.l_value else "")
  | ARecordField (lv, f) ->
      Format.asprintf "[FieldAccess [%s] [%s]]"
        (tikz_of_lvalue pp_state pp_res lv read)
        f
  | AArray ({ l_payload = AVar id; _ }, { e_payload = AConst c; _ }) ->
      Format.asprintf "[%s$\\lbrack$%i$\\rbrack$,label=below:{$%s$}]" id c
        (if read then pp_res lv.l_value else "")
  | AArray (lv', e) ->
      Format.asprintf "[ArrayAccess, label=below:{$%s$} %s %s]"
        (if read then pp_res lv.l_value else "")
        (tikz_of_lvalue pp_state pp_res lv' read)
        (tikz_of_expr pp_state pp_res e)

and tikz_of_chunk pp_state pp_res (c : ('a, 'b) chunk) : string =
  match c.c_payload with
  | ATypedec (_v, _t) -> (* Format.asprintf "[Typedec %s]" (escape v) *) ""
  | AVardec (id, _t, { e_payload = AConst x; _ }) ->
      Format.asprintf "[%s :\\texttt{=} %i, label=below:{$%s$} ]" id x
        (pp_state c.c_state)
  | AVardec (v, _t, e) ->
      Format.asprintf "[Vardec %s, label=below:{$%s$} %s]" v
        (pp_state c.c_state)
        (tikz_of_expr pp_state pp_res e)
  | AExp e -> Format.asprintf "[%s]" (tikz_of_expr pp_state pp_res e)

and tikz_of_chunks pp_state pp_res (chunks : ('a, 'b) chunk list) : string =
  match chunks with
  | [ c ] -> String.concat " " (List.map (tikz_of_chunk pp_state pp_res) chunks)
  | _ ->
      "["
      ^ String.concat " " (List.map (tikz_of_chunk pp_state pp_res) chunks)
      ^ "]"

let tikz_of_program pp_state pp_res (chunks : ('a, 'b) chunk list) : string =
  Format.asprintf
    "\\scalebox{0.5}{\n\
     \\begin{forest}\n\
     for tree={\n\
    \  draw,\n\
    \  rounded corners,\n\
    \  node options={align=center},\n\
    \  s sep=40pt,\n\
    \  l sep=40pt\n\
     }\n\
     %s\n\
     \\end{forest}}"
    (tikz_of_chunks pp_state pp_res chunks)

let write_to_file ?(color_state = fun _ -> "red")
    ?(color_expr = fun _ -> "blue") filename pp_state pp_res chunks =
  let oc = open_out filename in
  Printf.fprintf oc "\\documentclass{article}\n";
  Printf.fprintf oc "\\usepackage[utf8]{inputenc}\n";
  Printf.fprintf oc "\\usepackage{xcolor}\n";
  Printf.fprintf oc "\\usepackage{forest}\n";
  Printf.fprintf oc "\\usepackage{geometry}\n";
  Printf.fprintf oc "\\geometry{margin=1in}\n";
  Printf.fprintf oc "\\usepackage{graphics}\n";
  Printf.fprintf oc "\\begin{document}\n\n";
  Printf.fprintf oc "\\begin{center}\n\n";
  Printf.fprintf oc "%s\n"
    (tikz_of_program
       (fun x ->
         Format.asprintf "\\textcolor{%s}{" (color_state x)
         ^ escape (pp_state x)
         ^ "}")
       (fun x ->
         Format.asprintf "\\textcolor{%s}{" (color_expr x)
         ^ escape (pp_res x)
         ^ "}")
       chunks);
  Printf.fprintf oc "\\end{center}\n\n";
  Printf.fprintf oc "\n\\end{document}\n";
  close_out oc;
  let return_status =
    Sys.command
      (Format.asprintf "pdflatex -halt-on-error %s > /dev/null 2>&1" filename)
  in
  if return_status = 0 then
    Format.printf "file %s filename generated\n"
      (Filename.basename (Filename.chop_extension filename) ^ ".pdf")
  else Format.printf "Error during pdf creation\n";
  Sys.command "rm -f *.aux *.log" |> ignore
