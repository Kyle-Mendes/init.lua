vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- Enter the File Explorer
vim.keymap.set("n", "<leader>,", vim.cmd.noh)
vim.keymap.set("n", "<leader>S", vim.cmd.so)

-- Move selections
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep the cursor where it is
vim.keymap.set("n", "J", "mzJ`z") -- Keep the cursor in the same spot when `J`
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP") -- Paste over and keep the paste in the buffer

-- Yank to the system clipboard
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>Y", "\"+y")

vim.keymap.set("n", "Q", "<nop>")
