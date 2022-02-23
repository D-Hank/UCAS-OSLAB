/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 *            Copyright (C) 2018 Institute of Computing Technology, CAS
 *               Author : Han Shukai (email : hanshukai@ict.ac.cn)
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 *            Synchronous primitive related content implementation,
 *                 such as: locks, barriers, semaphores, etc.
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

#ifndef INCLUDE_SYNC_H_
#define INCLUDE_SYNC_H_

#include <os/lock.h>

#define MAX_BARRIER 8
#define MAX_SEMAPHORE 8
#define MAX_MBOX 8
#define MAX_NAME 32
#define MBOX_BUFFER 256

typedef struct barrier
{
    int valid;
    //need a status field?
    int all_wait_num;
    list_head wait_queue;
} barrier_t;
barrier_t barrier_array[MAX_BARRIER];

typedef struct semaphore
{
    int valid;
    int total_resources;
    list_head wait_queue;
} semaphore_t;
semaphore_t semaphore_array[MAX_SEMAPHORE];

typedef struct mbox
{
    int valid;
    int head;
    int tail;
    int reference;
    char name[MAX_NAME];
    list_head send_queue;
    list_head recv_queue;
    char buffer[MBOX_BUFFER];
} mbox_t;
mbox_t mbox_array[MAX_MBOX];

int do_barrier_init(int *key, unsigned count, int *valid);
int do_barrier_wait(int handle);
int do_barrier_destroy(int handle, int *valid);

int do_semaphore_init(int *key, int val, int *valid);
int do_semaphore_up(int handle);
int do_semaphore_down(int handle);
int do_semaphore_destroy(int handle, int *valid);

int do_mbox_open(char *name);
void do_mbox_close(int id);
int do_mbox_send(int id, void *msg, int msg_length);
int do_mbox_recv(int id, void *msg, int msg_length);

#endif
