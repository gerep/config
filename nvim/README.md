# Neovim Configuration

This document outlines the keybindings and important configurations for this Neovim setup.

## Keybindings

### General

*   `<leader>rc`: Reload Neovim configuration
*   `<C-s>`: Save buffer

### Navigation

*   `J` (Visual Mode): Move line down
*   `K` (Visual Mode): Move line up
*   `J` (Normal Mode): Join lines below
*   `<C-d>`: Jump half page down (cursor in middle)
*   `<C-u>`: Jump half page up (cursor in middle)
*   `n`: Next search match (cursor in middle)
*   `N`: Previous search match (cursor in middle)
*   `<M-j>`: Move current line down
*   `<M-k>`: Move current line up

### Telescope (Fuzzy Finder)

*   `<leader>f`: Find files
*   `<leader>/`: Live grep (search by content)
*   `<leader>b`: List open buffers
*   `<leader>s`: Search document symbols
*   `<leader>S`: Search workspace symbols
*   `<leader>k`: Search help tags
*   `<leader>tt`: Fuzzy find in current buffer
*   `*`: Find string under cursor

### Git (Gitsigns & Telescope)

*   `<leader>gF`: Find Git files
*   `<leader>gS`: Git status
*   `[c`: Previous hunk
*   `]c`: Next hunk
*   `<leader>gs`: Stage hunk
*   `<leader>gr`: Reset hunk
*   `<leader>gS`: Stage buffer
*   `<leader>gR`: Reset buffer
*   `<leader>gu`: Undo staged hunk
*   `<leader>gp`: Preview hunk
*   `<leader>gb`: Blame line
*   `<leader>gd`: Diff this
*   `<leader>gD`: Diff this against HEAD

### Diagnostics & LSP

*   `[d`: Go to previous diagnostic
*   `]d`: Go to next diagnostic
*   `<leader>d`: Show diagnostics for current file (Telescope)
*   `<leader>D`: Show diagnostics for all documents (Telescope)
*   `<leader>e`: Show hover diagnostics
*   `<leader>rn`: Rename symbol
*   `<leader>ca`: Code action
*   `<leader>a`: Code action
*   `<C-f>`: Format document

### Other

*   `<leader>o`: Open parent directory (Oil)
*   `<C-c>`: Comment/uncomment line (Normal/Visual mode)
*   `<M-,>`: Resize window left
*   `<M-.>`: Resize window right
*   `<M-t>`: Resize window up
*   `<M-s>`: Resize window down
*   `<esc><esc>` (Terminal Mode): Exit terminal
*   `,st`: Open terminal at bottom
