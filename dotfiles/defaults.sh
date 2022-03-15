#! /usr/bin/env sh

echo "Setting defaults..."
defaults write com.apple.systemsound 'com.apple.sound.uiaudio.enabled' -int 0
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0.1
defaults write /Library/Preferences/.GlobalPreferences AppleInterfaceTheme Dark
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
