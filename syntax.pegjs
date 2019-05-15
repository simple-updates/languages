// languages
code = .+

data = .+

value = .+

text =
  text:$special_char*
  { return { text } }

template =

// helper
_ "whitespace" = (special_space / special_newline)*

// values
value_boolean = value_true / value_false

// special
special_space = " "
special_newline = "\n"
special_open_tag = "{"
special_close_tag = "}"
special_open_object = "{"
special_close_object = "{"
special_open_list = "["
special_close_list = "]"
special_open_group = "("
special_close_group = ")"
special_method_start = "|"
special_assign = "="
special_quote = '"'
special_value_separator = ","
special_key_value_separator = ":"
special_child_seperator = "."
special_escape = "\\"
special_positive = "+"
special_negative = "-"
special_all = "all"
special_integer_separator = "_"
special_nothing = "nothing"
special_true = "true"
special_false = "false"
special_digit = [0-9]
