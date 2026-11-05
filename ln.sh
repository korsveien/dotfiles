#! /usr/bin/env sh

# Symlinks
ln -sfn ~/dotfiles/nvim ~/.config/nvim
ln -sfn ~/dotfiles/fish ~/.config/fish
ln -sfn ~/dotfiles/tmux ~/.config/tmux
ln -sfn ~/dotfiles/kitty ~/.config/kitty
ln -sfn ~/dotfiles/yazi ~/.config/yazi
ln -sfn ~/dotfiles/opencode ~/.config/opencode
ln -sfn ~/dotfiles/bat ~/.config/bat
bat cache --build

# Zed: settings.json is generated from zed/settings.json and ~/.config/zed-local/work.json
[ -L ~/.config/zed ] && rm ~/.config/zed
mkdir -p ~/.config/zed
ln -sfn ~/dotfiles/zed/keymap.json ~/.config/zed/keymap.json
ln -sfn ~/dotfiles/zed/themes ~/.config/zed/themes
~/dotfiles/zed/build-settings.py

# AGENTS.md
mkdir -p ~/.claude
ln -sf ~/dotfiles/agents/AGENTS.md ~/.config/opencode/AGENTS.md
ln -sf ~/dotfiles/agents/AGENTS.md ~/.claude/CLAUDE.md
