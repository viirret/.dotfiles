-- plug.lua

local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn

-- Ensure lazy.nvim is installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configure lazy.nvim
require("lazy").setup({
  -- LSP and completion
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = 'v2.x',
    dependencies = {
      {'neovim/nvim-lspconfig'},             -- Core LSP
      {'williamboman/mason.nvim'},           -- LSP server manager
      {'williamboman/mason-lspconfig.nvim'}, -- Bridges Mason and lspconfig
      {'hrsh7th/nvim-cmp'},                  -- Autocompletion
      {'hrsh7th/cmp-nvim-lsp'},              -- LSP source for nvim-cmp
      {'hrsh7th/cmp-buffer'},                -- Buffer completion source
      {'hrsh7th/cmp-path'},                  -- Path completion source
      {'L3MON4D3/LuaSnip'},                  -- Snippet engine
      {'saadparwaiz1/cmp_luasnip'},          -- LuaSnip source for nvim-cmp
    },
    config = function()
      local lsp = require('lsp-zero')

      -- Basic LSP setup
      lsp.extend_lspconfig()

      -- Ensure Mason is set up for managing servers
      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = {},
        automatic_installation = false
      })

      -- Set up keymaps for LSP features
      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)             -- Go to definition
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)            -- Go to declaration
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)                   -- Show documentation
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)         -- Rename symbol
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)    -- Code actions
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)         -- Show diagnostics
      end

      local lspconfig = require('lspconfig')

      -- Clangd
      lspconfig.clangd.setup({
        cmd = { "clangd", "--header-insertion=never" },
        on_attach = on_attach
      })

      -- Omnisharp (C#)
      lspconfig.omnisharp.setup({
          on_attach = on_attach
      })

      -- Pylsp
      lspconfig.pylsp.setup({
        on_attach = on_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
        settings = {
          pylsp = {
            plugins = {
              pycodestyle = { enabled = true },
              pyflakes = { enabled = true },
              pylint = { enabled = false },
              autopep8 = { enabled = false }
            }
          }
        }
     })

      -- Setup nvim-cmp for autocompletion
      local cmp = require('cmp')
      local cmp_select = { behavior = cmp.SelectBehavior.Select }
      local cmp_mappings = lsp.defaults.cmp_mappings({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      })

      -- nvim-cmp sources
      cmp.setup({
        mapping = cmp_mappings,
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'luasnip' },
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
      })

      -- Finalize LSP configuration
      lsp.setup()
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
        require('telescope').load_extension('file_browser')
    end
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = nil,
        },
      })
    end,
  },
  { "p00f/nvim-ts-rainbow" },

  -- UI Enhancements
  "nvim-tree/nvim-web-devicons",
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup()
    end,
  },
  { "romgrk/barbar.nvim" },

  -- Codedark theme
  {
    "tomasiser/vim-code-dark",
    config = function()
      vim.cmd("colorscheme codedark")
    end,
  },

  {
    'windwp/nvim-autopairs',
    opts = {}
  },

  -- lualine
  {
    'nvim-lualine/lualine.nvim',
    config = function()
        require("lualine").setup({
          options = {
            theme = 'auto',
            section_separators = { left = '', right = '' },
            component_separators = { left = '', right = '' }
        }
    })
    end,
  },

  -- nvim-treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
      },
      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil
      }
    }
  },

  -- Utilities
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

})


