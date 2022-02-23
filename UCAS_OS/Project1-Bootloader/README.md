# Project1 - Bootloader

## Running Tips

在 Linux 命令行下使用 make all 命令构建所有任务，可以在 Makefile 中指定内核和入口地址

## File List

- Makefile: 配置 make
- image: 生成的镜像文件
- createimage.c & createimage: 用于生成镜像文件
- kernel1.c & kernel1: 编写的第 1 个内核，引导时编号为 0，占 4 个扇区
- kernel2.c & kernel2: 编写的第 2 个内核，引导时编号为 1，占 6 个扇区
- kernel_large: 提供的入口地址为 0x50200000 的内核，占 41 个扇区
- bootblock.S & bootblock: 引导程序
- head.S
- run_qemu.sh
- riscv.lds
- include 内的头文件