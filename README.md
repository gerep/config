# config

# Neovim Configuration

A basic Neovim configuration focused on Go development with TypeScript/Vue support.

## Features

- **LSP Support**: Go (gopls), Lua, TypeScript/JavaScript, Vue
- **Auto-formatting**: On save with proper formatters (goimports, prettierd, eslint)
- **File Navigation**: fzf integration for finding files and searching text
- **Git Integration**: Line-level git changes with gitsigns
- **Note-taking**: Obsidian.nvim integration
- **Syntax Highlighting**: Treesitter for better code highlighting
- **Auto-completion**: nvim-cmp with LSP sources

## Key Mappings

### General

- `<leader>` = `<space>`
- `<leader>pv` - File explorer (netrw)
- `<leader>e` - Toggle Oil file explorer
- `<leader>u` - Toggle undotree

### File Navigation (fzf)

- `<leader>ff` - Find files
- `<leader>fg` - Search text in project
- `<leader>fb` - Switch buffers

### LSP

- `gd` - Go to definition
- `gi` - Go to implementation
- `gr` - Go to references
- `K` - Hover documentation
- `<leader>ca` - Code actions
- `<leader>rn` - Rename symbol
- `<leader>fmt` - Format file manually

### Diagnostics

- `<leader>d` - Show diagnostic in float
- `<leader>q` - Show buffer diagnostics in location list
- `<leader>Q` - Show project diagnostics in quickfix
- `[d` / `]d` - Navigate diagnostics

### Git

- `]c` / `[c` - Navigate git hunks

### Notes (Obsidian)

- `<leader>on` - Create new note
- `<leader>of` - Find notes
- `<leader>os` - Search in notes
- `<leader>ot` - Open today's daily note
- `<leader>ob` - Show backlinks

### Clipboard

- `<leader>y` - Copy to system clipboard (visual mode)
- `<leader>p` - Paste from system clipboard

## Dependencies

### System Packages (Arch Linux)

```bash
sudo pacman -S fzf ripgrep lua-language-server
```

### Go Tools

```bash
go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest
```

### Node.js Tools

```bash
npm install -g typescript-language-server @vue/language-server prettierd eslint
```

### Lua Tools

```bash
# Install stylua for Lua formatting
sudo pacman -S stylua  # if available in AUR
```

### Optional (for better performance)

```bash
# For faster grep in large projects
sudo pacman -S fd  # alternative to find
```

## Notes

- All plugins are automatically installed by lazy.nvim
- Formatting happens automatically on save for supported file types
- LSP servers start automatically when opening supported file types
- Configuration is kept simple and minimal, preferring explicitness over abstraction

```

```
