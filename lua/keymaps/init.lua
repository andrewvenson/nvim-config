local daddy = require 'plugins.dads-json'
local prettier = require 'plugins.prettier'
local jesty = require 'plugins.jesty'

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<leader>p', ':DBUIToggle<CR>', { desc = 'Toggle dbui drawer' })
vim.keymap.set('n', '<leader>qt', prettier.pretty, { desc = 'Runs prettier on code project' })
vim.keymap.set('n', '<leader>j', daddy.jsonify, { desc = 'Copies sql output to json in clipboard' })
vim.keymap.set('n', '<leader>o', jesty.jest, { desc = 'Copies one off jest file for testing' })
