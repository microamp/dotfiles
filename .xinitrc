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

sh ~/.fehbg &

# map caps to ctrl, rctrl to ralt (thinkpad x230), rwin to alt (filco)
setxkbmap -option "ctrl:nocaps, ctrl:rctrl_ralt, altwin:alt_super_win"

# thinkpad x230: swap pgup and pddn around
xmodmap -e "keycode 112 = Next"
xmodmap -e "keycode 117 = Prior"
# thinkpad x230: disable touchpad
xinput --set-prop "SynPS/2 Synaptics TouchPad" "Device Enabled" 0

xset +fp /usr/share/fonts/local
xset fp rehash
xset b off

# screen powersave
xset +dpms
xset dpms 0 0 300

# mpd daemon
mpd ~/.config/mpd/mpd.conf

# urxvt daemon
urxvtd -q -o -f

exec i3
