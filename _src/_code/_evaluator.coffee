_ = require '../_'

class Evaluator_
  constructor: (@_node, @_context) ->

  _eval: ->
    _.log(_.json(@_node))

module.exports = Evaluator_
