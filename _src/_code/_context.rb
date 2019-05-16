class Code_
  class Context_
    attr_reader :_arguments, :_block

    def initialize(_arguments = [], _block = -> {})
      @_arguments = _arguments
      @_block = _block
    end

    def self._code_eval(_input)
      new._code_eval(_input)
    end

    def self._code_define(_arguments = [], &_block)
      new._code_define(Array(_arguments), &_block)
    end

    def self._code_import(_arguments = [], &_block)
      new._code_import(Array(_arguments), &_block)
    end

    def _code_define(_arguments = [], &_block)
      p _arguments
      self.class.send(:define_method, "_code_#{_arguments[0]}") do |_m_arguments = []|
        self.class.new(_m_arguments, _block)._instance_eval
      end
    end

    def _instance_eval
      instance_eval(&_block)
    end

    def _parser
      @_parser ||= Code_::Parser_.new
    end

    _code_define 'eval' do
      _parser._parse(_arguments[0]).map do |_type, _value|
        p({ _type => _value })
      end
    end

    _code_define 'inputs' do
      if ARGV.any?
        ARGV.dup.tap { ARGV.clear }
      else
        [STDIN.each_line.to_a.join]
      end
    end

    _code_define 'show'  do
      puts _arguments[0]
    end

    _code_define 'join' do
      _arguments[0].join(" ")
    end

    _code_define 'import' do
      _code_eval(File.read(File.join(File.dirname(__FILE__), _arguments[0])))
    end

    _code_define 'input' do
      _code_eval "join inputs"
    end

    # _code_import('./lib.code')
  end
end
