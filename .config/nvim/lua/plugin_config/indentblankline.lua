-- IndentBlankLine config
require('indent_blankline').setup {
  char = '▏',
  context_patterns = {'class', 'function', 'method', '^if', '^while', '^for', '^object', '^table', 'block', 'arguments'},
  buftype_exclude = {"terminal", 'help'},
  use_treesitter = true,
}

