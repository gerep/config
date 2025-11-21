# Neovim Configuration Agent

This agent helps manage and customize your Neovim configuration.

## Commands

### Add Plugin
Add a new plugin to your Neovim setup using lazy.nvim.

**Usage:** `add-plugin <plugin-name> [--opts <options>]`

**Examples:**
- `add-plugin nvim-tree` - Add the nvim-tree file explorer
- `add-plugin which-key --opts { "event": "VeryLazy" }` - Add which-key with options

### Configure LSP
Configure a new LSP server for a language.

**Usage:** `configure-lsp <language> <server-name>`

**Examples:**
- `configure-lsp python pyright` - Configure Python LSP with pyright
- `configure-lsp typescript tsserver` - Configure TypeScript LSP

### Add Keymap
Add a new key mapping to your configuration.

**Usage:** `add-keymap <mode> <key> <command> [--desc <description>]`

**Examples:**
- `add-keymap n <leader>ff ":Telescope find_files<CR>" --desc "Find files"`
- `add-keymap i jk "<Esc>" --desc "Escape insert mode"`

### Set Option
Set a Neovim option in your configuration.

**Usage:** `set-option <option> <value> [--scope <scope>]`

**Examples:**
- `set-option tabstop 2` - Set tabstop to 2
- `set-option relativenumber true --scope opt` - Enable relative line numbers

### Install Theme
Install and configure a new color theme.

**Usage:** `install-theme <theme-name>`

**Examples:**
- `install-theme tokyonight` - Install Tokyonight theme
- `install-theme catppuccin` - Install Catppuccin theme

## File Structure

- `init.lua` - Main configuration file
- `lua/plugins/` - Plugin configurations
- `lua/lsp/` - LSP configurations
- `lazy-lock.json` - Plugin lockfile

## Common Tasks

- To add a new plugin: Use `add-plugin` command
- To configure LSP: Use `configure-lsp` command
- To add keybindings: Use `add-keymap` command
- To change settings: Use `set-option` command
