#!/bin/sh

echo "Starting VM"

OUTPUT_FILES="images/"
KERNEL_IMAGE="${OUTPUT_FILES}/ifs.bin"
DISK_IMAGE="${OUTPUT_FILES}/disk-qemu.vmdk"

sudo qemu-system-x86_64 \
--cpu max \
-m 2G \
-drive file=${DISK_IMAGE},if=ide,id=drv0 \
-kernel ${KERNEL_IMAGE} \
-serial mon:stdio \
-device virtio-net-pci,netdev=net0 \
-netdev vmnet-shared,id=net0 \
-no-reboot \
-nographic

