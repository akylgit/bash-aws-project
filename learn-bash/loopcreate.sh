#!/bin/bash


create multiple file.txt named file1 to file10
for i in {1..10}; do
    rm "file.txt$i"
    echo "Created file.txt: file.txt$i"
done

