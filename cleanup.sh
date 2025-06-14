#!/bin/bash

# Directory containing log files
LOG_DIR="/var/log/syslog"

# Delete .log files older than 30 days
find "$LOG_DIR" -name "*.log" -type f -mtime +30 -exec rm -f {} \;

# Print confirmation
echo "Old log files deleted from $LOG_DIR."

