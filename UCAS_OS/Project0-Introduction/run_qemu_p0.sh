#!/bin/bash
IMG_PATH=/home/stu/project0/test
/home/stu/OSLab-RISC-V/qemu-4.1.1/riscv64-softmmu/qemu-system-riscv64 -nographic -machine virt -m 256M -kernel ${IMG_PATH} -s -S -bios none
