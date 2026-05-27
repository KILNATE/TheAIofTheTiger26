open Lexing

(* open a file and parse it *)
let parse (filename : string) =
  let content = Disamb.process_file filename in
  Utils.file := filename;
 let lex = from_string content in
  let fileparser = Parser.program Lexer.token in
  try
    lex.lex_curr_p <- { lex.lex_curr_p with pos_fname = filename };
    fileparser lex
  with
  | Lexer.Lexical_error (msg, _, _, _) ->
      let msg =
        Format.asprintf "Lexical Error \"%s\" in %a\n" msg Errors.from_lex lex
      in
      Errors.fail msg
  | _ ->
      let msg = Format.asprintf "Syntax Error in %a\n" Errors.from_lex lex in
      Errors.fail msg
