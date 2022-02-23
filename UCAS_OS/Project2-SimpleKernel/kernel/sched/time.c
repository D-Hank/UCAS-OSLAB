#include <os/time.h>
#include <os/mm.h>
#include <os/irq.h>
#include <type.h>

LIST_HEAD(timers);

uint64_t time_elapsed = 0;//here set as start time
uint32_t time_base = 0;

uint64_t get_ticks()
{//current ticks (cycles)
    __asm__ __volatile__(
        "rdtime %0"
        : "=r"(time_elapsed));
    return time_elapsed;
}

uint64_t get_timer()
{//current time
    return get_ticks() / time_base;
}

uint64_t get_time_base()
{
    return time_base;
}

void latency(uint64_t time)
{//wait for some time
    uint64_t begin_time = get_timer();

    while (get_timer() - begin_time < time);
    return;
}

uint32_t get_walltime(uint32_t *time_elapsed){
    *time_elapsed=(uint32_t)get_ticks();
    return time_base;
}
