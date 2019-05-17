_ = require '../_'

Languages_ = require('../../_build/_languages.js')
{ ParserError_ }  = require('./_errors.coffee')

class Parser_
  constructor: (@_input, @_tracer = _.noop) ->

  _parse: ->
    if typeof @_input == "string"
      Languages_.parse(@_input, tracer: @_tracer)
    else
      throw new ParserError_("input is not a string")

module.exports = Parser_
