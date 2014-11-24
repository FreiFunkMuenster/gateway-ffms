#!/bin/bash

# Check der Routingtabelle 42 

output=$( ip route show table 42 | tr "\n" "#" )
expected="0.0.0.0/1 via 10.8.0.30 dev tun0 #128.0.0.0/1 via 10.8.0.30 dev tun0 #"

if [ "#$output" = "#$expected" ]
then
    echo "OK - $output"
    exit 0
else
    echo "CRITICAL - $output"
    exit 2
fi
