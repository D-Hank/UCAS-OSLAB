#include <sbi.h>
#include <atomic.h>
#include <os/sched.h>
#include <os/smp.h>
#include <os/lock.h>

void smp_init()
{
    /* TODO: */
}

void wakeup_other_hart()
{
    /* TODO: */
    sbi_send_ipi(NULL);
    //sbi_clear_ipi();
}

void lock_kernel()
{
    /* TODO: */
    spin_lock_acquire(&kernel_lock);
}

void unlock_kernel()
{
    /* TODO: */
    spin_lock_release(&kernel_lock);
}

