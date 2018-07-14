#!/bin/bash

# Enable Natural Scrolling
xinput --set-prop 8 'libinput Natural Scrolling Enabled' 1
echo "[INFO] takecareofit: Enabled Natural Scrolling"

# Disable caps lock
setxkbmap -option caps:none > /dev/null 2>&1
echo "[INFO] takecareofit: Disabled Caps Lock"

# mount google drive if not mounted already
# mount | grep "${HOME}/Google Drive" > /dev/null 2>&1 || /usr/bin/google-drive-ocamlfuse "${HOME}/Google Drive" 2>&1
# echo "[INFO] takecareofit: mounted Google Drive"
