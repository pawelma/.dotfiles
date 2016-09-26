#!/bin/bash

#
#* * * * * /home/pawel/scripts/rm_tmp_cache.sh
#

find /tmp/*.cache -mmin +5 -exec rm -f {} \;
 
