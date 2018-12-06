#!/usr/bin/env bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

xargs brew install < brew-packages
xargs brew cask install < brew-cask-packages
