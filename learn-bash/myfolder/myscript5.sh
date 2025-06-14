#!/bin/bash

echo "Add phone model"
read brand
case $brand in
    samsung)
	echo "discount for phone $brand - 30%" ;;
    nokia)
	echo "discount for phone $brand - 10%";;
    huawei)
	echo "discount for phone $brand - 20%";;
    *)
	echo " No discount for such phones"
esac
	
