#!/bin/bash

TOUCHPAD_DEVICE=12 # check with `xinput` command

if [[ "$1" == "on" ]]; then
  xinput enable $TOUCHPAD_DEVICE
else
  if [[ "$1" == "off" ]]; then
    xinput disable $TOUCHPAD_DEVICE
  else
    if [[ "$1" == *h* ]]; then
      echo -e "\e[2muse: 'touchpad on/off' to change state\e[0m"
    fi
  fi
fi

xinput list $TOUCHPAD_DEVICE | grep disabled > /dev/null

if [ $? -eq 0 ]; then
  echo -e "TOUCHPAD: \e[31mdisabled\e[0m"
else
  echo -e "TOUCHPAD: \e[32menabled\e[0m"
fi
