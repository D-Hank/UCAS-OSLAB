#include <os/fs.h>
#include <sbi.h>
#include <os/mm.h>
#include <pgtable.h>
#include <os/stdio.h>
#include <assert.h>
#include <os/time.h>
#include <screen.h>

unsigned init_inode_id = 0;
block_map_t block_map = (block_map_t)block_map_buffer;
inode_map_t inode_map = (inode_map_t)inode_map_buffer;
data_block_t cur_dir_block = (data_block_t)data_block_buffer;
data_block_t data_temp = (data_block_t)data_block_temp;

/*******************************NOTICE*****************************************
1. When we do allocating, we ignore those blocks occupied before init.
2. Stack for some functions may be larger than 4KB, pay attention to overflow!
3. Removing a non-empty directory is not supported.
4. Setting hard link on a directory is not allowed.
5. Absolute path is only used in `do_link` now.
6. For a file, we use direct block first, then indirect1, 2, 3
7. When removing a node, we should set block_ptr=0
8. Byte locate can change the file size.
9. Print too many lines at a time may cause buffer overflow!
10. Current directory may be updated. Please verify before using!
11. Unlinking a large file is not supported now.
12. Allocating blank blocks should be done in do_lseek
13. Pay attention to temp blocks!!!


******************************************************************************/

#define UNCACHE

// Look-up Table
//little endian
char alloc_table[256] = {
    0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4,
    0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,5,
    0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4,
    0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,6,
    0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4,
    0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,5,
    0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4,
    0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,7,
    0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4,
    0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,5,
    0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4,
    0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,6,
    0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4,
    0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,5,
    0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4,
    0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,-1
};

char new_alloc_table[256] = {
      1,  3,  3,  7,  5,  7,  7, 15,  9, 11, 11, 15, 13, 15, 15, 31,
     17, 19, 19, 23, 21, 23, 23, 31, 25, 27, 27, 31, 29, 31, 31, 63,
     33, 35, 35, 39, 37, 39, 39, 47, 41, 43, 43, 47, 45, 47, 47, 63,
     49, 51, 51, 55, 53, 55, 55, 63, 57, 59, 59, 63, 61, 63, 63,127,
     65, 67, 67, 71, 69, 71, 71, 79, 73, 75, 75, 79, 77, 79, 79, 95,
     81, 83, 83, 87, 85, 87, 87, 95, 89, 91, 91, 95, 93, 95, 95,127,
     97, 99, 99,103,101,103,103,111,105,107,107,111,109,111,111,127,
    113,115,115,119,117,119,119,127,121,123,123,127,125,127,127,255,
    129,131,131,135,133,135,135,143,137,139,139,143,141,143,143,159,
    145,147,147,151,149,151,151,159,153,155,155,159,157,159,159,191,
    161,163,163,167,165,167,167,175,169,171,171,175,173,175,175,191,
    177,179,179,183,181,183,183,191,185,187,187,191,189,191,191,255,
    193,195,195,199,197,199,199,207,201,203,203,207,205,207,207,223,
    209,211,211,215,213,215,215,223,217,219,219,223,221,223,223,255,
    225,227,227,231,229,231,231,239,233,235,235,239,237,239,239,255,
    241,243,243,247,245,247,247,255,249,251,251,255,253,255,255, -1
};

//use this table by `access_table[want][permit]`
int access_table[3][3] = {
    1,0,0,
    1,1,0,
    1,0,1
};

void read_superblock(){
    //padding to 1 block, but the buffer is 512B
    sbi_sd_read(kva2pa(&superblock), 1, SUPER_BLOCK_START);
}

void write_superblock(){
    sbi_sd_write(kva2pa(&superblock), 1, SUPER_BLOCK_START);
}

void read_inode(inode_t *dest_node, unsigned inode_id){
    // 4 inodes in a sector
    unsigned base = inode_id / (SECTOR_SIZE / superblock.inode_size);
    unsigned off  = inode_id % (SECTOR_SIZE / superblock.inode_size);
    unsigned sector_id = superblock.inode_start + (base << 9);

    sbi_sd_read(kva2pa((uintptr_t)inode_buffer), 1, sector_id);
    //move this inode in 512 byte to dest_node of 128 byte
    // Here we won't consider the case that dest_node is already in the buffer
    kmemcpy(dest_node, inode_buffer + off * superblock.inode_size, superblock.inode_size);
}

void write_inode(inode_t *src_node, unsigned inode_id){
    unsigned base = inode_id / (SECTOR_SIZE / superblock.inode_size);
    unsigned off  = inode_id % (SECTOR_SIZE / superblock.inode_size);
    unsigned sector_id = superblock.inode_start + (base << 9);

    sbi_sd_read(kva2pa((uintptr_t)inode_buffer), 1, sector_id);
    kmemcpy(inode_buffer + off * superblock.inode_size, src_node, superblock.inode_size);
    sbi_sd_write(kva2pa((uintptr_t)inode_buffer), 1, sector_id);
}

void read_inode_map(){
    // Let's do it simply, 8 sectors in and out
    sbi_sd_read(kva2pa((uintptr_t)inode_map), superblock.inode_map_sectors, superblock.inode_map_start);
}

void read_block_map(){
    sbi_sd_read(kva2pa((uintptr_t)block_map), superblock.block_map_sectors, superblock.block_map_start);
}

void write_block_map(){
    sbi_sd_write(kva2pa((uintptr_t)block_map), superblock.block_map_sectors, superblock.block_map_start);
}

void write_inode_map(){
    sbi_sd_write(kva2pa((uintptr_t)inode_map), superblock.inode_map_sectors, superblock.inode_map_start);
}

void read_block(data_block_t dest_block, int block_id){//only read one block every time
    sbi_sd_read(kva2pa((uintptr_t)dest_block), BLOCK_SIZE, BLOCK_ID_TO_SECTOR(block_id));
}

void write_block(data_block_t src_block, int block_id){
    sbi_sd_write(kva2pa((uintptr_t)src_block), BLOCK_SIZE, BLOCK_ID_TO_SECTOR(block_id));
}

void init_fs(){
    //get the super block
    read_superblock();

    if(superblock.magic == DHK_MAGIC){
        printk("> [INIT] DHK fs recognized...\n");

        //existed
        do_statfs();
        //read root dir
        read_inode(&cur_dir_inode, init_inode_id);
        read_block(cur_dir_block, cur_dir_inode.direct_block[0]);
        read_inode_map();
        read_block_map();
    }else{
        printk("> [INIT] No supported file system, now creating one...\n");
        make_fs();
    }

    init_fd();

    printk("> [INIT] Init file system succeeded.\n");
}

void init_fd(){
    for(int i=0;i<MAX_FD;i++){
        fd_array[i].status = FD_EMPTY;
    }
}

void make_superblock(){
    prints("[FS] Setting superblock...\n");

    superblock.magic = DHK_MAGIC;
    superblock.fs_size = FS_SIZE;
    superblock.fs_start = FS_START;

    superblock.block_map_start = BLOCK_MAP_START;
    superblock.block_map_sectors = BLOCK_MAP_SECTOR;
    superblock.block_map_num = 1;

    superblock.inode_map_start = INODE_MAP_START;
    superblock.inode_map_sectors = INODE_MAP_SECTOR;
    superblock.inode_map_num = 1;

    superblock.inode_start = INODE_START;
    superblock.inode_num = INODE_NUM;
    superblock.inode_free = INODE_NUM;

    superblock.data_block_start = DATA_BLOCK_START;
    superblock.data_block_num = DATA_BLOCK_NUM;
    superblock.data_block_free = DATA_BLOCK_NUM;
    //just ignore those blocks occupied before init
    //especially when we allocate blocks

    superblock.inode_size = sizeof(inode_t);
    superblock.dentry_size = sizeof(dentry_t);

    write_superblock();
}

void make_block_map(){
    kmemset(block_map, 0, superblock.block_map_sectors << 9);
    write_block_map();
}

void make_inode_map(){
    kmemset(inode_map, 0, superblock.inode_map_sectors << 9);
    write_inode_map();
}

void make_root_dir(){
    //allocate space for root dir
    unsigned root_id = alloc_inode();
    assert(root_id == init_inode_id);

    //data block consists of dentries
    unsigned block_id = alloc_block();

    init_inode(&cur_dir_inode, block_id, root_id, I_DIR, O_RDWR);

    write_inode(&cur_dir_inode, root_id);

    read_block(cur_dir_block, block_id);

    init_dir_block((dentry_t *)cur_dir_block, root_id, root_id);

    write_block(cur_dir_block, block_id);

    //current_inode_id = root_id;
    //current_block_id = block_id;
}

//NOTICE: this dir_block should be 4K-sized
void init_dir_block(dentry_t *dir_block, unsigned dir_id, unsigned parent_id){
    //here id is inode id
    //clear this block for directory
    kmemset(dir_block, 0, NORMAL_PAGE_SIZE);
    dir_block[0].inode_id = dir_id;
    dir_block[0].mode = D_DIR;
    dir_block[0].name[0] = '.';
    dir_block[0].name[1] = '\0';

    dir_block[1].inode_id = parent_id;
    dir_block[1].mode = D_DIR;
    dir_block[1].name[0] = '.';
    dir_block[1].name[1] = '.';
    dir_block[1].name[2] = '\0';
}

void init_inode(inode_t *dest_inode, unsigned dest_block, unsigned dest_id, inode_mode_t mode, access_t access){
    dest_inode->inode_id = dest_id;
    dest_inode->owner_pid = 0;
    dest_inode->mode = mode;
    dest_inode->access = access;
    dest_inode->links = 1;
    //ignore self to self, only consider parent
    dest_inode->file_size = 0;
    //init size, first allocate 4KB
    dest_inode->create_time = get_timer();
    dest_inode->modify_time = get_timer();

    dest_inode->direct_block[0] = dest_block;
    //allocate one block at first
    for(int i=1;i<DIRECT_BLOCK_NUM;i++){
        dest_inode->direct_block[i] = 0;
    }
    for(int i=0;i<INDIRECT_1_NUM;i++){
        dest_inode->indirect_1[i] = 0;
    }
    for(int i=0;i<INDIRECT_2_NUM;i++){
        dest_inode->indirect_2[i] = 0;
    }
    dest_inode->indirect_3 = 0;

    if(mode == I_DIR){
        dest_inode->file_num = 2;
    }else{
        dest_inode->file_num = 0;
    }
}

unsigned alloc_inode(){//returns an inode id
    read_inode_map();
    static int next_search = 0;//last searched byte
    int i;//counter
    int base;//which byte
    int offset;//which bit of this byte
    int found=0;
    for(base=next_search,i=0;i<INODE_NUM;i++,base=(base+1)%INODE_NUM){
        if(inode_map[base] != 0xFF){
            found=1;
            break;
        }
    }

    if(found==1){
        char byte = inode_map[base];
        offset = alloc_table[byte];
        if(offset == 7){
            next_search++;
        }
        inode_map[base] = new_alloc_table[byte];

        write_inode_map();
        superblock.inode_free--;
        write_superblock();

        return MAP_BYTE_TO_ID(base, offset);
    }

    assert(0);// inode not enough
}

unsigned alloc_block_one(){//not updated
    read_block_map();
    static int next_search = 0;
    int i;
    int base;
    int offset;
    int found=0;
    for(base=next_search,i=0;i<DATA_BLOCK_NUM;i++,base=(base+1)%DATA_BLOCK_NUM){
        if(block_map[base] != 0xFF){
            found=1;
            break;
        }
    }

    if(found==1){
        char byte = block_map[base];
        offset = alloc_table[byte];
        if(offset == 7){
            next_search++;
        }
        block_map[base] = new_alloc_table[byte];
        superblock.data_block_free--;

        return MAP_BYTE_TO_ID(base, offset);
    }

    assert(0);// data block not enough
}

unsigned alloc_block(){//similar to alloc_inode

    int ret = alloc_block_one();

//#ifdef UNCACHE
    write_block_map();
//#endif

    write_superblock();

    return ret;
}

void dealloc_inode(unsigned inode_id){
    read_inode_map();//necessary?
    unsigned base = inode_id >> 3;//which byte
    unsigned offset = inode_id & 0b111;//which bit of this byte
    inode_map[base] = DEALLOC_MAP(inode_map[base], offset);
    superblock.inode_free++;
    //update
    write_superblock();
    write_inode_map();
}

void dealloc_block(unsigned block_id){
    read_block_map();//necessary?
    unsigned base = block_id >> 3;
    unsigned offset = block_id & 0b111;
    block_map[base] = DEALLOC_MAP(block_map[base], offset);
    superblock.data_block_free++;
    write_superblock();
    write_block_map();
}

int search_dentry(dentry_t *search_in, char *dir_name, dentry_mode_t mode){
    //returns a status
    //1 for found, -1 for not found
    int i;
    for(i=2;i<DENTRY_NUM;i++){
        if(search_in[i].mode==mode){
            if(kstrcmp(search_in[i].name, dir_name)==0){
                return i;//found
            }
        }
    }

    return -1;//not found
}

//just do it simple, we won't use next search here
int alloc_dentry(dentry_t *dir){
    int i;
    for(i=2;i<DENTRY_NUM;i++){
        if(dir[i].mode==D_NULL){
            return i;
        }
    }

    return -1;//not enough
}

int alloc_fd(){
    int i;
    for(i=0;i<MAX_FD;i++){
        if(fd_array[i].status == FD_EMPTY){
            fd_array[i].status = FD_BUSY;
            return i;
        }
    }

    return -1;//not enough
}

void clear_block(unsigned block_id){
    kmemset(data_temp, 0, NORMAL_PAGE_SIZE);//clear new block
    write_block(data_temp, block_id);
}

int do_mkfs(){
    //superblock may have not been read to memory
    read_superblock();
    if(superblock.magic == DHK_MAGIC){
        prints("File system already existed!\n");
        return -1;
    }else{
        do_remake();
        return 1;
    }
}

void do_remake(){
    kmemset(block_map, 0, superblock.block_map_sectors << 9);
    write_block_map();
    kmemset(inode_map, 0, superblock.inode_map_sectors << 9);
    write_inode_map();
    kmemset(&superblock, 0, sizeof(superblock_t));
    write_superblock();
    init_fs();
}

void make_fs(){
    prints("[FS] Start to initialize FS!\n");

    make_superblock();
    make_block_map();
    make_root_dir();
}

void do_statfs(){
    prints("MAGIC word: 0x%X\n", superblock.magic);
    prints("Start at: 0x%x\n", superblock.fs_start);
    prints("Inode map start at: 0x%x\n",superblock.inode_map_start);
    prints("Block map start at: 0x%x\n",superblock.block_map_start);
    prints("Inode used: %d/%d, start at: 0x%x\n",superblock.inode_num-superblock.inode_free, superblock.inode_num,superblock.inode_start);
    prints("Data block used: %d/%d, start at: 0x%x\n",superblock.data_block_num-superblock.data_block_free, superblock.data_block_num, superblock.data_block_start);
    prints("Inode size: %dB, dentry size: %dB\n",superblock.inode_size, superblock.dentry_size);
    return;
}

int do_mkdir(char *dir_name){
    //create a new dir in current dir
    dentry_t *cur_dir = (dentry_t *)cur_dir_block;
    //NOTE: dentries are in the data block now
    //Child dir has the same name as parent dir?

    if(search_dentry(cur_dir, dir_name, D_DIR)>0){
        return -1;
    }

    int i = alloc_dentry(cur_dir);
    if(i<0){
        return -2;
    }

    unsigned new_inode = alloc_inode();
    unsigned new_block = alloc_block();

    //write new dir inode
    inode_t inode_temp;
    //read_inode(&inode_temp, new_inode);
    init_inode(&inode_temp, new_block, new_inode, I_DIR, O_RDWR);
    write_inode(&inode_temp, new_inode);

    cur_dir[i].inode_id = new_inode;
    kstrcpy(cur_dir[i].name, dir_name);
    cur_dir[i].mode = D_DIR;

    //write back current data block
    //direct[0] is current block
    write_block(cur_dir_block, cur_dir_inode.direct_block[0]);

    //get and write back new dir block
    read_block(data_temp, new_block);//necessary?
    init_dir_block((dentry_t *)data_temp, new_inode, cur_dir_inode.inode_id);
    write_block(data_temp, new_block);

    //here cur_dir is invalid
    cur_dir_inode.file_num++;
    cur_dir_inode.links++;
    //add one entry to this directory
    cur_dir_inode.file_size += superblock.dentry_size;
    cur_dir_inode.modify_time = get_timer();

    //write back cur dir inode
    write_inode(&cur_dir_inode, cur_dir_inode.inode_id);

    return 0;
}

int do_rmdir(char *dir_name){
    dentry_t *cur_dir = (dentry_t *)cur_dir_block;

    int index = search_dentry(cur_dir, dir_name, D_DIR);
    if(index<0){
        return -1;
    }

    unsigned rm_inode_id = cur_dir[index].inode_id;
    cur_dir[index].mode = D_NULL;
    cur_dir_inode.file_num--;
    cur_dir_inode.links--;
    cur_dir_inode.file_size -= superblock.dentry_size;
    cur_dir_inode.modify_time = get_timer();

    write_inode(&cur_dir_inode, cur_dir_inode.inode_id);
    write_block(cur_dir_block, cur_dir_inode.direct_block[0]);

    //Note: no hard link on this directory, so just dealloc
    inode_t rm_inode;
    read_inode(&rm_inode, rm_inode_id);

    unsigned rm_block_id = rm_inode.direct_block[0];
    dealloc_inode(rm_inode_id);
    dealloc_block(rm_block_id);

    //Maybe we can use a function do_rmnod?
    return 1;
}

int do_cd(char *dir_name){
    dentry_t *cur_dir = (dentry_t *)cur_dir_block;

    int index;
    if(strcmp(dir_name,".") == 0){
        return 1;//current to current
    }else if(strcmp(dir_name,"..") == 0){
        if(cur_dir_inode.inode_id == init_inode_id){
            return 1;//root cd to root
        }
        index=1;
    }else if((index=search_dentry(cur_dir, dir_name, D_DIR)) < 0){
        return -1;
    }

    //write back current dir
    write_inode(&cur_dir_inode, cur_dir_inode.inode_id);
    write_block(cur_dir_block, cur_dir_inode.direct_block[0]);

    unsigned cd_inode_id = cur_dir[index].inode_id;
    read_inode(&cur_dir_inode, cd_inode_id);
    unsigned cd_block_id = cur_dir_inode.direct_block[0];
    read_block(cur_dir_block, cd_block_id);

    return 1;
}

void do_ls(int argc, char *argv[]){
    //Update current directory
    //read_inode(&cur_dir_inode, cur_dir_inode.inode_id);
    dentry_t *cur_dir = (dentry_t *)cur_dir_block;

    int option = 0;//default
    if((argc == 1) && (strcmp(argv[0], "-l") == 0)){
        option = 1;
    }

    if(option == 0){
        int i=0;//traverse
        int file=0;
        for(;file<cur_dir_inode.file_num;i++){
            if(cur_dir[i].mode != D_NULL){
                prints("%s ",cur_dir[i].name);
                file++;
            }
        }
        prints("\n");
    }else if(option == 1){
        prints("INODE SIZE    LINKS  NAME\n");
        int i=0;
        int file=0;
        for(;file<cur_dir_inode.file_num;i++){
            if(cur_dir[i].mode != D_NULL){
                inode_t inode_temp;
                read_inode(&inode_temp, cur_dir[i].inode_id);
                prints("\t\t%u\t\t\t%dB\t\t\t\t\t\t%u\t\t\t\t%s\n",inode_temp.inode_id, inode_temp.file_size, inode_temp.links, cur_dir[i].name);
                screen_reflush();
                file++;
            }
        }
    }
}

int do_mknod(char *file_name){//mknod and mkdir can be one function?
    dentry_t *cur_dir = (dentry_t *)cur_dir_block;

    if(search_dentry(cur_dir, file_name, D_FILE)>0){
        return -1;
    }

    int i = alloc_dentry(cur_dir);
    if(i < 0){
        return -2;
    }

    unsigned new_inode = alloc_inode();
    unsigned new_block = alloc_block();

    inode_t inode_temp;
    init_inode(&inode_temp, new_block, new_inode, I_FILE, O_RDWR);
    write_inode(&inode_temp, new_inode);

    cur_dir[i].inode_id = new_inode;
    kstrcpy(cur_dir[i].name, file_name);
    cur_dir[i].mode = D_FILE;

    write_block(cur_dir_block, cur_dir_inode.direct_block[0]);

    clear_block(new_block);

    cur_dir_inode.file_num++;
    //cur_dir_inode.links++;
    //cur_dir_inode.file_size = 0;//no data in this file
    cur_dir_inode.modify_time = get_timer();

    write_inode(&cur_dir_inode, cur_dir_inode.inode_id);

    return 0;

}

int do_unlink(char *file_name){
    dentry_t *cur_dir = (dentry_t *)cur_dir_block;

    int index = search_dentry(cur_dir, file_name, D_FILE);
    if(index<0){
        return -1;
    }

    unsigned unlink_inode_id = cur_dir[index].inode_id;
    inode_t unlink_inode;
    read_inode(&unlink_inode, unlink_inode_id);
    if(unlink_inode.file_size > NORMAL_PAGE_SIZE){
        return -2;//too large
    }
    unlink_inode.links--;
    write_inode(&unlink_inode, unlink_inode_id);

    cur_dir[index].mode = D_NULL;
    cur_dir_inode.file_num--;
    cur_dir_inode.modify_time = get_timer();
    write_inode(&cur_dir_inode, cur_dir_inode.inode_id);
    write_block(cur_dir_block, cur_dir_inode.direct_block[0]);
    //update_cur_dir();

    if(unlink_inode.links == 0){//Remove a small file
        dealloc_inode(unlink_inode_id);
        dealloc_block(unlink_inode.direct_block[0]);
    }else{
        unlink_inode.modify_time = get_timer();
    }

    return 0;
}

int do_cat(char *file_name){
    dentry_t *cur_dir = (dentry_t *)cur_dir_block;

    int index;
    if((index=search_dentry(cur_dir, file_name, D_FILE))<0){
        return -1;
    }

    unsigned cat_inode_id = cur_dir[index].inode_id;
    inode_t inode_temp;
    read_inode(&inode_temp, cat_inode_id);
    unsigned cat_size = inode_temp.file_size;
    /*if(cat_size > NORMAL_PAGE_SIZE || cat_size <= 0){
        return -2;//too large to print
    }*/

    unsigned cat_block_id = inode_temp.direct_block[0];
    read_block(data_temp, cat_block_id);
    data_temp[cat_size - 1] = 0;
    prints("%s\n",data_temp);
    return 1;
}

int do_open(char *file_name, access_t access){
    dentry_t *cur_dir = (dentry_t *)cur_dir_block;

    int index;
    if((index=search_dentry(cur_dir, file_name, D_FILE))<0){
        return -1;//no such file
    }

    unsigned open_inode_id = cur_dir[index].inode_id;
    inode_t inode_temp;
    read_inode(&inode_temp, open_inode_id);
    if((access != inode_temp.access) && (inode_temp.access != O_RDWR)){
        return -2;//permission denied
    }

    int open_fd;
    if((open_fd = alloc_fd()) < 0){
        return -3;//out of fd
    }

    fd_array[open_fd].access = access;
    fd_array[open_fd].inode_id = open_inode_id;
    fd_array[open_fd].rd_offset = 0;
    fd_array[open_fd].wr_offset = 0;//when open, pointed at beginning

    return open_fd;
}

int do_write(int fd, char *buff, int size){
    fd_t *fp = &(fd_array[fd]);
    if(fp->status == FD_EMPTY){
        return 0;//no such file
    }
    if(fp->access == O_RDONLY){
        return 0;//permission denied
    }
    if(fp->wr_offset + size > START_LEVEL_3){
        return 0;//file size too large
    }

    //start to write
    //When we write, we write at last writing position
    unsigned wr_inode_id = fp->inode_id;
    inode_t wr_inode;
    read_inode(&wr_inode, wr_inode_id);
    unsigned sz_written = 0;
    while(size > 0){
        unsigned wr_off = fp->wr_offset;
        unsigned start_block_id;
        unsigned start_byte;

        int status = byte_locate(&start_block_id, &start_byte, wr_off, &wr_inode);
        if(status < 0){
            break;//file size too large
        }

        unsigned wr_size = min(size, NORMAL_PAGE_SIZE - start_byte);
        read_block(data_temp, start_block_id);
        kmemcpy(data_temp + start_byte, buff + sz_written, wr_size);
        write_block(data_temp, start_block_id);

        size -= wr_size;
        sz_written += wr_size;
        fp->wr_offset += wr_size;
    }

    //or wr_offset + 1 ?
    wr_inode.file_size = max(wr_inode.file_size, fp->wr_offset + 1);
    wr_inode.modify_time = get_timer();
    write_inode(&wr_inode, wr_inode_id);

    return sz_written;

}

int do_read(int fd, char *buff, int size){
    fd_t *fp = &(fd_array[fd]);
    if(fp->status == FD_EMPTY){
        return 0;
    }
    if(fp->access == O_WRONLY){
        return 0;
    }

    //start to read
    unsigned rd_inode_id = fp->inode_id;
    inode_t rd_inode;
    read_inode(&rd_inode, rd_inode_id);
    if(fp->rd_offset + size > rd_inode.file_size){
        return 0;//too large
    }

    unsigned sz_read = 0;
    while(size > 0){
        unsigned rd_off = fp->rd_offset;
        unsigned start_block_id;
        unsigned start_byte;

        int status = byte_locate(&start_block_id, &start_byte, rd_off, &rd_inode);
        if(status < 0){
            break;//file size not enough or too large
        }

        unsigned rd_size = min(size, NORMAL_PAGE_SIZE - start_byte);
        read_block(data_temp, start_block_id);
        kmemcpy(buff + sz_read, data_temp + start_byte, rd_size);
        write_block(data_temp, start_block_id);

        size -= rd_size;
        sz_read += rd_size;
        fp->rd_offset += rd_size;
    }

    //or rd_offset + 1 ?
    rd_inode.file_size = max(rd_inode.file_size, fp->rd_offset + 1);
    rd_inode.modify_time = get_timer();
    write_inode(&rd_inode, rd_inode_id);

    return sz_read;
}

void do_close(int fd){
    /*fd_t *fp = &(fd_array[fd]);
    if(fp->status == FD_EMPTY){
        return;
    }*/
    fd_array[fd].status = FD_EMPTY;
}

int do_link(char *src, char *dest){
    //USAGE: ln src_file dest_file
    int src_inode_id;
    unsigned src_parent_inode;
    dentry_t *src_parent_dir = get_parent_dir(src, &src_inode_id, &src_parent_inode);
    if(src_parent_dir == NULL || src_inode_id < 0){
        return -1;
    }

    int temp;//will be -1
    unsigned dest_parent_inode;
    dentry_t *dest_parent = get_parent_dir(dest, &temp, &dest_parent_inode);
    if(dest_parent == NULL){
        return -1;
    }
    temp = alloc_dentry(dest_parent);
    if(temp < 0){
        return -2;
    }

    char new_name[MAX_NAME];
    int i = kstrlen(dest);
    new_name[i--] = 0;
    for(; (i>=0) && (dest[i] != '/'); i--){
        new_name[i] = dest[i];
    }

    dest_parent[temp].inode_id = src_inode_id;
    kstrcpy(dest_parent[temp].name, &new_name[i+1]);
    dest_parent[temp].mode = D_FILE;

    inode_t inode_temp;
    read_inode(&inode_temp, dest_parent_inode);
    inode_temp.file_num++;
    inode_temp.modify_time = get_timer();
    write_inode(&inode_temp, dest_parent_inode);

    write_block((data_block_t)dest_parent, inode_temp.direct_block[0]);

    read_inode(&inode_temp, src_inode_id);
    inode_temp.links++;
    inode_temp.modify_time = get_timer();
    write_inode(&inode_temp, src_inode_id);

    update_cur_dir();//may revise current directory

    return 0;
}

// to find which byte of which data block
int byte_locate(unsigned *locate_block_id, unsigned *locate_byte, unsigned offset, inode_t *in_inode){
    unsigned start_level;
    unsigned page_id = offset / NORMAL_PAGE_SIZE;
    unsigned start_byte = offset % NORMAL_PAGE_SIZE;
    if(page_id < START_LEVEL_0){
        start_level = 0;
    }else if(page_id < START_LEVEL_1){
        start_level = 1;
    }else if(page_id < START_LEVEL_2){
        start_level = 2;
    }else if(offset < START_LEVEL_3){
        start_level = 3;
    }else{
        return -1;//file size too large!
    }

    unsigned start_block_id;
    unsigned dir_ptr;
    unsigned ind_1_ptr;
    unsigned ind_2_ptr;
    unsigned ind_3_ptr;

    if(start_level == 0){
        dir_ptr = page_id;//which direct pointer
        start_block_id = in_inode->direct_block[dir_ptr];
        if(start_block_id == 0){
            //Note: this block can't be root block
            //So this is an unused block
            start_block_id = alloc_block();
            in_inode->direct_block[dir_ptr] = start_block_id;
            write_inode(in_inode, in_inode->inode_id);//update inode
            clear_block(start_block_id);
        }

    }else if(start_level == 1){
        unsigned level_1_page = page_id - START_LEVEL_0;
        ind_1_ptr = level_1_page / INDIRECT_1_PAGE;//which indirect_1
        unsigned ind_1_block_id = in_inode->indirect_1[ind_1_ptr];
        if(ind_1_block_id == 0){
            //Unused middle block
            ind_1_block_id = alloc_block();
            in_inode->indirect_1[ind_1_ptr] = ind_1_block_id;
            write_inode(in_inode, in_inode->inode_id);
            clear_block(ind_1_block_id);
        }

        read_block(data_temp, ind_1_block_id);
        dir_ptr = level_1_page % INDIRECT_1_PAGE;
        // which direct pointer in this block_1 (one in 1024)
        ind_ptr_t *dir_array = (ind_ptr_t *)data_temp;
        start_block_id = dir_array[dir_ptr];
        if(start_block_id == 0){
            start_block_id = alloc_block();
            dir_array[dir_ptr] = start_block_id;
            write_block(data_temp, ind_1_block_id);
            clear_block(start_block_id);//data_temp is used here
        }

    }else if(start_level == 2){
        unsigned level_2_page = page_id - START_LEVEL_1;
        ind_2_ptr = level_2_page / INDIRECT_2_PAGE;//which ind2
        unsigned ind_2_block_id = in_inode->indirect_2[ind_2_ptr];
        if(ind_2_block_id == 0){//write/read for the first time
            ind_2_block_id = alloc_block();
            in_inode->indirect_2[ind_2_ptr] = ind_2_block_id;
            write_inode(in_inode, in_inode->inode_id);
            clear_block(ind_2_block_id);
        }

        read_block(data_temp, ind_2_block_id);
        ind_1_ptr = (level_2_page % INDIRECT_2_PAGE) / INDIRECT_1_PAGE;
        ind_ptr_t *ind_1_array = (ind_ptr_t *)data_temp;
        unsigned ind_1_block_id = ind_1_array[ind_1_ptr];
        if(ind_1_block_id == 0){
            ind_1_block_id = alloc_block();
            ind_1_array[ind_1_ptr] = ind_1_block_id;
            write_block(data_temp, ind_2_block_id);
            clear_block(ind_1_block_id);
        }

        read_block(data_temp, ind_1_block_id);
        dir_ptr = (level_2_page % INDIRECT_2_PAGE) % INDIRECT_1_PAGE;
        ind_ptr_t *dir_array = (ind_ptr_t *)data_temp;
        start_block_id = dir_array[dir_ptr];
        if(start_block_id == 0){
            start_block_id = alloc_block();
            dir_array[dir_ptr] = start_block_id;
            write_block(data_temp, ind_1_block_id);
            clear_block(start_block_id);
        }

    }else if(start_level == 3){//Maybe we will never use this level
        unsigned level_3_page = page_id - START_LEVEL_3;
        ind_3_ptr = level_3_page / INDIRECT_3_PAGE;
        unsigned ind_3_block_id = in_inode->indirect_3;
        if(ind_3_block_id == 0){
            ind_3_block_id = alloc_block();
            in_inode->indirect_3 = ind_3_block_id;
            write_inode(in_inode, in_inode->inode_id);
            clear_block(ind_3_block_id);
        }

        read_block(data_temp, ind_3_block_id);
        ind_2_ptr = (level_3_page % INDIRECT_3_PAGE) / INDIRECT_2_PAGE;
        ind_ptr_t *ind_2_array = (ind_ptr_t *)data_temp;
        unsigned ind_2_block_id = ind_2_array[ind_2_ptr];
        if(ind_2_block_id == 0){
            ind_2_block_id = alloc_block();
            ind_2_array[ind_2_ptr] = ind_2_block_id;
            write_block(data_temp, ind_3_block_id);
            clear_block(ind_2_block_id);
        }

        read_block(data_temp, ind_2_block_id);
        ind_1_ptr = ((level_3_page % INDIRECT_3_PAGE) % INDIRECT_2_PAGE) / INDIRECT_1_PAGE;
        ind_ptr_t *ind_1_array = (ind_ptr_t *)data_temp;
        unsigned ind_1_block_id = ind_1_array[ind_1_ptr];
        if(ind_1_block_id == 0){
            ind_1_block_id = alloc_block();
            ind_1_array[ind_1_ptr] = ind_1_block_id;
            write_block(data_temp, ind_2_block_id);
            clear_block(ind_1_block_id);
        }

        read_block(data_temp, ind_1_block_id);
        dir_ptr = ((level_3_page % INDIRECT_3_PAGE) % INDIRECT_2_PAGE) % INDIRECT_1_PAGE;
        ind_ptr_t *dir_array = (ind_ptr_t *)data_temp;
        start_block_id = dir_array[dir_ptr];
        if(start_block_id == 0){
            start_block_id = alloc_block();
            dir_array[dir_ptr] = start_block_id;
            write_block(data_temp, ind_1_block_id);
            clear_block(start_block_id);
        }

    }

    *locate_block_id = start_block_id;
    *locate_byte = start_byte;
    return 1;
}

//path analysis, actually parent_inode here is not necessary
dentry_t *get_parent_dir(char *file_name, int *file_inode, unsigned *parent_inode){//returns a status
    int root;
    int level = 0;//number of directories
    int i;
    if(file_name[0] == '/'){
        root=1;
    }else{
        root=0;
    }

    char name[MAX_FILE_LEVEL][MAX_NAME];
    int len[MAX_FILE_LEVEL] = {0,0,0};
    i = root - 1;
    while(1){
        for(i = i + 1; (file_name[i] != 0) && (file_name[i] != '/'); i++){
            name[level][len[level]++] = file_name[i];
        }
        name[level][len[level]] = 0;

        if(file_name[i] == 0){
            break;
        }else{
            level++;
        }
    }

    dentry_t *search_dir;
    if(root == 1){
        //get root dir
        inode_t inode_temp;
        read_inode(&inode_temp, init_inode_id);
        unsigned root_block_id = inode_temp.direct_block[0];
        read_block(data_temp, root_block_id);
        search_dir = (dentry_t *)data_temp;
        *parent_inode = init_inode_id;
    }else{//related to current dir
        search_dir = (dentry_t *)cur_dir_block;
        *parent_inode = cur_dir_inode.inode_id;
    }

    for(i = 0; i < level; i++){
        int index;
        if((index=search_dentry(search_dir, name[i], D_DIR))<0){
            return NULL;//no such directory
        }

        unsigned next_dir_inode_id = search_dir[index].inode_id;
        inode_t inode_temp;
        read_inode(&inode_temp, next_dir_inode_id);
        unsigned next_dir_block_id = inode_temp.direct_block[0];
        read_block(data_temp, next_dir_block_id);
        search_dir = (dentry_t *)data_temp;
        *parent_inode = next_dir_inode_id;
    }

    int index;
    if((index=search_dentry(search_dir, name[level], D_FILE))<0){
        *file_inode = -1;//no such file
    }else{
        *file_inode = search_dir[index].inode_id;
    }

    return search_dir;
}

void update_cur_dir(){
    read_inode(&cur_dir_inode, cur_dir_inode.inode_id);
    read_block(cur_dir_block, cur_dir_inode.direct_block[0]);
}

int do_lseek(int fd, int offset, int whence, char rw){
    fd_t *fp = &(fd_array[fd]);
    if(fp->status == FD_EMPTY){
        return -1;//no such file
    }

    int *dest_offset;
    if(rw == 'r'){
        dest_offset = &(fp->rd_offset);
    }else{
        dest_offset = &(fp->wr_offset);
    }

    unsigned seek_inode_id = fp->inode_id;
    inode_t seek_inode;
    read_inode(&seek_inode, seek_inode_id);

    if(whence == 0){
        *dest_offset = offset;
    }else if(whence == 1){
        *dest_offset = *dest_offset + offset;
    }else{
        *dest_offset = seek_inode.file_size + offset;
    }

    if(seek_inode.file_size < (*dest_offset) + 1){
        enlarge_file_size(seek_inode.file_size, (*dest_offset) + 1, &seek_inode);
        seek_inode.file_size = (*dest_offset) + 1;
    }
    write_inode(&seek_inode, seek_inode_id);
    return 1;
}

void enlarge_file_size(int old_sz, int new_sz, inode_t *in_inode){
    int old_page = old_sz / NORMAL_PAGE_SIZE;
    int new_page = new_sz / NORMAL_PAGE_SIZE;

    if(old_page == new_page){
        return;
    }

    int victim_id;
    int victim_byte;
    for(int size = old_sz; size <= new_sz; size += NORMAL_PAGE_SIZE){
        byte_locate(&victim_id, &victim_byte, size, in_inode);
    }
}
