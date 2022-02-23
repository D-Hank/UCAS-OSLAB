CC = riscv64-unknown-linux-gnu-gcc
HOST_CC = gcc
# CFLAGS = -O2  -fno-pic -fno-builtin -nostdinc -N -o bootblock bootblock.s -nostdlib -e main -Wl,-m -T riscv.lds
CFLAGS = -g -O2  -fno-builtin -nostdlib -T riscv.lds -Iinclude -Wall -mcmodel=medany
DISK = /dev/sdb

BOOTLOADER_ENTRYPOINT = 0x50200000
KERNEL_ENTRYPOINT = 0x50200000

all: createimage image

bootblock: bootblock.S riscv.lds
	${CC} ${CFLAGS} bootblock.S -o bootblock -e main -Ttext=${BOOTLOADER_ENTRYPOINT}

kernel1: kernel1.c head.S riscv.lds
	${CC} ${CFLAGS} kernel1.c head.S -o kernel1 -Ttext=${KERNEL_ENTRYPOINT}

kernel2: kernel2.c head.S riscv.lds
	${CC} ${CFLAGS} kernel2.c head.S -o kernel2 -Ttext=${KERNEL_ENTRYPOINT}

createimage: createimage.c
	${HOST_CC} createimage.c -o createimage -ggdb -Wall

image: bootblock kernel2 createimage
	./createimage --extended bootblock kernel_large kernel2

clean:
	rm -rf bootblock image kernel2 *.o createimage

floppy:
	sudo fdisk -l ${DISK}
	sudo dd if=image of=${DISK}2 conv=notrunc
