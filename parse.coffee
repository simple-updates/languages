#!/usr/bin/env coffee

require('./lib').import_()

show(pretty_json(parse(read_input())))
