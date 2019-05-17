class RuntimeError_ extends Error
  constructor: (@_type, @_context) ->
    super()
    @message = "#{@_type} #{@_context._to_s()}"
    @name = "runtime error"

class ParserError_ extends Error
  constructor: (@_message) ->
    super()
    @message = @_message
    @name = "parser error"

class ContextError_ extends Error
  constructor: (@_message) ->
    super()
    @message = @_message
    @name = "context error"

module.exports = { RuntimeError_, ParserError_, ContextError_ }
