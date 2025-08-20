#!/bin/bash
bat0_now=$(cat /sys/class/power_supply/BAT0/energy_now)
bat0_full=$(cat /sys/class/power_supply/BAT0/energy_full)
bat1_now=$(cat /sys/class/power_supply/BAT1/energy_now)
bat1_full=$(cat /sys/class/power_supply/BAT1/energy_full)

bat0_percent=$(( 100 * bat0_now / bat0_full ))
bat1_percent=$(( 100 * bat1_now / bat1_full ))
total_percent=$(( 100 * (bat0_now + bat1_now) / (bat0_full + bat1_full) ))

cat <<EOF
# HELP battery_percent Battery capacity percent per battery
# TYPE battery_percent gauge
battery_percent{battery="BAT0"} $bat0_percent
battery_percent{battery="BAT1"} $bat1_percent
battery_percent{battery="TOTAL"} $total_percent
EOF
