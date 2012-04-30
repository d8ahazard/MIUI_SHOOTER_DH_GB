#!/sbin/sh
#sweep2wake.sh by show-p1984
#Features: 
#activate sweep2wake over the kernels cmdline

#Check for HTC's Screenshot feature and disable it inside the build.prop
#This is a compatibility fix for sweep2unlock (avoids taking screenshots while locking the phone)
if [ -e /system/build.prop ] ; then
	sed -i 's/ro.htc.framework.screencapture = true/ro.htc.framework.screencapture = false/g' /system/build.prop
	sed -i 's/ro.htc.framework.screencapture= true/ro.htc.framework.screencapture = false/g' /system/build.prop
	sed -i 's/ro.htc.framework.screencapture =true/ro.htc.framework.screencapture = false/g' /system/build.prop
	sed -i 's/ro.htc.framework.screencapture=true/ro.htc.framework.screencapture = false/g' /system/build.prop
	#for build.props without that line:
	found=$(find /system/build.prop -type f | xargs grep -oh "ro.htc.framework.screencapture");
	if [ "$found" != 'ro.htc.framework.screencapture' ]; then
		echo "" >> /system/build.prop;
		echo "#disable HTCs Screenshot feature" >> /system/build.prop;
		echo "ro.htc.framework.screencapture = false" >> /system/build.prop;
		echo "" >> /system/build.prop;
	fi
fi

#use button backlight?
val=$(cat /tmp/aroma-data/sweep.prop | cut -d"=" -f2)
case $val in
  1)
    s2w="1"
    ;;
  2)
    s2w="2"
    ;;
  3)
    s2w="0"
    ;;
esac

#Add s2w to the kernels cmdline.
cmdline=$(cat /tmp/boot.img-cmdline)
searchString="s2w="
s2w="s2w="$s2w
case $cmdline in
  "$searchString"* | *" $searchString"*)
   	echo $(cat /tmp/boot.img-cmdline | sed -e 's/s2w=[^ ]\+//')>/tmp/boot.img-cmdline
	echo $(cat /tmp/boot.img-cmdline)\ $s2w>/tmp/boot.img-cmdline
	;;  
  *)
	echo $(cat /tmp/boot.img-cmdline)\ $s2w>/tmp/boot.img-cmdline
	;;
esac
#end s2w

