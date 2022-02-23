#include <stdio.h>
#include <sys/syscall.h>
#include <assert.h>

int main(int argc, char* argv[])
{
	for(int i=0x30000;i<0x110000;i+=0x1000){//0x80 pages
		sys_move_cursor(2, 2);
		printf("0x%lx\n",i);
		long *ptr=(long *)i;
		//long temp=*ptr;
		*ptr=i;
		sys_reflush();
	}
	for(int i=0x30000;i<0x110000;i+=0x1000){//0x1000
		long *ptr=(long *)i;
        long temp=*ptr;
        if(temp==i){
            sys_move_cursor(3,3);
            printf("0x%lx\n",i);
            sys_reflush();
        }else{
            assert(0);
        }
	}
	printf("Success!\n");

	// while(1);
	return 0;
}
