#include <mailbox.h>
#include <string.h>
#include <sys/syscall.h>
#include <stdatomic.h>

int mailbox_num=0;

void mbox_init(){
    mthread_semaphore_init(&visit_mailbox,1);
    int i;
    for(i=0;i<MAX_MBOX;i++){
        mailbox_array[i].valid=0;
    }
}

mailbox_t* mbox_open(char *name)
{
    // TODO:
    int i;
    mthread_semaphore_down(&visit_mailbox);
    for(i=0;i<MAX_MBOX;i++){
        if(strcmp(name,mailbox_array[i].name)==0&&mailbox_array[i].valid==1){
            mailbox_array[i].reference++;
            mthread_semaphore_up(&visit_mailbox);
            return &mailbox_array[i];
        }
    }

    //not found, create a new one
    mailbox_t *box=&(mailbox_array[mailbox_num]);
    box->valid=1;
    box->head=0;
    box->tail=0;
    box->reference=1;
    strcpy(box->name,name);

    mthread_semaphore_init(&(box->full),0);
    mthread_semaphore_init(&(box->empty),1);
    
    mailbox_num++;
    mthread_semaphore_up(&visit_mailbox);

    return box;
}

void mbox_close(mailbox_t *mailbox)
{
    // TODO:
    mthread_semaphore_down(&visit_mailbox);
    if(mailbox->valid==0){
        mthread_semaphore_up(&visit_mailbox);
        return;
    }

    if(mailbox->reference<=1){
        mailbox->reference=0;
        mailbox->valid=0;
        mailbox->head=0;
        mailbox->tail=0;
        mthread_semaphore_up(&visit_mailbox);
        return;
    }

    mailbox->reference--;
    mthread_semaphore_up(&visit_mailbox);
}

int mbox_send(mailbox_t *mailbox, void *msg, int msg_length)
{
    // TODO:
    int block=0;
    for(;;){
        mthread_semaphore_down(&visit_mailbox);
        if(mailbox->tail>mailbox->head){
            mthread_semaphore_up(&visit_mailbox);
            block++;
            sys_yield();
            //sys_sleep(3);
        }else{
            break;
        }
    }
    memcpy(mailbox->buffer,msg,msg_length);
    mailbox->head=0;
    mailbox->tail=msg_length;
    mthread_semaphore_up(&visit_mailbox);
    int next = rand() % 5 + 1;
    sys_sleep(next);
    //sys_yield();
    return block;
}

int mbox_recv(mailbox_t *mailbox, void *msg, int msg_length)
{
    // TODO:
    int block=0;
    for(;;){
        mthread_semaphore_down(&visit_mailbox);
        if(mailbox->tail<=mailbox->head){
            mthread_semaphore_up(&visit_mailbox);
            block++;
            sys_yield();
            //sys_sleep(3);
        }else{
            break;
        }
    }
    memcpy(msg,mailbox->buffer+mailbox->head,msg_length);
    mailbox->head+=msg_length;
    mthread_semaphore_up(&visit_mailbox);
    //int next = rand() % 3 + 1;
    //sys_sleep(next);
    //sys_yield();
    return block;
}
