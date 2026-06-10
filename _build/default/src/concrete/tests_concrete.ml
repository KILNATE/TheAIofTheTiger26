let verbose = ref false
let options = [ ("--verbose", Arg.Set verbose, "Enables the printing of log") ]

let parse_args () =
  try Arg.parse_argv Sys.argv options ignore "tiger_concrete test suite"
  with Arg.Bad s | Arg.Help s ->
    Format.printf "%s" s;
    exit 0

let read_file filename =
  let chan = open_in filename in
  let len = in_channel_length chan in
  let content = really_input_string chan len in
  close_in chan;
  content

let diff_strings s1 s2 =
  let len1 = String.length s1 in
  let len2 = String.length s2 in
  if len1 + len2 < 20 then Printf.printf "expected %s but got %s " s1 s2
  else
    let min_len = min len1 len2 in
    let lines = ref 1 in
    let col = ref 1 in
    try
      for i = 0 to min_len - 1 do
        if s1.[i] <> s2.[i] then (
          Printf.printf "Diff at line %d col %d: '%c' <> '%c' " !lines !col
            s1.[i] s2.[i];
          raise Exit);
        if s1.[i] = '\n' then (
          incr lines;
          col := 1)
      done;
      if len1 > len2 then
        Printf.printf "Extra in s1: \"%s\" " (String.sub s1 len2 (len1 - len2))
      else if len2 > len1 then
        Printf.printf "Extra in s2: \"%s\" " (String.sub s2 len1 (len2 - len1))
    with Exit -> ()

let equal_file_string file1 content2 =
  try
    let content1 = read_file file1 in
    content1 = content2
    ||
    (if !verbose then diff_strings content1 content2;
     false)
  with Sys_error msg ->
    Printf.eprintf "File error: %s\n" msg;
    false

let run_interpreter file =
  let ast = Fileparser.parse file in
  let no_ext_filename = Filename.chop_extension file in
  let oc = Format.str_formatter in
  let _state = Interpreter.eval_program ~oc ast in
  let content2 = Format.flush_str_formatter () in
  let print_name = no_ext_filename ^ ".print" in
  equal_file_string print_name content2

let check_interpret () =
  let tests_dir = "tests/interpreter" in
  let files = Sys.readdir tests_dir in
  Array.sort compare files;
  let files = Array.to_list files in
  let tig_files =
    List.filter (fun file -> Filename.check_suffix file ".tig") files
  in
  let niy = ref 0 in
  let errors = ref 0 in
  let success = ref 0 in
  Format.printf
    "---------------------\n| Interpreter Tests |\n---------------------\n";
  List.iter
    (fun filename ->
      let full_path = Filename.concat tests_dir filename in
      if !verbose then Format.printf "%s " full_path;
      try
        if run_interpreter full_path then (
          incr success;
          if !verbose then Format.printf "\027[32mOk\027[0m\n")
        else (
          incr errors;
          if !verbose then Format.printf "\027[31mError\027[0m\n")
      with Utils.NotImplementedYet s ->
        incr niy;
        if !verbose then
          Format.printf "\027[33m %s Not implemented yet\027[0m\n" s)
    tig_files;
  Format.printf "Interpreter: Not implemented:%i, Errors:%i, Success:%i.\n" !niy
    !errors !success;
  Format.printf "Correctness: %s\027[0m\t"
    (if !errors = 0 then "\027[32m\xE2\x9C\x94" else "\027[31m\xE2\x9C\x97");
  Format.printf " Coverage: %s\027[0m\n"
    (if !niy = 0 then "\027[32m\xE2\x9C\x94" else "\027[31m\xE2\x9C\x97")

let () =
  parse_args ();
  check_interpret ()
