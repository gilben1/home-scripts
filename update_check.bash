#!/bin/bash

# Script by Nick Gilbert (nickgilbert2@gmail.com)
# Use and modify as you will

# count how many updates we have got

ups=`/usr/lib/update-notifier/apt-check --human-readable | head -1 | awk '{print $1;}'`

# print the results
if [ "$ups" -eq "1" ] ; then
    echo "(1)"
elif [ "$ups" -gt "1" ] ; then
    echo "($ups)"
else
    #echo "(√)"
    echo ""
fi
