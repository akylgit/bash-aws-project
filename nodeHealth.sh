#!/bin/bash



################################
#MetaData:

#Author: AK
#Data:06/13/2025	
#
#This script outputs the node health
#
#Version: v1
################################

set -x # debug mode
set -e # exit the script when there is an error
set -o pipefail

asfasfsafsfdsfs | echo
df -h


free -g


nproc

ps -ef | grep amazon | awk -F " " '{print $2}'
