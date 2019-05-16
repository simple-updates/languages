fs = require 'fs'
process = require 'process'
cp = require 'child_process'
coffeescript = require 'coffeescript'
Tracer = require 'pegjs-backtrace'
pipe = require('pipe-args').load()

read_input = =>
  process.argv[2]

read_file = (filename) =>
  fs.readFileSync(filename).toString()

pretty_json = (input) =>
  JSON.stringify(input, null, 2)

show = (input) =>
  process.stdout.write("#{input}\n")

exit = (message) =>
  show(message)
  process.exit()

parse = (input) =>
  exec("pegjs languages.syntax --trace -o build/languages.js")

  tracer = new Tracer input,
    showFullPath: true

  languages = require './build/languages'

  try
    languages.parse(input, tracer: tracer)
  catch error
    show(tracer.getBacktraceString())
    exit(error.message)

import_ = (filename = __filename) =>
  filename = "#{filename}.coffee" unless filename.endsWith(".coffee")
  coffeescript.eval(read_file(filename))

relative_import = (filename) =>
  import_("#{__dirname}/#{filename}")

exec = (input) =>
  program = input.split(' ')[0]
  args = input.split(' ').splice(1)
  result = cp.spawnSync(program, args)
  stderr = result.stderr.toString()
  exit(stderr) if stderr

show_json = (input) =>
  show(pretty_json(input))

module.exports = { import_ }
