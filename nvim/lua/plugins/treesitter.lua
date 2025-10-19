return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"gdscript",
				"lua",
				"go",
				"typescript",
				"python",
				"javascript",
				"markdown",
				"markdown_inline",
			},
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
