#!/bin/bash

# Freifunk Watchdog Scripte - Gemeinsame Funktionen  
# 
# Gemeinsame Funktionen für die Watchdog Scripte 
# Hier werden bereits die einzelnen Checks ausgeführt 
# In den einzelnen Watchdog-Scripten erfolgt dann die Reaktion 
# entsprechend der Ergebnisse 

### CONFIGURATION ###

# Set the paths, as cron will not do this
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

### FUNCTIONS ###

# Write message to logfile 
#
# ${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]} 
# .. is always the 'main' executing script file which included this one 

function log() {
	date "+%Y/%m/%d %H:%M:%S: [${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}]: $1" >> '/var/log/watchdog.log'
}

### CODE ###

log "===================================================================="

# Log relevant state info before run 
log "Pre-State (batctl gw): $(batctl gw)"

# Check the OpenVPN Deamon  
log "Check OpenVPN Status .. "

ovpnout=$(service openvpn status)  
ovpnret=$?
log "Check OpenVPN Status: $ovpnret / $ovpnout"

# Check the Routing Table 42 for proper Freifunk routing 
log "Check Routing Table 42 .. "

rt42out=$(/bin/bash /var/gateway-ffms/nrpe/check_routes_42.sh)  
rt42ret=$?
log "Check Routing Table 42: $rt42ret / $rt42out"

# Check IPv4 Ping through tunnel 
log "Check IPv4 Ping .. "

ping4out=$(/bin/bash /var/gateway-ffms/nrpe/check_openvpn_ping4.sh) 
ping4ret=$?
log "Check IPv4 Ping: $ping4ret / $ping4out"

