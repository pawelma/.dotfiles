#!/bin/bash

. '/home/pawel/.config/i3/lock-with-log/log.sh'

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
