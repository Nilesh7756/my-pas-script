#!/bin/bash


for i in $(seq 4 5)
do 
	cd /tmp/sample_app
	CF_HOME=/tmp/scale-org-$i cf push scale-app-$i-1 
	CF_HOME=/tmp/scale-org-$i cf push scale-app-$i-2 
	CF_HOME=/tmp/scale-org-$i cf push scale-app-$i-3
	CF_HOME=/tmp/scale-org-$i cf scale -i 150 scale-app-$i-1
	CF_HOME=/tmp/scale-org-$i cf scale -i 50 scale-app-$i-2 
	CF_HOME=/tmp/scale-org-$i cf scale -i 50 scale-app-$i-3
	sleep 30
	CF_HOME=/tmp/scale-org-$i cf scale -i 50 scale-app-$i-1
	CF_HOME=/tmp/scale-org-$i cf scale -i 150 scale-app-$i-2
	CF_HOME=/tmp/scale-org-$i cf scale -i 50 scale-app-$i-3
	sleep 30
	CF_HOME=/tmp/scale-org-$i cf scale -i 10 scale-app-$i-1
	CF_HOME=/tmp/scale-org-$i cf scale -i 5 scale-app-$i-2 
	CF_HOME=/tmp/scale-org-$i cf scale -i 100 scale-app-$i-3

	sleep 30

	CF_HOME=/tmp/scale-org-$i cf delete -f scale-app-$i-1
	CF_HOME=/tmp/scale-org-$i cf delete -f scale-app-$i-2 
	CF_HOME=/tmp/scale-org-$i cf delete -f scale-app-$i-3
done
