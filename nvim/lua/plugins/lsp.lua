return {
	"neovim/nvim-lspconfig",
	ft = { "go", "gdscript" },

	config = function()
		require("plugins.lsp.setup")
	end,
}
