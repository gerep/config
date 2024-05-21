return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local data = assert(vim.fn.stdpath "data")
    require('telescope').setup {
      extensions = {
        wrap_results = true,
        fzf = {},
        history = {
          path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
          limit = 100,
        },
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

    vim.keymap.set("n", "<leader>/", telescope_builtin.current_buffer_fuzzy_find, {})

    vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, {})
    vim.keymap.set("n", "<leader>fd", telescope_builtin.find_files, {})
    vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, {})
    vim.keymap.set("n", "<leader>fl", telescope_builtin.lsp_document_symbols, {})

    -- grep
    vim.keymap.set("n", "<leader>fs", telescope_builtin.grep_string, {})
    vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, {})

    -- git
    vim.keymap.set("n", "<leader>gf", telescope_builtin.git_files, {})
    vim.keymap.set("n", "<leader>gs", telescope_builtin.git_status, {})

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
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
  end
}
