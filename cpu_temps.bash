#!/bin/bash

core_0=$(sensors | grep "Core 0")
core_1=$(sensors | grep "Core 1")

core_0=$(echo $core_0 | cut -d '+' -f 2 | cut -d ' ' -f 1)
core_1=$(echo $core_1 | cut -d '+' -f 2 | cut -d ' ' -f 1)

echo "${core_0} : ${core_1}"
