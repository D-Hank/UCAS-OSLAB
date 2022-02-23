#include <asm/sbidef.h>
#include <asm/sbiasm.h>

//#define BOOT_LOADER_SIG_OFFSET 0x1fe
// #define OS_SIZE_LOC (BOOT_LOADER_SIG_OFFSET - 2)
#define OS_SIZE_LOC0 0x1fc
#define OS_SIZE_LOC1 0x1fe

.equ os_size_loc, 0x502001fc

// 1. kernel address (move kernel to here ~)
.equ kernel, 0x50200000

// 2. kernel main address (jmp here to start kernel main!)
.equ kernel_main, 0x50200000

.text
.global main

main:
	// fence on all memory and I/O
	fence

	/* Load the global pointer */
  	.option push
  	.option norelax
  	la gp, __global_pointer$
  	.option pop

	// print a \n to avoid system output error...
	li a0, 10
	SBI_CALL SBI_CONSOLE_PUTCHAR

	// 1) task1 call BIOS print string "It's bootblock!"
	la a0, msg
	SBI_CALL SBI_CONSOLE_PUTSTR

	// 2) task2 call BIOS read kernel in SD card and jump to kernel start

	la a0, choose
	SBI_CALL SBI_CONSOLE_PUTSTR

	call getch
	
	addi t0, a0, -48 # t0 = a0-48
	li a0, kernel
	lhu a1, OS_SIZE_LOC0(a0) #kernel0 size
	li a2, 1 #kernel0 start sector
	li a7, SBI_SD_READ
	bnez t0, kernel1

kernel0:
	j copy  # jump to copy

kernel1:
	add a2, a2, a1 #kernel1 start sector
	lhu a1, OS_SIZE_LOC1(a0)

copy:
	//get end of kernel
	slli t2,a1,9
	add t2,a0,t2
	li t0, kernel_main
	//start address of rest instructions
	auipc t1,0
	lw t3,40(t1)#PC+4
	lw t4,44(t1)#PC+8
	lw t5,48(t1)#PC+12
	lw t6,52(t1)#PC+16
	sw t3,0(t2)#PC+20
	sw t4,4(t2)#PC+24
	sw t5,8(t2)#PC+28
	sw t6,12(t2)#PC+32
	jalr zero,0(t2)#PC+36

	ecall
	nop

	fence.i
	jalr zero,0(t0)

// while(1) --> stop here
stop:
	j stop
	nop

.data

getch:
	li		a0,0
	li		a1,0
	li		a2,0
	li		a7,2
	ecall
	slliw	a5,a0,0x18
	sraiw	a5,a5,0x18#low 8 bit (signed)
	bltz	a5,getch
	andi	a0,a0,255#low 8 bit
	ret

msg: .string "It's a bootloader...\n\r"

choose: .string "Input 0 to choose kernel 0, else kernel 1: \n\r"

