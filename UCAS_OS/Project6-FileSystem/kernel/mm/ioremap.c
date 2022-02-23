#include <os/ioremap.h>
#include <os/mm.h>
#include <pgtable.h>
#include <type.h>

// maybe you can map it to IO_ADDR_START ?
static uintptr_t io_base = IO_ADDR_START;
// physical addr
// remember to switch SATP when we do IO

//initial value
unsigned long long vpn2 = (IO_ADDR_START >> (NORMAL_PAGE_SHIFT + PPN_BITS + PPN_BITS)) & VPN_MASK;//384
unsigned long long vpn1 = (IO_ADDR_START >> (NORMAL_PAGE_SHIFT + PPN_BITS)) & VPN_MASK;//0
unsigned long long vpn0 = (IO_ADDR_START >> (NORMAL_PAGE_SHIFT)) & VPN_MASK;//0

//----------------------------NOTICE-----------------------------
// This mapping may not be cancelled.
// So we won't define a alloc_io_page function.
// The correctness of mapping should be guaranteed externally.
//-----------------------------END-------------------------------

// Support ONE pgdir is enough

void *ioremap(unsigned long phys_addr, unsigned long size)
{
    // map phys_addr to a virtual address
    // then return the virtual address
    // allocate by page, so pa and size should be 4K aligned
    //static offset = 0;
    uintptr_t virt_addr = io_base;
    PTE *io_dir = (PTE *)pa2kva(PGDIR_PA);
    unsigned long i=0;
    for(;i<size;i+=0x1000){
        if((io_dir[vpn2] & _PAGE_PRESENT) ==0){
            io_pmd = alloc_pgtab();
            set_pfn(&io_dir[vpn2], kva2pa(io_pmd) >> NORMAL_PAGE_SHIFT);
            set_attribute(&io_dir[vpn2], _PAGE_PRESENT);
            clear_pgdir(pa2kva(get_pa(io_dir[vpn2])));
        }

        PTE *pmd = (PTE *)pa2kva(get_pa(io_dir[vpn2]));
        if((pmd[vpn1] & _PAGE_PRESENT) ==0){
            set_pfn(&pmd[vpn1], kva2pa(alloc_pgtab()) >> NORMAL_PAGE_SHIFT);
            set_attribute(&pmd[vpn1], _PAGE_PRESENT);
            clear_pgdir(pa2kva(get_pa(pmd[vpn1])));
        }

        PTE *pte = (PTE *)pa2kva(get_pa(pmd[vpn1]));
        // Suppose this pte[vpn0] is NOT present
        set_pfn(&pte[vpn0], (phys_addr + i) >> NORMAL_PAGE_SHIFT);
        set_attribute(&pte[vpn0], _PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | _PAGE_EXEC | _PAGE_ACCESSED | _PAGE_DIRTY);

        if(vpn0 == NUM_PTE_ENTRY - 1){
            vpn0 = 0;
            vpn1++;
            if(vpn1 == NUM_PTE_ENTRY - 1){
                vpn1 = 0;
                vpn2++;
            }
        }else{
            vpn0++;
        }

        // vpn2 cannot be 511
    }
    local_flush_tlb_all();

    io_base+=i;
    return (void *)virt_addr;
}

void iounmap(void *io_addr)
{
    // TODO: a very naive iounmap() is OK
    // maybe no one would call this function?
    // *pte = 0;
}
