# Google Selected Text

This script takes the currently selected text (in terminal, browser, editor etc.) and opens a new firefox window with that text.
One of its main uses is to google an error in the terminal, but it is very useful in general.

## Installation
```
sudo apt install xsel
```

## Keyboard shortcut
Settings -> Keyboard -> Customize Shortcuts -> custom shortcuts:

```
Name:
google-selected

Command:
python3 /home/wizard/sandbox/commands/packages/google-selected/google-search-selected-text.py

Shortcut (suggested):
Ctrl+6
```