-- return {
--     "rebelot/kanagawa.nvim",
--     priority = 1000,
--     lazy = false,
--     config = function()
--         vim.cmd.colorscheme("kanagawa-dragon")
--     end,
-- }

return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        vim.cmd.colorscheme("catppuccin-mocha")
    end,
}
