# Project6 - FileSystem

## Running Tips

在 Linux 命令行下使用 make all 命令构建所有任务，输入`sudo sh run_qemu.sh`启动 qemu，然后在qemu 中 loadboot，此时按下任意键使 bootblock 继续运行，引导至内核后，出现提示语句“Press any key to enter: ”，再按下任意键，待内核初始化完成后，出现 shell 命令行

## Shell Commands

目前我们已经实现了路径解析的函数get_parent_dir，但还没来得及应用到所有函数内，所以只有do_link支持相对路径和绝对路径，其余都只能在当前目录下使用

`mkfs`：创建文件系统，正常情况下由于文件系统已经初始化好，所以使用该命令会报错

`remake`：强制新建文件系统

`statfs`：显示文件系统信息，包括魔术字，FS起始块号，inode map起始块号，block map起始块号，inode使用情况及起始块号，data block使用情况及起始块号，inode大小，dentry大小

`cd`：切换目录，比如`cd ..`切换至上级目录

`mkdir`：创建目录，如果已存在会报错

`rmdir`：删除目录，如果不存在会报错

`ls`：打印目录项，可以加上`-l`参数，打印inode号、文件大小、链接数和名称

`touch`：创建空文件

`cat`：显示文件内容，由于缓冲区有限，只打印一个direct block，超出会报错

`ln`：创建硬链接，支持相对路径和绝对路径

`rm`：删除文件/链接，目前仅支持一个direct block，超出会报错

## Test Sets

`test_fs`：文件操作，包括打开、写、读和关闭，先通过`touch`命令创建`1.txt`，然后输入`exec fs`运行，完成后可以再用`cat`命令来查看

`seek`：大文件读写测试及指针重定位测试，先通过`touch`命令创建`2.txt`，然后输入`exec seek`运行，通过`lseek`重定位，在0 ~ 9M的位置上，每隔1M写一次hello，然后再从这些位置上读出并打印出来，由于`cat`只支持4K文件，所以写完后，不能用`cat`再查看。最后在9M的位置写9个字节，所以最后会占用2304个页，如果是第一次运行这个任务，则statfs可以看到占用了2310个页（第三个一级间址）

`GetTest`：C-core 的测试，只完成了部分功能，补上了P4的共享内存（consensus任务），通过网络获取elf文件，并写入文件系统/打印出来，这里我们用小飞机elf来测试，用pktRxTx发包后（发2个），打印出来，可以看到elf的第一个512B的内容

