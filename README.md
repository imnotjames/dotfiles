dotfiles
--------

These are my dotfiles.

Future me: Grab all this for another machine with

```
alias homegit='/usr/bin/git --gitdir=$HOME/.homegit --work-tree=$HOME'
git clone --bare https://github.com/imnotjames/dotfiles.git $HOME/.homegit
homegit sparse-checkout set --no-cone '/*' '!README.md'
homegit checkout
```
