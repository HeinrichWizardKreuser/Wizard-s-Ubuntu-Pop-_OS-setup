# Python Environment Recursive Activation

This script attempts to activate the python environment located in the current directory if there is one. If there isn't, it tries again but in the parent directory. If that fails, then it tries in the grandparent directory and so on until it reaches the home directory (where it stops if it fails)

## Terminal shortcut
Place this in your bash (sensitive to path of this folder)
```
alias activate='. ~/sandbox/commands/packages/activate-recur/activate-recur.sh'
```
