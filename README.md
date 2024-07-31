# My dotfiles

This directory contains the dotfiles for my arch linux system

## Requirements

Ensure you have the following installed on your system

### Git

```
pacman -S git
```

### Stow

```
pacman -S stow
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

to adopt change from the .config use
```
$ stow . -t ~ --adopt
```
