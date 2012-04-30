#!/sbin/sh
#sweep2wake.sh by show-p1984
#Features: 
#activate sweep2wake over the kernels cmdline

#Add s2w to the kernels cmdline.
cmdline=$(cat /tmp/boot.img-cmdline)
searchString="s2w="
s2w="s2w=0"
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

