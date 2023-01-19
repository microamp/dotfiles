# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# man xkeyboard-config
# 1. CapsLock as Ctrl
# 2. Right Ctrl as Right Alt
# gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier', 'altwin:swap_lalt_lwin', 'ctrl:rctrl_ralt']"
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier', 'ctrl:rctrl_ralt']"

# dependency: gammastep
# gammastep -b 0.9:0.7 -l -36.848461:174.763336 &

# https://sr.ht/~kennylevinsen/wlsunset/
# wlsunset -l 36.8509 -L 174.7645

# echo 8250 > /sys/class/backlight/intel_backlight/brightness

# enable forward search (C-s) in terminals
# stty -ixon
. "$HOME/.cargo/env"
