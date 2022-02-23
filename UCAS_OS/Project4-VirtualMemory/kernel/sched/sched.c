#include <os/list.h>
#include <os/mm.h>
#include <os/lock.h>
#include <os/sched.h>
#include <os/smp.h>
#include <os/time.h>
#include <os/irq.h>
#include <screen.h>
#include <os/stdio.h>
#include <os/elf.h>
#include <assert.h>

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

    if(last_pcb == cpu_pcb_pointer[mycpu_id]){
        choose_index=1-mycpu_id;
    }else{
        choose=(last_pcb->node).next;
        for(;;){
            if(choose==&(last_pcb->node)){
                break;
            }
            if(choose==NULL||choose==&ready_queue){
                choose=ready_queue.next;
            }else{
                choose_index=choose->index;
                if(pcb[choose_index].status==TASK_READY&&(pcb[choose_index].bound_on_cpu==-1||pcb[choose_index].bound_on_cpu==mycpu_id)){
                    break;
                }else{
                    choose=choose->next;
                }
            }
        }
        choose_index=choose->index;
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

    //here we are in user's pg_dir
    if(last_pcb->pg_dir != current_running[mycpu_id]->pg_dir){
        set_satp(SATP_MODE_SV39, current_running[mycpu_id]->pid, (unsigned long)(kva2pa(current_running[mycpu_id]->pg_dir) >> NORMAL_PAGE_SHIFT) & PFN_MASK);
        local_flush_tlb_all();
    }

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
    //NOTICE: we assume that 32 pcbs are enough
    int i;
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
    }
    pcb[process_id].pid=process_id;
    return process_id;
}

void set_pcb_ready(int index){
    pcb[index].status=TASK_READY;

    if(pcb[index].hang_on==&exit_queue){
        move_node(&(pcb[index].node),&ready_queue,&exit_queue);
        pcb[index].hang_on=&ready_queue;
        return;
    }

    pcb[index].hang_on=&ready_queue;

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
    /*int index=alloc_new_pcb();
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
    set_pcb_ready(index);*/

    return process_id++;
}

void do_prior(int prior){
    //uint64_t current_time=get_ticks();
    int mycpu_id=get_current_cpu_id();
    current_running[mycpu_id]->prior_time=timer+(prior+1)*(TIMER_INTERVAL);
}

pid_t do_spawn(task_info_t *task, void* arg, spawn_mode_t mode){
    /*int index=alloc_new_pcb();
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
    //do_scheduler();*/

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

    dealloc_uvm(delete_pcb->pg_dir);

    switch_init_kdir();

    unmap_kvm(delete_pcb->pg_dir);

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

// NOTICE: We haven't released lock yet!!!
// Kill another core is NOT supported!
// If zombie is killed, then it just exits
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
    if(pcb[i].status==TASK_RUNNING){//on another core
        return -1;
    }

    //Now we need to kill thread
    found=0;
    int j;
    for(j=0;j<NUM_MAX_TASK;j++){
        if(pcb[j].pg_dir==pcb[i].pg_dir&&j!=i){
            found=1;
            break;
        }
    }
    if(found==1){
        if(pcb[j].status==TASK_RUNNING){
            return -1;
        }
    }

    if((pcb[i].wait_list).index>0){
        release_wait_list(&(pcb[i].wait_list));
    }
    move_node(&(pcb[i].node),&exit_queue,pcb[i].hang_on);
    pcb[i].status=TASK_EXITED;
    pcb[i].hang_on=&exit_queue;
    //this pcb can't be current_running
    //so in ready_queue, block_queue or zombie queue

    pcb[i].kernel_sp=pcb[i].kernel_stack_base;
    pcb[i].user_sp=pcb[i].user_stack_base;

    lock_exit(&(pcb[i]));

    if(found==1&&pcb[j].status!=TASK_EXITED){
        if((pcb[j].wait_list).index>0){
            release_wait_list(&(pcb[j].wait_list));
        }
        move_node(&(pcb[j].node),&exit_queue,pcb[j].hang_on);
        pcb[j].status=TASK_EXITED;
        pcb[j].hang_on=&exit_queue;

        pcb[j].kernel_sp=pcb[j].kernel_stack_base;
        pcb[j].user_sp=pcb[j].user_stack_base;

        lock_exit(&(pcb[j]));
    }

    dealloc_uvm(pcb[i].pg_dir);
    //switch_init_kdir();
    //there's no need to switch since we will go back
    unmap_kvm(pcb[i].pg_dir);

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

void copy_user_arg(int argc, char *argv[], ptr_t kva){
    unsigned long long *_argc = (unsigned long long *)kva;
    *_argc = argc;//8 byte align
    char ***_argv = (char ***)(kva + sizeof(unsigned long long));//point at new argv
    ptr_t k_u_offset = kva - (USER_STACK_ADDR - STACK_VICTIM);

    char **arg = (char **)(kva + sizeof(unsigned long long) + sizeof(char **));//point at new argv[0]
    char *arg_str = (char *)(kva + sizeof(unsigned long long) + sizeof(char **) + argc * sizeof(char *));//point at new argv[0][0]
    int i=0;
    int j=0;
    for(;i<argc;i++){
        arg[i]=(char *)((ptr_t)(&arg_str[j]) - k_u_offset);
        for(int k=0;argv[i][k]!=0;k++){
            arg_str[j]=argv[i][k];
            j++;
        }
        arg_str[j++]=0;
    }
    *_argv = (char **)((ptr_t)(arg) - k_u_offset);
}

pid_t do_exec(const char* file_name, int argc, char* argv[], spawn_mode_t mode){
    int index = alloc_new_pcb();
    if(index<0){
        return -1;
    }

    int mycpu_id=get_current_cpu_id();
    pcb[index].preempt_count=0;
    pcb[index].type=USER_PROCESS;
    //pcb[index].status=TASK_READY;
    pcb[index].cursor_x=0;
    pcb[index].cursor_y=0;
    pcb[index].unsleep_time=0;
    pcb[index].mode=mode;
    pcb[index].bound_on_cpu=-1;

    unsigned char *elf;
    unsigned length;
    uintptr_t entry_point;
    get_elf_file(file_name, (unsigned char**)&elf, &length);

    PTE *pg_dir=alloc_uvm(length);
    //this is a new pg_dir
    //set_satp(SATP_MODE_SV39, 0, PGDIR_PA >> NORMAL_PAGE_SHIFT);
    //local_flush_tlb_all();
    map_kvm(pg_dir);
    //set_satp(SATP_MODE_SV39, 0, PGDIR_PA >> NORMAL_PAGE_SHIFT);
    local_flush_tlb_all();

    entry_point = load_elf((unsigned char*)elf, length, (uintptr_t)pg_dir, get_kva_of);

    init_pcb_stack(pcb[index].kernel_stack_base,pcb[index].user_stack_base,entry_point,&(pcb[index]));

    //NOTICE: assume that argc>0
    ptr_t kva = get_kva_of(USER_STACK_ADDR - STACK_VICTIM, pg_dir) + PAGE_SIZE - STACK_VICTIM;//dest addr
    //when we call get_kva_of, it returns a 4K align addr
    //NOTICE: the order of calculating really matters
    copy_user_arg(argc, argv, kva);

    set_pcb_ready(index);
    pcb[index].pg_dir=pg_dir;

    return process_id++;
}

int do_thread_create(int *id, void (*start_routine)(void*), void *arg){
    int index=alloc_new_pcb();
    if(index<0){
        return -1;
    }

    int mycpu_id=get_current_cpu_id();
    pcb[index].preempt_count=current_running[mycpu_id]->preempt_count;
    pcb[index].type=USER_THREAD;
    pcb[index].cursor_x=current_running[mycpu_id]->cursor_x;
    pcb[index].cursor_y=current_running[mycpu_id]->cursor_y;
    pcb[index].unsleep_time=current_running[mycpu_id]->unsleep_time;
    pcb[index].mode=current_running[mycpu_id]->mode;
    pcb[index].bound_on_cpu=current_running[mycpu_id]->bound_on_cpu;

    //allocate new user stack
    reg_t new_ustack_low = USER_STACK_LOW + PAGE_SIZE;
    //here we only support one thread
    unsigned long long vpn2 = (new_ustack_low >> (NORMAL_PAGE_SHIFT + PPN_BITS + PPN_BITS)) & VPN_MASK;
    unsigned long long vpn1 = (new_ustack_low >> (NORMAL_PAGE_SHIFT + PPN_BITS)) & VPN_MASK;
    unsigned long long vpn0 = (new_ustack_low >> (NORMAL_PAGE_SHIFT)) & VPN_MASK;

    PTE *pg_dir=current_running[mycpu_id]->pg_dir;
    PTE *pme=(PTE *)pa2kva(get_pa(pg_dir[vpn2]));
    PTE *pte=(PTE *)pa2kva(get_pa(pme[vpn1]));
    uintptr_t new_ustack_kva = alloc_ph_page(&(pte[vpn0]));
    kmemset(new_ustack_kva, 0, NORMAL_PAGE_SIZE);
    set_pfn(&(pte[vpn0]), kva2pa(new_ustack_kva) >> NORMAL_PAGE_SHIFT);
    set_attribute(&pte[vpn0], _PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | _PAGE_EXEC | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_USER);
    local_flush_tlb_all();
    pcb[index].pg_dir=pg_dir;

    pcb[index].user_sp=new_ustack_low + PAGE_SIZE - STACK_VICTIM;
    pcb[index].user_stack_base=new_ustack_low + PAGE_SIZE - STACK_VICTIM;

    reg_t entry_point=(reg_t)start_routine;
    init_pcb_stack(pcb[index].kernel_stack_base,pcb[index].user_stack_base,entry_point,&(pcb[index]));
    regs_context_t *process_context=(regs_context_t *)(current_running[mycpu_id]->kernel_stack_base - sizeof(regs_context_t));
    regs_context_t *thread_context=(regs_context_t *)(pcb[index].kernel_stack_base - sizeof(regs_context_t));
    reg_t *process_reg=process_context->regs;
    reg_t *thread_reg=thread_context->regs;
    thread_reg[3]=process_reg[3];
    thread_reg[10]=(reg_t)arg;

    *id=pcb[index].pid;

    set_pcb_ready(index);
    return process_id++;
}