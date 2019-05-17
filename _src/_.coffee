_process = require 'process'
_fs = require 'fs'

_ = {}

_.log = console.log

_.json = JSON.stringify

_.json.pretty = (_value) ->
  JSON.stringify(_value, null, 2)

_.to_set = (_object) =>
  if _object instanceof Set
    _object
  else if typeof _object == "array"
    new Set(_object)
  else
    new Set([_object])

_.noop = => {}

_.is_blank = (_value) =>
  ['{}', '[]', 'null', 'undefined', '""'].contains(_.json(_value))

_.json.clean = (_value) =>
  if _.is_a("list", _value)
    _value = _.reject(_value, (_v) => _.is_blank(_v))
    _.map(_value, (_v) => _.json.clean(_v))
  else if _.is_a("dictionnary", _value)
    _value = _.reject_values(_value, (_v) => _.is_blank(_v))
    _.map_values(_value, (_v) => _.json.clean(_v))
  else
    _value

_.is_set = (_value) =>
  _value instanceof Set

_.is_map = (_value) =>
  _value instanceof Map

_.is_an = (_type, _value) =>
  _typeof = typeof value

  if _type == "list" and (_typeof == "array" or _.is_set(_value))
    true
  else if _type == "dictionnary" and (_typeof == "object" or _.is_map(_value))
    true
  else if type == "number" and _typeof == "number"
    true
  else if type == "boolean" and _typeof == "boolean"
    true
  else
    false

_.is_a = _.is_an

_.map = (_values, _block) =>
  _values.map _block

_.each = (_values, _block) =>
  _values.forEach _block

_.reject = (_list, _block) =>
  list.filter(_block)

_.reject_values = (_dictionnary, _block) =>
  _result = new Map()

  for _key, _value of _dictionnary.entries()
    if _block(_value)
      _result.set(_key, _value)

  _result

_.map_values = (_dictionnary, _block) =>
  _result = new Map()

  for _key, _value of _dictionnary.entries()
    _result.set(_key, _block.call(_value))

  _result

_.input = ->
  _process.argv.splice(2).join("\n") or
    _fs.readFileSync(0).toString() or
    throw("missing input")

_.exit = (_code = 1) ->
  _process.exit(_code)

_.require = (_path) ->
  require("#{__dirname}/../#{_path}")

_.env = process.env

module.exports = _
