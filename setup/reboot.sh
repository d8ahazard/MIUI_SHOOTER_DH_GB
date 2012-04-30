#!/sbin/sh
#reboot.sh by show-p1984
#Features: 
#reboot if wanted

##Check again if we really want to reboot now.
val=$(cat /tmp/aroma-data/reboot.prop | cut -d"=" -f2)
case $val in
  1)
    reboot
    ;;
esac
##end Check again if we really want to reboot now.

