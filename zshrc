# Wayland / Niri session
export XDG_CURRENT_DESKTOP=niri
export XDG_SESSION_DESKTOP=niri
export XDG_SESSION_TYPE=wayland
export MOZ_ENABLE_WAYLAND=1
export ELECTRON_OZONE_PLATFORM_HINT=auto

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt share_history hist_ignore_dups hist_ignore_space

# Basic completion
autoload -Uz compinit
compinit -C

# Key bindings (emacs-style, like oh-my-zsh default)
bindkey -e

# PATH
export PATH=$HOME/go/bin:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/.amp/bin:$HOME/.opencode/bin:/usr/local/go/bin:$HOME/bootdev/emsdk:$HOME/bootdev/emsdk/upstream/emscripten:$PATH

[[ -f ~/.zsh_secrets ]] && source ~/.zsh_secrets

# Editor
export EDITOR=nvim

# NVM (lazy-loaded)
export NVM_DIR="$HOME/.nvm"
function load_nvm() {
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

# Emscripten (lazy-loaded)
function load_emsdk() {
    source $HOME/bootdev/emsdk/emsdk_env.sh
}

# Aliases
alias v=nvim
alias gv="nvim --listen /tmp/godot.pipe"
alias lg="lazygit"
alias ld="lazydocker"
alias mm="mymind"
alias unlockdatagrip="rm ~/.var/app/com.jetbrains.DataGrip/config/JetBrains/DataGrip*/.lock"

# Zoxide
eval "$(zoxide init zsh --cmd cd)"

# Starship prompt
eval "$(starship init zsh)"

# Goose
export GOOSE_MIGRATION_DIR=backend/internal/database/sql/schema
export GOOSE_DBSTRING=postgres://daniel:@localhost:5432/classroom?sslmode=disable
export GOOSE_DRIVER=postgres

# Google Cloud SDK
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# Keys
export MYMIND_VAULT="/home/gerep/me/notes"
