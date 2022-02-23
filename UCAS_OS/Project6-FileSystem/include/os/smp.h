#ifndef SMP_H
#define SMP_H

#include <type.h>
#include <os/sched.h>

#define NR_CPUS 2
ptr_t cpu_stack_pointer[NR_CPUS];
ptr_t cpu_pcb_pointer[NR_CPUS];
extern void smp_init();
extern void wakeup_other_hart();
extern uint64_t get_current_cpu_id();
extern void lock_kernel();
extern void unlock_kernel();

#endif /* SMP_H */
