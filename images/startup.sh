#!/bin/sh

# By default set umask so that services don't accidentally create group/world writable files.
umask 022


echo "---> Starting slogger2"
slogger2
waitfor /dev/slog

echo "---> Starting PCI Services"
 pci-server --config=/proc/boot/pci_server.cfg
waitfor /dev/pci/server_id_1
# Not ideal. Can't set ACLs. Perhaps supplementary groups would be better
chmod a+rx /dev/pci/server_id_1

devc-ser8250 -e

on  -d -t /dev/ser1 ksh -l

fsevmgr

echo "---> Starting devb"
devb-eide  blk cache=64M,auto=partition,vnode=2000,ncache=2000,commit=low
waitfor /dev/hd0 10

echo "---> Mounting file systems"
mount_fs.sh

pipe
waitfor /dev/pipe

echo "---> Configuring networking "
io-sock -m phy -m pci -m usb -d vtnet_pci

if_up -p -r 20 vtnet0
ifconfig vtnet0 up
ifconfig vtnet0 192.168.64.33
sysctl -w net.inet.icmp.bmcastecho=1 > /dev/null

