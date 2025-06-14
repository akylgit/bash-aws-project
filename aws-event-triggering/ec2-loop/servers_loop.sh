#!/bin/bash

# List of 10 server IPs or hostnames
servers=(
  server1.example.com
  server2.example.com
  server3.example.com
  server4.example.com
  server5.example.com
  server6.example.com
  server7.example.com
  server8.example.com
  server9.example.com
  server10.example.com
)

# Path to your script in the current folder
local_script="/home/vagrant/learn-bash/aws-bash/execute.sh"

# Remote path to copy script to
remote_script="/tmp/execute.sh"

# SSH user (adjust if needed)
ssh_user="ubuntu"

# SSH key (optional if using agent or already authenticated)
# ssh_key="-i ~/.ssh/id.rsa"

# Loop over servers
for server in "${servers[@]}"
do
  echo "===== Connecting to $server ====="

  # Copy the script to the remote server
  scp $local_script $ssh_user@$server:$remote_script

  # Run the script remotely
  ssh $ssh_user@$server "bash $remote_script"

  echo "===== Done with $server ====="
  echo
done

