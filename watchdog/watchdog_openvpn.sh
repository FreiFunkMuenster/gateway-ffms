#!/bin/bash

# Freifunk Watchdog Scripte - Hauptscript 
# 
# Dieses Script alle 5 Minuten von cron gestartet und überwacht den 
# Status des OpenVPN Tunnels zu MullVAD 

# Initialize and execute checks
source /var/gateway-ffms/watchdog/watchdog_common.sh

if [ $ovpnret -eq 0 ] && [ $rt42ret -eq 0 ] && [ $ping4ret -eq 0 ]; then

  # Everything is OK 
  log "OpenVPN Status: OK" 
  
  exit 0 
fi
  
log "Something is wrong, OpenVPN Status: ERROR" 

if [ $ovpnret -eq 0 ]; then 

  # The routing via OpenVPN is broken but the service is running
  # The service will be stopped until the next script run 
  
  log "Stopping OpenVPN Service"

  stopout=$(service openvpn stop) 
  log "$stopout"

  exit 1  
fi
  
  
# Restart OpenVPN to reinitialize the connection
  
log "Starting OpenVPN Service"

startout=$(service openvpn restart) 
log "$startout"

exit 1
