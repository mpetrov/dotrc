#!/bin/bash

PREFIX=`pwd`

ROOT=~

BACKUP=${ROOT}/.backup`date +%s`
VIMRC=${ROOT}/.vimrc
DOTVIM=${ROOT}/.vim
ZSHRC=${ROOT}/.zshrc
SCREENRC=${ROOT}/.screenrc

git submodule init
git submodule update

mkdir -p ${BACKUP}
mv -f ${VIMRC} ${BACKUP} 2> /dev/null
mv -f ${ZSHRC} ${BACKUP} 2> /dev/null
mv -f ${DOTVIM} ${BACKUP} 2> /dev/null
mv -f ${SCREENRC} ${BACKUP} 2> /dev/null

ln -s ${PREFIX}/rc.vim ${VIMRC}
ln -s ${PREFIX}/vim ${DOTVIM} 
ln -s ${PREFIX}/rc.zsh ${ZSHRC} 
ln -s ${PREFIX}/rc.screen ${SCREENRC} 

pushd ~/.vim/bundle/vim-command-t
rake make 
popd

