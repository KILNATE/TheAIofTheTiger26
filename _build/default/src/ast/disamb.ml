(*
   This preprocessing step differentiates type identifiers used in array
   initialization from other identifiers at the lexical level.

   Given a text file, it identifies and modifies patterns where an
   identifier is followed by a bracketed expression and then the keyword "of".

   The process consists of:
   - Identifying valid identifiers using the pattern: [a-zA-Z_][a-zA-Z0-9_]*
   - Detecting bracketed expressions following these identifiers
   - When encountering "of" after such bracketed expressions, inserting
     a predefined token ("_") before the identifier to disambiguate parsing
   - Supporting nested bracketed expressions (e.g., `array[expr1[expr2]]`)

   This transformation ensures that parsing remains unambiguous without
   requiring a Generalized LR (GLR) parser.
*)

open Str

let find_matching_bracket text start_index =
  let rec aux i stack =
    if i >= String.length text then -1
    else
      match text.[i] with
      | '[' -> aux (i + 1) (stack + 1)
      | ']' -> if stack = 1 then i else aux (i + 1) (stack - 1)
      | _ -> aux (i + 1) stack
  in
  aux (start_index + 1) 1

let extract_identifier text index =
  let id_regex = regexp "\\([a-zA-Z_][a-zA-Z0-9_]*\\)[ \n\r\x0c\t]*\\[" in
  if string_match id_regex text index then
    let identifier = matched_group 1 text in
    let end_index = match_end () - 1 in
    let rec extract_brackets id end_idx =
      if end_idx < String.length text && text.[end_idx] = '[' then
        let matching_bracket = find_matching_bracket text end_idx in
        if matching_bracket = -1 then (id, end_idx)
        else
          extract_brackets
            (id ^ String.sub text end_idx (matching_bracket - end_idx + 1))
            (matching_bracket + 1)
      else (id, end_idx)
    in
    extract_brackets identifier end_index
  else ("", index)

let insert_token_before_identifier text token =
  let buffer = Buffer.create (String.length text) in
  let rec process i =
    if i >= String.length text then ()
    else if
      text.[i] |> Char.code >= Char.code 'a'
      && text.[i] |> Char.code <= Char.code 'z'
      || text.[i] |> Char.code >= Char.code 'A'
         && text.[i] |> Char.code <= Char.code 'Z'
    then
      let identifier, next_index = extract_identifier text i in
      if identifier <> "" then
        (* Format.printf "identifier '%s'\n" identifier; *)
        let remainder =
          String.sub text next_index (String.length text - next_index)
        in
        if string_match (regexp "[ \n\r\x0c\t]*of\\b") remainder 0 then (
          (* Format.printf "followed by of : true\n"; *)
          let new_name = token ^ identifier ^ " of" in
          (* Format.printf "new name: %s\n" new_name; *)
          Buffer.add_string buffer new_name;
          process (next_index + match_end ()))
        else (
          (* Format.printf "followed by of : false\n"; *)
          Buffer.add_char buffer text.[i];
          process (i + 1))
      else (
        Buffer.add_char buffer text.[i];
        process (i + 1))
    else (
      Buffer.add_char buffer text.[i];
      process (i + 1))
  in
  process 0;
  Buffer.contents buffer

let process_file ?(rewrite = false) f =
  let input_file = f in
  let ic = open_in input_file in
  let content = really_input_string ic (in_channel_length ic) in
  close_in ic;
  let modified_content = insert_token_before_identifier content "_" in
  if rewrite then (
    let f = Filename.basename f in
    let output_file = "deamb_" ^ f in
    let oc = open_out output_file in
    output_string oc modified_content;
    close_out oc);
  modified_content
