let show_ast = ref false
let show_annotated_ast = ref false
let globaldescr = "Tiger_ai is a static analyzer for the tiger language"
let domain = ref "const"
let pdf = ref false
let report = ref false
let rewrite = ref false

let options =
  [
    ("--show-ast", Arg.Set show_ast, "Enables the printing of the AST");
    ( "--annot",
      Arg.Set show_annotated_ast,
      "Enables the printing of the AST along with their abstract state" );
    ( "--pdf",
      Arg.Set pdf,
      "Enables the printing of the annotated AST int a pdf file" );
    ("--report", Arg.Set report, "Enables the generation of a report");
    ("--domain", Arg.Set_string domain, "Changes the evaluation domain");
    ( "--rewrite",
      Arg.Set rewrite,
      "Rewrites the program with annotations on safe array accesses" );
  ]

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
  let open Driver in
  Random.self_init ();
  let file = parse_args () in
  let safe, unsafe =
    match !domain with
    | "parity" ->
        ParityAnalyzer.run ~report:!report ~show_ast:!show_ast
          ~show_annotast:!show_annotated_ast ~pdf:!pdf file
    | "const" ->
        ConstAnalyzer.run ~report:!report ~show_ast:!show_ast
          ~show_annotast:!show_annotated_ast ~pdf:!pdf file
    | "interval" ->
        IntervalAnalyzer.run ~report:!report ~show_ast:!show_ast
          ~show_annotast:!show_annotated_ast ~pdf:!pdf file
    | "product" ->
        IntervalParityAnalyzer.run ~report:!report ~show_ast:!show_ast
          ~show_annotast:!show_annotated_ast ~pdf:!pdf file
    | s -> failwith (Format.asprintf "domain %s unknown" s)
  in
  Format.printf "%i/%i access proven safe\n" safe (safe + unsafe)
