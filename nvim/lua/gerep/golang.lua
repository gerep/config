vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local params = vim.lsp.util.make_range_params(nil, nil, bufnr)
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({async = false, bufnr = bufnr})
  end
})
