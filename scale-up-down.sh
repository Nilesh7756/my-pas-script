#!/bin/bash



LOGFILE=/home/ubuntu/nsx-logs/nsx-np/scale-down-"$(date +%Y%d%H%M)".log
date > $LOGFILE
num=20

count=1

while [ $count -le $num ]
do
	echo "Login to org 'test-2'\n" >> $LOGFILE
	cf login --skip-ssl-validation -a api.system.pcf.local -u admin -p kgZ8E0D-1g2TFuTpMSWmSN6Qlqt4jLEq -o test-2 >> $LOGFILE
	echo "\n Deleting of App $1 \n" >> $LOGFILE
	cf delete -f $1 >> $LOGFILE
	echo "\n Deleting of App $2" >> $LOGFILE
	cf delete -f $2 >> $LOGFILE

	echo "\n Pushing new app $1" >> $LOGFILE
	cd /tmp/sample_app
	cf push $1 >> $LOGFILE
	echo "Pushing new app $2" >> $LOGFILE
	cf push $2 >> $LOGFILE

	echo "scale of app $1" >> $LOGFILE
	cf scale -i 10 $1 >> $LOGFILE
	echo "scale of app $2" >> $LOGFILE
	cf scale -i 10 $2 >> $LOGFILE

	echo "Sleeping for 15 sec" >> $LOGFILE
	sleep 15
	
	for i in $(seq 0 1 9)
	do
		echo "\n Ping to app $1 instance - $i" >> $LOGFILE
	
		cf ssh $1 -i "$i" -c "ping -c 3 66.10.10.10"  >> $LOGFILE
		
		echo "\n Ping to app $2 instance - $i" >> $LOGFILE
		cf ssh $2 -i "$i" -c "ping -c 3 66.10.10.10"  >> $LOGFILE

	done

	count=`expr $count + 1`
done

