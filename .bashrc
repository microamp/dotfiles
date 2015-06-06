#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias i3lock="i3lock -c 5d7f8c"
alias wifi="sudo wifi-menu"
alias down="sudo shutdown -h now"
alias emc="env TERM=xterm-256color emacsclient -t"

archey

# The next line updates PATH for the Google Cloud SDK.
source '/home/microamp/google-cloud-sdk/path.bash.inc'

# The next line enables bash completion for gcloud.
source '/home/microamp/google-cloud-sdk/completion.bash.inc'
