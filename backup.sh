#!/bin/bash

# Directories
SOURCE_DIR="/home/vagrant/bash-script/test"
BACKUP_DIR="/home/vagrant/bash-script"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")  # Date format for unique backup name

# Create backup
tar -czf "$BACKUP_DIR/backup_$DATE.tar.gz" -C "$SOURCE_DIR" .

# Print confirmation
echo "Backup completed: $BACKUP_DIR/backup_$DATE.tar.gz"

