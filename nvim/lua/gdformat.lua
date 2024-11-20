vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.gd",
  callback = function()
    -- Execute gdformat on the current file
    vim.cmd("silent !gdformat %")
  end,
})
