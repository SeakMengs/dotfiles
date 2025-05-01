#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Alias
alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
alias f='yazi'
alias fetch='fastfetch'
alias monitor_mode="$HOME/.config/scripts/monitor_mode.sh"
alias syncdot="$HOME/.config/scripts/syncdot.sh"
alias getCurrentWallpaper="$HOME/.config/scripts/get_current_wallpaper.sh"

# Execute when terminal open
eval "$(oh-my-posh init bash --config ~/.config/ohmyposh/pure.omp.json)"
fastfetch --config examples/8

# source /usr/share/nvm/init-nvm.sh
