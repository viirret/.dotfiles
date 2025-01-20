local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.nvim_workspace()
lsp.setup()

--local lspconfig = require('lspconfig')
--lspconfig.clangd.setup {
--    cmd = {"clangd", "--header-insertion=never"},
--}
