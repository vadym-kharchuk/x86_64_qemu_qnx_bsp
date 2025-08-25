# x86_64_qemu_qnx_bsp

## Generation and build of QNX image

Before executing - take into account that '--force' argument is used, it may override your unsaved changes
in the current directory.

``` bash
mkqnximage --clean --type=qemu --ip=192.168.0.33 --hostname=qnx803 --root=yes --sshd-pregen=no --ssh-ident=${HOME}/.ssh/id_rsa.pub --valgrind=yes --force
```

If any change added in the customization layer the following command may be used to re-build the image:

``` bash
mkqnximage --build
```

## Host configuration
Networking:
* Not clear yet... *

## BSP fixes

Patches can be found in the 'patches' directory and should be applied from the repo root.
```bash
patch --dry-run -p1 < name.patch
patch -p1 < name.patch
```

Patch '0001-FIX-filesystem-mounts.patch' fixes /boot and /data partitions mounting.
First call of waitfor exits with 'Unable to access /dev/hd0'
Reason: Unknown

## Running QEMU simulation with generated image

```
qemu-system-x86_64 \
-smp 2 \
--cpu max \
-m 1G \
-drive file=disk-qemu.vmdk,if=ide,id=drv0 \
-pidfile qemu.pid \
-kernel ifs.bin \
-serial mon:stdio \
-object rng-random,filename=/dev/urandom,id=rng0 \
-netdev user,id=en0,hostfwd=tcp::2222-:22,hostfwd=tcp::8080-:80,hostfwd=tcp::8443-:443 \
-device virtio-net,netdev=en0 \
-no-reboot
```
