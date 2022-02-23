#include <stdio.h>
#include <sys/syscall.h>

static char blank[] = {"                   "};
static char plane1[] = {"    ___         _  "};
static char plane2[] = {"| __\\_\\______/_| "};
static char plane3[] = {"<[___\\_\\_______| "};
static char plane4[] = {"|  o'o             "};

int main(int argc, char *argv[])
{
    int i = 22, j = 10;
    /*sys_move_cursor(0, 18);
    printf("argc=%d\n",argc);
    printf("argv:\n");
    for(int k=0;k<argc;k++){
        printf("%s\n",argv[k]);
    }*/

    while (1)
    {
        for (i = 60; i > 0; i--)
        {
            /* move */
            sys_move_cursor(i, j + 0);
            printf("%s", plane1);

            sys_move_cursor(i, j + 1);
            printf("%s", plane2);

            sys_move_cursor(i, j + 2);
            printf("%s", plane3);

            sys_move_cursor(i, j + 3);
            printf("%s", plane4);
            sys_yield();
        }

        sys_move_cursor(1, j + 0);
        printf("%s", blank);

        sys_move_cursor(1, j + 1);
        printf("%s", blank);

        sys_move_cursor(1, j + 2);
        printf("%s", blank);

        sys_move_cursor(1, j + 3);
        printf("%s", blank);

        //sys_exit();
    }
}
