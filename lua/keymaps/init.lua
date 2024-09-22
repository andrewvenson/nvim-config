vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<leader>p', ':DBUIToggle<CR>', { desc = 'Toggle dbui drawer' })
vim.keymap.set('n', '<leader>qt', function()
  local fp = vim.fn.expand '%:p' -- gives full path of file
  local repos_for_prettier = {
    'adopt-provider',
    'adopt-workflows',
    'billing-workflows',
    'delivery-provider',
    'delivery-workflows',
    'e2e-testing',
    'graphs',
    'identity-provider',
    'identity-workflows',
    'partner-workflows',
    'product-workflows',
    'publisher-provider',
    'redshelf',
    'redshelf-core',
    'redshelf-graph-layer',
    'redshelf-layer-ts',
    'subgraphs',
    'university-provider',
    'university-workflows',
  }
  print('Running prettier on: ' .. fp)
  for dir in string.gmatch(fp, '[%w%-]+') do -- [%w%-]+ finds all alphanumberic chars including a -
    for _, v in ipairs(repos_for_prettier) do
      if v == dir then
        local cmd = 'cd ~/code/' .. v .. '/ts && yarn prettier'
        vim.fn.system(cmd)
        vim.cmd 'edit'
        print 'Prettier complete'
        return
      end
    end
  end
end, { desc = 'Runs prettier on code project' })
