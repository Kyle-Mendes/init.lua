local M = {
	'nvim-telescope/telescope.nvim', branch = '0.1.x',
	dependencies = {
		{'nvim-lua/plenary.nvim'}
	},
	cmd = { "Telescope", "Tel" }, -- lazy loads on these commands
	keys = { "<leader>f" }, -- lazy loads on this pattern
}

function M.config()
	local telescope = require("telescope")
	telescope.setup({
        defaults = {
            -- prompt_prefix = string.format("%s ", astronvim.get_icon "Search"),
            -- selection_caret = string.format("%s ", astronvim.get_icon "Selected"),
            path_display = { "truncate" },
            sorting_strategy = "ascending",
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    preview_width = 0.55,
                    results_width = 0.8,
                },
                vertical = {
                    mirror = false,
                },
                width = 0.87,
                height = 0.80,
                preview_cutoff = 120,
            },
        },
    })

	local builtin = require('telescope.builtin')
	vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
	vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})
	vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
	vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
	vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
end

return M
