#!/bin/bash
servers=("google.com" "yahoo.com" "bing.com")

for server in "${servers[@]}"; do
    ping -c 4 $server
    if [ $? -eq 0 ]; then
	echo "Ping to $server succesful"
    else
	echo "Ping to $server failed"
    fi
done
