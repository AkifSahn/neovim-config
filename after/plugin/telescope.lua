local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>fs', builtin.live_grep, {})
vim.keymap.set('n', '<leader>hh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>dd', builtin.diagnostics, {})
-- live grep does everything this mapping does
--vim.keymap.set('n', '<leader>fs', function()
--    builtin.grep_string({ search = vim.fn.input("Grep > ") });
--end)
