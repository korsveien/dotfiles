# dotfiles

Home for system configuration and lists of useful tools.

This repo is managed using [yadm](https://yadm.io/).

## How to setup a new system

1. Install prerequisites for Homebrew: `xcode-select --install`
2. Install Homebrew: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
3. Clone this repo using yadm: `yadm clone https://github.com/korsveien/dotfiles.git`
4. Bootstrap with yadm: `yadm bootstrap`

## [Tools](Tools)

Lists of useful tools for enhancing productivity and quality of life.

### Mac OS

| Feature                         | Tool                                                               |
| ------------------------------- | ------------------------------------------------------------------ |
| Window manager                  | [Rectangle](https://rectangleapp.com/)                             |
| App Switcher                    | [Apptivate](http://www.apptivateapp.com/)                          |
| Window Switcher                 | [Contexts](https://contexts.co/)                                   |
| Clipboard manager               | [Maccy](https://maccy.app/)                                        |
| Terminal                        | [iTerm2](https://iterm2.com)                                       |
| Mouse Side Button Functionality | [SensibleSideButtons](https://sensible-side-buttons.archagon.net/) |

### Developer Tools

| Feature     | Tool                                             |
| ----------- | ------------------------------------------------ |
| Editor      | [Neovim](https://neovim.io/)                     |
| IDE         | [IntelliJ IDEA](https://www.jetbrains.com/idea/) |
| REST Client | [Insomnia](https://insomnia.rest/)               |

### Homebrew Packages

See the contents of Brewfile.

### How to remove native tab bar and sidebar header in Firefox

1. In Firefox, go to `about:config` and set `toolkit.legacyUserProfileCustomizations.stylesheets` to `true`
2. In Firefox, go to `about:support` and see the "Profile Folder" row to find its location
3. Create a folder named `chrome` in the profile folder
4. Create `userChrome.css` and into the folder you just created with the following contents:

```css
/* hides the native tabs */
#TabsToolbar {
  visibility: collapse;
}

/* hides the sidebar */
#sidebar-header {
  visibility: collapse !important;
}
```

## Resources

- https://openfolder.sh/macos-migrations-with-brewfile
- [How to remove native tab bar in firefox](https://superuser.com/questions/1424478/can-i-hide-native-tabs-at-the-top-of-firefox)
