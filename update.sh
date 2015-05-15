#!/bin/bash 
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


# Restart nrpe
service nagios-nrpe-server reload


