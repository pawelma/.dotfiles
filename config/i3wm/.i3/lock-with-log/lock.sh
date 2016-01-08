#!/bin/bash

LOG_PATH=/var/log/lock/lock.log

touch $LOG_PATH

function log {
  datetime=`date +"%Y-%m-%d %H:%M:%S"`
  echo $datetime - $1 >> $LOG_PATH
}

log "Locked"

i3lock -c 000000 --nofork

log "Unlocked"
