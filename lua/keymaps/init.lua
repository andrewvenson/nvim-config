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
vim.keymap.set('n', '<leader>j', function()
  os.execute 'echo "$(pbpaste)" > ~/table_data/temp_table_data'
  local file = io.open('/Users/andrewvenson/table_data/temp_table_data', 'r')

  local x = 1
  local columns = {}
  local rows = {}

  while true do
    if file ~= nil then
      local line = file:read()
      local match = string.find(line, '%(%d+ rows*%)')
      if match ~= nil then
        file:close()
        break
      end
      if x == 1 then
        local i = 0
        while true do
          local a, b = string.find(line, '%w+', i + 1)
          if b ~= nil and a ~= nil then
            i = b
            local column = string.sub(line, a, b)
            table.insert(columns, column)
          else
            break
          end
        end
      else
        if x ~= 2 then
          local i = 0
          local rowI = 1
          local row = {}
          local loop = true
          while loop do
            local a, b = string.find(line, '|', i + 1)
            if b ~= nil and a ~= nil then
              local field = string.sub(line, i + 1, b - 1)
              i = b
              local column = columns[rowI]
              local leading_stripped = string.gsub(field, '^%s+', '')
              local fully_stripped = string.gsub(leading_stripped, '%s+$', '')
              row[column] = fully_stripped

              local c, d = string.find(line, '|', i + 1)
              if c == nil and d == nil then
                local field2 = string.sub(line, i + 1)
                local lastColumn = columns[rowI]
                row[lastColumn] = field2
                loop = false
              end
            else
              break
            end
            rowI = rowI + 1
          end
          table.insert(rows, row)
        end
      end
      x = x + 1
    end
  end

  os.execute('echo ' .. "'" .. '{ "results": [' .. "' >> sql.json")
  local table_length = 0
  for _, _ in ipairs(rows) do
    table_length = table_length + 1
  end

  for k, v in ipairs(rows) do
    os.execute "echo '{' >> sql.json"
    local row_length = 0
    local current_row_index = 1
    for _, _ in pairs(v) do
      row_length = row_length + 1
    end
    for key, val in pairs(v) do
      if current_row_index == row_length then
        os.execute("echo '" .. '"' .. key .. '"' .. ':' .. '"' .. val .. '"' .. "' >> sql.json")
      else
        os.execute("echo '" .. '"' .. key .. '"' .. ':' .. '"' .. val .. '",' .. "' >> sql.json")
      end
      current_row_index = current_row_index + 1
    end
    if table_length ~= k then
      os.execute "echo '},' >> sql.json"
    else
      os.execute "echo '}' >> sql.json"
    end
  end
  os.execute("echo '" .. "]}' >> sql.json")
  os.execute 'pbcopy < sql.json; rm sql.json'
  os.execute 'rm ~/table_data/temp_table_data'
end, { desc = 'Copies sql output to json in clipboard' })
