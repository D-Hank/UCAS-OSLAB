/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 *            Copyright (C) 2018 Institute of Computing Technology, CAS
 *               Author : Han Shukai (email : hanshukai@ict.ac.cn)
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 *         The kernel's entry, where most of the initialization work is done.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this
 * software and associated documentation files (the "Software"), to deal in the Software
 * without restriction, including without limitation the rights to use, copy, modify,
 * merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit
 * persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * */

#include <common.h>
#include <os/irq.h>
#include <os/mm.h>
//#include <fdt.h>
#include <os/elf.h>
//#include <os/futex.h>
#include <os/ioremap.h>
#include <os/sched.h>
#include <os/lock.h>
#include <os/sync.h>
#include <os/smp.h>
#include <screen.h>
#include <sbi.h>
#include <os/stdio.h>
#include <type.h>
#include <os/time.h>
#include <os/syscall.h>
#include <os/fs.h>
#include <pgtable.h>
#include <context.h>
#include <screen.h>
#include <assert.h>

#include <sbi.h>

#include <plic.h>
#include <emacps/xemacps_example.h>
#include <net.h>

#include <csr.h>

extern void ret_from_exception();
extern void __global_pointer$();

void init_pcb_stack(
    ptr_t kernel_stack, ptr_t user_stack, ptr_t entry_point,
    pcb_t *pcb)
{
    ptr_t top = kernel_stack - sizeof(regs_context_t);

    regs_context_t *pt_regs = (regs_context_t *)top;
    /* TODO: initialization registers
     * note: sp, gp, ra, sepc, sstatus
     * gp should be __global_pointer$
     * To run the task in user mode,
     * you should set corresponding bits of sstatus(SPP, SPIE, etc.).
     */
    reg_t * reg_start=pt_regs->regs;

    reg_start[0]=0;//zero

    reg_start[1]=(reg_t)entry_point;//ra

    reg_start[2]=(reg_t)top;//sp
    reg_start[3]=(reg_t)__global_pointer$;//gp
    //NOTICE: this is kernel gp
    reg_start[4]=0;//tp

    reg_start[5]=0;//t0
    reg_start[6]=0;//t1
    reg_start[7]=0;//t2

    reg_start[8]=0;//s0
    reg_start[9]=0;//s1

    reg_start[10]=0;//a0
    reg_start[11]=0;//a1
    reg_start[12]=0;//a2
    reg_start[13]=0;
    reg_start[14]=0;
    reg_start[15]=0;
    reg_start[16]=0;
    reg_start[17]=0;//a7

    reg_start[18]=0;//s2
    reg_start[19]=0;
    reg_start[20]=0;
    reg_start[21]=0;
    reg_start[22]=0;
    reg_start[23]=0;
    reg_start[24]=0;
    reg_start[25]=0;
    reg_start[26]=0;
    reg_start[27]=0;//s11

    reg_start[28]=0;//t3
    reg_start[29]=0;
    reg_start[30]=0;
    reg_start[31]=0;//t6

    pt_regs->sstatus=0x20;
    pt_regs->sepc=(reg_t)entry_point;
    pt_regs->sbadaddr=0;
    pt_regs->scause=0x8;

    // set sp to simulate return from switch_to
    /* TODO: you should prepare a stack, and push some values to
     * simulate a pcb context.
     */
    // which means, context of the process/thread will be stored on stack
    // when switch to it, CONTEXT and SWITCH_TO_REG should be at the right position
    //ptr_t is also called uint64_t
    top=top-sizeof(switchto_context_t);
    switchto_context_t *pt_switch=(switchto_context_t *)top;
    reg_start=pt_switch->regs;

    reg_start[ 0]=(reg_t)entry_point;//ra
    reg_start[ 1]=(reg_t)top;//sp
    reg_start[ 2]=0;//s0
    reg_start[ 3]=0;
    reg_start[ 4]=0;
    reg_start[ 5]=0;
    reg_start[ 6]=0;
    reg_start[ 7]=0;
    reg_start[ 8]=0;
    reg_start[ 9]=0;
    reg_start[10]=0;
    reg_start[11]=0;
    reg_start[12]=0;
    reg_start[13]=0;//s11

    //REMEMBER to revise sp in PCB
    pcb->kernel_sp=top;
    pcb->user_sp=user_stack;

}

void do_nothing(){
    //NOTICE: when executing this in user mode, $ra will be set as entry_point
    //so if return, we will return to the same function
    return;
}

void init_free_page(){
    for(int i=0;i<PH_PAGE;i++){
        ph_page_array[i].status=PAGE_AVAILAB;
        ph_page_array[i].pte=NULL;
    }

    for(int i=0;i<PGTAB_NUM;i++){
        page_tab_array[i].status=PAGE_AVAILAB;
    }

    for(int i=0;i<SWAP_NUM;i++){
        swap_page_array[i].status=PAGE_AVAILAB;
    }
}

static void init_pcb()
{
     /* initialize all of your pcb and add them into ready_queue
     * TODO:
     */
    pid0_pcb_core0.status=TASK_READY;
    pid0_pcb_core1.status=TASK_READY;

    ptr_t kernel_stack;
    ptr_t user_stack = USER_STACK_ADDR - STACK_VICTIM;

    kernel_stack=(ptr_t)kmalloc(PAGE_SIZE)+PAGE_SIZE;//virtual addr
    pcb[0].kernel_stack_base=kernel_stack;
    pcb[0].kernel_sp=kernel_stack;

    kernel_stack=(ptr_t)kmalloc(PAGE_SIZE)+PAGE_SIZE;
    pcb[0].user_stack_base=kernel_stack;
    pcb[0].user_sp=kernel_stack;
    pcb[0].preempt_count=0;

    pcb[0].pid=0;
    pcb[0].bound_on_cpu=1;
    pcb[0].type=KERNEL_PROCESS;
    pcb[0].status=TASK_READY;
    pcb[0].cursor_x=0;
    pcb[0].cursor_y=0;
    pcb[0].unsleep_time=0;
    pcb[0].mode=AUTO_CLEANUP_ON_EXIT;
    pcb[0].pg_dir=PGDIR_PA;
    //runs on current virtual space
    pcb[0].hang_on=&ready_queue;

    init_pcb_stack(pcb[0].kernel_sp,pcb[0].user_sp,&do_nothing,&(pcb[0]));

    kernel_stack=(ptr_t)kmalloc(PAGE_SIZE)+PAGE_SIZE;
    pcb[1].kernel_stack_base=kernel_stack;
    pcb[1].kernel_sp=kernel_stack;

    pcb[1].user_stack_base=user_stack;
    pcb[1].user_sp=user_stack;
    pcb[1].preempt_count=0;

    pcb[1].pid=1;
    pcb[1].bound_on_cpu=0;
    pcb[1].type=USER_PROCESS;
    pcb[1].status=TASK_READY;
    pcb[1].cursor_x=0;
    pcb[1].cursor_y=0;
    pcb[1].unsleep_time=0;
    pcb[1].mode=AUTO_CLEANUP_ON_EXIT;
    pcb[1].hang_on=&ready_queue;

    unsigned char *elf;
    unsigned length;
    uintptr_t entry_point;
    get_elf_file("shell", (unsigned char**)&elf, &length);

    PTE *pg_dir=alloc_uvm(length);//virtual addr
    map_kvm(pg_dir);
    map_io(pg_dir);

    pcb[1].pg_dir=pg_dir;

    entry_point = load_elf((unsigned char*)elf, length, (uintptr_t)pcb[1].pg_dir, get_kva_of);

    init_pcb_stack(kernel_stack,user_stack,entry_point,&(pcb[1]));

    //index is the index in pcb array
    list_node_t *idle=&(pcb[0].node);
    list_node_t *shell=&(pcb[1].node);
    idle->index=0;
    shell->index=1;

    ready_queue.next=idle;
    idle->prev=&ready_queue;

    idle->next=shell;
    shell->prev=idle;

    shell->next=NULL;
    ready_queue.prev=shell;

    ready_queue.index=2;//list head index: number of nodes

    process_id=2;

    /* remember to initialize `current_running`
     * TODO:
     */
    current_running[0]=&pid0_pcb_core0;
    current_running[1]=&pid0_pcb_core1;
    //pcb[0].status=TASK_RUNNING;

    for(int i=2;i<NUM_MAX_TASK;i++){
        kernel_stack=(ptr_t)kmalloc(PAGE_SIZE)+PAGE_SIZE;
        pcb[i].kernel_stack_base=kernel_stack;
        pcb[i].kernel_sp=kernel_stack;
        pcb[i].user_stack_base=user_stack;
        pcb[i].user_sp=user_stack;

        pcb[i].type=USER_PROCESS;
        pcb[i].status=TASK_EXITED;
        pcb[i].bound_on_cpu=-1;
    }

}

void print_syscall(uint64_t a0, uint64_t a1, uint64_t a2){
    printk("Unknown syscall with a0: %ld, a1: %ld, a2: %ld\n",a0,a1,a2);
}

void do_process_show(){
    int i;
    prints("[PROCESS TABLE]\n");
    for(i=0;i<NUM_MAX_TASK;i++){
        task_status_t status=pcb[i].status;
        if(status==TASK_EXITED){
            continue;
        }
        prints("[%d] PID: %d STATUS : ",i,pcb[i].pid);
        if(status==TASK_BLOCKED){
            prints("BLOCKED");
 
    net_poll_mode = 1;
    // xemacps_example_main();
        }else if(status==TASK_RUNNING){
            prints("RUNNING");
        }else if(status==TASK_READY){
            prints("READY");
        }else if(status==TASK_ZOMBIE){
            prints("ZOMBIE");
        }/*else if(status==TASK_EXITED){
            prints("EXITED\n");
        }*/
        int cpu=pcb[i].bound_on_cpu;
        prints(" Runs on CORE: ");
        if(cpu==-1){
            prints("0 or 1");
        }else{
            prints("%d",cpu);
        }
        prints("\n");
    }
    screen_reflush();
    return;
}

void do_check(){
    latency(10);
}

void do_loop(){
    while(1){
        ;
    }
}

void do_net_test(){
    return;
}

static void init_syscall(void)
{
    // initialize system call table.
    syscall[SYSCALL_EXEC           ]=&do_exec;
    syscall[SYSCALL_EXIT           ]=&do_exit;
    syscall[SYSCALL_SLEEP          ]=&do_sleep;
    syscall[SYSCALL_KILL           ]=&do_kill;
    syscall[SYSCALL_WAITPID        ]=&do_waitpid;
    syscall[SYSCALL_PS             ]=&do_process_show;
    syscall[SYSCALL_GETPID         ]=&do_getpid;
    syscall[SYSCALL_YIELD          ]=&do_scheduler;
    syscall[SYSCALL_FORK           ]=&do_fork;
    syscall[SYSCALL_PRIOR          ]=&do_prior;

    syscall[SYSCALL_FUTEX_WAIT     ]=&do_nothing;
    syscall[SYSCALL_FUTEX_WAKEUP   ]=&do_nothing;

    syscall[12                     ]=&print_syscall;
    syscall[13                     ]=&print_syscall;
    syscall[14                     ]=&print_syscall;
    syscall[15                     ]=&print_syscall;
    syscall[16                     ]=&print_syscall;
    syscall[17                     ]=&print_syscall;
    syscall[18                     ]=&print_syscall;
    syscall[19                     ]=&print_syscall;

    syscall[SYSCALL_WRITE          ]=&screen_write;
    syscall[SYSCALL_READ           ]=&do_nothing;
    syscall[SYSCALL_MOVE_CURSOR    ]=&screen_move_cursor;
    syscall[SYSCALL_GET_CURSOR     ]=&screen_get_cursor;
    syscall[SYSCALL_REFLUSH        ]=&screen_reflush;

    syscall[SYSCALL_SERIAL_READ    ]=&do_nothing;
    syscall[SYSCALL_SERIAL_WRITE   ]=&do_nothing;
    syscall[SYSCALL_READ_SHELL_BUFF]=&do_nothing;
    syscall[SYSCALL_SCREEN_CLEAR   ]=&screen_clear;
    syscall[SYSCALL_GETCHAR        ]=&getch;
    syscall[SYSCALL_PUTCHAR        ]=&port_write_ch;

    syscall[SYSCALL_GET_TIMEBASE   ]=&get_time_base;
    syscall[SYSCALL_GET_TICK       ]=&get_ticks;
    syscall[SYSCALL_GET_WALLTIME   ]=&get_walltime;

    syscall[SYSCALL_GET_MUTEX      ]=&get_mutex;
    syscall[SYSCALL_LOCK_MUTEX     ]=&lock_mutex;
    syscall[SYSCALL_UNLOCK_MUTEX   ]=&unlock_mutex;

    syscall[SYSCALL_GET_CHAR       ]=&do_nothing;

    syscall[SYSCALL_BARRIER_INIT   ]=&do_barrier_init;
    syscall[SYSCALL_BARRIER_WAIT   ]=&do_barrier_wait;
    syscall[SYSCALL_BARRIER_DESTROY]=&do_barrier_destroy;

    syscall[SYSCALL_SEMA_INIT      ]=&do_semaphore_init;
    syscall[SYSCALL_SEMA_UP        ]=&do_semaphore_up;
    syscall[SYSCALL_SEMA_DOWN      ]=&do_semaphore_down;
    syscall[SYSCALL_SEMA_DESTROY   ]=&do_semaphore_destroy;

    syscall[SYSCALL_MBOX_OPEN      ]=&do_mbox_open;
    syscall[SYSCALL_MBOX_CLOSE     ]=&do_mbox_close;
    syscall[SYSCALL_MBOX_SEND      ]=&do_mbox_send;
    syscall[SYSCALL_MBOX_RECV      ]=&do_mbox_recv;

    syscall[SYSCALL_TASKSET        ]=&do_taskset;

    syscall[SYSCALL_SHMPAGEGET     ]=&shm_page_get;
    syscall[SYSCALL_SHMPAGEDT      ]=&shm_page_dt;

    syscall[SYSCALL_BINSEMGET      ]=&do_binsemget;
    syscall[SYSCALL_BINSEMOP       ]=&do_binsemop;

    syscall[SYSCALL_THREAD_CREATE  ]=&do_thread_create;

    syscall[SYSCALL_CHECK          ]=&do_check;
    syscall[SYSCALL_LOOP           ]=&do_loop;

    syscall[SYSCALL_NET_IRQ_MODE   ]=&do_net_irq_mode;
    syscall[SYSCALL_NET_RECV       ]=&do_net_recv;
    syscall[SYSCALL_NET_SEND       ]=&do_net_send;

    syscall[SYSCALL_NET_TEST       ]=&do_net_test;

    syscall[SYSCALL_FOPEN          ]=&do_open;
    syscall[SYSCALL_FWRITE         ]=&do_write;
    syscall[SYSCALL_FREAD          ]=&do_read;
    syscall[SYSCALL_CLOSE          ]=&do_close;

    syscall[SYSCALL_MK_FS          ]=&do_mkfs;
    syscall[SYSCALL_STAT_FS        ]=&do_statfs;

    syscall[SYSCALL_MK_DIR         ]=&do_mkdir;
    syscall[SYSCALL_RM_DIR         ]=&do_rmdir;
    syscall[SYSCALL_LIST_DIR       ]=&do_ls;
    syscall[SYSCALL_CHG_DIR        ]=&do_cd;

    syscall[SYSCALL_MK_NOD         ]=&do_mknod;
    syscall[SYSCALL_CAT            ]=&do_cat;

    syscall[SYSCALL_LINK           ]=&do_link;
    syscall[SYSCALL_UNLINK         ]=&do_unlink;

    syscall[SYSCALL_LSEEK          ]=&do_lseek;

    syscall[SYSCALL_REMAKE         ]=&do_remake;
}

void init_binsem(){
    for(int i=0;i<MAX_LOCK;i++){
        binsem_array[i].binsem_id=0;
        binsem_array[i].lock.lock.status=UNLOCKED;
    }
}

void init_ethernet()
{

    unsigned slcr_bade_addr = 0;
    // get_prop_u32(_dtb, "/soc/slcr/reg", &slcr_bade_addr);
    slcr_bade_addr = sbi_read_fdt(SLCR_BADE_ADDR);
    printk("[slcr] phy: 0x%x\n\r", slcr_bade_addr);

    unsigned ethernet_addr = 0;
    // get_prop_u32(_dtb, "/soc/ethernet/reg", &ethernet_addr);
    ethernet_addr = sbi_read_fdt(ETHERNET_ADDR);
    printk("[ethernet] phy: 0x%x\n\r", ethernet_addr);

    unsigned plic_addr = 0;
    // get_prop_u32(_dtb, "/soc/interrupt-controller/reg", &plic_addr);
    plic_addr = sbi_read_fdt(PLIC_ADDR);
    printk("[plic] plic: 0x%x\n\r", plic_addr);

    unsigned nr_irqs = 0;
    // get_prop_u32(_dtb, "/soc/interrupt-controller/riscv,ndev", &nr_irqs);
    nr_irqs = sbi_read_fdt(NR_IRQS);
    printk("[plic] nr_irqs: 0x%x\n\r", nr_irqs);

    XPS_SYS_CTRL_BASEADDR =
        (uintptr_t)ioremap((unsigned long long)slcr_bade_addr, NORMAL_PAGE_SIZE);
#ifdef BOARD
    xemacps_config.BaseAddress =
        (uintptr_t)ioremap((unsigned long long)ethernet_addr, NORMAL_PAGE_SIZE);
#endif

#ifdef QEMU
    xemacps_config.BaseAddress =
        (uintptr_t)ioremap((unsigned long long)ethernet_addr, 9 * NORMAL_PAGE_SIZE);
    xemacps_config.BaseAddress += 0x8000;
#endif
    uintptr_t _plic_addr =
        (uintptr_t)ioremap((unsigned long long)plic_addr, 0x4000*NORMAL_PAGE_SIZE);
    // XPS_SYS_CTRL_BASEADDR = slcr_bade_addr;
    // xemacps_config.BaseAddress = ethernet_addr;
    xemacps_config.DeviceId        = 0;
    xemacps_config.IsCacheCoherent = 0;

    printk(
        "[slcr_bade_addr] phy:%x virt:%lx\n\r", slcr_bade_addr,
        XPS_SYS_CTRL_BASEADDR);
    printk(
        "[ethernet_addr] phy:%x virt:%lx\n\r", ethernet_addr,
        xemacps_config.BaseAddress);
    printk("[plic_addr] phy:%x virt:%lx\n\r", plic_addr, _plic_addr);
    plic_init(_plic_addr, nr_irqs);
    
    long status = EmacPsInit(&EmacPsInstance);
    if (status != XST_SUCCESS) {
        printk("Error: initialize ethernet driver failed!\n\r");
        assert(0);
    }

    printk("> [INIT] Init ethernet succeeded.\n\r");

    net_poll_mode = 1;
    // xemacps_example_main();

}

// jump from bootloader.
// The beginning of everything >_< ~~~~~~~~~~~~~~
int main(unsigned long mhartid, uintptr_t _dtb)
{
    if(get_current_cpu_id()==1){
        printk("Core 1 is ready...\n\r");
        setup_exception();
        sbi_set_timer(get_ticks()+0x10000);
        enable_interrupt();
        while(1){
            //__asm__ __volatile__("wfi\n\r":::);
            do_nothing();
        }
    }else{
        printk("> [INIT] Press any key to enter:");
        getchar();
        spin_lock_init(&kernel_lock);
    }

    init_free_page();

    // setup timebase
    // fdt_print(_dtb);
    // get_prop_u32(_dtb, "/cpus/cpu/timebase-frequency", &time_base);
    // read CPU frequency
    time_base = sbi_read_fdt(TIMEBASE);

    init_ethernet();

    init_binsem();
    //init_lock();

    // init Process Control Block (-_-!)
    // here we only statically allocate pages for shell and idle
    init_pcb();
    printk("> [INIT] PCB initialization succeeded.\n\r");

    // init system call table (0_0)
    init_syscall();
    printk("> [INIT] System call initialized successfully.\n\r");

    // fdt_print(riscv_dtb);

    // init screen (QAQ)
    init_screen();
    printk("> [INIT] SCREEN initialization succeeded.\n\r");

    init_fs();

    // START FIRST TASK
    cpu_stack_pointer[0]=(ptr_t)pid0_stack_core0;
    cpu_stack_pointer[1]=(ptr_t)pid0_stack_core1;
    cpu_pcb_pointer[0]=(ptr_t)&pid0_pcb_core0;
    cpu_pcb_pointer[1]=(ptr_t)&pid0_pcb_core1;

    // init sleep_queue
    sleep_queue.index=0;
    sleep_queue.prev=NULL;
    sleep_queue.next=NULL;

    exit_queue.index=0;
    exit_queue.prev=NULL;
    exit_queue.next=NULL;

    printk("\n\rCore 0 is ready...\n\r");

    // init interrupt (^_^)
    printk("> [INIT] Interrupt processing initialization succeeded.\n\r");
    init_exception();
    //wakeup_other_hart();
    //setup_exception();
    enable_sum();

    // TODO:
    // Setup timer interrupt and enable all interrupt
    sbi_set_timer(get_ticks()+time_base/INT_PER_SEC);

    //printk("4004004004004004004\n");
    enable_interrupt();

    while (1) {
        // (QAQQQQQQQQQQQ)
        // If you do non-preemptive scheduling, you need to use it
        // to surrender control do_scheduler();
        //disable_interrupt();
        //__asm__ __volatile__("wfi\n\r":::);
        //do_scheduler();
        do_nothing();
    }
    return 0;
}
