return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require('telescope').setup {
      defaults = {
        file_ignore_patterns = { "vendor/", "node_modules/" }
      },
    }

    local telescope_builtin = require('telescope.builtin')
    vim.keymap.set("n", "<leader>f", telescope_builtin.find_files, {})
    vim.keymap.set("n", "<leader>gf", telescope_builtin.git_files, {})
    vim.keymap.set("n", "<leader>gl", telescope_builtin.live_grep, {})
    vim.keymap.set("n", "<leader>gg", telescope_builtin.grep_string, {})
    vim.keymap.set("n", "<leader>b", telescope_builtin.buffers, {})
    vim.keymap.set("n", "<leader>s", telescope_builtin.lsp_document_symbols, {})
    vim.keymap.set("n", "<leader>d", function()
      telescope_builtin.diagnostics({ bufnr = 0 })
    end)
    vim.keymap.set("n", "<leader>D", function()
      telescope_builtin.diagnostics()
    end)
    vim.keymap.set("n", "gr", telescope_builtin.lsp_references, {})
    vim.keymap.set("n", "gi", telescope_builtin.lsp_implementations, {})
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

    vim.api.nvim_create_autocmd("VimEnter", {
      pattern = "*",
      callback = function()
        telescope_builtin.find_files()
      end
    })
  end
}
