#!/bin/bash

for file in output.txt input.txt error.txt
do
    rm-r $file
        echo "deleted files: $file"
done
