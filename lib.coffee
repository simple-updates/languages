fs = require 'fs'
process = require 'process'
cp = require 'child_process'
coffeescript = require 'coffeescript'
Tracer = require 'pegjs-backtrace'

read_input = =>
  if process.stdin.isTTY
    process.argv[2]
  else
    fs.readFileSync(0).toString()

read_file = (filename) =>
  fs.readFileSync(filename).toString()

pretty_json = (input) =>
  JSON.stringify(input, null, 2)

show = (input) =>
  console.log(input)

exit = (message) =>
  show(message)
  process.exit()

parse = (input) =>
  tracer = new Tracer input,
    showFullPath: true

  languages = require './build/languages'

  try
    languages.parse(input, tracer: tracer)
  catch error
    show(tracer.getBacktraceString())
    exit(error.message)

import_ = (filename = path.dirname(__filename)) =>
  coffeescript.eval(read_file(filename))

exec = (input) =>
  program = input.split(' ')[0]
  args = input.split(' ').splice(1)
  result = cp.spawnSync(program, args)
  stderr = result.stderr.toString()
  exit(stderr) if stderr

module.exports = { import_ }
