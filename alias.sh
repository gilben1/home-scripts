#!/bin/bash

# Outputs the aliases and functions defined in .bash_aliases

aliases=$(cat ~/.bash_aliases | grep ^alias | cut -d ' ' -f 2 | cut -d '=' -f 1)
functions=$(cat ~/.bash_aliases | grep ^function | cut -d ' ' -f 2 | rev | cut -c 3- | rev)

echo "${aliases}${functions}"
