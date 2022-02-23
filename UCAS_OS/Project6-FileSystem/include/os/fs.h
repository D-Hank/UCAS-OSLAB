#ifndef INCLUDE_FS_H_
#define INCLUDE_FS_H_

/**************************SD CARD LAYOUT****************************

-------------------------KERNEL RUNNING ENV--------------------------

|    PART NAME   |  SIZE IN SECTOR  |  SECTOR START  |  SECTOR END   |
|   boot block   |        1         |        0       |       0       |
|  kernel image  |     ~=1000       |        1       |     2047      |
|    swap area   |       8192       |      2048      |     10239     |

----------------------------FILE SYSTEM------------------------------
|    PART NAME   |   SIZE IN BLOCK  |  SECTOR START  |   SECTOR END  |
|   super block  |        1         |     2^20       |    2^20+7     |
|    block map   |        4         |     2^20+8     |    2^20+39    |
|    inode map   |        1         |     2^20+40    |    2^20+47    |
|      inode     |      1024        |     2^20+48    |    2^20+xx-1  |
|      data      |      2^17-yy     |     2^20+xx    |    2^21-1     |

********************************************************************/

#include <os/mm.h>
#include <pgtable.h>

//NOTICE: These are in sector size

#define SECTOR_SIZE           512

#define FS_START        (1 << 20) //512MB start
#define FS_SIZE         (1 << 20) //512MB size, 2^20 sectors

#define BLOCK_SIZE      (1 <<  3) //4KB per block (8 sectors)

//NOTICE: These are in block size

#define FS_BLOCK_NUM    (1 << 17) //512MB = 128K * 4KB
#define AVG_FILE_SIZE   (1 <<  2) //2^2 blocks per file

#define SUPER_BLOCK_SIZE        1 //1 sector, aligned to 1 block
#define BLOCK_MAP_SIZE          4 //4 blocks for block map
#define INODE_MAP_SIZE          1 //1 block for inode map
#define INODE_SIZE           1024 //32K * 128 byte = 4 MB, 1K blocks

#define SUPER_BLOCK_NUM (1 <<  0)
#define BLOCK_MAP_NUM   (1 <<  0)
#define INODE_MAP_NUM   (1 <<  0)
#define INODE_NUM       (1 << 15) //2^15(32K) file/dir at most
#define DATA_BLOCK_NUM  ((FS_BLOCK_NUM) - (SUPER_BLOCK_SIZE) - (BLOCK_MAP_SIZE) - (INODE_MAP_SIZE) - (INODE_SIZE))

#define BLOCK_MAP_BYTE     ((BLOCK_MAP_SIZE   ) << 12)
#define INODE_MAP_BYTE     ((INODE_MAP_SIZE   ) << 12)
#define INODE_BYTE         ((INODE_SIZE       ) << 12)

//NOTICE: sector view

#define SUPER_BLOCK_SECTOR ((SUPER_BLOCK_SIZE ) << 3)
#define BLOCK_MAP_SECTOR   ((BLOCK_MAP_SIZE   ) << 3)
#define INODE_MAP_SECTOR   ((INODE_MAP_SIZE   ) << 3)
#define INODE_SECTOR       ((INODE_SIZE       ) << 3)

#define SUPER_BLOCK_START  ((FS_START         ) +                   0 ) //1048576
#define BLOCK_MAP_START    ((SUPER_BLOCK_START) + (SUPER_BLOCK_SECTOR)) //1048584
#define INODE_MAP_START    ((BLOCK_MAP_START  ) + (BLOCK_MAP_SECTOR  )) //1048616
#define INODE_START        ((INODE_MAP_START  ) + (INODE_MAP_SECTOR  )) //1048624
#define DATA_BLOCK_START   ((INODE_START      ) + (INODE_SECTOR      )) //1056816

#define DIRECT_BLOCK_NUM 6
#define INDIRECT_1_NUM   3
#define INDIRECT_2_NUM   2
#define INDIRECT_3_NUM   1

#define MAX_NAME 24
#define MAX_FD   32
#define MAX_FILE_LEVEL 3

#define DHK_MAGIC        0xBadBabe


typedef struct superblock{
    unsigned long long magic;
    unsigned long long fs_size;
    unsigned long long fs_start;

    unsigned long long block_map_start;
    unsigned long long block_map_sectors;
    unsigned long long block_map_num;

    unsigned long long inode_map_start;
    unsigned long long inode_map_sectors;
    unsigned long long inode_map_num;

    unsigned long long inode_start;
    unsigned long long inode_num;
    unsigned long long inode_free;

    unsigned long long data_block_start;
    unsigned long long data_block_num;
    unsigned long long data_block_free;

    unsigned long long inode_size;
    unsigned long long dentry_size;

    char padding[376];
} superblock_t;

typedef enum inode_mode{
    I_DIR,
    I_FILE,
} inode_mode_t;

typedef enum access{
    O_RDWR,
    O_RDONLY,
    O_WRONLY,
} access_t;

typedef struct inode{//32*4 = 128 byte
    unsigned inode_id;
    unsigned owner_pid;
    inode_mode_t mode;
    access_t access;
    unsigned links;
    unsigned file_size;
    unsigned file_num;//for dir node
    unsigned create_time;
    unsigned modify_time;

    //stores data block id
    unsigned direct_block[DIRECT_BLOCK_NUM];
    unsigned indirect_1[INDIRECT_1_NUM];
    unsigned indirect_2[INDIRECT_2_NUM];
    unsigned indirect_3;

    unsigned padding[11];
} inode_t;

typedef enum dentry_mode{
    D_NULL,
    D_DIR,
    D_FILE,
} dentry_mode_t;

typedef struct dentry{//32 byte
    unsigned inode_id;
    dentry_mode_t mode;
    char name[MAX_NAME];
} dentry_t;

typedef enum fd_status{
    FD_EMPTY,
    FD_BUSY,
} fd_status_t;

typedef struct fd{
    unsigned inode_id;
    fd_status_t status;
    access_t access;
    unsigned rd_offset;
    unsigned wr_offset;
} fd_t;

typedef char* block_map_t;
typedef char* inode_map_t;
typedef char* data_block_t;

typedef unsigned ind_ptr_t;//indirect pointer

superblock_t superblock;
char inode_buffer[SECTOR_SIZE];
char block_map_buffer[BLOCK_MAP_BYTE];
char inode_map_buffer[INODE_MAP_BYTE];
char data_block_buffer[NORMAL_PAGE_SIZE];
char data_block_temp[NORMAL_PAGE_SIZE];
//inode_t root_inode;
//unsigned current_inode_id;
//unsigned current_block_id;
inode_t cur_dir_inode;
extern data_block_t cur_dir_block;

//These are temp blocks
extern data_block_t data_temp;
extern block_map_t block_map;
extern inode_map_t inode_map;

fd_t fd_array[MAX_FD];

extern unsigned init_inode_id;

#define IND_PTR_NUM ((NORMAL_PAGE_SIZE) / sizeof(ind_ptr_t))

#define INDIRECT_1_SIZE      ((NORMAL_PAGE_SIZE) * (IND_PTR_NUM))
#define INDIRECT_2_SIZE      ((NORMAL_PAGE_SIZE) * (IND_PTR_NUM) * (IND_PTR_NUM))
#define INDIRECT_3_SIZE      ((NORMAL_PAGE_SIZE) * (IND_PTR_NUM) * (IND_PTR_NUM) * (IND_PTR_NUM))

#define MAX_DIRECT_SIZE      ((DIRECT_BLOCK_NUM) * (NORMAL_PAGE_SIZE))
#define MAX_INDIRECT_1_SIZE  ((INDIRECT_1_NUM  ) * (INDIRECT_1_SIZE ))
#define MAX_INDIRECT_2_SIZE  ((INDIRECT_2_NUM  ) * (INDIRECT_2_SIZE ))
#define MAX_INDIRECT_3_SIZE  ((INDIRECT_3_NUM  ) * (INDIRECT_3_SIZE ))
// 6 * 4KB = 6 * 4096 B = 24576 B
// 3 * 4MB = 3 * 35,651,584 B
// 2 * 4GB = 2 *  xxx
// 1 * 4TB

#define INDIRECT_1_PAGE      (IND_PTR_NUM)
#define INDIRECT_2_PAGE      ((IND_PTR_NUM) * (IND_PTR_NUM))
#define INDIRECT_3_PAGE      ((IND_PTR_NUM) * (IND_PTR_NUM) * (IND_PTR_NUM))

#define MAX_DIRECT_PAGE      (DIRECT_BLOCK_NUM)
#define MAX_INDIRECT_1_PAGE  ((INDIRECT_1_NUM) * (INDIRECT_1_PAGE))
#define MAX_INDIRECT_2_PAGE  ((INDIRECT_2_NUM) * (INDIRECT_2_PAGE))
#define MAX_INDIRECT_3_PAGE  ((INDIRECT_3_NUM) * (INDIRECT_3_PAGE))

#define START_LEVEL_0        (MAX_DIRECT_PAGE)
#define START_LEVEL_1        ((MAX_DIRECT_PAGE) + (MAX_INDIRECT_1_PAGE))
#define START_LEVEL_2        ((MAX_DIRECT_PAGE) + (MAX_INDIRECT_1_PAGE) + (MAX_INDIRECT_2_PAGE))
#define START_LEVEL_3        ((MAX_DIRECT_PAGE) + (MAX_INDIRECT_1_PAGE) + (MAX_INDIRECT_2_PAGE) + (MAX_INDIRECT_3_PAGE))

#define DENTRY_NUM                     ((NORMAL_PAGE_SIZE) / (superblock.dentry_size))
#define MAP_BYTE_TO_ID(base, offset)   (((base) << 3) + (offset))
#define BLOCK_ID_TO_SECTOR(id)         ((superblock.data_block_start) + ((id) << 3))
#define DEALLOC_MAP(byte, bit)         ((byte) & (~((unsigned char)((0x1lu) << (bit)))))

#define min(a,b) (((a) < (b)) ? (a) : (b))
#define max(a,b) (((a) > (b)) ? (a) : (b))

void init_fs();

void do_remake();
void make_fs();
void make_superblock();
void make_block_map();
void make_inode_map();

void init_fd();
void init_inode(inode_t *dest_inode, unsigned dest_block, unsigned dest_id, inode_mode_t mode, access_t access);
void init_dir_block(dentry_t *dir_block, unsigned dir_id, unsigned parent_id);

int do_mkfs();
void do_statfs();

int do_mkdir(char *dir_name);
int do_rmdir(char *dir_name);
int do_cd(char *dir_name);
void do_ls(int argc, char *argv[]);

int do_mknod(char *file_name);
int do_unlink(char *file_name);
int do_cat(char *file_name);

int do_open(char *file_name, access_t access);
int do_write(int fd, char *buff, int size);
int do_read(int fd, char *buff, int size);
void do_close(int fd);
int do_lseek(int fd, int offset, int whence, char rw);

int do_link(char *src, char *dest);

void read_superblock();
void write_superblock();

void read_inode(inode_t *dest_node, unsigned inode_id);
void write_inode(inode_t *src_node, unsigned inode_id);
void read_block_map();
void write_block_map();
void read_inode_map();
void write_inode_map();
void read_block(data_block_t dest_block, int block_id);
void write_block(data_block_t src_block, int block_id);

unsigned alloc_inode();
unsigned alloc_block();//update
unsigned alloc_block_one();
//unsigned alloc_block_batch(int num);
void dealloc_inode(unsigned inode_id);
void dealloc_block(unsigned block_id);

void clear_block(unsigned block_id);

int search_dentry(dentry_t *search_in, char *dir_name, dentry_mode_t mode);
int alloc_dentry(dentry_t *dir);

int byte_locate(unsigned *start_block_id, unsigned *start_byte, unsigned offset, inode_t *in_inode);
dentry_t *get_parent_dir(char *file_name, int *file_inode, unsigned *parent_inode);
void update_cur_dir();

void enlarge_file_size(int old_sz, int new_sz, inode_t *in_inode);

#endif
