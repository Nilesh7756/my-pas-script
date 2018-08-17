#!/bin/bash

n=1
for i in $(seq 1)
do
	echo "ORG - $i"
	old_url=$(grep ".baseURL" user-files/simulations/computerdatabase/BasicSimulation.scala | cut -d '"' -f2 | cut -d "/" -f3)
	old_url_host=$(grep -w '100.100.100.10' /etc/hosts | awk '{print $2}')
	for j in app web db
	do
		sed -i 's/'$old_url'/app-'$i'.apps1.pcf.local/' user-files/simulations/computerdatabase/BasicSimulation.scala
		sed -i 's/'$old_url_host'/app-'$i'.apps1.pcf.local/' /etc/hosts
		result=$(sh /root/gatling-charts-highcharts-bundle-2.3.1/bin/gatling.sh -s computerdatabase.BasicSimulation | grep "failed")
		echo "URL: $j-$i.apps1.pcf.local --> $result"
		sleep 15
	done
done
