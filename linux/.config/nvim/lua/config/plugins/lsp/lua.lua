-- lua/lsp/lua.lua
local M = {}

local function lua_root(fname)
	local root_util = require("utils.root_dir")
	return root_util.get_root_dir(fname, { "luarc.json", ".git", "init.lua" })
end

function M.setup(capabilities, on_attach)
	vim.lsp.config["lua_ls"] = {
		cmd = { "lua-language-server" },
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "lua" },
		root_dir = lua_root(),
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
			local root = lua_root()

			if #active == 0 then
				vim.lsp.start({
					name = "lua_ls",
					cmd = { "lua-language-server" },
					capabilities = capabilities,
					on_attach = on_attach,
					root_dir = root,
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
