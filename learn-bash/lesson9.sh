#!/bin/bash

mkdir dir1
src_dir="./lesson6.sh"
dest_dir="dir1"
tar -czvf $dest_dir/backup_$(date +%F).tar.gz $src_dir
echo "Backup created at $dest_dir"
