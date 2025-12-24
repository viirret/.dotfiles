-- plug.lua

local fn = vim.fn

-- Ensure lazy.nvim is installed
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	fn.system({
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

	---------------------------------------------------------------------------
	-- Mason + LSP
	---------------------------------------------------------------------------
	{
		"williamboman/mason.nvim",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {},
				automatic_installation = true,
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local function detect_clangd()
				-- Detect if running NixOs
				local is_nixos = vim.loop.fs_stat("/etc/NIXOS") ~= nil

				if is_nixos then
					local user_clangd = "/etc/profiles/per-user/" .. os.getenv("USER") .. "/bin/clangd"
					if vim.loop.fs_stat(user_clangd) then
						return user_clangd
					end

					local nix_system_clangd = "/run/current-system/sw/bin/clangd"
					if vim.loop.fs_stat(nix_system_clangd) then
						return nix_system_clangd
					end
				end

				local clangd = vim.fn.exepath("clangd")
				if clangd ~= "" then
					return clangd
				end

				-- Mason managed clangd
				local mason_clangd = vim.fn.stdpath("data") .. "/mason/bin/clangd"
				if vim.loop.fs_stat(mason_clangd) then
					return mason_clangd
				end

				vim.notify("[LSP] clangd not found in PATH or Nix profiles!", vim.log.levels.ERROR)
				return nil
			end

			local clangd_bin = detect_clangd()
			if not clangd_bin then
				vim.notify("Clangd not found", vim.log.levels.ERROR)
				return
			end

			vim.notify("Using clangd from: " .. clangd_bin)

			local function detect_gcc_includes()
				local version = fn.systemlist("gcc -dumpversion")[1] or ""
				local machine = fn.systemlist("gcc -dumpmachine")[1] or ""
				local base = fn.systemlist("dirname $(gcc -print-file-name=include)")[1] or ""
				local paths = {
					"/usr/include/c++/" .. version,
					"/usr/include/c++" .. version .. "/" .. machine,
					base .. "/c++/" .. version,
					base .. "/c++/" .. version .. "/" .. machine,
				}
				local include_flags = { "--header-insertion=never" }
				for _, p in ipairs(paths) do
					if fn.isdirectory(p) == 1 then
						table.insert(include_flags, "-isystem")
						table.insert(include_flags, p)
					end
				end
				return include_flags
			end

			local on_attach = require("keys.on_attach").on_attach

			-- Define and enable clangd.
			vim.lsp.config["clangd"] = {
				cmd = vim.list_extend({ clangd_bin }, detect_gcc_includes()),
				capabilities = capabilities,
				on_attach = on_attach,
				root_markers = { "compile_commands.json", ".git" },
				filetypes = { "c", "cpp", "objc", "objcpp", "ixx" },
			}

			-- Automatically start clangd for C/C++ buffers
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "c", "cpp", "objc", "objcpp", "ixx", "hpp", "hh" },
				callback = function(args)
					local active = vim.lsp.get_clients({ bufnr = args.buf, name = "clangd" })
					if #active == 0 then
						vim.lsp.start({
							name = "clangd",
							cmd = vim.list_extend({ clangd_bin }, detect_gcc_includes()),
							capabilities = capabilities,
							on_attach = on_attach,
							root_dir = vim.fs.dirname(
								vim.fs.find({ "compile_commands.json", ".git" }, { upward = true, path = args.file })[1]
							),
						})
					end
				end,
			})
		end,
	},

	---------------------------------------------------------------------------
	-- nvim-cmp
	---------------------------------------------------------------------------
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local cmp_keys = require("keys.get_mappings")
			local mappings = cmp_keys.get_mappings()

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = mappings,
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "luasnip" },
				}),
			})
		end,
	},

	---------------------------------------------------------------------------
	-- Telescope
	---------------------------------------------------------------------------
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-file-browser.nvim",
		},
		config = function()
			require("telescope").load_extension("file_browser")
			require("keys.telescope")
		end,
	},

	---------------------------------------------------------------------------
	-- UI / Extras
	---------------------------------------------------------------------------
	"nvim-tree/nvim-web-devicons",
	"romgrk/barbar.nvim",
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({ options = { theme = "auto" } })
		end,
	},
	{
		"tomasiser/vim-code-dark",
		config = function()
			vim.cmd("colorscheme codedark")
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	{ "nvim-treesitter/nvim-treesitter" },
})
