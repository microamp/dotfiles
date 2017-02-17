#!/bin/sh

archey

alias la="ls -a"
alias ll="ls -l"
alias lla="ls -la"

export GOPATH=/Users/microamp/src/go
export GOBIN=$GOPATH/bin

export PATH=$PATH:$GOBIN
