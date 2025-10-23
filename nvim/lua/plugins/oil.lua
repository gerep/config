return {
    "stevearc/oil.nvim",
    dependencies = {
        { "echasnovski/mini.icons", opts = {} },
    },
    lazy = false,
    config = function()
        require("oil").setup({
            view_options = {
                show_hidden = true,
            },
            float = {
                padding = 2,
                max_width = 90,
                max_height = 30,
                border = "rounded",
                win_options = {
                    winblend = 20,
                },
                preview_split = "right",
            },
        })

        vim.keymap.set("n", "<leader>-", function()
            require("oil").toggle_float()
        end, { desc = "Toggle Oil" })
    end,
}
