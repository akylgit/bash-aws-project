#!/bin/bash

firstcounter=1
while [ $firstcounter -le 5 ]
do
    echo "Counter: $firstcounter"
    ((firstcounter++))
done

secondcounter=10
while [ $secondcounter -ge 1 ]
do
	echo "Counter: $secondcounter"
	((secondcounter--))
done
