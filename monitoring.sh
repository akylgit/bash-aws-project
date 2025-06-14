#!/bin/bash

# Slack webhook URL
WEBHOOK_URL="https://hooks.slack.com/services/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"

# Set threshold for disk usage (in %)
THRESHOLD=10

# Get current usage
USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')

# If usage exceeds threshold, send Slack notification
if [ "$USAGE" -gt "$THRESHOLD" ]; then
    MESSAGE=":warning: *Disk usage alert:* $USAGE% used on $(hostname)"
    
    curl -X POST -H 'Content-type: application/json' \
        --data "{\"text\":\"$MESSAGE\"}" \
        "$WEBHOOK_URL"
else
    echo "Disk usage is at $USAGE%, within safe limits."
fi

