-- lsp-config setup
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
local wk = require("which-key")
local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

-- Mappings for lsp
local opts = { noremap=true, silent=true }
buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
-- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
-- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
-- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
buf_set_keymap('n', 'gr', '<cmd>Trouble lsp_references<CR>', opts)
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

-- lspinstall setup
require("lspinstall").setup{}
local installed_servers = require'lspinstall'.installed_servers()
for _, server in pairs(installed_servers) do
    if server == 'cpp' then -- special setup for clangd
        require'lspconfig'.cpp.setup{
            vim.api.nvim_set_keymap('n', '<space>cs', ':ClangdSwitchSourceHeader<cr>', {noremap = true}),
        }
    else
        require'lspconfig'[server].setup{}
    end
    nvim_lsp[server].setup { on_attach = on_attach }
end

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
