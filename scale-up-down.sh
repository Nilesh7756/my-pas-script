#!/bin/bash

echo "Please provide count to execute WHILE in loop:"

read num

echo "num 20"
count=1

while [ $count -le $num ]
do
	echo "Deleting of App"
	cf delete -f $1
	cf delete -f $2

	echo "Pushing new app"
	cd /tmp/sample_app
	cf push $1
	cf push $2

	echo "scale of app"
	cf scale -i 50 $1
	cf scale -i 50 $2

	sleep 15
	
	for i in $(seq 0 1 49)
	do
		echo "Ping to app $1 instance - $i"
	
		cf ssh $1 -i "$i" -c "ping -c 3 66.10.10.10" |  grep 'packet loss' | awk '{print $6 " " $7 " " $8}'
		
		echo "Ping to app $2 instance - $i"
		cf ssh $2 -i "$i" -c "ping -c 3 66.10.10.10" |  grep 'packet loss' | awk '{print $6 " " $7 " " $8}'

	done

	count=`expr $count + 1`
done

