# Homebrew

Brewfiles generated with `brew bundle dump`. The suffix shows which machine the file comes
from:

- `Brewfile.sb1`: work laptop (SpareBank 1).

## Install

Install Homebrew if it is not already installed:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install everything in the Brewfile (taps, formulae, casks and global npm packages):

```sh
brew bundle --file=~/dotfiles/homebrew/Brewfile.sb1
```

The `npm` entries are installed with `npm install -g` and require `node`. The Brewfile installs
`node@24` and links it. Casks may ask for the admin password.

Check what is missing without installing anything:

```sh
brew bundle check --file=~/dotfiles/homebrew/Brewfile.sb1 --verbose
```

## Update the dump

Overwrite the file with the packages currently installed:

```sh
brew bundle dump --file=~/dotfiles/homebrew/Brewfile.sb1 --force
```

List installed packages that are not in the Brewfile. Add `--force` to uninstall them:

```sh
brew bundle cleanup --file=~/dotfiles/homebrew/Brewfile.sb1
```
