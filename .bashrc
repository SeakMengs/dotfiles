#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Execute when terminal open
eval "$(oh-my-posh init bash --config ~/.config/ohmyposh/pure.omp.json)"
fastfetch --config examples/8

PATH=~/.console-ninja/.bin:$PATH
