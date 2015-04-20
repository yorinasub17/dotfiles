#!/bin/bash

mkdir -p ~/.vim/bundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp .vimrc ~/.vimrc
cp -r ftplugin ~/.vim
vim +PluginInstall +qall
