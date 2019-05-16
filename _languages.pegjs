code = (
  expressions:expression+
  { return { expressions } } /
  (
    open_code
    _
    code:code
    _
    close_code
    { return code }
  )
)

space = " "
newline = "\n"
open_code = "{"
close_code = "}"
open_group = "("
close_group = ")"

_ = (space / newline)*

name =
  $(
    !space
    !open_code
    !close_code
    !open_group
    !close_group
    .
  )+

expression =
  _
  name:name
  _
  values:value+
  _
  { return { name, values } }

value =
  value:(
    nothing:nothing /
    boolean:boolean /
    number:number /
    string:string /
    list:list /
    object:object /
    name:name
  )
  { return { value } }

nothing =
  nothing:"nothing"
  { return { nothing } }

boolean =
  boolean:(true / false)
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
    )
  )+
  { return { number } }

digit = [0-9]
digit_separator = "_"
digit_decimal_separator = "," / "."

string =
  open_string
  (!close_string text:text)+
  close_string
  { return text }

open_string = '"'
close_string = open_string

text = .

list =
  list:(
    _
    open_list
    _
    first_value:value?
    _
    other_values:(
      list_separator
      _
      value:value
      _
      { return value }
    )*
    _
    close_list
    _
    { return [...first_value, ...other_values] }
  )
  { return { list } }

open_list = "["
close_list = "]"
list_separator = ","

object =
  object:(
    _
    open_object
    _
    first_key_value:key_value?
    _
    key_values:(
      list_separator
      _
      key_value:key_value
      _
    )*
    close_object
    _
  )
  { return { object } }

open_object = "{"
close_object = "}"

key_value =
  _
  name:name
  _
  key_value_separator
  _
  value:value
  _
  { return { name, value } }

key_value_separator = ":"
