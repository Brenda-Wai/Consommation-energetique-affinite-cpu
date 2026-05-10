#!/bin/bash

sleep 10
tcpdump -i eno2 -s 0 -tt -n port 80 -w /users/Brenda/core5/capture.pcap &
PID=$!
sleep 10
#ab -n 50000 -g /users/Brenda/client/data/data1.tsv http://10.10.1.1:80/ 
#ab -n 50000 http://10.10.1.1:80/
ab -n 10000 http://10.10.1.2:80/
sleep 15
ab -n 10000 http://10.10.1.2:80/
sleep 15
ab -n 10000 http://10.10.1.2:80/
sleep 15
ab -n 10000 http://10.10.1.2:80/
sleep 15
ab -n 10000 http://10.10.1.2:80/
sleep 40
kill $PID 2>/dev/null
