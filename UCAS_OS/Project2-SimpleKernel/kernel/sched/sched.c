#include <os/list.h>
#include <os/mm.h>
#include <os/lock.h>
#include <os/sched.h>
#include <os/time.h>
#include <os/irq.h>
#include <screen.h>
#include <stdio.h>
#include <assert.h>

#define USER_DYNAMIC_START 0x50600000

pcb_t pcb[NUM_MAX_TASK];
const ptr_t pid0_stack = INIT_KERNEL_STACK + PAGE_SIZE;
pcb_t pid0_pcb = {
    .pid = 0,
    .kernel_sp = (ptr_t)pid0_stack,
    .user_sp = (ptr_t)pid0_stack,
    .preempt_count = 0
};

list_head ready_queue;
list_head sleep_queue;
//LIST_HEAD(ready_queue);

/* current running task PCB */
pcb_t * volatile current_running;

/* global process id */
pid_t process_id = 1;

ptr_t kernel_dynamic_start = INIT_KERNEL_STACK + PAGE_SIZE;
ptr_t user_dynamic_start = USER_DYNAMIC_START + PAGE_SIZE;

static inline void assert_supervisor_mode() 
{
   __asm__ __volatile__("csrr x0, sscratch\n"); 
} 

void do_scheduler(void)
{
    // TODO schedule
    // Modify the current_running pointer.
    //assert_supervisor_mode();
    list_node_t * choose;
    int choose_index;
    pcb_t * last_pcb;
    //ready_queue.next==NULL?
    uint64_t scheduler_time=get_timer();
    int scheduler_count;
    int queue_node=sleep_queue.index;
    list_node_t * sleep_node;
    //?
    for(scheduler_count=0,sleep_node=sleep_queue.next;sleep_queue.index>0&&scheduler_count<queue_node;scheduler_count++,sleep_node=sleep_node->next){
        if(pcb[sleep_node->index].unsleep_time<=scheduler_time){
            pcb[sleep_node->index].status=TASK_READY;
            do_unblock(sleep_node);
            sleep_queue.index--;
        }
    }

    choose=ready_queue.next;
    choose_index=choose->index;
    last_pcb=current_running;
    last_pcb->cursor_x=screen_cursor_x;
    last_pcb->cursor_y=screen_cursor_y;
    last_pcb->status=TASK_READY;

    current_running=&pcb[choose_index];
    current_running->status=TASK_RUNNING;

    //put at tail
    //what about pid0?
    choose->next->prev=&ready_queue;
    ready_queue.next=choose->next;

    (ready_queue.prev)->next=choose;
    choose->prev=ready_queue.prev;

    ready_queue.prev=choose;
    choose->next=&ready_queue;

    // restore the current_running's cursor_x and cursor_y
    vt100_move_cursor(current_running->cursor_x,
                      current_running->cursor_y);
    screen_cursor_x = current_running->cursor_x;
    screen_cursor_y = current_running->cursor_y;
    // TODO: switch_to current_running
    //screen_reflush();

    switch_to(last_pcb,current_running);//from external components
}

void do_sleep(uint32_t sleep_time)
{
    // TODO: sleep(seconds)
    // note: you can assume: 1 second = `timebase` ticks
    // 1. block the current_running
    // 2. create a timer which calls `do_unblock` when timeout
    // 3. reschedule because the current_running is blocked.
    current_running->status=TASK_BLOCKED;
    current_running->unsleep_time=sleep_time+get_timer();
    do_block(ready_queue.prev,&sleep_queue);
    sleep_queue.index++;
    do_scheduler();

}

void do_block(list_node_t *pcb_node, list_head *queue)
{
    // TODO: block the pcb task into the block queue
    // at least one node will be in ready_queue (pid0 not included)
    pcb_node->next->prev=pcb_node->prev;
    pcb_node->prev->next=pcb_node->next;
    ready_queue.index--;

    list_node_t * p;
    if(queue->index==0){
        p=queue;
    }else{
        p=queue->prev;
    }
    p->next=pcb_node;
    pcb_node->prev=p;
    pcb_node->next=NULL;
    queue->prev=pcb_node;//tail of queue

    //queue->index++;
}

void do_unblock(list_node_t *pcb_node)
{
    // TODO: unblock the `pcb` from the block queue
    list_node_t * p=pcb_node->prev;
    p->next=pcb_node->next;
    if(pcb_node->next!=NULL){
        pcb_node->next->prev=p;
    }

    pcb_node->prev=ready_queue.prev;
    ready_queue.prev->next=pcb_node;

    ready_queue.prev=pcb_node;
    pcb_node->next=&ready_queue;
}

int do_fork(){
    //NOTE: when push, sp goes low and when pop, sp goes high
    kernel_dynamic_start = (ptr_t)kmalloc(PAGE_SIZE)+PAGE_SIZE;
    user_dynamic_start += PAGE_SIZE;
    ptr_t child_kernel_sp = kernel_dynamic_start;
    ptr_t child_user_sp = user_dynamic_start;

    pcb[process_id].kernel_stack_high=kernel_dynamic_start;
    //pcb[process_id].user_sp=user_dynamic_start;
    pcb[process_id].preempt_count=current_running->preempt_count;

    pcb[process_id].pid=process_id;
    pcb[process_id].type=current_running->type;
    pcb[process_id].status=TASK_READY;
    pcb[process_id].cursor_x=current_running->cursor_x;
    pcb[process_id].cursor_y=current_running->cursor_y;
    pcb[process_id].unsleep_time=current_running->unsleep_time;

    //copy by page (can fp really point at stack bottom?)
    //NOTICE: kernel_high not really 4K aligned!!!(kmalloc)
    ptr_t parent_kernel_high = current_running->kernel_stack_high;
    ptr_t parent_user_high = (((current_running->user_sp)>>12)+1)<<12;
    int kernel_stack_used = parent_kernel_high-current_running->kernel_sp;
    int user_stack_used = parent_user_high-current_running->user_sp;

    // NOTE: context of current running was just pushed, but without switch_to
    child_kernel_sp-=kernel_stack_used;
    child_user_sp-=user_stack_used;

    // Substract first, then store
    kmemcpy(child_kernel_sp, current_running->kernel_sp, kernel_stack_used);
    kmemcpy(child_user_sp, current_running->user_sp, user_stack_used);

    regs_context_t *child_context=(regs_context_t *)child_kernel_sp;
    reg_t * context_reg=child_context->regs;
    context_reg[10]=0;
    //no need to revise sp? and fp?
    context_reg[2]=child_user_sp;
    context_reg[8]=(reg_t)(context_reg[8]-current_running->user_sp+child_user_sp);

    child_kernel_sp-=sizeof(switchto_context_t);
    switchto_context_t *child_switch=(switchto_context_t *)child_kernel_sp;
    reg_t * switchto_reg=child_switch->regs;
    //no need to revise sp?
    switchto_reg[0]=context_reg[1];
    switchto_reg[1]=child_user_sp;
    switchto_reg[2]=context_reg[8];
    switchto_reg[3]=context_reg[9];
    switchto_reg[4]=context_reg[18];
    switchto_reg[5]=context_reg[19];
    switchto_reg[6]=context_reg[20];
    switchto_reg[7]=context_reg[21];
    switchto_reg[8]=context_reg[22];
    switchto_reg[9]=context_reg[23];
    switchto_reg[10]=context_reg[24];
    switchto_reg[11]=context_reg[25];
    switchto_reg[12]=context_reg[26];
    switchto_reg[13]=context_reg[27];

    pcb[process_id].kernel_sp=child_kernel_sp;
    pcb[process_id].user_sp=child_user_sp;

    //put to ready queue?
    //ready_queue.prev always corresponds to current_running?
    list_node_t *ready_last=ready_queue.prev;
    //parent node
    list_node_t *ready_new=(list_node_t *)(kmalloc(sizeof(list_node_t)));
    ready_new->index=process_id;
    ready_new->next=ready_last;
    ready_new->prev=ready_last->prev;

    ready_last->prev->next=ready_new;
    ready_last->prev=ready_new;

    ready_queue.index++;

    /*list_node_t * ready_new=(list_node_t *)(kmalloc(sizeof(list_node_t)));
    ready_new->index=process_id;

    (ready_queue.next)->prev=ready_new;
    ready_new->next=ready_queue.next;
    ready_new->prev=&ready_queue;
    ready_queue.next=ready_new;

    ready_queue.index++;*/


    return process_id++;
}

void do_prior(int prior){
    //uint64_t current_time=get_ticks();
    current_running->prior_time=timer+(prior+1)*(TIMER_INTERVAL);
}
