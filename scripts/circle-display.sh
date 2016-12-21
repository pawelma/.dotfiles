#!/bin/bash

# MODES
HDMI_LEFT=1   # external left of internal
HDMI_MIRROR=2 # external is mirroring internal
HDMI_ON=3     # only external
HDMI_OFF=0    # only internal

ACTIVE_OUTPUTS=(`xrandr -q | grep -v disconnected | grep connected | awk '{print $1}'`)
MODE=`cat /tmp/.hdmi_mode 2> /dev/null`
PREV_EXTERNAL=`cat /tmp/.hdmi_output 2> /dev/null`

function notify(){
  mode=$1
  output=$2
  output2=$3

  echo $mode > /tmp/.hdmi_mode
  echo $output > /tmp/.hdmi_output

  msg="Unknown mode!"
  case $mode in
    1)
      msg="${output} left of ${output2}"
      ;;
    2)
      msg="${output} mirroring ${output2}"
      ;;
    3)
      msg="${output} on"
      ;;
    0)
      msg="${output2} on"
      ;;
  esac

  notify-send --urgency=low --icon=display Screen "$msg"
}

if [ ${#ACTIVE_OUTPUTS[*]} -gt 1 ]; then
  # workaround for nvidia extended resolution problem (1 screen with 3800 px instead 2 with 1900) 
  resolution_extend=`xrandr -q | grep ${ACTIVE_OUTPUTS[1]} -A 2 | grep 80i | awk '{print $1}' `
  if [[ ! -z $resolution_extend ]]; then
    xrandr --output ${ACTIVE_OUTPUTS[1]} --fb $resolution_extend --mode $resolution_extend  
  fi

  case $MODE in
    0)
      xrandr --auto
      xrandr --output ${ACTIVE_OUTPUTS[1]} --left-of ${ACTIVE_OUTPUTS[0]}
      notify 1 ${ACTIVE_OUTPUTS[1]} ${ACTIVE_OUTPUTS[0]}
      ;;
    1)
      xrandr --auto
      xrandr --output ${ACTIVE_OUTPUTS[1]} --same-as ${ACTIVE_OUTPUTS[0]}
      notify 2 ${ACTIVE_OUTPUTS[1]} ${ACTIVE_OUTPUTS[0]}
      ;;
    2)
      xrandr --auto
      xrandr --output ${ACTIVE_OUTPUTS[0]} --off
      xrandr --output ${ACTIVE_OUTPUTS[1]} --primary 
      notify 3 ${ACTIVE_OUTPUTS[1]} ${ACTIVE_OUTPUTS[0]}
      ;;
    *) # also 3 included
      xrandr --auto
      xrandr --output ${ACTIVE_OUTPUTS[1]} --off
      xrandr --output ${ACTIVE_OUTPUTS[0]} --primary 
      notify 0 "" ${ACTIVE_OUTPUTS[0]}
      ;;
  esac
else
  xrandr --output $PREV_EXTERNAL --off
  xrandr --auto
  xrandr --output $ACTIVE_OUTPUTS --primary
  notify 0 "" ${ACTIVE_OUTPUTS[0]}
fi
