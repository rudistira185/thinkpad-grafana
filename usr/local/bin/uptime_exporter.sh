#!/bin/bash
uptime_seconds=$(awk '{print $1}' /proc/uptime)
echo "custom_node_uptime_seconds $uptime_seconds" > /var/lib/node_exporter/textfile_collector/uptime.prom
