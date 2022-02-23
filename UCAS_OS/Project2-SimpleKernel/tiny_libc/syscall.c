#include <sys/syscall.h>
#include <stdint.h>

static inline void assert_supervisor_mode()
{ 
   __asm__ __volatile__("csrr x0, sscratch\n"); 
} 

void sys_sleep(uint32_t time)
{
    invoke_syscall(SYSCALL_SLEEP,time,IGNORE,IGNORE);
}

//sys_fork by asm

void sys_prior(int prior){
    invoke_syscall(SYSCALL_PRIOR,prior,IGNORE,IGNORE);
}

void sys_write(char *buff)
{
    invoke_syscall(SYSCALL_WRITE,buff,IGNORE,IGNORE);
}

void sys_reflush()
{
    invoke_syscall(SYSCALL_REFLUSH,IGNORE,IGNORE,IGNORE);
}

void sys_move_cursor(int x, int y)
{
    invoke_syscall(SYSCALL_CURSOR,x,y,IGNORE);
}

int sys_getchar(){
    return invoke_syscall(SYSCALL_GETCHAR,IGNORE,IGNORE,IGNORE);
}

long sys_get_timebase()
{
    return invoke_syscall(SYSCALL_GET_TIMEBASE,IGNORE,IGNORE,IGNORE);
}

long sys_get_tick()
{
    return invoke_syscall(SYSCALL_GET_TICK,IGNORE,IGNORE,IGNORE);
}

void sys_yield()
{
    invoke_syscall(SYSCALL_YIELD, IGNORE, IGNORE, IGNORE);
}

int sys_get_mutex(int *key){
    //assert_supervisor_mode();
    return invoke_syscall(SYSCALL_GET_MUTEX,key,IGNORE,IGNORE);
}

int sys_lock_mutex(int handle){
    return invoke_syscall(SYSCALL_LOCK_MUTEX,handle,IGNORE,IGNORE);
}

int sys_unlock_mutex(int handle){
    return invoke_syscall(SYSCALL_UNLOCK_MUTEX,handle,IGNORE,IGNORE);
}

uint32_t sys_get_walltime(uint32_t *time_elapsed){
    return invoke_syscall(SYSCALL_GET_WALLTIME,time_elapsed,IGNORE,IGNORE);
}