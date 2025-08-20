#!/bin/bash

BAT_PATH=/sys/class/power_supply
OUTPUT=/var/lib/node_exporter/textfile_collector/battery.prom

# Inisialisasi
total_now=0
total_full=0

# Loop semua BAT*
for bat in $BAT_PATH/BAT*; do
    if [ -f "$bat/energy_now" ] && [ -f "$bat/energy_full" ]; then
        now=$(cat "$bat/energy_now")
        full=$(cat "$bat/energy_full")

        total_now=$((total_now + now))
        total_full=$((total_full + full))
    fi
done

# Hitung persen
if [ "$total_full" -gt 0 ]; then
    percent=$((100 * total_now / total_full))
else
    percent=0
fi

# Tulis ke file .prom
cat <<EOF > "$OUTPUT"
# HELP laptop_battery_capacity_percent Total battery percentage across all batteries
# TYPE laptop_battery_capacity_percent gauge
laptop_battery_capacity_percent $percent
EOF
