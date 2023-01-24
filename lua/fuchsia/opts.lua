local fn = vim.fn
local o = vim.opt
local g = vim.g

o.guicursor = ""

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.preserveindent = true

o.swapfile = false
o.backup = false
o.undodir = os.getenv("HOME") .. "/.vim/undodir"
o.undofile = true

o.incsearch = true

o.scrolloff = 8
o.signcolumn = "yes"
o.colorcolumn = "120"

o.wrap = true
o.number = true
o.relativenumber = true
o.termguicolors = true

o.laststatus = 3

o.smartcase = true
o.showtabline = 2

g.highlighturl_enabled = true
g.autoformat_enabled = true
