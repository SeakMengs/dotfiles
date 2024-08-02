# My dotfiles

This directory contains the dotfiles for my arch linux system

## Requirements

Ensure you have the following installed on your system (Not necessary mean u need those, these are for me to copy paste if i ever need to fresh install my system)

```
pacman -S git hyprland kitty thunar waybar stow nvim hyprpaper zsh fastfetch snapper btrfs-assistant pipewire pipewire-alsa pipewire-pulse pavucontrol sof-firmware ttf-font-awesome ttf-liberation ttf-cascadia-code-nerd ttf-firacode-nerd ttf-jetbrains-mono-nerd
```

```
yay -S system76-power pywal-16-colors
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```
$ git clone https://github.com/SeakMengs/dotfiles.git
$ cd dotfiles
```

then use GNU stow to create symlinks

```
$ stow . -t ~
```

to unlink the created symlinks
```
$ stow -D . -t ~
```

to adopt change from the dotfiles that already exist in your system, use
```
$ stow . -t ~ --adopt
```

## Notes

In `.config/hypr/hyprpaper.conf` change `/home/yato/` to `/home/your-username/`