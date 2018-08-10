#!/bin/bash

LOGFILE=/home/ubuntu/nsx-logs/nsx-np/scale-down-"$(date +%Y%d%H%M)".logs

date > $LOGFILE
uptime >> $LOGFILE

