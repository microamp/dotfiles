#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

setxkbmap -option "ctrl:nocaps"

xset +fp /usr/share/fonts/local
xset fp rehash
xset b off

export EDITOR=vim

xrdb -merge ~/.Xresources

xcompmgr -c &

sh ~/.fehbg &

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
exec i3 -V >> ~/.i3/i3log 2>&1
