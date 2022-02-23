#include <os/syscall.h>

long (*syscall[NUM_SYSCALLS])();

static inline void assert_supervisor_mode()
{ 
   __asm__ __volatile__("csrr x0, sscratch\n"); 
} 

void handle_syscall(regs_context_t *regs, uint64_t interrupt, uint64_t cause)
{
    //assert_supervisor_mode();
    // syscall[fn](arg1, arg2, arg3, arg4)
    regs->sepc = regs->sepc + 4;
    regs->regs[10] = syscall[regs->regs[17]](regs->regs[10],
                                             regs->regs[11],
                                             regs->regs[12],
                                             regs->regs[13]);
}
