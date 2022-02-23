/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 *            Copyright (C) 2018 Institute of Computing Technology, CAS
 *               Author : Han Shukai (email : hanshukai@ict.ac.cn)
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 *        Process scheduling related content, such as: scheduler, process blocking,
 *                 process wakeup, process creation, process kill, etc.
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

#ifndef INCLUDE_SCHEDULER_H_
#define INCLUDE_SCHEDULER_H_
 
#include <context.h>
#include <pgtable.h>

#include <type.h>
#include <os/list.h>
#include <os/smp.h>
#include <os/mm.h>

#define NUM_MAX_TASK 32
#define NR_CPUS 2

/* used to save register infomation */

typedef enum {
    TASK_EXITED,
    TASK_BLOCKED,
    TASK_RUNNING,
    TASK_READY,
    TASK_ZOMBIE,
} task_status_t;

typedef enum {
    AUTO_CLEANUP_ON_EXIT,
    ENTER_ZOMBIE_ON_EXIT,
} spawn_mode_t;

typedef enum {
    KERNEL_PROCESS,
    KERNEL_THREAD,
    USER_PROCESS,
    USER_THREAD,
} task_type_t;

/* Process Control Block */
//------------------NOTICE------------------
// The order really matters!!!!!!!!!!!!!!!!
//------------------------------------------
typedef struct pcb
{
    /* register context */
    // this must be this order!! The order is defined in regs.h
    reg_t kernel_sp;
    reg_t user_sp;

    // count the number of disable_preempt
    // enable_preempt enables CSR_SIE only when preempt_count == 0
    reg_t preempt_count;

    //node of this pcb, to be put in a queue(only one)
    list_node_t node;
    //other pcb waiting for this pcb
    list_head wait_list;
    //this pcb is blocked by another(hang on a list)
    list_head * hang_on;//points at list head

    /* process id */
    pid_t pid;
    int bound_on_cpu;

    /* kernel/user thread/process */
    task_type_t type;

    /* BLOCK | READY | RUNNING | ZOMBIE */
    task_status_t status;
    spawn_mode_t mode;
    
    uint64_t unsleep_time;
    uint64_t prior_time;

    reg_t kernel_stack_base;
    reg_t user_stack_base;

    /* cursor position */
    int cursor_x;
    int cursor_y;

    PTE *pg_dir;//vaddr
} pcb_t;

/* task information, used to init PCB */
typedef struct task_info
{
    ptr_t entry_point;
    task_type_t type;
} task_info_t;

/* ready queue to run */
//from external components
extern list_head ready_queue;
extern list_head sleep_queue;
extern list_head zombie_queue;

/* current running task PCB */
extern pcb_t * volatile current_running[NR_CPUS];
extern pid_t process_id;

extern pcb_t pcb[NUM_MAX_TASK];
// extern pcb_t kernel_pcb[NR_CPUS];
extern pcb_t pid0_pcb_core0;
extern const ptr_t pid0_stack_core0;
extern pcb_t pid0_pcb_core1;
extern const ptr_t pid0_stack_core1;

extern list_head exit_queue;

extern void switch_to(pcb_t *prev, pcb_t *next);
void do_scheduler(void);
void do_sleep(uint32_t);
int do_fork();
void do_prior(int);

void move_node(list_node_t *node, list_head *dest_queue, list_head *src_queue);
void release_wait_list(list_head *head);
void set_pcb_ready(int index);
int alloc_new_pcb(void);
void lock_exit(pcb_t *delete_pcb);
void copy_user_arg(int argc, char *argv[], ptr_t kva);

extern pid_t do_exec(const char* file_name, int argc, char* argv[], spawn_mode_t mode);
extern void do_show_exec();
extern pid_t do_spawn(task_info_t *task, void* arg, spawn_mode_t mode);
extern void do_exit(void);
extern int do_kill(pid_t pid);
extern int do_waitpid(pid_t pid);
extern void do_process_show();
extern pid_t do_getpid();

extern int do_taskset(int pid, int cpu);

extern int do_thread_create(int *id, void (*start_routine)(void*), void *arg);

#endif
