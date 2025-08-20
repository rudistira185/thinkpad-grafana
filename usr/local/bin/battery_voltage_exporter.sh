#!/bin/bash

# path ke textfile collector Node Exporter
OUTFILE=/var/lib/node_exporter/textfile_collector/battery_voltage.prom

# baca voltase (microvolt → volt)
if [ -f /sys/class/power_supply/BAT0/voltage_now ]; then
    VOLT=$(cat /sys/class/power_supply/BAT0/voltage_now)
    VOLT=$(echo "scale=2; $VOLT/1000000" | bc)
else
    VOLT=0
fi

# tulis ke file prom
cat <<EOF > $OUTFILE
# HELP battery_voltage_volt Voltage of battery in volts
# TYPE battery_voltage_volt gauge
battery_voltage_volt $VOLT
EOF
