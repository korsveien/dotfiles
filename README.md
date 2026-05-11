# dotfiles

Personal configuration for Neovim, Fish, Tmux, and Alacritty.

## Setup

```sh
./ln.sh
```

Creates symlinks from `~/.config/{nvim,fish,alacritty,tmux}` to this repo.

## Contents

| Tool | Notes |
|------|-------|
| **Neovim** | Custom `sekigawa` colorscheme (Kanagawa-based), minimal plugin setup |
| **Fish** | vi bindings, git/editor abbreviations, fzf branch switcher (`gco`), autojump |
| **Tmux** | vi pane navigation, `|`/`-` splits, mouse on |
| **Alacritty** | Kanagawa Dragon theme |

## Dependencies

- [bob](https://github.com/MordechaiHadad/bob) — Neovim version manager
- [autojump](https://github.com/wting/autojump) — directory jumping
- [fzf](https://github.com/junegunn/fzf) — fuzzy finder (used by `gco`)
- [ripgrep](https://github.com/BurntSushi/ripgrep) — used by `ho` function

```sh
brew install bob autojump fzf ripgrep
bob install latest && bob use latest
```
