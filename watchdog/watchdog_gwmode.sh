#!/bin/bash

# Freifunk Watchdog Scripte - Gateway Mode
# 
# Dieses Script wird jede Minute von cron gestartet und setzt den
# Gateway-Modus von B.A.T.M.A.N. wenn das Gateway voll funktionsfähig ist 

# Initialize and execute checks
source /var/gateway-ffms/watchdog/watchdog_common.sh

if [ $ovpnret -eq 0 ] && [ $rt42ret -eq 0 ] && [ $ping4ret -eq 0 ]; then

  # Everything is OK the Gateway can be anounced by B.A.T.M.A.N.
    
  log "Gateway Status: OK" 
  
  batctl gw server
  log "New-State (batctl gw): $(batctl gw)"
  
  exit 0 

fi

# Something is wrong ..
# The Gateway anouncement by B.A.T.M.A.N. has to be stopped
  
log "Something is wrong, Gateway Status: ERROR" 

batctl gw off
log "New-State (batctl gw): $(batctl gw)"

exit 1  
  

