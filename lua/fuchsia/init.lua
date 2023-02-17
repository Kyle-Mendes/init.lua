vim.g.mapleader = " " -- Set this first for Lazy to be happy

require("fuchsia.lazy")
require("fuchsia.remap")
require("fuchsia.opts")

require("lazy").setup("fuchsia.plugins", {
	dev = {
		path = "~/Projects/neovim",
		fallback = false
	}
}) -- Setup our package manager
