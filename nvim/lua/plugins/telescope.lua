return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")

        telescope.setup({
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--glob=!vendor",
                },
            },
            pickers = {
                find_files = {
                    find_command = { "fd", "--exclude", "vendor" },
                },
            },
        })

        vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find files" })
        vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Grep workspace" })
        vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Buffers" })
        vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Help tags" })
        vim.keymap.set("n", "<leader>s", builtin.grep_string, { desc = "Find string under cursor" })
        vim.keymap.set("n", "<leader>?", builtin.commands, { desc = "Find commands" })
        vim.keymap.set("n", "<leader>k", builtin.keymaps, { desc = "Find keymaps" })
        vim.keymap.set("n", "<leader>o", builtin.oldfiles, { desc = "Find recent files" })
        vim.keymap.set("n", "<leader>t", builtin.treesitter, { desc = "Find treesitter symbols (functions, etc.)" })
        vim.keymap.set("n", "<leader>gt", builtin.git_status, { desc = "Git status (modified, staged, untracked files)" })
    end,
}
