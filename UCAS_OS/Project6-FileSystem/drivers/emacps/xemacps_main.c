/******************************************************************************
 *
 * Copyright (C) 2010 - 2019 Xilinx, Inc.  All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person
 *obtaining a copy of this software and associated documentation
 *files (the "Software"), to deal in the Software without
 *restriction, including without limitation the rights to use,
 *copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 *Software is furnished to do so, subject to the following
 *conditions:
 *
 * The above copyright notice and this permission notice shall be
 *included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 *EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 *OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 *NONINFRINGEMENT. IN NO EVENT SHALL XILINX  BE LIABLE FOR ANY
 *CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
 *CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 *CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 * Except as contained in this notice, the name of the Xilinx shall
 *not be used in advertising or otherwise to promote the sale, use
 *or other dealings in this Software without prior written
 *authorization from Xilinx.
 *
 ******************************************************************************/
/****************************************************************************/
/**
 *
 *
 * Functional guide to example:
 *
 * - EmacPsErrorHandler() demonstrates how to manage asynchronous
 *errors.
 *
 * - EmacPsResetDevice() demonstrates how to reset the driver/HW
 *without loosing all configuration settings.
 *
 *
 * <pre>
 * MODIFICATION HISTORY:
 *
 * Ver   Who  Date     Changes
 * ----- ---- --------
 *------------------------------------------------------- 1.00a wsy
 *01/10/10 First release 1.00a asa  11/25/11 The cache disable
 *routines are removed. So now both I-cache and D-cache are
 *enabled. The array RxBuffer is removed to avoid an extra copy
 *from RxBuffer to RxFrame. Now the address of RxFrame is submitted
 *to the Rx BD instead of the address of RxBuffer. In function
 *EmacPsDmaSingleFrameIntrExample, BdRxPtr is made as a pointer
 *instead of array of pointers. This is done since on the Rx path
 *we now submit a single BD instead of all 32 BDs. Because of this
 *change, relevant changes are made throughout the function
 *		      EmacPsDmaSingleFrameIntrExample.
 *		      Cache invalidation is now being done for the RxFrame
 *		      buffer.
 *		      The unnecessary cache flush (Xil_DCacheFlushRange) is
 *		      removed. This was being done towards the end of the
 *		      example which was unnecessary.
 * 1.00a asa 01/24/12  Support for Zynq board is added. The SLCR
 *divisors are different for Zynq. Changes are made for the same.
 * 		      Presently the SLCR GEM clock divisors are hard-coded
 *		      assuming that IO PLL output frequency is 1000 MHz.
 * 		      The BDs are allocated at the address 0xFF00000 and
 *the 1 MB address range starting from this address is made
 * 		      uncached. This is because, for GEM the BDs need to be
 * 		      placed in uncached memory. The RX BDs are allocated
 *at address 0xFF00000 and TX BDs are allocated at address
 * 		      0xFF10000.
 * 		      The MDIO divisor used of 224 is used for Zynq board.
 * 1.01a asa 02/27/12  The hardcoded SLCR divisors for Zynq are
 *removed. The divisors are obtained from xparameters.h.c. The
 *sleep values are reduced for Zynq. One sleep is added after MDIO
 *divisor is set. Some of the prints are removed. 1.01a asa
 *03/14/12  The SLCR divisor support for ENET1 is added. 1.01a asa
 *04/15/12  The funcation calls to Xil_DisableMMU and Xil_EnableMMU
 *		      are removed for setting the translation table
 *		      attributes for the BD memory region.
 * 1.05a asa 09/22/13 Cache handling is changed to fix an issue
 *(CR#663885). The cache invalidation of the Rx frame is now moved
 *to XEmacPsRecvHandler so that invalidation happens after the
 *			  received data is available in the memory. The
 *variable TxFrameLength is now made global. 2.1	srt 07/11/14
 *Implemented 64-bit changes and modified as per Zynq Ultrascale Mp
 *GEM specification 3.0  kpc  01/23/14 Removed PEEP board related
 *code 3.0  hk   03/18/15 Added support for jumbo frames. Add cache
 *flush after BD terminate entries. 3.2  hk   10/15/15 Added clock
 *control using CRL_APB_GEM_REF_CTRL register. Enabled 1G speed for
 *ZynqMP GEM. Select GEM interrupt based on instance present.
 *                    Manage differences between emulation platform
 *and silicon. 3.2  mus  20/02/16.Added support for INTC interrupt
 *controlller. Added support to access zynq emacps interrupt from
 *                    microblaze.
 * 3.3 kpc   12/09/16 Fixed issue when -O2 is enabled
 * 3.4 ms    01/23/17 Modified xil_printf statement in main
 *function to ensure that "Successfully ran" and "Failed" strings
 *                   are available in all examples. This is a fix
 *for CR-965028. 3.5 hk    08/14/17 Dont perform data cache
 *operations when CCI is enabled on ZynqMP. 3.8 hk    10/01/18 Fix
 *warning for redefinition of interrupt number. 3.9 hk    02/12/19
 *Change MDC divisor for Versal emulation. 03/06/19 Fix BD space
 *assignment and its memory attributes. 03/20/19 Fix alignment
 *pragmas for IAR compiler.
 *
 * </pre>
 *
 *****************************************************************************/

#include <os/stdio.h>
#include "xemacps_example.h"
#include "xemacps_hw.h"
#include "xemacps_bdring.h"
#include "xparameters.h"
#include "xemacps.h"
#include <net.h>

#include <os/sched.h>

/*************************** Constant Definitions
 * ***************************/

#define RXBD_CNT 32 /* Number of RxBDs to use */
#define TXBD_CNT 32 /* Number of TxBDs to use */

//LIST_HEAD(net_recv_queue);
//LIST_HEAD(net_send_queue);

/*
 * SLCR setting
 */
uintptr_t XPS_SYS_CTRL_BASEADDR;
#define SLCR_LOCK_ADDR (XPS_SYS_CTRL_BASEADDR + 0x4)
#define SLCR_UNLOCK_ADDR (XPS_SYS_CTRL_BASEADDR + 0x8)
#define SLCR_GEM0_CLK_CTRL_ADDR (XPS_SYS_CTRL_BASEADDR + 0x140)
#define SLCR_GEM1_CLK_CTRL_ADDR (XPS_SYS_CTRL_BASEADDR + 0x144)

#define SLCR_LOCK_KEY_VALUE 0x767B
#define SLCR_UNLOCK_KEY_VALUE 0xDF0D
#define SLCR_ADDR_GEM_RST_CTRL (XPS_SYS_CTRL_BASEADDR + 0x214)

#define CRL_GEM_DIV_MASK 0x003F3F00
#define CRL_GEM_1G_DIV0 0x00000C00
#define CRL_GEM_1G_DIV1 0x00010000

#define JUMBO_FRAME_SIZE 10240
#define FRAME_HDR_SIZE 18

#define GEMVERSION_VERSAL 0x107

/*************************** Variable Definitions
 * ***************************/


EthernetFrame TxFrame; /* Transmit buffer */
EthernetFrame RxFrame; /* Receive buffer */

/*
 * Buffer descriptors are allocated in uncached memory. The memory
 * is made uncached by setting the attributes appropriately in the
 * MMU table.
 */
#define RXBD_SPACE_BYTES XEmacPs_BdRingMemCalc(XEMACPS_BD_ALIGNMENT, RXBD_CNT)
#define TXBD_SPACE_BYTES XEmacPs_BdRingMemCalc(XEMACPS_BD_ALIGNMENT, TXBD_CNT)

/*
 * Buffer descriptors are allocated in uncached memory. The memory
 * is made uncached by setting the attributes appropriately in the
 * MMU table. The minimum region for which attribute settings take
 * effect is 2MB for arm 64 variants(A53) and 1MB for the rest (R5
 * and A9). Hence the same is allocated, even if not used fully by
 * this example, to make sure none of the adjacent global memory is
 * affected.
 */

u8 bd_space[0x200000] __attribute__((aligned(0x200000)));


u8 *RxBdSpacePtr;
u8 *TxBdSpacePtr;

#define FIRST_FRAGMENT_SIZE 64

/*
 * Counters to be incremented by callbacks
 */
volatile s32 FramesRx;     /* Frames have been received */
volatile s32 FramesTx;     /* Frames have been sent */
volatile s32 DeviceErrors; /* Number of errors detected in the device */

u32 TxFrameLength;

XEmacPs_Bd BdTxTerminate __attribute__((aligned(64)));
XEmacPs_Bd BdRxTerminate __attribute__((aligned(64)));

u32 GemVersion;
u32 Platform;

XEmacPs_Config xemacps_config;

/*************************** Function Prototypes
 * ****************************/

/*
 * Example
 */
LONG EmacPsDmaIntrExample(
    XEmacPs *EmacPsInstancePtr);

LONG EmacPsDmaSingleFrameIntrExample(XEmacPs *EmacPsInstancePtr);

static void XEmacPsSendHandler(void *Callback);
static void XEmacPsRecvHandler(void *Callback);
static void XEmacPsErrorHandler(void *Callback, u8 direction, u32 word);

/*
 * Utility routines
 */
static LONG EmacPsResetDevice(XEmacPs *EmacPsInstancePtr);
void XEmacPsClkSetup(XEmacPs *EmacPsInstancePtr, u32 speed);
void XEmacPs_SetMdioDivisor(XEmacPs *InstancePtr, XEmacPs_MdcDiv Divisor);
/****************************************************************************/
/**
 *
 * This is the main function for the EmacPs example. This function
 *is not included if the example is generated from the TestAppGen
 *test tool.
 *
 * @param	None.
 *
 * @return	XST_SUCCESS to indicate success, otherwise XST_FAILURE.
 *
 * @note		None.
 *
 ****************************************************************************/
int xemacps_example_main(void)
{
    LONG Status;

    xil_printf("Entering into main() \r\n");

    /*
     * Call the EmacPs DMA interrupt example , specify the
     * parameters generated in xparameters.h
     */
    Status = EmacPsDmaIntrExample(&EmacPsInstance);

    if (Status != XST_SUCCESS) {
        EmacPsUtilErrorTrap("Emacps intr dma Example Failed\r\n");
        return XST_FAILURE;
    }

    xil_printf("Successfully ran Emacps intr dma Example\r\n");
    return XST_SUCCESS;
}

XEmacPs_Bd* tx_bd_array;
XEmacPs_Bd* rx_bd_array;

LONG EmacPsSetupBD(XEmacPs *EmacPsInstancePtr)
{
    RxBdSpacePtr = &(bd_space[0]);
    TxBdSpacePtr = &(bd_space[0x100000]);

    //initialize rx bd
    rx_bd_array = (XEmacPs_Bd*)RxBdSpacePtr;
    XEmacPs_Bd* rx_bd_temp = rx_bd_array;
    for(int i = 0; i < RXBD_CNT; i++, rx_bd_temp++){
        XEmacPs_BdSetAddressRx(rx_bd_temp, kva2pa((uintptr_t)&rx_buffer[i]));
        XEmacPs_BdSetRxNew(rx_bd_temp);
    }

    //initialize tx bd
    tx_bd_array = (XEmacPs_Bd*)TxBdSpacePtr;
    XEmacPs_BdSetAddressTx(tx_bd_array, kva2pa((uintptr_t)&tx_buffer));
    XEmacPs_BdSetTxUsed(tx_bd_array);
    XEmacPs_BdSetLast(tx_bd_array);

    //second tx bd
    XEmacPs_BdSetTxUsed(tx_bd_array + 1);

    return XST_SUCCESS;
}

#define PHY_DETECT_REG1 2
#define PHY_DETECT_REG2 3
#define PHY_ID_RTL		0x1c

LONG EmacPsInitPhy(XEmacPs * EmacPsInstancePtr, u32 *Speed)
{
	LONG Status;
	u16 PhyIdentity;
	u16 PhyIdentity2;
	u32 PhyAddr;

	/*
	 * Detect the PHY address
	 */
	PhyAddr = XEmacPsDetectPHY(EmacPsInstancePtr);

	if (PhyAddr >= 32) {
		EmacPsUtilErrorTrap("Error detect phy");
		return XST_FAILURE;
	}

    /* phy id is stored in {phy reg 2, phy reg 3}
     * PYNQ use RTL 8211E
     */
	if (XEmacPs_PhyRead(EmacPsInstancePtr, PhyAddr, PHY_DETECT_REG1, &PhyIdentity) != XST_SUCCESS) {
		EmacPsUtilErrorTrap("Phy Read Error");
	}
    if (XEmacPs_PhyRead(EmacPsInstancePtr, PhyAddr, PHY_DETECT_REG2, &PhyIdentity2) != XST_SUCCESS) {
		EmacPsUtilErrorTrap("Phy Read Error");
	}
	xil_printf("phy identity: %x\n\r", ((uint32_t) PhyIdentity << 16) | PhyIdentity2);

	if (PhyIdentity == PHY_ID_RTL) {
		Status = EmacPsUtilRtlPhyInit(EmacPsInstancePtr, Speed, PhyAddr);
	} else {
		EmacPsUtilErrorTrap("Unknown phy identity");
	}

	if (Status != XST_SUCCESS) {
		EmacPsUtilErrorTrap("Error setup phy loopback");
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}

LONG EmacPsSetupDevice(XEmacPs *EmacPsInstancePtr)
{
    LONG Status;
    XEmacPs_Config *Config = &xemacps_config;

    /*************************************/
    /* Setup device for first-time usage */
    /*************************************/

    Status =
        XEmacPs_CfgInitialize(EmacPsInstancePtr, Config, Config->BaseAddress);

    if (Status != XST_SUCCESS) {
        EmacPsUtilErrorTrap("Error in initialize");
        return XST_FAILURE;
    } else {
        xil_printf("XEmacPs_CfgInitialize success! \r\n");
    }

    GemVersion = ((Xil_In32(Config->BaseAddress + 0xFC)) >> 16) & 0xFFF;
	xil_printf("GemVersion: %x\n\r", GemVersion);

	Platform = PLATFORM_VERSALEMU;

    XEmacPs_Reset(EmacPsInstancePtr);

    /*
     * Set the MAC address
     */
    Status = XEmacPs_SetMacAddress(EmacPsInstancePtr, EmacPsMAC, 1);
    if (Status != XST_SUCCESS) {
        EmacPsUtilErrorTrap("Error setting MAC address");
        return XST_FAILURE;
    } else {
        //char testMacAddr[6]
        //void XEmacPs_GetMacAddress(EmacPsInstancePtr, , u8 Index)
		xil_printf("MAC address success! \r\n");
	}
    /*
     * Setup callbacks
     */
    Status = XEmacPs_SetHandler(
        EmacPsInstancePtr, XEMACPS_HANDLER_DMASEND, (void *)XEmacPsSendHandler,
        EmacPsInstancePtr);
    Status |= XEmacPs_SetHandler(
        EmacPsInstancePtr, XEMACPS_HANDLER_DMARECV, (void *)XEmacPsRecvHandler,
        EmacPsInstancePtr);
    Status |= XEmacPs_SetHandler(
        EmacPsInstancePtr, XEMACPS_HANDLER_ERROR, (void *)XEmacPsErrorHandler,
        EmacPsInstancePtr);
    if (Status != XST_SUCCESS) {
        EmacPsUtilErrorTrap("Error assigning handlers");
        return XST_FAILURE;
    } else {
		xil_printf("Assigning handlers success! \r\n");
	}

    return XST_SUCCESS;
}

LONG EmacPsInit(XEmacPs *EmacPsInstancePtr)
{
    LONG status = XST_SUCCESS;
    status = EmacPsSetupDevice(EmacPsInstancePtr);
    if (status != XST_SUCCESS) {
        xil_printf("setup device error!\n\r");
    }

    status = EmacPsSetupBD(EmacPsInstancePtr);
    if (status != XST_SUCCESS) {
        xil_printf("setup BD error!\n\r");
    }

    /*
     * Set emacps to phy loopback or init phy for link
     */
    if (GemVersion == 2) {
        XEmacPs_SetMdioDivisor(EmacPsInstancePtr, MDC_DIV_224);
        EmacpsDelay(1);
        // NOTE: for convenience you can enter loopback mode to test your code.
        // EmacPsUtilEnterLocalLoopback(EmacPsInstancePtr);
        // EmacPsUtilEnterLoopback(EmacPsInstancePtr, EMACPS_LOOPBACK_SPEED_1G);
        u32 speed = EMACPS_LOOPBACK_SPEED_1G;
        if (EmacPsInitPhy(EmacPsInstancePtr, &speed) != XST_SUCCESS) {
            EmacPsUtilErrorTrap("init phy error!\n\r");
        }
        XEmacPs_SetOperatingSpeed(EmacPsInstancePtr, speed);
        XEmacPsClkSetup(EmacPsInstancePtr, speed);
        xil_printf("XEmacPsClkSetup success! \r\n");
    }

    /* clear any existed int status */
	XEmacPs_WriteReg(EmacPsInstancePtr->Config.BaseAddress, XEMACPS_ISR_OFFSET,
			   XEMACPS_IXR_ALL_MASK);

    /* Enable TX and RX interrupts */
    /* TODO: 
     * NOTE: you can use XEmacPs_IntEnable and XEmacPs_IntDisable
     *       enable these bits: 
     *          (XEMACPS_IXR_TX_ERR_MASK | XEMACPS_IXR_RX_ERR_MASK |
     *          (u32)XEMACPS_IXR_FRAMERX_MASK | (u32)XEMACPS_IXR_TXCOMPL_MASK)
     */

    return status;
}

LONG EmacPsSend(XEmacPs *EmacPsInstancePtr, EthernetFrame *TxFrame, size_t length)
{
    /*
     * Allocate, setup, and enqueue 1 TxBDs. The first BD will
     * describe the first 32 bytes of TxFrame and the rest of BDs
     * will describe the rest of the frame.
     *
     * The function below will allocate 1 adjacent BDs with Bd1Ptr
     * being set as the lead BD.
     */

    // TODO:

    /*
     * Setup first TxBD
     */
    
    // TODO:
    // set address, length, clear tx used bit
    // set `last` bit if needed
    XEmacPs_BdClearTxUsed(tx_bd_array);
    XEmacPs_BdSetLength(tx_bd_array, length);
    XEmacPs_BdSetLast(tx_bd_array);

    // flush dcache
    Xil_DCacheFlushRange(0, 64);

    XEmacPs_SetQueuePtr(EmacPsInstancePtr, (UINTPTR)tx_bd_array, 0, XEMACPS_SEND);

    // set enable bit
	u32 nwctrl = XEmacPs_ReadReg(EmacPsInstancePtr->Config.BaseAddress, XEMACPS_NWCTRL_OFFSET);
	XEmacPs_WriteReg(EmacPsInstancePtr->Config.BaseAddress, XEMACPS_NWCTRL_OFFSET, nwctrl | (u32)XEMACPS_NWCTRL_TXEN_MASK);

	// start transmit
    XEmacPs_Transmit(EmacPsInstancePtr);

    return XST_SUCCESS;
}

LONG EmacPsWaitSend(XEmacPs *EmacPsInstancePtr)
{
    /*
     * Wait for transmission to complete
     */
    while(XEmacPs_BdIsTxUsed(tx_bd_array) == FALSE) {
		Xil_DCacheFlushRange(0, 64);
    }

    return XST_SUCCESS;
}

LONG EmacPsRecv(XEmacPs *EmacPsInstancePtr, EthernetFrame *RxFrame, int num_packet)
{
    /* disable receiver */
	u32 nwctrl = XEmacPs_ReadReg(EmacPsInstancePtr->Config.BaseAddress, XEMACPS_NWCTRL_OFFSET);
	XEmacPs_WriteReg(EmacPsInstancePtr->Config.BaseAddress, XEMACPS_NWCTRL_OFFSET, nwctrl & (~(u32)XEMACPS_NWCTRL_RXEN_MASK));
    XEmacPs_WriteReg(EmacPsInstancePtr->Config.BaseAddress, XEMACPS_RXSR_OFFSET, 0xF);

    /*
     * Setup buffer address to associated BD.
     * Remember to set wrap bit and clear owner bit.
     */

    // TODO:
    XEmacPs_Bd* rx_bd_temp = rx_bd_array;
    for(int i = 0; i < num_packet; i++, rx_bd_temp++){
        XEmacPs_BdWrite(rx_bd_temp, XEMACPS_BD_STAT_OFFSET, 0);
        XEmacPs_BdClearRxNew(rx_bd_temp);
        XEmacPs_BdClearRxWrap(rx_bd_temp);

        if(i == num_packet - 1){//last one
            XEmacPs_BdSetRxWrap((UINTPTR)(rx_bd_temp));
        }
    }

    // flush dcache again
    Xil_DCacheFlushRange(0, 64);
    /*
     * Set the Queue pointers
     */
    // TODO: set rx queue base
    XEmacPs_SetQueuePtr(EmacPsInstancePtr, (UINTPTR)rx_bd_array, 0, XEMACPS_RECV);

	/* Enable receiver if not already enabled */
	nwctrl = XEmacPs_ReadReg(EmacPsInstancePtr->Config.BaseAddress, XEMACPS_NWCTRL_OFFSET);
	XEmacPs_WriteReg(EmacPsInstancePtr->Config.BaseAddress, XEMACPS_NWCTRL_OFFSET, nwctrl | (u32)XEMACPS_NWCTRL_RXEN_MASK);

    return XST_SUCCESS;
}

LONG EmacPsWaitRecv(XEmacPs *EmacPsInstancePtr, int num_packet, u32* RxFrLen)
{
    /*
     * Wait for Rx indication
     */
    XEmacPs_Bd* rx_bd_temp = rx_bd_array;
    for(int i = 0; i < num_packet; i++, rx_bd_temp++){
        while(XEmacPs_BdIsRxNew(rx_bd_temp) == FALSE){
            Xil_DCacheFlushRange(0, 64);
        }
        RxFrLen[i] = XEmacPs_BdGetLength(rx_bd_temp);
    }

    /*
     * Now that the frame has been received, post process our RxBD.
     * Since we have submitted to hardware.
     */
    
    // TODO:
    // NOTE: you can get length from BD
    
    return XST_SUCCESS;
}

void check_send(){
    Xil_DCacheFlushRange(0, 64);
    if(XEmacPs_BdIsTxUsed(tx_bd_array) == TRUE){
        int index=(net_send_queue.next)->index;
        pcb[index].status=TASK_READY;
        pcb[index].hang_on=&ready_queue;
        move_node(net_send_queue.next, &ready_queue, &net_send_queue);
    }
}

#define min(a,b) (((a) < (b)) ? (a) : (b))

XEmacPs_Bd* last_rx_bd;
int batch_finish=1;
int batch;
void check_recv(){
    //int temp=_num_packet;
    if(_num_packet > 0){//rest of the packets
        if(batch_finish==1){//recv a new batch
            batch=min(_num_packet,batch_size);
            for(int i=0;i<RXBD_CNT;i++){
                kmemset(&rx_buffer[i], 0, sizeof(EthernetFrame));
                rx_len[i] = 0;
            }
            switch_init_kdir();
            batch_finish=0;
            last_rx_bd=rx_bd_array;
            EmacPsRecv(&EmacPsInstance, 0, batch);
            switch_pgdir_back();
        }else{//check the old batch
            int i;// the i th bd in this batch
            switch_init_kdir();
            for(i=last_rx_bd-rx_bd_array;i<batch;){
                Xil_DCacheFlushRange(0, 64);
                if(XEmacPs_BdIsRxNew(last_rx_bd) == FALSE){//not yet
                    break;
                }

                rx_len[i] = XEmacPs_BdGetLength(last_rx_bd);
                //printk("i=%d,len=%d,batch=%d\n",i,rx_len[i],batch);
                kmemcpy(_addr, rx_buffer + i, rx_len[i]);
                *_frLength = rx_len[i];
                /*for(int j=0;j<rx_len[i];j++){
                    printk("%02x ", (unsigned)(*((char*)_addr)+j));
                }*/
                _addr += rx_len[i];
                _frLength ++;
                i++;
                last_rx_bd++;
            }
            if(i==batch){
                batch_finish=1;
                _num_packet -= batch_size;
            }
            switch_pgdir_back();
        }
    }else{//finish all
        /*for(int j=1;j<=3;j++){
            printk("frlen=%ld\n",*(_frLength-j));
        }*/
        unsigned char *start=(unsigned char *)_addr;
        /*printk("[CHECK]:\n");
        for(int j=0;j<200;j++){
            printk("%02x ", *(start-j));
            if(j%20==0){
                printk("\n");
            }
        }*/
        int index=(net_recv_queue.next)->index;
        pcb[index].status=TASK_READY;
        pcb[index].hang_on=&ready_queue;
        move_node(net_recv_queue.next, &ready_queue, &net_recv_queue);
    }
}

void clear_isr(XEmacPs *EmacPsInstancePtr){
    u32 isr =  XEmacPs_ReadReg(EmacPsInstancePtr->Config.BaseAddress, XEMACPS_ISR_OFFSET);
    XEmacPs_WriteReg(EmacPsInstancePtr->Config.BaseAddress, XEMACPS_ISR_OFFSET, isr);
}

void clear_txsr(XEmacPs *EmacPsInstancePtr){
    u32 txsr = XEmacPs_ReadReg(EmacPsInstancePtr->Config.BaseAddress, XEMACPS_TXSR_OFFSET);
    //write 1 to clear
    XEmacPs_WriteReg(EmacPsInstancePtr->Config.BaseAddress, XEMACPS_TXSR_OFFSET, txsr | XEMACPS_TXSR_TXCOMPL_MASK);
    //clear interrupt bit
    XEmacPs_IntDisable(EmacPsInstancePtr, XEMACPS_IXR_TXCOMPL_MASK | XEMACPS_IXR_TX_ERR_MASK);
}

void clear_rxsr(XEmacPs *EmacPsInstancePtr){
    u32 rxsr = XEmacPs_ReadReg(EmacPsInstancePtr->Config.BaseAddress, XEMACPS_RXSR_OFFSET);
    //write 1 to clear
    XEmacPs_WriteReg(EmacPsInstancePtr->Config.BaseAddress, XEMACPS_RXSR_OFFSET, rxsr | XEMACPS_RXSR_FRAMERX_MASK);
    //clear interrupt bit
    XEmacPs_IntDisable(EmacPsInstancePtr, XEMACPS_IXR_FRAMERX_MASK | XEMACPS_IXR_RX_ERR_MASK);
}

/****************************************************************************/
/**
 *
 * This function demonstrates the usage of the EmacPs driver by
 *sending by sending and receiving frames in interrupt driven DMA
 *mode.
 *
 *
 * @param	IntcInstancePtr is a pointer to the instance of the Intc
 *driver.
 * @param	EmacPsInstancePtr is a pointer to the instance of the
 *EmacPs driver.
 * @param	EmacPsDeviceId is Device ID of the EmacPs Device ,
 *typically XPAR_<EMACPS_instance>_DEVICE_ID value from
 *xparameters.h.
 * @param	EmacPsIntrId is the Interrupt ID and is typically
 *		XPAR_<EMACPS_instance>_INTR value from xparameters.h.
 *
 * @return	XST_SUCCESS to indicate success, otherwise XST_FAILURE.
 *
 * @note		None.
 *
 *****************************************************************************/
LONG EmacPsDmaIntrExample(
    XEmacPs *EmacPsInstancePtr)
{
    LONG Status = EmacPsInit(EmacPsInstancePtr);

    /*
     * Run the EmacPs DMA Single Frame Interrupt example
     */
	xil_printf("Start run the EmacPs DMA Single Frame Interrupt example\n\r");
    Status = EmacPsDmaSingleFrameIntrExample(EmacPsInstancePtr);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    } else {
		xil_printf("Run the EmacPs DMA Single Frame Interrupt example success\n\r");
	}

    /*
     * Stop the device
     */
    XEmacPs_Stop(EmacPsInstancePtr);

    return XST_SUCCESS;
}

/****************************************************************************/
/**
 *
 * This function demonstrates the usage of the EMACPS by sending
 *and receiving a single frame in DMA interrupt mode. The source
 *packet will be described by two descriptors. It will be received
 *into a buffer described by a single descriptor.
 *
 * @param	EmacPsInstancePtr is a pointer to the instance of the
 *EmacPs driver.
 *
 * @return	XST_SUCCESS to indicate success, otherwise XST_FAILURE.
 *
 * @note		None.
 *
 *****************************************************************************/
LONG EmacPsDmaSingleFrameIntrExample(XEmacPs *EmacPsInstancePtr)
{
    LONG Status;
    u32 PayloadSize = 1000;

    /*
     * Clear variables shared with callbacks
     */
    FramesRx     = 0;
    FramesTx     = 0;
    DeviceErrors = 0;

    /*
     * Calculate the frame length (not including FCS)
     */
    TxFrameLength = XEMACPS_HDR_SIZE + PayloadSize;

    /*
     * Setup packet to be transmitted
     */
    EmacPsUtilFrameHdrFormatMAC(&TxFrame, BroadcastMAC);
    EmacPsUtilFrameHdrFormatType(&TxFrame, PayloadSize);
    EmacPsUtilFrameSetPayloadData(&TxFrame, PayloadSize);
	xil_printf("Setup packet to be transmitted\n\r");
    Xil_DCacheFlushRange((UINTPTR)&TxFrame, sizeof(EthernetFrame));

    /*
     * Clear out receive packet memory area
     */
    EmacPsUtilFrameMemClear(&RxFrame);
	xil_printf("Clear out receive packet memory area\n\r");
    Xil_DCacheFlushRange((UINTPTR)&RxFrame, sizeof(EthernetFrame));

    EmacPsRecv(EmacPsInstancePtr, &RxFrame, 1);
    EmacPsSend(EmacPsInstancePtr, &TxFrame, TxFrameLength);

    EmacPsWaitSend(EmacPsInstancePtr);
    u32 RxFrLen;
    EmacPsWaitRecv(EmacPsInstancePtr, 1, &RxFrLen);

    /*
     * Start the device
     */

    // XEmacPs_Start(EmacPsInstancePtr);
	// xil_printf("Start device\n\r");

    /* Start transmit */
    // XEmacPs_Transmit(EmacPsInstancePtr);
	// xil_printf("Start transmit\n\r"); 


    if (EmacPsUtilFrameVerify(&TxFrame, &RxFrame) != 0) {
        for (int i = 0; i < (TxFrameLength / 16) - 1; ++i) {
            xil_printf("Tx > ");
            for (int j = 0; j < 16; ++j) {
                xil_printf("%02x ", ((u8*)&TxFrame)[i*16 + j]);
            }
            xil_printf("\n\rRx > ");
            for (int j = 0; j < 16; ++j) {
                xil_printf("%02x ", ((u8*)&RxFrame)[i*16 + j]);
            }
            xil_printf("\n\r");
        }
        EmacPsUtilErrorTrap("Data mismatch");
        return XST_FAILURE;
    } else {
		xil_printf("Data match success\n\r");
	}

    /*
     * Finished this example. If everything worked correctly, all
     * TxBDs and RxBDs should be free for allocation. Stop the
     * device.
     */
    XEmacPs_Stop(EmacPsInstancePtr);

    return XST_SUCCESS;
}

/****************************************************************************/
/**
 * This function resets the device but preserves the options set by
 *the user.
 *
 * The descriptor list could be reinitialized with the same calls
 *to XEmacPs_BdRingClone() as used in main(). Doing this is a
 *matter of preference. In many cases, an OS may have resources
 *tied up in the descriptors. Reinitializing in this case may bad
 *for the OS since its resources may be permamently lost.
 *
 * @param	EmacPsInstancePtr is a pointer to the instance of the
 *EmacPs driver.
 *
 * @return	XST_SUCCESS if successful, else XST_FAILURE.
 *
 * @note		None.
 *
 *****************************************************************************/
static LONG EmacPsResetDevice(XEmacPs *EmacPsInstancePtr)
{
    LONG Status = 0;
    u8 MacSave[6];
    u32 Options;
    XEmacPs_Bd BdTemplate;

    /*
     * Stop device
     */
    XEmacPs_Stop(EmacPsInstancePtr);

    /*
     * Save the device state
     */
    XEmacPs_GetMacAddress(EmacPsInstancePtr, &MacSave, 1);
    Options = XEmacPs_GetOptions(EmacPsInstancePtr);

    /*
     * Stop and reset the device
     */
    XEmacPs_Reset(EmacPsInstancePtr);

    /*
     * Restore the state
     */
    XEmacPs_SetMacAddress(EmacPsInstancePtr, &MacSave, 1);
    Status |= XEmacPs_SetOptions(EmacPsInstancePtr, Options);
    Status |= XEmacPs_ClearOptions(EmacPsInstancePtr, ~Options);
    if (Status != XST_SUCCESS) {
        EmacPsUtilErrorTrap("Error restoring state after reset");
        return XST_FAILURE;
    }

    /*
     * Setup callbacks
     */
    Status = XEmacPs_SetHandler(
        EmacPsInstancePtr, XEMACPS_HANDLER_DMASEND, (void *)XEmacPsSendHandler,
        EmacPsInstancePtr);
    Status |= XEmacPs_SetHandler(
        EmacPsInstancePtr, XEMACPS_HANDLER_DMARECV, (void *)XEmacPsRecvHandler,
        EmacPsInstancePtr);
    Status |= XEmacPs_SetHandler(
        EmacPsInstancePtr, XEMACPS_HANDLER_ERROR, (void *)XEmacPsErrorHandler,
        EmacPsInstancePtr);
    if (Status != XST_SUCCESS) {
        EmacPsUtilErrorTrap("Error assigning handlers");
        return XST_FAILURE;
    }

    /*
     * Setup RxBD space.
     *
     * We have already defined a properly aligned area of memory to
     * store RxBDs at the beginning of this source code file so
     * just pass its address into the function. No MMU is being
     * used so the physical and virtual addresses are the same.
     *
     * Setup a BD template for the Rx channel. This template will
     * be copied to every RxBD. We will not have to explicitly set
     * these again.
     */
    XEmacPs_BdClear(&BdTemplate);

    /*
     * Create the RxBD ring
     */
    Status = XEmacPs_BdRingCreate(
        &(XEmacPs_GetRxRing(EmacPsInstancePtr)), kva2pa((UINTPTR)RxBdSpacePtr),
        (UINTPTR)RxBdSpacePtr, XEMACPS_BD_ALIGNMENT, RXBD_CNT, &(XEmacPs_GetTxRing(EmacPsInstancePtr)));
    if (Status != XST_SUCCESS) {
        EmacPsUtilErrorTrap("Error setting up RxBD space, BdRingCreate");
        return XST_FAILURE;
    }

    Status = XEmacPs_BdRingClone(
        &(XEmacPs_GetRxRing(EmacPsInstancePtr)), &BdTemplate, XEMACPS_RECV);
    if (Status != XST_SUCCESS) {
        EmacPsUtilErrorTrap("Error setting up RxBD space, BdRingClone");
        return XST_FAILURE;
    }

    /*
     * Setup TxBD space.
     *
     * Like RxBD space, we have already defined a properly aligned
     * area of memory to use.
     *
     * Also like the RxBD space, we create a template. Notice we
     * don't set the "last" attribute. The examples will be
     * overriding this attribute so it does no good to set it up
     * here.
     */
    XEmacPs_BdClear(&BdTemplate);
    XEmacPs_BdSetStatus(&BdTemplate, XEMACPS_TXBUF_USED_MASK);

    /*
     * Create the TxBD ring
     */
    Status = XEmacPs_BdRingCreate(
        &(XEmacPs_GetTxRing(EmacPsInstancePtr)), kva2pa((UINTPTR)TxBdSpacePtr),
        (UINTPTR)TxBdSpacePtr, XEMACPS_BD_ALIGNMENT, TXBD_CNT, &(XEmacPs_GetRxRing(EmacPsInstancePtr)));
    if (Status != XST_SUCCESS) {
        EmacPsUtilErrorTrap("Error setting up TxBD space, BdRingCreate");
        return XST_FAILURE;
    }
    Status = XEmacPs_BdRingClone(
        &(XEmacPs_GetTxRing(EmacPsInstancePtr)), &BdTemplate, XEMACPS_SEND);
    if (Status != XST_SUCCESS) {
        EmacPsUtilErrorTrap("Error setting up TxBD space, BdRingClone");
        return XST_FAILURE;
    }

    /*
     * Restart the device
     */
    XEmacPs_Start(EmacPsInstancePtr);

    return XST_SUCCESS;
}

/****************************************************************************/
/**
 *
 * This the Transmit handler callback function and will increment a
 *shared counter that can be shared by the main thread of
 *operation.
 *
 * @param	Callback is the pointer to the instance of the EmacPs
 *device.
 *
 * @return	None.
 *
 * @note		None.
 *
 *****************************************************************************/
static void XEmacPsSendHandler(void *Callback)
{
    // TODO: you finish sending packet now
    XEmacPs *EmacPsInstancePtr = (XEmacPs *)Callback;

    /*
     * Disable the transmit related interrupts
     */
    /*XEmacPs_IntDisable(
        EmacPsInstancePtr,
        (XEMACPS_IXR_TXCOMPL_MASK | XEMACPS_IXR_TX_ERR_MASK));*/

    /*
     * Increment the counter so that main thread knows something
     * happened.
     */
    FramesTx++;

    /*if (!net_poll_mode) {
        if (!list_empty(&net_send_queue)) {
            do_unblock(net_send_queue.next);
        }
    }*/
}

/****************************************************************************/
/**
 *
 * This is the Receive handler callback function and will increment
 *a shared counter that can be shared by the main thread of
 *operation.
 *
 * @param	Callback is a pointer to the instance of the EmacPs
 *device.
 *
 * @return	None.
 *
 * @note		None.
 *
 *****************************************************************************/
static void XEmacPsRecvHandler(void *Callback)
{
    // TODO: you finish receiving packet now
    XEmacPs *EmacPsInstancePtr = (XEmacPs *)Callback;

    /*
     * Disable the transmit related interrupts
     */
    /*XEmacPs_IntDisable(
        EmacPsInstancePtr,
        (XEMACPS_IXR_FRAMERX_MASK | XEMACPS_IXR_RX_ERR_MASK));*/

    /*
     * Increment the counter so that main thread knows something
     * happened.
     */
    FramesRx++;
    
    /*if (!net_poll_mode) {
        if (!list_empty(&net_recv_queue)) {
            do_unblock(net_recv_queue.next);
        }
    }*/

}

/****************************************************************************/
/**
 *
 * This is the Error handler callback function and this function
 *increments the error counter so that the main thread knows the
 *number of errors.
 *
 * @param	Callback is the callback function for the driver. This
 *		parameter is not used in this example.
 * @param	Direction is passed in from the driver specifying which
 *		direction error has occurred.
 * @param	ErrorWord is the status register value passed in.
 *
 * @return	None.
 *
 * @note		None.
 *
 *****************************************************************************/
static void XEmacPsErrorHandler(void *Callback, u8 Direction, u32 ErrorWord)
{
    XEmacPs *EmacPsInstancePtr = (XEmacPs *)Callback;

    /*
     * Increment the counter so that main thread knows something
     * happened. Reset the device and reallocate resources ...
     */
    DeviceErrors++;

    switch (Direction) {
        case XEMACPS_RECV:
            if (ErrorWord & XEMACPS_RXSR_HRESPNOK_MASK) {
                EmacPsUtilErrorTrap("Receive DMA error");
            }
            if (ErrorWord & XEMACPS_RXSR_RXOVR_MASK) {
                EmacPsUtilErrorTrap("Receive over run");
            }
            if (ErrorWord & XEMACPS_RXSR_BUFFNA_MASK) {
                EmacPsUtilErrorTrap("Receive buffer not available");
            }
            break;
        case XEMACPS_SEND:
            if (ErrorWord & XEMACPS_TXSR_HRESPNOK_MASK) {
                EmacPsUtilErrorTrap("Transmit DMA error");
            }
            if (ErrorWord & XEMACPS_TXSR_URUN_MASK) {
                EmacPsUtilErrorTrap("Transmit under run");
            }
            if (ErrorWord & XEMACPS_TXSR_BUFEXH_MASK) {
                EmacPsUtilErrorTrap("Transmit buffer exhausted");
            }
            if (ErrorWord & XEMACPS_TXSR_RXOVR_MASK) {
                EmacPsUtilErrorTrap("Transmit retry excessed limits");
            }
            if (ErrorWord & XEMACPS_TXSR_FRAMERX_MASK) {
                EmacPsUtilErrorTrap("Transmit collision");
            }
            if (ErrorWord & XEMACPS_TXSR_USEDREAD_MASK) {
                EmacPsUtilErrorTrap("Transmit buffer not available");
            }
            break;
    }
    /*
     * Bypassing the reset functionality as the default tx status
     * for q0 is USED BIT READ. so, the first interrupt will be tx
     * used bit and it resets the core always.
     */
    if (GemVersion == 2) {
        EmacPsResetDevice(EmacPsInstancePtr);
    }
}

/****************************************************************************/
/**
 *
 * This function sets up the clock divisors for 1000Mbps.
 *
 * @param	EmacPsInstancePtr is a pointer to the instance of the
 *EmacPs driver.
 * @param	EmacPsIntrId is the Interrupt ID and is typically
 *			XPAR_<EMACPS_instance>_INTR value from xparameters.h.
 * @return	None.
 *
 * @note		None.
 *
 *****************************************************************************/
void XEmacPsClkSetup(XEmacPs *EmacPsInstancePtr, u32 speed)
{
    u32 ClkCntrl;
    if (GemVersion == 2) {
        /*************************************/
        /* Setup device for first-time usage */
        /*************************************/

        /* SLCR unlock */
        *(volatile unsigned int *)(SLCR_UNLOCK_ADDR) = SLCR_UNLOCK_KEY_VALUE;
        /* GEM0 1G clock configuration*/
        ClkCntrl = *(volatile unsigned int *)(SLCR_GEM0_CLK_CTRL_ADDR);
        ClkCntrl &= EMACPS_SLCR_DIV_MASK;

        u32 _div0 = 0;
        u32 _div1 = 0;
        switch (speed) {
            case 10:
                _div1 = XPAR_PS7_ETHERNET_0_ENET_SLCR_10MBPS_DIV1;
                _div0 = XPAR_PS7_ETHERNET_0_ENET_SLCR_10MBPS_DIV0;
                break;
            case 100:
                _div1 = XPAR_PS7_ETHERNET_0_ENET_SLCR_100MBPS_DIV1;
                _div0 = XPAR_PS7_ETHERNET_0_ENET_SLCR_100MBPS_DIV0;
                break;
            case 1000:
                _div1 = XPAR_PS7_ETHERNET_0_ENET_SLCR_1000MBPS_DIV1;
                _div0 = XPAR_PS7_ETHERNET_0_ENET_SLCR_1000MBPS_DIV0;
                break;
            default:
                EmacPsUtilErrorTrap("Unknown Speed, cannot setup clock.");
        }

        ClkCntrl |= (_div1 << 20);
        ClkCntrl |= (_div0 << 8);
        *(volatile unsigned int *)(SLCR_GEM0_CLK_CTRL_ADDR) = ClkCntrl;

        /* SLCR lock */
        *(unsigned int *)(SLCR_LOCK_ADDR) = SLCR_LOCK_KEY_VALUE;

        unsigned long count = 0;
        while (count < 0xffff) {
            count++;
        }
    }
}
