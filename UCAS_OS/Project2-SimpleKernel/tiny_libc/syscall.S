#include <asm.h>

ENTRY(invoke_syscall)
    /* TODO: */
    add     a7, a0, zero
    add     a0, a1, zero
    add     a1, a2, zero
    add     a2, a3, zero
    ecall
    nop

    jr ra
ENDPROC(invoke_syscall)

ENTRY(sys_fork)
    li      a7, 3#SYSCALL_FORK
    ecall
    nop

    ret
ENDPROC(sys_fork)
