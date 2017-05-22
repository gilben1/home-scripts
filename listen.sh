#!/bin/bash

# Notification thing written by grpyhon. Change to your $user and $host rather than mine if you are using it
ssh -4 nickg@serenity.cat.pdx.edu "tail -n0 -f ~/beep.log" </dev/null | nohup ruby -rshellwords -ne '`notify-send -t 1000 #{$_.shellescape}`' >/dev/null 2>&1
