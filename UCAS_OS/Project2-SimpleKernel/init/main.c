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
#include <os/sched.h>
#include <os/lock.h>
#include <screen.h>
#include <sbi.h>
#include <stdio.h>
#include <os/time.h>
#include <os/syscall.h>
#include <test.h>

#include <csr.h>

extern void ret_from_exception();
extern void __global_pointer$();

static void init_pcb_stack(
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

static void init_pcb()
{
     /* initialize all of your pcb and add them into ready_queue
     * TODO:
     */
    int32_t task_temp;

    pid0_pcb.type=USER_PROCESS;
    pid0_pcb.status=TASK_READY;
    pid0_pcb.cursor_x=0;
    pid0_pcb.cursor_y=0;

    list_node_t *ready_cur;
    pcb[0]=pid0_pcb;
    list_node_t *ready_last=&ready_queue;
    ready_queue.index=0;
    //pid0 will not be in the queue

    for(task_temp=0;task_temp<num_sched2_tasks;process_id++,task_temp++){
        kernel_dynamic_start=(ptr_t)kmalloc(PAGE_SIZE)+PAGE_SIZE;
        user_dynamic_start+=PAGE_SIZE;
        pcb[process_id].kernel_stack_high=kernel_dynamic_start;
        pcb[process_id].kernel_sp=kernel_dynamic_start;
        pcb[process_id].user_sp=user_dynamic_start;
        pcb[process_id].preempt_count=0;

        pcb[process_id].pid=process_id;
        pcb[process_id].type=sched2_tasks[task_temp]->type;
        pcb[process_id].status=TASK_READY;
        pcb[process_id].cursor_x=0;
        pcb[process_id].cursor_y=0;
        pcb[process_id].unsleep_time=0;

        init_pcb_stack(kernel_dynamic_start,user_dynamic_start,sched2_tasks[task_temp]->entry_point,&(pcb[process_id]));

        //index is the index in pcb array
        ready_cur=(list_node_t *)(kmalloc(sizeof(list_node_t)));
        ready_cur->index=process_id;//index equals to pid here
        ready_cur->prev=ready_last;
        ready_last->next=ready_cur;

        ready_queue.index++;//list head index: number of nodes

        ready_last=ready_cur;
    }

    for(task_temp=0;task_temp<num_lock2_tasks;process_id++,task_temp++){
        kernel_dynamic_start=(ptr_t)kmalloc(PAGE_SIZE)+PAGE_SIZE;
        user_dynamic_start+=PAGE_SIZE;
        pcb[process_id].kernel_stack_high=kernel_dynamic_start;
        pcb[process_id].kernel_sp=kernel_dynamic_start;
        pcb[process_id].user_sp=user_dynamic_start;
        pcb[process_id].preempt_count=0;

        pcb[process_id].pid=process_id;
        pcb[process_id].type=sched2_tasks[task_temp]->type;
        pcb[process_id].status=TASK_READY;
        pcb[process_id].cursor_x=0;
        pcb[process_id].cursor_y=0;
        pcb[process_id].unsleep_time=0;

        init_pcb_stack(kernel_dynamic_start,user_dynamic_start,lock2_tasks[task_temp]->entry_point,&(pcb[process_id]));

        //index is the index in pcb array
        ready_cur=(list_node_t *)(kmalloc(sizeof(list_node_t)));
        ready_cur->index=process_id;//index equals to pid here
        ready_cur->prev=ready_last;
        ready_last->next=ready_cur;

        ready_queue.index++;//list head index: number of nodes

        ready_last=ready_cur;
    }

    for(task_temp=0;task_temp<num_timer_tasks;process_id++,task_temp++){
        kernel_dynamic_start=(ptr_t)kmalloc(PAGE_SIZE)+PAGE_SIZE;
        user_dynamic_start+=PAGE_SIZE;
        pcb[process_id].kernel_stack_high=kernel_dynamic_start;
        pcb[process_id].kernel_sp=kernel_dynamic_start;
        pcb[process_id].user_sp=user_dynamic_start;
        pcb[process_id].preempt_count=0;

        pcb[process_id].pid=process_id;
        pcb[process_id].type=sched2_tasks[task_temp]->type;
        pcb[process_id].status=TASK_READY;
        pcb[process_id].cursor_x=0;
        pcb[process_id].cursor_y=0;
        pcb[process_id].unsleep_time=0;

        init_pcb_stack(kernel_dynamic_start,user_dynamic_start,timer_tasks[task_temp]->entry_point,&(pcb[process_id]));

        //index is the index in pcb array
        ready_cur=(list_node_t *)(kmalloc(sizeof(list_node_t)));
        ready_cur->index=process_id;//index equals to pid here
        ready_cur->prev=ready_last;
        ready_last->next=ready_cur;

        ready_queue.index++;//list head index: number of nodes

        ready_last=ready_cur;
    }

    ready_cur->next=&ready_queue;
    ready_queue.prev=ready_cur;

    /* remember to initialize `current_running`
     * TODO:
     */
    current_running=&pid0_pcb;
    //pcb[0].status=TASK_RUNNING;
}

void print_syscall(uint64_t a0, uint64_t a1, uint64_t a2){
    printk("Unknown syscall with a0: %ld, a1: %ld, a2: %ld\n",a0,a1,a2);
}

static void init_syscall(void)
{
    // initialize system call table.
    syscall[0                   ]=&print_syscall;
    syscall[1                   ]=&print_syscall;
    syscall[SYSCALL_SLEEP       ]=&do_sleep;
    syscall[SYSCALL_FORK        ]=&do_fork;
    syscall[SYSCALL_PRIOR       ]=&do_prior;
    syscall[5                   ]=&print_syscall;
    syscall[6                   ]=&print_syscall;
    syscall[SYSCALL_YIELD       ]=&do_scheduler;
    syscall[8                   ]=&print_syscall;
    syscall[9                   ]=&print_syscall;

    syscall[SYSCALL_WRITE       ]=&screen_write;
    syscall[SYSCALL_READ        ]=&print_syscall;
    syscall[SYSCALL_CURSOR      ]=&screen_move_cursor;
    syscall[SYSCALL_REFLUSH     ]=&screen_reflush;
    syscall[SYSCALL_GETCHAR     ]=&getch;

    syscall[SYSCALL_GET_TIMEBASE]=&get_time_base;
    syscall[SYSCALL_GET_TICK    ]=&get_ticks;
    syscall[SYSCALL_GET_WALLTIME]=&get_walltime;

    syscall[SYSCALL_GET_MUTEX   ]=&get_mutex;
    syscall[SYSCALL_LOCK_MUTEX  ]=&lock_mutex;
    syscall[SYSCALL_UNLOCK_MUTEX]=&unlock_mutex;
}

// jump from bootloader.
// The beginning of everything >_< ~~~~~~~~~~~~~~
int main()
{
    // init Process Control Block (-_-!)
    init_pcb();
    //printk("> [INIT] PCB initialization succeeded.\n\r");

    // read CPU frequency
    time_base = sbi_read_fdt(TIMEBASE);

    // init interrupt (^_^)
    init_exception();
    printk("> [INIT] Interrupt processing initialization succeeded.\n\r");

    // init system call table (0_0)
    init_syscall();
    printk("> [INIT] System call initialized successfully.\n\r");

    // fdt_print(riscv_dtb);

    // init screen (QAQ)
    init_screen();
    printk("> [INIT] SCREEN initialization succeeded.\n\r");

    // init sleep_queue
    sleep_queue.index=0;
    sleep_queue.prev=NULL;
    sleep_queue.next=NULL;

    // TODO:
    // Setup timer interrupt and enable all interrupt
    sbi_set_timer(TIMER_BASE);

    //printk("4004004004004004004\n");

    while (1) {
        // (QAQQQQQQQQQQQ)
        // If you do non-preemptive scheduling, you need to use it
        // to surrender control do_scheduler();
        disable_interrupt();
        // __asm__ __volatile__("wfi\n\r":::);
        do_scheduler();
    };
    return 0;
}
