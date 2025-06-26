return {
	-- This first line is the plugin's name. It's crucial.
	"nvim-treesitter/nvim-treesitter",

	-- The rest of the configuration for this plugin
	build = ":TSUpdate",
	config = function()
		-- The line that was previously failing
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query", -- Base languages
				"go",
				"gdscript",
				"typescript",
				"vue", -- Your languages
			},
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
			},
			modules = {},
			ignore_install = {},
		})
	end,
}
