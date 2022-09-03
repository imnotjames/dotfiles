dotfiles
--------

These are my dotfiles.

Future me: Grab all this for another machine with

```
HOMEGIT_REPO=https://github.com/imnotjames/dotfiles.git

git clone --bare --branch homegit $HOMEGIT_REPO $HOME/.homegit
echo '/.homegit' >> $HOME/.homegit/info/exclude
HOMEGIT='/usr/bin/git --gitdir=$HOME/.homegit --work-tree=$HOME'

$HOMEGIT config pull.ff only
$HOMEGIT config --local status.showUntrackedFiles no
$HOMEGIT sparse-checkout set --no-cone '/*' '!README.md'
$HOMEGIT checkout
```
