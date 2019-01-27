#!/usr/local/bin/fish

set day (date +"%a")
if test $day = "Sun" -o $day = "Sat"
  exit 0
end
slack_presence "afk"
slack_presence "afk :afk:" --set-status
