local wk = require("which-key")
-- Mappings for lsp
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  -- local builtin = require('telescope.builtin')
  -- local opts = { noremap=true, silent=true }
  -- vim.keymap.set('n', 'gD', builtin.lsp_definitions, opts)
  -- vim.keymap.set('n', 'gi', builtin.lsp_implementations, opts)
  -- vim.keymap.set('n', '<space>D', builtin.lsp_type_definitions, opts)
  -- vim.keymap.set('n', 'gr', builtin.lsp_references, opts)
  local opts = { noremap=true, silent=true, buffer=bufnr }
  -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>s', vim.lsp.buf.format(), opts)


    -- Set some keybinds conditional on server capabilities
    local filetype = vim.bo.filetype
    if filetype == "c" or filetype == "cpp" then
      vim.keymap.set('n', '<space>cs', '<cmd>ClangdSwitchSourceHeader<CR>', opts)
        wk.register({
          c = {
              name = "Code action",
              a = "Code action",
              s = "Clangd Switch Source Header",
              r = "Rename"
          },
        }, { prefix = "<leader>" })
    else
        wk.register({
          c = {
              name = "Code action",
              a = "Code action",
              r = "Rename"
          },
        }, { prefix = "<leader>" })
    end

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.document_highlight then
        vim.api.nvim_exec([[
          augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END
        ]], false)
    end
end

local servers = { 'pylsp', 'clangd', 'ts_ls', 'svls', 'texlab', 'bashls'}
for _,lsp in ipairs(servers) do
  vim.lsp.enable(lsp)
end
