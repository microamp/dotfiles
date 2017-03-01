#!/bin/sh

alias la="ls -a"
alias ll="ls -l"
alias lla="ls -la"

export PATH=$PATH:$HOME/bin

export GOPATH=/Users/microamp/src/go
export GOBIN=$GOPATH/bin

export PATH=$PATH:$GOBIN

# After installing `bash_completion`
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# Run `git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell` for installation (https://github.com/chriskempson/base16-shell)
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

base16_grayscale-light

# Git-aware prompt (https://github.com/jimeh/git-aware-prompt)
export GITAWAREPROMPT=$HOME/src/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"
export PS1="\u@\h \W \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "
export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "

# Auto-completion with `hub` (https://github.com/github/hub)
if [ -f $HOME/bin/hub.bash_completion.sh ]; then
    . $HOME/bin/hub.bash_completion.sh
fi

archey

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
