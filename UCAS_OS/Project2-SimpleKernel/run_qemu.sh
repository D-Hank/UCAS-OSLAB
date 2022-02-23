#!/bin/bash
IMG_PATH=/home/stu/oslab/UCAS_OS/Project2-SimpleKernel/image
sudo /home/stu/OSLab-RISC-V/qemu-4.1.1/riscv64-softmmu/qemu-system-riscv64 -nographic -machine virt -m 256M -kernel /home/stu/OSLab-RISC-V/u-boot/u-boot -drive if=none,format=raw,id=image,file=${IMG_PATH} -device virtio-blk-device,drive=image -smp 2 -s
