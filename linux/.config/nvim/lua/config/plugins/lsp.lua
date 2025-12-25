return {
	"williamboman/mason.nvim",
	dependencies = { "williamboman/mason-lspconfig.nvim" },
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {},
			automatic_installation = true,
		})
		local fn = vim.fn
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- ==========================
		-- clangd
		-- ==========================
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

			local clangd = fn.exepath("clangd")
			if clangd ~= "" then
				return clangd
			end

			-- Mason managed clangd
			local mason_clangd = fn.stdpath("data") .. "/mason/bin/clangd"
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

		-- ==========================
		-- Python
		-- ==========================
		vim.lsp.config["pylsp"] = {
			cmd = { "pylsp" },
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "python" },
			settings = {
				pylsp = {
					plugins = {
						pyflakes = { enabled = true },
						pycodestyle = { enabled = true },
						black = { enabled = false },
						ruff = { enabled = true },
						pylsp_mypy = { enabled = false },
					},
				},
			},
		}

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "python" },
			callback = function(args)
				local active = vim.lsp.get_clients({ bufnr = args.buf, name = "pylsp" })
				if #active == 0 then
					vim.lsp.start({
						name = "pylsp",
						cmd = { "pylsp" },
						capabilities = capabilities,
						on_attach = on_attach,
						root_dir = vim.fs.dirname(
							vim.fs.find({ "pyproject.toml", "setup.py", ".git" }, { upward = true, path = args.file })[1]
						),
					})
				end
			end,
		})

		-- ==========================
		-- Lua
		-- ==========================
		vim.lsp.config["lua_ls"] = {
			cmd = { "lua-language-server" },
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "lua" },
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" }, -- recognize the `vim` global
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false, -- don’t warn about “unknown” globals
					},
					telemetry = { enable = false },
				},
			},
		}

		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "lua" },
			callback = function(args)
				local active = vim.lsp.get_clients({ bufnr = args.buf, name = "lua_ls" })
				if #active == 0 then
					vim.lsp.start({
						name = "lua_ls",
						cmd = { "lua-language-server" },
						capabilities = capabilities,
						on_attach = on_attach,
						root_dir = vim.fs.dirname(
							vim.fs.find({ ".luarc.json", ".git" }, { upward = true, path = args.file })[1]
						),
						settings = {
							Lua = {
								runtime = { version = "LuaJIT" },
								diagnostics = { globals = { "vim" } },
								workspace = {
									library = vim.api.nvim_get_runtime_file("", true),
									checkThirdParty = false,
								},
								telemetry = { enable = false },
							},
						},
					})
				end
			end,
		})
	end,
}
