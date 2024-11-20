local api = vim.api
local opts = {
  expandtab = false, -- Use tabs, not spaces
  tabstop = 2,       -- Set tab width to 4
  shiftwidth = 2,    -- Indent with 4 spaces
  softtabstop = 2    -- Align with 4 spaces
}

for k, v in pairs(opts) do
  api.nvim_set_option_value(k, v, { scope = "local" })
end
