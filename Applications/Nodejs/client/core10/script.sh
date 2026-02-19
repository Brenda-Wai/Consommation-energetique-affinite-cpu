#!/bin/bash

sleep 10
tcpdump -i eno2 -s 0 -tt -n port 3000 -w /users/Brenda/client/nodejs/core10/capture.pcap &
PID=$!
sleep 10
#ab -n 50000 -g /users/Brenda/client/data/data1.tsv http://10.10.1.1:80/ 
#ab -n 50000 http://10.10.1.1:80/
ab -n 60 http://10.10.1.1:3000/heavy?n=5000000
sleep 60
kill $PID 2>/dev/null
