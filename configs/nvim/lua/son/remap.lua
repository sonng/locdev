-- Space as leader!
vim.g.mapleader = " "

-- Previous/Next buffer
vim.keymap.set("n", "<leader>bp", ":bp<cr>")
vim.keymap.set("n", "<leader>bo", ":bo<cr>")

-- NvimTree
vim.keymap.set("n", "<leader>fe", ":NvimTreeToggle<cr>")
vim.keymap.set("n", "<leader>ff", ":NvimTreeFindFile<cr>")

-- Move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- J on steroidz
vim.keymap.set("n", "J", "mzJ`z")

-- Keep us centered when we move up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")

-- Next search occurrences gets centered
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])

-- Clipboard 
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Search Replace
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Copilot
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true})
vim.api.nvim_set_keymap("i", "<C-H>", 'copilot#Previous()', { silent = true, expr = true})
vim.api.nvim_set_keymap("i", "<C-K>", 'copilot#Next()', { silent = true, expr = true})
vim.api.nvim_set_keymap("i", "<C-L>", 'copilot#Suggest()', { silent = true, expr = true})
