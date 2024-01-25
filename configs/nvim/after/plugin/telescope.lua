local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>p', builtin.find_files, { desc = 'Find files in [P]roject' })
vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp tags'})

vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
