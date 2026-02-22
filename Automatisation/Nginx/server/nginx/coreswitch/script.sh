#!/bin/bash
powerstat -aRc 0.5 240 >> /users/Brenda/nginx/coreswitch/data/powerstat.csv &
#sar -P ALL 1 60 >> /users/Brenda/nginx/coreswitch/data/sar.csv &
echo off > /sys/devices/system/cpu/smt/control &
/users/Brenda/cpupower.sh &
sleep 10
systemctl start nginx
pids=$(pidof nginx)

for pid in $pids; do
	{
  		for ((i=0; i<60; i++)); do
		cpu=$((i % 28))
		taskset -cp $cpu $pid >/dev/null
		sleep 1
		done
	} &
        perf stat -p $pid >> /users/Brenda/nginx/coreswitch/data/perf.txt 2>&1 &
done

sleep 120
systemctl stop nginx
