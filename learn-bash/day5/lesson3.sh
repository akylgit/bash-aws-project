#!/bin/bash

cd dir2
if [ $? -eq 0 ]; then
	echo "Success"
else 
	echo "Failed"
fi
