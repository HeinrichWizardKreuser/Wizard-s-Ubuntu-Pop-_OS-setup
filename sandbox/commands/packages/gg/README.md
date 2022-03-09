# Git Shortcuts

`gg` is a package that compacts
```
git status
git add
git commit
```
all in one command and uses an algorithm to detect what the user intends to do.
See examples by running the tests (next section) or viewing the end of the file for examples


## Test
```
python testgg.py
```

## Terminal Shortcut
Place this in your bash (sensitive to path of this folder)
```
alias gc='python3 ~/sandbox/commands/packages/gg/gg.py'
```

## Examples
```
$ |gc| ->
  |git status|

$ |gc .| ->
  |git add .|

$ |gc testgg.py| ->
  |git add testgg.py|

$ |gc testgg.py gg.py| ->
  |git add testgg.py gg.py|

$ |gc ...| ->
  |git commit -m "..."|

$ |gc x| ->
  |git commit -m "x"|

$ |gc somemessage| ->
  |git commit -m "somemessage"|

$ |gc some message| ->
  |git commit -m "some message"|

$ |gc some quite long and extranious message| ->
  |git commit -m "some quite long and extranious message"|

$ |gc some message with a 'single' quote| ->
  |git commit -m "some message with a 'single' quote"|

$ |gc some quite long and extranious message with a 'single' quote| ->
  |git commit -m "some quite long and extranious message with a 'single' quote"|

$ |gc testgg.py ...| ->
  |git add testgg.py|
  |git commit -m "..."|

$ |gc testgg.py x| ->
  |git add testgg.py|
  |git commit -m "x"|

$ |gc testgg.py somemessage| ->
  |git add testgg.py|
  |git commit -m "somemessage"|

$ |gc testgg.py some message| ->
  |git add testgg.py|
  |git commit -m "some message"|

$ |gc testgg.py some quite long and extranious message| ->
  |git add testgg.py|
  |git commit -m "some quite long and extranious message"|

$ |gc testgg.py some message with a 'single' quote| ->
  |git add testgg.py|
  |git commit -m "some message with a 'single' quote"|

$ |gc testgg.py some quite long and extranious message with a 'single' quote| ->
  |git add testgg.py|
  |git commit -m "some quite long and extranious message with a 'single' quote"|

$ |gc testgg.py gg.py ...| ->
  |git add testgg.py gg.py|
  |git commit -m "..."|

$ |gc testgg.py gg.py x| ->
  |git add testgg.py gg.py|
  |git commit -m "x"|

$ |gc testgg.py gg.py somemessage| ->
  |git add testgg.py gg.py|
  |git commit -m "somemessage"|

$ |gc testgg.py gg.py some message| ->
  |git add testgg.py gg.py|
  |git commit -m "some message"|

$ |gc testgg.py gg.py some quite long and extranious message| ->
  |git add testgg.py gg.py|
  |git commit -m "some quite long and extranious message"|

$ |gc testgg.py gg.py some message with a 'single' quote| ->
  |git add testgg.py gg.py|
  |git commit -m "some message with a 'single' quote"|

$ |gc testgg.py gg.py some quite long and extranious message with a 'single' quote| ->
  |git add testgg.py gg.py|
  |git commit -m "some quite long and extranious message with a 'single' quote"|
```
