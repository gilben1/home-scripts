#!/bin/bash

# Notification thing written by grpyhon. Change to your $user and $host rather than mine if you are using it
ssh -4 nickg@serenity.cat.pdx.edu "tail -n0 -f ~/beep.log" </dev/null | nohup ruby -rshellwords -ne '`notify-send #{$_.shellescape} -i $HOME/.notify_icons/weechat.png`' >/dev/null 2>&1 &
