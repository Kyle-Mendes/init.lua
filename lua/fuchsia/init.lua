vim.g.mapleader = " " -- Set this first for Lazy to be happy

require("fuchsia.lazy")
require("fuchsia.remap")
require("fuchsia.opts")

require("lazy").setup("fuchsia.plugins", opts) -- Setup our package manager
