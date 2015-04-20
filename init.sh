#!/bin/bash

mkdir -p ~/.vim/bundle
git clone https://github.com/gmarik/Vundle.vim.git@cfd3b2d388a8c2e9903d7a9d80a65539aabfe933 ~/.vim/bundle
cp .vimrc ~/.vimrc
vim +PluginInstall +qall
