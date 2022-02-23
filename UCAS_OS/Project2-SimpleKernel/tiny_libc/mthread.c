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
