#!/bin/bash
#
# Script to prompt to rename the current workspace.
#
# Cadged from
#  https://faq.i3wm.org/question/3936/how-can-i-change-the-position-of-i3-input-prompt/
#
WSNUMBER=$(ruby -rjson -e 'puts(JSON.parse(`i3-msg -t get_workspaces`).find { |ws| ws["focused"] }["num"])')
OLDNAME=$(ruby -rjson -e 'puts(JSON.parse(`i3-msg -t get_workspaces`).find { |ws| ws["focused"] }["name"])')
NEWNAME=$(echo | rofi   -dmenu \
                        -i \
                        -hide-scrollbar true \
                        -width 35 \
                        -location 7 \
                        -lines 0 \
                        -p "Workspace Name for (${OLDNAME})")
if [ -z "${NEWNAME}" ] ; then
    NEWNAME="${OLDNAME}"
elif [[ ! "${NEWNAME}" =~ ^[0-9]+: ]] ; then
    NEWNAME="${WSNUMBER}:${NEWNAME}"
fi
    i3-msg "rename workspace to \"${NEWNAME}\""
