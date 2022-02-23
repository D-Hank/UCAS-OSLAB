#ifndef PGTABLE_H
#define PGTABLE_H

#include <type.h>
#include <sbi.h>
#include <os/string.h>
//used for C
#define SATP_MODE_SV39 8
#define SATP_MODE_SV48 9
#define PA_LEN 56
#define VA_LEN 39
#define PTE_LEN 54

#define SATP_ASID_SHIFT 44lu
#define SATP_MODE_SHIFT 60lu

#define NORMAL_PAGE_SHIFT 12lu
#define NORMAL_PAGE_SIZE (1lu << NORMAL_PAGE_SHIFT)
#define LARGE_PAGE_SHIFT 21lu
#define LARGE_PAGE_SIZE (1lu << LARGE_PAGE_SHIFT)

/*
 * Flush entire local TLB.  'sfence.vma' implicitly fences with the instruction
 * cache as well, so a 'fence.i' is not necessary.
 */
static inline void local_flush_tlb_all(void)
{
    __asm__ __volatile__ ("sfence.vma" : : : "memory");
}

/* Flush one page from local TLB */
static inline void local_flush_tlb_page(unsigned long addr)
{
    __asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory");
}

static inline void local_flush_icache_all(void)
{
    asm volatile ("fence.i" ::: "memory");
}

static inline void flush_icache_all(void)
{
    local_flush_icache_all();
    sbi_remote_fence_i(NULL);
}

static inline void flush_tlb_all(void)
{
    local_flush_tlb_all();
    sbi_remote_sfence_vma(NULL, 0, -1);
}
static inline void flush_tlb_page_all(unsigned long addr)
{
    local_flush_tlb_page(addr);
    sbi_remote_sfence_vma(NULL, 0, -1);
}

static inline void set_satp(
    unsigned mode, unsigned asid, unsigned long ppn)
{
    unsigned long __v =
        (unsigned long)(((unsigned long)mode << SATP_MODE_SHIFT) | ((unsigned long)asid << SATP_ASID_SHIFT) | ppn);
    __asm__ __volatile__("sfence.vma\ncsrw satp, %0" : : "rK"(__v) : "memory");
}

#define PGDIR_PA 0x5e000000lu  // use bootblock's page as PGDIR, original PGDIR

/*
 * PTE format:
 * | XLEN-1  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
 *       PFN      reserved for SW   D   A   G   U   X   W   R   V
 */

#define _PAGE_ACCESSED_OFFSET 6

#define _PAGE_PRESENT (1 << 0)
#define _PAGE_READ (1 << 1)     /* Readable */
#define _PAGE_WRITE (1 << 2)    /* Writable */
#define _PAGE_EXEC (1 << 3)     /* Executable */
#define _PAGE_USER (1 << 4)     /* User */
#define _PAGE_GLOBAL (1 << 5)   /* Global */
#define _PAGE_ACCESSED (1 << 6) /* Set by hardware on any access \
                                 */
#define _PAGE_DIRTY (1 << 7)    /* Set by hardware on any write */
#define _PAGE_SOFT (1 << 8)     /* Reserved for software */

#define _PAGE_PFN_SHIFT 10lu
#define PFN_MASK ((1lu << (PTE_LEN - _PAGE_PFN_SHIFT)) - 1) //44*1'b1

#define VA_MASK ((1lu << VA_LEN) - 1) //39*1'b1
#define ATTRIBUTE_MASK ((1lu << _PAGE_PFN_SHIFT) - 1) //10*1'b1

#define PPN_BITS 9lu
#define PPN_MASK ((1lu << PPN_BITS) - 1) //9*1'b1
#define VPN_BITS 9lu
#define VPN_MASK ((1lu << VPN_BITS) - 1) //9*1'b1
#define OFF_BITS 12lu
#define OFF_MASK ((1lu << OFF_BITS) - 1)
#define NUM_PTE_ENTRY (1 << PPN_BITS)
#define KERNEL_VBASE 0xffffffc000000000

#define KERNEL_PGDIR_START ((0xffffffc050200000 >> (NORMAL_PAGE_SHIFT + VPN_BITS + VPN_BITS)) & VPN_MASK)
#define KERNEL_PGDIR_END ((0xffffffc060000000 >> (NORMAL_PAGE_SHIFT + VPN_BITS + VPN_BITS)) & VPN_MASK)
#define KERNEL_PME_START ((0xffffffc050200000 >> (NORMAL_PAGE_SHIFT + VPN_BITS)) & VPN_MASK)
#define KERNEL_PME_END ((0xffffffc060000000 >> (NORMAL_PAGE_SHIFT + VPN_BITS)) & VPN_MASK)

#define PRVLG_BITS 38
#define PRVLG_MASK ((0xffffffffffffffff) << PRVLG_BITS)

typedef uint64_t PTE;

static inline uintptr_t kva2pa(uintptr_t kva)
{
    // TODO:
    return kva - KERNEL_VBASE;
}

static inline uintptr_t pa2kva(uintptr_t pa)
{
    // TODO:
    return pa + KERNEL_VBASE;
}

static inline uint64_t get_pa(PTE entry)
{//here we have a last-level page table entry
    // TODO:
    return (((entry >> _PAGE_PFN_SHIFT) & PFN_MASK) << NORMAL_PAGE_SHIFT);
}

static inline uintptr_t get_kva_of(uintptr_t va, uintptr_t pgdir_va)
{//get pa of va by checking this pgdir_va, return this pa in kernel virtual space
    // TODO:
    unsigned vpn2 = (va >> (NORMAL_PAGE_SHIFT + VPN_BITS + VPN_BITS)) & VPN_MASK;
    unsigned vpn1 = (va >> (NORMAL_PAGE_SHIFT + VPN_BITS)) & VPN_MASK;
    unsigned vpn0 = (va >> (NORMAL_PAGE_SHIFT)) & VPN_MASK;

    PTE *pgdir = (PTE *)pgdir_va;

    PTE *pme_base_pa = (PTE *)get_pa(pgdir[vpn2]);
    PTE *pme_base_va = (PTE *)pa2kva(pme_base_pa);

    PTE *pte_base_pa = (PTE *)get_pa(pme_base_va[vpn1]);
    PTE *pte_base_va = (PTE *)pa2kva(pte_base_pa);

    uintptr_t pa = (uintptr_t)get_pa(pte_base_va[vpn0]);
    uintptr_t va_in_kernel = pa2kva(pa);
    return va_in_kernel;
}

/* Get/Set page frame number of the `entry` */
static inline long get_pfn(PTE entry)
{
    // TODO:
    return ((entry >> _PAGE_PFN_SHIFT) & PFN_MASK);
}
static inline void set_pfn(PTE *entry, uint64_t pfn)
{
    // TODO:
    PTE attribute = *entry & ATTRIBUTE_MASK;
    *entry = (pfn << _PAGE_PFN_SHIFT) | attribute;
}

/* Get/Set attribute(s) of the `entry` */
static inline long get_attribute(PTE entry, uint64_t mask)
{
    // TODO:
    return entry & mask;
}
static inline void set_attribute(PTE *entry, uint64_t bits)
{
    // TODO:
    *entry |= bits;
}

static inline void clear_pgdir(uintptr_t pgdir_addr)
{
    // TODO:
    // when using this, we are in real mode
    kmemset(pgdir_addr, 0, NORMAL_PAGE_SIZE);
}

#endif  // PGTABLE_H
