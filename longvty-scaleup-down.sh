#!/bin/bash


for i in $(seq 1 5)
do
	cf create-org scale-org-$i
        cf target -o "scale-org-$i"
        cf create-space scale-space-$i
        cf target -o "scale-org-$i" -s "scale-space-$i"
done
