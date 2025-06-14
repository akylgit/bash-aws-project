#!/bin/bash

for dir in dir1 dir2 dir3 dir4 dir5
do
	mkdir $dir
	touch $dir/file.txt
	echo "File created in $dir"
done
