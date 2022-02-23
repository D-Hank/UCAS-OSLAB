#include <os/sched.h>
#include <os/sync.h>
#include <os/string.h>

int barrier_num=0;
int semaphore_num=0;
int mbox_num=0;

int do_barrier_init(int *key, unsigned count, int *valid){
    barrier_array[barrier_num].valid=1;
    barrier_array[barrier_num].all_wait_num=count;
    barrier_array[barrier_num].wait_queue.next=NULL;
    barrier_array[barrier_num].wait_queue.prev=NULL;
    barrier_array[barrier_num].wait_queue.index=0;
    *valid=1;
    return barrier_num++;
}

int do_barrier_wait(int handle){
    int mycpu_id=get_current_cpu_id();
    if(barrier_array[handle].wait_queue.index>=barrier_array[handle].all_wait_num-1){
        release_wait_list(&(barrier_array[handle].wait_queue));
    }else{
        current_running[mycpu_id]->status=TASK_BLOCKED;
        current_running[mycpu_id]->hang_on=&(barrier_array[handle].wait_queue);
        move_node(&(current_running[mycpu_id]->node),&(barrier_array[handle].wait_queue),&ready_queue);
        do_scheduler();
    }
    return 0;
}

int do_barrier_destroy(int handle, int *valid){
    //NOTICE: all nodes should be released before this operation!!!
    //wait_queue cleared in release_wait_list()
    barrier_array[handle].all_wait_num=0;
    barrier_array[handle].valid=0;
    *valid=0;
    //barrier_num--;
    return 0;
}

int do_semaphore_init(int *key, int val, int *valid){
    semaphore_array[semaphore_num].valid=1;
    semaphore_array[semaphore_num].total_resources=val;
    semaphore_array[semaphore_num].wait_queue.next=NULL;
    semaphore_array[semaphore_num].wait_queue.prev=NULL;
    semaphore_array[semaphore_num].wait_queue.index=0;
    *valid=1;
    return semaphore_num++;
}

int do_semaphore_up(int handle){//release resource
    list_head *wait_queue=&(semaphore_array[handle].wait_queue);
    if(wait_queue->index>0){
        pcb[wait_queue->next->index].status=TASK_READY;
        pcb[wait_queue->next->index].hang_on=&ready_queue;
        move_node(wait_queue->next,&ready_queue,wait_queue);
    }else{
        semaphore_array[handle].total_resources++;
    }
    return 0;
}

int do_semaphore_down(int handle){//apply for resources
    int mycpu_id=get_current_cpu_id();
    if(semaphore_array[handle].total_resources>0){
        semaphore_array[handle].total_resources--;
    }else{
        current_running[mycpu_id]->status=TASK_BLOCKED;
        current_running[mycpu_id]->hang_on=&(semaphore_array[handle].wait_queue);
        move_node(&(current_running[mycpu_id]->node),&(semaphore_array[handle].wait_queue),&ready_queue);
        do_scheduler();
    }
    return 0;
}

int do_semaphore_destroy(int handle, int *valid){
    semaphore_array[handle].total_resources=0;
    semaphore_array[handle].valid=0;
    *valid=0;
    return 0;
}

int do_mbox_open(char *name){
    int i;
    for(i=0;i<MAX_MBOX;i++){
        if(kstrcmp(name,mbox_array[i].name)==0&&mbox_array[i].valid==1){
            mbox_array[i].reference++;
            return i;
        }
    }

    //not found, create a new one
    mbox_array[mbox_num].valid=1;
    mbox_array[mbox_num].head=0;
    mbox_array[mbox_num].tail=0;
    mbox_array[mbox_num].reference=1;
    mbox_array[mbox_num].name=name;

    mbox_array[mbox_num].send_queue.next=NULL;
    mbox_array[mbox_num].send_queue.prev=NULL;
    mbox_array[mbox_num].send_queue.index=0;

    mbox_array[mbox_num].recv_queue.next=NULL;
    mbox_array[mbox_num].recv_queue.prev=NULL;
    mbox_array[mbox_num].recv_queue.index=0;

    return mbox_num++;
}

void do_mbox_close(int id){
    if(mbox_array[id].valid=0){
        return;
    }

    if(mbox_array[id].reference<=1){
        mbox_array[id].reference=0;
        mbox_array[id].valid=0;
        mbox_array[id].name=NULL;
        mbox_array[id].head=0;
        mbox_array[id].tail=0;
        return;
    }

    mbox_array[id].reference--;
}

int do_mbox_send(int id, void *msg, int msg_length){
    int mycpu_id=get_current_cpu_id();
    if(mbox_array[id].tail>mbox_array[id].head){
        //wait for consumers to finish consuming
        current_running[mycpu_id]->status=TASK_BLOCKED;
        current_running[mycpu_id]->hang_on=&(mbox_array[id].send_queue);
        move_node(&(current_running[mycpu_id]->node),&(mbox_array[id].send_queue),&ready_queue);
        do_scheduler();
    }else{
        //mailbox empty, send message and wake up
        kmemcpy(mbox_array[id].buffer,msg,msg_length);
        mbox_array[id].head=0;
        mbox_array[id].tail=msg_length;
        list_head *wait_queue=&(mbox_array[id].recv_queue);
        if(wait_queue->index>0){
            pcb[wait_queue->next->index].status=TASK_READY;
            pcb[wait_queue->next->index].hang_on=&ready_queue;
            move_node(wait_queue->next,&ready_queue,wait_queue);
        }
    }
    return 0;
}

int do_mbox_recv(int id, void *msg, int msg_length){
    int mycpu_id=get_current_cpu_id();
    if(mbox_array[id].tail<=mbox_array[id].head){
        //wait for producers to produce
        current_running[mycpu_id]->status=TASK_BLOCKED;
        current_running[mycpu_id]->hang_on=&(mbox_array[id].recv_queue);
        move_node(&(current_running[mycpu_id]->node),&(mbox_array[id].recv_queue),&ready_queue);
        do_scheduler();
    }else{
        kmemcpy(msg,mbox_array[id].buffer+mbox_array[id].head,msg_length);
        mbox_array[id].head+=msg_length;
        list_head *wait_queue=&(mbox_array[id].send_queue);
        if(wait_queue->index>0){
            pcb[wait_queue->next->index].status=TASK_READY;
            pcb[wait_queue->next->index].hang_on=&ready_queue;
            move_node(wait_queue->next,&ready_queue,wait_queue);
        }
    }
    return 0;
}
