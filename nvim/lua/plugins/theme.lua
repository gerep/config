return {
	-- {
	-- 	"AlexvZyl/nordic.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("nordic").load()
	-- 	end,
	-- },
	-- {
	-- 	"catppuccin/nvim",
	-- 	priority = 1000, -- Make sure this loads first
	-- 	config = function()
	-- 		vim.cmd.colorscheme("catppuccin-mocha")
	-- 	end,
	-- },
	{
		"kar9222/minimalist.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("minimalist")
		end,
	},
	-- {
	-- 	"rektrex/micro.vim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd.colorscheme("micro")
	-- 	end,
	-- },
	-- {
	-- 	"rebelot/kanagawa.nvim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd.colorscheme("kanagawa")
	-- 	end,
	-- },
}
