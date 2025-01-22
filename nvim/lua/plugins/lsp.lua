return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },
  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip', -- Add snippet completion source
      'hrsh7th/cmp-buffer',       -- Add buffer completion
      'hrsh7th/cmp-path',         -- Add path completion
      'hrsh7th/cmp-cmdline',      -- Add command line completion
      'onsails/lspkind.nvim',     -- Add VSCode-like pictograms
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_cmp()

      local cmp = require('cmp')
      local cmp_action = lsp_zero.cmp_action()
      local lspkind = require('lspkind')

      cmp.setup({
        formatting = {
          fields = { cmp.ItemField.Abbr },
          expandable_indicator = true,
          format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '...',
          })
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require('luasnip').expand_or_jumpable() then
              require('luasnip').expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require('luasnip').jumpable(-1) then
              require('luasnip').jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-e>'] = cmp.mapping.abort(), -- Add escape from completion
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        }),
      })

      -- Use buffer source for `/` and `?`
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':'
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
          { name = 'cmdline' }
        })
      })
    end
  },
  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'williamboman/mason-lspconfig.nvim',
      'folke/neodev.nvim', -- Add Lua development support
    },
    config = function()
      -- Setup neodev first
      require('neodev').setup()

      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      -- Enhanced on_attach function
      local on_attach = function(client, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })

        -- Enable inlay hints for supported languages
        if client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(true)
        end

        -- Add format on save if supported
        if client.server_capabilities.documentFormattingProvider then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end

      -- Global LSP settings
      local lsp_defaults = {
        on_attach = on_attach,
        capabilities = vim.tbl_deep_extend(
          'force',
          vim.lsp.protocol.make_client_capabilities(),
          require('cmp_nvim_lsp').default_capabilities()
        ),
        flags = {
          debounce_text_changes = 150,
        }
      }

      require('mason-lspconfig').setup({
        automatic_installation = {},
        ensure_installed = {
          'lua_ls',
          'ts_ls',
          -- 'eslint',
          'gopls',
        },
        handlers = {
          lsp_zero.default_setup,
          tsserver = function()
            require('lspconfig').ts_ls.setup {
              root_dir = require('lspconfig.util').root_pattern('package.json', 'tsconfig.json', 'jsconfig.json'),
              single_file_support = true,
              on_attach = function(client, bufnr)
                lsp_zero.async_autoformat(client, bufnr)
              end
            }
          end,
          eslint = function()
            require('lspconfig').eslint.setup({
              root_dir = require('lspconfig.util').root_pattern('.eslintrc', '.eslintrc.js', '.eslintrc.json'),
              on_attach = function(client, bufnr)
                vim.api.nvim_create_autocmd("BufWritePre", {
                  buffer = bufnr,
                  command = "EslintFixAll",
                })
              end,
            })
          end,
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(vim.tbl_deep_extend('force', lsp_defaults, lua_opts))
          end,
          gopls = function()
            require('lspconfig').gopls.setup(vim.tbl_deep_extend('force', lsp_defaults, {
              settings = {
                gopls = {
                  staticcheck = true,
                  gofumpt = true,
                  analyses = {
                    unusedparams = true,
                    shadow = true,
                    nilness = true,
                    unusedwrite = true,
                    useany = true,
                  },
                  codelenses = {
                    gc_details = true,
                    generate = true,
                    regenerate_cgo = true,
                    tidy = true,
                    upgrade_dependency = true,
                  },
                  usePlaceholders = true,
                  completeUnimported = true,
                  directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                },
              },
            }))
          end,
        }
      })
    end
  }
}
