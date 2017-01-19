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

# cpu usage
function showCpu()
{
	# vmstat the first output is inaccurate
	eval $(echo `vmstat 1 3 | awk '{if(NR==5) print "total="100-$15"%;user="$13"%;system="$14"%;iowait="$16"%"}'`)
	echo "Cpu Total:" $total
	echo "Cpu User:" $user
	echo "Cpu System:" $system
	echo "Cpu IOWait:" $iowait

	eval $(echo `uptime | awk -F " load average: " '{print $2}'|awk -F ", " '{print "la1="$1";la5="$2";la15="$3}'`)
	echo "Load average 1 min:"$la1", 5 min:"$la5", 15 min:"$la15
}

#showMem
showCpu

