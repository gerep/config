return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8', -- Pin to a specific version for stability
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local telescope_builtin = require('telescope.builtin')

            -- General
            vim.keymap.set("n", "<leader>tt", telescope_builtin.current_buffer_fuzzy_find,
                { desc = "[T]elescope buffer fuzzy find" })
            vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, { desc = "[F]ind [B]uffers" })
            vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = "[F]ind [F]iles" })
            vim.keymap.set("n", "<leader>j", telescope_builtin.jumplist, { desc = "[J]umplist" })
            vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, { desc = "[F]ind [H]elp" })
            vim.keymap.set("n", "<leader>fd", telescope_builtin.lsp_document_symbols,
                { desc = "[F]ind [D]ocument Symbols" })

            -- Grep
            vim.keymap.set("n", "<leader>fs", telescope_builtin.grep_string, { desc = "[F]ind [S]tring" })
            vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, { desc = "[F]ind by [G]rep" })

            -- Git
            vim.keymap.set("n", "<leader>gf", telescope_builtin.git_files, { desc = "[G]it [F]iles" })
            vim.keymap.set("n", "<leader>gs", telescope_builtin.git_status, { desc = "[G]it [S]tatus" })

            -- Diagnostics and LSP
            vim.keymap.set("n", "<leader>dd", function()
                telescope_builtin.diagnostics({ bufnr = 0 })
            end, { desc = "[D]iagnostics for current [D]ocument" })
            vim.keymap.set("n", "<leader>DD", function()
                telescope_builtin.diagnostics()
            end, { desc = "[D]iagnostics for all [D]ocuments" })

            -- Note: You have 'gr' mapped here and also in your lsp.lua. You should choose one.
            vim.keymap.set("n", "gr", telescope_builtin.lsp_references, { desc = "[G]oto [R]eferences (Telescope)" })
            vim.keymap.set("n", "gi", telescope_builtin.lsp_implementations, { desc = "[G]oto [I]mplementation" })
            vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { desc = "Code [A]ction" })
        end
    },
    -- It's good practice to also explicitly include dependencies
    {
        'nvim-lua/plenary.nvim'
    },
}
