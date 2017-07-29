#!/usr/bin/env sh
#
# Created by 0xelectron
#

# launch polybar if not already running
is_running=$(pgrep -x polybar)
if [ $? -eq 1 ]
then
    polybar -rq top &
fi
