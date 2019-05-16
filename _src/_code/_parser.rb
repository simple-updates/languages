require 'execjs'

class Code_
  class Parser_
    PARSER_FILE_ = File.join(File.dirname(__FILE__), '../../_build/_languages.js')

    def initialize
      @_compiled = ExecJS.compile(File.read(PARSER_FILE_))
    end

    def _parse(_input)
      @_compiled.call('_Languages.parse', _input)
    end
  end
end
