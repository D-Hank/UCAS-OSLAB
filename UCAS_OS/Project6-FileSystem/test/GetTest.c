#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/syscall.h>

#include <os.h>

#define MAX_RECV_CNT 128
#define PACKET_LEN 512
#define HEAD_LEN 54
char recv_buffer[MAX_RECV_CNT * sizeof(EthernetFrame)];
size_t recv_length[MAX_RECV_CNT];

int main(int argc, char *argv[])
{
    int mode = 0;
    int size = 1;
    if(argc > 1) {
        size = atol(argv[1]);
        printf("%d \n", size);
    }
    if(argc > 2) {
        mode = atol(argv[2]);
    }
    //sys_mknod("1.txt");
    //size = 103;

    sys_net_irq_mode(mode);

    sys_move_cursor(1, 1);
    printf("[RECV TASK] start recv(%d):                    ", size);

    //int fd = sys_fopen("1.txt", O_RDWR);
    int ret = sys_net_recv(recv_buffer, size * sizeof(EthernetFrame), size, recv_length);
    //printf("%d\n", ret);
    printf("size = %d\n", size);
    char *curr = recv_buffer + HEAD_LEN + recv_length[0];
    for (int i = 1; i < size; ++i) {
        printf("packet %d:\n", i);
        for (int j = 0; j < (recv_length[i] + 15) / 16; ++j) {
            for (int k = 0; k < 16 && (j * 16 + k < recv_length[i]); ++k) {
                printf("%02x ", (uint32_t)(*(uint8_t*)curr));
                //sys_fwrite(fd, curr++, 1);
                curr++;
            }
            printf("\n");
        }
        curr += HEAD_LEN;
    }
    //sys_close(fd);

    return 0;
}