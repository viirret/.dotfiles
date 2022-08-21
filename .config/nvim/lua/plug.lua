-- plug.lua

local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn

-- ensure that plugins are installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	os.execute("~/.config/nvim/plugin.sh")
	execute 'packadd packer.nvim'
end

local packer = require'packer'
local util = require'packer.util'

--- startup and add configure plugins
packer.startup(function()
	local use = use
	-- self
	use 'wbthomason/packer.nvim'

	-- code completion
	use { 'VonHeikemen/lsp-zero.nvim',
		requires = {
      		-- LSP Support
		  	{ 'neovim/nvim-lspconfig' },
		  	{ 'williamboman/nvim-lsp-installer' },

		  	-- autocompletion
		  	{ 'hrsh7th/nvim-cmp' },
		  	{ 'hrsh7th/cmp-buffer' },
		  	{ 'hrsh7th/cmp-path' },
			{ 'saadparwaiz1/cmp_luasnip' },
		  	{ 'hrsh7th/cmp-nvim-lsp' },
		  	{ 'hrsh7th/cmp-nvim-lua' },
	    	
			-- snipppets
			{ 'L3MON4D3/LuaSnip' },
    	    { 'rafamadriz/friendly-snippets' },
		}
	  }

	-- Statusline
  	use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }

	-- auto close brackets
	use 'windwp/nvim-autopairs'

  	-- Tabline
  	use {'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'}}

end)


