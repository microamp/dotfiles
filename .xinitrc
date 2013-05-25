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

xrdb -merge ~/.Xresources

#xcompmgr -c &
compton &

urxvtd -q -o -f  # urxvt daemon for session use

sh ~/.fehbg &

export EDITOR=vim

# map caps to ctrl
setxkbmap -option "ctrl:nocaps"
# swap pgup and pddn around
xmodmap -e "keycode 112 = Next"
xmodmap -e "keycode 117 = Prior"
# disable touchpad
xinput --set-prop "SynPS/2 Synaptics TouchPad" "Device Enabled" 0

xset +fp /usr/share/fonts/local
xset fp rehash
xset b off

# screen powersave
xset +dpms
xset dpms 0 0 300

# powerdown: automatic load
upower -e

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
#exec i3 -V >> ~/.i3/i3log 2>&1
exec i3
