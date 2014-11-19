#!/bin/bash

# Check deb Batman-Gatewaymode

output=$( batctl gw )

if [[ "$output" =~ ^server.* ]]
then
    echo "OK - $output"
    exit 0
else
    echo "CRITICAL - $output"
    exit 2
fi
