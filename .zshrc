# Execute when terminal open
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/pure.omp.json)"
fastfetch --config examples/8

# Created by newuser for 5.9
# Credit: https://github.com/dreamsofautonomy/zensh/blob/main/.zshrc

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions 
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^[[A' history-search-backward # Arrow down
bindkey '^[[B' history-search-forward # Arrow up
bindkey '^[w' kill-region # Ctrl + w | clear line

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
#zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Alias
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias f='yazi'
alias fetch='fastfetch'
alias monitor_mode="$HOME/.config/scripts/monitor_mode.sh"
alias syncdot="$HOME/.config/scripts/syncdot.sh"
alias getCurrentWallpaper="$HOME/.config/scripts/get_current_wallpaper.sh"

# Execute when terminal open
eval "$(fzf --zsh)"
eval $(thefuck --alias)

# source /usr/share/nvm/init-nvm.sh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Optional: Loads bash_completion
