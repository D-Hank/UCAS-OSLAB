#ifndef NET_H
#define NET_H

#include <type.h>
#include <os/list.h>
#include <os/string.h>
#include <emacps/xemacps_example.h>

long do_net_recv(uintptr_t addr, size_t length, int num_packet, size_t* frLength);
void do_net_send(uintptr_t addr, size_t length);
void do_net_irq_mode(int mode);

extern int net_poll_mode;
extern int batch_size;
extern EthernetFrame rx_buffer[RXBD_CNT];
extern EthernetFrame tx_buffer;
extern unsigned rx_len[RXBD_CNT];
extern list_head net_recv_queue;
extern list_head net_send_queue;

extern uintptr_t _addr;
extern int _num_packet;
extern size_t* _frLength;

#endif //NET_H
