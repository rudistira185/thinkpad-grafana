#!/bin/bash

# file output untuk node_exporter textfile collector
OUTFILE="/var/lib/node_exporter/textfile_collector/ram.prom"

# ambil data memory dari free
# field: total, used, free (bytes)
read total used free <<< $(free -b | awk '/^Mem:/ {print $2,$3,$4}')

# tulis ke file prometheus
cat <<EOF > "$OUTFILE"
# HELP ram_used_bytes RAM digunakan dalam bytes
# TYPE ram_used_bytes gauge
ram_used_bytes $used

# HELP ram_total_bytes Total RAM
# TYPE ram_total_bytes gauge
ram_total_bytes $total

# HELP ram_used_percent RAM digunakan dalam persen
# TYPE ram_used_percent gauge
ram_used_percent $(awk "BEGIN {printf \"%.2f\", $used/$total*100}")
EOF
