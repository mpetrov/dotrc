#!/usr/bin/env bash

ln -s $HOME/dotrc/rc.vim ~/.vimrc
ln -s $HOME/dotrc/rc.vim ~/.config/nvim/init.vim
ln -s $HOME/dotrc/conf.tmux ~/.tmux.conf
ln -s $HOME/dotrc/rc.zsh ~/.zshrc

bin/homebrew/install zsh neovim antigen

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
