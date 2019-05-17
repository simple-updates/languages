_log = console.log

Context_ = require('./_code/_context.coffee')

class Code_
  @_eval = (_input) =>
    _log("code eval #{_input}")
    Context_._eval(_input)

module.exports = Code_
