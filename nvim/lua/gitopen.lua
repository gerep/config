function GitOpen()
  local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub('\n', '')

  -- Get the root directory of the Git repository
  local gitRoot = vim.fn.system("git rev-parse --show-toplevel"):gsub('\n', '')
  if vim.v.shell_error ~= 0 then
    print("Error finding git repository root.")
    return
  end

  local filePath = vim.fn.expand('%')

  -- Trim the Git root path from the file path to get the relative path
  local relativeFilePath = filePath:sub(#gitRoot + 2) -- +2 to remove the leading '/' as well

  local cursorLine = vim.api.nvim_win_get_cursor(0)[1]
  local pathWithNumber = relativeFilePath .. '#L' .. tostring(cursorLine)

  local cmd = string.format("git open %s %s", branch, pathWithNumber)
  vim.fn.system(cmd)

  -- if it fails, it may be because the branch is not available on the
  -- remote repository. It tries 'main' by default.
  if vim.v.shell_error ~= 0 then
    vim.fn.system(string.format("git open main %s", pathWithNumber))
  end
end

vim.api.nvim_set_keymap('n', '<leader>ho', ":lua GitOpen()<CR>", { noremap = true, silent = true })
