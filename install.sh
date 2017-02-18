#!/bin/sh

CWD="$(pwd)"

FILE=".bash_profile"
ln -s $CWD/$FILE $HOME/$FILE
echo "symlinked: ${FILE}"

FILE=".tmux.conf"
ln -s $CWD/$FILE $HOME/$FILE
echo "symlinked: ${FILE}"

FILE=".vimrc"
ln -s $CWD/$FILE $HOME/$FILE
echo "symlinked: ${FILE}"
