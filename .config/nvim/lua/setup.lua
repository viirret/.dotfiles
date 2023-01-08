
-- setup.lua
-- Plugin specific setup 

require('nvim-autopairs').setup()
require('lualine').setup()


-- Tabline configuration
vim.api.nvim_create_autocmd('BufWinEnter', {
	pattern = '*',
	callback = function()
		if vim.bo.filetype == 'NvimTree' then
			require'bufferline.state'.set_offset(31, 'FileTree')
		end
	end
})
vim.api.nvim_create_autocmd('BufWinLeave', {
	pattern = '*',
	callback = function()
		if vim.fn.expand('<afile>'):match('NvimTree') then
			require'bufferline.state'.set_offset(0)
		end
	end
})


require("nvim-treesitter.configs").setup {
  highlight = {
      -- ...
  },
  -- ...
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}

