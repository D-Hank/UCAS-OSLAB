# Project2 - SimpleKernel

## Running Tips

在 Linux 命令行下使用 make all 命令构建所有任务，输入`sudo sh run_qemu.sh`启动qemu，然后在qemu中loadboot，出现提示语句“Input 0 to choose kernel 0, else kernel 1”后，输入0，启动0号内核，此时test目录下的用户进程将被启动，fork_task进程在打印计数的同时，会请求输入子进程的优先级，我们输入一个0 ~ 9的数字（数字越大，优先级越高），可以看到子进程被创建，且数字增长的速度比父进程快。时间片的长度由inlude/os/irq.h中的TIME_INTERVAL宏确定。
