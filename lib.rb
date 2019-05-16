$DEFINITIONS = {}

class Code_
  attr_reader :_previous, :_arguments

  def initialize(_previous = nil, _arguments = [])
    @_previous = _previous
    @_arguments= _arguments
  end

  def self._eval(_input)
    Code_.new._code_eval(_input)
  end

  def self._class_eval(&block)
    class_eval(&block)
  end

  def _instance_eval(&_block)
    instance_eval(&_block)
  end

  def self._code_def(*args, &block)
    new._code_def(*args, &block)
  end

  def _code_def(_previous, _arguments = [], &_block)
    Code_._class_eval do
      define_instance_method("_code_#{_previous}") do |_method_previous, _method_arguments = []|
        _context = Code_.new(_method_previous, _method_arguments)
        _context._instance_eval(&_block)
      end
    end
  end

  _code_def('eval') do
    _previous.split(';').map do |_line|
      _line.split('|').map(&:strip).inject(nil) do |_result, _instruction|
        _name, _arguments = _instruction.split(' ', 2)
        method(:"_code_#{_name}").call(_result, _arguments)
      end
    end.join
  end

  _code_def('inputs') do
    if ARGV.any?
      ARGV.dup.tap { ARGV.clear }
    else
      [STDIN.each_line.to_a.join]
    end
  end

  _code_def('input') do
    _code_eval('inputs | join')
  end

  _code_def('show') do
    puts _previous
  end

  _code_def('join') do
    _previous.join(" ")
  end
end
