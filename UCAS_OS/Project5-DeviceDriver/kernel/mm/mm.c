#include <os/list.h>
#include <os/mm.h>
#include <os/sched.h>
#include <pgtable.h>
#include <os/string.h>
#include <assert.h>

ptr_t memCurr = FREEMEM;
ptr_t kernel_free_space = 0x51002000lu;
ptr_t kernel_free_stack = 0x52000000lu;
ptr_t user_free_space = 0x53000000lu;
ptr_t user_free_stack = 0x54000000lu;
ptr_t io_remap_space = 0x55000000lu;
ptr_t free_space_end = 0x5a000000lu;

static inline void fence_i()
{
    __asm__ __volatile__("fence.i\n\r");
}

ptr_t allocPage(int numPage)
{
    // align PAGE_SIZE
    // alloc page for kernel
    ptr_t ret = ROUND(memCurr, PAGE_SIZE);
    memCurr = ret + numPage * PAGE_SIZE;
    return ret;
}

void freePage(ptr_t baseAddr, int numPage)
{
    // TODO:
}

void* kmalloc(size_t size)
{
    ptr_t ret = ROUND(memCurr, 4);
    memCurr = ret + size;
    return (void*)ret;
}

uintptr_t alloc_ph_page(PTE *pte)
{
    // find a physical page from user section
    // act as a mark for ph
    // returns virtual its addr in kernel
    /*ptr_t ret = ROUND(user_free_space, PAGE_SIZE);
    user_free_space = ret + PAGE_SIZE;
    return pa2kva(ret);*/

    static int last_search=-1;
    int index,i;
    int found=0;
    //int replace[4]={-1,-1,-1,-1};
    static int next_replace=30;//leave 30 pages for shell and swap

    for(index=last_search+1,i=0;i<PH_PAGE;i++,index=(index+1)%PH_PAGE){
        if(ph_page_array[index].status==PAGE_AVAILAB){
            found=1;
            break;
        }
        /*if(*(ph_page_array[index].pte) & _PAGE_ACCESSED){
            ;
        }*/
    }

    if(found==1){
        ph_page_array[index].status=PAGE_BUSY;
        ph_page_array[index].pte=pte;
        if(index==PH_PAGE-1){
            last_search=-1;
        }else{
            last_search=index;
        }
        return pa2kva((PHIDX_TO_PHADDR(index)));
    }

    //found=0, ph_page used up
    //-----------------NOTE OF REPLACEMENT--------------------
    //Then this pte must be present
    //By our design, this physical page must be
    //PRESENT, DIRTY, ACCESSED
    //so we just casually choose one page
    //We say casually but not randomly
    //It's just like round-robin
    //-------------------------END----------------------------

    //Now, next_replace will be written to swap area
    PTE *old=ph_page_array[next_replace].pte;
    found=0;
    for(i=0;i<SWAP_NUM;i++){
        if(swap_page_array[i].status==PAGE_AVAILAB){
            found=1;
            break;
        }
    }

    if(found==0){
        assert(0);//Swap pages are not enough
    }

    //Now we found a swap page
    int sector=SWAPIDX_TO_SECTOR(i);
    swap_page_array[i].status=PAGE_BUSY;
    unsigned long long phaddr=get_pa(*old);
    sbi_sd_write(phaddr, 8, sector);

    *old=0;
    set_pfn(old,sector);
    set_attribute(old,_PAGE_SOFT);

    //set_satp(SATP_MODE_SV39, 0, PGDIR_PA >> NORMAL_PAGE_SHIFT);
    local_flush_tlb_all();

    ph_page_array[next_replace].status=PAGE_BUSY;
    ph_page_array[next_replace].pte=pte;
    index=next_replace;
    if(next_replace==PH_PAGE-1){
        next_replace=30;
    }else{
        next_replace++;
    }

    phaddr=PHIDX_TO_PHADDR(index);

    return pa2kva(phaddr);
}

uintptr_t shm_page_get(int key)
{
    // TODO(c-core):
}

void shm_page_dt(uintptr_t addr)
{
    // TODO(c-core):
}

/* this is used for mapping kernel virtual address into user page table */
void share_pgtable(uintptr_t dest_pgdir, uintptr_t src_pgdir)
{
    // TODO:
}

uintptr_t alloc_pgtab(){//returns virtual addr
    /*static uintptr_t new_pgdir = PGDIR_VA;
    uintptr_t ret = new_pgdir;
    new_pgdir += 0x1000;
    return ret;*/

    static int last_search=-1;
    int index,i;
    int found=0;
    for(index=last_search+1,i=0;i<PGTAB_NUM;i++,index=(index+1)%PGTAB_NUM){
        if(page_tab_array[index].status==PAGE_AVAILAB){
            found=1;
            break;
        }
    }

    if(found==1){
        page_tab_array[index].status=PAGE_BUSY;
        last_search=index;
        return PGTIDX_TO_VADDR(index);
    }

    assert(0);//not enough pgtab
}

PTE* alloc_uvm(unsigned num_bytes){
    //statically allocate
    //used to start a user process
    //allocate a pg_dir
    //clear_pgdir()
    //only use one page space
    //returns a virtual addr
    //unsigned num_pages=(num_bytes+PAGE_SIZE-1)>>NORMAL_PAGE_SHIFT;

    //------------------NOTICE----------------------------
    // Here num_bytes is file size
    // However, when we load elf
    // We use mem size
    // So we just statically allocate ?
    //----------------------------------------------------

    static const int init_bytes = NORMAL_PAGE_SIZE * 128;

    uintptr_t code_data;//kva
    PTE *first_tab = (PTE *)alloc_pgtab();//virtual addr
    PTE *second_tab = (PTE *)alloc_pgtab();
    PTE *third_tab = (PTE *)alloc_pgtab();
    clear_pgdir(first_tab);
    clear_pgdir(second_tab);
    clear_pgdir(third_tab);

    unsigned long long vpn2 = (USER_STATIC_ADDR >> (NORMAL_PAGE_SHIFT + PPN_BITS + PPN_BITS)) & VPN_MASK;
    unsigned long long vpn1 = (USER_STATIC_ADDR >> (NORMAL_PAGE_SHIFT + PPN_BITS)) & VPN_MASK;
    unsigned long long vpn0 = (USER_STATIC_ADDR >> (NORMAL_PAGE_SHIFT)) & VPN_MASK;

    set_pfn(&first_tab[vpn2], (uintptr_t)(kva2pa(second_tab)) >> NORMAL_PAGE_SHIFT);
    set_attribute(&first_tab[vpn2], _PAGE_PRESENT);

    set_pfn(&second_tab[vpn1], (uintptr_t)(kva2pa(third_tab)) >> NORMAL_PAGE_SHIFT);
    set_attribute(&second_tab[vpn1], _PAGE_PRESENT);

    for(int i=0;i<init_bytes;i+=PAGE_SIZE){
        code_data = alloc_ph_page(&third_tab[vpn0]);
        kmemset(code_data, 0, NORMAL_PAGE_SIZE);
        set_pfn(&third_tab[vpn0], (uintptr_t)(kva2pa(code_data)) >> NORMAL_PAGE_SHIFT);
        set_attribute(&third_tab[vpn0], _PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | _PAGE_EXEC | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_USER);
        vpn0+=1;
    }

    //init stack
    //Note that uintptr_t is uint64
    second_tab = (PTE *)alloc_pgtab();
    third_tab = (PTE *)alloc_pgtab();
    clear_pgdir(second_tab);
    clear_pgdir(third_tab);

    vpn2 = (USER_STACK_LOW >> (NORMAL_PAGE_SHIFT + PPN_BITS + PPN_BITS)) & VPN_MASK;
    vpn1 = (USER_STACK_LOW >> (NORMAL_PAGE_SHIFT + PPN_BITS)) & VPN_MASK;
    vpn0 = (USER_STACK_LOW >> (NORMAL_PAGE_SHIFT)) & VPN_MASK;

    set_pfn(&first_tab[vpn2], (uintptr_t)(kva2pa(second_tab)) >> NORMAL_PAGE_SHIFT);
    set_attribute(&first_tab[vpn2], _PAGE_PRESENT);

    set_pfn(&second_tab[vpn1], (uintptr_t)(kva2pa(third_tab)) >> NORMAL_PAGE_SHIFT);
    set_attribute(&second_tab[vpn1], _PAGE_PRESENT);

    uintptr_t stack = alloc_ph_page(&third_tab[vpn0]);//kva
    kmemset(stack, 0, NORMAL_PAGE_SIZE);
    set_pfn(&third_tab[vpn0], (uintptr_t)(kva2pa(stack)) >> NORMAL_PAGE_SHIFT);
    set_attribute(&third_tab[vpn0], _PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | _PAGE_EXEC | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_USER);

    //XXX: reflush TLB?
    return first_tab;
}

void dealloc_uvm(PTE *pg_dir){
    //Note: not all entries will be traversed
    //NOTICE: pages on disk should be invalid
    int i,j,k;
    for(i=0;i<KERNEL_PGDIR_START;i++){
        if((pg_dir[i] & _PAGE_PRESENT) ==1){//valid entry
            PTE *second=(PTE *)pa2kva(get_pa(pg_dir[i]));
            for(j=0;j<NUM_PTE_ENTRY;j++){
                if((second[j] & _PAGE_PRESENT) ==1){//valid entry
                    PTE *third=(PTE *)pa2kva(get_pa(second[j]));
                    for(k=0;k<NUM_PTE_ENTRY;k++){
                        if((third[k] & _PAGE_PRESENT) ==1){//valid entry
                            long phaddr=get_pa(third[k]);
                            int index=PHADDR_TO_PHIDX(phaddr);
                            ph_page_array[index].status=PAGE_AVAILAB;
                            ph_page_array[index].pte=NULL;
                        }else if((third[k] & _PAGE_SOFT) !=0){//on disk
                            int sector=get_pfn(third[k]);
                            swap_page_array[SECTOR_TO_SWAPIDX(sector)].status=PAGE_AVAILAB;
                        }
                        third[k] = 0;
                    }

                    int index=VADDR_TO_PGIDX(third);
                    page_tab_array[index].status=PAGE_AVAILAB;
                }
                second[j]=0;
            }

            int index=VADDR_TO_PGIDX(second);
            page_tab_array[index].status=PAGE_AVAILAB;
        }
        pg_dir[i]=0;
    }
}

void unmap_kvm(PTE *pg_dir){
    //PME will be cleared when we use kmalloc
    //note that the kernel pg_dir has changed already
    int i,j;
    unsigned phaddr=get_pa(pg_dir[KERNEL_PGDIR_START]);
    PTE *second=(PTE *)pa2kva(phaddr);
    for(i=KERNEL_PME_START;i<KERNEL_PME_END;i++){
        second[i]=0;
    }

    int index=VADDR_TO_PGIDX(second);
    page_tab_array[index].status=PAGE_AVAILAB;
    pg_dir[KERNEL_PGDIR_START]=0;
}

void switch_init_kdir(){
    // the same as enable_vm()
    set_satp(SATP_MODE_SV39, 0, PGDIR_PA >> NORMAL_PAGE_SHIFT);
    local_flush_tlb_all();
}

void switch_pgdir_back(){
    int mycpu_id=get_current_cpu_id();
    set_satp(SATP_MODE_SV39, current_running[mycpu_id]->pid, (unsigned long)(kva2pa(current_running[mycpu_id]->pg_dir)) >> NORMAL_PAGE_SHIFT);
    local_flush_tlb_all();
}

// using 2MB large page, preparing virtual page for kernel
void map_kernel_page(uint64_t va, uint64_t pa, PTE *pgdir)
{//when using this, we are in real mode
    va &= VA_MASK;
    uint64_t vpn2 =
        va >> (NORMAL_PAGE_SHIFT + PPN_BITS + PPN_BITS);
    uint64_t vpn1 = (vpn2 << PPN_BITS) ^
                    (va >> (NORMAL_PAGE_SHIFT + PPN_BITS));
    if (pgdir[vpn2] == 0) {
        // alloc a new second-level page directory
        set_pfn(&pgdir[vpn2], kva2pa(alloc_pgtab()) >> NORMAL_PAGE_SHIFT);
        set_attribute(&pgdir[vpn2], _PAGE_PRESENT);
        clear_pgdir(pa2kva(get_pa(pgdir[vpn2])));
    }
    PTE *pmd = (PTE *)pa2kva(get_pa(pgdir[vpn2]));
    set_pfn(&pmd[vpn1], pa >> NORMAL_PAGE_SHIFT);
    set_attribute(
        &pmd[vpn1], _PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE |
                        _PAGE_EXEC | _PAGE_ACCESSED | _PAGE_DIRTY);

    //NOTICE: here for debugging, we git privilege to user!!!
}

void map_kvm(PTE *pg_dir){
    //this user's pg_dir is clean, except for those allocated
    for(unsigned long long kva = 0xffffffc050200000lu;
         kva < 0xffffffc060000000lu; kva += 0x200000lu) {
        map_kernel_page(kva, kva2pa(kva), pg_dir);
    }
    return;
}

/* allocate physical page for `va`, mapping it into `pgdir`,
   return the kernel virtual address for the page.
   */
// used for page fault
void alloc_page_helper(uintptr_t va, PTE* pgdir)
{
    // TODO:
    //
    // Note that a single pgdir is enough for 4GB space
    va &= VA_MASK;
    if((va & PRVLG_MASK) !=0){
        return 0;//illegal addr
    }

    unsigned long long vpn2 = (va >> (NORMAL_PAGE_SHIFT + VPN_BITS + VPN_BITS)) & VPN_MASK;
    unsigned long long vpn1 = (va >> (NORMAL_PAGE_SHIFT + VPN_BITS)) & VPN_MASK;
    unsigned long long vpn0 = (va >> (NORMAL_PAGE_SHIFT)) & VPN_MASK;
    unsigned long long off = (va & OFF_MASK);

    if((pgdir[vpn2] & _PAGE_PRESENT) ==0){
        //allocate a second-level table
        set_pfn(&pgdir[vpn2], kva2pa(alloc_pgtab()) >> NORMAL_PAGE_SHIFT);
        set_attribute(&pgdir[vpn2], _PAGE_PRESENT);
        clear_pgdir(pa2kva(get_pa(pgdir[vpn2])));
    }

    PTE *pmd = (PTE *)pa2kva(get_pa(pgdir[vpn2]));
    if((pmd[vpn1] & _PAGE_PRESENT) ==0){
        //allocate a third-level table
        set_pfn(&pmd[vpn1], kva2pa(alloc_pgtab()) >> NORMAL_PAGE_SHIFT);
        set_attribute(&pmd[vpn1], _PAGE_PRESENT);
        clear_pgdir(pa2kva(get_pa(pmd[vpn1])));
    }

    PTE *pte = (PTE *)pa2kva(get_pa(pmd[vpn1]));
    if((pte[vpn0] & _PAGE_PRESENT) ==0){//this entry is certainly not present
        //allocate an available physical page
        if((pte[vpn0] & _PAGE_SOFT) ==0){//not on disk
            uintptr_t new_page_kva = alloc_ph_page(&pte[vpn0]);
            kmemset((void *)new_page_kva,0,NORMAL_PAGE_SIZE);
            set_pfn(&pte[vpn0], kva2pa(new_page_kva) >> NORMAL_PAGE_SHIFT);
            set_attribute(&pte[vpn0], _PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | _PAGE_EXEC | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_USER);
        }else{//on disk
            int sector=get_pfn(pte[vpn0]);
            //find a physical page to hold this page
            //its original page may be filled by others
            uintptr_t new_page_kva = alloc_ph_page(&pte[vpn0]);
            uintptr_t new_page_pa = kva2pa(new_page_kva);
            kmemset((void *)new_page_kva,0,NORMAL_PAGE_SIZE);

            sbi_sd_read(new_page_pa, 8, sector);
            local_flush_icache_all();

            swap_page_array[SECTOR_TO_SWAPIDX(sector)].status=PAGE_AVAILAB;
            //NOTICE: AVAILAB should be after alloc_ph_page
            pte[vpn0]=0;
            set_pfn(&pte[vpn0], new_page_pa >> NORMAL_PAGE_SHIFT);
            set_attribute(&pte[vpn0], _PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | _PAGE_EXEC | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_USER);
        }
    }

    local_flush_tlb_all();

}

void map_io(PTE *pg_dir){
    static vpn2 = (IO_ADDR_START >> (NORMAL_PAGE_SHIFT + PPN_BITS + PPN_BITS)) & VPN_MASK;
    set_pfn(&pg_dir[vpn2], kva2pa(io_pmd) >> NORMAL_PAGE_SHIFT);
    set_attribute(&pg_dir[vpn2], _PAGE_PRESENT);
}

void unmap_io(PTE *pg_dir){
    static vpn2 = (IO_ADDR_START >> (NORMAL_PAGE_SHIFT + PPN_BITS + PPN_BITS)) & VPN_MASK;
    pg_dir[vpn2]=0;
}
