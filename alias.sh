#!/bin/bash

alias | awk -F'[ =]' '{print $2}'
