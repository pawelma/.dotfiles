#!/bin/bash

LOG_PATH=/var/log/lock/lock.log

touch $LOG_PATH

function log {
  datetime=`date +"%Y-%m-%d %H:%M:%S"`
  echo $datetime - $1 >> $LOG_PATH
}

if [ $# -ne 0 ]; then
  log $*
fi
