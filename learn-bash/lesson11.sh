#!/bin/bash
logfile="/path/to/update_log_$(date +%F).txt"
sudo apt update && sudo apt upgrade -y >> $logfile 2>&1
if [ $? -eq 0 ]; then
echo "System update successful" >> $logfile
else
echo "System update failed" >> $logfile
fi
