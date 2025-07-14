-- opts.lua

local opt = vim.opt
local cmd = vim.api.nvim_command
local g = vim.g

opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true
opt.smartindent = true
opt.number = true
opt.relativenumber = true
opt.ruler = true
opt.clipboard = 'unnamedplus'
opt.shell = '/bin/bash'
opt.expandtab = true
opt.list = true

cmd "set noshowmode"
cmd "abb WQ wq"
cmd "abb Wq wq"

-- theme
g.t_co = 256
g.background = "dark"

opt.syntax = "ON"
opt.termguicolors = true
