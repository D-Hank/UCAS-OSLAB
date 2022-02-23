#include <stdatomic.h>
#include <mthread.h>
#include <sys/syscall.h>


int mthread_mutex_init(void* handle)
{
    /* TODO: */
    int *id=(int *)handle;
    *id=sys_get_mutex((int *)handle);
    return 0;
}
int mthread_mutex_lock(void* handle) 
{
    /* TODO: */
    return sys_lock_mutex(*(int *)handle);
}
int mthread_mutex_unlock(void* handle)
{
    /* TODO: */
    return sys_unlock_mutex(*(int *)handle);
}

int mthread_barrier_init(void* handle, unsigned count)
{
    // NOTICE: three arguments to make this operation atomic
    // TODO:
    mthread_barrier_t *id_barrier=(mthread_barrier_t *)handle;
    int *id=&(id_barrier->user_barrier);
    int *valid=&(id_barrier->valid);
    *id=sys_barrier_init(id,count,valid);
    return 0;
}

int mthread_barrier_wait(void* handle)
{
    mthread_barrier_t *id_barrier=(mthread_barrier_t *)handle;
    int id=id_barrier->user_barrier;
    return sys_barrier_wait(id);
}

int mthread_barrier_destroy(void* handle)
{
    // NOTICE: three arguments to make this operation atomic
    // All nodes should be released before this operation!!!
    // TODO:
    mthread_barrier_t *id_barrier=(mthread_barrier_t *)handle;
    int id=id_barrier->user_barrier;
    int *valid=&(id_barrier->valid);
    return sys_barrier_destroy(id,valid);
}

int mthread_semaphore_init(void* handle, int val)
{
    // TODO:
    mthread_semaphore_t *id_semaphore=(mthread_semaphore_t *)handle;
    int *id=&(id_semaphore->user_semaphore);
    int *valid=&(id_semaphore->valid);
    *id=sys_semaphore_init(id,val,valid);
    return 0;
}
int mthread_semaphore_up(void* handle)
{
    // TODO:
    mthread_semaphore_t *id_semaphore=(mthread_semaphore_t *)handle;
    int id=id_semaphore->user_semaphore;
    return sys_semaphore_up(id);
}
int mthread_semaphore_down(void* handle)
{
    // TODO:
    mthread_semaphore_t *id_semaphore=(mthread_semaphore_t *)handle;
    int id=id_semaphore->user_semaphore;
    return sys_semaphore_down(id);
}
int mthread_semaphore_destroy(void* handle)
{
    // TODO:
    mthread_semaphore_t *id_semaphore=(mthread_semaphore_t *)handle;
    int id=id_semaphore->user_semaphore;
    int *valid=&(id_semaphore->valid);
    return sys_semaphore_destroy(id,valid);
}
