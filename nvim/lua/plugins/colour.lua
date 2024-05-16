return {
  {
    --"sainnhe/everforest",
    --"davidosomething/vim-colors-meh",
    --"vonheikemen/rubber-themes.vim",
    --"dikiaap/minimalist",
    --"Marfisc/vorange",
    --"kar9222/minimalist.nvim",
    "rebelot/kanagawa.nvim",
    config = function()
      vim.cmd [[ set background=dark ]]
      --vim.cmd [[ colorscheme everforest ]]
      vim.cmd [[ colorscheme kanagawa-wave ]]
    end
  }
}
