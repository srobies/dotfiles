-- lsp-config setup
local nvim_lsp = require('lspconfig')
local wk = require("which-key")

-- Mappings for lsp
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>cr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    wk.register({
        r = "References",
        d = "Definition",
        D = "Declaration",
        i = "Implementation",
        f = "LSP Finder", -- check init.vim for Lspsaga binds
        s = "Signature help",
        p = "Definition preview"
    }, { prefix = "g" })
    wk.register({
        D = "Type definition"
    }, { prefix = "<leader>" })

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
        wk.register({
            c = {
                f = "Format"
            }
        }, { prefix = "<leader>" })
    end
    if client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("v", "<space>cf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end
    if client.resolved_capabilities.ClangdSwitchSourceHeader then
        wk.register({
            c = {
                s = "Clangd Switch Source Header"
            }
        }, { prefix = "<leader>" })
    end

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
          augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
          augroup END
        ]], false)
    end
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'clangd', 'tsserver', 'svls', 'texlab'}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities =  require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

require('lspconfig').sumneko_lua.setup {
  cmd = {"lua-language-server"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = "/usr/bin/luajit",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
local saga = require 'lspsaga'
saga.init_lsp_saga {
    error_sign = '',
    infor_sign = '',
    hint_sign = '',
    warn_sign = '',
    max_preview_lines = 15,
    finder_action_keys = {
      open = 'o', vsplit = '|',split = '-',quit = {'q', '<esc>'}, scroll_down = '<C-f>', scroll_up = '<C-b>' -- quit can be a table
    },
    code_action_keys = {
      quit = {'q', '<Esc>'}, exec = '<CR>'
    },
    rename_action_keys = {
      quit = {'<C-c>', '<Esc>'}, exec = '<CR>'
    },
}
