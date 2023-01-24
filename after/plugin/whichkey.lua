local wk = require("which-key")

wk.register({
	f = {
		name = "file",
		f = "find files",
		b = "find buffers",
		w = "grep files",
		h = "find help tags",
        o = "find old files"
	},
    g = {
        b = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle showing git blame" },
        d = "LSP - Definition",
        r = "LSP - References",
        l = {
            c = {"<cmd>GH<cr>", 'Copy Link GH for selection'}
        },
    },
    p = {
        v = "open file explorer",
    },
    l = {
        a = "LSP - Code Actions",
        r = {
            n = "LSP - Rename",
        },
    },
}, { prefix = "<leader>"} )
