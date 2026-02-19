#!/bin/bash

output="/users/Brenda/cpu_freq_log.csv"
duree=90

# Nombre de cœurs détectés
num_cpus=$(nproc)

# En-tête de l'output
header="timestamp"
for ((i=0; i<$num_cpus; i++)); do
    header="$header,CPU$i"
done
echo "$header" > "$output"

# Collecte des données
for ((t=1; t<=$duree; t++)); do
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")

    line="$timestamp"
    for ((i=0; i<$num_cpus; i++)); do
        freq=$(cat /sys/devices/system/cpu/cpu$i/cpufreq/scaling_cur_freq 2>/dev/null || echo 0)
        line="$line,$freq"
    done

    echo "$line" >> "$output"
    sleep 1
done


