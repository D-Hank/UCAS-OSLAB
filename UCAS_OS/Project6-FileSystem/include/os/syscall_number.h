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

#ifndef OS_SYSCALL_NUMBER_H_
#define OS_SYSCALL_NUMBER_H_

#define IGNORE 0
#define NUM_SYSCALLS 64

/* define */
#define SYSCALL_EXEC 0
#define SYSCALL_EXIT 1
#define SYSCALL_SLEEP 2
#define SYSCALL_KILL 3
#define SYSCALL_WAITPID 4
#define SYSCALL_PS 5
#define SYSCALL_GETPID 6
#define SYSCALL_YIELD 7
#define SYSCALL_FORK 8
#define SYSCALL_PRIOR 9

#define SYSCALL_FUTEX_WAIT 10
#define SYSCALL_FUTEX_WAKEUP 11

#define SYSCALL_WRITE 19
#define SYSCALL_READ 20
#define SYSCALL_MOVE_CURSOR 21
#define SYSCALL_GET_CURSOR 22
#define SYSCALL_REFLUSH 23
//how to use read?
#define SYSCALL_SERIAL_READ 24
#define SYSCALL_SERIAL_WRITE 25
#define SYSCALL_READ_SHELL_BUFF 26
#define SYSCALL_SCREEN_CLEAR 27
#define SYSCALL_GETCHAR 28
#define SYSCALL_PUTCHAR 29

#define SYSCALL_GET_TIMEBASE 30
#define SYSCALL_GET_TICK 31
#define SYSCALL_GET_WALLTIME 32

#define SYSCALL_GET_MUTEX 33
#define SYSCALL_LOCK_MUTEX 34
#define SYSCALL_UNLOCK_MUTEX 35

#define SYSCALL_GET_CHAR 36

#define SYSCALL_BARRIER_INIT 37
#define SYSCALL_BARRIER_WAIT 38
#define SYSCALL_BARRIER_DESTROY 39

#define SYSCALL_SEMA_INIT 40
#define SYSCALL_SEMA_UP 41
#define SYSCALL_SEMA_DOWN 42
#define SYSCALL_SEMA_DESTROY 43

#define SYSCALL_MBOX_OPEN 44
#define SYSCALL_MBOX_CLOSE 45
#define SYSCALL_MBOX_SEND 46
#define SYSCALL_MBOX_RECV 47

#define SYSCALL_TASKSET 48

#define SYSCALL_SHMPAGEGET 49
#define SYSCALL_SHMPAGEDT 50

#define SYSCALL_BINSEMGET 51
#define SYSCALL_BINSEMOP 52

#define SYSCALL_THREAD_CREATE 53

#define SYSCALL_CHECK 54
#define SYSCALL_LOOP 55

#define SYSCALL_NET_RECV 56
#define SYSCALL_NET_SEND 57
#define SYSCALL_NET_IRQ_MODE 58

#define SYSCALL_NET_TEST 59

#define SYSCALL_FOPEN 60
#define SYSCALL_FWRITE 61
#define SYSCALL_FREAD 62
#define SYSCALL_CLOSE 63

#define SYSCALL_MK_FS 64
#define SYSCALL_STAT_FS 65

#define SYSCALL_MK_DIR 66
#define SYSCALL_RM_DIR 67
#define SYSCALL_LIST_DIR 68
#define SYSCALL_CHG_DIR 69

#define SYSCALL_MK_NOD 70
#define SYSCALL_CAT 71

#define SYSCALL_LINK 72
#define SYSCALL_UNLINK 73

#define SYSCALL_LSEEK 74

#define SYSCALL_REMAKE 75

#endif
