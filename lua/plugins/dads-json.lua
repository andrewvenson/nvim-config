return {
  jsonify = function()
    vim.cmd 'normal! gg"+yG'
    os.execute 'echo "$(pbpaste)" > ~/table_data/temp_table_data'
    local file = io.open('/Users/andrewvenson/table_data/temp_table_data', 'r')

    local loop_iter = 1
    local columns = {}
    local rows = {}
    local main_loop = true
    local column_iter_count = 1

    while main_loop do
      if file ~= nil then
        local line = file:read()
        local match = string.find(line, '%(%d+ rows*%)')
        if match ~= nil then
          file:close()
          main_loop = false
          break
        end
        if loop_iter == 1 then
          local i = 0
          local loop = true
          while loop do
            local a, b = string.find(line, '%w+', i + 1)
            if b ~= nil and a ~= nil then
              i = b
              local column = string.sub(line, a, b)
              table.insert(columns, column)
            else
              loop = false
              break
            end
            column_iter_count = column_iter_count + 1
          end
        else
          if loop_iter ~= 2 then
            local i = 0
            local rowI = 1
            local row = {}
            local stringx = '\\"'
            while rowI < column_iter_count do
              local a, b = string.find(line, '|', i + 1)
              if b ~= nil and a ~= nil then
                local field = string.sub(line, i + 1, b - 1)
                i = b
                local column = columns[rowI]
                local leading_stripped = string.gsub(field, '^%s+', '')
                local fully_stripped = string.gsub(leading_stripped, '%s+$', '')
                row[column] = string.gsub(fully_stripped, '"', stringx)
              else
                local field2 = string.sub(line, i + 1)
                local lastColumn = columns[rowI]
                local leading_stripped2 = string.gsub(field2, '^%s+', '')
                local fully_stripped2 = string.gsub(leading_stripped2, '%s+$', '')
                row[lastColumn] = string.gsub(fully_stripped2, '"', stringx)
              end
              rowI = rowI + 1
            end
            table.insert(rows, row)
          end
        end
        loop_iter = loop_iter + 1
      end
    end

    os.execute("echo '" .. "{' >> sql.json")
    os.execute("echo '" .. '  "results": [' .. "' >> sql.json")
    local table_length = 0
    for _, _ in ipairs(rows) do
      table_length = table_length + 1
    end

    for k, v in ipairs(rows) do
      os.execute "echo '    {' >> sql.json"
      local row_length = 0
      local current_row_index = 0
      for _, _ in pairs(v) do
        row_length = row_length + 1
      end
      for key, val in pairs(v) do
        current_row_index = current_row_index + 1
        if current_row_index == row_length then
          os.execute("echo '" .. '      "' .. key .. '"' .. ':' .. '"' .. val .. '"' .. "' >> sql.json")
        else
          os.execute("echo '" .. '      "' .. key .. '"' .. ':' .. '"' .. val .. '",' .. "' >> sql.json")
        end
      end
      if table_length ~= k then
        os.execute "echo '    },' >> sql.json"
      else
        os.execute "echo '    }' >> sql.json"
      end
    end
    os.execute("echo '" .. "  ]' >> sql.json")
    os.execute "echo '}' >> sql.json"
    os.execute 'pbcopy < sql.json; rm sql.json'
    os.execute 'rm ~/table_data/temp_table_data'
    print 'Formatted sql response to json...'
  end,
}
