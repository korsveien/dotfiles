#! /usr/bin/env sh

rm -rf ~/.config/nvim
rm -rf ~/.config/fish
rm -rf ~/.config/alacritty
rm -rf ~/.config/hypr

ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/fish ~/.config/fish
ln -s ~/dotfiles/alacritty ~/.config/alacritty
ln -s ~/dotfiles/hypr ~/.config/hypr
