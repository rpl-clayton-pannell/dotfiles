#!/bin/sh

# move to repo directory
cd "${0%/*}"

#install dotfiles
mv dotfiles/.vimrc ~/.vimrc
mkdir -p ~/.config/nvim
mv dotfiles/init.vim ~/.config/nvim/init.vim
mkdir -p ~/.config/coc
mv dotfiles/coc-settings.json ~/.config/coc

# Set up nvim
nvim +'PlugInstall' +qall
nvim +'CocUpdateSync' +qall

# install coc extensions
nvim +'CocInstall coc-pyright coc-clangd coc-rust-analyzer coc-json -sync' +qall
