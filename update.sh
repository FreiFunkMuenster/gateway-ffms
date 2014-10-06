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

# Reload Bind9
service bind9 reload

# Restart nrpe
service nagios-nrpe-server reload

# Generate Bind DB with Node Names 
# Funktion auskommentiert - Dürfen alfred Daten eventuell nur beim Master gelesen werden ?? 
#
#python /var/gateway-ffms/nodenames.py > /var/tmp/db.nodes.ffms.new
#
#RETVAL=$?
#
#if [ $RETVAL -eq 0 ] 
#  then 
#  
#  # Copy generated output 
#  mv /var/tmp/db.nodes.ffms.new /var/tmp/db.nodes.ffms
#
#  # Reload Bind9
#  service bind9 reload
#
#fi 

