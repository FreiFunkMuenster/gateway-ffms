#!/bin/sh 
# 
# Initialisierung:
#   cd /var
#   git clone https://github.com/FreiFunkMuenster/gateway-ffms
#   chmod +x update.sh

set -e
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Aktualisieren 
cd /var/gateway-ffms
git pull 

# Reload Fastd Config
kill -HUP $(pidof fastd)

# Generate Bind DB with Node Names 
rm -f /var/tmp/db.nodes.ffms
python /var/gateway-ffms/nodenames.py > /var/tmp/db.nodes.ffms

# Reload Bind9
service bind9 reload 

# Restart dhcpd
service isc-dhcp-server restart

# Restart nrpe
service nagios-nrpe-server restart
