#!/bin/bash

for user in user1 user2 user3
do
	sudo adduser $user
	echo "User $user added"
done
