#!/bin/sh

#
# ~/.xsession
#
# Executed by xdm/gdm/kdm at login
#

# mpd daemon
mpd ~/.config/mpd/mpd.conf

# urxvt daemon
urxvtd -q -o -f

# emacs daemon start
#emacs --daemon

/bin/bash --login -i ~/.xinitrc

exec i3
