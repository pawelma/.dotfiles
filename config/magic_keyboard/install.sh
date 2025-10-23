#!/bin/bash

# This script installs systemd monitor for the Magic Keyboard
# it requires the proper layout being set up in your gnome settings
# and the keyboard id being set in the .bash_profile

# we are adding systemd service and timer to monitor the keyboard
# and not using udev rules because it cannot run gsettings commands
# as a user, also it does not work when keyboard is plugged/unplugged
# while the system is suspended or turned off.

lsusb

echo

MAGIC_KEYBOARD_ID=$(lsusb | grep "Apple, Inc. Magic Keyboard" | awk '{print $6}')
if [ -z "$MAGIC_KEYBOARD_ID" ]; then
  echo "Magic Keyboard not found, please make sure it is connected"
  exit 1
fi
echo "adding env to .bash_pfofile: MAGIC_KEYBOARD_ID=$MAGIC_KEYBOARD_ID"
echo "export MAGIC_KEYBOARD_ID=$MAGIC_KEYBOARD_ID" >> $HOME/.bash_profile

echo "ensure fish is loading .bash_profile"
echo "source ~/.bash_profile" > $HOME/.config/fish/conf.d/00-source_bash_profile.fish

echo setting up symlinks
ln -fs $(pwd)/keyboard-layout-monitor.sh $HOME/.local/bin/keyboard-layout-monitor.sh
sudo ln -fs $(pwd)/keyboard-layout-monitor.service $HOME/.config/systemd/user/keyboard-layout-monitor.service
sudo ln -fs $(pwd)/keyboard-layout-monitor.timer $HOME/.config/systemd/user/keyboard-layout-monitor.timer

echo "enabling and starting the service"
systemctl --user enable keyboard-layout-monitor.timer
systemctl --user start keyboard-layout-monitor.timer
echo

echo "setting up the mission control like key binding for magic keyboard"
gsettings set org.gnome.shell.keybindings toggle-overview "['XF86LaunchA']"

systemctl --user status keyboard-layout-monitor.timer
