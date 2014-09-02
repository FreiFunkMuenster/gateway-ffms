#!/bin/bash

### CONFIGURATION ###

# Set the number of the iptables mark, to catch the packets and route them through the tunnel
iptables_mark=1

# Set the destination ip to use for pinging
destination_ip=8.8.8.8

# Set the source interface
source_if='tun0'

# Set the maximum number of tries
max_tries=3

# Logfile path
log_path='/var/log/watchdog_mullvad.log'

### FUNCTIONS ###

function execute_on_fail() {
	service fastd stop
	echo "Stopped fastd for reasons!"
}

function separator() {
	echo "" >> $log_path
}

function log() {
	date "+%Y/%m/%d %H:%M:%S: $1" >> $log_path
}

### CODE ###

separator
log "Trying to get a reply from $destination_ip..."

while [ $max_tries -gt 0 ]; do
	ping -q -I $source_if -c1 -m $iptables_mark $destination_ip >& /dev/null
	if [ $? -eq 0 ]; then
		log "Got a reply from $destination_ip, so everything seems to be in order. Exiting."
		exit 0
	fi
	max_tries=`expr $max_tries - 1`
	sleep 1
done

log "Did not get a reply from $destination_ip, so there seems to be a problem. Running 'execute_on_fail'..."
execute_on_fail
log "Exiting."
exit 1
