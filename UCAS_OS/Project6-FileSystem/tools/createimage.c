#include <assert.h>
#include <elf.h>
#include <errno.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define IMAGE_FILE "./image"
#define ARGS "[--extended] [--vm] <bootblock> <executable-file> ..."
#define SECTOR_SIZE 512
#define BUFFER_SIZE 2048


/* structure to store command line options */
static struct {
    int vm;
    int extended;
} options;

/* prototypes of local functions */
static void create_image(int nfiles, char *files[]);
static void error(char *fmt, ...);
static void read_ehdr(Elf64_Ehdr * ehdr, FILE * fp);
static void read_phdr(Elf64_Phdr * phdr, FILE * fp, int ph,
                      Elf64_Ehdr ehdr);
static void write_segment(Elf64_Ehdr ehdr, Elf64_Phdr phdr, FILE * fp,
                          FILE * img, int *nbytes, long *section_header_start, int *first_inv);
static void write_os_size(int nbytes, FILE * img, short k1_size, short k2_size);

int main(int argc, char **argv)
{
    char *progname = argv[0];

    /* process command line options */
    options.vm = 0;
    options.extended = 0;
    while ((argc > 1) && (argv[1][0] == '-') && (argv[1][1] == '-')) {
        char *option = &argv[1][2];

        if (strcmp(option, "vm") == 0) {
            options.vm = 1;
        } else if (strcmp(option, "extended") == 0) {
            options.extended = 1;
        } else {
            error("%s: invalid option\nusage: %s %s\n", progname,
                  progname, ARGS);
        }
        argc--;
        argv++;
    }
    if (options.vm == 1) {
        error("%s: option --vm not implemented\n", progname);
    }
    if (argc < 3) {
        /* at least 3 args (createimage bootblock kernel) */
        error("usage: %s %s\n", progname, ARGS);
    }
    create_image(argc - 1, argv + 1);
    return 0;
}

static void create_image(int nfiles, char *files[])
{
    short k1_size=0, k2_size=0;
    int ph, nbytes = 0, first_inv = 0;
    //ph: which program header
    int ph_start;
    long section_header_start;
    FILE *fp, *img;
    Elf64_Ehdr ehdr;
    Elf64_Phdr phdr;

    /* open the image file */
    img=fopen(IMAGE_FILE,"w+");

    /* for each input file */
    while (nfiles-- > 0) {

        /* open input file */
        fp=fopen(*files,"r");

        /* read ELF header */
        read_ehdr(&ehdr, fp);
        printf("0x%04lx: %s\n", ehdr.e_entry, *files);

        /* for each program header */
        for (ph = 0,ph_start=ehdr.e_phoff,section_header_start=ehdr.e_shoff; ph < ehdr.e_phnum; ph++,ph_start+=ehdr.e_phentsize) {

            /* read program header */
            read_phdr(&phdr, fp, ph, ehdr);
            printf("\tsegment %d\n",ph);
            printf("\t\toffset 0x%04lx",phdr.p_offset);
            printf("\t\tvaddr 0x%04lx\n",phdr.p_vaddr);
            printf("\t\tfilesz 0x%04lx",phdr.p_filesz);
            printf("\t\tmemsz 0x%04lx\n",phdr.p_memsz);

            /* write segment to the image */
            write_segment(ehdr, phdr, fp, img, &nbytes, &section_header_start, &first_inv);
            if(phdr.p_memsz!=0){
                printf("\t\twriting 0x%04lx bytes\n",phdr.p_memsz);
                printf("\t\tpadding up to 0x%04x\n",(nbytes+511)/512*512);
            }
        }
        fclose(fp);
        files++;
        
        //fill a sector when finishing a file
        int to_be_padded;
        if((to_be_padded=SECTOR_SIZE-nbytes%SECTOR_SIZE)<SECTOR_SIZE){
            char *padding=(char *)malloc(to_be_padded);
            memset(padding,0,to_be_padded);
            fwrite(padding,sizeof(char),to_be_padded,img);
            nbytes+=to_be_padded;
        }

        if(first_inv==1){
            if(k1_size==0){
                k1_size=(short)(nbytes/SECTOR_SIZE-1);
            }else{
                k2_size=(short)(nbytes/SECTOR_SIZE-1)-k1_size;
            }
        }
    }

    //k2_size=(short)(nbytes/SECTOR_SIZE-1)-k1_size;
    //printf("k1=%d\n",k1_size);
    //printf("k2=%d\n",k2_size);
    //k1_size=3;
    //k2_size=3;
    write_os_size(nbytes, img, k1_size, k2_size);
    fclose(img);
}

static void read_ehdr(Elf64_Ehdr * ehdr, FILE * fp)
{
    //default: 64 byte for ELF headers
    fread(ehdr,sizeof(Elf64_Ehdr),1,fp);
}

static void read_phdr(Elf64_Phdr * phdr, FILE * fp, int ph,
                      Elf64_Ehdr ehdr)
{
    fseek(fp,ph*ehdr.e_phentsize+sizeof(Elf64_Ehdr),SEEK_SET);
    //go to the start position of this program header
    fread(phdr,ehdr.e_phentsize,1,fp);
}

static void write_segment(Elf64_Ehdr ehdr, Elf64_Phdr phdr, FILE * fp,
                          FILE * img, int *nbytes, long *section_header_start, int *first_inv)
{
    int read_byte=0;//number of bytes read in this segment
    int segment_byte=phdr.p_filesz;//total bytes in this segment
    int mem_sz;
    char *buffer;
    Elf64_Shdr shdr;

    if(*first_inv==0){
        mem_sz=SECTOR_SIZE;
        //*first_inv=1;
    }else{
        mem_sz=phdr.p_memsz;
    }
    buffer=(char *)malloc(mem_sz+1);

    for(;read_byte<segment_byte;){
        fseek(fp,*section_header_start,SEEK_SET);
        fread(&shdr,ehdr.e_shentsize,1,fp);
        //get a section header
        *section_header_start+=ehdr.e_shentsize;

        int padding=shdr.sh_addr-ehdr.e_entry-read_byte;
        if(read_byte>0&&padding>0){
            read_byte+=padding;
        }

        fseek(fp,shdr.sh_offset,SEEK_SET);
        fread(buffer+read_byte,shdr.sh_size,1,fp);
        read_byte+=shdr.sh_size;
    }

    fwrite(buffer,1,mem_sz,img);
    *nbytes+=mem_sz;
    /*if(*first_inv==1){
        for(int i=0;i<mem_sz;i++){
            if(i%16==0){
                printf("%03x: ",i);
            }
            printf("%02hhx ",buffer[i]);
            if(i%16==15){
                printf("\n");
            }
        }
    }*/
    if(*first_inv==0){
        *first_inv=1;
    }
    free(buffer);
}

static void write_os_size(int nbytes, FILE * img, short k1_size, short k2_size)
{
    fseek(img,SECTOR_SIZE-4,SEEK_SET);
    fwrite(&k1_size,2,1,img);
    printf("os1_size: %d sector(s)\n",k1_size);
    if(k2_size!=0){
        fwrite(&k2_size,2,1,img);
        printf("os2_size: %d sector(s)\n",k2_size);
    }
}

/* print an error message and exit */
static void error(char *fmt, ...)
{
    va_list args;

    va_start(args, fmt);
    vfprintf(stderr, fmt, args);
    va_end(args);
    if (errno != 0) {
        perror(NULL);
    }
    exit(EXIT_FAILURE);
}

