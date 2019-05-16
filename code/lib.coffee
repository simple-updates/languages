require("#{__dirname}/lib").import_()

code = (tree) =>
  show_json(tree)

module.exports = { code }
