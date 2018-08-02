#!/bin/bash


for i in $(seq 1 5)
do
	mkdir /tmp/scale-org-$i
	CF_HOME=/tmp/scale-org-$i cf login --skip-ssl-validation -a api.system.pcf.local -u admin -p kgZ8E0D-1g2TFuTpMSWmSN6Qlqt4jLEq -o scale-org-$i

done
