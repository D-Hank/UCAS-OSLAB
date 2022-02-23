#include <mailbox.h>
#include <string.h>
#include <sys/syscall.h>
#include <stdatomic.h>

int mailbox_num=0;

mailbox_t mbox_open(char *name)
{
    // TODO:
    return sys_mbox_open(name);
}

void mbox_close(mailbox_t mailbox)
{
    // TODO:
    sys_mbox_close(mailbox);
}

int mbox_send(mailbox_t mailbox, void *msg, int msg_length)
{
    // TODO:
    int block=0;
    while(sys_mbox_send(mailbox, msg, msg_length)<msg_length){
        block++;
        //sys_sleep(1);
        //sys_yield();
    }
    return block;
}

int mbox_recv(mailbox_t mailbox, void *msg, int msg_length)
{
    // TODO:
    int block=0;
    while(sys_mbox_recv(mailbox, msg, msg_length)<msg_length){
        block++;
        //sys_sleep(1);
        //sys_yield();
    }
    return block;
}
