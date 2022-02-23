#include <stdio.h>
#include <string.h>
#include <sys/syscall.h>

#include <os.h>

#define POS_1   0x0
#define POS_2   (1 << 10)
#define POS_3   (1 << 23)
#define DELTA   (1 << 20)
#define LOOP    10

static char buff[64];
char *string[] = {
    "hello 0!\n",
    "hello 1!\n",
    "hello 2!\n",
    "hello 3!\n",
    "hello 4!\n",
    "hello 5!\n",
    "hello 6!\n",
    "hello 7!\n",
    "hello 8!\n",
    "hello 9!\n"
};

int main(void)
{
    int i, j;
    int fd = sys_fopen("2.txt", O_RDWR);

    int pos = 0;

    // write
    for(int i=0;i<LOOP;i++){
        sys_lseek(fd, pos, 0, 'w');
        sys_fwrite(fd, string[i % 10], 9);
        pos += DELTA;
    }

    pos = 0;
    for(int i=0;i<LOOP;i++){
        sys_lseek(fd, pos, 0, 'r');
        sys_fread(fd, buff, 9);
        printf("%s",buff);
        pos += DELTA;
    }

    sys_close(fd);
}