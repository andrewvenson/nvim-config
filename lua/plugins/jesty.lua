local prettier = require 'plugins.prettier'

return {
  jest = function()
    local fp = vim.fn.expand '%:p' -- gives full path of file
    os.execute('cat ~/code/test.ts > ' .. fp)
    prettier.pretty()
    vim.cmd 'edit'
  end,
}
