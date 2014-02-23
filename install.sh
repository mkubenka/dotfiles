#!/usr/bin/env sh

dotfiles="$HOME/.dotfiles"

# to error out
warn() {
  echo "$1" >&2
}

die() {
  warn "$1"
  exit 1
}

lnif() {
  if [ ! -e $2 ] ; then
    ln -s $1 $2
  fi
}

echo "Installing/Updating dotfiles...\n"

if [ ! -e $dotfiles/.git ]; then
  echo "Cloning dotfiles\n"
  git clone https://github.com/mkubenka/dotfiles.git $dotfiles
else
  echo "Updating dotfiles\n"
  cd $dotfiles && git pull
fi

# bash
# echo "Setting up bash...\n"
# lnif $dotfiles/bash_profile $HOME/.bash_profile
# lnif $dotfiles/bashrc $HOME/.bashrc
# lnif $dotfiles/bash $HOME/.bash

# screen
echo "Setting up screen...\n"
lnif $dotfiles/screenrc $HOME/.screenrc

# vim
echo "Setting up vim...\n"
lnif $dotfiles/vimrc $HOME/.vimrc
lnif $dotfiles/vimrc.bundles $HOME/.vimrc.bundles
lnif $dotfiles/vim $HOME/.vim

# vim vundle
if [ ! -d $dotfiles/vim/bundle ]; then
    mkdir -p $dotfiles/vim/bundle
fi

if [ ! -e $dotfiles/vim/bundle/vundle ]; then
  echo "Installing vundle"
  git clone http://github.com/gmarik/vundle.git $dotfiles/vim/bundle/vundle
fi

echo "Update/Install plugins using vundle"
vim -u $dotfiles/vimrc.bundles +BundleInstall! +BundleClean +qall