#!/usr/bin/python

# Check-Script um aus dem Fast-Status-Socket 
# die Anzahl der aktiven Verbindungen auszulesen

import socket
import sys
import json

# Create a UDS socket
sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)

# Connect the socket to the port where the server is listening
server_address = '/tmp/fastd-status'

try:
    # Open socket 
    sock.connect(server_address)

    received_count = 1
    received_data = ""

    # read data from socket 
    while received_count > 0:
        data = sock.recv(1024)
        received_count = len(data)
        received_data += data;

	# close socket and parse json data 
    sock.close();
    received_json = json.loads(received_data);

    connections = 0

	# count connections 
    for item in received_json.items()[2][1].items():
        connection = item[1]
        connections += 1
        #print connection["name"]

	# pront results 
    print "Fastd Connections %d " % connections
	
    if connections < 2:
        # return Critical
        sys.exit(2)
    elif connections < 30:
        # return Warning
        sys.exit(1)
    else:
        # return OK
        sys.exit(0)

except socket.error, msg:
    print msg
    sys.exit(2)

	