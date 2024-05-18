# notes

To be able to search through all the notes, it requires: [ripgrep](https://github.com/BurntSushi/ripgrep) and [fzf](https://github.com/junegunn/fzf).

Add this alias to your bash profile:

```bash
alias rgnotes="rg --no-heading --line-number '' $HOME/notes | fzf --preview 'batcat --style=numbers --color=always --line-range :500 {1}' --delimiter ':' --bind 'enter:execute(nvim {1} +{2})'"
```
