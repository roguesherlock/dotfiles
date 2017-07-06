#!/bin/bash
#
# Check if any updates are available
#
# Created by 0xelectron
#

pac=$(checkupdates | wc -l)
aur=$(pacaur -k | wc -l)

total=$((pac + aur))
if [ $total -gt 0 ]
then
    printf ""
else
    printf " "
fi