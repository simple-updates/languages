module Code_
  class Context_
    attr_reader :_before, :_arguments, :_block

    def initialize(_before = nil, _arguments = [], _block = -> {})
      @_before = _before
      @_arguments= _arguments
      @_block = _block
    end

    def self._eval(_input)
      new._code_eval(_input)
    end

    def self._def(_before, _arguments = [], &_block)
      new._code_def(_before, _arguments, &_block)
    end

    def _eval
      instance_eval(&@_block)
    end

    def _parser
      @_parser ||= Code_::Parser_.new
    end

    def _define_method(_name, &block)
      self.class.send(:define_method, "_code_#{_name}")
    end

    def _code_def(_before, _arguments = [], &_block)
      self.class.send(:define_method, "_code_#{_before}") do |_m_before, _m_arguments = []|
        self.class.new(_m_before, _m_arguments, _block)._eval
      end
    end

    _def 'eval' do
      _parser._parse(_before).map do |_type, _value|
        p({ _type => _value })
        # _line.split('|').map(&:strip).inject(nil) do |_result, _instruction|
        #   _name, _arguments = _instruction.split(' ', 2)
        #  method(:"_code_#{_name}").call(_result, _arguments)
        # end
      end
    end

    _def 'inputs' do
      if ARGV.any?
        ARGV.dup.tap { ARGV.clear }
      else
        [STDIN.each_line.to_a.join]
      end
    end

    _def 'input' do
      _code_eval('inputs | join')
    end

    _def 'show'  do
      puts _before
    end

    _def 'join' do
      _before.join(" ")
    end
  end
end
