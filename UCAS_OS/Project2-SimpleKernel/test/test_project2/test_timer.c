#include <test2.h>
#include <stdio.h>
#include <sys/syscall.h>
#include <time.h>

void timer_task(void)
{
    int print_location = 2;

    while (1)
    {
        /* call get_timer() to get time */
        uint32_t time_elapsed = clock();
	    //uint32_t time = time_elapsed / CLOCKS_PER_SEC;
        uint32_t _time_elapsed=0;
        uint32_t _time_base=sys_get_walltime(&_time_elapsed);
        uint32_t time=_time_elapsed/_time_base;
        sys_move_cursor(1, print_location);
        // NOTICE: frequency can be static here
        // We use yield to release control here
        printf("> [TASK] This is a thread to timing! (%u/%u seconds).\n", time, time_elapsed);
        sys_yield();
    }
}
