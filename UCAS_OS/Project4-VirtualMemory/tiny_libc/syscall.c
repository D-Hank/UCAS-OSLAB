#include <sys/syscall.h>
#include <stdint.h>

static inline void assert_supervisor_mode()
{ 
   __asm__ __volatile__("csrr x0, sscratch\n"); 
}

pid_t sys_exec(const char *file_name, int argc, char* argv[], spawn_mode_t mode){
    return invoke_syscall(SYSCALL_EXEC, (long)file_name, (long)argc, argv, (long)mode);
}

pid_t sys_spawn(task_info_t *info, void* arg, spawn_mode_t mode)
{
    //return invoke_syscall(SYSCALL_SPAWN,info,arg,mode,IGNORE);
    return 0;
}

void sys_exit(void){
    invoke_syscall(SYSCALL_EXIT,IGNORE,IGNORE,IGNORE,IGNORE);
}

void sys_sleep(uint32_t time)
{
    invoke_syscall(SYSCALL_SLEEP,time,IGNORE,IGNORE,IGNORE);
}

int sys_kill(pid_t pid)//return a status
{
    return invoke_syscall(SYSCALL_KILL,pid,IGNORE,IGNORE,IGNORE);
}

int sys_waitpid(pid_t pid)//return a status
{
    return invoke_syscall(SYSCALL_WAITPID,pid,IGNORE,IGNORE,IGNORE);
}

void sys_process_show(void)
{
    invoke_syscall(SYSCALL_PS,IGNORE,IGNORE,IGNORE,IGNORE);
}

pid_t sys_getpid(void)
{
    return invoke_syscall(SYSCALL_GETPID,IGNORE,IGNORE,IGNORE,IGNORE);
}

void sys_yield()
{
    invoke_syscall(SYSCALL_YIELD, IGNORE, IGNORE, IGNORE, IGNORE);
}

//sys_fork by asm

void sys_prior(int prior){
    invoke_syscall(SYSCALL_PRIOR,prior,IGNORE,IGNORE,IGNORE);
}

void sys_futex_wait(volatile uint64_t *val_addr, uint64_t val)
{
    invoke_syscall(SYSCALL_FUTEX_WAIT,val_addr,val,IGNORE,IGNORE);
}

void sys_futex_wakeup(volatile uint64_t *val_addr, int num_wakeup){
    invoke_syscall(SYSCALL_FUTEX_WAKEUP,val_addr,num_wakeup,IGNORE,IGNORE);
}

void sys_write(char *buff)
{
    invoke_syscall(SYSCALL_WRITE,buff,IGNORE,IGNORE,IGNORE);
}

void sys_read(){
    invoke_syscall(SYSCALL_READ,IGNORE,IGNORE,IGNORE,IGNORE);
}

void sys_move_cursor(int x, int y)
{
    invoke_syscall(SYSCALL_MOVE_CURSOR,x,y,IGNORE,IGNORE);
}

void sys_get_cursor(int *x,int *y)
{
    invoke_syscall(SYSCALL_GET_CURSOR,x,y,IGNORE,IGNORE);
}

void sys_reflush()
{
    invoke_syscall(SYSCALL_REFLUSH,IGNORE,IGNORE,IGNORE,IGNORE);
}

void sys_screen_clear()
{
    invoke_syscall(SYSCALL_SCREEN_CLEAR,IGNORE,IGNORE,IGNORE,IGNORE);
}

int sys_getchar(){
    while(1){
        char c=invoke_syscall(SYSCALL_GETCHAR,IGNORE,IGNORE,IGNORE,IGNORE);
        if(c>0&&c<=127){
            return c;
        }
    }
}

void sys_putchar(char c)
{
    invoke_syscall(SYSCALL_PUTCHAR,c,IGNORE,IGNORE,IGNORE);
}

long sys_get_timebase()
{
    return invoke_syscall(SYSCALL_GET_TIMEBASE,IGNORE,IGNORE,IGNORE,IGNORE);
}

long sys_get_tick()
{
    return invoke_syscall(SYSCALL_GET_TICK,IGNORE,IGNORE,IGNORE,IGNORE);
}

uint32_t sys_get_walltime(uint32_t *time_elapsed){
    return invoke_syscall(SYSCALL_GET_WALLTIME,time_elapsed,IGNORE,IGNORE,IGNORE);
}

int sys_get_mutex(int *key){
    //assert_supervisor_mode();
    return invoke_syscall(SYSCALL_GET_MUTEX,key,IGNORE,IGNORE,IGNORE);
}

int sys_lock_mutex(int handle){
    return invoke_syscall(SYSCALL_LOCK_MUTEX,handle,IGNORE,IGNORE,IGNORE);
}

int sys_unlock_mutex(int handle){
    return invoke_syscall(SYSCALL_UNLOCK_MUTEX,handle,IGNORE,IGNORE,IGNORE);
}

int sys_get_char(){
    return invoke_syscall(SYSCALL_GET_CHAR,IGNORE,IGNORE,IGNORE,IGNORE);
}

int sys_barrier_init(int *key, unsigned count, int *valid){
    return invoke_syscall(SYSCALL_BARRIER_INIT,key,count,valid,IGNORE);
}

int sys_barrier_wait(int handle){
    return invoke_syscall(SYSCALL_BARRIER_WAIT,handle,IGNORE,IGNORE,IGNORE);
}

int sys_barrier_destroy(int handle, int *valid){
    return invoke_syscall(SYSCALL_BARRIER_DESTROY,handle,valid,IGNORE,IGNORE);
}

int sys_semaphore_init(int *key, int val, int *valid){
    return invoke_syscall(SYSCALL_SEMA_INIT,key,val,valid,IGNORE);
}

int sys_semaphore_up(int handle){
    return invoke_syscall(SYSCALL_SEMA_UP,handle,IGNORE,IGNORE,IGNORE);
}

int sys_semaphore_down(int handle){
    return invoke_syscall(SYSCALL_SEMA_DOWN,handle,IGNORE,IGNORE,IGNORE);
}

int sys_semaphore_destroy(int handle, int *valid){
    return invoke_syscall(SYSCALL_SEMA_DESTROY,handle,valid,IGNORE,IGNORE);
}

int sys_mbox_open(char *name){
    return invoke_syscall(SYSCALL_MBOX_OPEN, name, IGNORE, IGNORE, IGNORE);
}

void sys_mbox_close(int id){
    invoke_syscall(SYSCALL_MBOX_CLOSE, id, IGNORE, IGNORE, IGNORE);
}

int sys_mbox_send(int id, void *msg, int msg_length){
    return invoke_syscall(SYSCALL_MBOX_SEND, id, msg, msg_length, IGNORE);
}

int sys_mbox_recv(int id, void *msg, int msg_length){
    return invoke_syscall(SYSCALL_MBOX_RECV, id, msg, msg_length, IGNORE);
}

int sys_taskset(int pid, int cpu){
    return invoke_syscall(SYSCALL_TASKSET, pid, cpu, IGNORE, IGNORE);
}

void *shmpageget(int key){
    return invoke_syscall(SYSCALL_SHMPAGEGET, key, IGNORE, IGNORE,IGNORE);
}

void shmpagedt(void *addr){
    invoke_syscall(SYSCALL_SHMPAGEGET, addr, IGNORE, IGNORE,IGNORE);
}

int binsemget(int key){
    return invoke_syscall(SYSCALL_BINSEMGET, key, IGNORE, IGNORE, IGNORE);
}

int binsemop(int binsem_id, int op){
    return invoke_syscall(SYSCALL_BINSEMOP, binsem_id, op, IGNORE, IGNORE);
}

int sys_thread_create(int *id, void (*start_routine)(void*), void *arg){
    return invoke_syscall(SYSCALL_THREAD_CREATE, id, start_routine, arg, IGNORE);
}

void sys_check(){
    invoke_syscall(SYSCALL_CHECK, IGNORE, IGNORE, IGNORE, IGNORE);
}

void sys_loop(){
    invoke_syscall(SYSCALL_LOOP, IGNORE, IGNORE, IGNORE, IGNORE);
}
