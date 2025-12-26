-- lua/lsp/lua.lua
local M = {}

function M.setup(capabilities, on_attach)
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
end

return M
