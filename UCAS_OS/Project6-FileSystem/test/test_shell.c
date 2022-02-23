/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 *            Copyright (C) 2018 Institute of Computing Technology, CAS
 *               Author : Han Shukai (email : hanshukai@ict.ac.cn)
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 *                  The shell acts as a task running in user mode.
 *       The main function is to make system calls through the user's output.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this
 * software and associated documentation files (the "Software"), to deal in the Software
 * without restriction, including without limitation the rights to use, copy, modify,
 * merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit
 * persons to whom the Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * */

#include <test.h>
#include <string.h>
#include <os.h>
#include <sys/syscall.h>
#include <stdio.h>
#include <stdint.h>

#define SHELL_BEGIN 15
#define COMMAND_LINE 128
#define ARG_VALUE 20
#define ARG_COUNT 10

int main(){
    test_shell();
    return 0;
}

void test_shell()
{
    // TODO:
    //char buf[] = "consensus";
    //sys_exec("consensus", 0, &buf, AUTO_CLEANUP_ON_EXIT);
    //sys_yield();
    sys_screen_clear();
    sys_move_cursor(1, SHELL_BEGIN);
    printf("------------------- COMMAND -------------------\n");
    printf("> D-Hank@UCAS_OS: ");
    sys_reflush();
    //sys_move_cursor(17, SHELL_BEGIN+2);
    char command_line [COMMAND_LINE]={0};
    char c;
    int len=0;
    const int hint_len=18;
    /*sys_spawn(test_tasks[5],NULL,AUTO_CLEANUP_ON_EXIT);
    sys_spawn(test_tasks[5],NULL,AUTO_CLEANUP_ON_EXIT);
    sys_spawn(test_tasks[5],NULL,AUTO_CLEANUP_ON_EXIT);
    sys_spawn(test_tasks[4],NULL,AUTO_CLEANUP_ON_EXIT);
    while(1){
        sys_yield();
    }*/

    while (1)
    {
        // TODO: call syscall to read UART port
        
        // TODO: parse input
        // note: backspace maybe 8('\b') or 127(delete)
        // NOTICE: 'DELETE' will be a control character for vt100 console
        for(;;){
            c=sys_getchar();
            if(c=='\b'||c==127){
                if(len>0){
                    //command_line[--len]='\0';
                    len--;
                    printf("%c",c);
                }
            }else if(c=='\n'||c=='\r'){
                printf("\n");
                command_line[len]=0;
                len=0;
                sys_reflush();
                break;
            }else{
                printf("%c",c);
                command_line[len++]=c;
            }
            sys_reflush();

        // TODO: ps, exec, kill, clear
        }
        //get a command line

        int argc=-1;
        int i;
        char arg [ARG_COUNT][ARG_VALUE];
        char command [COMMAND_LINE];
        for(i=0;;i++){
            if(command_line[i]==0){
                argc=0;
                break;
            }else if(command_line[i]==' '){
                break;
            }
            command[i]=command_line[i];
        }
        command[i]=0;

        if(argc!=0){
            i++;
            int row=0;
            int column=0;
            for(argc=0;;){
                if(command_line[i]==0){
                    arg[row][column]=0;
                    argc++;
                    break;
                }else if(command_line[i]==' '){
                    arg[row][column]=0;
                    argc++;
                    i++;
                    row++;
                    column=0;
                }else{
                    arg[row][column]=command_line[i];
                    i++;
                    column++;
                }
            }
        }

        if(strcmp(command,"ps")==0){
            sys_process_show();
            //sys_reflush();
        }else if(strcmp(command,"clear")==0){
            sys_screen_clear();
            sys_move_cursor(1, SHELL_BEGIN);
            printf("------------------- COMMAND -------------------\n");
        }else if(strcmp(command,"echo")==0){
            for(int i=0;i<argc;i++){
                printf(" %s",arg[i]);
            }
            printf("\n");
        }else if(strcmp(command,"exec")==0){
            char *argv[ARG_COUNT];
            for(int i=0;i<argc;i++){
                argv[i]=arg[i];
            }
            int result=sys_exec(arg[0], argc, argv, AUTO_CLEANUP_ON_EXIT);
            if(result>=0){
                printf("Exec %s task, with pid: %d\n", arg[0], result);
            }else{
                printf("Exec failed.\n");
            }
        }else if(strcmp(command,"kill")==0){
            int pid=atoi(arg[0]);
            int result=sys_kill(pid);
            if(result==-1){
                printf("Permission denied!\n");
            }else if(result==0){
                printf("Task exited or not found.\n");
            }else{
                printf("Process [%d] killed.\n",pid);
            }
        }else if(strcmp(command,"taskset")==0){
            if(strcmp(arg[0],"-p")==0){//mode 0 for existing
                int pid=atoi(arg[2]);
                if(strcmp(arg[1],"01")==0){
                    sys_taskset(pid,0);
                }else if(strcmp(arg[1],"10")==0){
                    sys_taskset(pid,1);
                }else{
                    sys_taskset(pid,-1);
                }
            }else{
                int task=atoi(arg[1]);
                printf("Taskset with task: %d, mask: %s\n",task,arg[0]);
                /*int pid=sys_spawn(test_tasks[task],NULL,AUTO_CLEANUP_ON_EXIT);
                if(strcmp(arg[0],"01")==0){
                    sys_taskset(pid,0);
                }else if(strcmp(arg[0],"10")==0){
                    sys_taskset(pid,1);
                }else{
                    sys_taskset(pid,-1);
                }*/
            }
        }else if(strcmp(command,"check")==0){
            sys_check();
        }else if(strcmp(command,"remake")==0){
            sys_remake();
        }else if(strcmp(command,"loop")==0){
            sys_loop();
        }else if(strcmp(command,"mkfs")==0){
            sys_mkfs();
        }else if(strcmp(command,"statfs")==0){
            sys_statfs();
        }else if(strcmp(command,"mkdir")==0){
            int ret = sys_mkdir(arg[0]);
            if(ret < 0){
                printf("Mkdir failed.\n");
            }
        }else if(strcmp(command,"rmdir")==0){
            int ret = sys_rmdir(arg[0]);
            if(ret < 0){
                printf("Rmdir failed.\n");
            }
        }else if(strcmp(command,"ls")==0){
            char *argv[ARG_COUNT];
            for(int i=0;i<argc;i++){
                argv[i]=arg[i];
            }
            sys_ls(argc, argv);
        }else if(strcmp(command,"cd")==0){
            int ret = sys_cd(arg[0]);
            if(ret < 0){
                printf("No such directory.\n");
            }
        }else if(strcmp(command,"touch")==0){
            int ret = sys_mknod(arg[0]);
            if(ret < 0){
                printf("File already existed!\n");
            }
        }else if(strcmp(command,"cat")==0){
            int ret = sys_cat(arg[0]);
            if(ret < 0){
                printf("Cat failed.\n");
            }
        }else if(strcmp(command,"ln")==0){
            int ret = sys_link(arg[0], arg[1]);
            if(ret < 0){
                printf("Link failed.\n");
            }
        }else if(strcmp(command,"rm")==0){
            int ret = sys_unlink(arg[0]);
            if(ret < 0){
                printf("Remove failed.\n");
            }
        }else{
            printf("Unknown command!\n");
        }
        printf("> D-Hank@UCAS_OS: ");
        sys_reflush();
        sys_yield();
    }
}
