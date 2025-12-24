-- opts.lua

local opt = vim.opt
local cmd = vim.api.nvim_command
local g = vim.g

if vim.fn.filereadable("/bin/bash") == 1 then
	opt.shell = "/bin/bash"
elseif vim.fn.executable("bash") == 1 then
	opt.shell = vim.fn.exepath("bash")
else
	vim.notify("Warning: bash not found, falling to /bin/sh", vim.log.levels.WARN)
	opt.shell = "/bin/sh"
end

opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true
opt.smartindent = true
opt.number = true
opt.relativenumber = true
opt.ruler = true
opt.clipboard = "unnamedplus"
opt.expandtab = true
opt.list = true

cmd("set noshowmode")
cmd("abb WQ wq")
cmd("abb Wq wq")

-- theme
g.t_co = 256
g.background = "dark"

opt.syntax = "ON"
opt.termguicolors = true
