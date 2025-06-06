require('mapping')
require('which-key-bindings')
require('nvim_lsp')
require('plugin-config')
require('plugin_config/autopairs')
require('plugin_config/cmp')
require('plugin_config/dap')
require('plugin_config/indentblankline')
require('plugin_config/lsp_saga')
require('plugin_config/orgmode')
-- require('plugin_config/ufo')

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.HINT] = '',
      [vim.diagnostic.severity.INFO] = '',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
      [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
    }
  }
})
