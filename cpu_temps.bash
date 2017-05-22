#!/bin/bash

# Script by Nick Gilbert
# Use and modify as you will

# Simple script to output the temps of cores 0 and 1 from lmsensors 'sensors' output
# For use in py3statuses "external script" module

core_0=$(sensors | grep "Core 0")
core_1=$(sensors | grep "Core 1")

core_0=$(echo $core_0 | cut -d '+' -f 2 | cut -d ' ' -f 1)
core_1=$(echo $core_1 | cut -d '+' -f 2 | cut -d ' ' -f 1)

echo "${core_0} : ${core_1}"
