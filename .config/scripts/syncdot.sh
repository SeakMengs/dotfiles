#!/bin/bash

# Change to the dotfiles directory
cd "$HOME/projects/dotfiles" || { echo "Directory not found: ~/projects/dotfiles"; exit 1; }

# Check if --adopt is passed as an argument
if [ "$1" == "--adopt" ]; then
    # Run stow with the --adopt option which will take changes from the config in the system to this folder.
    stow . -t ~ --adopt
else
    stow . -t ~
fi
