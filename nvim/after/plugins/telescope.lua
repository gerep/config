return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require('telescope').setup{
			-- Your Telescope-specific configurations
		}

		-- Optional: Telescope keymaps
		local telescope_builtin = require('telescope.builtin')
		vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, {})
		vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, {})
		-- Additional keymaps...
	end
}
