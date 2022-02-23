#include <asm/sbidef.h>
#include <asm/sbiasm.h>
#include <csr.h>

//#define BOOT_LOADER_SIG_OFFSET 0x1fe
// #define OS_SIZE_LOC (BOOT_LOADER_SIG_OFFSET - 2)
#define OS_SIZE_LOC0 0x1fc
#define OS_SIZE_LOC1 0x1fe

.equ os_size_loc, 0x502001fc

// 1. kernel address (move kernel to here ~)
.equ kernel, 0x50201000

// 2. kernel main address (jmp here to start kernel main!)
.equ kernel_main, 0x50201000

.text
.global main

main:
	// fence on all memory and I/O
	fence

	// a0 is mhartid, a1 is the pointer of fdt
	csrr	a0, CSR_MHARTID
	move	s0, a0
	move 	s1, a1

	/* Load the global pointer */
  	.option push
  	.option norelax
  	la gp, __global_pointer$
  	.option pop

	// print a \n to avoid system output error...
	li 		a0, 10
	SBI_CALL SBI_CONSOLE_PUTCHAR

	// The core whose mhartid=0 is selected to boot the kernel.
	// Other cores should wait until the kernel's initialization
	// has been finished.
 	move 	a0, s0
	bnez 	a0, secondary

primary:
	// 1) task1 call BIOS print string "It's bootblock!"
	la 		a0, msg
	SBI_CALL SBI_CONSOLE_PUTSTR

	// 2) task2 call BIOS read kernel in SD card and jump to kernel start

	#la 		a0, choose
	#SBI_CALL SBI_CONSOLE_PUTSTR

	call 	getch

	#addi 	t0, a0, -48 # t0 = a0-48

	li		t0, kernel#dest address
	li		t1, 0#sectors already copied
	#li		t2, 1
	li		t3, os_size_loc
	lhu		t3, 0(t3)#kernel size, total/rest sectors
	li		t4, 64#sectors count

copy_start:
	bgt 	t3, t4, 1f

	j		copy_done

1:
	slli	t2, t1, 9
	add		a0, t0, t2
	li		a1, 64
	addi	a2, t1, 1
	li 		a7, SBI_SD_READ

	ecall
	nop

	fence.i

	addi	t1, t1, 64
	addi	t3, t3, -64
	j 		copy_start

copy_done:
	slli	t2, t1, 9
	add		a0, t0, t2
	add		a1, t3, zero
	addi	a2, t1, 1
	li		a7, SBI_SD_READ

	ecall
	nop

	fence.i

	jalr 	zero,0(t0)

secondary:
	#NOTICE: will this be covered???
	/* TODO: 
	 * 1. Mask all interrupts
	 * 2. let stvec pointer to kernel_main
	 * 3. enable software interrupt for ipi
	 */
	fence
	csrw	CSR_SIE, zero
	la		t0, kernel_main
	csrw	CSR_STVEC, t0
	li		t0, SR_SIE
	csrw	CSR_SSTATUS, t0
	li		t0, SIE_SSIE
	csrs 	CSR_SIE, t0

	fence.i

wait_for_wakeup:
	wfi
	j       wait_for_wakeup

// while(1) --> stop here
stop:
	j 		stop
	nop

getch:
	li		a0, 0
	li		a1, 0
	li		a2, 0
	li		a7, 2
	ecall
	slliw	a5, a0, 0x18
	sraiw	a5, a5, 0x18#low 8 bit (signed)
	bltz	a5, getch
	andi	a0, a0, 255#low 8 bit
	ret

.data

msg: .string "It's a bootloader...\n\r"

choose: .string "Input 0 to choose kernel 0, else kernel 1: \n\r"

