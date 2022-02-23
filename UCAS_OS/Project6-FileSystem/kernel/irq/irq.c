#include <os/irq.h>
#include <os/time.h>
#include <os/sched.h>
#include <os/string.h>
#include <os/stdio.h>
#include <os/smp.h>
#include <os/mm.h>
#include <net.h>
#include <assert.h>
#include <sbi.h>
#include <screen.h>

#include <emacps/xemacps_example.h>
#include <plic.h>

handler_t irq_table[IRQC_COUNT];
handler_t exc_table[EXCC_COUNT];
uintptr_t riscv_dtb;

long long unsigned timer=TIMER_BASE;

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
    unsigned long long current_time=get_ticks();
    int mycpu_id=get_current_cpu_id();
    sbi_set_timer(current_time+time_base/INT_PER_SEC);
    if(current_time>current_running[mycpu_id]->prior_time){
        do_scheduler();
    }
    //prior_time default value will be zero
}

void interrupt_helper(regs_context_t *regs, uint64_t stval, uint64_t cause)
{
    //assert_supervisor_mode();
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
    if(net_recv_queue.index>0){
        check_recv();
    }
    if(net_send_queue.index>0){
        check_send();
    }
    reset_irq_timer();
    //printk("2\n");
}

void handle_pgfault(regs_context_t *regs, uint64_t interrupt, uint64_t cause)
{
    //assert(0);
    //handle_other(regs,interrupt,cause);
    if(cause == EXCC_INST_PAGE_FAULT){
        do_exit();
    }else{
        int mycpu_id = get_current_cpu_id();
        alloc_page_helper(regs->sbadaddr, current_running[mycpu_id]->pg_dir);
    }
}

void handle_irq(regs_context_t *regs, int irq)
{
    // TODO: 
    // handle external irq from network device
    // let PLIC know that handle_irq has been finished
    if(net_recv_queue.index>0){
        check_recv();
        //switch_init_kdir();
        clear_rxsr(&EmacPsInstance);
    }
    if(net_send_queue.index>0){
        check_send();
        //switch_init_kdir();
        clear_txsr(&EmacPsInstance);
    }
    clear_isr(&EmacPsInstance);
    plic_irq_eoi(irq);
    //switch_pgdir_back();
}
// !!! NEW: handle_irq
extern uint64_t read_sip();

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
    irq_table[IRQC_S_EXT           ]=&plic_handle_irq;
    irq_table[10                   ]=&handle_other;
    irq_table[IRQC_M_EXT           ]=&handle_other;

    exc_table[EXCC_INST_MISALIGNED ]=&handle_other;
    exc_table[EXCC_INST_ACCESS     ]=&handle_other;
    exc_table[EXCC_ILLEGAL_INST    ]=&handle_other;
    exc_table[EXCC_BREAKPOINT      ]=&handle_other;

    exc_table[EXCC_LOAD_MISALIGNED ]=&handle_other;
    exc_table[EXCC_LOAD_ACCESS     ]=&handle_other;
    exc_table[EXCC_STORE_MISALIGNED]=&handle_other;
    exc_table[EXCC_STORE_ACCESS    ]=&handle_other;
    exc_table[EXCC_SYSCALL         ]=&handle_syscall;

    exc_table[EXCC_INST_PAGE_FAULT ]=&handle_pgfault;
    exc_table[EXCC_LOAD_PAGE_FAULT ]=&handle_pgfault;
    exc_table[14                   ]=&handle_other;
    exc_table[EXCC_STORE_PAGE_FAULT]=&handle_pgfault;

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
    printk("sstatus: 0x%lx sbadaddr: 0x%lx scause: %lx\n\r",
           regs->sstatus, regs->sbadaddr, regs->scause);
    printk("stval: 0x%lx cause: %lx\n\r",
           stval, cause);
    printk("sepc: 0x%lx\n\r", regs->sepc);
    // printk("mhartid: 0x%lx\n\r", get_current_cpu_id());

    uintptr_t fp = regs->regs[8], sp = regs->regs[2];
    printk("[Backtrace]\n\r");
    printk("  addr: %lx sp: %lx fp: %lx\n\r", regs->regs[1] - 4, sp, fp);
    // while (fp < USER_STACK_ADDR && fp > USER_STACK_ADDR - PAGE_SIZE) {
    while (fp > 0x10000) {
        uintptr_t prev_ra = *(uintptr_t*)(fp-8);
        uintptr_t prev_fp = *(uintptr_t*)(fp-16);

        printk("  addr: %lx sp: %lx fp: %lx\n\r", prev_ra - 4, fp, prev_fp);

        fp = prev_fp;
    }

    assert(0);
}
