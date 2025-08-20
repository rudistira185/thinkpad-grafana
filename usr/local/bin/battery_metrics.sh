#!/bin/bash
METRIC_FILE="/var/lib/node_exporter/textfile_collector/battery.prom"
BAT_PATH=$(upower -e | grep BAT)

PERCENT=$(upower -i $BAT_PATH | grep percentage | awk '{print $2}' | tr -d '%')
CAPACITY=$(upower -i $BAT_PATH | grep capacity | awk '{print $2}' | tr -d '%')
ENERGY=$(upower -i $BAT_PATH | grep "energy:" | awk '{print $2}')
VOLTAGE=$(upower -i $BAT_PATH | grep voltage | awk '{print $2}')
STATE=$(upower -i $BAT_PATH | grep state | awk '{print $2}')

echo "# HELP laptop_battery_percentage Battery charge percentage" > $METRIC_FILE
echo "# TYPE laptop_battery_percentage gauge" >> $METRIC_FILE
echo "laptop_battery_percentage $PERCENT" >> $METRIC_FILE

echo "# HELP laptop_battery_capacity Battery capacity vs design" >> $METRIC_FILE
echo "# TYPE laptop_battery_capacity gauge" >> $METRIC_FILE
echo "laptop_battery_capacity $CAPACITY" >> $METRIC_FILE

echo "# HELP laptop_battery_energy Battery energy in Wh" >> $METRIC_FILE
echo "# TYPE laptop_battery_energy gauge" >> $METRIC_FILE
echo "laptop_battery_energy $ENERGY" >> $METRIC_FILE

echo "# HELP laptop_battery_voltage Battery voltage in V" >> $METRIC_FILE
echo "# TYPE laptop_battery_voltage gauge" >> $METRIC_FILE
echo "laptop_battery_voltage $VOLTAGE" >> $METRIC_FILE

if [ "$STATE" = "charging" ]; then
    echo "laptop_battery_charging 1" >> $METRIC_FILE
else
    echo "laptop_battery_charging 0" >> $METRIC_FILE
fi
