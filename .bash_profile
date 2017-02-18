#!/bin/sh

alias la="ls -a"
alias ll="ls -l"
alias lla="ls -la"

export GOPATH=/Users/microamp/src/go
export GOBIN=$GOPATH/bin

export PATH=$PATH:$GOBIN

# After installing `bash_completion`
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# Run `git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell` for installation
# (See https://github.com/chriskempson/base16-shell for more details)
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

base16_grayscale-light

archey
