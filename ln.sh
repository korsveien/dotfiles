#! /usr/bin/env sh

rm -rf ~/.config/nvim
rm -rf ~/.config/fish
rm -rf ~/.config/kitty
rm -rf ~/.config/yazi
rm -rf ~/.config/opencode

ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/fish ~/.config/fish
ln -s ~/dotfiles/kitty ~/.config/kitty
ln -s ~/dotfiles/yazi ~/.config/yazi
ln -s ~/dotfiles/opencode ~/.config/opencode
