#!/bin/bash

BAT0_STATUS=$(cat /sys/class/power_supply/BAT0/status)
BAT1_STATUS=$(cat /sys/class/power_supply/BAT1/status)

# Konversi status ke angka (0=Discharging,1=Charging,2=Full,3=Not charging)
case $BAT0_STATUS in
  "Discharging")  BAT0=0 ;;
  "Charging")     BAT0=1 ;;
  "Full")         BAT0=2 ;;
  "Not charging") BAT0=3 ;;
  *) BAT0=-1 ;;
esac

case $BAT1_STATUS in
  "Discharging")  BAT1=0 ;;
  "Charging")     BAT1=1 ;;
  "Full")         BAT1=2 ;;
  "Not charging") BAT1=3 ;;
  *) BAT1=-1 ;;
esac

cat <<EOF > /var/lib/node_exporter/textfile_collector/battery_status.prom
# HELP battery0_status Battery 0 status (0=discharging,1=charging,2=full,3=not charging)
# TYPE battery0_status gauge
battery0_status $BAT0

# HELP battery1_status Battery 1 status (0=discharging,1=charging,2=full,3=not charging)
# TYPE battery1_status gauge
battery1_status $BAT1
EOF
