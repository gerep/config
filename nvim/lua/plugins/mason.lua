return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
			ensure_installed = {
			"gopls",
			"prettier",
			"typescript-language-server",
			"black",
			"pyright",
			"lua-language-server",
			"stylua",
			},
			})
		end,
	},
}
