#!/bin/bash

git submodule init
git submodule update
git submodule foreach git submodule init
git submodule foreach git submodule update

# Copy vimrc
cp .vimrc ~/.vimrc

# Build command t
cd bundle/command-t/ruby/command-t
ruby extconf.rb
make
