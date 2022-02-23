#include <net.h>
#include <os/string.h>
#include <screen.h>
#include <emacps/xemacps_example.h>
#include <emacps/xemacps.h>

#include <os/sched.h>
#include <os/mm.h>

#define min(a,b) (((a) < (b)) ? (a) : (b))
#define BATCH_SIZE 32

EthernetFrame rx_buffer[RXBD_CNT];
EthernetFrame tx_buffer;
unsigned rx_len[RXBD_CNT];

list_head net_recv_queue;
list_head net_send_queue;

int send_wait=0;
int recv_wait=0;

int net_poll_mode;
int batch_size=BATCH_SIZE;
volatile uintptr_t rx_curr = 0, rx_tail = 0;

uintptr_t _addr;
int _num_packet;
size_t* _frLength;

long do_net_recv(uintptr_t addr, size_t length, int num_packet, size_t* frLength)
{
    // TODO: 
    // receive packet by calling network driver's function
    // wait until you receive enough packets(`num_packet`).
    // maybe you need to call drivers' receive function multiple times ?

    //int mycpu_id=get_current_cpu_id();

    // 32 packets a batch
    int rest_packet;
    int mycpu_id=get_current_cpu_id();
    if(net_poll_mode==0){
        rx_curr = addr;
        rx_tail = 0;
        for(rest_packet = num_packet; rest_packet > 0; rest_packet -= BATCH_SIZE){
            int batch = min(rest_packet, BATCH_SIZE);
            for(int i = 0; i < RXBD_CNT; i++){
                kmemset(&rx_buffer[i], 0, sizeof(EthernetFrame));
                rx_len[i] = 0;
            }
            //switch_init_kdir();
            EmacPsRecv(&EmacPsInstance, 0, batch);
            EmacPsWaitRecv(&EmacPsInstance, batch, rx_len);
            //switch_pgdir_back();
            for(int i = 0; i < batch; i++){
                kmemcpy(rx_curr, rx_buffer + i, rx_len[i]);
                *frLength = rx_len[i];
                rx_curr += rx_len[i];
                rx_tail += rx_len[i];
                frLength ++;
            }
        }
    }else if(net_poll_mode==1 || net_poll_mode==2){
        _addr = get_kva_of(addr, current_running[mycpu_id]->pg_dir);
        _num_packet = num_packet;
        _frLength = (size_t*)get_kva_of(frLength, current_running[mycpu_id]->pg_dir);
        //printk("[START] %lx, %d, %lx\n",_addr, _num_packet, _frLength);
        current_running[mycpu_id]->status=TASK_BLOCKED;
        current_running[mycpu_id]->hang_on=&net_recv_queue;
        move_node(&(current_running[mycpu_id]->node), &net_recv_queue, &ready_queue);
        return_v(1);
        //switch_pgdir_back();
        do_scheduler();
    }
    return rx_tail;
}

void do_net_send(uintptr_t addr, size_t length)
{
    // TODO:
    // send all packet
    // maybe you need to call drivers' send function multiple times ?
    int mycpu_id = get_current_cpu_id();
    kmemset(&tx_buffer, 0, sizeof(EthernetFrame));
    kmemcpy(&tx_buffer, addr, length);
    //switch_init_kdir();
    EmacPsSend(&EmacPsInstance, &tx_buffer ,length);
    if(net_poll_mode == 0){
        EmacPsWaitSend(&EmacPsInstance);
        //switch_pgdir_back();
    }else if(net_poll_mode == 1 || net_poll_mode == 2){
        current_running[mycpu_id]->status=TASK_BLOCKED;
        current_running[mycpu_id]->hang_on=&net_send_queue;
        move_node(&(current_running[mycpu_id]->node), &net_send_queue, &ready_queue);
        return_v(1);
        //switch_pgdir_back();
        do_scheduler();
    }
}

void do_net_irq_mode(int mode)
{
    // TODO:
    // turn on/off network driver's interrupt mode
    u32 mask = (XEMACPS_IXR_TX_ERR_MASK | XEMACPS_IXR_RX_ERR_MASK | (u32)XEMACPS_IXR_FRAMERX_MASK | (u32)XEMACPS_IXR_TXCOMPL_MASK);
    net_poll_mode = mode;
    //switch_init_kdir();
    if(mode != 2){
        XEmacPs_IntDisable(&EmacPsInstance, mask);
    }else{
        XEmacPs_IntEnable(&EmacPsInstance, mask);
    }
    //switch_pgdir_back();
}
