#include <os/lock.h>
#include <os/sched.h>
#include <atomic.h>

#define MAX_LOCK 8
mutex_lock_t lock_array[MAX_LOCK];
int lock_num=0;

static inline void assert_supervisor_mode() 
{ 
   __asm__ __volatile__("csrr x0, sscratch\n"); 
} 

//used for kernel
void do_mutex_lock_init(mutex_lock_t *lock)
{
    assert_supervisor_mode();
    /* TODO */
    //atomic operations?
    (lock->lock).status=UNLOCKED;
    (lock->block_queue).next=NULL;
    (lock->block_queue).prev=NULL;
    (lock->block_queue).index=0;
    /*atomic_swap(LOCKED,&((lock->lock).status));
    atomic_swap_d(NULL,&((lock->block_queue).next));
    atomic_swap_d(NULL,&((lock->block_queue).prev));*/
}

void do_mutex_lock_acquire(mutex_lock_t *lock)
{
    /* TODO */
    // ready_queue is global, and the first node of list is current running node
    // a single block_queue for each lock
    // current_running points at current pcb
    if((lock->lock).status==LOCKED){
        current_running->status=TASK_BLOCKED;
        do_block(ready_queue.prev,&(lock->block_queue));
        (lock->block_queue).index++;
        do_scheduler();
    }else{//the lock is not locked
        (lock->lock).status=LOCKED;
    }
}

void do_mutex_lock_release(mutex_lock_t *lock)
{
    /* TODO */
    if((lock->block_queue).index>0){
        pcb[((lock->block_queue).next)->index].status=TASK_READY;
        do_unblock((lock->block_queue).next);
        (lock->block_queue).index--;
    }else{
        (lock->lock).status=UNLOCKED;
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