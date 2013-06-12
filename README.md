Simple Busybox Initrd Filesystem
================================
This repository contains a simple Busybox root filesystem that is suitable for booting as a ramdisk under any ARM embedded system.

Features
--------
- Stock Busybox 1.21, compiled without modifications
- Mounts /proc, /sys, /d
- Uses mdev (tiny udev) to populate /dev
- Easily customizable to perform specific tasks (just change /etc/profile)

Usage
-----
First, built the ramdisk file by issuing `make`. This will create a `ramdisk.img.gz` file, which is image file you want to boot on. Pass it to your bootloader the set the `initrd` parameter of the kernel accordingly (if working on a fastboot-enabled bootloader, the `fastboot boot` command normally does it for you). Also make sure the `root=/dev/ram rw rdinit=/sbin/init` are present in your kernel command line, and you should have a working shell once you boot.

Feedback and contact
--------------------
Alexandre Courbot <gnurou@gmail.com>