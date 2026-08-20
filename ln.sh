#! /usr/bin/env sh

rm -rf ~/.config/nvim
rm -rf ~/.config/fish
rm -rf ~/.config/tmux

ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/fish ~/.config/fish
ln -s ~/dotfiles/tmux ~/.config/tmux
