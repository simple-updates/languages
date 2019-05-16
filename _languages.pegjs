code =
  first_code:(
    instruction:instruction
    { return { instruction } } /
    group_begin
    code:code
    group_end
    { return code }
  )
  _
  other_codes:(
    _
    instruction_separator
    _
    code:code
    { return code }
  )*
  { return [first_code].concat(...other_codes) }

_ = (" " / "\n")*
space = " "
newline = "\n"
instruction_separator = ";"
group_begin = "("
group_end = ")"

instruction =
  name:name
  _
  parameters:(
    value /
    code
  )*
  _
  block:(
    _
    block_begin
    _
    code:code
    _
    block_end
    { return code }
  )?
  { return { name, parameters, block } }

block_begin = "do"
block_end = "end"

name =
  name:$(
    !(
      space /
      newline /
      block_begin /
      block_end /
      group_begin /
      group_end /
      instruction_separator
    )
    .
  )+
  { return name }

value =
  _
  value:(
    nothing /
    boolean /
    number /
    string
  )
  { return { value } }

nothing =
  nothing:"nothing"
  { return { nothing } }

boolean =
  boolean:(
    true /
    false
  )
  { return { boolean } }

true = "true"
false = "false"

number =
  number:$(
    (
      digit /
      digit_separator
    )+
    (
      digit_decimal_separator
      (
        digit /
        digit_separator
      )+
    )?
  )
  { return { number } }

digit = [0-9]
digit_separator = "_"
digit_decimal_separator = "."

string =
  string_begin
  string:$(!string_end .)+
  string_end
  { return { string } }

string_begin = '"'
string_end = string_begin
