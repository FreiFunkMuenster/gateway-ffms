#!/usr/bin/env python
import time
import re
import subprocess
import json


# Our IPv6 prefix
prefix6 = '2a03:2260:115:0:'


nodes = {}

output = subprocess.check_output(["alfred-json","-r","158","-f","json","-z"])
data = json.loads(output.decode("utf-8"))

for mac, node in data.items():

    try:
        hostname = re.sub(r'[^a-z0-9\-]',"", node["hostname"].lower()) 
        for address in node["network"]["addresses"]:
            if address.lower().startswith(prefix6):
                nodes[hostname] = address
    except: 
        pass


print("$ORIGIN nodes.ffms.")
print("$TTL 3600	; 1 Stunde")
print("@			IN SOA	localhost. info.freifunk-muenster.de. (")
#print("				" + time.strftime("%Y%m%d%S") + "; serial: wird bei jeder Aenderung inkrementiert (Format: JJJJMMTTVV)")
print("				" + time.strftime("%s") + "; serial: wird bei jeder Aenderung inkrementiert (Format: Unix-Timestamp, damit man auch zwischendurch was aendern kann)")
print("				86400	; refresh: Sekundenabstand, in dem die Slaves anfragen, ob sich etwas geaendert hat")
print("				7200	; retry: Sekundenabstand, in denen ein Slave wiederholt, falls sein Master nicht antwortet")
print("				3600000	; expire: wenn der Master auf einen Zonentransfer-Request nicht reagiert, deaktiviert ein Slave nach dieser Zeitspanne in Sekunden die Zone")
print("				172800	; TTL fuer negatives caching: Analog zum Standard-Caching wird im Cache vermerkt, dass dem zustaendigen Nameserver der Name unbekannt war. Da fuer einen nicht vorhandenen Namen keine TTL existiert, steht sie hier.")
print("				)")
print("")
print("")
print(";AUTHORATIVE NAMESERVER")
print("@			NS	localhost.")
print("")
print("")


for hostname in nodes.keys():

    print(hostname + " 	AAAA	" + nodes[hostname]) 
    print("")

print("")
