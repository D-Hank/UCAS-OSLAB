#include <sys/syscall.h>
#include <stdint.h>

static inline void assert_supervisor_mode()
{ 
   __asm__ __volatile__("csrr x0, sscratch\n"); 
} 

pid_t sys_spawn(task_info_t *info, void* arg, spawn_mode_t mode)
{
    return invoke_syscall(SYSCALL_SPAWN,info,arg,mode);
}

void sys_exit(void){
    invoke_syscall(SYSCALL_EXIT,IGNORE,IGNORE,IGNORE);
}

void sys_sleep(uint32_t time)
{
    invoke_syscall(SYSCALL_SLEEP,time,IGNORE,IGNORE);
}

int sys_kill(pid_t pid)//return a status
{
    return invoke_syscall(SYSCALL_KILL,pid,IGNORE,IGNORE);
}

int sys_waitpid(pid_t pid)//return a status
{
    return invoke_syscall(SYSCALL_WAITPID,pid,IGNORE,IGNORE);
}

void sys_process_show(void)
{
    invoke_syscall(SYSCALL_PS,IGNORE,IGNORE,IGNORE);
}

pid_t sys_getpid(void)
{
    return invoke_syscall(SYSCALL_GETPID,IGNORE,IGNORE,IGNORE);
}

void sys_yield()
{
    invoke_syscall(SYSCALL_YIELD, IGNORE, IGNORE, IGNORE);
}

//sys_fork by asm

void sys_prior(int prior){
    invoke_syscall(SYSCALL_PRIOR,prior,IGNORE,IGNORE);
}

void sys_futex_wait(volatile uint64_t *val_addr, uint64_t val)
{
    invoke_syscall(SYSCALL_FUTEX_WAIT,IGNORE,IGNORE,IGNORE);
}

void sys_futex_wakeup(volatile uint64_t *val_addr, int num_wakeup){
    invoke_syscall(SYSCALL_FUTEX_WAKEUP,IGNORE,IGNORE,IGNORE);
}

void sys_write(char *buff)
{
    invoke_syscall(SYSCALL_WRITE,buff,IGNORE,IGNORE);
}

void sys_read(){
    invoke_syscall(SYSCALL_READ,IGNORE,IGNORE,IGNORE);
}

void sys_move_cursor(int x, int y)
{
    invoke_syscall(SYSCALL_MOVE_CURSOR,x,y,IGNORE);
}

void sys_get_cursor(int *x,int *y)
{
    invoke_syscall(SYSCALL_GET_CURSOR,x,y,IGNORE);
}

void sys_reflush()
{
    invoke_syscall(SYSCALL_REFLUSH,IGNORE,IGNORE,IGNORE);
}

void sys_screen_clear()
{
    invoke_syscall(SYSCALL_SCREEN_CLEAR,IGNORE,IGNORE,IGNORE);
}

int sys_getchar(){
    while(1){
        char c=invoke_syscall(SYSCALL_GETCHAR,IGNORE,IGNORE,IGNORE);
        if(c>0&&c<=127){
            return c;
        }
    }
}

void sys_putchar(char c)
{
    invoke_syscall(SYSCALL_PUTCHAR,c,IGNORE,IGNORE);
}

long sys_get_timebase()
{
    return invoke_syscall(SYSCALL_GET_TIMEBASE,IGNORE,IGNORE,IGNORE);
}

long sys_get_tick()
{
    return invoke_syscall(SYSCALL_GET_TICK,IGNORE,IGNORE,IGNORE);
}

uint32_t sys_get_walltime(uint32_t *time_elapsed){
    return invoke_syscall(SYSCALL_GET_WALLTIME,time_elapsed,IGNORE,IGNORE);
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

int sys_get_char(){
    return invoke_syscall(SYSCALL_GET_CHAR,IGNORE,IGNORE,IGNORE);
}

int sys_barrier_init(int *key, unsigned count, int *valid){
    return invoke_syscall(SYSCALL_BARRIER_INIT,key,count,valid);
}

int sys_barrier_wait(int handle){
    return invoke_syscall(SYSCALL_BARRIER_WAIT,handle,IGNORE,IGNORE);
}

int sys_barrier_destroy(int handle, int *valid){
    return invoke_syscall(SYSCALL_BARRIER_DESTROY,handle,valid,IGNORE);
}

int sys_semaphore_init(int *key, int val, int *valid){
    return invoke_syscall(SYSCALL_SEMA_INIT,key,val,valid);
}

int sys_semaphore_up(int handle){
    return invoke_syscall(SYSCALL_SEMA_UP,handle,IGNORE,IGNORE);
}

int sys_semaphore_down(int handle){
    return invoke_syscall(SYSCALL_SEMA_DOWN,handle,IGNORE,IGNORE);
}

int sys_semaphore_destroy(int handle, int *valid){
    return invoke_syscall(SYSCALL_SEMA_DESTROY,handle,valid,IGNORE);
}

int sys_taskset(int pid, int cpu){
    return invoke_syscall(SYSCALL_TASKSET, pid, cpu, IGNORE);
}
