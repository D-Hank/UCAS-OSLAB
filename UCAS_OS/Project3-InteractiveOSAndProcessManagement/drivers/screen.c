#include <screen.h>
#include <common.h>
#include <stdio.h>
#include <os/string.h>
#include <os/lock.h>
#include <os/sched.h>
#include <os/irq.h>

#define SCREEN_WIDTH    80
#define SCREEN_HEIGHT   50

int screen_cursor_x[NR_CPUS];
int screen_cursor_y[NR_CPUS];

/* screen buffer */
char new_screen[SCREEN_HEIGHT * SCREEN_WIDTH] = {0};
char old_screen[SCREEN_HEIGHT * SCREEN_WIDTH] = {0};

/* cursor position */
void vt100_move_cursor(int x, int y)
{
    // \033[y;xH
    //disable_preempt();
    int mycpu_id=get_current_cpu_id();
    printk("%c[%d;%dH", 27, y, x);
    current_running[mycpu_id]->cursor_x = x;
    current_running[mycpu_id]->cursor_y = y;
    //enable_preempt();
}

/* clear screen */
static void vt100_clear()
{
    // \033[2J
    printk("%c[2J", 27);
}

/* hidden cursor */
static void vt100_hidden_cursor()
{
    // \033[?25l
    printk("%c[?25l", 27);
}

/* write a char */
static void screen_write_ch(char ch)
{
    int mycpu_id=get_current_cpu_id();
    if (ch == '\n' || ch == '\r')
    {
        screen_cursor_x[mycpu_id] = 0;
        screen_cursor_y[mycpu_id]++;
    }
    else if (ch== '\b' || ch==127)
    {
        screen_cursor_x[mycpu_id]--;
        new_screen[screen_cursor_y[mycpu_id] * SCREEN_WIDTH + screen_cursor_x[mycpu_id]] = ' ';
    }
    else
    {
        new_screen[(screen_cursor_y[mycpu_id]) * SCREEN_WIDTH + (screen_cursor_x[mycpu_id])] = ch;
        screen_cursor_x[mycpu_id]++;
    }
    
    if (screen_cursor_x[mycpu_id] < 0)
    {
        screen_cursor_x[mycpu_id] = 0;
        screen_cursor_y[mycpu_id] = 0;
    }

    if (screen_cursor_x[mycpu_id] >= SCREEN_WIDTH)
    {
        screen_cursor_y[mycpu_id]++;
        screen_cursor_x[mycpu_id] = 0;
    }

    if (screen_cursor_y[mycpu_id] < 0)
    {
        screen_cursor_y[mycpu_id] = 0;
        screen_cursor_x[mycpu_id] = 0;
    }

    if(screen_cursor_y[mycpu_id]>=SCREEN_HEIGHT)
    {
        screen_cursor_y[mycpu_id] = 0;
        screen_cursor_x[mycpu_id] = 0;
    }
    current_running[mycpu_id]->cursor_x = screen_cursor_x[mycpu_id];
    current_running[mycpu_id]->cursor_y = screen_cursor_y[mycpu_id];

}

void init_screen(void)
{
    //vt100_hidden_cursor();
    vt100_clear();
}

void screen_clear(void)
{
    int i, j;
    int mycpu_id=get_current_cpu_id();
    for (i = 0; i < SCREEN_HEIGHT; i++)
    {
        for (j = 0; j < SCREEN_WIDTH; j++)
        {
            new_screen[i * SCREEN_WIDTH + j] = ' ';
            old_screen[i * SCREEN_WIDTH + j] = 0;
        }
    }
    screen_cursor_x[mycpu_id] = 0;
    screen_cursor_y[mycpu_id] = 0;
    screen_reflush();
}

void screen_move_cursor(int x, int y)
{
    int mycpu_id=get_current_cpu_id();
    screen_cursor_x[mycpu_id] = x;
    screen_cursor_y[mycpu_id] = y;
    current_running[mycpu_id]->cursor_x = screen_cursor_x[mycpu_id];
    current_running[mycpu_id]->cursor_y = screen_cursor_y[mycpu_id];
    //screen_reflush();
}

void screen_get_cursor(int *x,int *y)
{
    int mycpu_id=get_current_cpu_id();
    *x=screen_cursor_x[mycpu_id];
    *y=screen_cursor_y[mycpu_id];
}

void screen_write(char *buff)
{
    int i = 0;
    int l = kstrlen(buff);

    //screen_reflush();
    for (i = 0; i < l; i++)
    {
        screen_write_ch(buff[i]);
    }
    //screen_reflush();
}

/*
 * This function is used to print the serial port when the clock
 * interrupt is triggered. However, we need to pay attention to
 * the fact that in order to speed up printing, we only refresh
 * the characters that have been modified since this time.
 */
void screen_reflush(void)
{
    int i, j;
    int mycpu_id=get_current_cpu_id();

    /* here to reflush screen buffer to serial port */
    for (i = 0; i < SCREEN_HEIGHT; i++)
    {
        for (j = 0; j < SCREEN_WIDTH; j++)
        {
            /* We only print the data of the modified location. */
            if (new_screen[i * SCREEN_WIDTH + j] != old_screen[i * SCREEN_WIDTH + j])
            {
                vt100_move_cursor(j + 1, i + 1);
                port_write_ch(new_screen[i * SCREEN_WIDTH + j]);
                old_screen[i * SCREEN_WIDTH + j] = new_screen[i * SCREEN_WIDTH + j];
            }
        }
    }

    /* recover cursor position */
    vt100_move_cursor(screen_cursor_x[mycpu_id] + 1, screen_cursor_y[mycpu_id] + 1);
}

int getch(){
	//Waits for a keyboard input and then returns.
    char c;
    for(int i=0;i<100;i++){
        c=port_read_ch();
        if(c>0&&c<=127){
            return c;
        }
    }
    return c;
    //Notice: ctrl+0x0100_0000 for control characters
}

int getchar(){
    char c;
    while((c=port_read_ch())>127||c<0){
        ;
    }
    return c;
}
