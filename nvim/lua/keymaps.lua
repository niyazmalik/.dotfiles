
vim.g.mapleader = " "

vim.keymap.set("i", "kj", "<Esc>", { noremap = true })

vim.keymap.set({"i", "s"}, "hh", function()
    require("luasnip").expand()
end, { desc = "Expand snippet" })

vim.keymap.set("n", "<A-j>", "]m", { desc = "Next brace" })
vim.keymap.set("n", "<A-k>", "[m", { desc = "Previous brace" })

vim.keymap.set("i", "<A-h>", "<Left>", { desc = "Move left" })
vim.keymap.set("i", "<A-l>", "<Right>", { desc = "Move right" })

vim.keymap.set('n', '<Tab>', '4l', { noremap = true })
vim.keymap.set('n', '<S-Tab>', '4h', { noremap = true })

vim.keymap.set('n', '<A-t>', ToggleTerminal, { noremap = true, silent = true })
vim.keymap.set('t', '<A-t>', ToggleTerminal, { noremap = true, silent = true })

vim.keymap.set({"n", "v"}, "<leader>c", toggle_comment, { desc = "Toggle // comment" })
