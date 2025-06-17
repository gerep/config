return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" },                       -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken",                            -- Only on MacOS or Linux
        opts = {
            -- See Configuration section for options
        },
        keys = {
            { "<leader>zc", "<cmd>CopilotChat<cr>",        desc = "Copilot Chat" },
            { "<leader>ze", "<cmd>CopilotChatExplain<cr>", desc = "Copilot Chat Explain" },
            { "<leader>zr", "<cmd>CopilotChatReview<cr>",  desc = "Copilot Chat Review" },
            { "<leader>zf", "<cmd>CopilotChatFix<cr>",     desc = "Copilot Chat Fix" },
            { "<leader>zo", "<cmd>CopilotChatOptmize<cr>", desc = "Copilot Chat Optimize" },
            { "<leader>zo", "<cmd>CopilotChatDocs<cr>",    desc = "Copilot Chat Docs" },
            { "<leader>zC", "<cmd>CopilotChatClose<cr>",   desc = "Copilot Chat Close" },
            { "<leader>zR", "<cmd>CopilotChatRefresh<cr>", desc = "Copilot Chat Refresh" },
        },
        config = function()
            require("CopilotChat").setup {
                model = "gemini",
            }
        end
    },
}
