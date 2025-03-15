#!/bin/bash

CORE_LOG="logs/core.log"
FRAG_LOG="logs/fragment.log"

# mengambil data dari core.log
cpu_usages=$(grep 'Core Usage' logs/core.log | sed -n 's/.*Core Usage \[\(.*\)%\].*/\1/p')

total_cpu=0
count=0

for usage in $cpu_usages; do
    if [[ "$usage" =~ ^[0-9]+([.][0-9]+)?$ ]]; then 
        total_cpu=$(echo "$total_cpu + $usage" | bc) 
        ((count++))
    else
        echo "Warning: Data usage invalid: $usage"
    fi
done

if [[ "$count" -eq 0 ]]; then
    echo "Error: No CPU usage found!"
    exit 1
fi

average_cpu=$(perl -E "say sprintf('%.2f', $total_cpu / $count)")

# ambil informasi RAM dari sistem secara langsung
ram_total=$(free -m | awk '/Mem:/ {print $2}') 
ram_used=$(free -m | awk '/Mem:/ {print $3}')
ram_usage=$(perl -E "say sprintf('%.2f', ($ram_used/$ram_total)*100)")

timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# save hasil ke fragment.log
echo "[$timestamp] -- Fragment Usage [${ram_usage}%] -- Fragment Count [$(perl -E "say sprintf('%.2f', $ram_used)") MB] -- Details [Total: ${ram_total} MB, Available: $(($ram_total - $ram_used)) MB]" >> "$FRAG_LOG"

# show
echo "[$timestamp] -- Fragment Usage [${ram_usage}%] -- Fragment Count [$(perl -E "say sprintf('%.2f', $ram_used)") MB] -- Details [Total: ${ram_total} MB, Available: $(($ram_total - $ram_used)) MB]"
