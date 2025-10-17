local M = {}

local servers = {
	"gopls",
	"ts_ls",
	"pyright",
	"lua_ls",
}

function M.setup()
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local opts = { buffer = args.buf }
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

			vim.keymap.set("n", "<leader>db", "<cmd>Telescope diagnostics bufnr=0<cr>", opts)
			vim.keymap.set("n", "<leader>dw", "<cmd>Telescope diagnostics<cr>", opts)
			vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, opts)
			vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, opts)
			vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, opts)
		end,
	})

	for _, server in ipairs(servers) do
		local config = require("lsp." .. server)
		vim.lsp.config(server, config)
	end

	vim.lsp.enable(servers)
end

return M
