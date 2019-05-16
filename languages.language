code = (
  _
  identifier:identifier
  _
  { return { identifier } }
)

space = " "
newline = "\n"
open_code = "{"
close_code = "}"
open_group = "("
close_group = ")"

_ = (space / newline)*

identifier =
  $(
    !open_code
    !close_code
    !open_group
    !close_group
    .
  )+
