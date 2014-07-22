#!/bin/sh 
# 
# Initialisierung:
#   cd /var
#   git clone https://github.com/FreiFunkMuenster/gateway-ffms
#   chmod +x update.sh

# Aktualisieren 
cd /var/gateway-ffms
git pull 

# Reload Fastd Config
kill -HUP $(pidof fastd)

# Reload Bind9
service bind9 reload 

# Restart dhcpd
service isc-dhcp-server restart
