#include <os/irq.h>
#include <os/time.h>
#include <os/sched.h>
#include <os/string.h>
#include <stdio.h>
#include <assert.h>
#include <sbi.h>
#include <screen.h>

handler_t irq_table[IRQC_COUNT];
handler_t exc_table[EXCC_COUNT];
uintptr_t riscv_dtb;

long long unsigned timer=TIMER_BASE;

static inline void assert_supervisor_mode()
{ 
   __asm__ __volatile__("csrr x0, sscratch\n"); 
} 

void reset_irq_timer()
{
    // TODO clock interrupt handler.
    // TODO: call following functions when task4
    screen_reflush();
    //screen_clear();
    // timer_check();
    // To check whether reaches executing time
    // note: use sbi_set_timer
    // remember to reschedule
    timer+=TIMER_INTERVAL;
    sbi_set_timer(timer);
    uint64_t current_time=get_ticks();
    if(current_time>current_running->prior_time){
        do_scheduler();
    }
    //prior_time default value will be zero
}

void interrupt_helper(regs_context_t *regs, uint64_t stval, uint64_t cause)
{
    assert_supervisor_mode();
    // TODO interrupt handler.
    // call corresponding handler by the value of `cause`
    //printk("cause=%ld\n",cause);
    //printk("Handling interrupt...\n");
    //printk("------------------------------------\n");
    //printk("SCAUSE: 0x%lx\n",cause);
    //printk("SBADADDR: 0x%lx\n",stval);
    //printk("SEPC: 0x%lx\n",regs->sepc);
    //printk("SSTATUS: 0x%lx\n",regs->sstatus);
    //printk("a7: %lx, a0: %lx, a1: %lx, a2: %lx\n",regs->regs[17],regs->regs[10],regs->regs[11],regs->regs[12]);
    //printk("------------------------------------\n");
    if((cause&0x8000000000000000)==0x8000000000000000){
        //printk("1\n");
        irq_table[cause&0x7FFFFFFFFFFFFFFF](regs, stval, cause);
        //printk("3\n");
    }else{
        exc_table[cause&0x7FFFFFFFFFFFFFFF](regs, stval, cause);
        //regs->sepc+=4;
        //+4 implemented in syscall.c
    }
}

void handle_int(regs_context_t *regs, uint64_t interrupt, uint64_t cause)
{
    reset_irq_timer();
    //printk("2\n");
}

void init_exception()
{
    /* TODO: initialize irq_table and exc_table */
    /* note: handle_int, handle_syscall, handle_other, etc.*/
    // that is, put handling function in the table
    // but no need for call number in the table
    irq_table[IRQC_U_SOFT          ]=&handle_other;
    irq_table[IRQC_S_SOFT          ]=&handle_other;
    irq_table[2                    ]=&handle_other;
    irq_table[IRQC_M_SOFT          ]=&handle_other;

    irq_table[IRQC_U_TIMER         ]=&handle_other;
    irq_table[IRQC_S_TIMER         ]=&handle_int;
    irq_table[6                    ]=&handle_other;
    irq_table[IRQC_M_TIMER         ]=&handle_other;

    irq_table[IRQC_U_EXT           ]=&handle_other;
    irq_table[IRQC_S_EXT           ]=&handle_other;
    irq_table[10                   ]=&handle_other;
    irq_table[11                   ]=&handle_other;

    exc_table[EXCC_INST_MISALIGNED ]=&handle_other;
    exc_table[EXCC_INST_ACCESS     ]=&handle_other;
    exc_table[2                    ]=&handle_other;
    exc_table[EXCC_BREAKPOINT      ]=&handle_other;

    exc_table[4                    ]=&handle_other;
    exc_table[EXCC_LOAD_ACCESS     ]=&handle_other;
    exc_table[EXCC_STORE_ACCESS    ]=&handle_other;
    exc_table[EXCC_SYSCALL         ]=&handle_syscall;

    exc_table[EXCC_INST_PAGE_FAULT ]=&handle_other;
    exc_table[EXCC_LOAD_PAGE_FAULT ]=&handle_other;
    exc_table[14                   ]=&handle_other;
    exc_table[EXCC_STORE_PAGE_FAULT]=&handle_other;

    setup_exception();
}

void handle_other(regs_context_t *regs, uint64_t stval, uint64_t cause)
{
    char* reg_name[] = {
        "zero "," ra  "," sp  "," gp  "," tp  ",
        " t0  "," t1  "," t2  ","s0/fp"," s1  ",
        " a0  "," a1  "," a2  "," a3  "," a4  ",
        " a5  "," a6  "," a7  "," s2  "," s3  ",
        " s4  "," s5  "," s6  "," s7  "," s8  ",
        " s9  "," s10 "," s11 "," t3  "," t4  ",
        " t5  "," t6  "
    };
    for (int i = 0; i < 32; i += 3) {
        for (int j = 0; j < 3 && i + j < 32; ++j) {
            printk("%s : %016lx ",reg_name[i+j], regs->regs[i+j]);
        }
        printk("\n\r");
    }
    printk("sstatus: 0x%lx sbadaddr: 0x%lx scause: %lu\n\r",
           regs->sstatus, regs->sbadaddr, regs->scause);
    printk("sepc: 0x%lx\n\r", regs->sepc);
    assert(0);
}
