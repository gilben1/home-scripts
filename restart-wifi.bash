#!/bin/bash

# Script by Nick Gilbert (nickgilbert2@gmail.com)
# Use and modify as you will

# Restarts the network manager via service

# Restart the network manager, and if it succeeds, tell the user
service network-manager restart && notify-send -t 500 "Network Service Restarted"
