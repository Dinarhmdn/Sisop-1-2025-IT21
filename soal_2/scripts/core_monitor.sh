#!/bin/bash

LOG_FILE="./logs/core.log"

echo "Monitoring CPU usage every 5 seconds..."
echo "Press 'CTRL+C' to stop."

while true; do
    # jumlah core CPU yang aktif
    num_cores=$(nproc)

    # persentase CPU usage
    cpu_usage=$(top -bn1 | awk '/Cpu\(s\):/ {print $2 + $4}')

    # model CPU
    cpu_model=$(lscpu | grep "Model name" | sed -E 's/Model name:\s+//')

    timestamp=$(date "+%Y-%m-%d %H:%M:%S")

    # simpan hasil monitoring
    echo "[$timestamp] -- Core Usage [${cpu_usage}%] -- Terminal Model [$cpu_model]" >> "$LOG_FILE"

    # tampilkan hasil ke terminal
    echo "[$timestamp] -- Core Usage: ${cpu_usage}%, CPU Model: $cpu_model"

    sleep 5
done
