#!/bin/bash

defaults write com.googlecode.iterm2 "PrefsCustomFolder" -string "$HOME/etc/iterm2/"
defaults write com.googlecode.iterm2 "LoadPrefsFromCustomFolder" -bool true

