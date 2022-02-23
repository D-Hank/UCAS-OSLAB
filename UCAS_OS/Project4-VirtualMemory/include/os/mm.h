#ifndef MM_H
#define MM_H

/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 *            Copyright (C) 2018 Institute of Computing Technology, CAS
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 *                                   Memory Management
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  * * * * * * * * * * *
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
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

#include <type.h>
#include <pgtable.h>

#define MEM_SIZE 32
#define PAGE_SIZE 4096 // 4K
#define STACK_VICTIM 128
#define INIT_KERNEL_STACK 0xffffffc051000000lu
#define FREEMEM (INIT_KERNEL_STACK + (PAGE_SIZE * 2))//leave two pages for IDLE
#define USER_STACK_ADDR 0xf00010000lu
#define USER_STACK_LOW 0xf0000f000lu
#define USER_STATIC_ADDR 0x000010000lu
#define USER_STATIC_END 0x000020000lu

/* Rounding; only works for n = power of two */
#define ROUND(a, n)     (((((uint64_t)(a))+(n)-1)) & ~((n)-1))
#define ROUNDDOWN(a, n) (((uint64_t)(a)) & ~((n)-1))

extern ptr_t memCurr;

#define USER_PAGE 1024
#define PH_PAGE 0x80//53000 ~ 58000 (20K)
#define PGTAB_NUM 8000//0x2000-2
//NOTICE: assume we have enough pgtabs

#define SWAP_SECTOR 2048//start sector
#define SWAP_NUM 8192//1 page is 8 sectors


typedef enum{
    MEMORY,
    DISK,
}swap_t;

typedef enum{
    PAGE_AVAILAB,
    PAGE_BUSY,
}page_status_t;

//on-disk flag and disk block will be stored in PTE
//phaddr is easy to get by index
typedef struct ph_page{
    page_status_t status;
    PTE *pte;
}ph_page_t;
ph_page_t ph_page_array[PH_PAGE];

typedef struct page_tab{
    page_status_t status;
}page_tab_t;
page_tab_t page_tab_array[PGTAB_NUM];

typedef struct swap_page{
    page_status_t status;
}swap_page_t;
swap_page_t swap_page_array[SWAP_NUM];

extern ptr_t kernel_free_space;
extern ptr_t kernel_free_stack;
extern ptr_t user_free_space;
extern ptr_t user_free_stack;
extern ptr_t free_space_end;

#define PTE2_NUM 0x100000
#define PTE1_NUM 0x800
#define PTE0_NUM 4

#define PGDIR_VA 0xffffffc05e004000lu//new pgdir, two for kernel before
#define PHIDX_TO_PHADDR(index)  ((user_free_space) + ((index) << 12))
#define PGTIDX_TO_VADDR(index)  ((PGDIR_VA) + ((index) << 12))
#define PHADDR_TO_PHIDX(phaddr) ((unsigned)((phaddr) - (user_free_space)) >> 12)
#define VADDR_TO_PGIDX(vaddr)   ((unsigned)((unsigned long long)(vaddr) - (PGDIR_VA)) >> 12)
#define SWAPIDX_TO_SECTOR(index)  ((SWAP_SECTOR) + ((index) << 3))
#define SECTOR_TO_SWAPIDX(sector) (((unsigned)((sector) - (SWAP_SECTOR))) >> 3)

extern ptr_t allocPage(int numPage);
extern void freePage(ptr_t baseAddr, int numPage);
extern void* kmalloc(size_t size);
extern uintptr_t alloc_ph_page(PTE *pte);//only one
extern PTE* alloc_uvm(unsigned num_bytes);
extern uintptr_t alloc_pgtab();
extern void map_kvm(PTE *pg_dir);
extern void map_kernel_page(uint64_t va, uint64_t pa, PTE *pgdir);
extern void share_pgtable(uintptr_t dest_pgdir, uintptr_t src_pgdir);
extern void alloc_page_helper(uintptr_t va, PTE* pgdir);
uintptr_t shm_page_get(int key);
void shm_page_dt(uintptr_t addr);

extern void dealloc_uvm(PTE *pg_dir);
extern void unmap_kvm(PTE *pg_dir);
extern void switch_init_kdir();

#endif /* MM_H */
