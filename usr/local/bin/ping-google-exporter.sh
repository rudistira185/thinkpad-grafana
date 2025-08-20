#!/bin/bash
METRIC_FILE="/var/lib/node_exporter/textfile_collector/ping_google.prom"

# Ping 3 paket, sukses salah satu = OK
if ping -c 3 -W 1 8.8.8.8 &> /dev/null; then
    echo "ping_google_status 1" > "$METRIC_FILE"
else
    echo "ping_google_status 0" > "$METRIC_FILE"
fi
