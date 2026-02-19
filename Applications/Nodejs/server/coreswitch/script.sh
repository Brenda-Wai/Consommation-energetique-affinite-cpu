#!/bin/bash

powerstat -aRc 0.5 180 >> /users/Brenda/nodejs/coreswitch/data/powerstat.csv &
echo off > /sys/devices/system/cpu/smt/control &
/users/Brenda/cpupower.sh &
sleep 10
node /users/Brenda/nodejs/server.js &
PID=$!
i=0
{
  while kill -0 $PID 2>/dev/null; do
	core=$((i % 28))
	taskset -cp $core $PID >/dev/null
	sleep 1
	i=$((i + 1))
  done
} &
perf stat -p $PID >> /users/Brenda/nodejs/coreswitch/data/perf.txt 2>&1 &
sleep 60
kill $PID 2>/dev/null
sleep 30
mv /users/Brenda/cpu_freq_log.csv /users/Brenda/nodejs/coreswitch/data/
