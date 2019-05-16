require 'execjs'

class Code_
  attr_reader :_previous, :_arguments, :_block

  def initialize(_previous = nil, _arguments = [], _block = -> {})
    @_previous = _previous
    @_arguments= _arguments
    @_block = _block
  end

  def self._eval(_input)
    Code_.new._code_eval(_input)
  end

  def self._def(_previous, _arguments, &_block)
    new._code_def(_previous, _arguments, &_block)
  end

  def _eval
    instance_eval(@_block)
  end

  def _define_method(_name, &block)
    Code_.send(:define_method, "_code_#{_name}")
  end

  def _code_def(_previous, _arguments = [], &_block)
    Code_.send(:define_method, "_code_#{_previous}") do |_m_previous, _m_arguments = []|
      Code_.new(_m_previous, _m_arguments, _block)._eval
    end
  end

  _def 'eval' do
    _previous.split(';').map do |_line|
      _line.split('|').map(&:strip).inject(nil) do |_result, _instruction|
        _name, _arguments = _instruction.split(' ', 2)
        method(:"_code_#{_name}").call(_result, _arguments)
      end
    end.join
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
    puts _previous
  end

  _def 'join' do
    _previous.join(" ")
  end
end
