return {
  "nvim-treesitter/nvim-treesitter",
  -- run = ":TSUpdate",
  build = ":TSUpdate",
  config = function()
    require 'nvim-treesitter.configs'.setup {
      ensure_installed = { "gdscript", "godot_resource", "gdshader", "c", "lua", "vim", "vimdoc", "go", "python", "rust", "javascript", "typescript" },
      sync_install = true,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
    }
  end
}
