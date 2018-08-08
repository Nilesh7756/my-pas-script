#!/bin/bash


for i in  $2 $3 $4
do
	while true
	do
		status=$(CF_HOME=/tmp/org_0-space_0/ cf app $1 | grep -w "#$i" | awk '{print $2}')
		#status=$(CF_HOME=/tmp/org_0-space_0/ cf app $1 | grep -w "#$i")
		echo "$status"
		if [ "$status" == 'running' ]
		then
			echo "for  app $1 instance $i"
			CF_HOME=/tmp/org_0-space_0/ cf ssh $1 -i $i -c "ping -c 3 50.0.112.3"
			break
		else
			echo "App-instance still not in RUNNING state"
			continue
		fi
	done
done
