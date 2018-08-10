#!/bin/bash


for i in $(seq 0 1 199)
do
	while true
	do
		echo "Get IP from org 'test' and app 'ping-verify' \n"
		live_ip=$(CF_HOME=/tmp/test cf ssh ping-verify -c "ip a | grep -w 'global eth0'" | awk '{print $2}' | cut -d "/" -f1)
		echo "IP from org 'test' and app 'ping-verify': $live_ip \n"
		status=$(CF_HOME=/tmp/test-2 cf app pas-np | grep -w "#$i" | awk '{print $2}')
		echo "app pas-np  is $status"
		if [ "$status" == "running" ]
		then
			echo "for  app $1 instance $i"
			CF_HOME=/tmp/test-2 cf ssh pas-np -i $i -c "ping -c 3 '$live_ip'"
			break
		else
			echo "App-instance still not in RUNNING state"
			continue
		fi
	done
done
