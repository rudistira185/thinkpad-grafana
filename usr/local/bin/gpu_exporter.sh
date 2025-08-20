#!/bin/bash
# gpu_exporter.sh - Export Intel HD 520 GPU metrics to Node Exporter

# Output file untuk Node Exporter textfile_collector
OUTFILE="/var/lib/node_exporter/textfile_collector/gpu.prom"

# Pastikan file kosong sebelum menulis
echo -n "" > "$OUTFILE"

# Ambil GPU frequency saat ini (MHz)
GPU_FREQ=$(cat /sys/class/drm/card0/gt_cur_freq_mhz 2>/dev/null)
GPU_MAX_FREQ=$(cat /sys/class/drm/card0/gt_max_freq_mhz 2>/dev/null)

# Ambil GPU busy/usage (%)
GPU_BUSY=$(cat /sys/class/drm/card0/device/gpu_busy_percent 2>/dev/null)

# Ambil suhu Intel GPU (jika tersedia, biasanya lewat hwmon)
GPU_TEMP=$(cat /sys/class/hwmon/hwmon*/temp*_input 2>/dev/null | head -n1)
# Convert m°C ke °C jika nilainya terlalu besar
if [[ $GPU_TEMP -gt 1000 ]]; then
  GPU_TEMP=$((GPU_TEMP / 1000))
fi

# Tulis ke file metrics
echo "# HELP intel_gpu_frequency_mhz GPU current frequency in MHz" >> "$OUTFILE"
echo "# TYPE intel_gpu_frequency_mhz gauge" >> "$OUTFILE"
echo "intel_gpu_frequency_mhz $GPU_FREQ" >> "$OUTFILE"

echo "# HELP intel_gpu_max_frequency_mhz GPU max frequency in MHz" >> "$OUTFILE"
echo "# TYPE intel_gpu_max_frequency_mhz gauge" >> "$OUTFILE"
echo "intel_gpu_max_frequency_mhz $GPU_MAX_FREQ" >> "$OUTFILE"

echo "# HELP intel_gpu_busy_percent GPU busy percentage" >> "$OUTFILE"
echo "# TYPE intel_gpu_busy_percent gauge" >> "$OUTFILE"
echo "intel_gpu_busy_percent $GPU_BUSY" >> "$OUTFILE"

echo "# HELP intel_gpu_temp_celsius GPU temperature in Celsius" >> "$OUTFILE"
echo "# TYPE intel_gpu_temp_celsius gauge" >> "$OUTFILE"
echo "intel_gpu_temp_celsius $GPU_TEMP" >> "$OUTFILE"
