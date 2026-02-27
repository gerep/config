# Force the system to recognize the Niri session
export XDG_CURRENT_DESKTOP=niri
export XDG_SESSION_DESKTOP=niri
export XDG_SESSION_TYPE=wayland

# Optional: If you use GTK apps (like Brave/Obsidian), tell them to use Wayland
export MOZ_ENABLE_WAYLAND=1
export ELECTRON_OZONE_PLATFORM_HINT=auto

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

zstyle ':omz:update' mode auto

plugins=(git)

source $ZSH/oh-my-zsh.sh

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/bootdev/emsdk
export PATH=$PATH:$HOME/bootdev/emsdk/upstream/emscripten
export EDITOR=nvim

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias v=nvim
alias gv="nvim --listen /tmp/godot.pipe"
alias lg="lazygit"
alias ld="lazydocker"

function load_emsdk() {
    source /home/daniel/bootdev/emsdk/emsdk_env.sh
}

eval "$(zoxide init zsh)"

# Goose stuff.
export GOOSE_MIGRATION_DIR=backend/internal/database/sql/schema
export GOOSE_DBSTRING=postgres://daniel:@localhost:5432/classroom?sslmode=disable
export GOOSE_DRIVER=postgres

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/daniel/google-cloud-sdk/path.zsh.inc' ]; then . '/home/daniel/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/daniel/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/daniel/google-cloud-sdk/completion.zsh.inc'; fi

# Amp CLI
export PATH="/home/daniel/.amp/bin:$PATH"

# opencode
export PATH=/home/gerep/.opencode/bin:$PATH

# Datagrip hack
alias unlockdatagrip="rm ~/.var/app/com.jetbrains.DataGrip/config/JetBrains/DataGrip*/.lock"

alias mm="mymind"
export GEMINI_API_KEY=""
export MYMIND_VAULT="/home/gerep/me/notes"
