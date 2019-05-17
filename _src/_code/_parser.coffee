Languages_ = require('../../_build/_languages.js')
{ ParserError_ }  = require('./_errors.coffee')

_noop = -> {}
_log = console.log

class Parser_
  constructor: (@_input) ->

  _parse: ->
    if typeof @_input == "string"
      Languages_.parse(@_input, tracer: { trace: _noop })
    else
      throw new ParserError_("input is not a string")

module.exports = Parser_
