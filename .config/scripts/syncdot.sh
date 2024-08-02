#!/bin/bash

# Change to the dotfiles directory
cd $HOME/projects/dotfiles || { echo "Directory not found: ~/projects/dotfiles"; exit 1; }

# Run stow with the specified target
stow . -t ~
