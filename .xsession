#!/bin/sh

#
# ~/.xsession
#
# Executed by xdm/gdm/kdm at login
#

# emacs daemon start
emacs --daemon

# mpd daemon start (if no other user instance exists)
[ ! -s ~/.config/mpd/pid ] && mpd ~/.config/mpd/mpd.conf

# urxvt daemon
urxvtd -q -o -f

/bin/bash --login -i ~/.xinitrc

exec i3
