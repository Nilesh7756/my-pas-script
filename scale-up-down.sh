#!/bin/bash

echo "Please provide count to execute WHILE in loop:"

read num

count=1

while [ $count -le $num ]
do
	echo "Deleting of App"
	cf delete -f pas-np

	echo "Pushing new app"
	cd /tmp/sample_app
	cf push pas-np

	echo "scale of app"
	cf scale -i 20 pas-np

	sleep 15
	
	for i in $(seq 0 1 19)
	do
		echo "Ping to app-instance - $i"
		cf ssh pas-np -i "$i" -c "ping -c 3 50.0.112.3"
	done

	count=`expr $count + 1`
done

