local keymap = vim.keymap.set
keymap("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
keymap("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
