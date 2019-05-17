_ = require '../_'

Tracer_ = require '../../_vendor/_pegjs-backtrace.js'

_tracer_options =
  showFullPath: true
  matchesNode: (_node, _options) ->
    if _.is_a('string', _options._grep) and not _node.path.includes(_options._grep)
      false
    else if _.is_a('string', _options.nodeType) and _node.type != _options._nodeType
      false
    else
      true

module.exports = { Tracer_, _tracer_options }
