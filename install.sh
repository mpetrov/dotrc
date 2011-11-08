#!/bin/bash

PREFIX=`pwd`

ROOT=~

VIMRC=${ROOT}/.vimrc
DOTVIM=${ROOT}/.vim
ZSHRC=${ROOT}/.zshrc
SCREENRC=${ROOT}/.screenrc

git submodule init
git submodule update

ln -s ${PREFIX}/submodules/vim-command-t ${PREFIX}/vim/bundle/  || echo "symlink exists"
ln -s ${PREFIX}/submodules/vim-supertab ${PREFIX}/vim/bundle/  || echo "symlink exists"
ln -s ${PREFIX}/submodules/vim-snipmate ${PREFIX}/vim/bundle/  || echo "symlink exists"
ln -s ${PREFIX}/submodules/vim-pathogen/autoload ${PREFIX}/vim/  || echo "symlink exists"

ln -s ${PREFIX}/rc.vim ${VIMRC}
ln -s ${PREFIX}/vim ${DOTVIM} 
ln -s ${PREFIX}/rc.zsh ${ZSHRC} 
ln -s ${PREFIX}/rc.screen ${SCREENRC} 

pushd ~/.vim/bundle/vim-snipmate
git apply --stat ../../patches/modified-snipmate-to-use-leader-key.patch
popd

pushd ~/.vim/bundle/vim-command-t
rake make 
popd

