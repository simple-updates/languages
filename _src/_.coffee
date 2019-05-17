_ = {}

_.log = console.log
_.json = JSON.stringify
_.toSet = (object) ->
  if object instanceof Set
    object
  else if typeof object == "array"
    new Set(object)
  else
    new Set([object])

_.noop = -> {}

module.exports = _
