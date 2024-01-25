local harpoon = require("harpoon")
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

harpoon.setup({
    tabline = true,
})

vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon: M[A]rk [F]ile" })
vim.keymap.set("n", "<leader>e", ui.toggle_quick_menu, { desc = "Harpoon: Show Fil[E]s" })

vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end, { desc = "Harpoon: Marked File [1]" })
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end, { desc = "Harpoon: Marked File [2]" })
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end, { desc = "Harpoon: Marked File [3]" })
vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end, { desc = "Harpoon: Marked File [4]" })

vim.cmd('highlight! HarpoonInactive guibg=NONE guifg=#63698c')
vim.cmd('highlight! HarpoonActive guibg=NONE guifg=white')
vim.cmd('highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7')
vim.cmd('highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7')
vim.cmd('highlight! TabLineFill guibg=NONE guifg=white')
