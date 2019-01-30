#!/usr/local/bin/fish

set day (date +"%a")
if test $day = "Sun" -o $day = "Sat"
  exit 0
end
# wait for wifi
sleep 120
slack_presence "back"
slack_presence "" --set-status
