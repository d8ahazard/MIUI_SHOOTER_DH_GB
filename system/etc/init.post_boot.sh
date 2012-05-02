#!/system/bin/sh

target=`getprop ro.board.platform`

case "$target" in
    "msm8660")
	 echo 50000 > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/sampling_rate
	 echo 50000 > /sys/devices/system/cpu/cpu1/cpufreq/ondemand/sampling_rate
	 echo 90 > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/up_threshold
	 echo 90 > /sys/devices/system/cpu/cpu1/cpufreq/ondemand/up_threshold
	 echo 1 > /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
	 echo 4 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
	 chown system /sys/devices/system/cpu/cpu0/cpufreq/ondemand/sampling_rate
	 chown system /sys/devices/system/cpu/cpu1/cpufreq/ondemand/sampling_rate
	 echo 384000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	 echo 384000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
         chown system /sys/devices/system/cpu/cpu0/online
         chown system /sys/devices/system/cpu/cpu1/online
	 chown root.system /sys/devices/system/cpu/mfreq
	 chmod 220 /sys/devices/system/cpu/mfreq
	 chown root.system /sys/devices/system/cpu/cpu1/online
	 chmod 664 /sys/devices/system/cpu/cpu1/online
         chown system /sys/power/perflock
	 start thermald
	 start mpdecision
	 mount -t debugfs none /sys/kernel/debug
	 echo "NO_NORMALIZED_SLEEPER" > /sys/kernel/debug/sched_features
	 echo "NO_NEW_FAIR_SLEEPERS" > /sys/kernel/debug/sched_features
	 umount /sys/kernel/debug
	/system/xbin/busybox run-parts /system/etc/init.d
        ;;
esac

