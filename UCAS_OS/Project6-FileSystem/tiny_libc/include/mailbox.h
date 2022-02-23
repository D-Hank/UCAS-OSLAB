#ifndef INCLUDE_MAIL_BOX_
#define INCLUDE_MAIL_BOX_

#include <mthread.h>

#define MAX_MBOX_LENGTH (64)
#define MAX_MBOX 8
#define MAX_NAME 50

// TODO: please define mailbox_t;
// mailbox_t is just an id of kernel's mail box.
/*typedef struct mailbox{
    int valid;
    int head;
    int tail;
    int reference;
    mthread_semaphore_t empty;
    mthread_semaphore_t full;
    char name[MAX_NAME];
    char buffer[MAX_MBOX_LENGTH];
} mailbox_t;*/

typedef int mailbox_t;

//mailbox_t mailbox_array[MAX_MBOX];
mthread_semaphore_t visit_mailbox;

mailbox_t mbox_open(char *);
void mbox_close(mailbox_t );
int mbox_send(mailbox_t , void *, int);
int mbox_recv(mailbox_t , void *, int);

#endif
