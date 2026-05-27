
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | WHILE
    | VAR
    | TYPID of (
# 36 "src/ast/parser.mly"
       (string)
# 17 "src/ast/parser.ml"
  )
    | TYPE
    | THEN
    | SUB
    | STRING of (
# 37 "src/ast/parser.mly"
       (string)
# 25 "src/ast/parser.ml"
  )
    | SEMI
    | RP
    | RB
    | OR
    | OF
    | NE
    | MUL
    | LT
    | LP
    | LET
    | LE
    | LB
    | IN
    | IF
    | ID of (
# 35 "src/ast/parser.mly"
       (string)
# 44 "src/ast/parser.ml"
  )
    | GT
    | GE
    | EQ
    | EOF
    | END
    | ELSE
    | DO
    | DIV
    | CONST of (
# 71 "src/ast/parser.mly"
       (int)
# 57 "src/ast/parser.ml"
  )
    | COMMA
    | COLON
    | ASSIGN
    | ARRAY
    | AND
    | ADD
  
end

include MenhirBasics

# 28 "src/ast/parser.mly"
  

open Ast


# 76 "src/ast/parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState00 : ('s, _menhir_box_program) _menhir_state
    (** State 00.
        Stack shape : .
        Start symbol: program. *)

  | MenhirState01 : (('s, _menhir_box_program) _menhir_cell1_WHILE, _menhir_box_program) _menhir_state
    (** State 01.
        Stack shape : WHILE.
        Start symbol: program. *)

  | MenhirState03 : (('s, _menhir_box_program) _menhir_cell1_TYPID, _menhir_box_program) _menhir_state
    (** State 03.
        Stack shape : TYPID.
        Start symbol: program. *)

  | MenhirState04 : (('s, _menhir_box_program) _menhir_cell1_SUB, _menhir_box_program) _menhir_state
    (** State 04.
        Stack shape : SUB.
        Start symbol: program. *)

  | MenhirState06 : (('s, _menhir_box_program) _menhir_cell1_LP, _menhir_box_program) _menhir_state
    (** State 06.
        Stack shape : LP.
        Start symbol: program. *)

  | MenhirState07 : (('s, _menhir_box_program) _menhir_cell1_LET, _menhir_box_program) _menhir_state
    (** State 07.
        Stack shape : LET.
        Start symbol: program. *)

  | MenhirState10 : (('s, _menhir_box_program) _menhir_cell1_VAR _menhir_cell0_ID, _menhir_box_program) _menhir_state
    (** State 10.
        Stack shape : VAR ID.
        Start symbol: program. *)

  | MenhirState16 : ((('s, _menhir_box_program) _menhir_cell1_VAR _menhir_cell0_ID, _menhir_box_program) _menhir_cell1_typ, _menhir_box_program) _menhir_state
    (** State 16.
        Stack shape : VAR ID typ.
        Start symbol: program. *)

  | MenhirState17 : (('s, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_state
    (** State 17.
        Stack shape : IF.
        Start symbol: program. *)

  | MenhirState19 : (('s, _menhir_box_program) _menhir_cell1_ID _menhir_cell0_LP, _menhir_box_program) _menhir_state
    (** State 19.
        Stack shape : ID LP.
        Start symbol: program. *)

  | MenhirState23 : (('s, _menhir_box_program) _menhir_cell1_raw_lvalue, _menhir_box_program) _menhir_state
    (** State 23.
        Stack shape : raw_lvalue.
        Start symbol: program. *)

  | MenhirState25 : (('s, _menhir_box_program) _menhir_cell1_raw_exp _menhir_cell0_SUB, _menhir_box_program) _menhir_state
    (** State 25.
        Stack shape : raw_exp SUB.
        Start symbol: program. *)

  | MenhirState27 : (('s, _menhir_box_program) _menhir_cell1_raw_exp, _menhir_box_program) _menhir_state
    (** State 27.
        Stack shape : raw_exp.
        Start symbol: program. *)

  | MenhirState29 : (('s, _menhir_box_program) _menhir_cell1_raw_exp, _menhir_box_program) _menhir_state
    (** State 29.
        Stack shape : raw_exp.
        Start symbol: program. *)

  | MenhirState32 : (('s, _menhir_box_program) _menhir_cell1_raw_exp, _menhir_box_program) _menhir_state
    (** State 32.
        Stack shape : raw_exp.
        Start symbol: program. *)

  | MenhirState34 : (('s, _menhir_box_program) _menhir_cell1_raw_exp, _menhir_box_program) _menhir_state
    (** State 34.
        Stack shape : raw_exp.
        Start symbol: program. *)

  | MenhirState36 : (('s, _menhir_box_program) _menhir_cell1_raw_exp, _menhir_box_program) _menhir_state
    (** State 36.
        Stack shape : raw_exp.
        Start symbol: program. *)

  | MenhirState38 : (('s, _menhir_box_program) _menhir_cell1_raw_exp, _menhir_box_program) _menhir_state
    (** State 38.
        Stack shape : raw_exp.
        Start symbol: program. *)

  | MenhirState40 : (('s, _menhir_box_program) _menhir_cell1_raw_exp, _menhir_box_program) _menhir_state
    (** State 40.
        Stack shape : raw_exp.
        Start symbol: program. *)

  | MenhirState42 : (('s, _menhir_box_program) _menhir_cell1_raw_exp, _menhir_box_program) _menhir_state
    (** State 42.
        Stack shape : raw_exp.
        Start symbol: program. *)

  | MenhirState44 : (('s, _menhir_box_program) _menhir_cell1_raw_exp, _menhir_box_program) _menhir_state
    (** State 44.
        Stack shape : raw_exp.
        Start symbol: program. *)

  | MenhirState46 : (('s, _menhir_box_program) _menhir_cell1_raw_exp, _menhir_box_program) _menhir_state
    (** State 46.
        Stack shape : raw_exp.
        Start symbol: program. *)

  | MenhirState48 : (('s, _menhir_box_program) _menhir_cell1_raw_exp, _menhir_box_program) _menhir_state
    (** State 48.
        Stack shape : raw_exp.
        Start symbol: program. *)

  | MenhirState50 : (('s, _menhir_box_program) _menhir_cell1_raw_lvalue, _menhir_box_program) _menhir_state
    (** State 50.
        Stack shape : raw_lvalue.
        Start symbol: program. *)

  | MenhirState53 : (('s, _menhir_box_program) _menhir_cell1_raw_exp, _menhir_box_program) _menhir_state
    (** State 53.
        Stack shape : raw_exp.
        Start symbol: program. *)

  | MenhirState58 : ((('s, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_raw_exp, _menhir_box_program) _menhir_state
    (** State 58.
        Stack shape : IF raw_exp.
        Start symbol: program. *)

  | MenhirState60 : (((('s, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_raw_exp, _menhir_box_program) _menhir_cell1_raw_exp, _menhir_box_program) _menhir_state
    (** State 60.
        Stack shape : IF raw_exp raw_exp.
        Start symbol: program. *)

  | MenhirState63 : (('s, _menhir_box_program) _menhir_cell1_VAR _menhir_cell0_ID, _menhir_box_program) _menhir_state
    (** State 63.
        Stack shape : VAR ID.
        Start symbol: program. *)

  | MenhirState67 : (('s, _menhir_box_program) _menhir_cell1_TYPE _menhir_cell0_ID, _menhir_box_program) _menhir_state
    (** State 67.
        Stack shape : TYPE ID.
        Start symbol: program. *)

  | MenhirState69 : (('s, _menhir_box_program) _menhir_cell1_raw_chunk, _menhir_box_program) _menhir_state
    (** State 69.
        Stack shape : raw_chunk.
        Start symbol: program. *)

  | MenhirState73 : ((('s, _menhir_box_program) _menhir_cell1_LET, _menhir_box_program) _menhir_cell1_chunks, _menhir_box_program) _menhir_state
    (** State 73.
        Stack shape : LET chunks.
        Start symbol: program. *)

  | MenhirState76 : (('s, _menhir_box_program) _menhir_cell1_raw_exp, _menhir_box_program) _menhir_state
    (** State 76.
        Stack shape : raw_exp.
        Start symbol: program. *)

  | MenhirState85 : ((('s, _menhir_box_program) _menhir_cell1_TYPID, _menhir_box_program) _menhir_cell1_raw_exp _menhir_cell0_RB, _menhir_box_program) _menhir_state
    (** State 85.
        Stack shape : TYPID raw_exp RB.
        Start symbol: program. *)

  | MenhirState88 : ((('s, _menhir_box_program) _menhir_cell1_WHILE, _menhir_box_program) _menhir_cell1_raw_exp, _menhir_box_program) _menhir_state
    (** State 88.
        Stack shape : WHILE raw_exp.
        Start symbol: program. *)


and ('s, 'r) _menhir_cell1_chunks = 
  | MenhirCell1_chunks of 's * ('s, 'r) _menhir_state * (Ast.program)

and ('s, 'r) _menhir_cell1_raw_chunk = 
  | MenhirCell1_raw_chunk of 's * ('s, 'r) _menhir_state * (Ast.chunk_payload) * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_raw_exp = 
  | MenhirCell1_raw_exp of 's * ('s, 'r) _menhir_state * (Ast.expr_payload) * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_raw_lvalue = 
  | MenhirCell1_raw_lvalue of 's * ('s, 'r) _menhir_state * (Ast.lvalue_payload) * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_typ = 
  | MenhirCell1_typ of 's * ('s, 'r) _menhir_state * (Ast.typ) * Lexing.position

and ('s, 'r) _menhir_cell1_ID = 
  | MenhirCell1_ID of 's * ('s, 'r) _menhir_state * (
# 35 "src/ast/parser.mly"
       (string)
# 269 "src/ast/parser.ml"
) * Lexing.position * Lexing.position

and 's _menhir_cell0_ID = 
  | MenhirCell0_ID of 's * (
# 35 "src/ast/parser.mly"
       (string)
# 276 "src/ast/parser.ml"
) * Lexing.position * Lexing.position

and ('s, 'r) _menhir_cell1_IF = 
  | MenhirCell1_IF of 's * ('s, 'r) _menhir_state * Lexing.position

and ('s, 'r) _menhir_cell1_LET = 
  | MenhirCell1_LET of 's * ('s, 'r) _menhir_state * Lexing.position

and ('s, 'r) _menhir_cell1_LP = 
  | MenhirCell1_LP of 's * ('s, 'r) _menhir_state * Lexing.position

and 's _menhir_cell0_LP = 
  | MenhirCell0_LP of 's * Lexing.position

and 's _menhir_cell0_RB = 
  | MenhirCell0_RB of 's * Lexing.position

and ('s, 'r) _menhir_cell1_SUB = 
  | MenhirCell1_SUB of 's * ('s, 'r) _menhir_state * Lexing.position

and 's _menhir_cell0_SUB = 
  | MenhirCell0_SUB of 's * Lexing.position

and ('s, 'r) _menhir_cell1_TYPE = 
  | MenhirCell1_TYPE of 's * ('s, 'r) _menhir_state * Lexing.position

and ('s, 'r) _menhir_cell1_TYPID = 
  | MenhirCell1_TYPID of 's * ('s, 'r) _menhir_state * (
# 36 "src/ast/parser.mly"
       (string)
# 307 "src/ast/parser.ml"
) * Lexing.position

and ('s, 'r) _menhir_cell1_VAR = 
  | MenhirCell1_VAR of 's * ('s, 'r) _menhir_state * Lexing.position

and ('s, 'r) _menhir_cell1_WHILE = 
  | MenhirCell1_WHILE of 's * ('s, 'r) _menhir_state * Lexing.position

and _menhir_box_program = 
  | MenhirBox_program of (Ast.program) [@@unboxed]

let _menhir_action_01 =
  fun l ->
    (
# 168 "src/ast/parser.mly"
                  ( l )
# 324 "src/ast/parser.ml"
     : (Ast.program))

let _menhir_action_02 =
  fun () ->
    (
# 216 "<standard.mly>"
    ( [] )
# 332 "src/ast/parser.ml"
     : (Ast.program))

let _menhir_action_03 =
  fun _endpos_x_ _startpos_x_ x xs ->
    let x =
      let c =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 107 "src/ast/parser.mly"
    ( build_chunk (_startpos,_endpos) x )
# 344 "src/ast/parser.ml"
        
      in
      
# 171 "src/ast/parser.mly"
                           ( c )
# 350 "src/ast/parser.ml"
      
    in
    (
# 219 "<standard.mly>"
    ( x :: xs )
# 356 "src/ast/parser.ml"
     : (Ast.program))

let _menhir_action_04 =
  fun () ->
    (
# 145 "<standard.mly>"
    ( [] )
# 364 "src/ast/parser.ml"
     : (Ast.expr list))

let _menhir_action_05 =
  fun x ->
    (
# 148 "<standard.mly>"
    ( x )
# 372 "src/ast/parser.ml"
     : (Ast.expr list))

let _menhir_action_06 =
  fun () ->
    (
# 145 "<standard.mly>"
    ( [] )
# 380 "src/ast/parser.ml"
     : (Ast.expr list))

let _menhir_action_07 =
  fun x ->
    (
# 148 "<standard.mly>"
    ( x )
# 388 "src/ast/parser.ml"
     : (Ast.expr list))

let _menhir_action_08 =
  fun c ->
    (
# 100 "src/ast/parser.mly"
                 ( c )
# 396 "src/ast/parser.ml"
     : (Ast.program))

let _menhir_action_09 =
  fun _endpos__2_ _endpos_x_ _startpos_x_ x ->
    let e =
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 408 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 414 "src/ast/parser.ml"
      
    in
    let _startpos_e_ = _startpos_x_ in
    let _endpos = _endpos__2_ in
    let _startpos = _startpos_e_ in
    (
# 101 "src/ast/parser.mly"
              ([build_chunk (_startpos,_endpos) (Exp(e))])
# 423 "src/ast/parser.ml"
     : (Ast.program))

let _menhir_action_10 =
  fun id ty ->
    (
# 174 "src/ast/parser.mly"
                                      ( Typedec(id,ty))
# 431 "src/ast/parser.ml"
     : (Ast.chunk_payload))

let _menhir_action_11 =
  fun _endpos_x_ _startpos_x_ id x ->
    let e =
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 443 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 449 "src/ast/parser.ml"
      
    in
    (
# 175 "src/ast/parser.mly"
                                      ( Vardec(id,None,e))
# 455 "src/ast/parser.ml"
     : (Ast.chunk_payload))

let _menhir_action_12 =
  fun _endpos_x_ _startpos_x_ id ty x ->
    let e =
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 467 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 473 "src/ast/parser.ml"
      
    in
    (
# 176 "src/ast/parser.mly"
                                      ( Vardec(id, Some ty, e))
# 479 "src/ast/parser.ml"
     : (Ast.chunk_payload))

let _menhir_action_13 =
  fun c ->
    (
# 117 "src/ast/parser.mly"
                                                    ( Const c )
# 487 "src/ast/parser.ml"
     : (Ast.expr_payload))

let _menhir_action_14 =
  fun s ->
    (
# 118 "src/ast/parser.mly"
                                                    ( String s )
# 495 "src/ast/parser.ml"
     : (Ast.expr_payload))

let _menhir_action_15 =
  fun _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ t x x_inlined1 ->
    let fill =
      let (_endpos_x_, _startpos_x_, x) = (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) in
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 508 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 514 "src/ast/parser.ml"
      
    in
    let size =
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 524 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 530 "src/ast/parser.ml"
      
    in
    (
# 120 "src/ast/parser.mly"
                                                    ( ArrayInit(t,size,fill))
# 536 "src/ast/parser.ml"
     : (Ast.expr_payload))

let _menhir_action_16 =
  fun _endpos_x_ _startpos_x_ x ->
    let lv =
      let l =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 110 "src/ast/parser.mly"
    ( build_lval (_startpos,_endpos) x )
# 548 "src/ast/parser.ml"
        
      in
      
# 143 "src/ast/parser.mly"
                           ( l )
# 554 "src/ast/parser.ml"
      
    in
    (
# 122 "src/ast/parser.mly"
                                                    ( Lval lv )
# 560 "src/ast/parser.ml"
     : (Ast.expr_payload))

let _menhir_action_17 =
  fun f xs ->
    let args = 
# 241 "<standard.mly>"
    ( xs )
# 568 "src/ast/parser.ml"
     in
    (
# 124 "src/ast/parser.mly"
                                                    ( Funcall(f,args))
# 573 "src/ast/parser.ml"
     : (Ast.expr_payload))

let _menhir_action_18 =
  fun _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 ->
    let right =
      let (_endpos_x_, _startpos_x_, x) = (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) in
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 586 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 592 "src/ast/parser.ml"
      
    in
    let b = 
# 156 "src/ast/parser.mly"
        (And)
# 598 "src/ast/parser.ml"
     in
    let left =
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 607 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 613 "src/ast/parser.ml"
      
    in
    (
# 126 "src/ast/parser.mly"
                                                    ( Boolop (left, b, right))
# 619 "src/ast/parser.ml"
     : (Ast.expr_payload))

let _menhir_action_19 =
  fun _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 ->
    let right =
      let (_endpos_x_, _startpos_x_, x) = (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) in
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 632 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 638 "src/ast/parser.ml"
      
    in
    let b = 
# 157 "src/ast/parser.mly"
        (Or)
# 644 "src/ast/parser.ml"
     in
    let left =
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 653 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 659 "src/ast/parser.ml"
      
    in
    (
# 126 "src/ast/parser.mly"
                                                    ( Boolop (left, b, right))
# 665 "src/ast/parser.ml"
     : (Ast.expr_payload))

let _menhir_action_20 =
  fun _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 ->
    let right =
      let (_endpos_x_, _startpos_x_, x) = (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) in
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 678 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 684 "src/ast/parser.ml"
      
    in
    let b = 
# 150 "src/ast/parser.mly"
        (Add)
# 690 "src/ast/parser.ml"
     in
    let left =
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 699 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 705 "src/ast/parser.ml"
      
    in
    (
# 127 "src/ast/parser.mly"
                                                    ( Binop (left, b, right))
# 711 "src/ast/parser.ml"
     : (Ast.expr_payload))

let _menhir_action_21 =
  fun _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 ->
    let right =
      let (_endpos_x_, _startpos_x_, x) = (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) in
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 724 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 730 "src/ast/parser.ml"
      
    in
    let b = 
# 151 "src/ast/parser.mly"
        (Mul)
# 736 "src/ast/parser.ml"
     in
    let left =
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 745 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 751 "src/ast/parser.ml"
      
    in
    (
# 127 "src/ast/parser.mly"
                                                    ( Binop (left, b, right))
# 757 "src/ast/parser.ml"
     : (Ast.expr_payload))

let _menhir_action_22 =
  fun _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 ->
    let right =
      let (_endpos_x_, _startpos_x_, x) = (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) in
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 770 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 776 "src/ast/parser.ml"
      
    in
    let b = 
# 152 "src/ast/parser.mly"
        (Sub)
# 782 "src/ast/parser.ml"
     in
    let left =
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 791 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 797 "src/ast/parser.ml"
      
    in
    (
# 127 "src/ast/parser.mly"
                                                    ( Binop (left, b, right))
# 803 "src/ast/parser.ml"
     : (Ast.expr_payload))

let _menhir_action_23 =
  fun _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 ->
    let right =
      let (_endpos_x_, _startpos_x_, x) = (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) in
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 816 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 822 "src/ast/parser.ml"
      
    in
    let b = 
# 153 "src/ast/parser.mly"
        (Div)
# 828 "src/ast/parser.ml"
     in
    let left =
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 837 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 843 "src/ast/parser.ml"
      
    in
    (
# 127 "src/ast/parser.mly"
                                                    ( Binop (left, b, right))
# 849 "src/ast/parser.ml"
     : (Ast.expr_payload))

let _menhir_action_24 =
  fun _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 ->
    let right =
      let (_endpos_x_, _startpos_x_, x) = (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) in
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 862 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 868 "src/ast/parser.ml"
      
    in
    let b = 
# 160 "src/ast/parser.mly"
        (Lt)
# 874 "src/ast/parser.ml"
     in
    let left =
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 883 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 889 "src/ast/parser.ml"
      
    in
    (
# 128 "src/ast/parser.mly"
                                                    ( Relop (left, b, right))
# 895 "src/ast/parser.ml"
     : (Ast.expr_payload))

let _menhir_action_25 =
  fun _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 ->
    let right =
      let (_endpos_x_, _startpos_x_, x) = (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) in
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 908 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 914 "src/ast/parser.ml"
      
    in
    let b = 
# 161 "src/ast/parser.mly"
         (Le)
# 920 "src/ast/parser.ml"
     in
    let left =
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 929 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 935 "src/ast/parser.ml"
      
    in
    (
# 128 "src/ast/parser.mly"
                                                    ( Relop (left, b, right))
# 941 "src/ast/parser.ml"
     : (Ast.expr_payload))

let _menhir_action_26 =
  fun _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 ->
    let right =
      let (_endpos_x_, _startpos_x_, x) = (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) in
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 954 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 960 "src/ast/parser.ml"
      
    in
    let b = 
# 162 "src/ast/parser.mly"
        (Gt)
# 966 "src/ast/parser.ml"
     in
    let left =
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 975 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 981 "src/ast/parser.ml"
      
    in
    (
# 128 "src/ast/parser.mly"
                                                    ( Relop (left, b, right))
# 987 "src/ast/parser.ml"
     : (Ast.expr_payload))

let _menhir_action_27 =
  fun _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 ->
    let right =
      let (_endpos_x_, _startpos_x_, x) = (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) in
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 1000 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 1006 "src/ast/parser.ml"
      
    in
    let b = 
# 163 "src/ast/parser.mly"
         (Ge)
# 1012 "src/ast/parser.ml"
     in
    let left =
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 1021 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 1027 "src/ast/parser.ml"
      
    in
    (
# 128 "src/ast/parser.mly"
                                                    ( Relop (left, b, right))
# 1033 "src/ast/parser.ml"
     : (Ast.expr_payload))

let _menhir_action_28 =
  fun _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 ->
    let right =
      let (_endpos_x_, _startpos_x_, x) = (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) in
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 1046 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 1052 "src/ast/parser.ml"
      
    in
    let b = 
# 164 "src/ast/parser.mly"
        (Eq)
# 1058 "src/ast/parser.ml"
     in
    let left =
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 1067 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 1073 "src/ast/parser.ml"
      
    in
    (
# 128 "src/ast/parser.mly"
                                                    ( Relop (left, b, right))
# 1079 "src/ast/parser.ml"
     : (Ast.expr_payload))

let _menhir_action_29 =
  fun _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 ->
    let right =
      let (_endpos_x_, _startpos_x_, x) = (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) in
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 1092 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 1098 "src/ast/parser.ml"
      
    in
    let b = 
# 165 "src/ast/parser.mly"
         (Ne)
# 1104 "src/ast/parser.ml"
     in
    let left =
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 1113 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 1119 "src/ast/parser.ml"
      
    in
    (
# 128 "src/ast/parser.mly"
                                                    ( Relop (left, b, right))
# 1125 "src/ast/parser.ml"
     : (Ast.expr_payload))

let _menhir_action_30 =
  fun _endpos_x_ _startpos__1_ _startpos_x_ x ->
    let e =
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 1137 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 1143 "src/ast/parser.ml"
      
    in
    let _endpos_e_ = _endpos_x_ in
    let _endpos = _endpos_e_ in
    let _startpos = _startpos__1_ in
    (
# 129 "src/ast/parser.mly"
                                                    ( Binop (build_expr (_startpos,_endpos) (Const 0), Sub, e))
# 1152 "src/ast/parser.ml"
     : (Ast.expr_payload))

let _menhir_action_31 =
  fun _endpos_xs_ _startpos_xs_ xs ->
    let e =
      let l = 
# 241 "<standard.mly>"
    ( xs )
# 1161 "src/ast/parser.ml"
       in
      let (_endpos_l_, _startpos_l_) = (_endpos_xs_, _startpos_xs_) in
      let _endpos = _endpos_l_ in
      let _startpos = _startpos_l_ in
      
# 140 "src/ast/parser.mly"
                               ( match l with [one] -> build_expr (_startpos,_endpos) one.e_payload | l -> build_expr (_startpos,_endpos) (Seq l) )
# 1169 "src/ast/parser.ml"
      
    in
    (
# 130 "src/ast/parser.mly"
                                                    ( e.e_payload )
# 1175 "src/ast/parser.ml"
     : (Ast.expr_payload))

let _menhir_action_32 =
  fun _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 ->
    let e =
      let (_endpos_x_, _startpos_x_, x) = (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) in
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 1188 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 1194 "src/ast/parser.ml"
      
    in
    let l =
      let l =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 110 "src/ast/parser.mly"
    ( build_lval (_startpos,_endpos) x )
# 1204 "src/ast/parser.ml"
        
      in
      
# 143 "src/ast/parser.mly"
                           ( l )
# 1210 "src/ast/parser.ml"
      
    in
    (
# 132 "src/ast/parser.mly"
                                                    ( Assign(l,e); )
# 1216 "src/ast/parser.ml"
     : (Ast.expr_payload))

let _menhir_action_33 =
  fun _endpos_x_ _endpos_x_inlined1_ _endpos_x_inlined2_ _startpos_x_ _startpos_x_inlined1_ _startpos_x_inlined2_ x x_inlined1 x_inlined2 ->
    let fbr =
      let (_endpos_x_, _startpos_x_, x) = (_endpos_x_inlined2_, _startpos_x_inlined2_, x_inlined2) in
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 1229 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 1235 "src/ast/parser.ml"
      
    in
    let tbr =
      let (_endpos_x_, _startpos_x_, x) = (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) in
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 1246 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 1252 "src/ast/parser.ml"
      
    in
    let c =
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 1262 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 1268 "src/ast/parser.ml"
      
    in
    (
# 134 "src/ast/parser.mly"
                                                    ( IfThenElse (c, tbr, Some fbr))
# 1274 "src/ast/parser.ml"
     : (Ast.expr_payload))

let _menhir_action_34 =
  fun _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 ->
    let tbr =
      let (_endpos_x_, _startpos_x_, x) = (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) in
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 1287 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 1293 "src/ast/parser.ml"
      
    in
    let c =
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 1303 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 1309 "src/ast/parser.ml"
      
    in
    (
# 135 "src/ast/parser.mly"
                                                    ( IfThenElse (c, tbr, None))
# 1315 "src/ast/parser.ml"
     : (Ast.expr_payload))

let _menhir_action_35 =
  fun _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 ->
    let body =
      let (_endpos_x_, _startpos_x_, x) = (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) in
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 1328 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 1334 "src/ast/parser.ml"
      
    in
    let c =
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 1344 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 1350 "src/ast/parser.ml"
      
    in
    (
# 136 "src/ast/parser.mly"
                                                    ( While (c, body))
# 1356 "src/ast/parser.ml"
     : (Ast.expr_payload))

let _menhir_action_36 =
  fun _endpos_xs_ _startpos_xs_ c xs ->
    let body =
      let l = 
# 241 "<standard.mly>"
    ( xs )
# 1365 "src/ast/parser.ml"
       in
      let (_endpos_l_, _startpos_l_) = (_endpos_xs_, _startpos_xs_) in
      let _endpos = _endpos_l_ in
      let _startpos = _startpos_l_ in
      
# 140 "src/ast/parser.mly"
                               ( match l with [one] -> build_expr (_startpos,_endpos) one.e_payload | l -> build_expr (_startpos,_endpos) (Seq l) )
# 1373 "src/ast/parser.ml"
      
    in
    (
# 137 "src/ast/parser.mly"
                                                    ( Let(c, body))
# 1379 "src/ast/parser.ml"
     : (Ast.expr_payload))

let _menhir_action_37 =
  fun id ->
    (
# 146 "src/ast/parser.mly"
                                       ( Var id)
# 1387 "src/ast/parser.ml"
     : (Ast.lvalue_payload))

let _menhir_action_38 =
  fun _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 ->
    let e =
      let (_endpos_x_, _startpos_x_, x) = (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) in
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 1400 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 1406 "src/ast/parser.ml"
      
    in
    let lv =
      let l =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 110 "src/ast/parser.mly"
    ( build_lval (_startpos,_endpos) x )
# 1416 "src/ast/parser.ml"
        
      in
      
# 143 "src/ast/parser.mly"
                           ( l )
# 1422 "src/ast/parser.ml"
      
    in
    (
# 147 "src/ast/parser.mly"
                                       ( Array(lv,e) )
# 1428 "src/ast/parser.ml"
     : (Ast.lvalue_payload))

let _menhir_action_39 =
  fun _endpos_x_ _startpos_x_ x ->
    let x =
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 1440 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 1446 "src/ast/parser.ml"
      
    in
    (
# 250 "<standard.mly>"
    ( [ x ] )
# 1452 "src/ast/parser.ml"
     : (Ast.expr list))

let _menhir_action_40 =
  fun _endpos_x_ _startpos_x_ x xs ->
    let x =
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 1464 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 1470 "src/ast/parser.ml"
      
    in
    (
# 253 "<standard.mly>"
    ( x :: xs )
# 1476 "src/ast/parser.ml"
     : (Ast.expr list))

let _menhir_action_41 =
  fun _endpos_x_ _startpos_x_ x ->
    let x =
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 1488 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 1494 "src/ast/parser.ml"
      
    in
    (
# 250 "<standard.mly>"
    ( [ x ] )
# 1500 "src/ast/parser.ml"
     : (Ast.expr list))

let _menhir_action_42 =
  fun _endpos_x_ _startpos_x_ x xs ->
    let x =
      let e =
        let _endpos = _endpos_x_ in
        let _startpos = _startpos_x_ in
        
# 104 "src/ast/parser.mly"
    ( build_expr (_startpos,_endpos) x )
# 1512 "src/ast/parser.ml"
        
      in
      
# 113 "src/ast/parser.mly"
                        ( e )
# 1518 "src/ast/parser.ml"
      
    in
    (
# 253 "<standard.mly>"
    ( x :: xs )
# 1524 "src/ast/parser.ml"
     : (Ast.expr list))

let _menhir_action_43 =
  fun id ->
    (
# 179 "src/ast/parser.mly"
          (T_id id)
# 1532 "src/ast/parser.ml"
     : (Ast.typ))

let _menhir_action_44 =
  fun t ->
    (
# 180 "src/ast/parser.mly"
                      (T_array (T_id t))
# 1540 "src/ast/parser.ml"
     : (Ast.typ))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | ADD ->
        "ADD"
    | AND ->
        "AND"
    | ARRAY ->
        "ARRAY"
    | ASSIGN ->
        "ASSIGN"
    | COLON ->
        "COLON"
    | COMMA ->
        "COMMA"
    | CONST _ ->
        "CONST"
    | DIV ->
        "DIV"
    | DO ->
        "DO"
    | ELSE ->
        "ELSE"
    | END ->
        "END"
    | EOF ->
        "EOF"
    | EQ ->
        "EQ"
    | GE ->
        "GE"
    | GT ->
        "GT"
    | ID _ ->
        "ID"
    | IF ->
        "IF"
    | IN ->
        "IN"
    | LB ->
        "LB"
    | LE ->
        "LE"
    | LET ->
        "LET"
    | LP ->
        "LP"
    | LT ->
        "LT"
    | MUL ->
        "MUL"
    | NE ->
        "NE"
    | OF ->
        "OF"
    | OR ->
        "OR"
    | RB ->
        "RB"
    | RP ->
        "RP"
    | SEMI ->
        "SEMI"
    | STRING _ ->
        "STRING"
    | SUB ->
        "SUB"
    | THEN ->
        "THEN"
    | TYPE ->
        "TYPE"
    | TYPID _ ->
        "TYPID"
    | VAR ->
        "VAR"
    | WHILE ->
        "WHILE"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37"]
  
  let _menhir_goto_program : type  ttv_stack. ttv_stack -> _ -> _menhir_box_program =
    fun _menhir_stack _v ->
      MenhirBox_program _v
  
  let _menhir_run_93 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _v _tok ->
      match (_tok : MenhirBasics.token) with
      | EOF ->
          let c = _v in
          let _v = _menhir_action_08 c in
          _menhir_goto_program _menhir_stack _v
      | _ ->
          _eRR ()
  
  let rec _menhir_run_01 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_WHILE (_menhir_stack, _menhir_s, _startpos) in
      let _menhir_s = MenhirState01 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TYPID _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SUB ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LP ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LET ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IF ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ID _v ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CONST _v ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_02 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_TYPID (_menhir_stack, _menhir_s, _v, _startpos) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LB ->
          let _menhir_s = MenhirState03 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | WHILE ->
              _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TYPID _v ->
              _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SUB ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING _v ->
              _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LP ->
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LET ->
              _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IF ->
              _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ID _v ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CONST _v ->
              _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_04 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_SUB (_menhir_stack, _menhir_s, _startpos) in
      let _menhir_s = MenhirState04 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TYPID _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SUB ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LP ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LET ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IF ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ID _v ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CONST _v ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_05 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos_s_, _startpos_s_, s) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_14 s in
      _menhir_goto_raw_exp _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_s_ _startpos_s_ _v _menhir_s _tok
  
  and _menhir_goto_raw_exp : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState00 ->
          _menhir_run_90 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState88 ->
          _menhir_run_89 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState01 ->
          _menhir_run_87 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState85 ->
          _menhir_run_86 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState03 ->
          _menhir_run_83 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState04 ->
          _menhir_run_82 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _tok
      | MenhirState06 ->
          _menhir_run_75 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState76 ->
          _menhir_run_75 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState73 ->
          _menhir_run_75 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState63 ->
          _menhir_run_64 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState16 ->
          _menhir_run_62 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState60 ->
          _menhir_run_61 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState58 ->
          _menhir_run_59 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState17 ->
          _menhir_run_57 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState53 ->
          _menhir_run_52 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState19 ->
          _menhir_run_52 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState50 ->
          _menhir_run_51 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState48 ->
          _menhir_run_49 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState46 ->
          _menhir_run_47 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState44 ->
          _menhir_run_45 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState42 ->
          _menhir_run_43 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState40 ->
          _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState38 ->
          _menhir_run_39 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState36 ->
          _menhir_run_37 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState34 ->
          _menhir_run_35 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState32 ->
          _menhir_run_33 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState29 ->
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _tok
      | MenhirState27 ->
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _tok
      | MenhirState25 ->
          _menhir_run_26 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState23 ->
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_90 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | SUB ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_40 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_42 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_46 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EOF ->
          let _endpos_0 = _menhir_lexbuf.Lexing.lex_curr_p in
          let (_endpos_x_, _startpos_x_, x, _endpos__2_) = (_endpos, _startpos, _v, _endpos_0) in
          let _v = _menhir_action_09 _endpos__2_ _endpos_x_ _startpos_x_ x in
          _menhir_goto_program _menhir_stack _v
      | DIV ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ADD ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_25 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_raw_exp -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell0_SUB (_menhir_stack, _startpos) in
      let _menhir_s = MenhirState25 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TYPID _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SUB ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LP ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LET ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IF ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ID _v ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CONST _v ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_06 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _menhir_stack = MenhirCell1_LP (_menhir_stack, _menhir_s, _startpos) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState06
      | TYPID _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState06
      | SUB ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState06
      | STRING _v ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState06
      | LP ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState06
      | LET ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState06
      | IF ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState06
      | ID _v ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState06
      | CONST _v ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState06
      | RP ->
          let _v = _menhir_action_06 () in
          _menhir_run_80 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _endpos _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_07 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_LET (_menhir_stack, _menhir_s, _startpos) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | VAR ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState07
      | TYPE ->
          _menhir_run_65 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState07
      | IN ->
          let _v = _menhir_action_02 () in
          _menhir_run_71 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState07 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_08 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_VAR (_menhir_stack, _menhir_s, _startpos) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | ID _v ->
          let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _menhir_stack = MenhirCell0_ID (_menhir_stack, _v, _startpos, _endpos) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | COLON ->
              let _menhir_s = MenhirState10 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | ID _v ->
                  _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | ARRAY ->
                  _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | ASSIGN ->
              let _menhir_s = MenhirState63 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | WHILE ->
                  _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | TYPID _v ->
                  _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | SUB ->
                  _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | STRING _v ->
                  _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | LP ->
                  _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LET ->
                  _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | IF ->
                  _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | ID _v ->
                  _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | CONST _v ->
                  _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_11 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos_id_, id) = (_endpos, _v) in
      let _v = _menhir_action_43 id in
      _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_id_ _v _menhir_s _tok
  
  and _menhir_goto_typ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState67 ->
          _menhir_run_68 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | MenhirState10 ->
          _menhir_run_15 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_68 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_TYPE _menhir_cell0_ID -> _ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell0_ID (_menhir_stack, id, _, _) = _menhir_stack in
      let MenhirCell1_TYPE (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
      let (_endpos_ty_, ty) = (_endpos, _v) in
      let _v = _menhir_action_10 id ty in
      _menhir_goto_raw_chunk _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_ty_ _startpos__1_ _v _menhir_s _tok
  
  and _menhir_goto_raw_chunk : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_raw_chunk (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
      match (_tok : MenhirBasics.token) with
      | VAR ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState69
      | TYPE ->
          _menhir_run_65 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState69
      | EOF | IN ->
          let _v_0 = _menhir_action_02 () in
          _menhir_run_70 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_65 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_TYPE (_menhir_stack, _menhir_s, _startpos) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | ID _v ->
          let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _menhir_stack = MenhirCell0_ID (_menhir_stack, _v, _startpos, _endpos) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | EQ ->
              let _menhir_s = MenhirState67 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | ID _v ->
                  _menhir_run_11 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | ARRAY ->
                  _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_12 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | OF ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | ID _v ->
              let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (_endpos_t_, t) = (_endpos, _v) in
              let _v = _menhir_action_44 t in
              _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_t_ _v _menhir_s _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_70 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_raw_chunk -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_raw_chunk (_menhir_stack, _menhir_s, x, _startpos_x_, _endpos_x_) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_03 _endpos_x_ _startpos_x_ x xs in
      _menhir_goto_list_chunk_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_list_chunk_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState00 ->
          _menhir_run_71 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState07 ->
          _menhir_run_71 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState69 ->
          _menhir_run_70 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_71 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let l = _v in
      let _v = _menhir_action_01 l in
      _menhir_goto_chunks _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_chunks : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState00 ->
          _menhir_run_93 _menhir_stack _v _tok
      | MenhirState07 ->
          _menhir_run_72 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_72 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_LET as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_chunks (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | IN ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | WHILE ->
              _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState73
          | TYPID _v_0 ->
              _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState73
          | SUB ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState73
          | STRING _v_1 ->
              _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState73
          | LP ->
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState73
          | LET ->
              _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState73
          | IF ->
              _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState73
          | ID _v_2 ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState73
          | CONST _v_3 ->
              _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState73
          | END ->
              let _v_4 = _menhir_action_06 () in
              _menhir_run_78 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _endpos _v_4 _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_17 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _menhir_stack = MenhirCell1_IF (_menhir_stack, _menhir_s, _startpos) in
      let _menhir_s = MenhirState17 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TYPID _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SUB ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LP ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LET ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IF ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ID _v ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CONST _v ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_18 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LP ->
          let _menhir_stack = MenhirCell1_ID (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
          let _menhir_stack = MenhirCell0_LP (_menhir_stack, _startpos) in
          let _menhir_s = MenhirState19 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | WHILE ->
              _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TYPID _v ->
              _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SUB ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING _v ->
              _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LP ->
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LET ->
              _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IF ->
              _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ID _v ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CONST _v ->
              _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | RP ->
              let _v = _menhir_action_04 () in
              _menhir_goto_loption_separated_nonempty_list_COMMA_exp__ _menhir_stack _menhir_lexbuf _menhir_lexer _v
          | _ ->
              _eRR ())
      | ADD | AND | ASSIGN | COMMA | DIV | DO | ELSE | END | EOF | EQ | GE | GT | IN | LB | LE | LT | MUL | NE | OR | RB | RP | SEMI | SUB | THEN | TYPE | VAR ->
          let (_endpos_id_, _startpos_id_, id) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_37 id in
          _menhir_goto_raw_lvalue _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_id_ _startpos_id_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_20 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let (_endpos_c_, _startpos_c_, c) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_13 c in
      _menhir_goto_raw_exp _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_c_ _startpos_c_ _v _menhir_s _tok
  
  and _menhir_goto_loption_separated_nonempty_list_COMMA_exp__ : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_ID _menhir_cell0_LP -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell0_LP (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_ID (_menhir_stack, _menhir_s, f, _startpos_f_, _) = _menhir_stack in
      let (xs, _endpos__4_) = (_v, _endpos) in
      let _v = _menhir_action_17 f xs in
      _menhir_goto_raw_exp _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__4_ _startpos_f_ _v _menhir_s _tok
  
  and _menhir_goto_raw_lvalue : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | LB ->
          let _menhir_stack = MenhirCell1_raw_lvalue (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          let _menhir_s = MenhirState23 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | WHILE ->
              _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TYPID _v ->
              _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SUB ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING _v ->
              _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LP ->
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LET ->
              _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IF ->
              _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ID _v ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CONST _v ->
              _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | ASSIGN ->
          let _menhir_stack = MenhirCell1_raw_lvalue (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          let _menhir_s = MenhirState50 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | WHILE ->
              _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TYPID _v ->
              _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SUB ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING _v ->
              _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LP ->
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LET ->
              _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IF ->
              _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ID _v ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CONST _v ->
              _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | ADD | AND | COMMA | DIV | DO | ELSE | END | EOF | EQ | GE | GT | IN | LE | LT | MUL | NE | OR | RB | RP | SEMI | SUB | THEN | TYPE | VAR ->
          let (_endpos_x_, _startpos_x_, x) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_16 _endpos_x_ _startpos_x_ x in
          _menhir_goto_raw_exp _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_x_ _startpos_x_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_78 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_LET, _menhir_box_program) _menhir_cell1_chunks -> _ -> _ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _tok ->
      match (_tok : MenhirBasics.token) with
      | END ->
          let _endpos_0 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_chunks (_menhir_stack, _, c) = _menhir_stack in
          let MenhirCell1_LET (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
          let (_endpos_xs_, _startpos_xs_, xs, _endpos__5_) = (_endpos, _startpos, _v, _endpos_0) in
          let _v = _menhir_action_36 _endpos_xs_ _startpos_xs_ c xs in
          _menhir_goto_raw_exp _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__5_ _startpos__1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_15 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_VAR _menhir_cell0_ID as 'stack) -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v, _endpos) in
      match (_tok : MenhirBasics.token) with
      | ASSIGN ->
          let _menhir_s = MenhirState16 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | WHILE ->
              _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TYPID _v ->
              _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SUB ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING _v ->
              _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LP ->
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LET ->
              _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IF ->
              _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ID _v ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CONST _v ->
              _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_80 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_LP -> _ -> _ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RP ->
          let _endpos_0 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LP (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
          let (_endpos_xs_, _startpos_xs_, xs, _endpos__3_) = (_endpos, _startpos, _v, _endpos_0) in
          let _v = _menhir_action_31 _endpos_xs_ _startpos_xs_ xs in
          _menhir_goto_raw_exp _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__3_ _startpos__1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_32 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_raw_exp -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState32 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TYPID _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SUB ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LP ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LET ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IF ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ID _v ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CONST _v ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_34 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_raw_exp -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState34 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TYPID _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SUB ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LP ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LET ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IF ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ID _v ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CONST _v ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_27 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_raw_exp -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState27 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TYPID _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SUB ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LP ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LET ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IF ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ID _v ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CONST _v ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_38 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_raw_exp -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState38 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TYPID _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SUB ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LP ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LET ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IF ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ID _v ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CONST _v ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_40 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_raw_exp -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState40 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TYPID _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SUB ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LP ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LET ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IF ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ID _v ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CONST _v ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_42 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_raw_exp -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState42 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TYPID _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SUB ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LP ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LET ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IF ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ID _v ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CONST _v ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_44 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_raw_exp -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState44 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TYPID _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SUB ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LP ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LET ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IF ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ID _v ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CONST _v ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_46 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_raw_exp -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState46 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TYPID _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SUB ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LP ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LET ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IF ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ID _v ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CONST _v ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_29 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_raw_exp -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState29 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TYPID _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SUB ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LP ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LET ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IF ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ID _v ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CONST _v ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_48 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_raw_exp -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState48 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TYPID _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SUB ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LP ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LET ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IF ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ID _v ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CONST _v ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_36 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_raw_exp -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState36 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | TYPID _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SUB ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING _v ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | LP ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LET ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IF ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ID _v ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | CONST _v ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_89 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_WHILE, _menhir_box_program) _menhir_cell1_raw_exp as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | SUB ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_40 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_42 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_46 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ADD ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | DO | ELSE | END | EOF | IN | RB | RP | SEMI | THEN | TYPE | VAR ->
          let MenhirCell1_raw_exp (_menhir_stack, _, x, _startpos_x_, _endpos_x_) = _menhir_stack in
          let MenhirCell1_WHILE (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
          let (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_35 _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 in
          _menhir_goto_raw_exp _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_x_inlined1_ _startpos__1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_87 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_WHILE as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
      match (_tok : MenhirBasics.token) with
      | SUB ->
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NE ->
          _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          _menhir_run_40 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          _menhir_run_42 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          _menhir_run_46 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DO ->
          let _menhir_s = MenhirState88 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | WHILE ->
              _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TYPID _v ->
              _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SUB ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING _v ->
              _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LP ->
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LET ->
              _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IF ->
              _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ID _v ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CONST _v ->
              _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | DIV ->
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ADD ->
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_86 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_TYPID, _menhir_box_program) _menhir_cell1_raw_exp _menhir_cell0_RB as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | SUB ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_40 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_42 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_46 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ADD ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | DO | ELSE | END | EOF | IN | RB | RP | SEMI | THEN | TYPE | VAR ->
          let MenhirCell0_RB (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_raw_exp (_menhir_stack, _, x, _startpos_x_, _endpos_x_) = _menhir_stack in
          let MenhirCell1_TYPID (_menhir_stack, _menhir_s, t, _startpos_t_) = _menhir_stack in
          let (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_15 _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ t x x_inlined1 in
          _menhir_goto_raw_exp _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_x_inlined1_ _startpos_t_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_83 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_TYPID as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
      match (_tok : MenhirBasics.token) with
      | SUB ->
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RB ->
          let _endpos = _menhir_lexbuf.Lexing.lex_curr_p in
          let _menhir_stack = MenhirCell0_RB (_menhir_stack, _endpos) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | OF ->
              let _menhir_s = MenhirState85 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | WHILE ->
                  _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | TYPID _v ->
                  _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | SUB ->
                  _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | STRING _v ->
                  _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | LP ->
                  _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LET ->
                  _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | IF ->
                  _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | ID _v ->
                  _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | CONST _v ->
                  _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | OR ->
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NE ->
          _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          _menhir_run_40 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          _menhir_run_42 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          _menhir_run_46 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ADD ->
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_82 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_SUB -> _ -> _ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _tok ->
      let MenhirCell1_SUB (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
      let (_endpos_x_, _startpos_x_, x) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_30 _endpos_x_ _startpos__1_ _startpos_x_ x in
      _menhir_goto_raw_exp _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_x_ _startpos__1_ _v _menhir_s _tok
  
  and _menhir_run_75 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | SUB ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SEMI ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          let _menhir_s = MenhirState76 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | WHILE ->
              _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TYPID _v ->
              _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SUB ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING _v ->
              _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LP ->
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LET ->
              _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IF ->
              _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ID _v ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CONST _v ->
              _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | OR ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_40 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_42 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_46 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ADD ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer
      | END | RP ->
          let (_endpos_x_, _startpos_x_, x) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_41 _endpos_x_ _startpos_x_ x in
          _menhir_goto_separated_nonempty_list_SEMI_exp_ _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_x_ _startpos_x_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_SEMI_exp_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState76 ->
          _menhir_run_77 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok
      | MenhirState06 ->
          _menhir_run_74 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | MenhirState73 ->
          _menhir_run_74 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_77 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_raw_exp -> _ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _v _tok ->
      let MenhirCell1_raw_exp (_menhir_stack, _menhir_s, x, _startpos_x_, _endpos_x_) = _menhir_stack in
      let (_endpos_xs_, xs) = (_endpos, _v) in
      let _v = _menhir_action_42 _endpos_x_ _startpos_x_ x xs in
      _menhir_goto_separated_nonempty_list_SEMI_exp_ _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_xs_ _startpos_x_ _v _menhir_s _tok
  
  and _menhir_run_74 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      let (_endpos_x_, _startpos_x_, x) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_07 x in
      _menhir_goto_loption_separated_nonempty_list_SEMI_exp__ _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_x_ _startpos_x_ _v _menhir_s _tok
  
  and _menhir_goto_loption_separated_nonempty_list_SEMI_exp__ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState06 ->
          _menhir_run_80 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _tok
      | MenhirState73 ->
          _menhir_run_78 _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_64 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_VAR _menhir_cell0_ID as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | SUB ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_40 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_42 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_46 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ADD ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EOF | IN | TYPE | VAR ->
          let MenhirCell0_ID (_menhir_stack, id, _, _) = _menhir_stack in
          let MenhirCell1_VAR (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
          let (_endpos_x_, _startpos_x_, x) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_11 _endpos_x_ _startpos_x_ id x in
          _menhir_goto_raw_chunk _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_x_ _startpos__1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_62 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_VAR _menhir_cell0_ID, _menhir_box_program) _menhir_cell1_typ as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | SUB ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_40 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_42 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_46 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ADD ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EOF | IN | TYPE | VAR ->
          let MenhirCell1_typ (_menhir_stack, _, ty, _) = _menhir_stack in
          let MenhirCell0_ID (_menhir_stack, id, _, _) = _menhir_stack in
          let MenhirCell1_VAR (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
          let (_endpos_x_, _startpos_x_, x) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_12 _endpos_x_ _startpos_x_ id ty x in
          _menhir_goto_raw_chunk _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_x_ _startpos__1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_61 : type  ttv_stack. ((((ttv_stack, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_raw_exp, _menhir_box_program) _menhir_cell1_raw_exp as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | SUB ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_40 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_42 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_46 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ADD ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | DO | ELSE | END | EOF | IN | RB | RP | SEMI | THEN | TYPE | VAR ->
          let MenhirCell1_raw_exp (_menhir_stack, _, x_inlined1, _startpos_x_inlined1_, _endpos_x_inlined1_) = _menhir_stack in
          let MenhirCell1_raw_exp (_menhir_stack, _, x, _startpos_x_, _endpos_x_) = _menhir_stack in
          let MenhirCell1_IF (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
          let (_endpos_x_inlined2_, _startpos_x_inlined2_, x_inlined2) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_33 _endpos_x_ _endpos_x_inlined1_ _endpos_x_inlined2_ _startpos_x_ _startpos_x_inlined1_ _startpos_x_inlined2_ x x_inlined1 x_inlined2 in
          _menhir_goto_raw_exp _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_x_inlined2_ _startpos__1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_59 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_raw_exp as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | SUB ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_40 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_42 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_46 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ELSE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          let _menhir_s = MenhirState60 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | WHILE ->
              _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TYPID _v ->
              _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SUB ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING _v ->
              _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LP ->
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LET ->
              _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IF ->
              _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ID _v ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CONST _v ->
              _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | DIV ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ADD ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | DO | END | EOF | IN | RB | RP | SEMI | THEN | TYPE | VAR ->
          let MenhirCell1_raw_exp (_menhir_stack, _, x, _startpos_x_, _endpos_x_) = _menhir_stack in
          let MenhirCell1_IF (_menhir_stack, _menhir_s, _startpos__1_) = _menhir_stack in
          let (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_34 _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 in
          _menhir_goto_raw_exp _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_x_inlined1_ _startpos__1_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_57 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_IF as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
      match (_tok : MenhirBasics.token) with
      | THEN ->
          let _menhir_s = MenhirState58 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | WHILE ->
              _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TYPID _v ->
              _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SUB ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING _v ->
              _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LP ->
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LET ->
              _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IF ->
              _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ID _v ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CONST _v ->
              _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | SUB ->
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NE ->
          _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          _menhir_run_40 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          _menhir_run_42 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          _menhir_run_46 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ADD ->
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_52 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | SUB ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_40 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_42 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_46 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          let _menhir_s = MenhirState53 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | WHILE ->
              _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | TYPID _v ->
              _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | SUB ->
              _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING _v ->
              _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | LP ->
              _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LET ->
              _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IF ->
              _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ID _v ->
              _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | CONST _v ->
              _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | AND ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ADD ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RP ->
          let (_endpos_x_, _startpos_x_, x) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_39 _endpos_x_ _startpos_x_ x in
          _menhir_goto_separated_nonempty_list_COMMA_exp_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_exp_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState53 ->
          _menhir_run_54 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState19 ->
          _menhir_run_21 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_54 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_raw_exp -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_raw_exp (_menhir_stack, _menhir_s, x, _startpos_x_, _endpos_x_) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_40 _endpos_x_ _startpos_x_ x xs in
      _menhir_goto_separated_nonempty_list_COMMA_exp_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_21 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_ID _menhir_cell0_LP -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let x = _v in
      let _v = _menhir_action_05 x in
      _menhir_goto_loption_separated_nonempty_list_COMMA_exp__ _menhir_stack _menhir_lexbuf _menhir_lexer _v
  
  and _menhir_run_51 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_raw_lvalue as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | SUB ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_40 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_42 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_46 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ADD ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | DO | ELSE | END | EOF | IN | RB | RP | SEMI | THEN | TYPE | VAR ->
          let MenhirCell1_raw_lvalue (_menhir_stack, _menhir_s, x, _startpos_x_, _endpos_x_) = _menhir_stack in
          let (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_32 _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 in
          _menhir_goto_raw_exp _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_x_inlined1_ _startpos_x_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_49 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_raw_exp as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | SUB ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_40 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_42 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_46 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ADD ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | COMMA | DO | ELSE | END | EOF | IN | OR | RB | RP | SEMI | THEN | TYPE | VAR ->
          let MenhirCell1_raw_exp (_menhir_stack, _menhir_s, x, _startpos_x_, _endpos_x_) = _menhir_stack in
          let (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_18 _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 in
          _menhir_goto_raw_exp _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_x_inlined1_ _startpos_x_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_47 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_raw_exp as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | SUB ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ADD ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | COMMA | DO | ELSE | END | EOF | IN | OR | RB | RP | SEMI | THEN | TYPE | VAR ->
          let MenhirCell1_raw_exp (_menhir_stack, _menhir_s, x, _startpos_x_, _endpos_x_) = _menhir_stack in
          let (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_28 _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 in
          _menhir_goto_raw_exp _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_x_inlined1_ _startpos_x_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_45 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_raw_exp as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | SUB ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ADD ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | COMMA | DO | ELSE | END | EOF | IN | OR | RB | RP | SEMI | THEN | TYPE | VAR ->
          let MenhirCell1_raw_exp (_menhir_stack, _menhir_s, x, _startpos_x_, _endpos_x_) = _menhir_stack in
          let (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_27 _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 in
          _menhir_goto_raw_exp _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_x_inlined1_ _startpos_x_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_43 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_raw_exp as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | SUB ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ADD ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | COMMA | DO | ELSE | END | EOF | IN | OR | RB | RP | SEMI | THEN | TYPE | VAR ->
          let MenhirCell1_raw_exp (_menhir_stack, _menhir_s, x, _startpos_x_, _endpos_x_) = _menhir_stack in
          let (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_26 _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 in
          _menhir_goto_raw_exp _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_x_inlined1_ _startpos_x_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_41 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_raw_exp as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | SUB ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ADD ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | COMMA | DO | ELSE | END | EOF | IN | OR | RB | RP | SEMI | THEN | TYPE | VAR ->
          let MenhirCell1_raw_exp (_menhir_stack, _menhir_s, x, _startpos_x_, _endpos_x_) = _menhir_stack in
          let (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_25 _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 in
          _menhir_goto_raw_exp _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_x_inlined1_ _startpos_x_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_39 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_raw_exp as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | SUB ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ADD ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | COMMA | DO | ELSE | END | EOF | IN | OR | RB | RP | SEMI | THEN | TYPE | VAR ->
          let MenhirCell1_raw_exp (_menhir_stack, _menhir_s, x, _startpos_x_, _endpos_x_) = _menhir_stack in
          let (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_24 _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 in
          _menhir_goto_raw_exp _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_x_inlined1_ _startpos_x_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_37 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_raw_exp as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | MUL ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ADD | AND | COMMA | DO | ELSE | END | EOF | EQ | GE | GT | IN | LE | LT | NE | OR | RB | RP | SEMI | SUB | THEN | TYPE | VAR ->
          let MenhirCell1_raw_exp (_menhir_stack, _menhir_s, x, _startpos_x_, _endpos_x_) = _menhir_stack in
          let (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_20 _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 in
          _menhir_goto_raw_exp _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_x_inlined1_ _startpos_x_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_35 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_raw_exp as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | SUB ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ADD ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | COMMA | DO | ELSE | END | EOF | IN | OR | RB | RP | SEMI | THEN | TYPE | VAR ->
          let MenhirCell1_raw_exp (_menhir_stack, _menhir_s, x, _startpos_x_, _endpos_x_) = _menhir_stack in
          let (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_29 _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 in
          _menhir_goto_raw_exp _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_x_inlined1_ _startpos_x_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_33 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_raw_exp as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | SUB ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_40 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_42 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_46 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ADD ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | DO | ELSE | END | EOF | IN | OR | RB | RP | SEMI | THEN | TYPE | VAR ->
          let MenhirCell1_raw_exp (_menhir_stack, _menhir_s, x, _startpos_x_, _endpos_x_) = _menhir_stack in
          let (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_19 _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 in
          _menhir_goto_raw_exp _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_x_inlined1_ _startpos_x_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_30 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_raw_exp -> _ -> _ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _tok ->
      let MenhirCell1_raw_exp (_menhir_stack, _menhir_s, x, _startpos_x_, _endpos_x_) = _menhir_stack in
      let (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_23 _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 in
      _menhir_goto_raw_exp _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_x_inlined1_ _startpos_x_ _v _menhir_s _tok
  
  and _menhir_run_28 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_raw_exp -> _ -> _ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _tok ->
      let MenhirCell1_raw_exp (_menhir_stack, _menhir_s, x, _startpos_x_, _endpos_x_) = _menhir_stack in
      let (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) = (_endpos, _startpos, _v) in
      let _v = _menhir_action_21 _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 in
      _menhir_goto_raw_exp _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_x_inlined1_ _startpos_x_ _v _menhir_s _tok
  
  and _menhir_run_26 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_raw_exp _menhir_cell0_SUB as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | MUL ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ADD | AND | COMMA | DO | ELSE | END | EOF | EQ | GE | GT | IN | LE | LT | NE | OR | RB | RP | SEMI | SUB | THEN | TYPE | VAR ->
          let MenhirCell0_SUB (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_raw_exp (_menhir_stack, _menhir_s, x, _startpos_x_, _endpos_x_) = _menhir_stack in
          let (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1) = (_endpos, _startpos, _v) in
          let _v = _menhir_action_22 _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 in
          _menhir_goto_raw_exp _menhir_stack _menhir_lexbuf _menhir_lexer _endpos_x_inlined1_ _startpos_x_ _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_24 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_raw_lvalue as 'stack) -> _ -> _ -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _endpos _startpos _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | SUB ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_25 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RB ->
          let _endpos_0 = _menhir_lexbuf.Lexing.lex_curr_p in
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_raw_lvalue (_menhir_stack, _menhir_s, x, _startpos_x_, _endpos_x_) = _menhir_stack in
          let (_endpos_x_inlined1_, _startpos_x_inlined1_, x_inlined1, _endpos__4_) = (_endpos, _startpos, _v, _endpos_0) in
          let _v = _menhir_action_38 _endpos_x_ _endpos_x_inlined1_ _startpos_x_ _startpos_x_inlined1_ x x_inlined1 in
          _menhir_goto_raw_lvalue _menhir_stack _menhir_lexbuf _menhir_lexer _endpos__4_ _startpos_x_ _v _menhir_s _tok
      | OR ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MUL ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_27 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_40 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_42 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GE ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_46 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DIV ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_29 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_48 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ADD ->
          let _menhir_stack = MenhirCell1_raw_exp (_menhir_stack, _menhir_s, _v, _startpos, _endpos) in
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  let _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          _menhir_run_01 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | VAR ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | TYPID _v ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState00
      | TYPE ->
          _menhir_run_65 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | SUB ->
          _menhir_run_04 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | STRING _v ->
          _menhir_run_05 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState00
      | LP ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | LET ->
          _menhir_run_07 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | IF ->
          _menhir_run_17 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | ID _v ->
          _menhir_run_18 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState00
      | CONST _v ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState00
      | EOF ->
          let _v = _menhir_action_02 () in
          _menhir_run_71 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState00 _tok
      | _ ->
          _eRR ()
  
end

let program =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_program v = _menhir_run_00 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
