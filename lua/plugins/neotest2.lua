return {
  'nvim-neotest/neotest',
  dependencies = {
    'haydenmeade/neotest-jest',
  },
  opts = function(_, opts)
    require('neotest').setup {
      opts.adapters,
      table.insert {
        'neotest-plenary',
        require 'neotest-jest' {
          jestCommand = 'npm test --',
          jestConfigFile = 'jest.config.ts',
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        },
      },
    }
  end,
}
