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

FILE=".macos_gitignore"
ln -s $CWD/$FILE $HOME/$FILE
echo "symlinked: ${FILE}"

git config --global core.excludesfile $HOME/$FILE

echo "[Git] Globally ignored: ${HOME}/${FILE}"
