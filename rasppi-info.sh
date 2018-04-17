#!/bin/bash

echo "Distro info..."
cat /proc/version

echo "Disk usage..."
-df -h

echo "partitions..."
cat /proc/partitions

echo "Temperature..."

/opt/vc/bin/vcgencmd measure_temp

echo "Voltages..."

for id in core sdram_c sdram_i sdram_p ; do \
echo -e "$id:\t$(/opt/vc/bin/vcgencmd measure_volts $id)" ; \
done

echo "Mem info..."
cat /proc/meminfo

echo "Cpu Info..."

cat /proc/cpuinfo

echo "Clock speeds..."
for src in arm core h264 isp v3d uart pwm emmc pixel vec hdmi dpi ; do \
echo -e "$src:\t$(/opt/vc/bin/vcgencmd measure_clock $src)" ; \
done

echo "scaling_cur_freq ..."
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
echo "scaling_min_freq ..."
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo "scaling_max_freq ..."
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq

echo "Memory allocated..."
/opt/vc/bin/vcgencmd get_mem arm && /opt/vc/bin/vcgencmd get_mem gpu