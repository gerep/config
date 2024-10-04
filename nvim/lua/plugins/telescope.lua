return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require('telescope').setup {
      extensions = {
        wrap_results = true,
        fzf = {},
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {},
        },
      },
      defaults = {
        file_ignore_patterns = { "vendor/", "node_modules/" },
        path_display = { "truncate" },
      },
    }

    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "smart_history")
    pcall(require("telescope").load_extension, "ui-select")

    local telescope_builtin = require('telescope.builtin')

    vim.keymap.set("n", "<leader>t", telescope_builtin.current_buffer_fuzzy_find, {})

    vim.keymap.set("n", "<leader>b", telescope_builtin.buffers, {})
    vim.keymap.set("n", "<leader>f", telescope_builtin.find_files, {})
    vim.keymap.set("n", "<leader>j", telescope_builtin.jumplist, {})
    vim.keymap.set("n", "<leader>vh", telescope_builtin.help_tags, {})
    vim.keymap.set("n", "<leader>s", telescope_builtin.lsp_document_symbols, {})

    -- grep
    vim.keymap.set("n", "<leader>x", telescope_builtin.grep_string, {})
    vim.keymap.set("n", "<leader>/", telescope_builtin.live_grep, {})

    -- git
    vim.keymap.set("n", "<leader>vf", telescope_builtin.git_files, {})
    vim.keymap.set("n", "<leader>g", telescope_builtin.git_status, {})

    -- diagnostics
    vim.keymap.set("n", "<leader>dd", function()
      telescope_builtin.diagnostics({ bufnr = 0 })
    end)
    vim.keymap.set("n", "<leader>DD", function()
      telescope_builtin.diagnostics()
    end)
    vim.keymap.set("n", "<leader>df", function()
      vim.diagnostic.open_float({ buffer = 0 })
    end)
    vim.keymap.set("n", "gr", telescope_builtin.lsp_references, {})
    vim.keymap.set("n", "gi", telescope_builtin.lsp_implementations, {})
    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, {})
  end
}
