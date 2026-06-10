let show_ast = ref false
let globaldescr = "Tiger_concrete is an interpreter for the tiger language"

let options =
  [ ("--show-ast", Arg.Set show_ast, "Enables the printing of the AST") ]

let parse_args () =
  let set_prog s = Utils.file := s in
  try
    Arg.parse_argv Sys.argv options set_prog globaldescr;
    if !Utils.file = "" then (
      Format.printf "Please give me a .tig file\n";
      exit 0);
    if Sys.file_exists !Utils.file then !Utils.file
    else (
      Format.printf "%s : file not found\n" !Utils.file;
      exit 0)
  with Arg.Bad s | Arg.Help s ->
    Format.printf "%s" s;
    exit 0

let () =
  Random.self_init ();
  let file = parse_args () in
  let ast = Fileparser.parse file in
  if !show_ast then Format.printf "%a@,%!" Ast.print_program ast;
  let _state = Interpreter.eval_program ast in
  ()
