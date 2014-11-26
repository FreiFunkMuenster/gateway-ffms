#!/bin/bash

# Check der ANDEREN verfügbaren Batman-Gateways

# Also immer Anzahl Gateways -1 
# Es wird einfach nur die Liste von batctl gwl geprüft 
# und die Anzahl der Zeilen gezählt (eine pro Gateway + Überschrift) 

output=$( sudo batctl gwl | tr "\n" "#" )
count=$( sudo batctl gwl | wc -l )

if [[ $count -eq 3 ]]
then
    # Expected Number of Gateways 
	
    echo "OK - $output"
    exit 0
fi

if [[ $count -lt 3 ]]
then
    # Number of Gateways is lesser than expected 
	# Can be a Gateway fail 
	
    echo "WARRNING - $output"
    exit 0
fi

# Number of gateways is greater than expected 
# Can be merge to another community or a rough Gateway 

echo "CRITICAL - $output"
exit 2

