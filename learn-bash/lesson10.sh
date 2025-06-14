#!/bin/bash
for file in *.txt; do
mv "$file" /home/file_management.lg
echo "Moved $file to destination" >> file_management.log
done
