return {
	"stevearc/conform.nvim",
	opts = {},
	version = "v9.0.0",
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				vue = { "prettierd", "eslint" },
				css = { "prettierd" },
				markdown = { "prettierd" },
				python = { "black" },
				lua = { "stylua" },
				c = { "clang-format" },
				ocaml = { "ocamlformat" },
				elixir = { "mix format" },
				go = { "goimports" },
			},
			options = {
				ignore_errors = true,
				formatters_by_ft = {
					json = { "jq" },
				},
			},
		})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				local filetype = vim.bo[args.buf].filetype
				if filetype ~= "sql" then
					require("conform").format({ bufnr = args.buf })
				end
			end,
		})
	end,
}
