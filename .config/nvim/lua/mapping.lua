local keymap = vim.keymap.set
-- lsp saga
keymap("n", "gf", "<cmd>Lspsaga finder<CR>", { silent = true })
keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
keymap("n", "<leader>cr", "<cmd>Lspsaga rename<CR>", { silent = true })
keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
keymap("n", "<leader>e", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
keymap("n","<leader>o", "<cmd>Lspsaga outline<CR>",{ silent = true })
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
keymap("n", "<leader>e", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
-- todo.comment
keymap("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

keymap("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

local builtin = require('telescope.builtin')
local opts = { noremap=true, silent=true }
vim.keymap.set('n', 'gD', builtin.lsp_definitions, opts)
vim.keymap.set('n', 'gi', builtin.lsp_implementations, opts)
vim.keymap.set('n', '<space>D', builtin.lsp_type_definitions, opts)
vim.keymap.set('n', 'gr', builtin.lsp_references, opts)
