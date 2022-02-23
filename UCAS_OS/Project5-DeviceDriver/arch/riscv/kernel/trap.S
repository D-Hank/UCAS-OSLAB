#include <asm.h>
#include <csr.h>

ENTRY(setup_exception)
    /* TODO: 
     * save exception_handler_entry into STVEC
     * enable global exceptions */
    la      a0, exception_handler_entry
    csrw    CSR_STVEC, a0
    csrw    CSR_SIP, zero
    li      a0, SR_SPIE | SR_SIE
    csrs    CSR_SSTATUS, a0
    li      a0, SIE_SSIE | SIE_STIE | SIE_SEIE
    csrs    CSR_SIE, a0

    jr      ra

ENDPROC(setup_exception)
