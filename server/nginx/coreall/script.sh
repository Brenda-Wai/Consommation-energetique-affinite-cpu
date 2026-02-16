#!/bin/bash
powerstat -aRc 0.5 240 >> /users/Brenda/nginx/coreall/data/powerstat.csv &
#sar -P ALL 1 170 >> /users/Brenda/nginx/coreall/data/sar.csv &
echo off > /sys/devices/system/cpu/smt/control &
/users/Brenda/cpupower.sh &
sleep 10
systemctl start nginx
pids=$(pidof nginx)

for pid in $pids; do
        #taskset -cp 0 $pid
	perf stat -p $pid >> /users/Brenda/nginx/coreall/data/perf.txt 2>&1 &
done

#sleep 150
sleep 120
systemctl stop nginx
