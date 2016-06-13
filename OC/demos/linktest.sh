#!/bin/bash
if [[ $1 == a && $2 == b ]] 
	then
echo "test $1"$2
fi

func(){
	echo $#
	echo \"$*\"
	echo \"$@\"
	}

func "$1$2"
