#include <os/list.h>
#include <os/mm.h>
#include <os/lock.h>
#include <os/sched.h>
#include <os/smp.h>
#include <os/time.h>
#include <os/irq.h>
#include <screen.h>
#include <stdio.h>
#include <assert.h>

#define USER_DYNAMIC_START 0x50600000
//#define SLAVE_CORE_OFFSET 0x00200000

pcb_t pcb[NUM_MAX_TASK];
const ptr_t pid0_stack_core0 = INIT_KERNEL_STACK + PAGE_SIZE;
const ptr_t pid0_stack_core1 = INIT_KERNEL_STACK + PAGE_SIZE * 2;
pcb_t pid0_pcb_core0 = {
    .pid = 0,
    .kernel_sp = (ptr_t)pid0_stack_core0,
    .user_sp = (ptr_t)pid0_stack_core0,
    .preempt_count = 0,
    .kernel_stack_base = (ptr_t)pid0_stack_core0,
    .user_stack_base = (ptr_t)pid0_stack_core0,
    .type = USER_PROCESS,
    .cursor_x = 0,
    .cursor_y = 0
};
pcb_t pid0_pcb_core1 = {
    .pid = 0,
    .kernel_sp = (ptr_t)pid0_stack_core1,
    .user_sp = (ptr_t)pid0_stack_core1,
    .preempt_count = 0,
    .kernel_stack_base = (ptr_t)pid0_stack_core1,
    .user_stack_base = (ptr_t)pid0_stack_core1,
    .type = USER_PROCESS,
    .cursor_x = 0,
    .cursor_y = 0
};

list_head ready_queue;
list_head sleep_queue;
list_head exit_queue;
list_head zombie_queue;
//LIST_HEAD(ready_queue);

/* current running task PCB */
pcb_t * volatile current_running[NR_CPUS];

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
    int mycpu_id=get_current_cpu_id();
    list_node_t * choose;
    int choose_index;
    pcb_t * last_pcb;
    //ready_queue.next==NULL?
    unsigned long long scheduler_time=get_timer();
    list_node_t * sleep_node;
    //?
    for(sleep_node=&sleep_queue;sleep_queue.index>0&&sleep_node->next!=NULL;){
        if(pcb[sleep_node->next->index].unsleep_time<=scheduler_time){
            pcb[sleep_node->next->index].status=TASK_READY;
            pcb[sleep_node->next->index].hang_on=&ready_queue;
            move_node(sleep_node->next,&ready_queue,&sleep_queue);
        }else{
            sleep_node=sleep_node->next;
        }
    }

    if(ready_queue.index==0){
        return;
    }

    last_pcb=current_running[mycpu_id];
    last_pcb->cursor_x=screen_cursor_x[mycpu_id];
    last_pcb->cursor_y=screen_cursor_y[mycpu_id];
    if(last_pcb->status==TASK_RUNNING){
        last_pcb->status=TASK_READY;
    }

    choose=(last_pcb->node).next;
    for(;;){
        choose_index=choose->index;
        if(choose==&(last_pcb->node)){
            break;
        }
        if(choose==NULL||choose==&ready_queue){
            choose=ready_queue.next;
        }else if(pcb[choose_index].status==TASK_READY&&(pcb[choose_index].bound_on_cpu==-1||pcb[choose_index].bound_on_cpu==mycpu_id)){
            break;
        }else{
            choose=choose->next;
        }
    }
    current_running[mycpu_id]=&pcb[choose_index];
    current_running[mycpu_id]->status=TASK_RUNNING;

    // restore the current_running's cursor_x and cursor_y
    vt100_move_cursor(current_running[mycpu_id]->cursor_x,
                      current_running[mycpu_id]->cursor_y);
    screen_cursor_x[mycpu_id] = current_running[mycpu_id]->cursor_x;
    screen_cursor_y[mycpu_id] = current_running[mycpu_id]->cursor_y;
    // TODO: switch_to current_running
    screen_reflush();

    switch_to(last_pcb,current_running[mycpu_id]);//from external components
}

void do_sleep(unsigned sleep_time)
{
    int mycpu_id=get_current_cpu_id();
    current_running[mycpu_id]->status=TASK_BLOCKED;
    current_running[mycpu_id]->unsleep_time=sleep_time+get_timer();
    current_running[mycpu_id]->hang_on=&sleep_queue;
    move_node(&(current_running[mycpu_id]->node),&sleep_queue,&ready_queue);
    do_scheduler();

}

void move_node(list_node_t *pcb_node, list_head *dest_queue, list_head *src_queue)
{
    // TODO: block the pcb task into the block queue
    // at least one node will be in ready_queue (pid0 not included)
    list_node_t * prev=pcb_node->prev;
    list_node_t * next=pcb_node->next;
    if(prev!=NULL){
        prev->next=next;
    }else{
        src_queue->next=next;
    }
    if(next!=NULL){//not tail of src_queue
        next->prev=prev;
    }else{//tail of src_queue
        src_queue->prev=prev;
    }
    src_queue->index--;

    list_node_t * p;
    if(dest_queue->index==0){
        p=dest_queue;
    }else{//tail of queue
        p=dest_queue->prev;
    }
    p->next=pcb_node;
    pcb_node->prev=p;
    pcb_node->next=NULL;
    dest_queue->prev=pcb_node;//tail of dest_queue

    dest_queue->index++;
}

int alloc_new_pcb(){
    //NOTICE: we assume that 16 pcbs are enough
    //-----------------------------------NOTICE------------------------------------
    //When using an exited node, we should move it from exit_queue to ready_queue!!!
    //-----------------------------------------------------------------------------
    /*int i;
    int found=0;
    for(i=0;i<NUM_MAX_TASK;i++){
        if(pcb[i].status==TASK_EXITED){
            found=1;
            break;
        }
    }

    if(found==1){//found an empty pcb
        pcb[i].pid=process_id;
        return i;
    }else{//not found: full
        return -1;
    }*/
    pcb[process_id].pid=process_id;
    return process_id;
}

void set_pcb_ready(int index){
    pcb[index].hang_on=&ready_queue;
    pcb[index].status=TASK_READY;

    //first node, jump the queue
    list_node_t *ready_first=ready_queue.next;
    list_node_t *ready_new=&(pcb[index].node);
    ready_new->index=index;
    ready_new->next=ready_first;
    ready_new->prev=&ready_queue;

    ready_first->prev=ready_new;
    ready_queue.next=ready_new;

    ready_queue.index++;
}

int do_fork(){
    //NOTE: when push, sp goes low and when pop, sp goes high
    int index=alloc_new_pcb();
    int mycpu_id=get_current_cpu_id();

    pcb[index].preempt_count=current_running[mycpu_id]->preempt_count;
    pcb[index].bound_on_cpu=current_running[mycpu_id]->bound_on_cpu;

    pcb[index].type=current_running[mycpu_id]->type;
    pcb[index].cursor_x=current_running[mycpu_id]->cursor_x;
    pcb[index].cursor_y=current_running[mycpu_id]->cursor_y;
    pcb[index].unsleep_time=current_running[mycpu_id]->unsleep_time;
    pcb[index].mode=current_running[mycpu_id]->mode;

    //copy by page (can fp really point at stack bottom?)
    //NOTICE: kernel_high not really 4K aligned!!!(kmalloc)
    int kernel_stack_used = current_running[mycpu_id]->kernel_stack_base-current_running[mycpu_id]->kernel_sp;
    int user_stack_used = current_running[mycpu_id]->user_stack_base-current_running[mycpu_id]->user_sp;

    // NOTE: context of current running was just pushed, but without switch_to
    ptr_t child_kernel_sp=pcb[index].kernel_stack_base-kernel_stack_used;
    ptr_t child_user_sp=pcb[index].user_stack_base-user_stack_used;

    // Substract first, then store
    kmemcpy(child_kernel_sp, current_running[mycpu_id]->kernel_sp, kernel_stack_used);
    kmemcpy(child_user_sp, current_running[mycpu_id]->user_sp, user_stack_used);

    regs_context_t *child_context=(regs_context_t *)child_kernel_sp;
    reg_t * context_reg=child_context->regs;
    context_reg[10]=0;
    //no need to revise sp? and fp?
    context_reg[2]=child_user_sp;
    context_reg[8]=(reg_t)(context_reg[8]-current_running[mycpu_id]->user_sp+child_user_sp);

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

    pcb[index].kernel_sp=child_kernel_sp;
    pcb[index].user_sp=child_user_sp;

    //ready_queue.prev always corresponds to current_running?
    set_pcb_ready(index);

    return process_id++;
}

void do_prior(int prior){
    //uint64_t current_time=get_ticks();
    int mycpu_id=get_current_cpu_id();
    current_running[mycpu_id]->prior_time=timer+(prior+1)*(TIMER_INTERVAL);
}

pid_t do_spawn(task_info_t *task, void* arg, spawn_mode_t mode){
    int index=alloc_new_pcb();
    if(index<0){
        return -1;
    }

    int mycpu_id=get_current_cpu_id();
    //pcb[index].pid=process_id;
    pcb[index].preempt_count=0;
    pcb[index].type=task->type;
    //pcb[index].status=TASK_READY;
    pcb[index].cursor_x=0;
    pcb[index].cursor_y=0;
    pcb[index].unsleep_time=0;
    pcb[index].mode=mode;
    pcb[index].bound_on_cpu=current_running[mycpu_id]->bound_on_cpu;
    //pcb[index].hang_on=&ready_queue;

    init_pcb_stack(pcb[index].kernel_stack_base,pcb[index].user_stack_base,task->entry_point,&(pcb[index]));
    ptr_t top=pcb[index].kernel_stack_base-sizeof(regs_context_t);
    regs_context_t *pt_regs=(regs_context_t *)top;
    reg_t *reg=pt_regs->regs;
    reg[10]=arg;

    set_pcb_ready(index);
    //do_scheduler();

    return process_id++;
}

void release_wait_list(list_head *wait_head){
    //NOTICE: at least one node is in this waiting_queue
    list_node_t *p=wait_head->next;//first node
    list_node_t *q=wait_head->prev;//tail
    list_node_t *clear=p;
    for(;clear!=NULL;clear=clear->next){
        pcb[clear->index].hang_on=&ready_queue;
        pcb[clear->index].status=TASK_READY;
    }
    list_node_t *ready_last=ready_queue.prev;
    ready_last->next=p;
    p->prev=ready_last;

    q->next=&ready_queue;
    ready_queue.prev=q;
    ready_queue.index+=wait_head->index;

    wait_head->prev=NULL;
    wait_head->next=NULL;
    wait_head->index=0;
}

void lock_exit(pcb_t *delete_pcb){
    int i;
    for(i=0;i<MAX_LOCK;i++){
        if(lock_array[i].lock.owner==delete_pcb){
            do_mutex_lock_release(&(lock_array[i]));
        }
    }
}

//NOTICE: We haven't released lock yet!!!
//Remember to clear prev and next
void do_exit(void){
    // how to manage the released node? (leak of memory)
    int mycpu_id=get_current_cpu_id();
    pcb_t * delete_pcb=current_running[mycpu_id];
    list_node_t * delete_node=&(delete_pcb->node);

    current_running[mycpu_id]=cpu_pcb_pointer[mycpu_id];

    delete_pcb->kernel_sp=delete_pcb->kernel_stack_base;
    delete_pcb->user_sp=delete_pcb->user_stack_base;
    //leave room for scheduler
    current_running[mycpu_id]->kernel_sp=current_running[mycpu_id]->kernel_stack_base;

    //no need to revise context

    if((delete_pcb->wait_list).index>0){
        release_wait_list(&(delete_pcb->wait_list));
        delete_pcb->status=TASK_EXITED;
        delete_pcb->hang_on=&(exit_queue);
        move_node(delete_node,&(exit_queue),&ready_queue);
    }else if(delete_pcb->mode==ENTER_ZOMBIE_ON_EXIT){
        delete_pcb->status=TASK_ZOMBIE;
        delete_pcb->hang_on=&(zombie_queue);
        move_node(delete_node,&(zombie_queue),&ready_queue);
    }else{
        delete_pcb->status=TASK_EXITED;
        delete_pcb->hang_on=&(exit_queue);
        move_node(delete_node,&(exit_queue),&ready_queue);
    }

    //release kernel lock
    lock_exit(delete_pcb);

    do_scheduler();

}

int do_waitpid(pid_t pid){
    int found=0;
    int i;
    int mycpu_id=get_current_cpu_id();
    for(i=0;i<NUM_MAX_TASK;i++){
        if(pcb[i].pid==pid){
            found=1;
            break;
        }
    }
    if(found==0){
        return -1;
    }
    if(pcb[i].status==TASK_EXITED){
        return -2;
    }
    if(pcb[i].status==TASK_ZOMBIE){
        move_node(&(pcb[i].node),&exit_queue,&zombie_queue);
        pcb[i].status=TASK_EXITED;
        return pid;
    }
    //RUNNING or READY
    current_running[mycpu_id]->status=TASK_BLOCKED;
    current_running[mycpu_id]->hang_on=&(pcb[i].wait_list);
    move_node(&(current_running[mycpu_id]->node),&(pcb[i].wait_list),&ready_queue);
    do_scheduler();
    return pid;
}

//NOTICE: We haven't released lock yet!!!
// Kill another core is NOT supported!
int do_kill(pid_t pid){
    int found=0;
    int i;
    int mycpu_id=get_current_cpu_id();
    if(pid==current_running[mycpu_id]->pid||pid==0||pid==1){
        return -1;
    }
    for(i=0;i<NUM_MAX_TASK;i++){
        if(pcb[i].pid==pid){
            found=1;
            break;
        }
    }
    if(found==0){
        return 0;
    }
    if(pcb[i].status==TASK_EXITED){
        return 0;
    }

    if((pcb[i].wait_list).index>0){
        release_wait_list(&(pcb[i].wait_list));
    }
    move_node(&(pcb[i].node),&exit_queue,pcb[i].hang_on);
    pcb[i].status=TASK_EXITED;
    pcb[i].hang_on=&exit_queue;
    //this pcb can't be current_running
    //so either in ready_queue or block_queue

    pcb[i].kernel_sp=pcb[i].kernel_stack_base;
    pcb[i].user_sp=pcb[i].user_stack_base;

    lock_exit(&(pcb[i]));

    //set NULL will be done when init
    return 1;
}

pid_t do_getpid(){
    int mycpu_id=get_current_cpu_id();
    return current_running[mycpu_id]->pid;
}

int do_taskset(int pid, int cpu){
    if(pid>=process_id){
        return -1;
    }
    pcb[pid].bound_on_cpu=cpu;
    return 1;
}