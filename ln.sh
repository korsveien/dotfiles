#! /usr/bin/env sh

# Symlinks
ln -sfn ~/dotfiles/nvim ~/.config/nvim
ln -sfn ~/dotfiles/fish ~/.config/fish
ln -sfn ~/dotfiles/tmux ~/.config/tmux
ln -sfn ~/dotfiles/kitty ~/.config/kitty
ln -sfn ~/dotfiles/yazi ~/.config/yazi
ln -sfn ~/dotfiles/zed ~/.config/zed
ln -sfn ~/dotfiles/opencode ~/.config/opencode
ln -sfn ~/dotfiles/bat ~/.config/bat
bat cache --build

# AGENTS.md
mkdir -p ~/.claude
ln -sf ~/dotfiles/agents/AGENTS.md ~/.config/opencode/AGENTS.md
ln -sf ~/dotfiles/agents/AGENTS.md ~/.claude/CLAUDE.md
