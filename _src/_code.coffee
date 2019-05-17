_ = require('./_')

Context_ = require('./_code/_context.coffee')

class Code_
  @_eval = (_input) =>
    Context_._eval(_input)

module.exports = Code_
