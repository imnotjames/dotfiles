#!/usr/bin/env bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew tap "homebrew/bundle"

brew bundle install --file $(dirname "$0")/Brewfile

