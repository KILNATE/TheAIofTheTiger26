open Ast

(* Annotated expressions parameterized by abstract state ('a) and abstract value ('b).
   Each expression node carries:
   - its payload (the structure of the expression),
   - the abstract state *after* analyzing this node,
   - the abstract value computed for this node,
   - and its source location. *)
type ('a, 'b) expr = {
  e_payload : ('a, 'b) expr_payload;
  e_state : 'a;
  e_value : 'b;
  e_loc : location;
}

and ('a, 'b) expr_payload =
  | AConst of int
  | AString of string
  | ALval of ('a, 'b) lvalue
  | ASeq of ('a, 'b) expr list
  | AAssign of ('a, 'b) lvalue * ('a, 'b) expr
  | ABinop of (('a, 'b) expr * binop * ('a, 'b) expr)
  | ARelop of (('a, 'b) expr * relop * ('a, 'b) expr)
  | ABoolop of (('a, 'b) expr * boolop * ('a, 'b) expr)
  | AIfThenElse of (('a, 'b) expr * ('a, 'b) expr * ('a, 'b) expr option)
  | AWhile of (('a, 'b) expr * ('a, 'b) expr)
  | AFuncall of (string * ('a, 'b) expr list)
  | ALet of ('a, 'b) chunk list * ('a, 'b) expr
  | AArrayInit of string * ('a, 'b) expr * ('a, 'b) expr

and ('a, 'b) lvalue = {
  l_payload : ('a, 'b) lvalue_payload;
  l_state : 'a;
  l_value : 'b;
  l_loc : location;
}

and ('a, 'b) lvalue_payload =
  | AVar of string
  | AArray of ('a, 'b) lvalue * ('a, 'b) expr
  | ARecordField of ('a, 'b) lvalue * string

and ('a, 'b) chunk = {
  c_payload : ('a, 'b) chunk_payload;
  c_state : 'a;
  c_loc : location;
}

and ('a, 'b) chunk_payload =
  | ATypedec of string * typ
  | AVardec of string * typ option * ('a, 'b) expr
  | AExp of ('a, 'b) expr

type ('a, 'b) program = ('a, 'b) chunk list

let rec print_expr pp_state pp_value fmt (e : ('a, 'b) expr) =
  Format.fprintf fmt "@[<v 0>%a@]@,@[<v 0>%a@]" pp_state e.e_state pp_value
    e.e_value;
  match e.e_payload with
  | AConst i -> Format.fprintf fmt "%i" i
  | AString s -> Format.fprintf fmt "\"%s\"" (String.escaped s)
  | ASeq l ->
      Format.fprintf fmt "@[<v>(%a)@]"
        (Format.pp_print_list
           ~pp_sep:(fun fmt () -> Format.fprintf fmt ";@,")
           (print_expr pp_state pp_value))
        l
  | AAssign (left, right) ->
      Format.fprintf fmt "%a := %a"
        (print_lvalue pp_state pp_value)
        left
        (print_expr pp_state pp_value)
        right
  | ABinop (e1, b, e2) ->
      Format.fprintf fmt "%a %s %a"
        (print_expr pp_state pp_value)
        e1 (binop_to_string b)
        (print_expr pp_state pp_value)
        e2
  | ABoolop (e1, b, e2) ->
      Format.fprintf fmt "%a %s %a"
        (print_expr pp_state pp_value)
        e1 (boolop_to_string b)
        (print_expr pp_state pp_value)
        e2
  | ARelop (e1, r, e2) ->
      Format.fprintf fmt "%a %s %a"
        (print_expr pp_state pp_value)
        e1 (relop_to_string r)
        (print_expr pp_state pp_value)
        e2
  | AIfThenElse (cond, tbr, Some fbr) ->
      Format.fprintf fmt "@[<v 2>if %a then@, %a@]@,@[<v 2>else@, %a@]"
        (print_expr pp_state pp_value)
        cond
        (print_expr pp_state pp_value)
        tbr
        (print_expr pp_state pp_value)
        fbr
  | AIfThenElse (cond, tbr, None) ->
      Format.fprintf fmt "@[<v 2>if %a then@, %a@]"
        (print_expr pp_state pp_value)
        cond
        (print_expr pp_state pp_value)
        tbr
  | AWhile (cond, body) ->
      Format.fprintf fmt "@[<v 2>while %a do@,%a@]"
        (print_expr pp_state pp_value)
        cond
        (print_expr pp_state pp_value)
        body
  | ALval v -> Format.fprintf fmt "%a" (print_lvalue pp_state pp_value) v
  | AFuncall (name, args) ->
      Format.fprintf fmt "%s(%a)" name
        (Format.pp_print_list
           ~pp_sep:(fun fmt () -> Format.fprintf fmt ", ")
           (print_expr pp_state pp_value))
        args
  | ALet (chunks, body) ->
      Format.fprintf fmt "@[<v 2>let@,%a@]@,@[<v 2>in@,%a@]@,end"
        (print_chunks pp_state pp_value)
        chunks
        (print_expr pp_state pp_value)
        body
  | AArrayInit (id, size, content) ->
      Format.fprintf fmt "%s[%a] of %a" id
        (print_expr pp_state pp_value)
        size
        (print_expr pp_state pp_value)
        content

and print_lvalue pp_state pp_value fmt (lv : ('a, 'b) lvalue) =
  Format.fprintf fmt "@[<v 0> %a@]@,@[<v 0> %a@]@," pp_state lv.l_state pp_value
    lv.l_value;
  match lv.l_payload with
  | AVar v -> Format.fprintf fmt "%s" v
  | ARecordField (lv, f) ->
      Format.fprintf fmt "%a.%s" (print_lvalue pp_state pp_value) lv f
  | AArray (lv, dim) ->
      Format.fprintf fmt "%a[%a]"
        (print_lvalue pp_state pp_value)
        lv
        (print_expr pp_state pp_value)
        dim

and print_chunks pp_state pp_value fmt c =
  Format.fprintf fmt "@[<v>%a@]"
    (Format.pp_print_list (print_chunk pp_state pp_value))
    c

and print_chunk pp_state pp_value fmt (chunk : ('a, 'b) chunk) =
  Format.fprintf fmt "@[<v 0>%a@]" pp_state chunk.c_state;
  match chunk.c_payload with
  | ATypedec (id, typ) -> Format.fprintf fmt "type %s = %a" id print_typ typ
  | AVardec (id, None, rvalue) ->
      Format.fprintf fmt "var %s := %a" id (print_expr pp_state pp_value) rvalue
  | AVardec (id, Some ty, rvalue) ->
      Format.fprintf fmt "var %s : %a := %a" id print_typ ty
        (print_expr pp_state pp_value)
        rvalue
  | AExp e -> (print_expr pp_state pp_value) fmt e

(* We use build_expr, build_lval, and build_chunk so that every
   construction of an annotated AST node passes through a single
   place. That way, later we can easily add invariants, logging,
   debugging hooks ... without changing too much code. *)
let build_expr e_loc e_payload e_state e_value =
  { e_payload; e_state; e_value; e_loc }

let build_lval l_loc l_payload l_state l_value =
  { l_payload; l_state; l_value; l_loc }

let build_chunk c_loc c_payload c_state = { c_payload; c_state; c_loc }

(* Recursively annotate an expression by copying its structure and
   filling each node with default abstract state and abstract
   value. Used, for example, to annotate unreachable code. *)
let rec fill_expr (ast : Ast.expr) (state : 'a) value : ('a, 'b) expr =
  match ast.e_payload with
  | Ast.Const c -> build_expr ast.e_loc (AConst c) state value
  | Ast.String s -> build_expr ast.e_loc (AString s) state value
  | Ast.Lval lv ->
      build_expr ast.e_loc (ALval (fill_lvalue lv state value)) state value
  | Ast.Seq l ->
      build_expr ast.e_loc
        (ASeq (List.map (fun e -> fill_expr e state value) l))
        state value
  | Ast.Assign (lv, e) ->
      build_expr ast.e_loc
        (AAssign (fill_lvalue lv state value, fill_expr e state value))
        state value
  | Ast.Binop (e1, op, e2) ->
      build_expr ast.e_loc
        (ABinop (fill_expr e1 state value, op, fill_expr e2 state value))
        state value
  | Ast.Relop (e1, op, e2) ->
      build_expr ast.e_loc
        (ARelop (fill_expr e1 state value, op, fill_expr e2 state value))
        state value
  | Ast.Boolop (e1, op, e2) ->
      build_expr ast.e_loc
        (ABoolop (fill_expr e1 state value, op, fill_expr e2 state value))
        state value
  | Ast.IfThenElse (cond, tbr, fbr) ->
      build_expr ast.e_loc
        (AIfThenElse
           ( fill_expr cond state value,
             fill_expr tbr state value,
             Option.map (fun e -> fill_expr e state value) fbr ))
        state value
  | Ast.While (cond, body) ->
      build_expr ast.e_loc
        (AWhile (fill_expr cond state value, fill_expr body state value))
        state value
  | Ast.Funcall (name, args) ->
      build_expr ast.e_loc
        (AFuncall (name, List.map (fun e -> fill_expr e state value) args))
        state value
  | Ast.Let (chunks, body) ->
      build_expr ast.e_loc
        (ALet
           ( List.map (fun c -> fill_chunk c state value) chunks,
             fill_expr body state value ))
        state value
  | Ast.ArrayInit (name, size, content) ->
      build_expr ast.e_loc
        (AArrayInit
           (name, fill_expr size state value, fill_expr content state value))
        state value

and fill_lvalue (lv : Ast.lvalue) (state : 'a) value : ('a, 'b) lvalue =
  match lv.l_payload with
  | Ast.Var id -> build_lval lv.l_loc (AVar id) state value
  | Ast.Array (lv, idx) ->
      build_lval lv.l_loc
        (AArray (fill_lvalue lv state value, fill_expr idx state value))
        state value

and fill_chunk (chunk : Ast.chunk) (state : 'a) value : ('a, 'b) chunk =
  match chunk.c_payload with
  | Ast.Typedec (id, typ) -> build_chunk chunk.c_loc (ATypedec (id, typ)) state
  | Ast.Vardec (id, ty_opt, expr) ->
      build_chunk chunk.c_loc
        (AVardec (id, ty_opt, fill_expr expr state value))
        state
  | Ast.Exp expr ->
      build_chunk chunk.c_loc (AExp (fill_expr expr state value)) state
