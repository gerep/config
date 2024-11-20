vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.gd",
  callback = function()
    vim.cmd("silent !gdformat --spaces %")
  end,
})
