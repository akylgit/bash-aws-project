#!/bin/bash
	echo "Add your age"
read age
if [[ $age -ge 0 ]] && [[ $age -lt 12 ]]; then
	echo "You are still baby"
    elif [[ $age -ge 12 ]] && [[ $age -lt 18 ]]; then
	echo "You are minor"
    elif [[ $age -ge 18 ]] && [[ $age -lt 60 ]]; then
	echo " You are man"
    else
	echo "You are old man"	
fi
