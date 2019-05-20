#!/usr/local/bin/fish

touch ~/.ignore
set ignore (cat ~/.ignore)
set day (date +"%a")
if test $day = "Sun" -o $day = "Sat" -o $ignore != 0
  exit 0
end
slack_presence "afk"
slack_presence "afk :afk:" --set-status
