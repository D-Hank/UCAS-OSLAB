# Project5 - DeviceDriver

## Running Tips

在 Linux 命令行下使用 make all 命令构建所有任务，输入`sudo sh e1000.sh`启动 qemu（如果不需要调试，应去掉-S和-s选项），然后在qemu 中 loadboot，此时按下任意键使 bootblock 继续运行，开启地址翻译并引导至内核后，出现提示语句“Press any key to enter: ”，再按下任意键，出现 shell 命令行

## Test Sets

`send`：发消息测试，在命令行输入`exec send x `，其中`x`为模式编号，0为轮询，1为时钟中断，2为网卡中断，测试集中设置的是1000个包，可以用wireshark接收

`recv`：接收消息测试，在命令行输入`exec recv n x`，其中`n`为收包个数，`x`为模式编号，比如`exec recv 65 2`，表示以网卡中断接收65个包，接收时启动pktRxTx程序，记得加上`-t 10000`选项调节速率

在中断模式下，收发的系统调用返回值为1表示成功，轮询模式下返回字节数

