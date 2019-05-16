require_relative './_code/_parser.rb'
require_relative './_code/_context.rb'

class Code_
  def self._eval(input)
    Code_::Context_.new._code_eval(input)
  end
end
