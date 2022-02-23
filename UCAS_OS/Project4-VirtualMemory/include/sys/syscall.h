/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 *            Copyright (C) 2018 Institute of Computing Technology, CAS
 *               Author : Han Shukai (email : hanshukai@ict.ac.cn)
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 *                       System call related processing
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * */

#ifndef INCLUDE_SYSCALL_H_
#define INCLUDE_SYSCALL_H_

#include <os/syscall_number.h>
#include <stdint.h>
#include <os.h>
 
#define SCREEN_HEIGHT 80
 

extern long invoke_syscall(long, long, long, long, long);

pid_t sys_spawn(task_info_t *info, void* arg, spawn_mode_t mode);
pid_t sys_create_thread(uintptr_t entry_point, void* arg);
void sys_exit(void);
void sys_sleep(uint32_t);
int sys_kill(pid_t pid);
int sys_waitpid(pid_t pid);
pid_t sys_exec(const char *file_name, int argc, char* argv[], spawn_mode_t mode);
void sys_show_exec();
void sys_process_show(void);
pid_t sys_getpid();
void sys_yield();
extern int sys_fork();
void sys_prior(int prior);

void sys_futex_wait(volatile uint64_t *val_addr, uint64_t val);
void sys_futex_wakeup(volatile uint64_t *val_addr, int num_wakeup);

void sys_write(char *);
void sys_read();
void sys_move_cursor(int, int);
void sys_get_cursor(int *x,int *y);
void sys_reflush();

void sys_screen_clear(void);
int sys_getchar();//use read?
void sys_putchar(char c);

long sys_get_timebase();
long sys_get_tick();
uint32_t sys_get_walltime(uint32_t *time_elapsed);

int sys_get_mutex(int *key);
int sys_lock_mutex(int handle);
int sys_unlock_mutex(int handle);
#define BINSEM_OP_LOCK 0 // mutex acquire
#define BINSEM_OP_UNLOCK 1 // mutex release

int binsemget(int key);
int binsemop(int binsem_id, int op);
int sys_get_char();

int sys_barrier_init(int *key, unsigned count, int *valid);
int sys_barrier_wait(int handle);
int sys_barrier_destroy(int handle, int *valid);

int sys_semaphore_init(int *key, int val, int *valid);
int sys_semaphore_up(int handle);
int sys_semaphore_down(int handle);
int sys_semaphore_destroy(int handle, int *valid);

int sys_mbox_open(char *name);
void sys_mbox_close(int id);
int sys_mbox_send(int id, void *msg, int msg_length);
int sys_mbox_recv(int id, void *msg, int msg_length);

int sys_taskset(int pid, int cpu);

int sys_thread_create(int *id, void (*start_routine)(void*), void *arg);

void sys_check();
void sys_loop();

#endif
