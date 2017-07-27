#!/usr/bin/env sh
#
# Created by 0xelectron
#

# Terminate already running bar instances
killall -qw polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch Top bar
polybar top &
#polybar bottom &
