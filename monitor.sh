#!/bin/bash

if [ "$EUID" != 0 ]; then 
	echo "Please run as root."
fi


# memory usage
function showMem()
{
	total=`free -m | awk '{if(NR==2) printf "%.2fG\n", $2/1024}'`
	echo "Mem Total: $total"
	use=`free -m | awk '{if(NR==2) printf "%.2fG (%.1f%%) \n", $3/1024 ,$3/$2*100}'`
	echo "Mem Use: $use"
	free=`free -m | awk '{if(NR==2) printf "%.2fG (%.1f%%) \n", $4/1024 ,$4/$2*100}'`
	echo "Mem Free: $free"
	cache=`free -m | awk '{if(NR==2) printf "%.2fG (%.1f%%) \n", $6/1024 ,$6/$2*100}'`
	echo "Mem Cache: $cache"
}

showMem

