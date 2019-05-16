#!/usr/bin/env coffee

require('./lib').import_()

relative_import "code/lib"

code(parse(read_input()))
