/* SPDX-License-Identifier: GPL-2.0-only */
/*
 * Copyright (C) 2012 Regents of the University of California
 */

#include <asm.h>
#include <csr.h>

/* maybe you need another stack for booting? */
.equ boot_stack_top_base, 0x50300000

.section ".entry_function","ax"
ENTRY(_start)
  /* TODO: */
  /* setup C environment for boot.c */
  la    sp, boot_stack_top_base

  /* this should never return */
  csrr  a0, CSR_MHARTID
  call  boot_kernel

loop:
  wfi
  j     loop

END(_start)
