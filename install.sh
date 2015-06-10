#!/bin/bash

# refer  spf13-vim bootstrap.sh`
BASEDIR=$(dirname $0)

cd $BASEDIR
CURRENT_DIR=`pwd`

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
}

echo "Step1: backing up current vim config"
today=`date +%Y%m%d`
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc $HOME/.vimrc.bundles; do [ -e $i ] && [ ! -L $i ] && mv $i $i.$today; done
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc $HOME/.vimrc.bundles; do [ -L $i ] && unlink $i ; done

echo "Step2: setting up symlinks"
lnif $CURRENT_DIR/vimrc $HOME/.vimrc
lnif $CURRENT_DIR/vimrc.bundles $HOME/.vimrc.bundles
lnif "$CURRENT_DIR/" "$HOME/.vim"


#vim bk and undo dir
if [ ! -d /tmp/vimbk ]
then
    mkdir -p /tmp/vimbk
fi

if [ ! -d /tmp/vimundo ]
then
    mkdir -p /tmp/vimundo
fi

echo "Install Done!"
