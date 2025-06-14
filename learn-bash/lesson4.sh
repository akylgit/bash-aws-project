#!/bin/bash

myvar="Hello Team"
if [ $myvar == "Hello" ]; then
    echo "Hello!"
elif [ $myvar == "World" ]; then
    echo "World!"
else
    echo "Neither Hello nor World."
fi
