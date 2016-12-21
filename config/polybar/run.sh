#!/bin/bash

# kill previous bar
killall -q polybar &>/dev/null
while pgrep -x polybar >/dev/null; do sleep 1; done

# run new one
polybar eDP1 &
polybar HDMI1 &
