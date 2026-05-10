#!/bin/bash
powerstat -aRc 0.5 240 >> /users/Brenda/nginx/core10/data/powerstat.csv &
#sar -P ALL 1 60 >> /users/Brenda/nginx/core10/data/sar.csv &
echo off > /sys/devices/system/cpu/smt/control &
/users/Brenda/cpupower.sh &
sleep 10
systemctl start nginx
pids=$(pidof nginx)

for pid in $pids; do
        taskset -cp 0-9 $pid
        perf stat -p $pid >> /users/Brenda/nginx/core10/data/perf.txt 2>&1 &
done

sleep 120
systemctl stop nginx
