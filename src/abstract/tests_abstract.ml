let verbose = ref false
let const = ref false
let interval = ref false
let product = ref false

let options =
  [
    ("--verbose", Arg.Set verbose, "Enables the printing of log");
    ("--const", Arg.Set const, "Enables the testing of consts");
    ("--interval", Arg.Set interval, "Enables the testing of intervals");
    ("--product", Arg.Set product, "Enables the testing of reduced product");
  ]

let color_gradient percent block_index total_blocks =
  let red_percentage =
    100.0 -. (float_of_int block_index /. float_of_int total_blocks *. 100.0)
  in
  let r = int_of_float (2.55 *. red_percentage) in
  let g = int_of_float (2.55 *. percent) in
  let b = 0 in
  Printf.sprintf "\027[38;2;%d;%d;%dm" r g b

let cmd_generic ~percentage ~down ~lvl =
  let target_freq = int_of_float (400.0 +. (percentage *. 24.0)) in
  let duration = 0.2 in
  let step_count = 8 in
  let step_size = float_of_int (target_freq - 400) /. float_of_int step_count in
  let seq_command =
    if down then Printf.sprintf "seq %d -1 0" (step_count - 1)
    else Printf.sprintf "seq 0 %d" (step_count - 1)
  in
  let command =
    Printf.sprintf
      "if command -v play >/dev/null; then for i in $(%s); do \
       current_freq=$(echo \"400 + %f * $i\" | bc); play -n synth %f sine \
       $(echo $current_freq | bc) vol %f > /dev/null 2>&1; done; fi"
      seq_command step_size duration lvl
  in
  ignore (Sys.command (command ^ " &"))

let cmd percentage = cmd_generic ~percentage ~down:false ~lvl:0.5
let cmd_unsound () = cmd_generic ~percentage:50. ~down:true ~lvl:0.7

let progress_bar percentage =
  let total_blocks = 20 in
  let filled_blocks =
    int_of_float (float_of_int total_blocks *. (percentage /. 100.0))
  in
  let bar = ref "" in
  for i = 0 to total_blocks - 1 do
    if i < filled_blocks then
      let color = color_gradient percentage i total_blocks in
      bar := !bar ^ color ^ "█\027[0m"
    else bar := !bar ^ " "
  done;
  Printf.sprintf "[%s] " !bar

let parse_args () =
  try Arg.parse_argv Sys.argv options ignore "tiger_ai test suite"
  with Arg.Bad s | Arg.Help s ->
    Format.printf "%s" s;
    exit 0

let check_soundness run_analyzer =
  if !verbose then Format.printf "\nTesting soundness ...\n\n";
  let tests_dir = "tests/bad" in
  let files = Sys.readdir tests_dir in
  Array.sort compare files;
  let files = Array.to_list files in
  let tig_files =
    List.filter (fun file -> Filename.check_suffix file ".tig") files
  in
  let niy = ref 0 in
  let errors = ref 0 in
  let success = ref 0 in
  List.iter
    (fun filename ->
      let full_path = Filename.concat tests_dir filename in
      if !verbose then Format.printf "%s " full_path;
      try
        let g, b = run_analyzer full_path in
        success := !success + g;
        errors := !errors + b;
        if !verbose then
          if g <> 0 then Format.printf "\027[31mError\027[0m\n"
          else Format.printf "\027[32mOk\027[0m\n"
      with Utils.NotImplementedYet s ->
        incr niy;
        if !verbose then
          Format.printf "\027[33m%s Not implemented yet\027[0m\n" s)
    tig_files;
  Format.printf
    "Bad\t: Not implemented:%i, Safe operations:%i, Unsafe operations:%i\n" !niy
    !success !errors;
  !success = 0

let check run_analyzer =
  if !verbose then Format.printf "\nTesting precision ...\n\n";
  let tests_dir = "tests/good" in
  let files = Sys.readdir tests_dir in
  Array.sort compare files;
  let files = Array.to_list files in
  let tig_files =
    List.filter (fun file -> Filename.check_suffix file ".tig") files
  in
  let niy = ref 0 in
  let errors = ref 0 in
  let success = ref 0 in
  List.iter
    (fun filename ->
      let full_path = Filename.concat tests_dir filename in
      if !verbose then Format.printf "%s " full_path;
      try
        let g, b = run_analyzer full_path in
        success := !success + g;
        errors := !errors + b;
        if !verbose then Format.printf "Safe: %d, Unsafe: %d\n" g b
      with Utils.NotImplementedYet s ->
        incr niy;
        if !verbose then
          Format.printf "\027[33m%s Not implemented yet\027[0m\n" s)
    tig_files;
  Format.printf
    "Good\t: Not implemented:%i, Safe access: %d, Unsafe access: %d\n" !niy
    !success !errors;
  let total_done = !success + !errors in
  let nb_files = List.length tig_files in
  let coverage = 100. *. float (nb_files - !niy) /. float nb_files in
  ( (if total_done > 0 then 100. *. float !success /. float total_done else 0.),
    coverage )

let run_const_analyzer file = Driver.ConstAnalyzer.run file
let run_interval_analyzer file = Driver.IntervalAnalyzer.run file
let run_product_analyzer file = Driver.IntervalParityAnalyzer.run file

let celebrate precision coverage sound =
  if !verbose && coverage = 100. && precision = 100. && sound then (
    let cmd =
      "#!/bin/bash\n\
       LINES=$(tput lines)\n\
       COLUMNS=$(tput cols)\n\
       for i in {1..1000}; do\n\
      \  row=$((RANDOM % LINES))\n\
      \  col=$((RANDOM % COLUMNS))\n\
      \  tput cup \"$row\" \"$col\"\n\
      \  printf \"%s\" \"$(shuf -n1 -e 🐯 🐅)\"\n\
       done\n\
       sleep 0.2; clear"
    in
    let filename = "/tmp/congrat.sh" in
    let out_chan = open_out filename in
    output_string out_chan cmd;
    close_out out_chan;
    ignore
      (Sys.command
         (Printf.sprintf "chmod +x %s && %s && rm %s" filename filename filename)))

let run_tests name analyzer =
  Format.printf "\n-----------------\n| %s Tests |\n-----------------\n" name;
  let sound = check_soundness analyzer in
  let precision, coverage = check analyzer in
  if !verbose then
    if sound then if coverage = 100. then cmd precision else cmd_unsound ();
  let color1 = progress_bar coverage in
  let color2 = progress_bar precision in
  Format.printf
    "Soundness: %s\n\
     \027[0mCoverage:  %s%.2f%%\n\
     \027[0mPrecision: %s%.2f%%\027[0m\n"
    (if sound then "\027[32m✔" else "\027[31m✗")
    color1 coverage color2 precision;
  celebrate precision coverage sound

let () =
  parse_args ();
  if !const then run_tests "Const" run_const_analyzer;
  if !interval then run_tests "Interval" run_interval_analyzer;
  if !product then run_tests "Product" run_product_analyzer
