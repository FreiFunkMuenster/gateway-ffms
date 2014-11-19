#!/bin/bash

# Check deb Batman-Gatewaymode

output=$( batctl gw )

if [[ "$output" =~ ^server.* ]]
then
    echo "OK - server"
    exit 0
else
    echo "CRITICAL - off"
    exit 2
fi
