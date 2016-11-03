#!/bin/bash

LOG_PATH=/var/log/lock/lock.log

touch $LOG_PATH

function log {
  datetime=`date +"%Y-%m-%d %H:%M:%S"`
  echo $datetime - $1 >> $LOG_PATH
}

log "Locked"
## pause player
player_state=`nuvolaplayer3ctl track-info | grep State | awk '{print $2}'`
nuvolaplayer3ctl action pause

# lock
i3lock -d -c 000000 --nofork

# unpause player
if [ "playing" = "$player_state" ]; then
  nuvolaplayer3ctl action play
fi
log "Unlocked"
