#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# OPAM configuration
. /home/microamp/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# start x at login
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    startx
fi
