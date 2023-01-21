local keymap = vim.keymap.set
-- lsp saga
keymap("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
keymap("n", "<leader>cr", "<cmd>Lspsaga rename<CR>", { silent = true })
keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
keymap("n", "<leader>e", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
keymap("n","<leader>o", "<cmd>LSoutlineToggle<CR>",{ silent = true })
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
keymap("n", "<leader>e", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
-- todo.comment
keymap("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

keymap("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
