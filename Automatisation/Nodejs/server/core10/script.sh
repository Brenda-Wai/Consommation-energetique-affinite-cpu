#!/bin/bash

powerstat -aRc 0.5 180 >> /users/Brenda/nodejs/core10/data/powerstat.csv &
echo off > /sys/devices/system/cpu/smt/control &
/users/Brenda/cpupower.sh &
sleep 10
taskset -c 0-9 node /users/Brenda/nodejs/server.js &
PID=$!
perf stat -p $PID >> /users/Brenda/nodejs/core10/data/perf.txt 2>&1 &
sleep 60
kill $PID 2>/dev/null
sleep 30
mv /users/Brenda/cpu_freq_log.csv /users/Brenda/nodejs/core10/data/
