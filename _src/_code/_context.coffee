_log = console.log
_json = JSON.stringify

Parser_ = require './_parser.coffee'
{ ContextError_ } = require './_errors.coffee'

class Context_
  constructor: (
    @_arguments = new Set(),
    @_scope = new Map(),
    @_block = "") ->

    unless @_arguments instanceof Set
      throw new ContextError_("arguments must be a set")

    unless @_scope instanceof Map
      throw new ContextError_("scope must be a map")

    unless typeof @_block == "string"
      throw new ContextError_("block must be a string")

    @_arg0 = [...@_arguments][0]
    @_arg1 = [...@_arguments][1]
    @_arg2 = [...@_arguments][2]

  @_eval: (_input) ->
    (new Context_(new Set([_input])))._eval()

  _eval: ->
    (new Parser_(@_arg0))._parse().forEach (node) =>
      _log(node)

  _define: ->
    @_scope.set @_arg0, (_context) =>
      @_arguments

  _import: ->
    _eval(fs.readFileSync(@_arg0, "utf8").toString())

  _rand: ->
    Math.random()

  # inputs, show, join, import, input, ...

  _to_s: ->
    "current: #{_json(@_current)}
     , arguments: #{_json(@_arguments)}
     , scope: #{_json(@_scope)}
     , block: #{_json(@_block)}"

module.exports = Context_
