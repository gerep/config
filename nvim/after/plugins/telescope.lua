return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require('telescope').setup {
            -- Your Telescope-specific configurations
        }

        local telescope_builtin = require('telescope.builtin')
        vim.keymap.set("n", "<leader>f", telescope_builtin.find_files, {})
        vim.keymap.set("n", "<leader>g", telescope_builtin.live_grep, {})
        vim.keymap.set("n", "<leader>b", telescope_builtin.buffers, {})
        vim.keymap.set("n", "<leader>s", telescope_builtin.lsp_document_symbols, {})
        vim.keymap.set("n", "<leader>S", telescope_builtin.lsp_workspace_symbols, {})
        vim.keymap.set("n", "<leader>d", telescope_builtin.diagnostics, {})
    end
}
