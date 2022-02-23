#!/bin/bash
QEMU_PATH=/home/stu/OSLab-RISC-V/qemu-4.1.1
UBOOT_PATH=/home/stu/OSLab-RISC-V/u-boot
IMG_PATH=/home/stu/oslab/UCAS_OS/Project5-DeviceDriver/image
sudo kill `sudo lsof | grep tun | awk '{print $2}'`
sudo ${QEMU_PATH}/riscv64-softmmu/qemu-system-riscv64 -nographic -machine virt -m 256M -kernel ${UBOOT_PATH}/u-boot -drive if=none,format=raw,id=image,file=${IMG_PATH} -device virtio-blk-device,drive=image -netdev tap,id=mytap,ifname=tap0,script=${QEMU_PATH}/etc/qemu-ifup,downscript=${QEMU_PATH}/etc/qemu-ifdown -device e1000,netdev=mytap -smp 2 -s -S
