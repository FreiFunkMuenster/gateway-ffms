#!/bin/bash

# Check if the mullvad tunnel is alive by Pinging several IPs through the
# tunnel by setting the source interface and the firewall mark 

### CONFIGURATION ###

# Set the number of the iptables mark, to catch the packets and route them through the tunnel
iptables_mark=1

# Set the destination ips to use for pinging
destination_ips=( '78.46.108.155' '78.46.108.150' '46.38.251.123' '8.8.8.8' )

# Set the source interface
source_if='tun0'

### CODE ###

for destination_ip in ${destination_ips[@]}; do
	ping -q -I $source_if -c1 -W1 -m $iptables_mark $destination_ip >& /dev/null
	if [ $? -eq 0 ]; then
		echo "OK - Got a reply from $destination_ip, Tunnel is UP"
		exit 0
	fi
	sleep 1
done

echo "CRITICAL - Did not get a reply from any destination ip, Tunnel is DOWN"
exit 2
