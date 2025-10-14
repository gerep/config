-- lua/plugins/formatting.lua
return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" }, -- Lazy-load on save attempt
	config = function()
		require("conform").setup({
			-- Define the list of formatters for each filetype
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "goimports" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				-- Run two formatters sequentially for Python: sort imports then format code
				python = { "isort", "black" },
				vue = { "prettierd", "eslint" },
				css = { "prettierd" },
				markdown = { "prettierd" },
				gdscript = { "gdformat" },
			},

			-- Mandatory: Format automatically before writing to disk
			format_on_save = {
				lsp_format = "fallback", -- Use LSP formatting if no external tool is defined/found
				timeout_ms = 500, -- Don't block Neovim for too long
				async = false, -- Crucial for synchronous format on write (especially `:wq`)
			},
		})

		-- OPTIONAL: Keymap for explicit formatting
		vim.keymap.set({ "n", "v" }, "<leader>fm", function()
			require("conform").format({ async = true, lsp_format = "fallback" })
		end, { desc = "Format file/selection" })
	end,
}
