#!/bin/bash
#
# Script to prompt to rename the current workspace.
#
# Cadged from
#  https://faq.i3wm.org/question/3936/how-can-i-change-the-position-of-i3-input-prompt/
#
WSNUMBER=$(ruby -rjson -e 'puts(JSON.parse(`i3-msg -t get_workspaces`).find { |ws| ws["focused"] }["num"])')
NEWNAME=$(echo | rofi   -dmenu \
                        -i \
                        -p "Workspace Name: ")
if [ -z "${NEWNAME}" ] ; then
    NEWNAME="${WSNUMBER}"
elif [[ ! "${NEWNAME}" =~ ^[0-9]+: ]] ; then
    NEWNAME="${WSNUMBER}:${NEWNAME}"
fi
    i3-msg "rename workspace to \"${NEWNAME}\""
