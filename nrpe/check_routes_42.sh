#!/bin/bash

# Check der Routingtabelle 42

output=$( ip route show table 42 | tr "\n" "#" )

if [[ "#$output" =~ ^.*[v][i][a].*[d][e][v].*[#].*[v][i][a].*[d][e][v].*[#]$ ]]
then
    echo "OK - $output"
    exit 0
else
    echo "CRITICAL - $output"
    exit 2
fi
