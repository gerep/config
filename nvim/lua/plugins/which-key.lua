return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")
        wk.setup({
            preset = "modern",
        })
        
        wk.add({
            { "<leader>c", group = "Code" },
            { "<leader>f", desc = "Find Files" },
            { "<leader>g", group = "Git/Go" },
            { "<leader>l", group = "Location List" },
            { "<leader>r", group = "Reload/Replace" },
            { "<leader>t", group = "Terminal/Test" },
        })
    end,
}
