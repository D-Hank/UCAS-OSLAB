#include <os/lock.h>
#include <os/sched.h>
#include <atomic.h>

int lock_num=0;

static inline void assert_supervisor_mode() 
{ 
   __asm__ __volatile__("csrr x0, sscratch\n"); 
} 

//used for kernel
void do_mutex_lock_init(mutex_lock_t *lock)
{
    //assert_supervisor_mode();
    /* TODO */
    //atomic operations?
    (lock->lock).status=UNLOCKED;
    (lock->lock).owner=NULL;
    (lock->block_queue).next=NULL;
    (lock->block_queue).prev=NULL;
    (lock->block_queue).index=0;
}

void do_mutex_lock_acquire(mutex_lock_t *lock)
{
    /* TODO */
    // ready_queue is global, and the first node of list is current running node
    // a single block_queue for each lock
    // current_running points at current pcb
    int mycpu_id=get_current_cpu_id();
    if((lock->lock).status==LOCKED){
        current_running[mycpu_id]->status=TASK_BLOCKED;
        current_running[mycpu_id]->hang_on=&(lock->block_queue);
        move_node(&(current_running[mycpu_id]->node),&(lock->block_queue),&ready_queue);
        do_scheduler();
    }else{//the lock is not locked
        (lock->lock).status=LOCKED;
        (lock->lock).owner=current_running[mycpu_id];
    }
}

void do_mutex_lock_release(mutex_lock_t *lock)
{
    //not necessary to rescheduler right now
    if((lock->block_queue).index>0){
        //NOTICE: status can't be UNLOCKED now
        //else two processes will assume they both hold the lock
        pcb[((lock->block_queue).next)->index].status=TASK_READY;
        pcb[((lock->block_queue).next)->index].hang_on=&ready_queue;
        move_node((lock->block_queue).next,&ready_queue,&(lock->block_queue));
        (lock->lock).owner=&pcb[((lock->block_queue).next)->index];
    }else{
        (lock->lock).status=UNLOCKED;
        (lock->lock).owner=NULL;
    }
}

int get_mutex(int *key){
    //printk("lock_num=%x\n",lock_num);
    do_mutex_lock_init(&lock_array[lock_num]);
    return lock_num++;
}

int lock_mutex(int handle){
    do_mutex_lock_acquire(&lock_array[handle]);
    return 0;
}

int unlock_mutex(int handle){
    do_mutex_lock_release(&lock_array[handle]);
    return 0;
}

void spin_lock_init(spin_lock_t *lock){
    lock->owner=NULL;
    lock->status=UNLOCKED;
}

void spin_lock_acquire(spin_lock_t *lock){
    while(atomic_cmpxchg(UNLOCKED,LOCKED,&(lock->status))==LOCKED){
        ;
    }
}

void spin_lock_release(spin_lock_t *lock){
    while(atomic_cmpxchg(LOCKED,UNLOCKED,&(lock->status))==UNLOCKED){
        ;
    }
}
