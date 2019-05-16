#!/usr/bin/env coffee

require('./lib').import_

exec("pegjs languages.syntax --trace -o build/languages.js")

show(pretty_json(parse(read_input())))
