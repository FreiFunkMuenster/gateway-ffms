#!/bin/bash

# Check der Routingtabelle 42

output=$( ip route show table 42 | grep default | tr "\n" "#" )

if [[ "#$output" =~ ^.*[t][u][n][-][f][f][r][l][-].*$ ]]
then
    echo "OK - $output"
    exit 0
else
    echo "CRITICAL - $output"
    exit 2
fi
