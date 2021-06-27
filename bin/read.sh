#!/bin/bash
if read -t 5 -p "Please enter your name: " name
then
	echo "Hello $name"
else
	echo "Sorry, timeout! "
fi