return {
	"stevearc/oil.nvim",
	dependencies = {
		{ "echasnovski/mini.icons", opts = {} },
	},
	lazy = false,
	config = function()
		require("oil").setup({
			float = {
				padding = 2,
				max_width = 90,
				max_height = 30,
				border = "rounded",
			},
		})
		vim.keymap.set("n", "<leader>o", function()
			require("oil").toggle_float()
		end, { desc = "Toggle Oil" })
	end,
}
