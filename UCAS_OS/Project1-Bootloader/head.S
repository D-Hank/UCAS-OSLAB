/* SPDX-License-Identifier: GPL-2.0-only */
/*
 * Copyright (C) 2012 Regents of the University of California
 */

#define CSR_SIE			0x104
#define CSR_SIP			0x144
#define KERNEL_STACK		0x50500000

.section ".entry_function","ax"
.global _start
_start:
  /* Mask all interrupts */
  csrw CSR_SIE, zero
  csrw CSR_SIP, zero

  /* Load the global pointer */
  .option push
  .option norelax
  la gp, __global_pointer$
  .option pop
  
  /* Clear BSS for flat non-ELF images */
  la t1, __bss_start
  la t2, __BSS_END__

L1:
  bgeu t1, t2, out_of_L1
  sw x0, (t1)
  /* Notice: alignment is required here */
  addi t1, t1, 4
  j L1

out_of_L1:
  /* setup C environment (set sp register)*/
  li sp, KERNEL_STACK
  /* Jump to the code in kernel.c*/
  j main

loop:
  wfi
  j loop

