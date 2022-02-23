#include <sbi.h>

#define VERSION_BUF 50

int version = 1; // version must between 0 and 9
char buf[VERSION_BUF];
char bss_pad[512];

int bss_check()
{
    for (int i = 0; i < VERSION_BUF; ++i) {
        if (buf[i] != 0){
            //sbi_console_putchar('x');
            return 0;
        }
    }
    //sbi_console_putchar('y');
    return 1;
}

int getch()
{
	//Waits for a keyboard input and then returns.
    char c;
    while((c=sbi_console_getchar())<0||c>127){
        ;
    }
    return c;
    //Notice: ctrl+0x0100_0000 for control characters
}

static inline unsigned long long GetCurrentPC(){
    unsigned long long ProgramCounter;
    asm volatile(
        "AUIPC  %0,0"
        :"=r"(ProgramCounter)
    );
    return ProgramCounter;
}

void PrintULL(unsigned long long number){//number to be printed is not zero
    if(number==0){
        return;
    }
    PrintULL(number/16);
    unsigned long long remainder=number%16;
    if(remainder<10){
        sbi_console_putchar(remainder+'0');
    }else{
        sbi_console_putchar(remainder-10+'A');
    }
}

int main(void)
{
    int check = bss_check();
    char output_str[] = "bss check: _ version: _\n\r";
    char output_val[2] = {0};
    int i, output_val_pos = 0;

    output_val[0] = check ? 't' : 'f';
    output_val[1] = version + '0';
    for (i = 0; i < sizeof(output_str); ++i) {
        buf[i] = output_str[i];
	    if (buf[i] == '_') {
	    buf[i] = output_val[output_val_pos++];
	    }
    }

	//print "Hello OS!"
    sbi_console_putstr("Hello OS0!\n\r");    

	//print array buf which is expected to be "Version: 1"
    sbi_console_putstr(buf);

    //fill function getch, and call getch here to receive keyboard input.
	//print it out at the same time
    char c;
    unsigned long long PC=GetCurrentPC();
    while(1){
        c=getch();
        sbi_console_putchar(c);
        if(c=='@'){
            sbi_console_putstr("\n\rPC sampling at 0x");
            PrintULL(PC);
            sbi_console_putchar(13);
            sbi_console_putchar(10);
        }
    }

    return 0;
}


