# Project3 - InteractiveOSAndProcessManagement

## Running Tips

在 Linux 命令行下使用 make all 命令构建所有任务，输入`sudo sh run_qemu.sh`启动 qemu，然后在qemu 中 loadboot，出现提示语句“Press any key to enter: ”后，按下任意键，主核开始初始化内核数据结构，中断向量表和屏幕，然后唤醒从核

**需要注意的是，kill命令暂不支持多核，另外，我们未重复利用已经退出的任务的 PCB，未避免资源不够用，建议用户每次测试时重新启动**

当出现 Shell 的提示符时，用户可以使用`echo`命令实现回显：

`echo hello, world!`

使用`ps`命令显示当前进程状态：

`ps`

使用`clear`命令清屏

`clear`

使用`exec`命令启动一个任务

`exec 0`启动 waitpid 任务，其中一个主进程等待三个子进程退出

`exec 1`启动信号量任务

`exec 2`启动屏障任务

`exec 3`启动多核加法任务

`exec 4`创建一个接收端，三次`exec 5`创建三个发送端，测试信箱

使用`taskset`命令实现绑核

`taskset 01 6`启动绑核的测试用例，并设置主进程运行的CPU核为0号，5个子进程继承该mask

`taskset -p 10 6`在主进程成功启动并创建好子进程后（我们为了给用户提供输入的时间，主进程会有一定的休眠时间），屏幕上会显示出各个子进程的 PID，一般为3 ~ 7号，使用该命令，将 PID 为 6 的子进程绑定在 1 号 CPU 上，可以看到运行速度明显变快

使用`kill`命令杀死一个进程（不允许杀死当前进程、0号和1号进程）

`kill 3`杀死 3 号进程

另外，如果输入了非法命令，会报错：

`Unknown command!`

