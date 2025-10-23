#!/bin/bash

source ~/.bash_profile

STATE_FILE="/tmp/keyboard_state.txt"
LOG_FILE="/var/log/magic_keyboard.log"

# Get the current state of the keyboard (plugged in or not)
CURRENT_STATE=$(lsusb | grep -q "ID $MAGIC_KEYBOARD_ID" && echo "plugged" || echo "unplugged")

# Read the previous state from the state file
PREVIOUS_STATE=$(cat $STATE_FILE 2>/dev/null)

# If the state has changed, update the layout
if [ "$CURRENT_STATE" != "$PREVIOUS_STATE" ]; then
  if [ "$CURRENT_STATE" == "plugged" ]; then
    gsettings set org.gnome.desktop.input-sources xkb-options "['custom:capslock', 'custom:magic_keyboard']"
  else
    gsettings set org.gnome.desktop.input-sources xkb-options "['custom:capslock', 'ctrl:swap_lalt_lctl']"
  fi

  # Update the state file
  echo "$(date): Magic Keyboard ('$MAGIC_KEYBOARD_ID') $CURRENT_STATE, layout changed." >> $LOG_FILE
  echo "$CURRENT_STATE" > $STATE_FILE
fi
