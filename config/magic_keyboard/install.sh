#!/bin/bash

# This script installs systemd monitor for the Magic Keyboard
# it requires the proper layout being set up in your gnome settings
# and the keyboard id being set in the .bash_profile

# we are adding systemd service and timer to monitor the keyboard
# and not using udev rules because it cannot run gsettings commands
# as a user, also it does not work when keyboard is plugged/unplugged
# while the system is suspended or turned off.

# Function to install XKB custom symbols
install_xkb_custom() {
  echo "=== Setting up XKB custom symbols ==="

  local xkb_symbols_file="/usr/share/X11/xkb/symbols/custom"
  local xkb_rules_file="/usr/share/X11/xkb/rules/evdev"
  local source_file="$(pwd)/xkb_symbols_custom"

  # Copy custom symbols file (idempotent)
  if [ -f "$xkb_symbols_file" ]; then
    echo "XKB symbols file already exists at $xkb_symbols_file"
    echo "Updating it with current configuration..."
  fi
  sudo cp "$source_file" "$xkb_symbols_file"
  echo "✓ Copied custom symbols to $xkb_symbols_file"

  # Add custom options to evdev rules (idempotent)
  if grep -q "custom:magic_keyboard" "$xkb_rules_file" 2>/dev/null; then
    echo "✓ XKB rules already configured in $xkb_rules_file"
  else
    echo "Adding custom options to $xkb_rules_file..."
    # Find the "! option = symbols" section and add our custom options after it
    # Using tab characters for proper alignment with the file format
    sudo sed -i '/^! option[[:space:]]*=[[:space:]]*symbols$/a\  custom:capslock\t=\t+custom(capslock)\n  custom:magic_keyboard\t=\t+custom(magic_keyboard)' "$xkb_rules_file"
    echo "✓ Added custom options to evdev rules"
  fi

  echo "✓ XKB custom symbols setup complete"
  echo
}

# Ask user if they want to set up XKB custom modifiers
echo "=== Magic Keyboard Installation ==="
echo
read -p "Do you want to set up custom XKB modifiers (capslock and magic_keyboard remapping)? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  install_xkb_custom
else
  echo "Skipping XKB custom symbols setup"
  echo
fi

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
