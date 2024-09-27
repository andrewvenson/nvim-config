return {
  pretty = function()
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
  end,
}
