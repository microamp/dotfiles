#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

#set -o vi
set -o emacs

alias i3lock="i3lock -c 5d7f8c"
alias wifi="sudo wifi-menu"
alias down="sudo shutdown -h now"
alias emacs="emacs -nw"

archey
