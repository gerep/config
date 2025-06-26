return {
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nordic").load()
		end,
	},
	-- {
	--     'catppuccin/nvim',
	--     priority = 1000, -- Make sure this loads first
	--     config = function()
	--         vim.cmd.colorscheme('catppuccin-mocha')
	--     end,
	-- },
}
