local builder = require("config.plugins.lsp.lspbuilder")

local M = {}

function M.setup(capabilities, on_attach)
	builder.build({
		name = "clangd",
		cmd = { "clangd" },
		filetypes = { "c", "cpp", "objc", "objcpp" },
		capabilities = capabilities,
		on_attach = on_attach,
		root_patterns = { "compile_commands.json", ".clangd", ".git" },
		settings = {
			clangd = {},
		},
	})
end

return M
