#!/usr/local/bin/fish

if test -e /tmp/signed_out
  set me_status (cat /tmp/signed_out)
else
  echo 0 > /tmp/signed_out
end

set day (date +"%a")
if test $day = "Sun" -o $day = "Sat" -o $me_status = 1
  exit 0
end
# wait for wifi
sleep 120
slack_presence "back"
slack_presence "" --set-status
