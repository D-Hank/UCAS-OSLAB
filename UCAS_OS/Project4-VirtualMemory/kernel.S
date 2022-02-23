
main:     file format elf64-littleriscv


Disassembly of section .text:

ffffffc050400000 <_start>:
ffffffc050400000:	10401073          	csrw	sie,zero
ffffffc050400004:	14401073          	csrw	sip,zero
ffffffc050400008:	6299                	lui	t0,0x6
ffffffc05040000a:	1002b073          	csrc	sstatus,t0
ffffffc05040000e:	00060197          	auipc	gp,0x60
ffffffc050400012:	0aa18193          	addi	gp,gp,170 # ffffffc0504600b8 <__global_pointer$>
ffffffc050400016:	f14022f3          	csrr	t0,mhartid
ffffffc05040001a:	02029863          	bnez	t0,ffffffc05040004a <setup_C_core1>
ffffffc05040001e:	87818693          	addi	a3,gp,-1928 # ffffffc05045f930 <_edata>
ffffffc050400022:	00074717          	auipc	a4,0x74
ffffffc050400026:	3c670713          	addi	a4,a4,966 # ffffffc0504743e8 <__BSS_END__>
ffffffc05040002a:	00e6d763          	bge	a3,a4,ffffffc050400038 <setup_C_core0>

ffffffc05040002e <clear_bss>:
ffffffc05040002e:	0006b023          	sd	zero,0(a3)
ffffffc050400032:	06a1                	addi	a3,a3,8
ffffffc050400034:	fee6cde3          	blt	a3,a4,ffffffc05040002e <clear_bss>

ffffffc050400038 <setup_C_core0>:
ffffffc050400038:	00007217          	auipc	tp,0x7
ffffffc05040003c:	36820213          	addi	tp,tp,872 # ffffffc0504073a0 <pid0_pcb_core0>
ffffffc050400040:	00060117          	auipc	sp,0x60
ffffffc050400044:	87813103          	ld	sp,-1928(sp) # ffffffc05045f8b8 <pid0_stack_core0>
ffffffc050400048:	a809                	j	ffffffc05040005a <head_done>

ffffffc05040004a <setup_C_core1>:
ffffffc05040004a:	00007217          	auipc	tp,0x7
ffffffc05040004e:	3ee20213          	addi	tp,tp,1006 # ffffffc050407438 <pid0_pcb_core1>
ffffffc050400052:	00060117          	auipc	sp,0x60
ffffffc050400056:	86e13103          	ld	sp,-1938(sp) # ffffffc05045f8c0 <pid0_stack_core1>

ffffffc05040005a <head_done>:
ffffffc05040005a:	14001073          	csrw	sscratch,zero
ffffffc05040005e:	00073517          	auipc	a0,0x73
ffffffc050400062:	da250513          	addi	a0,a0,-606 # ffffffc050472e00 <riscv_dtb>
ffffffc050400066:	e10c                	sd	a1,0(a0)
ffffffc050400068:	452010ef          	jal	ra,ffffffc0504014ba <main>

ffffffc05040006c <loop>:
ffffffc05040006c:	10500073          	wfi
ffffffc050400070:	bff5                	j	ffffffc05040006c <loop>
	...

ffffffc050400074 <setup_exception>:
ffffffc050400074:	00000517          	auipc	a0,0x0
ffffffc050400078:	14c50513          	addi	a0,a0,332 # ffffffc0504001c0 <exception_handler_entry>
ffffffc05040007c:	10551073          	csrw	stvec,a0
ffffffc050400080:	14401073          	csrw	sip,zero
ffffffc050400084:	02200513          	li	a0,34
ffffffc050400088:	10052073          	csrs	sstatus,a0
ffffffc05040008c:	22200513          	li	a0,546
ffffffc050400090:	10452073          	csrs	sie,a0
ffffffc050400094:	8082                	ret
	...

ffffffc050400098 <enable_preempt>:
ffffffc050400098:	8082                	ret
ffffffc05040009a:	0001                	nop

ffffffc05040009c <disable_preempt>:
ffffffc05040009c:	8082                	ret
ffffffc05040009e:	0001                	nop

ffffffc0504000a0 <enable_sum>:
ffffffc0504000a0:	000402b7          	lui	t0,0x40
ffffffc0504000a4:	1002a073          	csrs	sstatus,t0
ffffffc0504000a8:	8082                	ret
ffffffc0504000aa:	0001                	nop

ffffffc0504000ac <disable_sum>:
ffffffc0504000ac:	000402b7          	lui	t0,0x40
ffffffc0504000b0:	1002b073          	csrc	sstatus,t0
ffffffc0504000b4:	8082                	ret
ffffffc0504000b6:	0001                	nop

ffffffc0504000b8 <enable_interrupt>:
ffffffc0504000b8:	4289                	li	t0,2
ffffffc0504000ba:	1002a073          	csrs	sstatus,t0
ffffffc0504000be:	8082                	ret

ffffffc0504000c0 <disable_interrupt>:
ffffffc0504000c0:	4289                	li	t0,2
ffffffc0504000c2:	1002b073          	csrc	sstatus,t0
ffffffc0504000c6:	8082                	ret

ffffffc0504000c8 <switch_to>:
ffffffc0504000c8:	00053283          	ld	t0,0(a0)
ffffffc0504000cc:	f9028293          	addi	t0,t0,-112 # 3ff90 <_start-0xffffffc0503c0070>
ffffffc0504000d0:	0022b423          	sd	sp,8(t0)
ffffffc0504000d4:	0082b823          	sd	s0,16(t0)
ffffffc0504000d8:	0092bc23          	sd	s1,24(t0)
ffffffc0504000dc:	0322b023          	sd	s2,32(t0)
ffffffc0504000e0:	0332b423          	sd	s3,40(t0)
ffffffc0504000e4:	0342b823          	sd	s4,48(t0)
ffffffc0504000e8:	0352bc23          	sd	s5,56(t0)
ffffffc0504000ec:	0562b023          	sd	s6,64(t0)
ffffffc0504000f0:	0572b423          	sd	s7,72(t0)
ffffffc0504000f4:	0582b823          	sd	s8,80(t0)
ffffffc0504000f8:	0592bc23          	sd	s9,88(t0)
ffffffc0504000fc:	07a2b023          	sd	s10,96(t0)
ffffffc050400100:	07b2b423          	sd	s11,104(t0)
ffffffc050400104:	00553023          	sd	t0,0(a0)
ffffffc050400108:	0005b283          	ld	t0,0(a1)
ffffffc05040010c:	0082b103          	ld	sp,8(t0)
ffffffc050400110:	0102b403          	ld	s0,16(t0)
ffffffc050400114:	0182b483          	ld	s1,24(t0)
ffffffc050400118:	0202b903          	ld	s2,32(t0)
ffffffc05040011c:	0282b983          	ld	s3,40(t0)
ffffffc050400120:	0302ba03          	ld	s4,48(t0)
ffffffc050400124:	0382ba83          	ld	s5,56(t0)
ffffffc050400128:	0402bb03          	ld	s6,64(t0)
ffffffc05040012c:	0482bb83          	ld	s7,72(t0)
ffffffc050400130:	0502bc03          	ld	s8,80(t0)
ffffffc050400134:	0582bc83          	ld	s9,88(t0)
ffffffc050400138:	0602bd03          	ld	s10,96(t0)
ffffffc05040013c:	0682bd83          	ld	s11,104(t0)
ffffffc050400140:	07028293          	addi	t0,t0,112
ffffffc050400144:	0055b023          	sd	t0,0(a1)
ffffffc050400148:	00058233          	add	tp,a1,zero
ffffffc05040014c:	a011                	j	ffffffc050400150 <ret_from_exception>
ffffffc05040014e:	0001                	nop

ffffffc050400150 <ret_from_exception>:
ffffffc050400150:	3a0040ef          	jal	ra,ffffffc0504044f0 <unlock_kernel>
ffffffc050400154:	14021073          	csrw	sscratch,tp
ffffffc050400158:	00023103          	ld	sp,0(tp) # 0 <_start-0xffffffc050400000>
ffffffc05040015c:	6292                	ld	t0,256(sp)
ffffffc05040015e:	6332                	ld	t1,264(sp)
ffffffc050400160:	10029073          	csrw	sstatus,t0
ffffffc050400164:	14131073          	csrw	sepc,t1
ffffffc050400168:	60a2                	ld	ra,8(sp)
ffffffc05040016a:	61e2                	ld	gp,24(sp)
ffffffc05040016c:	72a2                	ld	t0,40(sp)
ffffffc05040016e:	7342                	ld	t1,48(sp)
ffffffc050400170:	73e2                	ld	t2,56(sp)
ffffffc050400172:	6406                	ld	s0,64(sp)
ffffffc050400174:	64a6                	ld	s1,72(sp)
ffffffc050400176:	6546                	ld	a0,80(sp)
ffffffc050400178:	65e6                	ld	a1,88(sp)
ffffffc05040017a:	7606                	ld	a2,96(sp)
ffffffc05040017c:	76a6                	ld	a3,104(sp)
ffffffc05040017e:	7746                	ld	a4,112(sp)
ffffffc050400180:	77e6                	ld	a5,120(sp)
ffffffc050400182:	680a                	ld	a6,128(sp)
ffffffc050400184:	68aa                	ld	a7,136(sp)
ffffffc050400186:	694a                	ld	s2,144(sp)
ffffffc050400188:	69ea                	ld	s3,152(sp)
ffffffc05040018a:	7a0a                	ld	s4,160(sp)
ffffffc05040018c:	7aaa                	ld	s5,168(sp)
ffffffc05040018e:	7b4a                	ld	s6,176(sp)
ffffffc050400190:	7bea                	ld	s7,184(sp)
ffffffc050400192:	6c0e                	ld	s8,192(sp)
ffffffc050400194:	6cae                	ld	s9,200(sp)
ffffffc050400196:	6d4e                	ld	s10,208(sp)
ffffffc050400198:	6dee                	ld	s11,216(sp)
ffffffc05040019a:	7e0e                	ld	t3,224(sp)
ffffffc05040019c:	7eae                	ld	t4,232(sp)
ffffffc05040019e:	00010f33          	add	t5,sp,zero
ffffffc0504001a2:	00020fb3          	add	t6,tp,zero
ffffffc0504001a6:	6115                	addi	sp,sp,288
ffffffc0504001a8:	002fb023          	sd	sp,0(t6)
ffffffc0504001ac:	008fb103          	ld	sp,8(t6)
ffffffc0504001b0:	020f3203          	ld	tp,32(t5)
ffffffc0504001b4:	0f8f3f83          	ld	t6,248(t5)
ffffffc0504001b8:	0f0f3f03          	ld	t5,240(t5)
ffffffc0504001bc:	10200073          	sret

ffffffc0504001c0 <exception_handler_entry>:
ffffffc0504001c0:	14021273          	csrrw	tp,sscratch,tp
ffffffc0504001c4:	00021663          	bnez	tp,ffffffc0504001d0 <_save_context>

ffffffc0504001c8 <_restore_kernel_tpsp>:
ffffffc0504001c8:	14002273          	csrr	tp,sscratch
ffffffc0504001cc:	00223023          	sd	sp,0(tp) # 0 <_start-0xffffffc050400000>

ffffffc0504001d0 <_save_context>:
ffffffc0504001d0:	00223423          	sd	sp,8(tp) # 8 <_start-0xffffffc0503ffff8>
ffffffc0504001d4:	00023103          	ld	sp,0(tp) # 0 <_start-0xffffffc050400000>
ffffffc0504001d8:	712d                	addi	sp,sp,-288
ffffffc0504001da:	00223023          	sd	sp,0(tp) # 0 <_start-0xffffffc050400000>
ffffffc0504001de:	e002                	sd	zero,0(sp)
ffffffc0504001e0:	e406                	sd	ra,8(sp)
ffffffc0504001e2:	e80a                	sd	sp,16(sp)
ffffffc0504001e4:	ec0e                	sd	gp,24(sp)
ffffffc0504001e6:	f012                	sd	tp,32(sp)
ffffffc0504001e8:	f416                	sd	t0,40(sp)
ffffffc0504001ea:	f81a                	sd	t1,48(sp)
ffffffc0504001ec:	fc1e                	sd	t2,56(sp)
ffffffc0504001ee:	e0a2                	sd	s0,64(sp)
ffffffc0504001f0:	e4a6                	sd	s1,72(sp)
ffffffc0504001f2:	e8aa                	sd	a0,80(sp)
ffffffc0504001f4:	ecae                	sd	a1,88(sp)
ffffffc0504001f6:	f0b2                	sd	a2,96(sp)
ffffffc0504001f8:	f4b6                	sd	a3,104(sp)
ffffffc0504001fa:	f8ba                	sd	a4,112(sp)
ffffffc0504001fc:	fcbe                	sd	a5,120(sp)
ffffffc0504001fe:	e142                	sd	a6,128(sp)
ffffffc050400200:	e546                	sd	a7,136(sp)
ffffffc050400202:	e94a                	sd	s2,144(sp)
ffffffc050400204:	ed4e                	sd	s3,152(sp)
ffffffc050400206:	f152                	sd	s4,160(sp)
ffffffc050400208:	f556                	sd	s5,168(sp)
ffffffc05040020a:	f95a                	sd	s6,176(sp)
ffffffc05040020c:	fd5e                	sd	s7,184(sp)
ffffffc05040020e:	e1e2                	sd	s8,192(sp)
ffffffc050400210:	e5e6                	sd	s9,200(sp)
ffffffc050400212:	e9ea                	sd	s10,208(sp)
ffffffc050400214:	edee                	sd	s11,216(sp)
ffffffc050400216:	f1f2                	sd	t3,224(sp)
ffffffc050400218:	f5f6                	sd	t4,232(sp)
ffffffc05040021a:	f9fa                	sd	t5,240(sp)
ffffffc05040021c:	fdfe                	sd	t6,248(sp)
ffffffc05040021e:	6299                	lui	t0,0x6
ffffffc050400220:	1002b073          	csrc	sstatus,t0
ffffffc050400224:	100022f3          	csrr	t0,sstatus
ffffffc050400228:	14102373          	csrr	t1,sepc
ffffffc05040022c:	143023f3          	csrr	t2,stval
ffffffc050400230:	14202e73          	csrr	t3,scause
ffffffc050400234:	e216                	sd	t0,256(sp)
ffffffc050400236:	e61a                	sd	t1,264(sp)
ffffffc050400238:	ea1e                	sd	t2,272(sp)
ffffffc05040023a:	ee72                	sd	t3,280(sp)
ffffffc05040023c:	000402b7          	lui	t0,0x40
ffffffc050400240:	1002a073          	csrs	sstatus,t0
ffffffc050400244:	14001073          	csrw	sscratch,zero
ffffffc050400248:	00060197          	auipc	gp,0x60
ffffffc05040024c:	e7018193          	addi	gp,gp,-400 # ffffffc0504600b8 <__global_pointer$>
ffffffc050400250:	282040ef          	jal	ra,ffffffc0504044d2 <lock_kernel>
ffffffc050400254:	00023503          	ld	a0,0(tp) # 0 <_start-0xffffffc050400000>
ffffffc050400258:	143025f3          	csrr	a1,stval
ffffffc05040025c:	14202673          	csrr	a2,scause
ffffffc050400260:	49e010ef          	jal	ra,ffffffc0504016fe <interrupt_helper>
ffffffc050400264:	b5f5                	j	ffffffc050400150 <ret_from_exception>
	...

ffffffc050400268 <sbi_console_putstr>:
ffffffc050400268:	1101                	addi	sp,sp,-32
ffffffc05040026a:	ec22                	sd	s0,24(sp)
ffffffc05040026c:	1000                	addi	s0,sp,32
ffffffc05040026e:	fea43423          	sd	a0,-24(s0)
ffffffc050400272:	a839                	j	ffffffc050400290 <sbi_console_putstr+0x28>
ffffffc050400274:	fe843783          	ld	a5,-24(s0)
ffffffc050400278:	00178713          	addi	a4,a5,1
ffffffc05040027c:	fee43423          	sd	a4,-24(s0)
ffffffc050400280:	0007c783          	lbu	a5,0(a5)
ffffffc050400284:	853e                	mv	a0,a5
ffffffc050400286:	4581                	li	a1,0
ffffffc050400288:	4601                	li	a2,0
ffffffc05040028a:	4885                	li	a7,1
ffffffc05040028c:	00000073          	ecall
ffffffc050400290:	fe843783          	ld	a5,-24(s0)
ffffffc050400294:	0007c783          	lbu	a5,0(a5)
ffffffc050400298:	fff1                	bnez	a5,ffffffc050400274 <sbi_console_putstr+0xc>
ffffffc05040029a:	0001                	nop
ffffffc05040029c:	0001                	nop
ffffffc05040029e:	6462                	ld	s0,24(sp)
ffffffc0504002a0:	6105                	addi	sp,sp,32
ffffffc0504002a2:	8082                	ret

ffffffc0504002a4 <sbi_console_putchar>:
ffffffc0504002a4:	1101                	addi	sp,sp,-32
ffffffc0504002a6:	ec22                	sd	s0,24(sp)
ffffffc0504002a8:	1000                	addi	s0,sp,32
ffffffc0504002aa:	87aa                	mv	a5,a0
ffffffc0504002ac:	fef42623          	sw	a5,-20(s0)
ffffffc0504002b0:	fec42783          	lw	a5,-20(s0)
ffffffc0504002b4:	853e                	mv	a0,a5
ffffffc0504002b6:	4581                	li	a1,0
ffffffc0504002b8:	4601                	li	a2,0
ffffffc0504002ba:	4885                	li	a7,1
ffffffc0504002bc:	00000073          	ecall
ffffffc0504002c0:	0001                	nop
ffffffc0504002c2:	6462                	ld	s0,24(sp)
ffffffc0504002c4:	6105                	addi	sp,sp,32
ffffffc0504002c6:	8082                	ret

ffffffc0504002c8 <sbi_console_getchar>:
ffffffc0504002c8:	1141                	addi	sp,sp,-16
ffffffc0504002ca:	e422                	sd	s0,8(sp)
ffffffc0504002cc:	0800                	addi	s0,sp,16
ffffffc0504002ce:	4501                	li	a0,0
ffffffc0504002d0:	4581                	li	a1,0
ffffffc0504002d2:	4601                	li	a2,0
ffffffc0504002d4:	4889                	li	a7,2
ffffffc0504002d6:	00000073          	ecall
ffffffc0504002da:	87aa                	mv	a5,a0
ffffffc0504002dc:	2781                	sext.w	a5,a5
ffffffc0504002de:	853e                	mv	a0,a5
ffffffc0504002e0:	6422                	ld	s0,8(sp)
ffffffc0504002e2:	0141                	addi	sp,sp,16
ffffffc0504002e4:	8082                	ret

ffffffc0504002e6 <port_write_ch>:
ffffffc0504002e6:	1101                	addi	sp,sp,-32
ffffffc0504002e8:	ec06                	sd	ra,24(sp)
ffffffc0504002ea:	e822                	sd	s0,16(sp)
ffffffc0504002ec:	1000                	addi	s0,sp,32
ffffffc0504002ee:	87aa                	mv	a5,a0
ffffffc0504002f0:	fef407a3          	sb	a5,-17(s0)
ffffffc0504002f4:	fef44783          	lbu	a5,-17(s0)
ffffffc0504002f8:	2781                	sext.w	a5,a5
ffffffc0504002fa:	853e                	mv	a0,a5
ffffffc0504002fc:	fa9ff0ef          	jal	ra,ffffffc0504002a4 <sbi_console_putchar>
ffffffc050400300:	0001                	nop
ffffffc050400302:	60e2                	ld	ra,24(sp)
ffffffc050400304:	6442                	ld	s0,16(sp)
ffffffc050400306:	6105                	addi	sp,sp,32
ffffffc050400308:	8082                	ret

ffffffc05040030a <port_write>:
ffffffc05040030a:	1101                	addi	sp,sp,-32
ffffffc05040030c:	ec06                	sd	ra,24(sp)
ffffffc05040030e:	e822                	sd	s0,16(sp)
ffffffc050400310:	1000                	addi	s0,sp,32
ffffffc050400312:	fea43423          	sd	a0,-24(s0)
ffffffc050400316:	fe843503          	ld	a0,-24(s0)
ffffffc05040031a:	f4fff0ef          	jal	ra,ffffffc050400268 <sbi_console_putstr>
ffffffc05040031e:	0001                	nop
ffffffc050400320:	60e2                	ld	ra,24(sp)
ffffffc050400322:	6442                	ld	s0,16(sp)
ffffffc050400324:	6105                	addi	sp,sp,32
ffffffc050400326:	8082                	ret

ffffffc050400328 <port_read_ch>:
ffffffc050400328:	1141                	addi	sp,sp,-16
ffffffc05040032a:	e406                	sd	ra,8(sp)
ffffffc05040032c:	e022                	sd	s0,0(sp)
ffffffc05040032e:	0800                	addi	s0,sp,16
ffffffc050400330:	f99ff0ef          	jal	ra,ffffffc0504002c8 <sbi_console_getchar>
ffffffc050400334:	87aa                	mv	a5,a0
ffffffc050400336:	853e                	mv	a0,a5
ffffffc050400338:	60a2                	ld	ra,8(sp)
ffffffc05040033a:	6402                	ld	s0,0(sp)
ffffffc05040033c:	0141                	addi	sp,sp,16
ffffffc05040033e:	8082                	ret

ffffffc050400340 <get_current_cpu_id>:
ffffffc050400340:	f1402573          	csrr	a0,mhartid
ffffffc050400344:	8082                	ret

ffffffc050400346 <sbi_set_timer>:
ffffffc050400346:	1101                	addi	sp,sp,-32
ffffffc050400348:	ec22                	sd	s0,24(sp)
ffffffc05040034a:	1000                	addi	s0,sp,32
ffffffc05040034c:	fea43423          	sd	a0,-24(s0)
ffffffc050400350:	fe843503          	ld	a0,-24(s0)
ffffffc050400354:	4581                	li	a1,0
ffffffc050400356:	4601                	li	a2,0
ffffffc050400358:	4881                	li	a7,0
ffffffc05040035a:	00000073          	ecall
ffffffc05040035e:	0001                	nop
ffffffc050400360:	6462                	ld	s0,24(sp)
ffffffc050400362:	6105                	addi	sp,sp,32
ffffffc050400364:	8082                	ret

ffffffc050400366 <sbi_read_fdt>:
ffffffc050400366:	1101                	addi	sp,sp,-32
ffffffc050400368:	ec22                	sd	s0,24(sp)
ffffffc05040036a:	1000                	addi	s0,sp,32
ffffffc05040036c:	87aa                	mv	a5,a0
ffffffc05040036e:	fef42623          	sw	a5,-20(s0)
ffffffc050400372:	fec42783          	lw	a5,-20(s0)
ffffffc050400376:	853e                	mv	a0,a5
ffffffc050400378:	4581                	li	a1,0
ffffffc05040037a:	4601                	li	a2,0
ffffffc05040037c:	48b1                	li	a7,12
ffffffc05040037e:	00000073          	ecall
ffffffc050400382:	87aa                	mv	a5,a0
ffffffc050400384:	2781                	sext.w	a5,a5
ffffffc050400386:	853e                	mv	a0,a5
ffffffc050400388:	6462                	ld	s0,24(sp)
ffffffc05040038a:	6105                	addi	sp,sp,32
ffffffc05040038c:	8082                	ret

ffffffc05040038e <pa2kva>:
ffffffc05040038e:	1101                	addi	sp,sp,-32
ffffffc050400390:	ec22                	sd	s0,24(sp)
ffffffc050400392:	1000                	addi	s0,sp,32
ffffffc050400394:	fea43423          	sd	a0,-24(s0)
ffffffc050400398:	fe843703          	ld	a4,-24(s0)
ffffffc05040039c:	57fd                	li	a5,-1
ffffffc05040039e:	179a                	slli	a5,a5,0x26
ffffffc0504003a0:	97ba                	add	a5,a5,a4
ffffffc0504003a2:	853e                	mv	a0,a5
ffffffc0504003a4:	6462                	ld	s0,24(sp)
ffffffc0504003a6:	6105                	addi	sp,sp,32
ffffffc0504003a8:	8082                	ret

ffffffc0504003aa <get_pa>:
ffffffc0504003aa:	1101                	addi	sp,sp,-32
ffffffc0504003ac:	ec22                	sd	s0,24(sp)
ffffffc0504003ae:	1000                	addi	s0,sp,32
ffffffc0504003b0:	fea43423          	sd	a0,-24(s0)
ffffffc0504003b4:	fe843783          	ld	a5,-24(s0)
ffffffc0504003b8:	83a9                	srli	a5,a5,0xa
ffffffc0504003ba:	00c79713          	slli	a4,a5,0xc
ffffffc0504003be:	fff007b7          	lui	a5,0xfff00
ffffffc0504003c2:	83a1                	srli	a5,a5,0x8
ffffffc0504003c4:	8ff9                	and	a5,a5,a4
ffffffc0504003c6:	853e                	mv	a0,a5
ffffffc0504003c8:	6462                	ld	s0,24(sp)
ffffffc0504003ca:	6105                	addi	sp,sp,32
ffffffc0504003cc:	8082                	ret

ffffffc0504003ce <get_kva_of>:
ffffffc0504003ce:	7159                	addi	sp,sp,-112
ffffffc0504003d0:	f486                	sd	ra,104(sp)
ffffffc0504003d2:	f0a2                	sd	s0,96(sp)
ffffffc0504003d4:	1880                	addi	s0,sp,112
ffffffc0504003d6:	f8a43c23          	sd	a0,-104(s0)
ffffffc0504003da:	f8b43823          	sd	a1,-112(s0)
ffffffc0504003de:	f9843783          	ld	a5,-104(s0)
ffffffc0504003e2:	83f9                	srli	a5,a5,0x1e
ffffffc0504003e4:	2781                	sext.w	a5,a5
ffffffc0504003e6:	1ff7f793          	andi	a5,a5,511
ffffffc0504003ea:	fef42623          	sw	a5,-20(s0)
ffffffc0504003ee:	f9843783          	ld	a5,-104(s0)
ffffffc0504003f2:	83d5                	srli	a5,a5,0x15
ffffffc0504003f4:	2781                	sext.w	a5,a5
ffffffc0504003f6:	1ff7f793          	andi	a5,a5,511
ffffffc0504003fa:	fef42423          	sw	a5,-24(s0)
ffffffc0504003fe:	f9843783          	ld	a5,-104(s0)
ffffffc050400402:	83b1                	srli	a5,a5,0xc
ffffffc050400404:	2781                	sext.w	a5,a5
ffffffc050400406:	1ff7f793          	andi	a5,a5,511
ffffffc05040040a:	fef42223          	sw	a5,-28(s0)
ffffffc05040040e:	f9043783          	ld	a5,-112(s0)
ffffffc050400412:	fcf43c23          	sd	a5,-40(s0)
ffffffc050400416:	fec46783          	lwu	a5,-20(s0)
ffffffc05040041a:	078e                	slli	a5,a5,0x3
ffffffc05040041c:	fd843703          	ld	a4,-40(s0)
ffffffc050400420:	97ba                	add	a5,a5,a4
ffffffc050400422:	639c                	ld	a5,0(a5)
ffffffc050400424:	853e                	mv	a0,a5
ffffffc050400426:	f85ff0ef          	jal	ra,ffffffc0504003aa <get_pa>
ffffffc05040042a:	87aa                	mv	a5,a0
ffffffc05040042c:	fcf43823          	sd	a5,-48(s0)
ffffffc050400430:	fd043783          	ld	a5,-48(s0)
ffffffc050400434:	853e                	mv	a0,a5
ffffffc050400436:	f59ff0ef          	jal	ra,ffffffc05040038e <pa2kva>
ffffffc05040043a:	87aa                	mv	a5,a0
ffffffc05040043c:	fcf43423          	sd	a5,-56(s0)
ffffffc050400440:	fe846783          	lwu	a5,-24(s0)
ffffffc050400444:	078e                	slli	a5,a5,0x3
ffffffc050400446:	fc843703          	ld	a4,-56(s0)
ffffffc05040044a:	97ba                	add	a5,a5,a4
ffffffc05040044c:	639c                	ld	a5,0(a5)
ffffffc05040044e:	853e                	mv	a0,a5
ffffffc050400450:	f5bff0ef          	jal	ra,ffffffc0504003aa <get_pa>
ffffffc050400454:	87aa                	mv	a5,a0
ffffffc050400456:	fcf43023          	sd	a5,-64(s0)
ffffffc05040045a:	fc043783          	ld	a5,-64(s0)
ffffffc05040045e:	853e                	mv	a0,a5
ffffffc050400460:	f2fff0ef          	jal	ra,ffffffc05040038e <pa2kva>
ffffffc050400464:	87aa                	mv	a5,a0
ffffffc050400466:	faf43c23          	sd	a5,-72(s0)
ffffffc05040046a:	fe446783          	lwu	a5,-28(s0)
ffffffc05040046e:	078e                	slli	a5,a5,0x3
ffffffc050400470:	fb843703          	ld	a4,-72(s0)
ffffffc050400474:	97ba                	add	a5,a5,a4
ffffffc050400476:	639c                	ld	a5,0(a5)
ffffffc050400478:	853e                	mv	a0,a5
ffffffc05040047a:	f31ff0ef          	jal	ra,ffffffc0504003aa <get_pa>
ffffffc05040047e:	faa43823          	sd	a0,-80(s0)
ffffffc050400482:	fb043503          	ld	a0,-80(s0)
ffffffc050400486:	f09ff0ef          	jal	ra,ffffffc05040038e <pa2kva>
ffffffc05040048a:	faa43423          	sd	a0,-88(s0)
ffffffc05040048e:	fa843783          	ld	a5,-88(s0)
ffffffc050400492:	853e                	mv	a0,a5
ffffffc050400494:	70a6                	ld	ra,104(sp)
ffffffc050400496:	7406                	ld	s0,96(sp)
ffffffc050400498:	6165                	addi	sp,sp,112
ffffffc05040049a:	8082                	ret

ffffffc05040049c <is_elf_format>:
ffffffc05040049c:	7179                	addi	sp,sp,-48
ffffffc05040049e:	f422                	sd	s0,40(sp)
ffffffc0504004a0:	1800                	addi	s0,sp,48
ffffffc0504004a2:	fca43c23          	sd	a0,-40(s0)
ffffffc0504004a6:	fd843783          	ld	a5,-40(s0)
ffffffc0504004aa:	fef43423          	sd	a5,-24(s0)
ffffffc0504004ae:	fe843783          	ld	a5,-24(s0)
ffffffc0504004b2:	0007c783          	lbu	a5,0(a5) # fffffffffff00000 <__BSS_END__+0x3fafa8bc18>
ffffffc0504004b6:	eb9d                	bnez	a5,ffffffc0504004ec <is_elf_format+0x50>
ffffffc0504004b8:	fe843783          	ld	a5,-24(s0)
ffffffc0504004bc:	0017c783          	lbu	a5,1(a5)
ffffffc0504004c0:	873e                	mv	a4,a5
ffffffc0504004c2:	4785                	li	a5,1
ffffffc0504004c4:	02f71463          	bne	a4,a5,ffffffc0504004ec <is_elf_format+0x50>
ffffffc0504004c8:	fe843783          	ld	a5,-24(s0)
ffffffc0504004cc:	0027c783          	lbu	a5,2(a5)
ffffffc0504004d0:	873e                	mv	a4,a5
ffffffc0504004d2:	4789                	li	a5,2
ffffffc0504004d4:	00f71c63          	bne	a4,a5,ffffffc0504004ec <is_elf_format+0x50>
ffffffc0504004d8:	fe843783          	ld	a5,-24(s0)
ffffffc0504004dc:	0037c783          	lbu	a5,3(a5)
ffffffc0504004e0:	873e                	mv	a4,a5
ffffffc0504004e2:	478d                	li	a5,3
ffffffc0504004e4:	00f71463          	bne	a4,a5,ffffffc0504004ec <is_elf_format+0x50>
ffffffc0504004e8:	4781                	li	a5,0
ffffffc0504004ea:	a011                	j	ffffffc0504004ee <is_elf_format+0x52>
ffffffc0504004ec:	4785                	li	a5,1
ffffffc0504004ee:	853e                	mv	a0,a5
ffffffc0504004f0:	7422                	ld	s0,40(sp)
ffffffc0504004f2:	6145                	addi	sp,sp,48
ffffffc0504004f4:	8082                	ret

ffffffc0504004f6 <load_elf>:
ffffffc0504004f6:	7159                	addi	sp,sp,-112
ffffffc0504004f8:	f486                	sd	ra,104(sp)
ffffffc0504004fa:	f0a2                	sd	s0,96(sp)
ffffffc0504004fc:	1880                	addi	s0,sp,112
ffffffc0504004fe:	faa43423          	sd	a0,-88(s0)
ffffffc050400502:	87ae                	mv	a5,a1
ffffffc050400504:	f8c43c23          	sd	a2,-104(s0)
ffffffc050400508:	f8d43823          	sd	a3,-112(s0)
ffffffc05040050c:	faf42223          	sw	a5,-92(s0)
ffffffc050400510:	fa843783          	ld	a5,-88(s0)
ffffffc050400514:	fcf43823          	sd	a5,-48(s0)
ffffffc050400518:	fc043423          	sd	zero,-56(s0)
ffffffc05040051c:	fe043423          	sd	zero,-24(s0)
ffffffc050400520:	fe042023          	sw	zero,-32(s0)
ffffffc050400524:	fa442783          	lw	a5,-92(s0)
ffffffc050400528:	0007871b          	sext.w	a4,a5
ffffffc05040052c:	478d                	li	a5,3
ffffffc05040052e:	00e7f863          	bgeu	a5,a4,ffffffc05040053e <load_elf+0x48>
ffffffc050400532:	fa843503          	ld	a0,-88(s0)
ffffffc050400536:	f67ff0ef          	jal	ra,ffffffc05040049c <is_elf_format>
ffffffc05040053a:	87aa                	mv	a5,a0
ffffffc05040053c:	e399                	bnez	a5,ffffffc050400542 <load_elf+0x4c>
ffffffc05040053e:	4781                	li	a5,0
ffffffc050400540:	a259                	j	ffffffc0504006c6 <load_elf+0x1d0>
ffffffc050400542:	fd043783          	ld	a5,-48(s0)
ffffffc050400546:	739c                	ld	a5,32(a5)
ffffffc050400548:	fa843703          	ld	a4,-88(s0)
ffffffc05040054c:	97ba                	add	a5,a5,a4
ffffffc05040054e:	fef43423          	sd	a5,-24(s0)
ffffffc050400552:	fd043783          	ld	a5,-48(s0)
ffffffc050400556:	0387d783          	lhu	a5,56(a5)
ffffffc05040055a:	fef41323          	sh	a5,-26(s0)
ffffffc05040055e:	fd043783          	ld	a5,-48(s0)
ffffffc050400562:	0367d783          	lhu	a5,54(a5)
ffffffc050400566:	fcf41323          	sh	a5,-58(s0)
ffffffc05040056a:	a299                	j	ffffffc0504006b0 <load_elf+0x1ba>
ffffffc05040056c:	fe843783          	ld	a5,-24(s0)
ffffffc050400570:	fcf43423          	sd	a5,-56(s0)
ffffffc050400574:	fc843783          	ld	a5,-56(s0)
ffffffc050400578:	439c                	lw	a5,0(a5)
ffffffc05040057a:	873e                	mv	a4,a5
ffffffc05040057c:	4785                	li	a5,1
ffffffc05040057e:	12f71263          	bne	a4,a5,ffffffc0504006a2 <load_elf+0x1ac>
ffffffc050400582:	fe042023          	sw	zero,-32(s0)
ffffffc050400586:	a239                	j	ffffffc050400694 <load_elf+0x19e>
ffffffc050400588:	fe042703          	lw	a4,-32(s0)
ffffffc05040058c:	fc843783          	ld	a5,-56(s0)
ffffffc050400590:	739c                	ld	a5,32(a5)
ffffffc050400592:	0af77463          	bgeu	a4,a5,ffffffc05040063a <load_elf+0x144>
ffffffc050400596:	fc843783          	ld	a5,-56(s0)
ffffffc05040059a:	6b98                	ld	a4,16(a5)
ffffffc05040059c:	fe042783          	lw	a5,-32(s0)
ffffffc0504005a0:	97ba                	add	a5,a5,a4
ffffffc0504005a2:	f9043703          	ld	a4,-112(s0)
ffffffc0504005a6:	f9843583          	ld	a1,-104(s0)
ffffffc0504005aa:	853e                	mv	a0,a5
ffffffc0504005ac:	9702                	jalr	a4
ffffffc0504005ae:	87aa                	mv	a5,a0
ffffffc0504005b0:	faf43823          	sd	a5,-80(s0)
ffffffc0504005b4:	fc843783          	ld	a5,-56(s0)
ffffffc0504005b8:	6798                	ld	a4,8(a5)
ffffffc0504005ba:	fe042783          	lw	a5,-32(s0)
ffffffc0504005be:	97ba                	add	a5,a5,a4
ffffffc0504005c0:	fa843703          	ld	a4,-88(s0)
ffffffc0504005c4:	00f706b3          	add	a3,a4,a5
ffffffc0504005c8:	fc843783          	ld	a5,-56(s0)
ffffffc0504005cc:	7398                	ld	a4,32(a5)
ffffffc0504005ce:	fe042783          	lw	a5,-32(s0)
ffffffc0504005d2:	40f707b3          	sub	a5,a4,a5
ffffffc0504005d6:	6705                	lui	a4,0x1
ffffffc0504005d8:	00f77363          	bgeu	a4,a5,ffffffc0504005de <load_elf+0xe8>
ffffffc0504005dc:	6785                	lui	a5,0x1
ffffffc0504005de:	2781                	sext.w	a5,a5
ffffffc0504005e0:	863e                	mv	a2,a5
ffffffc0504005e2:	85b6                	mv	a1,a3
ffffffc0504005e4:	fb043503          	ld	a0,-80(s0)
ffffffc0504005e8:	5eb050ef          	jal	ra,ffffffc0504063d2 <memcpy>
ffffffc0504005ec:	fc843783          	ld	a5,-56(s0)
ffffffc0504005f0:	7398                	ld	a4,32(a5)
ffffffc0504005f2:	fe042783          	lw	a5,-32(s0)
ffffffc0504005f6:	8f1d                	sub	a4,a4,a5
ffffffc0504005f8:	6785                	lui	a5,0x1
ffffffc0504005fa:	08f77663          	bgeu	a4,a5,ffffffc050400686 <load_elf+0x190>
ffffffc0504005fe:	fc843783          	ld	a5,-56(s0)
ffffffc050400602:	739c                	ld	a5,32(a5)
ffffffc050400604:	0007871b          	sext.w	a4,a5
ffffffc050400608:	6785                	lui	a5,0x1
ffffffc05040060a:	17fd                	addi	a5,a5,-1
ffffffc05040060c:	8ff9                	and	a5,a5,a4
ffffffc05040060e:	fcf42e23          	sw	a5,-36(s0)
ffffffc050400612:	a829                	j	ffffffc05040062c <load_elf+0x136>
ffffffc050400614:	fdc42783          	lw	a5,-36(s0)
ffffffc050400618:	fb043703          	ld	a4,-80(s0)
ffffffc05040061c:	97ba                	add	a5,a5,a4
ffffffc05040061e:	00078023          	sb	zero,0(a5) # 1000 <_start-0xffffffc0503ff000>
ffffffc050400622:	fdc42783          	lw	a5,-36(s0)
ffffffc050400626:	2785                	addiw	a5,a5,1
ffffffc050400628:	fcf42e23          	sw	a5,-36(s0)
ffffffc05040062c:	fdc42783          	lw	a5,-36(s0)
ffffffc050400630:	873e                	mv	a4,a5
ffffffc050400632:	6785                	lui	a5,0x1
ffffffc050400634:	fef760e3          	bltu	a4,a5,ffffffc050400614 <load_elf+0x11e>
ffffffc050400638:	a0b9                	j	ffffffc050400686 <load_elf+0x190>
ffffffc05040063a:	fc843783          	ld	a5,-56(s0)
ffffffc05040063e:	6b98                	ld	a4,16(a5)
ffffffc050400640:	fe042783          	lw	a5,-32(s0)
ffffffc050400644:	97ba                	add	a5,a5,a4
ffffffc050400646:	f9043703          	ld	a4,-112(s0)
ffffffc05040064a:	f9843583          	ld	a1,-104(s0)
ffffffc05040064e:	853e                	mv	a0,a5
ffffffc050400650:	9702                	jalr	a4
ffffffc050400652:	87aa                	mv	a5,a0
ffffffc050400654:	faf43c23          	sd	a5,-72(s0)
ffffffc050400658:	fc042c23          	sw	zero,-40(s0)
ffffffc05040065c:	a831                	j	ffffffc050400678 <load_elf+0x182>
ffffffc05040065e:	fd842783          	lw	a5,-40(s0)
ffffffc050400662:	078e                	slli	a5,a5,0x3
ffffffc050400664:	fb843703          	ld	a4,-72(s0)
ffffffc050400668:	97ba                	add	a5,a5,a4
ffffffc05040066a:	0007b023          	sd	zero,0(a5) # 1000 <_start-0xffffffc0503ff000>
ffffffc05040066e:	fd842783          	lw	a5,-40(s0)
ffffffc050400672:	2785                	addiw	a5,a5,1
ffffffc050400674:	fcf42c23          	sw	a5,-40(s0)
ffffffc050400678:	fd842783          	lw	a5,-40(s0)
ffffffc05040067c:	873e                	mv	a4,a5
ffffffc05040067e:	1ff00793          	li	a5,511
ffffffc050400682:	fce7fee3          	bgeu	a5,a4,ffffffc05040065e <load_elf+0x168>
ffffffc050400686:	fe042703          	lw	a4,-32(s0)
ffffffc05040068a:	6785                	lui	a5,0x1
ffffffc05040068c:	9fb9                	addw	a5,a5,a4
ffffffc05040068e:	2781                	sext.w	a5,a5
ffffffc050400690:	fef42023          	sw	a5,-32(s0)
ffffffc050400694:	fe042703          	lw	a4,-32(s0)
ffffffc050400698:	fc843783          	ld	a5,-56(s0)
ffffffc05040069c:	779c                	ld	a5,40(a5)
ffffffc05040069e:	eef765e3          	bltu	a4,a5,ffffffc050400588 <load_elf+0x92>
ffffffc0504006a2:	fc645783          	lhu	a5,-58(s0)
ffffffc0504006a6:	fe843703          	ld	a4,-24(s0)
ffffffc0504006aa:	97ba                	add	a5,a5,a4
ffffffc0504006ac:	fef43423          	sd	a5,-24(s0)
ffffffc0504006b0:	fe645783          	lhu	a5,-26(s0)
ffffffc0504006b4:	fff7871b          	addiw	a4,a5,-1
ffffffc0504006b8:	fee41323          	sh	a4,-26(s0)
ffffffc0504006bc:	ea0798e3          	bnez	a5,ffffffc05040056c <load_elf+0x76>
ffffffc0504006c0:	fd043783          	ld	a5,-48(s0)
ffffffc0504006c4:	6f9c                	ld	a5,24(a5)
ffffffc0504006c6:	853e                	mv	a0,a5
ffffffc0504006c8:	70a6                	ld	ra,104(sp)
ffffffc0504006ca:	7406                	ld	s0,96(sp)
ffffffc0504006cc:	6165                	addi	sp,sp,112
ffffffc0504006ce:	8082                	ret

ffffffc0504006d0 <init_pcb_stack>:
ffffffc0504006d0:	715d                	addi	sp,sp,-80
ffffffc0504006d2:	e4a2                	sd	s0,72(sp)
ffffffc0504006d4:	0880                	addi	s0,sp,80
ffffffc0504006d6:	fca43423          	sd	a0,-56(s0)
ffffffc0504006da:	fcb43023          	sd	a1,-64(s0)
ffffffc0504006de:	fac43c23          	sd	a2,-72(s0)
ffffffc0504006e2:	fad43823          	sd	a3,-80(s0)
ffffffc0504006e6:	fc843783          	ld	a5,-56(s0)
ffffffc0504006ea:	ee078793          	addi	a5,a5,-288 # ee0 <_start-0xffffffc0503ff120>
ffffffc0504006ee:	fef43423          	sd	a5,-24(s0)
ffffffc0504006f2:	fe843783          	ld	a5,-24(s0)
ffffffc0504006f6:	fef43023          	sd	a5,-32(s0)
ffffffc0504006fa:	fe043783          	ld	a5,-32(s0)
ffffffc0504006fe:	fcf43c23          	sd	a5,-40(s0)
ffffffc050400702:	fd843783          	ld	a5,-40(s0)
ffffffc050400706:	0007b023          	sd	zero,0(a5)
ffffffc05040070a:	fd843783          	ld	a5,-40(s0)
ffffffc05040070e:	07a1                	addi	a5,a5,8
ffffffc050400710:	fb843703          	ld	a4,-72(s0)
ffffffc050400714:	e398                	sd	a4,0(a5)
ffffffc050400716:	fd843783          	ld	a5,-40(s0)
ffffffc05040071a:	07c1                	addi	a5,a5,16
ffffffc05040071c:	fe843703          	ld	a4,-24(s0)
ffffffc050400720:	e398                	sd	a4,0(a5)
ffffffc050400722:	fd843783          	ld	a5,-40(s0)
ffffffc050400726:	07e1                	addi	a5,a5,24
ffffffc050400728:	00018713          	mv	a4,gp
ffffffc05040072c:	e398                	sd	a4,0(a5)
ffffffc05040072e:	fd843783          	ld	a5,-40(s0)
ffffffc050400732:	02078793          	addi	a5,a5,32
ffffffc050400736:	0007b023          	sd	zero,0(a5)
ffffffc05040073a:	fd843783          	ld	a5,-40(s0)
ffffffc05040073e:	02878793          	addi	a5,a5,40
ffffffc050400742:	0007b023          	sd	zero,0(a5)
ffffffc050400746:	fd843783          	ld	a5,-40(s0)
ffffffc05040074a:	03078793          	addi	a5,a5,48
ffffffc05040074e:	0007b023          	sd	zero,0(a5)
ffffffc050400752:	fd843783          	ld	a5,-40(s0)
ffffffc050400756:	03878793          	addi	a5,a5,56
ffffffc05040075a:	0007b023          	sd	zero,0(a5)
ffffffc05040075e:	fd843783          	ld	a5,-40(s0)
ffffffc050400762:	04078793          	addi	a5,a5,64
ffffffc050400766:	0007b023          	sd	zero,0(a5)
ffffffc05040076a:	fd843783          	ld	a5,-40(s0)
ffffffc05040076e:	04878793          	addi	a5,a5,72
ffffffc050400772:	0007b023          	sd	zero,0(a5)
ffffffc050400776:	fd843783          	ld	a5,-40(s0)
ffffffc05040077a:	05078793          	addi	a5,a5,80
ffffffc05040077e:	0007b023          	sd	zero,0(a5)
ffffffc050400782:	fd843783          	ld	a5,-40(s0)
ffffffc050400786:	05878793          	addi	a5,a5,88
ffffffc05040078a:	0007b023          	sd	zero,0(a5)
ffffffc05040078e:	fd843783          	ld	a5,-40(s0)
ffffffc050400792:	06078793          	addi	a5,a5,96
ffffffc050400796:	0007b023          	sd	zero,0(a5)
ffffffc05040079a:	fd843783          	ld	a5,-40(s0)
ffffffc05040079e:	06878793          	addi	a5,a5,104
ffffffc0504007a2:	0007b023          	sd	zero,0(a5)
ffffffc0504007a6:	fd843783          	ld	a5,-40(s0)
ffffffc0504007aa:	07078793          	addi	a5,a5,112
ffffffc0504007ae:	0007b023          	sd	zero,0(a5)
ffffffc0504007b2:	fd843783          	ld	a5,-40(s0)
ffffffc0504007b6:	07878793          	addi	a5,a5,120
ffffffc0504007ba:	0007b023          	sd	zero,0(a5)
ffffffc0504007be:	fd843783          	ld	a5,-40(s0)
ffffffc0504007c2:	08078793          	addi	a5,a5,128
ffffffc0504007c6:	0007b023          	sd	zero,0(a5)
ffffffc0504007ca:	fd843783          	ld	a5,-40(s0)
ffffffc0504007ce:	08878793          	addi	a5,a5,136
ffffffc0504007d2:	0007b023          	sd	zero,0(a5)
ffffffc0504007d6:	fd843783          	ld	a5,-40(s0)
ffffffc0504007da:	09078793          	addi	a5,a5,144
ffffffc0504007de:	0007b023          	sd	zero,0(a5)
ffffffc0504007e2:	fd843783          	ld	a5,-40(s0)
ffffffc0504007e6:	09878793          	addi	a5,a5,152
ffffffc0504007ea:	0007b023          	sd	zero,0(a5)
ffffffc0504007ee:	fd843783          	ld	a5,-40(s0)
ffffffc0504007f2:	0a078793          	addi	a5,a5,160
ffffffc0504007f6:	0007b023          	sd	zero,0(a5)
ffffffc0504007fa:	fd843783          	ld	a5,-40(s0)
ffffffc0504007fe:	0a878793          	addi	a5,a5,168
ffffffc050400802:	0007b023          	sd	zero,0(a5)
ffffffc050400806:	fd843783          	ld	a5,-40(s0)
ffffffc05040080a:	0b078793          	addi	a5,a5,176
ffffffc05040080e:	0007b023          	sd	zero,0(a5)
ffffffc050400812:	fd843783          	ld	a5,-40(s0)
ffffffc050400816:	0b878793          	addi	a5,a5,184
ffffffc05040081a:	0007b023          	sd	zero,0(a5)
ffffffc05040081e:	fd843783          	ld	a5,-40(s0)
ffffffc050400822:	0c078793          	addi	a5,a5,192
ffffffc050400826:	0007b023          	sd	zero,0(a5)
ffffffc05040082a:	fd843783          	ld	a5,-40(s0)
ffffffc05040082e:	0c878793          	addi	a5,a5,200
ffffffc050400832:	0007b023          	sd	zero,0(a5)
ffffffc050400836:	fd843783          	ld	a5,-40(s0)
ffffffc05040083a:	0d078793          	addi	a5,a5,208
ffffffc05040083e:	0007b023          	sd	zero,0(a5)
ffffffc050400842:	fd843783          	ld	a5,-40(s0)
ffffffc050400846:	0d878793          	addi	a5,a5,216
ffffffc05040084a:	0007b023          	sd	zero,0(a5)
ffffffc05040084e:	fd843783          	ld	a5,-40(s0)
ffffffc050400852:	0e078793          	addi	a5,a5,224
ffffffc050400856:	0007b023          	sd	zero,0(a5)
ffffffc05040085a:	fd843783          	ld	a5,-40(s0)
ffffffc05040085e:	0e878793          	addi	a5,a5,232
ffffffc050400862:	0007b023          	sd	zero,0(a5)
ffffffc050400866:	fd843783          	ld	a5,-40(s0)
ffffffc05040086a:	0f078793          	addi	a5,a5,240
ffffffc05040086e:	0007b023          	sd	zero,0(a5)
ffffffc050400872:	fd843783          	ld	a5,-40(s0)
ffffffc050400876:	0f878793          	addi	a5,a5,248
ffffffc05040087a:	0007b023          	sd	zero,0(a5)
ffffffc05040087e:	fe043783          	ld	a5,-32(s0)
ffffffc050400882:	02000713          	li	a4,32
ffffffc050400886:	10e7b023          	sd	a4,256(a5)
ffffffc05040088a:	fe043783          	ld	a5,-32(s0)
ffffffc05040088e:	fb843703          	ld	a4,-72(s0)
ffffffc050400892:	10e7b423          	sd	a4,264(a5)
ffffffc050400896:	fe043783          	ld	a5,-32(s0)
ffffffc05040089a:	1007b823          	sd	zero,272(a5)
ffffffc05040089e:	fe043783          	ld	a5,-32(s0)
ffffffc0504008a2:	4721                	li	a4,8
ffffffc0504008a4:	10e7bc23          	sd	a4,280(a5)
ffffffc0504008a8:	fe843783          	ld	a5,-24(s0)
ffffffc0504008ac:	f9078793          	addi	a5,a5,-112
ffffffc0504008b0:	fef43423          	sd	a5,-24(s0)
ffffffc0504008b4:	fe843783          	ld	a5,-24(s0)
ffffffc0504008b8:	fcf43823          	sd	a5,-48(s0)
ffffffc0504008bc:	fd043783          	ld	a5,-48(s0)
ffffffc0504008c0:	fcf43c23          	sd	a5,-40(s0)
ffffffc0504008c4:	fd843783          	ld	a5,-40(s0)
ffffffc0504008c8:	fb843703          	ld	a4,-72(s0)
ffffffc0504008cc:	e398                	sd	a4,0(a5)
ffffffc0504008ce:	fd843783          	ld	a5,-40(s0)
ffffffc0504008d2:	07a1                	addi	a5,a5,8
ffffffc0504008d4:	fe843703          	ld	a4,-24(s0)
ffffffc0504008d8:	e398                	sd	a4,0(a5)
ffffffc0504008da:	fd843783          	ld	a5,-40(s0)
ffffffc0504008de:	07c1                	addi	a5,a5,16
ffffffc0504008e0:	0007b023          	sd	zero,0(a5)
ffffffc0504008e4:	fd843783          	ld	a5,-40(s0)
ffffffc0504008e8:	07e1                	addi	a5,a5,24
ffffffc0504008ea:	0007b023          	sd	zero,0(a5)
ffffffc0504008ee:	fd843783          	ld	a5,-40(s0)
ffffffc0504008f2:	02078793          	addi	a5,a5,32
ffffffc0504008f6:	0007b023          	sd	zero,0(a5)
ffffffc0504008fa:	fd843783          	ld	a5,-40(s0)
ffffffc0504008fe:	02878793          	addi	a5,a5,40
ffffffc050400902:	0007b023          	sd	zero,0(a5)
ffffffc050400906:	fd843783          	ld	a5,-40(s0)
ffffffc05040090a:	03078793          	addi	a5,a5,48
ffffffc05040090e:	0007b023          	sd	zero,0(a5)
ffffffc050400912:	fd843783          	ld	a5,-40(s0)
ffffffc050400916:	03878793          	addi	a5,a5,56
ffffffc05040091a:	0007b023          	sd	zero,0(a5)
ffffffc05040091e:	fd843783          	ld	a5,-40(s0)
ffffffc050400922:	04078793          	addi	a5,a5,64
ffffffc050400926:	0007b023          	sd	zero,0(a5)
ffffffc05040092a:	fd843783          	ld	a5,-40(s0)
ffffffc05040092e:	04878793          	addi	a5,a5,72
ffffffc050400932:	0007b023          	sd	zero,0(a5)
ffffffc050400936:	fd843783          	ld	a5,-40(s0)
ffffffc05040093a:	05078793          	addi	a5,a5,80
ffffffc05040093e:	0007b023          	sd	zero,0(a5)
ffffffc050400942:	fd843783          	ld	a5,-40(s0)
ffffffc050400946:	05878793          	addi	a5,a5,88
ffffffc05040094a:	0007b023          	sd	zero,0(a5)
ffffffc05040094e:	fd843783          	ld	a5,-40(s0)
ffffffc050400952:	06078793          	addi	a5,a5,96
ffffffc050400956:	0007b023          	sd	zero,0(a5)
ffffffc05040095a:	fd843783          	ld	a5,-40(s0)
ffffffc05040095e:	06878793          	addi	a5,a5,104
ffffffc050400962:	0007b023          	sd	zero,0(a5)
ffffffc050400966:	fb043783          	ld	a5,-80(s0)
ffffffc05040096a:	fe843703          	ld	a4,-24(s0)
ffffffc05040096e:	e398                	sd	a4,0(a5)
ffffffc050400970:	fb043783          	ld	a5,-80(s0)
ffffffc050400974:	fc043703          	ld	a4,-64(s0)
ffffffc050400978:	e798                	sd	a4,8(a5)
ffffffc05040097a:	0001                	nop
ffffffc05040097c:	6426                	ld	s0,72(sp)
ffffffc05040097e:	6161                	addi	sp,sp,80
ffffffc050400980:	8082                	ret

ffffffc050400982 <do_nothing>:
ffffffc050400982:	1141                	addi	sp,sp,-16
ffffffc050400984:	e422                	sd	s0,8(sp)
ffffffc050400986:	0800                	addi	s0,sp,16
ffffffc050400988:	0001                	nop
ffffffc05040098a:	6422                	ld	s0,8(sp)
ffffffc05040098c:	0141                	addi	sp,sp,16
ffffffc05040098e:	8082                	ret

ffffffc050400990 <init_free_page>:
ffffffc050400990:	1101                	addi	sp,sp,-32
ffffffc050400992:	ec22                	sd	s0,24(sp)
ffffffc050400994:	1000                	addi	s0,sp,32
ffffffc050400996:	fe042623          	sw	zero,-20(s0)
ffffffc05040099a:	a815                	j	ffffffc0504009ce <init_free_page+0x3e>
ffffffc05040099c:	00069717          	auipc	a4,0x69
ffffffc0504009a0:	0e470713          	addi	a4,a4,228 # ffffffc050469a80 <ph_page_array>
ffffffc0504009a4:	fec42783          	lw	a5,-20(s0)
ffffffc0504009a8:	0792                	slli	a5,a5,0x4
ffffffc0504009aa:	97ba                	add	a5,a5,a4
ffffffc0504009ac:	0007a023          	sw	zero,0(a5)
ffffffc0504009b0:	00069717          	auipc	a4,0x69
ffffffc0504009b4:	0d070713          	addi	a4,a4,208 # ffffffc050469a80 <ph_page_array>
ffffffc0504009b8:	fec42783          	lw	a5,-20(s0)
ffffffc0504009bc:	0792                	slli	a5,a5,0x4
ffffffc0504009be:	97ba                	add	a5,a5,a4
ffffffc0504009c0:	0007b423          	sd	zero,8(a5)
ffffffc0504009c4:	fec42783          	lw	a5,-20(s0)
ffffffc0504009c8:	2785                	addiw	a5,a5,1
ffffffc0504009ca:	fef42623          	sw	a5,-20(s0)
ffffffc0504009ce:	fec42783          	lw	a5,-20(s0)
ffffffc0504009d2:	0007871b          	sext.w	a4,a5
ffffffc0504009d6:	07f00793          	li	a5,127
ffffffc0504009da:	fce7d1e3          	bge	a5,a4,ffffffc05040099c <init_free_page+0xc>
ffffffc0504009de:	fe042423          	sw	zero,-24(s0)
ffffffc0504009e2:	a005                	j	ffffffc050400a02 <init_free_page+0x72>
ffffffc0504009e4:	00061717          	auipc	a4,0x61
ffffffc0504009e8:	10c70713          	addi	a4,a4,268 # ffffffc050461af0 <page_tab_array>
ffffffc0504009ec:	fe842783          	lw	a5,-24(s0)
ffffffc0504009f0:	078a                	slli	a5,a5,0x2
ffffffc0504009f2:	97ba                	add	a5,a5,a4
ffffffc0504009f4:	0007a023          	sw	zero,0(a5)
ffffffc0504009f8:	fe842783          	lw	a5,-24(s0)
ffffffc0504009fc:	2785                	addiw	a5,a5,1
ffffffc0504009fe:	fef42423          	sw	a5,-24(s0)
ffffffc050400a02:	fe842783          	lw	a5,-24(s0)
ffffffc050400a06:	0007871b          	sext.w	a4,a5
ffffffc050400a0a:	6789                	lui	a5,0x2
ffffffc050400a0c:	f3f78793          	addi	a5,a5,-193 # 1f3f <_start-0xffffffc0503fe0c1>
ffffffc050400a10:	fce7dae3          	bge	a5,a4,ffffffc0504009e4 <init_free_page+0x54>
ffffffc050400a14:	fe042223          	sw	zero,-28(s0)
ffffffc050400a18:	a005                	j	ffffffc050400a38 <init_free_page+0xa8>
ffffffc050400a1a:	0006a717          	auipc	a4,0x6a
ffffffc050400a1e:	86670713          	addi	a4,a4,-1946 # ffffffc05046a280 <swap_page_array>
ffffffc050400a22:	fe442783          	lw	a5,-28(s0)
ffffffc050400a26:	078a                	slli	a5,a5,0x2
ffffffc050400a28:	97ba                	add	a5,a5,a4
ffffffc050400a2a:	0007a023          	sw	zero,0(a5)
ffffffc050400a2e:	fe442783          	lw	a5,-28(s0)
ffffffc050400a32:	2785                	addiw	a5,a5,1
ffffffc050400a34:	fef42223          	sw	a5,-28(s0)
ffffffc050400a38:	fe442783          	lw	a5,-28(s0)
ffffffc050400a3c:	0007871b          	sext.w	a4,a5
ffffffc050400a40:	6789                	lui	a5,0x2
ffffffc050400a42:	fcf74ce3          	blt	a4,a5,ffffffc050400a1a <init_free_page+0x8a>
ffffffc050400a46:	0001                	nop
ffffffc050400a48:	0001                	nop
ffffffc050400a4a:	6462                	ld	s0,24(sp)
ffffffc050400a4c:	6105                	addi	sp,sp,32
ffffffc050400a4e:	8082                	ret

ffffffc050400a50 <init_pcb>:
ffffffc050400a50:	711d                	addi	sp,sp,-96
ffffffc050400a52:	ec86                	sd	ra,88(sp)
ffffffc050400a54:	e8a2                	sd	s0,80(sp)
ffffffc050400a56:	1080                	addi	s0,sp,96
ffffffc050400a58:	00007797          	auipc	a5,0x7
ffffffc050400a5c:	94878793          	addi	a5,a5,-1720 # ffffffc0504073a0 <pid0_pcb_core0>
ffffffc050400a60:	470d                	li	a4,3
ffffffc050400a62:	cff8                	sw	a4,92(a5)
ffffffc050400a64:	00007797          	auipc	a5,0x7
ffffffc050400a68:	9d478793          	addi	a5,a5,-1580 # ffffffc050407438 <pid0_pcb_core1>
ffffffc050400a6c:	470d                	li	a4,3
ffffffc050400a6e:	cff8                	sw	a4,92(a5)
ffffffc050400a70:	1e0007b7          	lui	a5,0x1e000
ffffffc050400a74:	1ff78793          	addi	a5,a5,511 # 1e0001ff <_start-0xffffffc0323ffe01>
ffffffc050400a78:	079e                	slli	a5,a5,0x7
ffffffc050400a7a:	fef43023          	sd	a5,-32(s0)
ffffffc050400a7e:	6505                	lui	a0,0x1
ffffffc050400a80:	119040ef          	jal	ra,ffffffc050405398 <kmalloc>
ffffffc050400a84:	87aa                	mv	a5,a0
ffffffc050400a86:	873e                	mv	a4,a5
ffffffc050400a88:	6785                	lui	a5,0x1
ffffffc050400a8a:	97ba                	add	a5,a5,a4
ffffffc050400a8c:	fcf43c23          	sd	a5,-40(s0)
ffffffc050400a90:	00072797          	auipc	a5,0x72
ffffffc050400a94:	42878793          	addi	a5,a5,1064 # ffffffc050472eb8 <pcb>
ffffffc050400a98:	fd843703          	ld	a4,-40(s0)
ffffffc050400a9c:	ffb8                	sd	a4,120(a5)
ffffffc050400a9e:	00072797          	auipc	a5,0x72
ffffffc050400aa2:	41a78793          	addi	a5,a5,1050 # ffffffc050472eb8 <pcb>
ffffffc050400aa6:	fd843703          	ld	a4,-40(s0)
ffffffc050400aaa:	e398                	sd	a4,0(a5)
ffffffc050400aac:	6505                	lui	a0,0x1
ffffffc050400aae:	0eb040ef          	jal	ra,ffffffc050405398 <kmalloc>
ffffffc050400ab2:	87aa                	mv	a5,a0
ffffffc050400ab4:	873e                	mv	a4,a5
ffffffc050400ab6:	6785                	lui	a5,0x1
ffffffc050400ab8:	97ba                	add	a5,a5,a4
ffffffc050400aba:	fcf43c23          	sd	a5,-40(s0)
ffffffc050400abe:	00072797          	auipc	a5,0x72
ffffffc050400ac2:	3fa78793          	addi	a5,a5,1018 # ffffffc050472eb8 <pcb>
ffffffc050400ac6:	fd843703          	ld	a4,-40(s0)
ffffffc050400aca:	e3d8                	sd	a4,128(a5)
ffffffc050400acc:	00072797          	auipc	a5,0x72
ffffffc050400ad0:	3ec78793          	addi	a5,a5,1004 # ffffffc050472eb8 <pcb>
ffffffc050400ad4:	fd843703          	ld	a4,-40(s0)
ffffffc050400ad8:	e798                	sd	a4,8(a5)
ffffffc050400ada:	00072797          	auipc	a5,0x72
ffffffc050400ade:	3de78793          	addi	a5,a5,990 # ffffffc050472eb8 <pcb>
ffffffc050400ae2:	0007b823          	sd	zero,16(a5)
ffffffc050400ae6:	00072797          	auipc	a5,0x72
ffffffc050400aea:	3d278793          	addi	a5,a5,978 # ffffffc050472eb8 <pcb>
ffffffc050400aee:	0407a823          	sw	zero,80(a5)
ffffffc050400af2:	00072797          	auipc	a5,0x72
ffffffc050400af6:	3c678793          	addi	a5,a5,966 # ffffffc050472eb8 <pcb>
ffffffc050400afa:	4705                	li	a4,1
ffffffc050400afc:	cbf8                	sw	a4,84(a5)
ffffffc050400afe:	00072797          	auipc	a5,0x72
ffffffc050400b02:	3ba78793          	addi	a5,a5,954 # ffffffc050472eb8 <pcb>
ffffffc050400b06:	0407ac23          	sw	zero,88(a5)
ffffffc050400b0a:	00072797          	auipc	a5,0x72
ffffffc050400b0e:	3ae78793          	addi	a5,a5,942 # ffffffc050472eb8 <pcb>
ffffffc050400b12:	470d                	li	a4,3
ffffffc050400b14:	cff8                	sw	a4,92(a5)
ffffffc050400b16:	00072797          	auipc	a5,0x72
ffffffc050400b1a:	3a278793          	addi	a5,a5,930 # ffffffc050472eb8 <pcb>
ffffffc050400b1e:	0807a423          	sw	zero,136(a5)
ffffffc050400b22:	00072797          	auipc	a5,0x72
ffffffc050400b26:	39678793          	addi	a5,a5,918 # ffffffc050472eb8 <pcb>
ffffffc050400b2a:	0807a623          	sw	zero,140(a5)
ffffffc050400b2e:	00072797          	auipc	a5,0x72
ffffffc050400b32:	38a78793          	addi	a5,a5,906 # ffffffc050472eb8 <pcb>
ffffffc050400b36:	0607b423          	sd	zero,104(a5)
ffffffc050400b3a:	00072797          	auipc	a5,0x72
ffffffc050400b3e:	37e78793          	addi	a5,a5,894 # ffffffc050472eb8 <pcb>
ffffffc050400b42:	0607a023          	sw	zero,96(a5)
ffffffc050400b46:	00072797          	auipc	a5,0x72
ffffffc050400b4a:	37278793          	addi	a5,a5,882 # ffffffc050472eb8 <pcb>
ffffffc050400b4e:	5e000737          	lui	a4,0x5e000
ffffffc050400b52:	ebd8                	sd	a4,144(a5)
ffffffc050400b54:	00072797          	auipc	a5,0x72
ffffffc050400b58:	36478793          	addi	a5,a5,868 # ffffffc050472eb8 <pcb>
ffffffc050400b5c:	00072717          	auipc	a4,0x72
ffffffc050400b60:	31c70713          	addi	a4,a4,796 # ffffffc050472e78 <ready_queue>
ffffffc050400b64:	e7b8                	sd	a4,72(a5)
ffffffc050400b66:	00072797          	auipc	a5,0x72
ffffffc050400b6a:	35278793          	addi	a5,a5,850 # ffffffc050472eb8 <pcb>
ffffffc050400b6e:	6398                	ld	a4,0(a5)
ffffffc050400b70:	00072797          	auipc	a5,0x72
ffffffc050400b74:	34878793          	addi	a5,a5,840 # ffffffc050472eb8 <pcb>
ffffffc050400b78:	679c                	ld	a5,8(a5)
ffffffc050400b7a:	00000617          	auipc	a2,0x0
ffffffc050400b7e:	e0860613          	addi	a2,a2,-504 # ffffffc050400982 <do_nothing>
ffffffc050400b82:	00072697          	auipc	a3,0x72
ffffffc050400b86:	33668693          	addi	a3,a3,822 # ffffffc050472eb8 <pcb>
ffffffc050400b8a:	85be                	mv	a1,a5
ffffffc050400b8c:	853a                	mv	a0,a4
ffffffc050400b8e:	b43ff0ef          	jal	ra,ffffffc0504006d0 <init_pcb_stack>
ffffffc050400b92:	6505                	lui	a0,0x1
ffffffc050400b94:	005040ef          	jal	ra,ffffffc050405398 <kmalloc>
ffffffc050400b98:	87aa                	mv	a5,a0
ffffffc050400b9a:	873e                	mv	a4,a5
ffffffc050400b9c:	6785                	lui	a5,0x1
ffffffc050400b9e:	97ba                	add	a5,a5,a4
ffffffc050400ba0:	fcf43c23          	sd	a5,-40(s0)
ffffffc050400ba4:	00072797          	auipc	a5,0x72
ffffffc050400ba8:	31478793          	addi	a5,a5,788 # ffffffc050472eb8 <pcb>
ffffffc050400bac:	fd843703          	ld	a4,-40(s0)
ffffffc050400bb0:	10e7b823          	sd	a4,272(a5)
ffffffc050400bb4:	00072797          	auipc	a5,0x72
ffffffc050400bb8:	30478793          	addi	a5,a5,772 # ffffffc050472eb8 <pcb>
ffffffc050400bbc:	fd843703          	ld	a4,-40(s0)
ffffffc050400bc0:	efd8                	sd	a4,152(a5)
ffffffc050400bc2:	00072797          	auipc	a5,0x72
ffffffc050400bc6:	2f678793          	addi	a5,a5,758 # ffffffc050472eb8 <pcb>
ffffffc050400bca:	fe043703          	ld	a4,-32(s0)
ffffffc050400bce:	10e7bc23          	sd	a4,280(a5)
ffffffc050400bd2:	00072797          	auipc	a5,0x72
ffffffc050400bd6:	2e678793          	addi	a5,a5,742 # ffffffc050472eb8 <pcb>
ffffffc050400bda:	fe043703          	ld	a4,-32(s0)
ffffffc050400bde:	f3d8                	sd	a4,160(a5)
ffffffc050400be0:	00072797          	auipc	a5,0x72
ffffffc050400be4:	2d878793          	addi	a5,a5,728 # ffffffc050472eb8 <pcb>
ffffffc050400be8:	0a07b423          	sd	zero,168(a5)
ffffffc050400bec:	00072797          	auipc	a5,0x72
ffffffc050400bf0:	2cc78793          	addi	a5,a5,716 # ffffffc050472eb8 <pcb>
ffffffc050400bf4:	4705                	li	a4,1
ffffffc050400bf6:	0ee7a423          	sw	a4,232(a5)
ffffffc050400bfa:	00072797          	auipc	a5,0x72
ffffffc050400bfe:	2be78793          	addi	a5,a5,702 # ffffffc050472eb8 <pcb>
ffffffc050400c02:	0e07a623          	sw	zero,236(a5)
ffffffc050400c06:	00072797          	auipc	a5,0x72
ffffffc050400c0a:	2b278793          	addi	a5,a5,690 # ffffffc050472eb8 <pcb>
ffffffc050400c0e:	4709                	li	a4,2
ffffffc050400c10:	0ee7a823          	sw	a4,240(a5)
ffffffc050400c14:	00072797          	auipc	a5,0x72
ffffffc050400c18:	2a478793          	addi	a5,a5,676 # ffffffc050472eb8 <pcb>
ffffffc050400c1c:	470d                	li	a4,3
ffffffc050400c1e:	0ee7aa23          	sw	a4,244(a5)
ffffffc050400c22:	00072797          	auipc	a5,0x72
ffffffc050400c26:	29678793          	addi	a5,a5,662 # ffffffc050472eb8 <pcb>
ffffffc050400c2a:	1207a023          	sw	zero,288(a5)
ffffffc050400c2e:	00072797          	auipc	a5,0x72
ffffffc050400c32:	28a78793          	addi	a5,a5,650 # ffffffc050472eb8 <pcb>
ffffffc050400c36:	1207a223          	sw	zero,292(a5)
ffffffc050400c3a:	00072797          	auipc	a5,0x72
ffffffc050400c3e:	27e78793          	addi	a5,a5,638 # ffffffc050472eb8 <pcb>
ffffffc050400c42:	1007b023          	sd	zero,256(a5)
ffffffc050400c46:	00072797          	auipc	a5,0x72
ffffffc050400c4a:	27278793          	addi	a5,a5,626 # ffffffc050472eb8 <pcb>
ffffffc050400c4e:	0e07ac23          	sw	zero,248(a5)
ffffffc050400c52:	00072797          	auipc	a5,0x72
ffffffc050400c56:	26678793          	addi	a5,a5,614 # ffffffc050472eb8 <pcb>
ffffffc050400c5a:	00072717          	auipc	a4,0x72
ffffffc050400c5e:	21e70713          	addi	a4,a4,542 # ffffffc050472e78 <ready_queue>
ffffffc050400c62:	f3f8                	sd	a4,224(a5)
ffffffc050400c64:	fac40713          	addi	a4,s0,-84
ffffffc050400c68:	fb040793          	addi	a5,s0,-80
ffffffc050400c6c:	863a                	mv	a2,a4
ffffffc050400c6e:	85be                	mv	a1,a5
ffffffc050400c70:	00006517          	auipc	a0,0x6
ffffffc050400c74:	11850513          	addi	a0,a0,280 # ffffffc050406d88 <get_elf_file+0xa8>
ffffffc050400c78:	068060ef          	jal	ra,ffffffc050406ce0 <get_elf_file>
ffffffc050400c7c:	fac42783          	lw	a5,-84(s0)
ffffffc050400c80:	853e                	mv	a0,a5
ffffffc050400c82:	2cd040ef          	jal	ra,ffffffc05040574e <alloc_uvm>
ffffffc050400c86:	fca43823          	sd	a0,-48(s0)
ffffffc050400c8a:	fd043503          	ld	a0,-48(s0)
ffffffc050400c8e:	13e050ef          	jal	ra,ffffffc050405dcc <map_kvm>
ffffffc050400c92:	00072797          	auipc	a5,0x72
ffffffc050400c96:	22678793          	addi	a5,a5,550 # ffffffc050472eb8 <pcb>
ffffffc050400c9a:	fd043703          	ld	a4,-48(s0)
ffffffc050400c9e:	12e7b423          	sd	a4,296(a5)
ffffffc050400ca2:	fb043703          	ld	a4,-80(s0)
ffffffc050400ca6:	fac42583          	lw	a1,-84(s0)
ffffffc050400caa:	00072797          	auipc	a5,0x72
ffffffc050400cae:	20e78793          	addi	a5,a5,526 # ffffffc050472eb8 <pcb>
ffffffc050400cb2:	1287b783          	ld	a5,296(a5)
ffffffc050400cb6:	fffff697          	auipc	a3,0xfffff
ffffffc050400cba:	71868693          	addi	a3,a3,1816 # ffffffc0504003ce <get_kva_of>
ffffffc050400cbe:	863e                	mv	a2,a5
ffffffc050400cc0:	853a                	mv	a0,a4
ffffffc050400cc2:	835ff0ef          	jal	ra,ffffffc0504004f6 <load_elf>
ffffffc050400cc6:	fca43423          	sd	a0,-56(s0)
ffffffc050400cca:	00072697          	auipc	a3,0x72
ffffffc050400cce:	28668693          	addi	a3,a3,646 # ffffffc050472f50 <pcb+0x98>
ffffffc050400cd2:	fc843603          	ld	a2,-56(s0)
ffffffc050400cd6:	fe043583          	ld	a1,-32(s0)
ffffffc050400cda:	fd843503          	ld	a0,-40(s0)
ffffffc050400cde:	9f3ff0ef          	jal	ra,ffffffc0504006d0 <init_pcb_stack>
ffffffc050400ce2:	00072797          	auipc	a5,0x72
ffffffc050400ce6:	1ee78793          	addi	a5,a5,494 # ffffffc050472ed0 <pcb+0x18>
ffffffc050400cea:	fcf43023          	sd	a5,-64(s0)
ffffffc050400cee:	00072797          	auipc	a5,0x72
ffffffc050400cf2:	27a78793          	addi	a5,a5,634 # ffffffc050472f68 <pcb+0xb0>
ffffffc050400cf6:	faf43c23          	sd	a5,-72(s0)
ffffffc050400cfa:	fc043783          	ld	a5,-64(s0)
ffffffc050400cfe:	0007a023          	sw	zero,0(a5)
ffffffc050400d02:	fb843783          	ld	a5,-72(s0)
ffffffc050400d06:	4705                	li	a4,1
ffffffc050400d08:	c398                	sw	a4,0(a5)
ffffffc050400d0a:	00072797          	auipc	a5,0x72
ffffffc050400d0e:	16e78793          	addi	a5,a5,366 # ffffffc050472e78 <ready_queue>
ffffffc050400d12:	fc043703          	ld	a4,-64(s0)
ffffffc050400d16:	e798                	sd	a4,8(a5)
ffffffc050400d18:	fc043783          	ld	a5,-64(s0)
ffffffc050400d1c:	00072717          	auipc	a4,0x72
ffffffc050400d20:	15c70713          	addi	a4,a4,348 # ffffffc050472e78 <ready_queue>
ffffffc050400d24:	eb98                	sd	a4,16(a5)
ffffffc050400d26:	fc043783          	ld	a5,-64(s0)
ffffffc050400d2a:	fb843703          	ld	a4,-72(s0)
ffffffc050400d2e:	e798                	sd	a4,8(a5)
ffffffc050400d30:	fb843783          	ld	a5,-72(s0)
ffffffc050400d34:	fc043703          	ld	a4,-64(s0)
ffffffc050400d38:	eb98                	sd	a4,16(a5)
ffffffc050400d3a:	fb843783          	ld	a5,-72(s0)
ffffffc050400d3e:	0007b423          	sd	zero,8(a5)
ffffffc050400d42:	00072797          	auipc	a5,0x72
ffffffc050400d46:	13678793          	addi	a5,a5,310 # ffffffc050472e78 <ready_queue>
ffffffc050400d4a:	fb843703          	ld	a4,-72(s0)
ffffffc050400d4e:	eb98                	sd	a4,16(a5)
ffffffc050400d50:	00072797          	auipc	a5,0x72
ffffffc050400d54:	12878793          	addi	a5,a5,296 # ffffffc050472e78 <ready_queue>
ffffffc050400d58:	4709                	li	a4,2
ffffffc050400d5a:	c398                	sw	a4,0(a5)
ffffffc050400d5c:	81818793          	addi	a5,gp,-2024 # ffffffc05045f8d0 <process_id>
ffffffc050400d60:	4709                	li	a4,2
ffffffc050400d62:	c398                	sw	a4,0(a5)
ffffffc050400d64:	00072797          	auipc	a5,0x72
ffffffc050400d68:	12c78793          	addi	a5,a5,300 # ffffffc050472e90 <current_running>
ffffffc050400d6c:	00006717          	auipc	a4,0x6
ffffffc050400d70:	63470713          	addi	a4,a4,1588 # ffffffc0504073a0 <pid0_pcb_core0>
ffffffc050400d74:	e398                	sd	a4,0(a5)
ffffffc050400d76:	00072797          	auipc	a5,0x72
ffffffc050400d7a:	11a78793          	addi	a5,a5,282 # ffffffc050472e90 <current_running>
ffffffc050400d7e:	00006717          	auipc	a4,0x6
ffffffc050400d82:	6ba70713          	addi	a4,a4,1722 # ffffffc050407438 <pid0_pcb_core1>
ffffffc050400d86:	e798                	sd	a4,8(a5)
ffffffc050400d88:	4789                	li	a5,2
ffffffc050400d8a:	fef42623          	sw	a5,-20(s0)
ffffffc050400d8e:	a8f1                	j	ffffffc050400e6a <init_pcb+0x41a>
ffffffc050400d90:	6505                	lui	a0,0x1
ffffffc050400d92:	606040ef          	jal	ra,ffffffc050405398 <kmalloc>
ffffffc050400d96:	87aa                	mv	a5,a0
ffffffc050400d98:	873e                	mv	a4,a5
ffffffc050400d9a:	6785                	lui	a5,0x1
ffffffc050400d9c:	97ba                	add	a5,a5,a4
ffffffc050400d9e:	fcf43c23          	sd	a5,-40(s0)
ffffffc050400da2:	00072717          	auipc	a4,0x72
ffffffc050400da6:	11670713          	addi	a4,a4,278 # ffffffc050472eb8 <pcb>
ffffffc050400daa:	fec42683          	lw	a3,-20(s0)
ffffffc050400dae:	09800793          	li	a5,152
ffffffc050400db2:	02f687b3          	mul	a5,a3,a5
ffffffc050400db6:	97ba                	add	a5,a5,a4
ffffffc050400db8:	fd843703          	ld	a4,-40(s0)
ffffffc050400dbc:	ffb8                	sd	a4,120(a5)
ffffffc050400dbe:	00072717          	auipc	a4,0x72
ffffffc050400dc2:	0fa70713          	addi	a4,a4,250 # ffffffc050472eb8 <pcb>
ffffffc050400dc6:	fec42683          	lw	a3,-20(s0)
ffffffc050400dca:	09800793          	li	a5,152
ffffffc050400dce:	02f687b3          	mul	a5,a3,a5
ffffffc050400dd2:	97ba                	add	a5,a5,a4
ffffffc050400dd4:	fd843703          	ld	a4,-40(s0)
ffffffc050400dd8:	e398                	sd	a4,0(a5)
ffffffc050400dda:	00072717          	auipc	a4,0x72
ffffffc050400dde:	0de70713          	addi	a4,a4,222 # ffffffc050472eb8 <pcb>
ffffffc050400de2:	fec42683          	lw	a3,-20(s0)
ffffffc050400de6:	09800793          	li	a5,152
ffffffc050400dea:	02f687b3          	mul	a5,a3,a5
ffffffc050400dee:	97ba                	add	a5,a5,a4
ffffffc050400df0:	fe043703          	ld	a4,-32(s0)
ffffffc050400df4:	e3d8                	sd	a4,128(a5)
ffffffc050400df6:	00072717          	auipc	a4,0x72
ffffffc050400dfa:	0c270713          	addi	a4,a4,194 # ffffffc050472eb8 <pcb>
ffffffc050400dfe:	fec42683          	lw	a3,-20(s0)
ffffffc050400e02:	09800793          	li	a5,152
ffffffc050400e06:	02f687b3          	mul	a5,a3,a5
ffffffc050400e0a:	97ba                	add	a5,a5,a4
ffffffc050400e0c:	fe043703          	ld	a4,-32(s0)
ffffffc050400e10:	e798                	sd	a4,8(a5)
ffffffc050400e12:	00072717          	auipc	a4,0x72
ffffffc050400e16:	0a670713          	addi	a4,a4,166 # ffffffc050472eb8 <pcb>
ffffffc050400e1a:	fec42683          	lw	a3,-20(s0)
ffffffc050400e1e:	09800793          	li	a5,152
ffffffc050400e22:	02f687b3          	mul	a5,a3,a5
ffffffc050400e26:	97ba                	add	a5,a5,a4
ffffffc050400e28:	4709                	li	a4,2
ffffffc050400e2a:	cfb8                	sw	a4,88(a5)
ffffffc050400e2c:	00072717          	auipc	a4,0x72
ffffffc050400e30:	08c70713          	addi	a4,a4,140 # ffffffc050472eb8 <pcb>
ffffffc050400e34:	fec42683          	lw	a3,-20(s0)
ffffffc050400e38:	09800793          	li	a5,152
ffffffc050400e3c:	02f687b3          	mul	a5,a3,a5
ffffffc050400e40:	97ba                	add	a5,a5,a4
ffffffc050400e42:	0407ae23          	sw	zero,92(a5) # 105c <_start-0xffffffc0503fefa4>
ffffffc050400e46:	00072717          	auipc	a4,0x72
ffffffc050400e4a:	07270713          	addi	a4,a4,114 # ffffffc050472eb8 <pcb>
ffffffc050400e4e:	fec42683          	lw	a3,-20(s0)
ffffffc050400e52:	09800793          	li	a5,152
ffffffc050400e56:	02f687b3          	mul	a5,a3,a5
ffffffc050400e5a:	97ba                	add	a5,a5,a4
ffffffc050400e5c:	577d                	li	a4,-1
ffffffc050400e5e:	cbf8                	sw	a4,84(a5)
ffffffc050400e60:	fec42783          	lw	a5,-20(s0)
ffffffc050400e64:	2785                	addiw	a5,a5,1
ffffffc050400e66:	fef42623          	sw	a5,-20(s0)
ffffffc050400e6a:	fec42783          	lw	a5,-20(s0)
ffffffc050400e6e:	0007871b          	sext.w	a4,a5
ffffffc050400e72:	47fd                	li	a5,31
ffffffc050400e74:	f0e7dee3          	bge	a5,a4,ffffffc050400d90 <init_pcb+0x340>
ffffffc050400e78:	0001                	nop
ffffffc050400e7a:	0001                	nop
ffffffc050400e7c:	60e6                	ld	ra,88(sp)
ffffffc050400e7e:	6446                	ld	s0,80(sp)
ffffffc050400e80:	6125                	addi	sp,sp,96
ffffffc050400e82:	8082                	ret

ffffffc050400e84 <print_syscall>:
ffffffc050400e84:	7179                	addi	sp,sp,-48
ffffffc050400e86:	f406                	sd	ra,40(sp)
ffffffc050400e88:	f022                	sd	s0,32(sp)
ffffffc050400e8a:	1800                	addi	s0,sp,48
ffffffc050400e8c:	fea43423          	sd	a0,-24(s0)
ffffffc050400e90:	feb43023          	sd	a1,-32(s0)
ffffffc050400e94:	fcc43c23          	sd	a2,-40(s0)
ffffffc050400e98:	fd843683          	ld	a3,-40(s0)
ffffffc050400e9c:	fe043603          	ld	a2,-32(s0)
ffffffc050400ea0:	fe843583          	ld	a1,-24(s0)
ffffffc050400ea4:	00006517          	auipc	a0,0x6
ffffffc050400ea8:	eec50513          	addi	a0,a0,-276 # ffffffc050406d90 <get_elf_file+0xb0>
ffffffc050400eac:	555050ef          	jal	ra,ffffffc050406c00 <printk>
ffffffc050400eb0:	0001                	nop
ffffffc050400eb2:	70a2                	ld	ra,40(sp)
ffffffc050400eb4:	7402                	ld	s0,32(sp)
ffffffc050400eb6:	6145                	addi	sp,sp,48
ffffffc050400eb8:	8082                	ret

ffffffc050400eba <do_process_show>:
ffffffc050400eba:	1101                	addi	sp,sp,-32
ffffffc050400ebc:	ec06                	sd	ra,24(sp)
ffffffc050400ebe:	e822                	sd	s0,16(sp)
ffffffc050400ec0:	1000                	addi	s0,sp,32
ffffffc050400ec2:	00006517          	auipc	a0,0x6
ffffffc050400ec6:	efe50513          	addi	a0,a0,-258 # ffffffc050406dc0 <get_elf_file+0xe0>
ffffffc050400eca:	5bf050ef          	jal	ra,ffffffc050406c88 <prints>
ffffffc050400ece:	fe042623          	sw	zero,-20(s0)
ffffffc050400ed2:	aa0d                	j	ffffffc050401004 <do_process_show+0x14a>
ffffffc050400ed4:	00072717          	auipc	a4,0x72
ffffffc050400ed8:	fe470713          	addi	a4,a4,-28 # ffffffc050472eb8 <pcb>
ffffffc050400edc:	fec42683          	lw	a3,-20(s0)
ffffffc050400ee0:	09800793          	li	a5,152
ffffffc050400ee4:	02f687b3          	mul	a5,a3,a5
ffffffc050400ee8:	97ba                	add	a5,a5,a4
ffffffc050400eea:	4ffc                	lw	a5,92(a5)
ffffffc050400eec:	fef42423          	sw	a5,-24(s0)
ffffffc050400ef0:	fe842783          	lw	a5,-24(s0)
ffffffc050400ef4:	2781                	sext.w	a5,a5
ffffffc050400ef6:	10078163          	beqz	a5,ffffffc050400ff8 <do_process_show+0x13e>
ffffffc050400efa:	00072717          	auipc	a4,0x72
ffffffc050400efe:	fbe70713          	addi	a4,a4,-66 # ffffffc050472eb8 <pcb>
ffffffc050400f02:	fec42683          	lw	a3,-20(s0)
ffffffc050400f06:	09800793          	li	a5,152
ffffffc050400f0a:	02f687b3          	mul	a5,a3,a5
ffffffc050400f0e:	97ba                	add	a5,a5,a4
ffffffc050400f10:	4bb8                	lw	a4,80(a5)
ffffffc050400f12:	fec42783          	lw	a5,-20(s0)
ffffffc050400f16:	863a                	mv	a2,a4
ffffffc050400f18:	85be                	mv	a1,a5
ffffffc050400f1a:	00006517          	auipc	a0,0x6
ffffffc050400f1e:	ebe50513          	addi	a0,a0,-322 # ffffffc050406dd8 <get_elf_file+0xf8>
ffffffc050400f22:	567050ef          	jal	ra,ffffffc050406c88 <prints>
ffffffc050400f26:	fe842783          	lw	a5,-24(s0)
ffffffc050400f2a:	0007871b          	sext.w	a4,a5
ffffffc050400f2e:	4785                	li	a5,1
ffffffc050400f30:	00f71963          	bne	a4,a5,ffffffc050400f42 <do_process_show+0x88>
ffffffc050400f34:	00006517          	auipc	a0,0x6
ffffffc050400f38:	ebc50513          	addi	a0,a0,-324 # ffffffc050406df0 <get_elf_file+0x110>
ffffffc050400f3c:	54d050ef          	jal	ra,ffffffc050406c88 <prints>
ffffffc050400f40:	a891                	j	ffffffc050400f94 <do_process_show+0xda>
ffffffc050400f42:	fe842783          	lw	a5,-24(s0)
ffffffc050400f46:	0007871b          	sext.w	a4,a5
ffffffc050400f4a:	4789                	li	a5,2
ffffffc050400f4c:	00f71963          	bne	a4,a5,ffffffc050400f5e <do_process_show+0xa4>
ffffffc050400f50:	00006517          	auipc	a0,0x6
ffffffc050400f54:	ea850513          	addi	a0,a0,-344 # ffffffc050406df8 <get_elf_file+0x118>
ffffffc050400f58:	531050ef          	jal	ra,ffffffc050406c88 <prints>
ffffffc050400f5c:	a825                	j	ffffffc050400f94 <do_process_show+0xda>
ffffffc050400f5e:	fe842783          	lw	a5,-24(s0)
ffffffc050400f62:	0007871b          	sext.w	a4,a5
ffffffc050400f66:	478d                	li	a5,3
ffffffc050400f68:	00f71963          	bne	a4,a5,ffffffc050400f7a <do_process_show+0xc0>
ffffffc050400f6c:	00006517          	auipc	a0,0x6
ffffffc050400f70:	e9450513          	addi	a0,a0,-364 # ffffffc050406e00 <get_elf_file+0x120>
ffffffc050400f74:	515050ef          	jal	ra,ffffffc050406c88 <prints>
ffffffc050400f78:	a831                	j	ffffffc050400f94 <do_process_show+0xda>
ffffffc050400f7a:	fe842783          	lw	a5,-24(s0)
ffffffc050400f7e:	0007871b          	sext.w	a4,a5
ffffffc050400f82:	4791                	li	a5,4
ffffffc050400f84:	00f71863          	bne	a4,a5,ffffffc050400f94 <do_process_show+0xda>
ffffffc050400f88:	00006517          	auipc	a0,0x6
ffffffc050400f8c:	e8050513          	addi	a0,a0,-384 # ffffffc050406e08 <get_elf_file+0x128>
ffffffc050400f90:	4f9050ef          	jal	ra,ffffffc050406c88 <prints>
ffffffc050400f94:	00072717          	auipc	a4,0x72
ffffffc050400f98:	f2470713          	addi	a4,a4,-220 # ffffffc050472eb8 <pcb>
ffffffc050400f9c:	fec42683          	lw	a3,-20(s0)
ffffffc050400fa0:	09800793          	li	a5,152
ffffffc050400fa4:	02f687b3          	mul	a5,a3,a5
ffffffc050400fa8:	97ba                	add	a5,a5,a4
ffffffc050400faa:	4bfc                	lw	a5,84(a5)
ffffffc050400fac:	fef42223          	sw	a5,-28(s0)
ffffffc050400fb0:	00006517          	auipc	a0,0x6
ffffffc050400fb4:	e6050513          	addi	a0,a0,-416 # ffffffc050406e10 <get_elf_file+0x130>
ffffffc050400fb8:	4d1050ef          	jal	ra,ffffffc050406c88 <prints>
ffffffc050400fbc:	fe442783          	lw	a5,-28(s0)
ffffffc050400fc0:	0007871b          	sext.w	a4,a5
ffffffc050400fc4:	57fd                	li	a5,-1
ffffffc050400fc6:	00f71963          	bne	a4,a5,ffffffc050400fd8 <do_process_show+0x11e>
ffffffc050400fca:	00006517          	auipc	a0,0x6
ffffffc050400fce:	e5650513          	addi	a0,a0,-426 # ffffffc050406e20 <get_elf_file+0x140>
ffffffc050400fd2:	4b7050ef          	jal	ra,ffffffc050406c88 <prints>
ffffffc050400fd6:	a811                	j	ffffffc050400fea <do_process_show+0x130>
ffffffc050400fd8:	fe442783          	lw	a5,-28(s0)
ffffffc050400fdc:	85be                	mv	a1,a5
ffffffc050400fde:	00006517          	auipc	a0,0x6
ffffffc050400fe2:	e4a50513          	addi	a0,a0,-438 # ffffffc050406e28 <get_elf_file+0x148>
ffffffc050400fe6:	4a3050ef          	jal	ra,ffffffc050406c88 <prints>
ffffffc050400fea:	00006517          	auipc	a0,0x6
ffffffc050400fee:	e4650513          	addi	a0,a0,-442 # ffffffc050406e30 <get_elf_file+0x150>
ffffffc050400ff2:	497050ef          	jal	ra,ffffffc050406c88 <prints>
ffffffc050400ff6:	a011                	j	ffffffc050400ffa <do_process_show+0x140>
ffffffc050400ff8:	0001                	nop
ffffffc050400ffa:	fec42783          	lw	a5,-20(s0)
ffffffc050400ffe:	2785                	addiw	a5,a5,1
ffffffc050401000:	fef42623          	sw	a5,-20(s0)
ffffffc050401004:	fec42783          	lw	a5,-20(s0)
ffffffc050401008:	0007871b          	sext.w	a4,a5
ffffffc05040100c:	47fd                	li	a5,31
ffffffc05040100e:	ece7d3e3          	bge	a5,a4,ffffffc050400ed4 <do_process_show+0x1a>
ffffffc050401012:	170010ef          	jal	ra,ffffffc050402182 <screen_reflush>
ffffffc050401016:	0001                	nop
ffffffc050401018:	60e2                	ld	ra,24(sp)
ffffffc05040101a:	6442                	ld	s0,16(sp)
ffffffc05040101c:	6105                	addi	sp,sp,32
ffffffc05040101e:	8082                	ret

ffffffc050401020 <do_check>:
ffffffc050401020:	1141                	addi	sp,sp,-16
ffffffc050401022:	e406                	sd	ra,8(sp)
ffffffc050401024:	e022                	sd	s0,0(sp)
ffffffc050401026:	0800                	addi	s0,sp,16
ffffffc050401028:	4529                	li	a0,10
ffffffc05040102a:	3fe030ef          	jal	ra,ffffffc050404428 <latency>
ffffffc05040102e:	0001                	nop
ffffffc050401030:	60a2                	ld	ra,8(sp)
ffffffc050401032:	6402                	ld	s0,0(sp)
ffffffc050401034:	0141                	addi	sp,sp,16
ffffffc050401036:	8082                	ret

ffffffc050401038 <do_loop>:
ffffffc050401038:	1141                	addi	sp,sp,-16
ffffffc05040103a:	e422                	sd	s0,8(sp)
ffffffc05040103c:	0800                	addi	s0,sp,16
ffffffc05040103e:	a001                	j	ffffffc05040103e <do_loop+0x6>

ffffffc050401040 <init_syscall>:
ffffffc050401040:	1141                	addi	sp,sp,-16
ffffffc050401042:	e422                	sd	s0,8(sp)
ffffffc050401044:	0800                	addi	s0,sp,16
ffffffc050401046:	00073797          	auipc	a5,0x73
ffffffc05040104a:	1a278793          	addi	a5,a5,418 # ffffffc0504741e8 <syscall>
ffffffc05040104e:	00003717          	auipc	a4,0x3
ffffffc050401052:	dae70713          	addi	a4,a4,-594 # ffffffc050403dfc <do_exec>
ffffffc050401056:	e398                	sd	a4,0(a5)
ffffffc050401058:	00073797          	auipc	a5,0x73
ffffffc05040105c:	19078793          	addi	a5,a5,400 # ffffffc0504741e8 <syscall>
ffffffc050401060:	00002717          	auipc	a4,0x2
ffffffc050401064:	46a70713          	addi	a4,a4,1130 # ffffffc0504034ca <do_exit>
ffffffc050401068:	e798                	sd	a4,8(a5)
ffffffc05040106a:	00073797          	auipc	a5,0x73
ffffffc05040106e:	17e78793          	addi	a5,a5,382 # ffffffc0504741e8 <syscall>
ffffffc050401072:	00002717          	auipc	a4,0x2
ffffffc050401076:	f0070713          	addi	a4,a4,-256 # ffffffc050402f72 <do_sleep>
ffffffc05040107a:	eb98                	sd	a4,16(a5)
ffffffc05040107c:	00073797          	auipc	a5,0x73
ffffffc050401080:	16c78793          	addi	a5,a5,364 # ffffffc0504741e8 <syscall>
ffffffc050401084:	00002717          	auipc	a4,0x2
ffffffc050401088:	75a70713          	addi	a4,a4,1882 # ffffffc0504037de <do_kill>
ffffffc05040108c:	ef98                	sd	a4,24(a5)
ffffffc05040108e:	00073797          	auipc	a5,0x73
ffffffc050401092:	15a78793          	addi	a5,a5,346 # ffffffc0504741e8 <syscall>
ffffffc050401096:	00002717          	auipc	a4,0x2
ffffffc05040109a:	5b270713          	addi	a4,a4,1458 # ffffffc050403648 <do_waitpid>
ffffffc05040109e:	f398                	sd	a4,32(a5)
ffffffc0504010a0:	00073797          	auipc	a5,0x73
ffffffc0504010a4:	14878793          	addi	a5,a5,328 # ffffffc0504741e8 <syscall>
ffffffc0504010a8:	00000717          	auipc	a4,0x0
ffffffc0504010ac:	e1270713          	addi	a4,a4,-494 # ffffffc050400eba <do_process_show>
ffffffc0504010b0:	f798                	sd	a4,40(a5)
ffffffc0504010b2:	00073797          	auipc	a5,0x73
ffffffc0504010b6:	13678793          	addi	a5,a5,310 # ffffffc0504741e8 <syscall>
ffffffc0504010ba:	00003717          	auipc	a4,0x3
ffffffc0504010be:	b8c70713          	addi	a4,a4,-1140 # ffffffc050403c46 <do_getpid>
ffffffc0504010c2:	fb98                	sd	a4,48(a5)
ffffffc0504010c4:	00073797          	auipc	a5,0x73
ffffffc0504010c8:	12478793          	addi	a5,a5,292 # ffffffc0504741e8 <syscall>
ffffffc0504010cc:	00002717          	auipc	a4,0x2
ffffffc0504010d0:	b2270713          	addi	a4,a4,-1246 # ffffffc050402bee <do_scheduler>
ffffffc0504010d4:	ff98                	sd	a4,56(a5)
ffffffc0504010d6:	00073797          	auipc	a5,0x73
ffffffc0504010da:	11278793          	addi	a5,a5,274 # ffffffc0504741e8 <syscall>
ffffffc0504010de:	00002717          	auipc	a4,0x2
ffffffc0504010e2:	1d870713          	addi	a4,a4,472 # ffffffc0504032b6 <do_fork>
ffffffc0504010e6:	e3b8                	sd	a4,64(a5)
ffffffc0504010e8:	00073797          	auipc	a5,0x73
ffffffc0504010ec:	10078793          	addi	a5,a5,256 # ffffffc0504741e8 <syscall>
ffffffc0504010f0:	00002717          	auipc	a4,0x2
ffffffc0504010f4:	1e870713          	addi	a4,a4,488 # ffffffc0504032d8 <do_prior>
ffffffc0504010f8:	e7b8                	sd	a4,72(a5)
ffffffc0504010fa:	00073797          	auipc	a5,0x73
ffffffc0504010fe:	0ee78793          	addi	a5,a5,238 # ffffffc0504741e8 <syscall>
ffffffc050401102:	00000717          	auipc	a4,0x0
ffffffc050401106:	88070713          	addi	a4,a4,-1920 # ffffffc050400982 <do_nothing>
ffffffc05040110a:	ebb8                	sd	a4,80(a5)
ffffffc05040110c:	00073797          	auipc	a5,0x73
ffffffc050401110:	0dc78793          	addi	a5,a5,220 # ffffffc0504741e8 <syscall>
ffffffc050401114:	00000717          	auipc	a4,0x0
ffffffc050401118:	86e70713          	addi	a4,a4,-1938 # ffffffc050400982 <do_nothing>
ffffffc05040111c:	efb8                	sd	a4,88(a5)
ffffffc05040111e:	00073797          	auipc	a5,0x73
ffffffc050401122:	0ca78793          	addi	a5,a5,202 # ffffffc0504741e8 <syscall>
ffffffc050401126:	00000717          	auipc	a4,0x0
ffffffc05040112a:	d5e70713          	addi	a4,a4,-674 # ffffffc050400e84 <print_syscall>
ffffffc05040112e:	f3b8                	sd	a4,96(a5)
ffffffc050401130:	00073797          	auipc	a5,0x73
ffffffc050401134:	0b878793          	addi	a5,a5,184 # ffffffc0504741e8 <syscall>
ffffffc050401138:	00000717          	auipc	a4,0x0
ffffffc05040113c:	d4c70713          	addi	a4,a4,-692 # ffffffc050400e84 <print_syscall>
ffffffc050401140:	f7b8                	sd	a4,104(a5)
ffffffc050401142:	00073797          	auipc	a5,0x73
ffffffc050401146:	0a678793          	addi	a5,a5,166 # ffffffc0504741e8 <syscall>
ffffffc05040114a:	00000717          	auipc	a4,0x0
ffffffc05040114e:	d3a70713          	addi	a4,a4,-710 # ffffffc050400e84 <print_syscall>
ffffffc050401152:	fbb8                	sd	a4,112(a5)
ffffffc050401154:	00073797          	auipc	a5,0x73
ffffffc050401158:	09478793          	addi	a5,a5,148 # ffffffc0504741e8 <syscall>
ffffffc05040115c:	00000717          	auipc	a4,0x0
ffffffc050401160:	d2870713          	addi	a4,a4,-728 # ffffffc050400e84 <print_syscall>
ffffffc050401164:	ffb8                	sd	a4,120(a5)
ffffffc050401166:	00073797          	auipc	a5,0x73
ffffffc05040116a:	08278793          	addi	a5,a5,130 # ffffffc0504741e8 <syscall>
ffffffc05040116e:	00000717          	auipc	a4,0x0
ffffffc050401172:	d1670713          	addi	a4,a4,-746 # ffffffc050400e84 <print_syscall>
ffffffc050401176:	e3d8                	sd	a4,128(a5)
ffffffc050401178:	00073797          	auipc	a5,0x73
ffffffc05040117c:	07078793          	addi	a5,a5,112 # ffffffc0504741e8 <syscall>
ffffffc050401180:	00000717          	auipc	a4,0x0
ffffffc050401184:	d0470713          	addi	a4,a4,-764 # ffffffc050400e84 <print_syscall>
ffffffc050401188:	e7d8                	sd	a4,136(a5)
ffffffc05040118a:	00073797          	auipc	a5,0x73
ffffffc05040118e:	05e78793          	addi	a5,a5,94 # ffffffc0504741e8 <syscall>
ffffffc050401192:	00000717          	auipc	a4,0x0
ffffffc050401196:	cf270713          	addi	a4,a4,-782 # ffffffc050400e84 <print_syscall>
ffffffc05040119a:	ebd8                	sd	a4,144(a5)
ffffffc05040119c:	00073797          	auipc	a5,0x73
ffffffc0504011a0:	04c78793          	addi	a5,a5,76 # ffffffc0504741e8 <syscall>
ffffffc0504011a4:	00000717          	auipc	a4,0x0
ffffffc0504011a8:	ce070713          	addi	a4,a4,-800 # ffffffc050400e84 <print_syscall>
ffffffc0504011ac:	efd8                	sd	a4,152(a5)
ffffffc0504011ae:	00073797          	auipc	a5,0x73
ffffffc0504011b2:	03a78793          	addi	a5,a5,58 # ffffffc0504741e8 <syscall>
ffffffc0504011b6:	00001717          	auipc	a4,0x1
ffffffc0504011ba:	f6e70713          	addi	a4,a4,-146 # ffffffc050402124 <screen_write>
ffffffc0504011be:	efd8                	sd	a4,152(a5)
ffffffc0504011c0:	00073797          	auipc	a5,0x73
ffffffc0504011c4:	02878793          	addi	a5,a5,40 # ffffffc0504741e8 <syscall>
ffffffc0504011c8:	fffff717          	auipc	a4,0xfffff
ffffffc0504011cc:	7ba70713          	addi	a4,a4,1978 # ffffffc050400982 <do_nothing>
ffffffc0504011d0:	f3d8                	sd	a4,160(a5)
ffffffc0504011d2:	00073797          	auipc	a5,0x73
ffffffc0504011d6:	01678793          	addi	a5,a5,22 # ffffffc0504741e8 <syscall>
ffffffc0504011da:	00001717          	auipc	a4,0x1
ffffffc0504011de:	e5070713          	addi	a4,a4,-432 # ffffffc05040202a <screen_move_cursor>
ffffffc0504011e2:	f7d8                	sd	a4,168(a5)
ffffffc0504011e4:	00073797          	auipc	a5,0x73
ffffffc0504011e8:	00478793          	addi	a5,a5,4 # ffffffc0504741e8 <syscall>
ffffffc0504011ec:	00001717          	auipc	a4,0x1
ffffffc0504011f0:	ee470713          	addi	a4,a4,-284 # ffffffc0504020d0 <screen_get_cursor>
ffffffc0504011f4:	fbd8                	sd	a4,176(a5)
ffffffc0504011f6:	00073797          	auipc	a5,0x73
ffffffc0504011fa:	ff278793          	addi	a5,a5,-14 # ffffffc0504741e8 <syscall>
ffffffc0504011fe:	00001717          	auipc	a4,0x1
ffffffc050401202:	f8470713          	addi	a4,a4,-124 # ffffffc050402182 <screen_reflush>
ffffffc050401206:	ffd8                	sd	a4,184(a5)
ffffffc050401208:	00073797          	auipc	a5,0x73
ffffffc05040120c:	fe078793          	addi	a5,a5,-32 # ffffffc0504741e8 <syscall>
ffffffc050401210:	fffff717          	auipc	a4,0xfffff
ffffffc050401214:	77270713          	addi	a4,a4,1906 # ffffffc050400982 <do_nothing>
ffffffc050401218:	e3f8                	sd	a4,192(a5)
ffffffc05040121a:	00073797          	auipc	a5,0x73
ffffffc05040121e:	fce78793          	addi	a5,a5,-50 # ffffffc0504741e8 <syscall>
ffffffc050401222:	fffff717          	auipc	a4,0xfffff
ffffffc050401226:	76070713          	addi	a4,a4,1888 # ffffffc050400982 <do_nothing>
ffffffc05040122a:	e7f8                	sd	a4,200(a5)
ffffffc05040122c:	00073797          	auipc	a5,0x73
ffffffc050401230:	fbc78793          	addi	a5,a5,-68 # ffffffc0504741e8 <syscall>
ffffffc050401234:	fffff717          	auipc	a4,0xfffff
ffffffc050401238:	74e70713          	addi	a4,a4,1870 # ffffffc050400982 <do_nothing>
ffffffc05040123c:	ebf8                	sd	a4,208(a5)
ffffffc05040123e:	00073797          	auipc	a5,0x73
ffffffc050401242:	faa78793          	addi	a5,a5,-86 # ffffffc0504741e8 <syscall>
ffffffc050401246:	00001717          	auipc	a4,0x1
ffffffc05040124a:	d0870713          	addi	a4,a4,-760 # ffffffc050401f4e <screen_clear>
ffffffc05040124e:	eff8                	sd	a4,216(a5)
ffffffc050401250:	00073797          	auipc	a5,0x73
ffffffc050401254:	f9878793          	addi	a5,a5,-104 # ffffffc0504741e8 <syscall>
ffffffc050401258:	00001717          	auipc	a4,0x1
ffffffc05040125c:	0ac70713          	addi	a4,a4,172 # ffffffc050402304 <getch>
ffffffc050401260:	f3f8                	sd	a4,224(a5)
ffffffc050401262:	00073797          	auipc	a5,0x73
ffffffc050401266:	f8678793          	addi	a5,a5,-122 # ffffffc0504741e8 <syscall>
ffffffc05040126a:	fffff717          	auipc	a4,0xfffff
ffffffc05040126e:	07c70713          	addi	a4,a4,124 # ffffffc0504002e6 <port_write_ch>
ffffffc050401272:	f7f8                	sd	a4,232(a5)
ffffffc050401274:	00073797          	auipc	a5,0x73
ffffffc050401278:	f7478793          	addi	a5,a5,-140 # ffffffc0504741e8 <syscall>
ffffffc05040127c:	00003717          	auipc	a4,0x3
ffffffc050401280:	19470713          	addi	a4,a4,404 # ffffffc050404410 <get_time_base>
ffffffc050401284:	fbf8                	sd	a4,240(a5)
ffffffc050401286:	00073797          	auipc	a5,0x73
ffffffc05040128a:	f6278793          	addi	a5,a5,-158 # ffffffc0504741e8 <syscall>
ffffffc05040128e:	00003717          	auipc	a4,0x3
ffffffc050401292:	13e70713          	addi	a4,a4,318 # ffffffc0504043cc <get_ticks>
ffffffc050401296:	fff8                	sd	a4,248(a5)
ffffffc050401298:	00073797          	auipc	a5,0x73
ffffffc05040129c:	f5078793          	addi	a5,a5,-176 # ffffffc0504741e8 <syscall>
ffffffc0504012a0:	00003717          	auipc	a4,0x3
ffffffc0504012a4:	1be70713          	addi	a4,a4,446 # ffffffc05040445e <get_walltime>
ffffffc0504012a8:	10e7b023          	sd	a4,256(a5)
ffffffc0504012ac:	00073797          	auipc	a5,0x73
ffffffc0504012b0:	f3c78793          	addi	a5,a5,-196 # ffffffc0504741e8 <syscall>
ffffffc0504012b4:	00001717          	auipc	a4,0x1
ffffffc0504012b8:	2ba70713          	addi	a4,a4,698 # ffffffc05040256e <get_mutex>
ffffffc0504012bc:	10e7b423          	sd	a4,264(a5)
ffffffc0504012c0:	00073797          	auipc	a5,0x73
ffffffc0504012c4:	f2878793          	addi	a5,a5,-216 # ffffffc0504741e8 <syscall>
ffffffc0504012c8:	00001717          	auipc	a4,0x1
ffffffc0504012cc:	2ee70713          	addi	a4,a4,750 # ffffffc0504025b6 <lock_mutex>
ffffffc0504012d0:	10e7b823          	sd	a4,272(a5)
ffffffc0504012d4:	00073797          	auipc	a5,0x73
ffffffc0504012d8:	f1478793          	addi	a5,a5,-236 # ffffffc0504741e8 <syscall>
ffffffc0504012dc:	00001717          	auipc	a4,0x1
ffffffc0504012e0:	31070713          	addi	a4,a4,784 # ffffffc0504025ec <unlock_mutex>
ffffffc0504012e4:	10e7bc23          	sd	a4,280(a5)
ffffffc0504012e8:	00073797          	auipc	a5,0x73
ffffffc0504012ec:	f0078793          	addi	a5,a5,-256 # ffffffc0504741e8 <syscall>
ffffffc0504012f0:	fffff717          	auipc	a4,0xfffff
ffffffc0504012f4:	69270713          	addi	a4,a4,1682 # ffffffc050400982 <do_nothing>
ffffffc0504012f8:	12e7b023          	sd	a4,288(a5)
ffffffc0504012fc:	00073797          	auipc	a5,0x73
ffffffc050401300:	eec78793          	addi	a5,a5,-276 # ffffffc0504741e8 <syscall>
ffffffc050401304:	00003717          	auipc	a4,0x3
ffffffc050401308:	20a70713          	addi	a4,a4,522 # ffffffc05040450e <do_barrier_init>
ffffffc05040130c:	12e7b423          	sd	a4,296(a5)
ffffffc050401310:	00073797          	auipc	a5,0x73
ffffffc050401314:	ed878793          	addi	a5,a5,-296 # ffffffc0504741e8 <syscall>
ffffffc050401318:	00003717          	auipc	a4,0x3
ffffffc05040131c:	29e70713          	addi	a4,a4,670 # ffffffc0504045b6 <do_barrier_wait>
ffffffc050401320:	12e7b823          	sd	a4,304(a5)
ffffffc050401324:	00073797          	auipc	a5,0x73
ffffffc050401328:	ec478793          	addi	a5,a5,-316 # ffffffc0504741e8 <syscall>
ffffffc05040132c:	00003717          	auipc	a4,0x3
ffffffc050401330:	37470713          	addi	a4,a4,884 # ffffffc0504046a0 <do_barrier_destroy>
ffffffc050401334:	12e7bc23          	sd	a4,312(a5)
ffffffc050401338:	00073797          	auipc	a5,0x73
ffffffc05040133c:	eb078793          	addi	a5,a5,-336 # ffffffc0504741e8 <syscall>
ffffffc050401340:	00003717          	auipc	a4,0x3
ffffffc050401344:	3aa70713          	addi	a4,a4,938 # ffffffc0504046ea <do_semaphore_init>
ffffffc050401348:	14e7b023          	sd	a4,320(a5)
ffffffc05040134c:	00073797          	auipc	a5,0x73
ffffffc050401350:	e9c78793          	addi	a5,a5,-356 # ffffffc0504741e8 <syscall>
ffffffc050401354:	00003717          	auipc	a4,0x3
ffffffc050401358:	43e70713          	addi	a4,a4,1086 # ffffffc050404792 <do_semaphore_up>
ffffffc05040135c:	14e7b423          	sd	a4,328(a5)
ffffffc050401360:	00073797          	auipc	a5,0x73
ffffffc050401364:	e8878793          	addi	a5,a5,-376 # ffffffc0504741e8 <syscall>
ffffffc050401368:	00003717          	auipc	a4,0x3
ffffffc05040136c:	4ec70713          	addi	a4,a4,1260 # ffffffc050404854 <do_semaphore_down>
ffffffc050401370:	14e7b823          	sd	a4,336(a5)
ffffffc050401374:	00073797          	auipc	a5,0x73
ffffffc050401378:	e7478793          	addi	a5,a5,-396 # ffffffc0504741e8 <syscall>
ffffffc05040137c:	00003717          	auipc	a4,0x3
ffffffc050401380:	5ba70713          	addi	a4,a4,1466 # ffffffc050404936 <do_semaphore_destroy>
ffffffc050401384:	14e7bc23          	sd	a4,344(a5)
ffffffc050401388:	00073797          	auipc	a5,0x73
ffffffc05040138c:	e6078793          	addi	a5,a5,-416 # ffffffc0504741e8 <syscall>
ffffffc050401390:	00003717          	auipc	a4,0x3
ffffffc050401394:	5f070713          	addi	a4,a4,1520 # ffffffc050404980 <do_mbox_open>
ffffffc050401398:	16e7b023          	sd	a4,352(a5)
ffffffc05040139c:	00073797          	auipc	a5,0x73
ffffffc0504013a0:	e4c78793          	addi	a5,a5,-436 # ffffffc0504741e8 <syscall>
ffffffc0504013a4:	00004717          	auipc	a4,0x4
ffffffc0504013a8:	83270713          	addi	a4,a4,-1998 # ffffffc050404bd6 <do_mbox_close>
ffffffc0504013ac:	16e7b423          	sd	a4,360(a5)
ffffffc0504013b0:	00073797          	auipc	a5,0x73
ffffffc0504013b4:	e3878793          	addi	a5,a5,-456 # ffffffc0504741e8 <syscall>
ffffffc0504013b8:	00004717          	auipc	a4,0x4
ffffffc0504013bc:	99470713          	addi	a4,a4,-1644 # ffffffc050404d4c <do_mbox_send>
ffffffc0504013c0:	16e7b823          	sd	a4,368(a5)
ffffffc0504013c4:	00073797          	auipc	a5,0x73
ffffffc0504013c8:	e2478793          	addi	a5,a5,-476 # ffffffc0504741e8 <syscall>
ffffffc0504013cc:	00004717          	auipc	a4,0x4
ffffffc0504013d0:	b6e70713          	addi	a4,a4,-1170 # ffffffc050404f3a <do_mbox_recv>
ffffffc0504013d4:	16e7bc23          	sd	a4,376(a5)
ffffffc0504013d8:	00073797          	auipc	a5,0x73
ffffffc0504013dc:	e1078793          	addi	a5,a5,-496 # ffffffc0504741e8 <syscall>
ffffffc0504013e0:	00003717          	auipc	a4,0x3
ffffffc0504013e4:	89670713          	addi	a4,a4,-1898 # ffffffc050403c76 <do_taskset>
ffffffc0504013e8:	18e7b023          	sd	a4,384(a5)
ffffffc0504013ec:	00073797          	auipc	a5,0x73
ffffffc0504013f0:	dfc78793          	addi	a5,a5,-516 # ffffffc0504741e8 <syscall>
ffffffc0504013f4:	00001717          	auipc	a4,0x1
ffffffc0504013f8:	2a870713          	addi	a4,a4,680 # ffffffc05040269c <do_binsemget>
ffffffc0504013fc:	18e7bc23          	sd	a4,408(a5)
ffffffc050401400:	00073797          	auipc	a5,0x73
ffffffc050401404:	de878793          	addi	a5,a5,-536 # ffffffc0504741e8 <syscall>
ffffffc050401408:	00001717          	auipc	a4,0x1
ffffffc05040140c:	35a70713          	addi	a4,a4,858 # ffffffc050402762 <do_binsemop>
ffffffc050401410:	1ae7b023          	sd	a4,416(a5)
ffffffc050401414:	00073797          	auipc	a5,0x73
ffffffc050401418:	dd478793          	addi	a5,a5,-556 # ffffffc0504741e8 <syscall>
ffffffc05040141c:	00003717          	auipc	a4,0x3
ffffffc050401420:	bf070713          	addi	a4,a4,-1040 # ffffffc05040400c <do_thread_create>
ffffffc050401424:	1ae7b423          	sd	a4,424(a5)
ffffffc050401428:	00073797          	auipc	a5,0x73
ffffffc05040142c:	dc078793          	addi	a5,a5,-576 # ffffffc0504741e8 <syscall>
ffffffc050401430:	00000717          	auipc	a4,0x0
ffffffc050401434:	bf070713          	addi	a4,a4,-1040 # ffffffc050401020 <do_check>
ffffffc050401438:	1ae7b823          	sd	a4,432(a5)
ffffffc05040143c:	00073797          	auipc	a5,0x73
ffffffc050401440:	dac78793          	addi	a5,a5,-596 # ffffffc0504741e8 <syscall>
ffffffc050401444:	00000717          	auipc	a4,0x0
ffffffc050401448:	bf470713          	addi	a4,a4,-1036 # ffffffc050401038 <do_loop>
ffffffc05040144c:	1ae7bc23          	sd	a4,440(a5)
ffffffc050401450:	0001                	nop
ffffffc050401452:	6422                	ld	s0,8(sp)
ffffffc050401454:	0141                	addi	sp,sp,16
ffffffc050401456:	8082                	ret

ffffffc050401458 <init_binsem>:
ffffffc050401458:	1101                	addi	sp,sp,-32
ffffffc05040145a:	ec22                	sd	s0,24(sp)
ffffffc05040145c:	1000                	addi	s0,sp,32
ffffffc05040145e:	fe042623          	sw	zero,-20(s0)
ffffffc050401462:	a081                	j	ffffffc0504014a2 <init_binsem+0x4a>
ffffffc050401464:	00068697          	auipc	a3,0x68
ffffffc050401468:	49c68693          	addi	a3,a3,1180 # ffffffc050469900 <binsem_array>
ffffffc05040146c:	fec42703          	lw	a4,-20(s0)
ffffffc050401470:	87ba                	mv	a5,a4
ffffffc050401472:	0786                	slli	a5,a5,0x1
ffffffc050401474:	97ba                	add	a5,a5,a4
ffffffc050401476:	0792                	slli	a5,a5,0x4
ffffffc050401478:	97b6                	add	a5,a5,a3
ffffffc05040147a:	0007a023          	sw	zero,0(a5)
ffffffc05040147e:	00068697          	auipc	a3,0x68
ffffffc050401482:	48268693          	addi	a3,a3,1154 # ffffffc050469900 <binsem_array>
ffffffc050401486:	fec42703          	lw	a4,-20(s0)
ffffffc05040148a:	87ba                	mv	a5,a4
ffffffc05040148c:	0786                	slli	a5,a5,0x1
ffffffc05040148e:	97ba                	add	a5,a5,a4
ffffffc050401490:	0792                	slli	a5,a5,0x4
ffffffc050401492:	97b6                	add	a5,a5,a3
ffffffc050401494:	0007a423          	sw	zero,8(a5)
ffffffc050401498:	fec42783          	lw	a5,-20(s0)
ffffffc05040149c:	2785                	addiw	a5,a5,1
ffffffc05040149e:	fef42623          	sw	a5,-20(s0)
ffffffc0504014a2:	fec42783          	lw	a5,-20(s0)
ffffffc0504014a6:	0007871b          	sext.w	a4,a5
ffffffc0504014aa:	479d                	li	a5,7
ffffffc0504014ac:	fae7dce3          	bge	a5,a4,ffffffc050401464 <init_binsem+0xc>
ffffffc0504014b0:	0001                	nop
ffffffc0504014b2:	0001                	nop
ffffffc0504014b4:	6462                	ld	s0,24(sp)
ffffffc0504014b6:	6105                	addi	sp,sp,32
ffffffc0504014b8:	8082                	ret

ffffffc0504014ba <main>:
ffffffc0504014ba:	1141                	addi	sp,sp,-16
ffffffc0504014bc:	e406                	sd	ra,8(sp)
ffffffc0504014be:	e022                	sd	s0,0(sp)
ffffffc0504014c0:	0800                	addi	s0,sp,16
ffffffc0504014c2:	e7ffe0ef          	jal	ra,ffffffc050400340 <get_current_cpu_id>
ffffffc0504014c6:	872a                	mv	a4,a0
ffffffc0504014c8:	4785                	li	a5,1
ffffffc0504014ca:	02f71763          	bne	a4,a5,ffffffc0504014f8 <main+0x3e>
ffffffc0504014ce:	00006517          	auipc	a0,0x6
ffffffc0504014d2:	96a50513          	addi	a0,a0,-1686 # ffffffc050406e38 <get_elf_file+0x158>
ffffffc0504014d6:	72a050ef          	jal	ra,ffffffc050406c00 <printk>
ffffffc0504014da:	b9bfe0ef          	jal	ra,ffffffc050400074 <setup_exception>
ffffffc0504014de:	6ef020ef          	jal	ra,ffffffc0504043cc <get_ticks>
ffffffc0504014e2:	872a                	mv	a4,a0
ffffffc0504014e4:	67c1                	lui	a5,0x10
ffffffc0504014e6:	97ba                	add	a5,a5,a4
ffffffc0504014e8:	853e                	mv	a0,a5
ffffffc0504014ea:	e5dfe0ef          	jal	ra,ffffffc050400346 <sbi_set_timer>
ffffffc0504014ee:	bcbfe0ef          	jal	ra,ffffffc0504000b8 <enable_interrupt>
ffffffc0504014f2:	c90ff0ef          	jal	ra,ffffffc050400982 <do_nothing>
ffffffc0504014f6:	bff5                	j	ffffffc0504014f2 <main+0x38>
ffffffc0504014f8:	00006517          	auipc	a0,0x6
ffffffc0504014fc:	95850513          	addi	a0,a0,-1704 # ffffffc050406e50 <get_elf_file+0x170>
ffffffc050401500:	700050ef          	jal	ra,ffffffc050406c00 <printk>
ffffffc050401504:	65d000ef          	jal	ra,ffffffc050402360 <getchar>
ffffffc050401508:	00068517          	auipc	a0,0x68
ffffffc05040150c:	3e850513          	addi	a0,a0,1000 # ffffffc0504698f0 <kernel_lock>
ffffffc050401510:	112010ef          	jal	ra,ffffffc050402622 <spin_lock_init>
ffffffc050401514:	c7cff0ef          	jal	ra,ffffffc050400990 <init_free_page>
ffffffc050401518:	f41ff0ef          	jal	ra,ffffffc050401458 <init_binsem>
ffffffc05040151c:	d34ff0ef          	jal	ra,ffffffc050400a50 <init_pcb>
ffffffc050401520:	00006517          	auipc	a0,0x6
ffffffc050401524:	95850513          	addi	a0,a0,-1704 # ffffffc050406e78 <get_elf_file+0x198>
ffffffc050401528:	6d8050ef          	jal	ra,ffffffc050406c00 <printk>
ffffffc05040152c:	4501                	li	a0,0
ffffffc05040152e:	e39fe0ef          	jal	ra,ffffffc050400366 <sbi_read_fdt>
ffffffc050401532:	87aa                	mv	a5,a0
ffffffc050401534:	0007871b          	sext.w	a4,a5
ffffffc050401538:	88818793          	addi	a5,gp,-1912 # ffffffc05045f940 <time_base>
ffffffc05040153c:	c398                	sw	a4,0(a5)
ffffffc05040153e:	b03ff0ef          	jal	ra,ffffffc050401040 <init_syscall>
ffffffc050401542:	00006517          	auipc	a0,0x6
ffffffc050401546:	96650513          	addi	a0,a0,-1690 # ffffffc050406ea8 <get_elf_file+0x1c8>
ffffffc05040154a:	6b6050ef          	jal	ra,ffffffc050406c00 <printk>
ffffffc05040154e:	1eb000ef          	jal	ra,ffffffc050401f38 <init_screen>
ffffffc050401552:	00006517          	auipc	a0,0x6
ffffffc050401556:	98e50513          	addi	a0,a0,-1650 # ffffffc050406ee0 <get_elf_file+0x200>
ffffffc05040155a:	6a6050ef          	jal	ra,ffffffc050406c00 <printk>
ffffffc05040155e:	0005e797          	auipc	a5,0x5e
ffffffc050401562:	35a78793          	addi	a5,a5,858 # ffffffc05045f8b8 <pid0_stack_core0>
ffffffc050401566:	6398                	ld	a4,0(a5)
ffffffc050401568:	00060797          	auipc	a5,0x60
ffffffc05040156c:	42878793          	addi	a5,a5,1064 # ffffffc050461990 <cpu_stack_pointer>
ffffffc050401570:	e398                	sd	a4,0(a5)
ffffffc050401572:	0005e797          	auipc	a5,0x5e
ffffffc050401576:	34e78793          	addi	a5,a5,846 # ffffffc05045f8c0 <pid0_stack_core1>
ffffffc05040157a:	6398                	ld	a4,0(a5)
ffffffc05040157c:	00060797          	auipc	a5,0x60
ffffffc050401580:	41478793          	addi	a5,a5,1044 # ffffffc050461990 <cpu_stack_pointer>
ffffffc050401584:	e798                	sd	a4,8(a5)
ffffffc050401586:	00006717          	auipc	a4,0x6
ffffffc05040158a:	e1a70713          	addi	a4,a4,-486 # ffffffc0504073a0 <pid0_pcb_core0>
ffffffc05040158e:	00060797          	auipc	a5,0x60
ffffffc050401592:	41278793          	addi	a5,a5,1042 # ffffffc0504619a0 <cpu_pcb_pointer>
ffffffc050401596:	e398                	sd	a4,0(a5)
ffffffc050401598:	00006717          	auipc	a4,0x6
ffffffc05040159c:	ea070713          	addi	a4,a4,-352 # ffffffc050407438 <pid0_pcb_core1>
ffffffc0504015a0:	00060797          	auipc	a5,0x60
ffffffc0504015a4:	40078793          	addi	a5,a5,1024 # ffffffc0504619a0 <cpu_pcb_pointer>
ffffffc0504015a8:	e798                	sd	a4,8(a5)
ffffffc0504015aa:	00072797          	auipc	a5,0x72
ffffffc0504015ae:	8f678793          	addi	a5,a5,-1802 # ffffffc050472ea0 <sleep_queue>
ffffffc0504015b2:	0007a023          	sw	zero,0(a5)
ffffffc0504015b6:	00072797          	auipc	a5,0x72
ffffffc0504015ba:	8ea78793          	addi	a5,a5,-1814 # ffffffc050472ea0 <sleep_queue>
ffffffc0504015be:	0007b823          	sd	zero,16(a5)
ffffffc0504015c2:	00072797          	auipc	a5,0x72
ffffffc0504015c6:	8de78793          	addi	a5,a5,-1826 # ffffffc050472ea0 <sleep_queue>
ffffffc0504015ca:	0007b423          	sd	zero,8(a5)
ffffffc0504015ce:	00073797          	auipc	a5,0x73
ffffffc0504015d2:	c0278793          	addi	a5,a5,-1022 # ffffffc0504741d0 <exit_queue>
ffffffc0504015d6:	0007a023          	sw	zero,0(a5)
ffffffc0504015da:	00073797          	auipc	a5,0x73
ffffffc0504015de:	bf678793          	addi	a5,a5,-1034 # ffffffc0504741d0 <exit_queue>
ffffffc0504015e2:	0007b823          	sd	zero,16(a5)
ffffffc0504015e6:	00073797          	auipc	a5,0x73
ffffffc0504015ea:	bea78793          	addi	a5,a5,-1046 # ffffffc0504741d0 <exit_queue>
ffffffc0504015ee:	0007b423          	sd	zero,8(a5)
ffffffc0504015f2:	00006517          	auipc	a0,0x6
ffffffc0504015f6:	91e50513          	addi	a0,a0,-1762 # ffffffc050406f10 <get_elf_file+0x230>
ffffffc0504015fa:	606050ef          	jal	ra,ffffffc050406c00 <printk>
ffffffc0504015fe:	00006517          	auipc	a0,0x6
ffffffc050401602:	92a50513          	addi	a0,a0,-1750 # ffffffc050406f28 <get_elf_file+0x248>
ffffffc050401606:	5fa050ef          	jal	ra,ffffffc050406c00 <printk>
ffffffc05040160a:	1e6000ef          	jal	ra,ffffffc0504017f0 <init_exception>
ffffffc05040160e:	a93fe0ef          	jal	ra,ffffffc0504000a0 <enable_sum>
ffffffc050401612:	5bb020ef          	jal	ra,ffffffc0504043cc <get_ticks>
ffffffc050401616:	872a                	mv	a4,a0
ffffffc050401618:	88818793          	addi	a5,gp,-1912 # ffffffc05045f940 <time_base>
ffffffc05040161c:	439c                	lw	a5,0(a5)
ffffffc05040161e:	86be                	mv	a3,a5
ffffffc050401620:	06400793          	li	a5,100
ffffffc050401624:	02f6d7bb          	divuw	a5,a3,a5
ffffffc050401628:	2781                	sext.w	a5,a5
ffffffc05040162a:	1782                	slli	a5,a5,0x20
ffffffc05040162c:	9381                	srli	a5,a5,0x20
ffffffc05040162e:	97ba                	add	a5,a5,a4
ffffffc050401630:	853e                	mv	a0,a5
ffffffc050401632:	d15fe0ef          	jal	ra,ffffffc050400346 <sbi_set_timer>
ffffffc050401636:	a83fe0ef          	jal	ra,ffffffc0504000b8 <enable_interrupt>
ffffffc05040163a:	b48ff0ef          	jal	ra,ffffffc050400982 <do_nothing>
ffffffc05040163e:	bff5                	j	ffffffc05040163a <main+0x180>

ffffffc050401640 <sbi_set_timer>:
ffffffc050401640:	1101                	addi	sp,sp,-32
ffffffc050401642:	ec22                	sd	s0,24(sp)
ffffffc050401644:	1000                	addi	s0,sp,32
ffffffc050401646:	fea43423          	sd	a0,-24(s0)
ffffffc05040164a:	fe843503          	ld	a0,-24(s0)
ffffffc05040164e:	4581                	li	a1,0
ffffffc050401650:	4601                	li	a2,0
ffffffc050401652:	4881                	li	a7,0
ffffffc050401654:	00000073          	ecall
ffffffc050401658:	0001                	nop
ffffffc05040165a:	6462                	ld	s0,24(sp)
ffffffc05040165c:	6105                	addi	sp,sp,32
ffffffc05040165e:	8082                	ret

ffffffc050401660 <_panic>:
ffffffc050401660:	7179                	addi	sp,sp,-48
ffffffc050401662:	f406                	sd	ra,40(sp)
ffffffc050401664:	f022                	sd	s0,32(sp)
ffffffc050401666:	1800                	addi	s0,sp,48
ffffffc050401668:	fea43423          	sd	a0,-24(s0)
ffffffc05040166c:	87ae                	mv	a5,a1
ffffffc05040166e:	fcc43c23          	sd	a2,-40(s0)
ffffffc050401672:	fef42223          	sw	a5,-28(s0)
ffffffc050401676:	fe442783          	lw	a5,-28(s0)
ffffffc05040167a:	86be                	mv	a3,a5
ffffffc05040167c:	fe843603          	ld	a2,-24(s0)
ffffffc050401680:	fd843583          	ld	a1,-40(s0)
ffffffc050401684:	00006517          	auipc	a0,0x6
ffffffc050401688:	9e450513          	addi	a0,a0,-1564 # ffffffc050407068 <get_elf_file+0x388>
ffffffc05040168c:	574050ef          	jal	ra,ffffffc050406c00 <printk>
ffffffc050401690:	a001                	j	ffffffc050401690 <_panic+0x30>

ffffffc050401692 <reset_irq_timer>:
ffffffc050401692:	1101                	addi	sp,sp,-32
ffffffc050401694:	ec06                	sd	ra,24(sp)
ffffffc050401696:	e822                	sd	s0,16(sp)
ffffffc050401698:	1000                	addi	s0,sp,32
ffffffc05040169a:	2e9000ef          	jal	ra,ffffffc050402182 <screen_reflush>
ffffffc05040169e:	52f020ef          	jal	ra,ffffffc0504043cc <get_ticks>
ffffffc0504016a2:	fea43423          	sd	a0,-24(s0)
ffffffc0504016a6:	c9bfe0ef          	jal	ra,ffffffc050400340 <get_current_cpu_id>
ffffffc0504016aa:	87aa                	mv	a5,a0
ffffffc0504016ac:	fef42223          	sw	a5,-28(s0)
ffffffc0504016b0:	88818793          	addi	a5,gp,-1912 # ffffffc05045f940 <time_base>
ffffffc0504016b4:	439c                	lw	a5,0(a5)
ffffffc0504016b6:	873e                	mv	a4,a5
ffffffc0504016b8:	06400793          	li	a5,100
ffffffc0504016bc:	02f757bb          	divuw	a5,a4,a5
ffffffc0504016c0:	2781                	sext.w	a5,a5
ffffffc0504016c2:	02079713          	slli	a4,a5,0x20
ffffffc0504016c6:	9301                	srli	a4,a4,0x20
ffffffc0504016c8:	fe843783          	ld	a5,-24(s0)
ffffffc0504016cc:	97ba                	add	a5,a5,a4
ffffffc0504016ce:	853e                	mv	a0,a5
ffffffc0504016d0:	f71ff0ef          	jal	ra,ffffffc050401640 <sbi_set_timer>
ffffffc0504016d4:	00071717          	auipc	a4,0x71
ffffffc0504016d8:	7bc70713          	addi	a4,a4,1980 # ffffffc050472e90 <current_running>
ffffffc0504016dc:	fe442783          	lw	a5,-28(s0)
ffffffc0504016e0:	078e                	slli	a5,a5,0x3
ffffffc0504016e2:	97ba                	add	a5,a5,a4
ffffffc0504016e4:	639c                	ld	a5,0(a5)
ffffffc0504016e6:	7bbc                	ld	a5,112(a5)
ffffffc0504016e8:	fe843703          	ld	a4,-24(s0)
ffffffc0504016ec:	00e7f463          	bgeu	a5,a4,ffffffc0504016f4 <reset_irq_timer+0x62>
ffffffc0504016f0:	4fe010ef          	jal	ra,ffffffc050402bee <do_scheduler>
ffffffc0504016f4:	0001                	nop
ffffffc0504016f6:	60e2                	ld	ra,24(sp)
ffffffc0504016f8:	6442                	ld	s0,16(sp)
ffffffc0504016fa:	6105                	addi	sp,sp,32
ffffffc0504016fc:	8082                	ret

ffffffc0504016fe <interrupt_helper>:
ffffffc0504016fe:	7179                	addi	sp,sp,-48
ffffffc050401700:	f406                	sd	ra,40(sp)
ffffffc050401702:	f022                	sd	s0,32(sp)
ffffffc050401704:	1800                	addi	s0,sp,48
ffffffc050401706:	fea43423          	sd	a0,-24(s0)
ffffffc05040170a:	feb43023          	sd	a1,-32(s0)
ffffffc05040170e:	fcc43c23          	sd	a2,-40(s0)
ffffffc050401712:	fd843783          	ld	a5,-40(s0)
ffffffc050401716:	0207d663          	bgez	a5,ffffffc050401742 <interrupt_helper+0x44>
ffffffc05040171a:	fd843703          	ld	a4,-40(s0)
ffffffc05040171e:	57fd                	li	a5,-1
ffffffc050401720:	8385                	srli	a5,a5,0x1
ffffffc050401722:	8ff9                	and	a5,a5,a4
ffffffc050401724:	00071717          	auipc	a4,0x71
ffffffc050401728:	6e470713          	addi	a4,a4,1764 # ffffffc050472e08 <irq_table>
ffffffc05040172c:	078e                	slli	a5,a5,0x3
ffffffc05040172e:	97ba                	add	a5,a5,a4
ffffffc050401730:	639c                	ld	a5,0(a5)
ffffffc050401732:	fd843603          	ld	a2,-40(s0)
ffffffc050401736:	fe043583          	ld	a1,-32(s0)
ffffffc05040173a:	fe843503          	ld	a0,-24(s0)
ffffffc05040173e:	9782                	jalr	a5
ffffffc050401740:	a025                	j	ffffffc050401768 <interrupt_helper+0x6a>
ffffffc050401742:	fd843703          	ld	a4,-40(s0)
ffffffc050401746:	57fd                	li	a5,-1
ffffffc050401748:	8385                	srli	a5,a5,0x1
ffffffc05040174a:	8ff9                	and	a5,a5,a4
ffffffc05040174c:	00071717          	auipc	a4,0x71
ffffffc050401750:	63470713          	addi	a4,a4,1588 # ffffffc050472d80 <exc_table>
ffffffc050401754:	078e                	slli	a5,a5,0x3
ffffffc050401756:	97ba                	add	a5,a5,a4
ffffffc050401758:	639c                	ld	a5,0(a5)
ffffffc05040175a:	fd843603          	ld	a2,-40(s0)
ffffffc05040175e:	fe043583          	ld	a1,-32(s0)
ffffffc050401762:	fe843503          	ld	a0,-24(s0)
ffffffc050401766:	9782                	jalr	a5
ffffffc050401768:	0001                	nop
ffffffc05040176a:	70a2                	ld	ra,40(sp)
ffffffc05040176c:	7402                	ld	s0,32(sp)
ffffffc05040176e:	6145                	addi	sp,sp,48
ffffffc050401770:	8082                	ret

ffffffc050401772 <handle_int>:
ffffffc050401772:	7179                	addi	sp,sp,-48
ffffffc050401774:	f406                	sd	ra,40(sp)
ffffffc050401776:	f022                	sd	s0,32(sp)
ffffffc050401778:	1800                	addi	s0,sp,48
ffffffc05040177a:	fea43423          	sd	a0,-24(s0)
ffffffc05040177e:	feb43023          	sd	a1,-32(s0)
ffffffc050401782:	fcc43c23          	sd	a2,-40(s0)
ffffffc050401786:	f0dff0ef          	jal	ra,ffffffc050401692 <reset_irq_timer>
ffffffc05040178a:	0001                	nop
ffffffc05040178c:	70a2                	ld	ra,40(sp)
ffffffc05040178e:	7402                	ld	s0,32(sp)
ffffffc050401790:	6145                	addi	sp,sp,48
ffffffc050401792:	8082                	ret

ffffffc050401794 <handle_pgfault>:
ffffffc050401794:	7139                	addi	sp,sp,-64
ffffffc050401796:	fc06                	sd	ra,56(sp)
ffffffc050401798:	f822                	sd	s0,48(sp)
ffffffc05040179a:	0080                	addi	s0,sp,64
ffffffc05040179c:	fca43c23          	sd	a0,-40(s0)
ffffffc0504017a0:	fcb43823          	sd	a1,-48(s0)
ffffffc0504017a4:	fcc43423          	sd	a2,-56(s0)
ffffffc0504017a8:	fc843703          	ld	a4,-56(s0)
ffffffc0504017ac:	47b1                	li	a5,12
ffffffc0504017ae:	00f71563          	bne	a4,a5,ffffffc0504017b8 <handle_pgfault+0x24>
ffffffc0504017b2:	519010ef          	jal	ra,ffffffc0504034ca <do_exit>
ffffffc0504017b6:	a805                	j	ffffffc0504017e6 <handle_pgfault+0x52>
ffffffc0504017b8:	b89fe0ef          	jal	ra,ffffffc050400340 <get_current_cpu_id>
ffffffc0504017bc:	87aa                	mv	a5,a0
ffffffc0504017be:	fef42623          	sw	a5,-20(s0)
ffffffc0504017c2:	fd843783          	ld	a5,-40(s0)
ffffffc0504017c6:	1107b683          	ld	a3,272(a5)
ffffffc0504017ca:	00071717          	auipc	a4,0x71
ffffffc0504017ce:	6c670713          	addi	a4,a4,1734 # ffffffc050472e90 <current_running>
ffffffc0504017d2:	fec42783          	lw	a5,-20(s0)
ffffffc0504017d6:	078e                	slli	a5,a5,0x3
ffffffc0504017d8:	97ba                	add	a5,a5,a4
ffffffc0504017da:	639c                	ld	a5,0(a5)
ffffffc0504017dc:	6bdc                	ld	a5,144(a5)
ffffffc0504017de:	85be                	mv	a1,a5
ffffffc0504017e0:	8536                	mv	a0,a3
ffffffc0504017e2:	640040ef          	jal	ra,ffffffc050405e22 <alloc_page_helper>
ffffffc0504017e6:	0001                	nop
ffffffc0504017e8:	70e2                	ld	ra,56(sp)
ffffffc0504017ea:	7442                	ld	s0,48(sp)
ffffffc0504017ec:	6121                	addi	sp,sp,64
ffffffc0504017ee:	8082                	ret

ffffffc0504017f0 <init_exception>:
ffffffc0504017f0:	1141                	addi	sp,sp,-16
ffffffc0504017f2:	e406                	sd	ra,8(sp)
ffffffc0504017f4:	e022                	sd	s0,0(sp)
ffffffc0504017f6:	0800                	addi	s0,sp,16
ffffffc0504017f8:	00071797          	auipc	a5,0x71
ffffffc0504017fc:	61078793          	addi	a5,a5,1552 # ffffffc050472e08 <irq_table>
ffffffc050401800:	00000717          	auipc	a4,0x0
ffffffc050401804:	1c870713          	addi	a4,a4,456 # ffffffc0504019c8 <handle_other>
ffffffc050401808:	e398                	sd	a4,0(a5)
ffffffc05040180a:	00071797          	auipc	a5,0x71
ffffffc05040180e:	5fe78793          	addi	a5,a5,1534 # ffffffc050472e08 <irq_table>
ffffffc050401812:	00000717          	auipc	a4,0x0
ffffffc050401816:	1b670713          	addi	a4,a4,438 # ffffffc0504019c8 <handle_other>
ffffffc05040181a:	e798                	sd	a4,8(a5)
ffffffc05040181c:	00071797          	auipc	a5,0x71
ffffffc050401820:	5ec78793          	addi	a5,a5,1516 # ffffffc050472e08 <irq_table>
ffffffc050401824:	00000717          	auipc	a4,0x0
ffffffc050401828:	1a470713          	addi	a4,a4,420 # ffffffc0504019c8 <handle_other>
ffffffc05040182c:	eb98                	sd	a4,16(a5)
ffffffc05040182e:	00071797          	auipc	a5,0x71
ffffffc050401832:	5da78793          	addi	a5,a5,1498 # ffffffc050472e08 <irq_table>
ffffffc050401836:	00000717          	auipc	a4,0x0
ffffffc05040183a:	19270713          	addi	a4,a4,402 # ffffffc0504019c8 <handle_other>
ffffffc05040183e:	ef98                	sd	a4,24(a5)
ffffffc050401840:	00071797          	auipc	a5,0x71
ffffffc050401844:	5c878793          	addi	a5,a5,1480 # ffffffc050472e08 <irq_table>
ffffffc050401848:	00000717          	auipc	a4,0x0
ffffffc05040184c:	18070713          	addi	a4,a4,384 # ffffffc0504019c8 <handle_other>
ffffffc050401850:	f398                	sd	a4,32(a5)
ffffffc050401852:	00071797          	auipc	a5,0x71
ffffffc050401856:	5b678793          	addi	a5,a5,1462 # ffffffc050472e08 <irq_table>
ffffffc05040185a:	00000717          	auipc	a4,0x0
ffffffc05040185e:	f1870713          	addi	a4,a4,-232 # ffffffc050401772 <handle_int>
ffffffc050401862:	f798                	sd	a4,40(a5)
ffffffc050401864:	00071797          	auipc	a5,0x71
ffffffc050401868:	5a478793          	addi	a5,a5,1444 # ffffffc050472e08 <irq_table>
ffffffc05040186c:	00000717          	auipc	a4,0x0
ffffffc050401870:	15c70713          	addi	a4,a4,348 # ffffffc0504019c8 <handle_other>
ffffffc050401874:	fb98                	sd	a4,48(a5)
ffffffc050401876:	00071797          	auipc	a5,0x71
ffffffc05040187a:	59278793          	addi	a5,a5,1426 # ffffffc050472e08 <irq_table>
ffffffc05040187e:	00000717          	auipc	a4,0x0
ffffffc050401882:	14a70713          	addi	a4,a4,330 # ffffffc0504019c8 <handle_other>
ffffffc050401886:	ff98                	sd	a4,56(a5)
ffffffc050401888:	00071797          	auipc	a5,0x71
ffffffc05040188c:	58078793          	addi	a5,a5,1408 # ffffffc050472e08 <irq_table>
ffffffc050401890:	00000717          	auipc	a4,0x0
ffffffc050401894:	13870713          	addi	a4,a4,312 # ffffffc0504019c8 <handle_other>
ffffffc050401898:	e3b8                	sd	a4,64(a5)
ffffffc05040189a:	00071797          	auipc	a5,0x71
ffffffc05040189e:	56e78793          	addi	a5,a5,1390 # ffffffc050472e08 <irq_table>
ffffffc0504018a2:	00000717          	auipc	a4,0x0
ffffffc0504018a6:	12670713          	addi	a4,a4,294 # ffffffc0504019c8 <handle_other>
ffffffc0504018aa:	e7b8                	sd	a4,72(a5)
ffffffc0504018ac:	00071797          	auipc	a5,0x71
ffffffc0504018b0:	55c78793          	addi	a5,a5,1372 # ffffffc050472e08 <irq_table>
ffffffc0504018b4:	00000717          	auipc	a4,0x0
ffffffc0504018b8:	11470713          	addi	a4,a4,276 # ffffffc0504019c8 <handle_other>
ffffffc0504018bc:	ebb8                	sd	a4,80(a5)
ffffffc0504018be:	00071797          	auipc	a5,0x71
ffffffc0504018c2:	54a78793          	addi	a5,a5,1354 # ffffffc050472e08 <irq_table>
ffffffc0504018c6:	00000717          	auipc	a4,0x0
ffffffc0504018ca:	10270713          	addi	a4,a4,258 # ffffffc0504019c8 <handle_other>
ffffffc0504018ce:	efb8                	sd	a4,88(a5)
ffffffc0504018d0:	00071797          	auipc	a5,0x71
ffffffc0504018d4:	4b078793          	addi	a5,a5,1200 # ffffffc050472d80 <exc_table>
ffffffc0504018d8:	00000717          	auipc	a4,0x0
ffffffc0504018dc:	0f070713          	addi	a4,a4,240 # ffffffc0504019c8 <handle_other>
ffffffc0504018e0:	e398                	sd	a4,0(a5)
ffffffc0504018e2:	00071797          	auipc	a5,0x71
ffffffc0504018e6:	49e78793          	addi	a5,a5,1182 # ffffffc050472d80 <exc_table>
ffffffc0504018ea:	00000717          	auipc	a4,0x0
ffffffc0504018ee:	0de70713          	addi	a4,a4,222 # ffffffc0504019c8 <handle_other>
ffffffc0504018f2:	e798                	sd	a4,8(a5)
ffffffc0504018f4:	00071797          	auipc	a5,0x71
ffffffc0504018f8:	48c78793          	addi	a5,a5,1164 # ffffffc050472d80 <exc_table>
ffffffc0504018fc:	00000717          	auipc	a4,0x0
ffffffc050401900:	0cc70713          	addi	a4,a4,204 # ffffffc0504019c8 <handle_other>
ffffffc050401904:	eb98                	sd	a4,16(a5)
ffffffc050401906:	00071797          	auipc	a5,0x71
ffffffc05040190a:	47a78793          	addi	a5,a5,1146 # ffffffc050472d80 <exc_table>
ffffffc05040190e:	00000717          	auipc	a4,0x0
ffffffc050401912:	0ba70713          	addi	a4,a4,186 # ffffffc0504019c8 <handle_other>
ffffffc050401916:	ef98                	sd	a4,24(a5)
ffffffc050401918:	00071797          	auipc	a5,0x71
ffffffc05040191c:	46878793          	addi	a5,a5,1128 # ffffffc050472d80 <exc_table>
ffffffc050401920:	00000717          	auipc	a4,0x0
ffffffc050401924:	0a870713          	addi	a4,a4,168 # ffffffc0504019c8 <handle_other>
ffffffc050401928:	f398                	sd	a4,32(a5)
ffffffc05040192a:	00071797          	auipc	a5,0x71
ffffffc05040192e:	45678793          	addi	a5,a5,1110 # ffffffc050472d80 <exc_table>
ffffffc050401932:	00000717          	auipc	a4,0x0
ffffffc050401936:	09670713          	addi	a4,a4,150 # ffffffc0504019c8 <handle_other>
ffffffc05040193a:	f798                	sd	a4,40(a5)
ffffffc05040193c:	00071797          	auipc	a5,0x71
ffffffc050401940:	44478793          	addi	a5,a5,1092 # ffffffc050472d80 <exc_table>
ffffffc050401944:	00000717          	auipc	a4,0x0
ffffffc050401948:	08470713          	addi	a4,a4,132 # ffffffc0504019c8 <handle_other>
ffffffc05040194c:	fb98                	sd	a4,48(a5)
ffffffc05040194e:	00071797          	auipc	a5,0x71
ffffffc050401952:	43278793          	addi	a5,a5,1074 # ffffffc050472d80 <exc_table>
ffffffc050401956:	00000717          	auipc	a4,0x0
ffffffc05040195a:	07270713          	addi	a4,a4,114 # ffffffc0504019c8 <handle_other>
ffffffc05040195e:	ff98                	sd	a4,56(a5)
ffffffc050401960:	00071797          	auipc	a5,0x71
ffffffc050401964:	42078793          	addi	a5,a5,1056 # ffffffc050472d80 <exc_table>
ffffffc050401968:	00004717          	auipc	a4,0x4
ffffffc05040196c:	7a470713          	addi	a4,a4,1956 # ffffffc05040610c <handle_syscall>
ffffffc050401970:	e3b8                	sd	a4,64(a5)
ffffffc050401972:	00071797          	auipc	a5,0x71
ffffffc050401976:	40e78793          	addi	a5,a5,1038 # ffffffc050472d80 <exc_table>
ffffffc05040197a:	00000717          	auipc	a4,0x0
ffffffc05040197e:	e1a70713          	addi	a4,a4,-486 # ffffffc050401794 <handle_pgfault>
ffffffc050401982:	f3b8                	sd	a4,96(a5)
ffffffc050401984:	00071797          	auipc	a5,0x71
ffffffc050401988:	3fc78793          	addi	a5,a5,1020 # ffffffc050472d80 <exc_table>
ffffffc05040198c:	00000717          	auipc	a4,0x0
ffffffc050401990:	e0870713          	addi	a4,a4,-504 # ffffffc050401794 <handle_pgfault>
ffffffc050401994:	f7b8                	sd	a4,104(a5)
ffffffc050401996:	00071797          	auipc	a5,0x71
ffffffc05040199a:	3ea78793          	addi	a5,a5,1002 # ffffffc050472d80 <exc_table>
ffffffc05040199e:	00000717          	auipc	a4,0x0
ffffffc0504019a2:	02a70713          	addi	a4,a4,42 # ffffffc0504019c8 <handle_other>
ffffffc0504019a6:	fbb8                	sd	a4,112(a5)
ffffffc0504019a8:	00071797          	auipc	a5,0x71
ffffffc0504019ac:	3d878793          	addi	a5,a5,984 # ffffffc050472d80 <exc_table>
ffffffc0504019b0:	00000717          	auipc	a4,0x0
ffffffc0504019b4:	de470713          	addi	a4,a4,-540 # ffffffc050401794 <handle_pgfault>
ffffffc0504019b8:	ffb8                	sd	a4,120(a5)
ffffffc0504019ba:	ebafe0ef          	jal	ra,ffffffc050400074 <setup_exception>
ffffffc0504019be:	0001                	nop
ffffffc0504019c0:	60a2                	ld	ra,8(sp)
ffffffc0504019c2:	6402                	ld	s0,0(sp)
ffffffc0504019c4:	0141                	addi	sp,sp,16
ffffffc0504019c6:	8082                	ret

ffffffc0504019c8 <handle_other>:
ffffffc0504019c8:	710d                	addi	sp,sp,-352
ffffffc0504019ca:	ee86                	sd	ra,344(sp)
ffffffc0504019cc:	eaa2                	sd	s0,336(sp)
ffffffc0504019ce:	1280                	addi	s0,sp,352
ffffffc0504019d0:	eaa43c23          	sd	a0,-328(s0)
ffffffc0504019d4:	eab43823          	sd	a1,-336(s0)
ffffffc0504019d8:	eac43423          	sd	a2,-344(s0)
ffffffc0504019dc:	00005717          	auipc	a4,0x5
ffffffc0504019e0:	77470713          	addi	a4,a4,1908 # ffffffc050407150 <get_elf_file+0x470>
ffffffc0504019e4:	ec840793          	addi	a5,s0,-312
ffffffc0504019e8:	86ba                	mv	a3,a4
ffffffc0504019ea:	10000713          	li	a4,256
ffffffc0504019ee:	863a                	mv	a2,a4
ffffffc0504019f0:	85b6                	mv	a1,a3
ffffffc0504019f2:	853e                	mv	a0,a5
ffffffc0504019f4:	1df040ef          	jal	ra,ffffffc0504063d2 <memcpy>
ffffffc0504019f8:	fe042623          	sw	zero,-20(s0)
ffffffc0504019fc:	a061                	j	ffffffc050401a84 <handle_other+0xbc>
ffffffc0504019fe:	fe042423          	sw	zero,-24(s0)
ffffffc050401a02:	a0a9                	j	ffffffc050401a4c <handle_other+0x84>
ffffffc050401a04:	fec42703          	lw	a4,-20(s0)
ffffffc050401a08:	fe842783          	lw	a5,-24(s0)
ffffffc050401a0c:	9fb9                	addw	a5,a5,a4
ffffffc050401a0e:	2781                	sext.w	a5,a5
ffffffc050401a10:	078e                	slli	a5,a5,0x3
ffffffc050401a12:	ff040713          	addi	a4,s0,-16
ffffffc050401a16:	97ba                	add	a5,a5,a4
ffffffc050401a18:	ed87b683          	ld	a3,-296(a5)
ffffffc050401a1c:	fec42703          	lw	a4,-20(s0)
ffffffc050401a20:	fe842783          	lw	a5,-24(s0)
ffffffc050401a24:	9fb9                	addw	a5,a5,a4
ffffffc050401a26:	2781                	sext.w	a5,a5
ffffffc050401a28:	eb843703          	ld	a4,-328(s0)
ffffffc050401a2c:	078e                	slli	a5,a5,0x3
ffffffc050401a2e:	97ba                	add	a5,a5,a4
ffffffc050401a30:	639c                	ld	a5,0(a5)
ffffffc050401a32:	863e                	mv	a2,a5
ffffffc050401a34:	85b6                	mv	a1,a3
ffffffc050401a36:	00005517          	auipc	a0,0x5
ffffffc050401a3a:	65a50513          	addi	a0,a0,1626 # ffffffc050407090 <get_elf_file+0x3b0>
ffffffc050401a3e:	1c2050ef          	jal	ra,ffffffc050406c00 <printk>
ffffffc050401a42:	fe842783          	lw	a5,-24(s0)
ffffffc050401a46:	2785                	addiw	a5,a5,1
ffffffc050401a48:	fef42423          	sw	a5,-24(s0)
ffffffc050401a4c:	fe842783          	lw	a5,-24(s0)
ffffffc050401a50:	0007871b          	sext.w	a4,a5
ffffffc050401a54:	4789                	li	a5,2
ffffffc050401a56:	00e7cc63          	blt	a5,a4,ffffffc050401a6e <handle_other+0xa6>
ffffffc050401a5a:	fec42703          	lw	a4,-20(s0)
ffffffc050401a5e:	fe842783          	lw	a5,-24(s0)
ffffffc050401a62:	9fb9                	addw	a5,a5,a4
ffffffc050401a64:	2781                	sext.w	a5,a5
ffffffc050401a66:	873e                	mv	a4,a5
ffffffc050401a68:	47fd                	li	a5,31
ffffffc050401a6a:	f8e7dde3          	bge	a5,a4,ffffffc050401a04 <handle_other+0x3c>
ffffffc050401a6e:	00005517          	auipc	a0,0x5
ffffffc050401a72:	63250513          	addi	a0,a0,1586 # ffffffc0504070a0 <get_elf_file+0x3c0>
ffffffc050401a76:	18a050ef          	jal	ra,ffffffc050406c00 <printk>
ffffffc050401a7a:	fec42783          	lw	a5,-20(s0)
ffffffc050401a7e:	278d                	addiw	a5,a5,3
ffffffc050401a80:	fef42623          	sw	a5,-20(s0)
ffffffc050401a84:	fec42783          	lw	a5,-20(s0)
ffffffc050401a88:	0007871b          	sext.w	a4,a5
ffffffc050401a8c:	47fd                	li	a5,31
ffffffc050401a8e:	f6e7d8e3          	bge	a5,a4,ffffffc0504019fe <handle_other+0x36>
ffffffc050401a92:	eb843783          	ld	a5,-328(s0)
ffffffc050401a96:	1007b703          	ld	a4,256(a5)
ffffffc050401a9a:	eb843783          	ld	a5,-328(s0)
ffffffc050401a9e:	1107b603          	ld	a2,272(a5)
ffffffc050401aa2:	eb843783          	ld	a5,-328(s0)
ffffffc050401aa6:	1187b783          	ld	a5,280(a5)
ffffffc050401aaa:	86be                	mv	a3,a5
ffffffc050401aac:	85ba                	mv	a1,a4
ffffffc050401aae:	00005517          	auipc	a0,0x5
ffffffc050401ab2:	5fa50513          	addi	a0,a0,1530 # ffffffc0504070a8 <get_elf_file+0x3c8>
ffffffc050401ab6:	14a050ef          	jal	ra,ffffffc050406c00 <printk>
ffffffc050401aba:	ea843603          	ld	a2,-344(s0)
ffffffc050401abe:	eb043583          	ld	a1,-336(s0)
ffffffc050401ac2:	00005517          	auipc	a0,0x5
ffffffc050401ac6:	61650513          	addi	a0,a0,1558 # ffffffc0504070d8 <get_elf_file+0x3f8>
ffffffc050401aca:	136050ef          	jal	ra,ffffffc050406c00 <printk>
ffffffc050401ace:	eb843783          	ld	a5,-328(s0)
ffffffc050401ad2:	1087b783          	ld	a5,264(a5)
ffffffc050401ad6:	85be                	mv	a1,a5
ffffffc050401ad8:	00005517          	auipc	a0,0x5
ffffffc050401adc:	62050513          	addi	a0,a0,1568 # ffffffc0504070f8 <get_elf_file+0x418>
ffffffc050401ae0:	120050ef          	jal	ra,ffffffc050406c00 <printk>
ffffffc050401ae4:	eb843783          	ld	a5,-328(s0)
ffffffc050401ae8:	63bc                	ld	a5,64(a5)
ffffffc050401aea:	fef43023          	sd	a5,-32(s0)
ffffffc050401aee:	eb843783          	ld	a5,-328(s0)
ffffffc050401af2:	6b9c                	ld	a5,16(a5)
ffffffc050401af4:	fcf43c23          	sd	a5,-40(s0)
ffffffc050401af8:	00005517          	auipc	a0,0x5
ffffffc050401afc:	61050513          	addi	a0,a0,1552 # ffffffc050407108 <get_elf_file+0x428>
ffffffc050401b00:	100050ef          	jal	ra,ffffffc050406c00 <printk>
ffffffc050401b04:	eb843783          	ld	a5,-328(s0)
ffffffc050401b08:	679c                	ld	a5,8(a5)
ffffffc050401b0a:	17f1                	addi	a5,a5,-4
ffffffc050401b0c:	fe043683          	ld	a3,-32(s0)
ffffffc050401b10:	fd843603          	ld	a2,-40(s0)
ffffffc050401b14:	85be                	mv	a1,a5
ffffffc050401b16:	00005517          	auipc	a0,0x5
ffffffc050401b1a:	60250513          	addi	a0,a0,1538 # ffffffc050407118 <get_elf_file+0x438>
ffffffc050401b1e:	0e2050ef          	jal	ra,ffffffc050406c00 <printk>
ffffffc050401b22:	a83d                	j	ffffffc050401b60 <handle_other+0x198>
ffffffc050401b24:	fe043783          	ld	a5,-32(s0)
ffffffc050401b28:	17e1                	addi	a5,a5,-8
ffffffc050401b2a:	639c                	ld	a5,0(a5)
ffffffc050401b2c:	fcf43823          	sd	a5,-48(s0)
ffffffc050401b30:	fe043783          	ld	a5,-32(s0)
ffffffc050401b34:	17c1                	addi	a5,a5,-16
ffffffc050401b36:	639c                	ld	a5,0(a5)
ffffffc050401b38:	fcf43423          	sd	a5,-56(s0)
ffffffc050401b3c:	fd043783          	ld	a5,-48(s0)
ffffffc050401b40:	17f1                	addi	a5,a5,-4
ffffffc050401b42:	fc843683          	ld	a3,-56(s0)
ffffffc050401b46:	fe043603          	ld	a2,-32(s0)
ffffffc050401b4a:	85be                	mv	a1,a5
ffffffc050401b4c:	00005517          	auipc	a0,0x5
ffffffc050401b50:	5cc50513          	addi	a0,a0,1484 # ffffffc050407118 <get_elf_file+0x438>
ffffffc050401b54:	0ac050ef          	jal	ra,ffffffc050406c00 <printk>
ffffffc050401b58:	fc843783          	ld	a5,-56(s0)
ffffffc050401b5c:	fef43023          	sd	a5,-32(s0)
ffffffc050401b60:	fe043703          	ld	a4,-32(s0)
ffffffc050401b64:	67c1                	lui	a5,0x10
ffffffc050401b66:	fae7efe3          	bltu	a5,a4,ffffffc050401b24 <handle_other+0x15c>
ffffffc050401b6a:	00005617          	auipc	a2,0x5
ffffffc050401b6e:	6e660613          	addi	a2,a2,1766 # ffffffc050407250 <__FUNCTION__.1563>
ffffffc050401b72:	0a000593          	li	a1,160
ffffffc050401b76:	00005517          	auipc	a0,0x5
ffffffc050401b7a:	5c250513          	addi	a0,a0,1474 # ffffffc050407138 <get_elf_file+0x458>
ffffffc050401b7e:	ae3ff0ef          	jal	ra,ffffffc050401660 <_panic>
ffffffc050401b82:	0001                	nop
ffffffc050401b84:	60f6                	ld	ra,344(sp)
ffffffc050401b86:	6456                	ld	s0,336(sp)
ffffffc050401b88:	6135                	addi	sp,sp,352
ffffffc050401b8a:	8082                	ret

ffffffc050401b8c <vt100_move_cursor>:
ffffffc050401b8c:	7179                	addi	sp,sp,-48
ffffffc050401b8e:	f406                	sd	ra,40(sp)
ffffffc050401b90:	f022                	sd	s0,32(sp)
ffffffc050401b92:	1800                	addi	s0,sp,48
ffffffc050401b94:	87aa                	mv	a5,a0
ffffffc050401b96:	872e                	mv	a4,a1
ffffffc050401b98:	fcf42e23          	sw	a5,-36(s0)
ffffffc050401b9c:	87ba                	mv	a5,a4
ffffffc050401b9e:	fcf42c23          	sw	a5,-40(s0)
ffffffc050401ba2:	f9efe0ef          	jal	ra,ffffffc050400340 <get_current_cpu_id>
ffffffc050401ba6:	87aa                	mv	a5,a0
ffffffc050401ba8:	fef42623          	sw	a5,-20(s0)
ffffffc050401bac:	fdc42703          	lw	a4,-36(s0)
ffffffc050401bb0:	fd842783          	lw	a5,-40(s0)
ffffffc050401bb4:	86ba                	mv	a3,a4
ffffffc050401bb6:	863e                	mv	a2,a5
ffffffc050401bb8:	45ed                	li	a1,27
ffffffc050401bba:	00005517          	auipc	a0,0x5
ffffffc050401bbe:	6a650513          	addi	a0,a0,1702 # ffffffc050407260 <__FUNCTION__.1563+0x10>
ffffffc050401bc2:	03e050ef          	jal	ra,ffffffc050406c00 <printk>
ffffffc050401bc6:	00071717          	auipc	a4,0x71
ffffffc050401bca:	2ca70713          	addi	a4,a4,714 # ffffffc050472e90 <current_running>
ffffffc050401bce:	fec42783          	lw	a5,-20(s0)
ffffffc050401bd2:	078e                	slli	a5,a5,0x3
ffffffc050401bd4:	97ba                	add	a5,a5,a4
ffffffc050401bd6:	639c                	ld	a5,0(a5)
ffffffc050401bd8:	fdc42703          	lw	a4,-36(s0)
ffffffc050401bdc:	08e7a423          	sw	a4,136(a5) # 10088 <_start-0xffffffc0503eff78>
ffffffc050401be0:	00071717          	auipc	a4,0x71
ffffffc050401be4:	2b070713          	addi	a4,a4,688 # ffffffc050472e90 <current_running>
ffffffc050401be8:	fec42783          	lw	a5,-20(s0)
ffffffc050401bec:	078e                	slli	a5,a5,0x3
ffffffc050401bee:	97ba                	add	a5,a5,a4
ffffffc050401bf0:	639c                	ld	a5,0(a5)
ffffffc050401bf2:	fd842703          	lw	a4,-40(s0)
ffffffc050401bf6:	08e7a623          	sw	a4,140(a5)
ffffffc050401bfa:	0001                	nop
ffffffc050401bfc:	70a2                	ld	ra,40(sp)
ffffffc050401bfe:	7402                	ld	s0,32(sp)
ffffffc050401c00:	6145                	addi	sp,sp,48
ffffffc050401c02:	8082                	ret

ffffffc050401c04 <vt100_clear>:
ffffffc050401c04:	1141                	addi	sp,sp,-16
ffffffc050401c06:	e406                	sd	ra,8(sp)
ffffffc050401c08:	e022                	sd	s0,0(sp)
ffffffc050401c0a:	0800                	addi	s0,sp,16
ffffffc050401c0c:	45ed                	li	a1,27
ffffffc050401c0e:	00005517          	auipc	a0,0x5
ffffffc050401c12:	66250513          	addi	a0,a0,1634 # ffffffc050407270 <__FUNCTION__.1563+0x20>
ffffffc050401c16:	7eb040ef          	jal	ra,ffffffc050406c00 <printk>
ffffffc050401c1a:	0001                	nop
ffffffc050401c1c:	60a2                	ld	ra,8(sp)
ffffffc050401c1e:	6402                	ld	s0,0(sp)
ffffffc050401c20:	0141                	addi	sp,sp,16
ffffffc050401c22:	8082                	ret

ffffffc050401c24 <vt100_hidden_cursor>:
ffffffc050401c24:	1141                	addi	sp,sp,-16
ffffffc050401c26:	e406                	sd	ra,8(sp)
ffffffc050401c28:	e022                	sd	s0,0(sp)
ffffffc050401c2a:	0800                	addi	s0,sp,16
ffffffc050401c2c:	45ed                	li	a1,27
ffffffc050401c2e:	00005517          	auipc	a0,0x5
ffffffc050401c32:	64a50513          	addi	a0,a0,1610 # ffffffc050407278 <__FUNCTION__.1563+0x28>
ffffffc050401c36:	7cb040ef          	jal	ra,ffffffc050406c00 <printk>
ffffffc050401c3a:	0001                	nop
ffffffc050401c3c:	60a2                	ld	ra,8(sp)
ffffffc050401c3e:	6402                	ld	s0,0(sp)
ffffffc050401c40:	0141                	addi	sp,sp,16
ffffffc050401c42:	8082                	ret

ffffffc050401c44 <screen_write_ch>:
ffffffc050401c44:	7179                	addi	sp,sp,-48
ffffffc050401c46:	f406                	sd	ra,40(sp)
ffffffc050401c48:	f022                	sd	s0,32(sp)
ffffffc050401c4a:	1800                	addi	s0,sp,48
ffffffc050401c4c:	87aa                	mv	a5,a0
ffffffc050401c4e:	fcf40fa3          	sb	a5,-33(s0)
ffffffc050401c52:	eeefe0ef          	jal	ra,ffffffc050400340 <get_current_cpu_id>
ffffffc050401c56:	87aa                	mv	a5,a0
ffffffc050401c58:	fef42623          	sw	a5,-20(s0)
ffffffc050401c5c:	fdf44783          	lbu	a5,-33(s0)
ffffffc050401c60:	0ff7f713          	andi	a4,a5,255
ffffffc050401c64:	47a9                	li	a5,10
ffffffc050401c66:	00f70963          	beq	a4,a5,ffffffc050401c78 <screen_write_ch+0x34>
ffffffc050401c6a:	fdf44783          	lbu	a5,-33(s0)
ffffffc050401c6e:	0ff7f713          	andi	a4,a5,255
ffffffc050401c72:	47b5                	li	a5,13
ffffffc050401c74:	04f71263          	bne	a4,a5,ffffffc050401cb8 <screen_write_ch+0x74>
ffffffc050401c78:	00071717          	auipc	a4,0x71
ffffffc050401c7c:	1f070713          	addi	a4,a4,496 # ffffffc050472e68 <screen_cursor_x>
ffffffc050401c80:	fec42783          	lw	a5,-20(s0)
ffffffc050401c84:	078a                	slli	a5,a5,0x2
ffffffc050401c86:	97ba                	add	a5,a5,a4
ffffffc050401c88:	0007a023          	sw	zero,0(a5)
ffffffc050401c8c:	00071717          	auipc	a4,0x71
ffffffc050401c90:	1e470713          	addi	a4,a4,484 # ffffffc050472e70 <screen_cursor_y>
ffffffc050401c94:	fec42783          	lw	a5,-20(s0)
ffffffc050401c98:	078a                	slli	a5,a5,0x2
ffffffc050401c9a:	97ba                	add	a5,a5,a4
ffffffc050401c9c:	439c                	lw	a5,0(a5)
ffffffc050401c9e:	2785                	addiw	a5,a5,1
ffffffc050401ca0:	0007871b          	sext.w	a4,a5
ffffffc050401ca4:	00071697          	auipc	a3,0x71
ffffffc050401ca8:	1cc68693          	addi	a3,a3,460 # ffffffc050472e70 <screen_cursor_y>
ffffffc050401cac:	fec42783          	lw	a5,-20(s0)
ffffffc050401cb0:	078a                	slli	a5,a5,0x2
ffffffc050401cb2:	97b6                	add	a5,a5,a3
ffffffc050401cb4:	c398                	sw	a4,0(a5)
ffffffc050401cb6:	a239                	j	ffffffc050401dc4 <screen_write_ch+0x180>
ffffffc050401cb8:	fdf44783          	lbu	a5,-33(s0)
ffffffc050401cbc:	0ff7f713          	andi	a4,a5,255
ffffffc050401cc0:	47a1                	li	a5,8
ffffffc050401cc2:	00f70a63          	beq	a4,a5,ffffffc050401cd6 <screen_write_ch+0x92>
ffffffc050401cc6:	fdf44783          	lbu	a5,-33(s0)
ffffffc050401cca:	0ff7f713          	andi	a4,a5,255
ffffffc050401cce:	07f00793          	li	a5,127
ffffffc050401cd2:	06f71e63          	bne	a4,a5,ffffffc050401d4e <screen_write_ch+0x10a>
ffffffc050401cd6:	00071717          	auipc	a4,0x71
ffffffc050401cda:	19270713          	addi	a4,a4,402 # ffffffc050472e68 <screen_cursor_x>
ffffffc050401cde:	fec42783          	lw	a5,-20(s0)
ffffffc050401ce2:	078a                	slli	a5,a5,0x2
ffffffc050401ce4:	97ba                	add	a5,a5,a4
ffffffc050401ce6:	439c                	lw	a5,0(a5)
ffffffc050401ce8:	37fd                	addiw	a5,a5,-1
ffffffc050401cea:	0007871b          	sext.w	a4,a5
ffffffc050401cee:	00071697          	auipc	a3,0x71
ffffffc050401cf2:	17a68693          	addi	a3,a3,378 # ffffffc050472e68 <screen_cursor_x>
ffffffc050401cf6:	fec42783          	lw	a5,-20(s0)
ffffffc050401cfa:	078a                	slli	a5,a5,0x2
ffffffc050401cfc:	97b6                	add	a5,a5,a3
ffffffc050401cfe:	c398                	sw	a4,0(a5)
ffffffc050401d00:	00071717          	auipc	a4,0x71
ffffffc050401d04:	17070713          	addi	a4,a4,368 # ffffffc050472e70 <screen_cursor_y>
ffffffc050401d08:	fec42783          	lw	a5,-20(s0)
ffffffc050401d0c:	078a                	slli	a5,a5,0x2
ffffffc050401d0e:	97ba                	add	a5,a5,a4
ffffffc050401d10:	439c                	lw	a5,0(a5)
ffffffc050401d12:	873e                	mv	a4,a5
ffffffc050401d14:	87ba                	mv	a5,a4
ffffffc050401d16:	0027979b          	slliw	a5,a5,0x2
ffffffc050401d1a:	9fb9                	addw	a5,a5,a4
ffffffc050401d1c:	0047979b          	slliw	a5,a5,0x4
ffffffc050401d20:	0007871b          	sext.w	a4,a5
ffffffc050401d24:	00071697          	auipc	a3,0x71
ffffffc050401d28:	14468693          	addi	a3,a3,324 # ffffffc050472e68 <screen_cursor_x>
ffffffc050401d2c:	fec42783          	lw	a5,-20(s0)
ffffffc050401d30:	078a                	slli	a5,a5,0x2
ffffffc050401d32:	97b6                	add	a5,a5,a3
ffffffc050401d34:	439c                	lw	a5,0(a5)
ffffffc050401d36:	9fb9                	addw	a5,a5,a4
ffffffc050401d38:	2781                	sext.w	a5,a5
ffffffc050401d3a:	0005e717          	auipc	a4,0x5e
ffffffc050401d3e:	c1670713          	addi	a4,a4,-1002 # ffffffc05045f950 <new_screen>
ffffffc050401d42:	97ba                	add	a5,a5,a4
ffffffc050401d44:	02000713          	li	a4,32
ffffffc050401d48:	00e78023          	sb	a4,0(a5)
ffffffc050401d4c:	a8a5                	j	ffffffc050401dc4 <screen_write_ch+0x180>
ffffffc050401d4e:	00071717          	auipc	a4,0x71
ffffffc050401d52:	12270713          	addi	a4,a4,290 # ffffffc050472e70 <screen_cursor_y>
ffffffc050401d56:	fec42783          	lw	a5,-20(s0)
ffffffc050401d5a:	078a                	slli	a5,a5,0x2
ffffffc050401d5c:	97ba                	add	a5,a5,a4
ffffffc050401d5e:	439c                	lw	a5,0(a5)
ffffffc050401d60:	873e                	mv	a4,a5
ffffffc050401d62:	87ba                	mv	a5,a4
ffffffc050401d64:	0027979b          	slliw	a5,a5,0x2
ffffffc050401d68:	9fb9                	addw	a5,a5,a4
ffffffc050401d6a:	0047979b          	slliw	a5,a5,0x4
ffffffc050401d6e:	0007871b          	sext.w	a4,a5
ffffffc050401d72:	00071697          	auipc	a3,0x71
ffffffc050401d76:	0f668693          	addi	a3,a3,246 # ffffffc050472e68 <screen_cursor_x>
ffffffc050401d7a:	fec42783          	lw	a5,-20(s0)
ffffffc050401d7e:	078a                	slli	a5,a5,0x2
ffffffc050401d80:	97b6                	add	a5,a5,a3
ffffffc050401d82:	439c                	lw	a5,0(a5)
ffffffc050401d84:	9fb9                	addw	a5,a5,a4
ffffffc050401d86:	2781                	sext.w	a5,a5
ffffffc050401d88:	0005e717          	auipc	a4,0x5e
ffffffc050401d8c:	bc870713          	addi	a4,a4,-1080 # ffffffc05045f950 <new_screen>
ffffffc050401d90:	97ba                	add	a5,a5,a4
ffffffc050401d92:	fdf44703          	lbu	a4,-33(s0)
ffffffc050401d96:	00e78023          	sb	a4,0(a5)
ffffffc050401d9a:	00071717          	auipc	a4,0x71
ffffffc050401d9e:	0ce70713          	addi	a4,a4,206 # ffffffc050472e68 <screen_cursor_x>
ffffffc050401da2:	fec42783          	lw	a5,-20(s0)
ffffffc050401da6:	078a                	slli	a5,a5,0x2
ffffffc050401da8:	97ba                	add	a5,a5,a4
ffffffc050401daa:	439c                	lw	a5,0(a5)
ffffffc050401dac:	2785                	addiw	a5,a5,1
ffffffc050401dae:	0007871b          	sext.w	a4,a5
ffffffc050401db2:	00071697          	auipc	a3,0x71
ffffffc050401db6:	0b668693          	addi	a3,a3,182 # ffffffc050472e68 <screen_cursor_x>
ffffffc050401dba:	fec42783          	lw	a5,-20(s0)
ffffffc050401dbe:	078a                	slli	a5,a5,0x2
ffffffc050401dc0:	97b6                	add	a5,a5,a3
ffffffc050401dc2:	c398                	sw	a4,0(a5)
ffffffc050401dc4:	00071717          	auipc	a4,0x71
ffffffc050401dc8:	0a470713          	addi	a4,a4,164 # ffffffc050472e68 <screen_cursor_x>
ffffffc050401dcc:	fec42783          	lw	a5,-20(s0)
ffffffc050401dd0:	078a                	slli	a5,a5,0x2
ffffffc050401dd2:	97ba                	add	a5,a5,a4
ffffffc050401dd4:	439c                	lw	a5,0(a5)
ffffffc050401dd6:	0207d663          	bgez	a5,ffffffc050401e02 <screen_write_ch+0x1be>
ffffffc050401dda:	00071717          	auipc	a4,0x71
ffffffc050401dde:	08e70713          	addi	a4,a4,142 # ffffffc050472e68 <screen_cursor_x>
ffffffc050401de2:	fec42783          	lw	a5,-20(s0)
ffffffc050401de6:	078a                	slli	a5,a5,0x2
ffffffc050401de8:	97ba                	add	a5,a5,a4
ffffffc050401dea:	0007a023          	sw	zero,0(a5)
ffffffc050401dee:	00071717          	auipc	a4,0x71
ffffffc050401df2:	08270713          	addi	a4,a4,130 # ffffffc050472e70 <screen_cursor_y>
ffffffc050401df6:	fec42783          	lw	a5,-20(s0)
ffffffc050401dfa:	078a                	slli	a5,a5,0x2
ffffffc050401dfc:	97ba                	add	a5,a5,a4
ffffffc050401dfe:	0007a023          	sw	zero,0(a5)
ffffffc050401e02:	00071717          	auipc	a4,0x71
ffffffc050401e06:	06670713          	addi	a4,a4,102 # ffffffc050472e68 <screen_cursor_x>
ffffffc050401e0a:	fec42783          	lw	a5,-20(s0)
ffffffc050401e0e:	078a                	slli	a5,a5,0x2
ffffffc050401e10:	97ba                	add	a5,a5,a4
ffffffc050401e12:	439c                	lw	a5,0(a5)
ffffffc050401e14:	873e                	mv	a4,a5
ffffffc050401e16:	04f00793          	li	a5,79
ffffffc050401e1a:	04e7d163          	bge	a5,a4,ffffffc050401e5c <screen_write_ch+0x218>
ffffffc050401e1e:	00071717          	auipc	a4,0x71
ffffffc050401e22:	05270713          	addi	a4,a4,82 # ffffffc050472e70 <screen_cursor_y>
ffffffc050401e26:	fec42783          	lw	a5,-20(s0)
ffffffc050401e2a:	078a                	slli	a5,a5,0x2
ffffffc050401e2c:	97ba                	add	a5,a5,a4
ffffffc050401e2e:	439c                	lw	a5,0(a5)
ffffffc050401e30:	2785                	addiw	a5,a5,1
ffffffc050401e32:	0007871b          	sext.w	a4,a5
ffffffc050401e36:	00071697          	auipc	a3,0x71
ffffffc050401e3a:	03a68693          	addi	a3,a3,58 # ffffffc050472e70 <screen_cursor_y>
ffffffc050401e3e:	fec42783          	lw	a5,-20(s0)
ffffffc050401e42:	078a                	slli	a5,a5,0x2
ffffffc050401e44:	97b6                	add	a5,a5,a3
ffffffc050401e46:	c398                	sw	a4,0(a5)
ffffffc050401e48:	00071717          	auipc	a4,0x71
ffffffc050401e4c:	02070713          	addi	a4,a4,32 # ffffffc050472e68 <screen_cursor_x>
ffffffc050401e50:	fec42783          	lw	a5,-20(s0)
ffffffc050401e54:	078a                	slli	a5,a5,0x2
ffffffc050401e56:	97ba                	add	a5,a5,a4
ffffffc050401e58:	0007a023          	sw	zero,0(a5)
ffffffc050401e5c:	00071717          	auipc	a4,0x71
ffffffc050401e60:	01470713          	addi	a4,a4,20 # ffffffc050472e70 <screen_cursor_y>
ffffffc050401e64:	fec42783          	lw	a5,-20(s0)
ffffffc050401e68:	078a                	slli	a5,a5,0x2
ffffffc050401e6a:	97ba                	add	a5,a5,a4
ffffffc050401e6c:	439c                	lw	a5,0(a5)
ffffffc050401e6e:	0207d663          	bgez	a5,ffffffc050401e9a <screen_write_ch+0x256>
ffffffc050401e72:	00071717          	auipc	a4,0x71
ffffffc050401e76:	ffe70713          	addi	a4,a4,-2 # ffffffc050472e70 <screen_cursor_y>
ffffffc050401e7a:	fec42783          	lw	a5,-20(s0)
ffffffc050401e7e:	078a                	slli	a5,a5,0x2
ffffffc050401e80:	97ba                	add	a5,a5,a4
ffffffc050401e82:	0007a023          	sw	zero,0(a5)
ffffffc050401e86:	00071717          	auipc	a4,0x71
ffffffc050401e8a:	fe270713          	addi	a4,a4,-30 # ffffffc050472e68 <screen_cursor_x>
ffffffc050401e8e:	fec42783          	lw	a5,-20(s0)
ffffffc050401e92:	078a                	slli	a5,a5,0x2
ffffffc050401e94:	97ba                	add	a5,a5,a4
ffffffc050401e96:	0007a023          	sw	zero,0(a5)
ffffffc050401e9a:	00071717          	auipc	a4,0x71
ffffffc050401e9e:	fd670713          	addi	a4,a4,-42 # ffffffc050472e70 <screen_cursor_y>
ffffffc050401ea2:	fec42783          	lw	a5,-20(s0)
ffffffc050401ea6:	078a                	slli	a5,a5,0x2
ffffffc050401ea8:	97ba                	add	a5,a5,a4
ffffffc050401eaa:	439c                	lw	a5,0(a5)
ffffffc050401eac:	873e                	mv	a4,a5
ffffffc050401eae:	03100793          	li	a5,49
ffffffc050401eb2:	02e7d663          	bge	a5,a4,ffffffc050401ede <screen_write_ch+0x29a>
ffffffc050401eb6:	00071717          	auipc	a4,0x71
ffffffc050401eba:	fba70713          	addi	a4,a4,-70 # ffffffc050472e70 <screen_cursor_y>
ffffffc050401ebe:	fec42783          	lw	a5,-20(s0)
ffffffc050401ec2:	078a                	slli	a5,a5,0x2
ffffffc050401ec4:	97ba                	add	a5,a5,a4
ffffffc050401ec6:	0007a023          	sw	zero,0(a5)
ffffffc050401eca:	00071717          	auipc	a4,0x71
ffffffc050401ece:	f9e70713          	addi	a4,a4,-98 # ffffffc050472e68 <screen_cursor_x>
ffffffc050401ed2:	fec42783          	lw	a5,-20(s0)
ffffffc050401ed6:	078a                	slli	a5,a5,0x2
ffffffc050401ed8:	97ba                	add	a5,a5,a4
ffffffc050401eda:	0007a023          	sw	zero,0(a5)
ffffffc050401ede:	00071717          	auipc	a4,0x71
ffffffc050401ee2:	fb270713          	addi	a4,a4,-78 # ffffffc050472e90 <current_running>
ffffffc050401ee6:	fec42783          	lw	a5,-20(s0)
ffffffc050401eea:	078e                	slli	a5,a5,0x3
ffffffc050401eec:	97ba                	add	a5,a5,a4
ffffffc050401eee:	639c                	ld	a5,0(a5)
ffffffc050401ef0:	00071697          	auipc	a3,0x71
ffffffc050401ef4:	f7868693          	addi	a3,a3,-136 # ffffffc050472e68 <screen_cursor_x>
ffffffc050401ef8:	fec42703          	lw	a4,-20(s0)
ffffffc050401efc:	070a                	slli	a4,a4,0x2
ffffffc050401efe:	9736                	add	a4,a4,a3
ffffffc050401f00:	4318                	lw	a4,0(a4)
ffffffc050401f02:	08e7a423          	sw	a4,136(a5)
ffffffc050401f06:	00071717          	auipc	a4,0x71
ffffffc050401f0a:	f8a70713          	addi	a4,a4,-118 # ffffffc050472e90 <current_running>
ffffffc050401f0e:	fec42783          	lw	a5,-20(s0)
ffffffc050401f12:	078e                	slli	a5,a5,0x3
ffffffc050401f14:	97ba                	add	a5,a5,a4
ffffffc050401f16:	639c                	ld	a5,0(a5)
ffffffc050401f18:	00071697          	auipc	a3,0x71
ffffffc050401f1c:	f5868693          	addi	a3,a3,-168 # ffffffc050472e70 <screen_cursor_y>
ffffffc050401f20:	fec42703          	lw	a4,-20(s0)
ffffffc050401f24:	070a                	slli	a4,a4,0x2
ffffffc050401f26:	9736                	add	a4,a4,a3
ffffffc050401f28:	4318                	lw	a4,0(a4)
ffffffc050401f2a:	08e7a623          	sw	a4,140(a5)
ffffffc050401f2e:	0001                	nop
ffffffc050401f30:	70a2                	ld	ra,40(sp)
ffffffc050401f32:	7402                	ld	s0,32(sp)
ffffffc050401f34:	6145                	addi	sp,sp,48
ffffffc050401f36:	8082                	ret

ffffffc050401f38 <init_screen>:
ffffffc050401f38:	1141                	addi	sp,sp,-16
ffffffc050401f3a:	e406                	sd	ra,8(sp)
ffffffc050401f3c:	e022                	sd	s0,0(sp)
ffffffc050401f3e:	0800                	addi	s0,sp,16
ffffffc050401f40:	cc5ff0ef          	jal	ra,ffffffc050401c04 <vt100_clear>
ffffffc050401f44:	0001                	nop
ffffffc050401f46:	60a2                	ld	ra,8(sp)
ffffffc050401f48:	6402                	ld	s0,0(sp)
ffffffc050401f4a:	0141                	addi	sp,sp,16
ffffffc050401f4c:	8082                	ret

ffffffc050401f4e <screen_clear>:
ffffffc050401f4e:	1101                	addi	sp,sp,-32
ffffffc050401f50:	ec06                	sd	ra,24(sp)
ffffffc050401f52:	e822                	sd	s0,16(sp)
ffffffc050401f54:	1000                	addi	s0,sp,32
ffffffc050401f56:	beafe0ef          	jal	ra,ffffffc050400340 <get_current_cpu_id>
ffffffc050401f5a:	87aa                	mv	a5,a0
ffffffc050401f5c:	fef42223          	sw	a5,-28(s0)
ffffffc050401f60:	fe042623          	sw	zero,-20(s0)
ffffffc050401f64:	a041                	j	ffffffc050401fe4 <screen_clear+0x96>
ffffffc050401f66:	fe042423          	sw	zero,-24(s0)
ffffffc050401f6a:	a085                	j	ffffffc050401fca <screen_clear+0x7c>
ffffffc050401f6c:	fec42703          	lw	a4,-20(s0)
ffffffc050401f70:	87ba                	mv	a5,a4
ffffffc050401f72:	0027979b          	slliw	a5,a5,0x2
ffffffc050401f76:	9fb9                	addw	a5,a5,a4
ffffffc050401f78:	0047979b          	slliw	a5,a5,0x4
ffffffc050401f7c:	2781                	sext.w	a5,a5
ffffffc050401f7e:	fe842703          	lw	a4,-24(s0)
ffffffc050401f82:	9fb9                	addw	a5,a5,a4
ffffffc050401f84:	2781                	sext.w	a5,a5
ffffffc050401f86:	0005e717          	auipc	a4,0x5e
ffffffc050401f8a:	9ca70713          	addi	a4,a4,-1590 # ffffffc05045f950 <new_screen>
ffffffc050401f8e:	97ba                	add	a5,a5,a4
ffffffc050401f90:	02000713          	li	a4,32
ffffffc050401f94:	00e78023          	sb	a4,0(a5)
ffffffc050401f98:	fec42703          	lw	a4,-20(s0)
ffffffc050401f9c:	87ba                	mv	a5,a4
ffffffc050401f9e:	0027979b          	slliw	a5,a5,0x2
ffffffc050401fa2:	9fb9                	addw	a5,a5,a4
ffffffc050401fa4:	0047979b          	slliw	a5,a5,0x4
ffffffc050401fa8:	2781                	sext.w	a5,a5
ffffffc050401faa:	fe842703          	lw	a4,-24(s0)
ffffffc050401fae:	9fb9                	addw	a5,a5,a4
ffffffc050401fb0:	2781                	sext.w	a5,a5
ffffffc050401fb2:	0005f717          	auipc	a4,0x5f
ffffffc050401fb6:	93e70713          	addi	a4,a4,-1730 # ffffffc0504608f0 <old_screen>
ffffffc050401fba:	97ba                	add	a5,a5,a4
ffffffc050401fbc:	00078023          	sb	zero,0(a5)
ffffffc050401fc0:	fe842783          	lw	a5,-24(s0)
ffffffc050401fc4:	2785                	addiw	a5,a5,1
ffffffc050401fc6:	fef42423          	sw	a5,-24(s0)
ffffffc050401fca:	fe842783          	lw	a5,-24(s0)
ffffffc050401fce:	0007871b          	sext.w	a4,a5
ffffffc050401fd2:	04f00793          	li	a5,79
ffffffc050401fd6:	f8e7dbe3          	bge	a5,a4,ffffffc050401f6c <screen_clear+0x1e>
ffffffc050401fda:	fec42783          	lw	a5,-20(s0)
ffffffc050401fde:	2785                	addiw	a5,a5,1
ffffffc050401fe0:	fef42623          	sw	a5,-20(s0)
ffffffc050401fe4:	fec42783          	lw	a5,-20(s0)
ffffffc050401fe8:	0007871b          	sext.w	a4,a5
ffffffc050401fec:	03100793          	li	a5,49
ffffffc050401ff0:	f6e7dbe3          	bge	a5,a4,ffffffc050401f66 <screen_clear+0x18>
ffffffc050401ff4:	00071717          	auipc	a4,0x71
ffffffc050401ff8:	e7470713          	addi	a4,a4,-396 # ffffffc050472e68 <screen_cursor_x>
ffffffc050401ffc:	fe442783          	lw	a5,-28(s0)
ffffffc050402000:	078a                	slli	a5,a5,0x2
ffffffc050402002:	97ba                	add	a5,a5,a4
ffffffc050402004:	0007a023          	sw	zero,0(a5)
ffffffc050402008:	00071717          	auipc	a4,0x71
ffffffc05040200c:	e6870713          	addi	a4,a4,-408 # ffffffc050472e70 <screen_cursor_y>
ffffffc050402010:	fe442783          	lw	a5,-28(s0)
ffffffc050402014:	078a                	slli	a5,a5,0x2
ffffffc050402016:	97ba                	add	a5,a5,a4
ffffffc050402018:	0007a023          	sw	zero,0(a5)
ffffffc05040201c:	166000ef          	jal	ra,ffffffc050402182 <screen_reflush>
ffffffc050402020:	0001                	nop
ffffffc050402022:	60e2                	ld	ra,24(sp)
ffffffc050402024:	6442                	ld	s0,16(sp)
ffffffc050402026:	6105                	addi	sp,sp,32
ffffffc050402028:	8082                	ret

ffffffc05040202a <screen_move_cursor>:
ffffffc05040202a:	7179                	addi	sp,sp,-48
ffffffc05040202c:	f406                	sd	ra,40(sp)
ffffffc05040202e:	f022                	sd	s0,32(sp)
ffffffc050402030:	1800                	addi	s0,sp,48
ffffffc050402032:	87aa                	mv	a5,a0
ffffffc050402034:	872e                	mv	a4,a1
ffffffc050402036:	fcf42e23          	sw	a5,-36(s0)
ffffffc05040203a:	87ba                	mv	a5,a4
ffffffc05040203c:	fcf42c23          	sw	a5,-40(s0)
ffffffc050402040:	b00fe0ef          	jal	ra,ffffffc050400340 <get_current_cpu_id>
ffffffc050402044:	87aa                	mv	a5,a0
ffffffc050402046:	fef42623          	sw	a5,-20(s0)
ffffffc05040204a:	00071717          	auipc	a4,0x71
ffffffc05040204e:	e1e70713          	addi	a4,a4,-482 # ffffffc050472e68 <screen_cursor_x>
ffffffc050402052:	fec42783          	lw	a5,-20(s0)
ffffffc050402056:	078a                	slli	a5,a5,0x2
ffffffc050402058:	97ba                	add	a5,a5,a4
ffffffc05040205a:	fdc42703          	lw	a4,-36(s0)
ffffffc05040205e:	c398                	sw	a4,0(a5)
ffffffc050402060:	00071717          	auipc	a4,0x71
ffffffc050402064:	e1070713          	addi	a4,a4,-496 # ffffffc050472e70 <screen_cursor_y>
ffffffc050402068:	fec42783          	lw	a5,-20(s0)
ffffffc05040206c:	078a                	slli	a5,a5,0x2
ffffffc05040206e:	97ba                	add	a5,a5,a4
ffffffc050402070:	fd842703          	lw	a4,-40(s0)
ffffffc050402074:	c398                	sw	a4,0(a5)
ffffffc050402076:	00071717          	auipc	a4,0x71
ffffffc05040207a:	e1a70713          	addi	a4,a4,-486 # ffffffc050472e90 <current_running>
ffffffc05040207e:	fec42783          	lw	a5,-20(s0)
ffffffc050402082:	078e                	slli	a5,a5,0x3
ffffffc050402084:	97ba                	add	a5,a5,a4
ffffffc050402086:	639c                	ld	a5,0(a5)
ffffffc050402088:	00071697          	auipc	a3,0x71
ffffffc05040208c:	de068693          	addi	a3,a3,-544 # ffffffc050472e68 <screen_cursor_x>
ffffffc050402090:	fec42703          	lw	a4,-20(s0)
ffffffc050402094:	070a                	slli	a4,a4,0x2
ffffffc050402096:	9736                	add	a4,a4,a3
ffffffc050402098:	4318                	lw	a4,0(a4)
ffffffc05040209a:	08e7a423          	sw	a4,136(a5)
ffffffc05040209e:	00071717          	auipc	a4,0x71
ffffffc0504020a2:	df270713          	addi	a4,a4,-526 # ffffffc050472e90 <current_running>
ffffffc0504020a6:	fec42783          	lw	a5,-20(s0)
ffffffc0504020aa:	078e                	slli	a5,a5,0x3
ffffffc0504020ac:	97ba                	add	a5,a5,a4
ffffffc0504020ae:	639c                	ld	a5,0(a5)
ffffffc0504020b0:	00071697          	auipc	a3,0x71
ffffffc0504020b4:	dc068693          	addi	a3,a3,-576 # ffffffc050472e70 <screen_cursor_y>
ffffffc0504020b8:	fec42703          	lw	a4,-20(s0)
ffffffc0504020bc:	070a                	slli	a4,a4,0x2
ffffffc0504020be:	9736                	add	a4,a4,a3
ffffffc0504020c0:	4318                	lw	a4,0(a4)
ffffffc0504020c2:	08e7a623          	sw	a4,140(a5)
ffffffc0504020c6:	0001                	nop
ffffffc0504020c8:	70a2                	ld	ra,40(sp)
ffffffc0504020ca:	7402                	ld	s0,32(sp)
ffffffc0504020cc:	6145                	addi	sp,sp,48
ffffffc0504020ce:	8082                	ret

ffffffc0504020d0 <screen_get_cursor>:
ffffffc0504020d0:	7179                	addi	sp,sp,-48
ffffffc0504020d2:	f406                	sd	ra,40(sp)
ffffffc0504020d4:	f022                	sd	s0,32(sp)
ffffffc0504020d6:	1800                	addi	s0,sp,48
ffffffc0504020d8:	fca43c23          	sd	a0,-40(s0)
ffffffc0504020dc:	fcb43823          	sd	a1,-48(s0)
ffffffc0504020e0:	a60fe0ef          	jal	ra,ffffffc050400340 <get_current_cpu_id>
ffffffc0504020e4:	87aa                	mv	a5,a0
ffffffc0504020e6:	fef42623          	sw	a5,-20(s0)
ffffffc0504020ea:	00071717          	auipc	a4,0x71
ffffffc0504020ee:	d7e70713          	addi	a4,a4,-642 # ffffffc050472e68 <screen_cursor_x>
ffffffc0504020f2:	fec42783          	lw	a5,-20(s0)
ffffffc0504020f6:	078a                	slli	a5,a5,0x2
ffffffc0504020f8:	97ba                	add	a5,a5,a4
ffffffc0504020fa:	4398                	lw	a4,0(a5)
ffffffc0504020fc:	fd843783          	ld	a5,-40(s0)
ffffffc050402100:	c398                	sw	a4,0(a5)
ffffffc050402102:	00071717          	auipc	a4,0x71
ffffffc050402106:	d6e70713          	addi	a4,a4,-658 # ffffffc050472e70 <screen_cursor_y>
ffffffc05040210a:	fec42783          	lw	a5,-20(s0)
ffffffc05040210e:	078a                	slli	a5,a5,0x2
ffffffc050402110:	97ba                	add	a5,a5,a4
ffffffc050402112:	4398                	lw	a4,0(a5)
ffffffc050402114:	fd043783          	ld	a5,-48(s0)
ffffffc050402118:	c398                	sw	a4,0(a5)
ffffffc05040211a:	0001                	nop
ffffffc05040211c:	70a2                	ld	ra,40(sp)
ffffffc05040211e:	7402                	ld	s0,32(sp)
ffffffc050402120:	6145                	addi	sp,sp,48
ffffffc050402122:	8082                	ret

ffffffc050402124 <screen_write>:
ffffffc050402124:	7179                	addi	sp,sp,-48
ffffffc050402126:	f406                	sd	ra,40(sp)
ffffffc050402128:	f022                	sd	s0,32(sp)
ffffffc05040212a:	1800                	addi	s0,sp,48
ffffffc05040212c:	fca43c23          	sd	a0,-40(s0)
ffffffc050402130:	fe042623          	sw	zero,-20(s0)
ffffffc050402134:	fd843503          	ld	a0,-40(s0)
ffffffc050402138:	044040ef          	jal	ra,ffffffc05040617c <kstrlen>
ffffffc05040213c:	87aa                	mv	a5,a0
ffffffc05040213e:	fef42423          	sw	a5,-24(s0)
ffffffc050402142:	fe042623          	sw	zero,-20(s0)
ffffffc050402146:	a005                	j	ffffffc050402166 <screen_write+0x42>
ffffffc050402148:	fec42783          	lw	a5,-20(s0)
ffffffc05040214c:	fd843703          	ld	a4,-40(s0)
ffffffc050402150:	97ba                	add	a5,a5,a4
ffffffc050402152:	0007c783          	lbu	a5,0(a5)
ffffffc050402156:	853e                	mv	a0,a5
ffffffc050402158:	aedff0ef          	jal	ra,ffffffc050401c44 <screen_write_ch>
ffffffc05040215c:	fec42783          	lw	a5,-20(s0)
ffffffc050402160:	2785                	addiw	a5,a5,1
ffffffc050402162:	fef42623          	sw	a5,-20(s0)
ffffffc050402166:	fec42703          	lw	a4,-20(s0)
ffffffc05040216a:	fe842783          	lw	a5,-24(s0)
ffffffc05040216e:	2701                	sext.w	a4,a4
ffffffc050402170:	2781                	sext.w	a5,a5
ffffffc050402172:	fcf74be3          	blt	a4,a5,ffffffc050402148 <screen_write+0x24>
ffffffc050402176:	0001                	nop
ffffffc050402178:	0001                	nop
ffffffc05040217a:	70a2                	ld	ra,40(sp)
ffffffc05040217c:	7402                	ld	s0,32(sp)
ffffffc05040217e:	6145                	addi	sp,sp,48
ffffffc050402180:	8082                	ret

ffffffc050402182 <screen_reflush>:
ffffffc050402182:	1101                	addi	sp,sp,-32
ffffffc050402184:	ec06                	sd	ra,24(sp)
ffffffc050402186:	e822                	sd	s0,16(sp)
ffffffc050402188:	1000                	addi	s0,sp,32
ffffffc05040218a:	9b6fe0ef          	jal	ra,ffffffc050400340 <get_current_cpu_id>
ffffffc05040218e:	87aa                	mv	a5,a0
ffffffc050402190:	fef42223          	sw	a5,-28(s0)
ffffffc050402194:	fe042623          	sw	zero,-20(s0)
ffffffc050402198:	aa31                	j	ffffffc0504022b4 <screen_reflush+0x132>
ffffffc05040219a:	fe042423          	sw	zero,-24(s0)
ffffffc05040219e:	a8f5                	j	ffffffc05040229a <screen_reflush+0x118>
ffffffc0504021a0:	fec42703          	lw	a4,-20(s0)
ffffffc0504021a4:	87ba                	mv	a5,a4
ffffffc0504021a6:	0027979b          	slliw	a5,a5,0x2
ffffffc0504021aa:	9fb9                	addw	a5,a5,a4
ffffffc0504021ac:	0047979b          	slliw	a5,a5,0x4
ffffffc0504021b0:	2781                	sext.w	a5,a5
ffffffc0504021b2:	fe842703          	lw	a4,-24(s0)
ffffffc0504021b6:	9fb9                	addw	a5,a5,a4
ffffffc0504021b8:	2781                	sext.w	a5,a5
ffffffc0504021ba:	0005d717          	auipc	a4,0x5d
ffffffc0504021be:	79670713          	addi	a4,a4,1942 # ffffffc05045f950 <new_screen>
ffffffc0504021c2:	97ba                	add	a5,a5,a4
ffffffc0504021c4:	0007c683          	lbu	a3,0(a5)
ffffffc0504021c8:	fec42703          	lw	a4,-20(s0)
ffffffc0504021cc:	87ba                	mv	a5,a4
ffffffc0504021ce:	0027979b          	slliw	a5,a5,0x2
ffffffc0504021d2:	9fb9                	addw	a5,a5,a4
ffffffc0504021d4:	0047979b          	slliw	a5,a5,0x4
ffffffc0504021d8:	2781                	sext.w	a5,a5
ffffffc0504021da:	fe842703          	lw	a4,-24(s0)
ffffffc0504021de:	9fb9                	addw	a5,a5,a4
ffffffc0504021e0:	2781                	sext.w	a5,a5
ffffffc0504021e2:	0005e717          	auipc	a4,0x5e
ffffffc0504021e6:	70e70713          	addi	a4,a4,1806 # ffffffc0504608f0 <old_screen>
ffffffc0504021ea:	97ba                	add	a5,a5,a4
ffffffc0504021ec:	0007c783          	lbu	a5,0(a5)
ffffffc0504021f0:	8736                	mv	a4,a3
ffffffc0504021f2:	08f70f63          	beq	a4,a5,ffffffc050402290 <screen_reflush+0x10e>
ffffffc0504021f6:	fe842783          	lw	a5,-24(s0)
ffffffc0504021fa:	2785                	addiw	a5,a5,1
ffffffc0504021fc:	0007871b          	sext.w	a4,a5
ffffffc050402200:	fec42783          	lw	a5,-20(s0)
ffffffc050402204:	2785                	addiw	a5,a5,1
ffffffc050402206:	2781                	sext.w	a5,a5
ffffffc050402208:	85be                	mv	a1,a5
ffffffc05040220a:	853a                	mv	a0,a4
ffffffc05040220c:	981ff0ef          	jal	ra,ffffffc050401b8c <vt100_move_cursor>
ffffffc050402210:	fec42703          	lw	a4,-20(s0)
ffffffc050402214:	87ba                	mv	a5,a4
ffffffc050402216:	0027979b          	slliw	a5,a5,0x2
ffffffc05040221a:	9fb9                	addw	a5,a5,a4
ffffffc05040221c:	0047979b          	slliw	a5,a5,0x4
ffffffc050402220:	2781                	sext.w	a5,a5
ffffffc050402222:	fe842703          	lw	a4,-24(s0)
ffffffc050402226:	9fb9                	addw	a5,a5,a4
ffffffc050402228:	2781                	sext.w	a5,a5
ffffffc05040222a:	0005d717          	auipc	a4,0x5d
ffffffc05040222e:	72670713          	addi	a4,a4,1830 # ffffffc05045f950 <new_screen>
ffffffc050402232:	97ba                	add	a5,a5,a4
ffffffc050402234:	0007c783          	lbu	a5,0(a5)
ffffffc050402238:	853e                	mv	a0,a5
ffffffc05040223a:	8acfe0ef          	jal	ra,ffffffc0504002e6 <port_write_ch>
ffffffc05040223e:	fec42703          	lw	a4,-20(s0)
ffffffc050402242:	87ba                	mv	a5,a4
ffffffc050402244:	0027979b          	slliw	a5,a5,0x2
ffffffc050402248:	9fb9                	addw	a5,a5,a4
ffffffc05040224a:	0047979b          	slliw	a5,a5,0x4
ffffffc05040224e:	2781                	sext.w	a5,a5
ffffffc050402250:	fe842703          	lw	a4,-24(s0)
ffffffc050402254:	9fb9                	addw	a5,a5,a4
ffffffc050402256:	0007869b          	sext.w	a3,a5
ffffffc05040225a:	fec42703          	lw	a4,-20(s0)
ffffffc05040225e:	87ba                	mv	a5,a4
ffffffc050402260:	0027979b          	slliw	a5,a5,0x2
ffffffc050402264:	9fb9                	addw	a5,a5,a4
ffffffc050402266:	0047979b          	slliw	a5,a5,0x4
ffffffc05040226a:	2781                	sext.w	a5,a5
ffffffc05040226c:	fe842703          	lw	a4,-24(s0)
ffffffc050402270:	9fb9                	addw	a5,a5,a4
ffffffc050402272:	2781                	sext.w	a5,a5
ffffffc050402274:	0005d717          	auipc	a4,0x5d
ffffffc050402278:	6dc70713          	addi	a4,a4,1756 # ffffffc05045f950 <new_screen>
ffffffc05040227c:	9736                	add	a4,a4,a3
ffffffc05040227e:	00074703          	lbu	a4,0(a4)
ffffffc050402282:	0005e697          	auipc	a3,0x5e
ffffffc050402286:	66e68693          	addi	a3,a3,1646 # ffffffc0504608f0 <old_screen>
ffffffc05040228a:	97b6                	add	a5,a5,a3
ffffffc05040228c:	00e78023          	sb	a4,0(a5)
ffffffc050402290:	fe842783          	lw	a5,-24(s0)
ffffffc050402294:	2785                	addiw	a5,a5,1
ffffffc050402296:	fef42423          	sw	a5,-24(s0)
ffffffc05040229a:	fe842783          	lw	a5,-24(s0)
ffffffc05040229e:	0007871b          	sext.w	a4,a5
ffffffc0504022a2:	04f00793          	li	a5,79
ffffffc0504022a6:	eee7dde3          	bge	a5,a4,ffffffc0504021a0 <screen_reflush+0x1e>
ffffffc0504022aa:	fec42783          	lw	a5,-20(s0)
ffffffc0504022ae:	2785                	addiw	a5,a5,1
ffffffc0504022b0:	fef42623          	sw	a5,-20(s0)
ffffffc0504022b4:	fec42783          	lw	a5,-20(s0)
ffffffc0504022b8:	0007871b          	sext.w	a4,a5
ffffffc0504022bc:	03100793          	li	a5,49
ffffffc0504022c0:	ece7dde3          	bge	a5,a4,ffffffc05040219a <screen_reflush+0x18>
ffffffc0504022c4:	00071717          	auipc	a4,0x71
ffffffc0504022c8:	ba470713          	addi	a4,a4,-1116 # ffffffc050472e68 <screen_cursor_x>
ffffffc0504022cc:	fe442783          	lw	a5,-28(s0)
ffffffc0504022d0:	078a                	slli	a5,a5,0x2
ffffffc0504022d2:	97ba                	add	a5,a5,a4
ffffffc0504022d4:	439c                	lw	a5,0(a5)
ffffffc0504022d6:	2785                	addiw	a5,a5,1
ffffffc0504022d8:	0007869b          	sext.w	a3,a5
ffffffc0504022dc:	00071717          	auipc	a4,0x71
ffffffc0504022e0:	b9470713          	addi	a4,a4,-1132 # ffffffc050472e70 <screen_cursor_y>
ffffffc0504022e4:	fe442783          	lw	a5,-28(s0)
ffffffc0504022e8:	078a                	slli	a5,a5,0x2
ffffffc0504022ea:	97ba                	add	a5,a5,a4
ffffffc0504022ec:	439c                	lw	a5,0(a5)
ffffffc0504022ee:	2785                	addiw	a5,a5,1
ffffffc0504022f0:	2781                	sext.w	a5,a5
ffffffc0504022f2:	85be                	mv	a1,a5
ffffffc0504022f4:	8536                	mv	a0,a3
ffffffc0504022f6:	897ff0ef          	jal	ra,ffffffc050401b8c <vt100_move_cursor>
ffffffc0504022fa:	0001                	nop
ffffffc0504022fc:	60e2                	ld	ra,24(sp)
ffffffc0504022fe:	6442                	ld	s0,16(sp)
ffffffc050402300:	6105                	addi	sp,sp,32
ffffffc050402302:	8082                	ret

ffffffc050402304 <getch>:
ffffffc050402304:	1101                	addi	sp,sp,-32
ffffffc050402306:	ec06                	sd	ra,24(sp)
ffffffc050402308:	e822                	sd	s0,16(sp)
ffffffc05040230a:	1000                	addi	s0,sp,32
ffffffc05040230c:	fe042423          	sw	zero,-24(s0)
ffffffc050402310:	a805                	j	ffffffc050402340 <getch+0x3c>
ffffffc050402312:	816fe0ef          	jal	ra,ffffffc050400328 <port_read_ch>
ffffffc050402316:	87aa                	mv	a5,a0
ffffffc050402318:	fef407a3          	sb	a5,-17(s0)
ffffffc05040231c:	fef44783          	lbu	a5,-17(s0)
ffffffc050402320:	0ff7f793          	andi	a5,a5,255
ffffffc050402324:	cb89                	beqz	a5,ffffffc050402336 <getch+0x32>
ffffffc050402326:	fef40783          	lb	a5,-17(s0)
ffffffc05040232a:	0007c663          	bltz	a5,ffffffc050402336 <getch+0x32>
ffffffc05040232e:	fef44783          	lbu	a5,-17(s0)
ffffffc050402332:	2781                	sext.w	a5,a5
ffffffc050402334:	a00d                	j	ffffffc050402356 <getch+0x52>
ffffffc050402336:	fe842783          	lw	a5,-24(s0)
ffffffc05040233a:	2785                	addiw	a5,a5,1
ffffffc05040233c:	fef42423          	sw	a5,-24(s0)
ffffffc050402340:	fe842783          	lw	a5,-24(s0)
ffffffc050402344:	0007871b          	sext.w	a4,a5
ffffffc050402348:	06300793          	li	a5,99
ffffffc05040234c:	fce7d3e3          	bge	a5,a4,ffffffc050402312 <getch+0xe>
ffffffc050402350:	fef44783          	lbu	a5,-17(s0)
ffffffc050402354:	2781                	sext.w	a5,a5
ffffffc050402356:	853e                	mv	a0,a5
ffffffc050402358:	60e2                	ld	ra,24(sp)
ffffffc05040235a:	6442                	ld	s0,16(sp)
ffffffc05040235c:	6105                	addi	sp,sp,32
ffffffc05040235e:	8082                	ret

ffffffc050402360 <getchar>:
ffffffc050402360:	1101                	addi	sp,sp,-32
ffffffc050402362:	ec06                	sd	ra,24(sp)
ffffffc050402364:	e822                	sd	s0,16(sp)
ffffffc050402366:	1000                	addi	s0,sp,32
ffffffc050402368:	0001                	nop
ffffffc05040236a:	fbffd0ef          	jal	ra,ffffffc050400328 <port_read_ch>
ffffffc05040236e:	87aa                	mv	a5,a0
ffffffc050402370:	fef407a3          	sb	a5,-17(s0)
ffffffc050402374:	fef40783          	lb	a5,-17(s0)
ffffffc050402378:	fe07c9e3          	bltz	a5,ffffffc05040236a <getchar+0xa>
ffffffc05040237c:	fef44783          	lbu	a5,-17(s0)
ffffffc050402380:	2781                	sext.w	a5,a5
ffffffc050402382:	853e                	mv	a0,a5
ffffffc050402384:	60e2                	ld	ra,24(sp)
ffffffc050402386:	6442                	ld	s0,16(sp)
ffffffc050402388:	6105                	addi	sp,sp,32
ffffffc05040238a:	8082                	ret

ffffffc05040238c <atomic_cmpxchg>:
ffffffc05040238c:	7179                	addi	sp,sp,-48
ffffffc05040238e:	f422                	sd	s0,40(sp)
ffffffc050402390:	1800                	addi	s0,sp,48
ffffffc050402392:	87aa                	mv	a5,a0
ffffffc050402394:	872e                	mv	a4,a1
ffffffc050402396:	fcc43823          	sd	a2,-48(s0)
ffffffc05040239a:	fcf42e23          	sw	a5,-36(s0)
ffffffc05040239e:	87ba                	mv	a5,a4
ffffffc0504023a0:	fcf42c23          	sw	a5,-40(s0)
ffffffc0504023a4:	fd043783          	ld	a5,-48(s0)
ffffffc0504023a8:	fdc42703          	lw	a4,-36(s0)
ffffffc0504023ac:	fd842683          	lw	a3,-40(s0)
ffffffc0504023b0:	1007a62f          	lr.w	a2,(a5)
ffffffc0504023b4:	00e61763          	bne	a2,a4,ffffffc0504023c2 <atomic_cmpxchg+0x36>
ffffffc0504023b8:	1ad7a5af          	sc.w.rl	a1,a3,(a5)
ffffffc0504023bc:	f9f5                	bnez	a1,ffffffc0504023b0 <atomic_cmpxchg+0x24>
ffffffc0504023be:	0330000f          	fence	rw,rw
ffffffc0504023c2:	fec42623          	sw	a2,-20(s0)
ffffffc0504023c6:	fec42783          	lw	a5,-20(s0)
ffffffc0504023ca:	853e                	mv	a0,a5
ffffffc0504023cc:	7422                	ld	s0,40(sp)
ffffffc0504023ce:	6145                	addi	sp,sp,48
ffffffc0504023d0:	8082                	ret

ffffffc0504023d2 <do_mutex_lock_init>:
ffffffc0504023d2:	1101                	addi	sp,sp,-32
ffffffc0504023d4:	ec22                	sd	s0,24(sp)
ffffffc0504023d6:	1000                	addi	s0,sp,32
ffffffc0504023d8:	fea43423          	sd	a0,-24(s0)
ffffffc0504023dc:	fe843783          	ld	a5,-24(s0)
ffffffc0504023e0:	0007a023          	sw	zero,0(a5)
ffffffc0504023e4:	fe843783          	ld	a5,-24(s0)
ffffffc0504023e8:	0007b423          	sd	zero,8(a5)
ffffffc0504023ec:	fe843783          	ld	a5,-24(s0)
ffffffc0504023f0:	0007bc23          	sd	zero,24(a5)
ffffffc0504023f4:	fe843783          	ld	a5,-24(s0)
ffffffc0504023f8:	0207b023          	sd	zero,32(a5)
ffffffc0504023fc:	fe843783          	ld	a5,-24(s0)
ffffffc050402400:	0007a823          	sw	zero,16(a5)
ffffffc050402404:	0001                	nop
ffffffc050402406:	6462                	ld	s0,24(sp)
ffffffc050402408:	6105                	addi	sp,sp,32
ffffffc05040240a:	8082                	ret

ffffffc05040240c <do_mutex_lock_acquire>:
ffffffc05040240c:	7179                	addi	sp,sp,-48
ffffffc05040240e:	f406                	sd	ra,40(sp)
ffffffc050402410:	f022                	sd	s0,32(sp)
ffffffc050402412:	1800                	addi	s0,sp,48
ffffffc050402414:	fca43c23          	sd	a0,-40(s0)
ffffffc050402418:	f29fd0ef          	jal	ra,ffffffc050400340 <get_current_cpu_id>
ffffffc05040241c:	87aa                	mv	a5,a0
ffffffc05040241e:	fef42623          	sw	a5,-20(s0)
ffffffc050402422:	fd843783          	ld	a5,-40(s0)
ffffffc050402426:	439c                	lw	a5,0(a5)
ffffffc050402428:	2781                	sext.w	a5,a5
ffffffc05040242a:	873e                	mv	a4,a5
ffffffc05040242c:	4785                	li	a5,1
ffffffc05040242e:	06f71363          	bne	a4,a5,ffffffc050402494 <do_mutex_lock_acquire+0x88>
ffffffc050402432:	00071717          	auipc	a4,0x71
ffffffc050402436:	a5e70713          	addi	a4,a4,-1442 # ffffffc050472e90 <current_running>
ffffffc05040243a:	fec42783          	lw	a5,-20(s0)
ffffffc05040243e:	078e                	slli	a5,a5,0x3
ffffffc050402440:	97ba                	add	a5,a5,a4
ffffffc050402442:	639c                	ld	a5,0(a5)
ffffffc050402444:	4705                	li	a4,1
ffffffc050402446:	cff8                	sw	a4,92(a5)
ffffffc050402448:	00071717          	auipc	a4,0x71
ffffffc05040244c:	a4870713          	addi	a4,a4,-1464 # ffffffc050472e90 <current_running>
ffffffc050402450:	fec42783          	lw	a5,-20(s0)
ffffffc050402454:	078e                	slli	a5,a5,0x3
ffffffc050402456:	97ba                	add	a5,a5,a4
ffffffc050402458:	639c                	ld	a5,0(a5)
ffffffc05040245a:	fd843703          	ld	a4,-40(s0)
ffffffc05040245e:	0741                	addi	a4,a4,16
ffffffc050402460:	e7b8                	sd	a4,72(a5)
ffffffc050402462:	00071717          	auipc	a4,0x71
ffffffc050402466:	a2e70713          	addi	a4,a4,-1490 # ffffffc050472e90 <current_running>
ffffffc05040246a:	fec42783          	lw	a5,-20(s0)
ffffffc05040246e:	078e                	slli	a5,a5,0x3
ffffffc050402470:	97ba                	add	a5,a5,a4
ffffffc050402472:	639c                	ld	a5,0(a5)
ffffffc050402474:	01878713          	addi	a4,a5,24
ffffffc050402478:	fd843783          	ld	a5,-40(s0)
ffffffc05040247c:	07c1                	addi	a5,a5,16
ffffffc05040247e:	00071617          	auipc	a2,0x71
ffffffc050402482:	9fa60613          	addi	a2,a2,-1542 # ffffffc050472e78 <ready_queue>
ffffffc050402486:	85be                	mv	a1,a5
ffffffc050402488:	853a                	mv	a0,a4
ffffffc05040248a:	391000ef          	jal	ra,ffffffc05040301a <move_node>
ffffffc05040248e:	760000ef          	jal	ra,ffffffc050402bee <do_scheduler>
ffffffc050402492:	a00d                	j	ffffffc0504024b4 <do_mutex_lock_acquire+0xa8>
ffffffc050402494:	fd843783          	ld	a5,-40(s0)
ffffffc050402498:	4705                	li	a4,1
ffffffc05040249a:	c398                	sw	a4,0(a5)
ffffffc05040249c:	00071717          	auipc	a4,0x71
ffffffc0504024a0:	9f470713          	addi	a4,a4,-1548 # ffffffc050472e90 <current_running>
ffffffc0504024a4:	fec42783          	lw	a5,-20(s0)
ffffffc0504024a8:	078e                	slli	a5,a5,0x3
ffffffc0504024aa:	97ba                	add	a5,a5,a4
ffffffc0504024ac:	6398                	ld	a4,0(a5)
ffffffc0504024ae:	fd843783          	ld	a5,-40(s0)
ffffffc0504024b2:	e798                	sd	a4,8(a5)
ffffffc0504024b4:	0001                	nop
ffffffc0504024b6:	70a2                	ld	ra,40(sp)
ffffffc0504024b8:	7402                	ld	s0,32(sp)
ffffffc0504024ba:	6145                	addi	sp,sp,48
ffffffc0504024bc:	8082                	ret

ffffffc0504024be <do_mutex_lock_release>:
ffffffc0504024be:	7179                	addi	sp,sp,-48
ffffffc0504024c0:	f406                	sd	ra,40(sp)
ffffffc0504024c2:	f022                	sd	s0,32(sp)
ffffffc0504024c4:	1800                	addi	s0,sp,48
ffffffc0504024c6:	fca43c23          	sd	a0,-40(s0)
ffffffc0504024ca:	fd843783          	ld	a5,-40(s0)
ffffffc0504024ce:	4b9c                	lw	a5,16(a5)
ffffffc0504024d0:	08f05263          	blez	a5,ffffffc050402554 <do_mutex_lock_release+0x96>
ffffffc0504024d4:	fd843783          	ld	a5,-40(s0)
ffffffc0504024d8:	6f9c                	ld	a5,24(a5)
ffffffc0504024da:	439c                	lw	a5,0(a5)
ffffffc0504024dc:	fef42623          	sw	a5,-20(s0)
ffffffc0504024e0:	00071717          	auipc	a4,0x71
ffffffc0504024e4:	9d870713          	addi	a4,a4,-1576 # ffffffc050472eb8 <pcb>
ffffffc0504024e8:	fec42683          	lw	a3,-20(s0)
ffffffc0504024ec:	09800793          	li	a5,152
ffffffc0504024f0:	02f687b3          	mul	a5,a3,a5
ffffffc0504024f4:	97ba                	add	a5,a5,a4
ffffffc0504024f6:	470d                	li	a4,3
ffffffc0504024f8:	cff8                	sw	a4,92(a5)
ffffffc0504024fa:	00071717          	auipc	a4,0x71
ffffffc0504024fe:	9be70713          	addi	a4,a4,-1602 # ffffffc050472eb8 <pcb>
ffffffc050402502:	fec42683          	lw	a3,-20(s0)
ffffffc050402506:	09800793          	li	a5,152
ffffffc05040250a:	02f687b3          	mul	a5,a3,a5
ffffffc05040250e:	97ba                	add	a5,a5,a4
ffffffc050402510:	00071717          	auipc	a4,0x71
ffffffc050402514:	96870713          	addi	a4,a4,-1688 # ffffffc050472e78 <ready_queue>
ffffffc050402518:	e7b8                	sd	a4,72(a5)
ffffffc05040251a:	fd843783          	ld	a5,-40(s0)
ffffffc05040251e:	6f98                	ld	a4,24(a5)
ffffffc050402520:	fd843783          	ld	a5,-40(s0)
ffffffc050402524:	07c1                	addi	a5,a5,16
ffffffc050402526:	863e                	mv	a2,a5
ffffffc050402528:	00071597          	auipc	a1,0x71
ffffffc05040252c:	95058593          	addi	a1,a1,-1712 # ffffffc050472e78 <ready_queue>
ffffffc050402530:	853a                	mv	a0,a4
ffffffc050402532:	2e9000ef          	jal	ra,ffffffc05040301a <move_node>
ffffffc050402536:	fec42703          	lw	a4,-20(s0)
ffffffc05040253a:	09800793          	li	a5,152
ffffffc05040253e:	02f70733          	mul	a4,a4,a5
ffffffc050402542:	00071797          	auipc	a5,0x71
ffffffc050402546:	97678793          	addi	a5,a5,-1674 # ffffffc050472eb8 <pcb>
ffffffc05040254a:	973e                	add	a4,a4,a5
ffffffc05040254c:	fd843783          	ld	a5,-40(s0)
ffffffc050402550:	e798                	sd	a4,8(a5)
ffffffc050402552:	a809                	j	ffffffc050402564 <do_mutex_lock_release+0xa6>
ffffffc050402554:	fd843783          	ld	a5,-40(s0)
ffffffc050402558:	0007a023          	sw	zero,0(a5)
ffffffc05040255c:	fd843783          	ld	a5,-40(s0)
ffffffc050402560:	0007b423          	sd	zero,8(a5)
ffffffc050402564:	0001                	nop
ffffffc050402566:	70a2                	ld	ra,40(sp)
ffffffc050402568:	7402                	ld	s0,32(sp)
ffffffc05040256a:	6145                	addi	sp,sp,48
ffffffc05040256c:	8082                	ret

ffffffc05040256e <get_mutex>:
ffffffc05040256e:	1101                	addi	sp,sp,-32
ffffffc050402570:	ec06                	sd	ra,24(sp)
ffffffc050402572:	e822                	sd	s0,16(sp)
ffffffc050402574:	1000                	addi	s0,sp,32
ffffffc050402576:	fea43423          	sd	a0,-24(s0)
ffffffc05040257a:	87818793          	addi	a5,gp,-1928 # ffffffc05045f930 <_edata>
ffffffc05040257e:	4398                	lw	a4,0(a5)
ffffffc050402580:	87ba                	mv	a5,a4
ffffffc050402582:	078a                	slli	a5,a5,0x2
ffffffc050402584:	97ba                	add	a5,a5,a4
ffffffc050402586:	078e                	slli	a5,a5,0x3
ffffffc050402588:	0005f717          	auipc	a4,0x5f
ffffffc05040258c:	42870713          	addi	a4,a4,1064 # ffffffc0504619b0 <lock_array>
ffffffc050402590:	97ba                	add	a5,a5,a4
ffffffc050402592:	853e                	mv	a0,a5
ffffffc050402594:	e3fff0ef          	jal	ra,ffffffc0504023d2 <do_mutex_lock_init>
ffffffc050402598:	87818793          	addi	a5,gp,-1928 # ffffffc05045f930 <_edata>
ffffffc05040259c:	439c                	lw	a5,0(a5)
ffffffc05040259e:	0017871b          	addiw	a4,a5,1
ffffffc0504025a2:	0007069b          	sext.w	a3,a4
ffffffc0504025a6:	87818713          	addi	a4,gp,-1928 # ffffffc05045f930 <_edata>
ffffffc0504025aa:	c314                	sw	a3,0(a4)
ffffffc0504025ac:	853e                	mv	a0,a5
ffffffc0504025ae:	60e2                	ld	ra,24(sp)
ffffffc0504025b0:	6442                	ld	s0,16(sp)
ffffffc0504025b2:	6105                	addi	sp,sp,32
ffffffc0504025b4:	8082                	ret

ffffffc0504025b6 <lock_mutex>:
ffffffc0504025b6:	1101                	addi	sp,sp,-32
ffffffc0504025b8:	ec06                	sd	ra,24(sp)
ffffffc0504025ba:	e822                	sd	s0,16(sp)
ffffffc0504025bc:	1000                	addi	s0,sp,32
ffffffc0504025be:	87aa                	mv	a5,a0
ffffffc0504025c0:	fef42623          	sw	a5,-20(s0)
ffffffc0504025c4:	fec42703          	lw	a4,-20(s0)
ffffffc0504025c8:	87ba                	mv	a5,a4
ffffffc0504025ca:	078a                	slli	a5,a5,0x2
ffffffc0504025cc:	97ba                	add	a5,a5,a4
ffffffc0504025ce:	078e                	slli	a5,a5,0x3
ffffffc0504025d0:	0005f717          	auipc	a4,0x5f
ffffffc0504025d4:	3e070713          	addi	a4,a4,992 # ffffffc0504619b0 <lock_array>
ffffffc0504025d8:	97ba                	add	a5,a5,a4
ffffffc0504025da:	853e                	mv	a0,a5
ffffffc0504025dc:	e31ff0ef          	jal	ra,ffffffc05040240c <do_mutex_lock_acquire>
ffffffc0504025e0:	4781                	li	a5,0
ffffffc0504025e2:	853e                	mv	a0,a5
ffffffc0504025e4:	60e2                	ld	ra,24(sp)
ffffffc0504025e6:	6442                	ld	s0,16(sp)
ffffffc0504025e8:	6105                	addi	sp,sp,32
ffffffc0504025ea:	8082                	ret

ffffffc0504025ec <unlock_mutex>:
ffffffc0504025ec:	1101                	addi	sp,sp,-32
ffffffc0504025ee:	ec06                	sd	ra,24(sp)
ffffffc0504025f0:	e822                	sd	s0,16(sp)
ffffffc0504025f2:	1000                	addi	s0,sp,32
ffffffc0504025f4:	87aa                	mv	a5,a0
ffffffc0504025f6:	fef42623          	sw	a5,-20(s0)
ffffffc0504025fa:	fec42703          	lw	a4,-20(s0)
ffffffc0504025fe:	87ba                	mv	a5,a4
ffffffc050402600:	078a                	slli	a5,a5,0x2
ffffffc050402602:	97ba                	add	a5,a5,a4
ffffffc050402604:	078e                	slli	a5,a5,0x3
ffffffc050402606:	0005f717          	auipc	a4,0x5f
ffffffc05040260a:	3aa70713          	addi	a4,a4,938 # ffffffc0504619b0 <lock_array>
ffffffc05040260e:	97ba                	add	a5,a5,a4
ffffffc050402610:	853e                	mv	a0,a5
ffffffc050402612:	eadff0ef          	jal	ra,ffffffc0504024be <do_mutex_lock_release>
ffffffc050402616:	4781                	li	a5,0
ffffffc050402618:	853e                	mv	a0,a5
ffffffc05040261a:	60e2                	ld	ra,24(sp)
ffffffc05040261c:	6442                	ld	s0,16(sp)
ffffffc05040261e:	6105                	addi	sp,sp,32
ffffffc050402620:	8082                	ret

ffffffc050402622 <spin_lock_init>:
ffffffc050402622:	1101                	addi	sp,sp,-32
ffffffc050402624:	ec22                	sd	s0,24(sp)
ffffffc050402626:	1000                	addi	s0,sp,32
ffffffc050402628:	fea43423          	sd	a0,-24(s0)
ffffffc05040262c:	fe843783          	ld	a5,-24(s0)
ffffffc050402630:	0007b423          	sd	zero,8(a5)
ffffffc050402634:	fe843783          	ld	a5,-24(s0)
ffffffc050402638:	0007a023          	sw	zero,0(a5)
ffffffc05040263c:	0001                	nop
ffffffc05040263e:	6462                	ld	s0,24(sp)
ffffffc050402640:	6105                	addi	sp,sp,32
ffffffc050402642:	8082                	ret

ffffffc050402644 <spin_lock_acquire>:
ffffffc050402644:	1101                	addi	sp,sp,-32
ffffffc050402646:	ec06                	sd	ra,24(sp)
ffffffc050402648:	e822                	sd	s0,16(sp)
ffffffc05040264a:	1000                	addi	s0,sp,32
ffffffc05040264c:	fea43423          	sd	a0,-24(s0)
ffffffc050402650:	0001                	nop
ffffffc050402652:	fe843783          	ld	a5,-24(s0)
ffffffc050402656:	863e                	mv	a2,a5
ffffffc050402658:	4585                	li	a1,1
ffffffc05040265a:	4501                	li	a0,0
ffffffc05040265c:	d31ff0ef          	jal	ra,ffffffc05040238c <atomic_cmpxchg>
ffffffc050402660:	87aa                	mv	a5,a0
ffffffc050402662:	2781                	sext.w	a5,a5
ffffffc050402664:	873e                	mv	a4,a5
ffffffc050402666:	4785                	li	a5,1
ffffffc050402668:	fef705e3          	beq	a4,a5,ffffffc050402652 <spin_lock_acquire+0xe>
ffffffc05040266c:	0001                	nop
ffffffc05040266e:	0001                	nop
ffffffc050402670:	60e2                	ld	ra,24(sp)
ffffffc050402672:	6442                	ld	s0,16(sp)
ffffffc050402674:	6105                	addi	sp,sp,32
ffffffc050402676:	8082                	ret

ffffffc050402678 <spin_lock_release>:
ffffffc050402678:	1101                	addi	sp,sp,-32
ffffffc05040267a:	ec06                	sd	ra,24(sp)
ffffffc05040267c:	e822                	sd	s0,16(sp)
ffffffc05040267e:	1000                	addi	s0,sp,32
ffffffc050402680:	fea43423          	sd	a0,-24(s0)
ffffffc050402684:	fe843783          	ld	a5,-24(s0)
ffffffc050402688:	863e                	mv	a2,a5
ffffffc05040268a:	4581                	li	a1,0
ffffffc05040268c:	4505                	li	a0,1
ffffffc05040268e:	cffff0ef          	jal	ra,ffffffc05040238c <atomic_cmpxchg>
ffffffc050402692:	0001                	nop
ffffffc050402694:	60e2                	ld	ra,24(sp)
ffffffc050402696:	6442                	ld	s0,16(sp)
ffffffc050402698:	6105                	addi	sp,sp,32
ffffffc05040269a:	8082                	ret

ffffffc05040269c <do_binsemget>:
ffffffc05040269c:	7179                	addi	sp,sp,-48
ffffffc05040269e:	f406                	sd	ra,40(sp)
ffffffc0504026a0:	f022                	sd	s0,32(sp)
ffffffc0504026a2:	1800                	addi	s0,sp,48
ffffffc0504026a4:	87aa                	mv	a5,a0
ffffffc0504026a6:	fcf42e23          	sw	a5,-36(s0)
ffffffc0504026aa:	fe042623          	sw	zero,-20(s0)
ffffffc0504026ae:	a835                	j	ffffffc0504026ea <do_binsemget+0x4e>
ffffffc0504026b0:	00067697          	auipc	a3,0x67
ffffffc0504026b4:	25068693          	addi	a3,a3,592 # ffffffc050469900 <binsem_array>
ffffffc0504026b8:	fec42703          	lw	a4,-20(s0)
ffffffc0504026bc:	87ba                	mv	a5,a4
ffffffc0504026be:	0786                	slli	a5,a5,0x1
ffffffc0504026c0:	97ba                	add	a5,a5,a4
ffffffc0504026c2:	0792                	slli	a5,a5,0x4
ffffffc0504026c4:	97b6                	add	a5,a5,a3
ffffffc0504026c6:	4398                	lw	a4,0(a5)
ffffffc0504026c8:	fdc42783          	lw	a5,-36(s0)
ffffffc0504026cc:	02f787bb          	mulw	a5,a5,a5
ffffffc0504026d0:	2781                	sext.w	a5,a5
ffffffc0504026d2:	2785                	addiw	a5,a5,1
ffffffc0504026d4:	2781                	sext.w	a5,a5
ffffffc0504026d6:	00f71563          	bne	a4,a5,ffffffc0504026e0 <do_binsemget+0x44>
ffffffc0504026da:	fec42783          	lw	a5,-20(s0)
ffffffc0504026de:	a8ad                	j	ffffffc050402758 <do_binsemget+0xbc>
ffffffc0504026e0:	fec42783          	lw	a5,-20(s0)
ffffffc0504026e4:	2785                	addiw	a5,a5,1
ffffffc0504026e6:	fef42623          	sw	a5,-20(s0)
ffffffc0504026ea:	87c18793          	addi	a5,gp,-1924 # ffffffc05045f934 <binsem_num>
ffffffc0504026ee:	4398                	lw	a4,0(a5)
ffffffc0504026f0:	fec42783          	lw	a5,-20(s0)
ffffffc0504026f4:	2781                	sext.w	a5,a5
ffffffc0504026f6:	fae7cde3          	blt	a5,a4,ffffffc0504026b0 <do_binsemget+0x14>
ffffffc0504026fa:	fdc42783          	lw	a5,-36(s0)
ffffffc0504026fe:	02f787bb          	mulw	a5,a5,a5
ffffffc050402702:	2781                	sext.w	a5,a5
ffffffc050402704:	87c18713          	addi	a4,gp,-1924 # ffffffc05045f934 <binsem_num>
ffffffc050402708:	4318                	lw	a4,0(a4)
ffffffc05040270a:	2785                	addiw	a5,a5,1
ffffffc05040270c:	0007869b          	sext.w	a3,a5
ffffffc050402710:	00067617          	auipc	a2,0x67
ffffffc050402714:	1f060613          	addi	a2,a2,496 # ffffffc050469900 <binsem_array>
ffffffc050402718:	87ba                	mv	a5,a4
ffffffc05040271a:	0786                	slli	a5,a5,0x1
ffffffc05040271c:	97ba                	add	a5,a5,a4
ffffffc05040271e:	0792                	slli	a5,a5,0x4
ffffffc050402720:	97b2                	add	a5,a5,a2
ffffffc050402722:	c394                	sw	a3,0(a5)
ffffffc050402724:	87c18793          	addi	a5,gp,-1924 # ffffffc05045f934 <binsem_num>
ffffffc050402728:	4398                	lw	a4,0(a5)
ffffffc05040272a:	87ba                	mv	a5,a4
ffffffc05040272c:	0786                	slli	a5,a5,0x1
ffffffc05040272e:	97ba                	add	a5,a5,a4
ffffffc050402730:	0792                	slli	a5,a5,0x4
ffffffc050402732:	00067717          	auipc	a4,0x67
ffffffc050402736:	1ce70713          	addi	a4,a4,462 # ffffffc050469900 <binsem_array>
ffffffc05040273a:	97ba                	add	a5,a5,a4
ffffffc05040273c:	07a1                	addi	a5,a5,8
ffffffc05040273e:	853e                	mv	a0,a5
ffffffc050402740:	c93ff0ef          	jal	ra,ffffffc0504023d2 <do_mutex_lock_init>
ffffffc050402744:	87c18793          	addi	a5,gp,-1924 # ffffffc05045f934 <binsem_num>
ffffffc050402748:	439c                	lw	a5,0(a5)
ffffffc05040274a:	0017871b          	addiw	a4,a5,1
ffffffc05040274e:	0007069b          	sext.w	a3,a4
ffffffc050402752:	87c18713          	addi	a4,gp,-1924 # ffffffc05045f934 <binsem_num>
ffffffc050402756:	c314                	sw	a3,0(a4)
ffffffc050402758:	853e                	mv	a0,a5
ffffffc05040275a:	70a2                	ld	ra,40(sp)
ffffffc05040275c:	7402                	ld	s0,32(sp)
ffffffc05040275e:	6145                	addi	sp,sp,48
ffffffc050402760:	8082                	ret

ffffffc050402762 <do_binsemop>:
ffffffc050402762:	1101                	addi	sp,sp,-32
ffffffc050402764:	ec06                	sd	ra,24(sp)
ffffffc050402766:	e822                	sd	s0,16(sp)
ffffffc050402768:	1000                	addi	s0,sp,32
ffffffc05040276a:	87aa                	mv	a5,a0
ffffffc05040276c:	872e                	mv	a4,a1
ffffffc05040276e:	fef42623          	sw	a5,-20(s0)
ffffffc050402772:	87ba                	mv	a5,a4
ffffffc050402774:	fef42423          	sw	a5,-24(s0)
ffffffc050402778:	fe842783          	lw	a5,-24(s0)
ffffffc05040277c:	2781                	sext.w	a5,a5
ffffffc05040277e:	e38d                	bnez	a5,ffffffc0504027a0 <do_binsemop+0x3e>
ffffffc050402780:	fec42703          	lw	a4,-20(s0)
ffffffc050402784:	87ba                	mv	a5,a4
ffffffc050402786:	0786                	slli	a5,a5,0x1
ffffffc050402788:	97ba                	add	a5,a5,a4
ffffffc05040278a:	0792                	slli	a5,a5,0x4
ffffffc05040278c:	00067717          	auipc	a4,0x67
ffffffc050402790:	17470713          	addi	a4,a4,372 # ffffffc050469900 <binsem_array>
ffffffc050402794:	97ba                	add	a5,a5,a4
ffffffc050402796:	07a1                	addi	a5,a5,8
ffffffc050402798:	853e                	mv	a0,a5
ffffffc05040279a:	c73ff0ef          	jal	ra,ffffffc05040240c <do_mutex_lock_acquire>
ffffffc05040279e:	a03d                	j	ffffffc0504027cc <do_binsemop+0x6a>
ffffffc0504027a0:	fe842783          	lw	a5,-24(s0)
ffffffc0504027a4:	0007871b          	sext.w	a4,a5
ffffffc0504027a8:	4785                	li	a5,1
ffffffc0504027aa:	02f71163          	bne	a4,a5,ffffffc0504027cc <do_binsemop+0x6a>
ffffffc0504027ae:	fec42703          	lw	a4,-20(s0)
ffffffc0504027b2:	87ba                	mv	a5,a4
ffffffc0504027b4:	0786                	slli	a5,a5,0x1
ffffffc0504027b6:	97ba                	add	a5,a5,a4
ffffffc0504027b8:	0792                	slli	a5,a5,0x4
ffffffc0504027ba:	00067717          	auipc	a4,0x67
ffffffc0504027be:	14670713          	addi	a4,a4,326 # ffffffc050469900 <binsem_array>
ffffffc0504027c2:	97ba                	add	a5,a5,a4
ffffffc0504027c4:	07a1                	addi	a5,a5,8
ffffffc0504027c6:	853e                	mv	a0,a5
ffffffc0504027c8:	cf7ff0ef          	jal	ra,ffffffc0504024be <do_mutex_lock_release>
ffffffc0504027cc:	4781                	li	a5,0
ffffffc0504027ce:	853e                	mv	a0,a5
ffffffc0504027d0:	60e2                	ld	ra,24(sp)
ffffffc0504027d2:	6442                	ld	s0,16(sp)
ffffffc0504027d4:	6105                	addi	sp,sp,32
ffffffc0504027d6:	8082                	ret

ffffffc0504027d8 <local_flush_tlb_all>:
ffffffc0504027d8:	1141                	addi	sp,sp,-16
ffffffc0504027da:	e422                	sd	s0,8(sp)
ffffffc0504027dc:	0800                	addi	s0,sp,16
ffffffc0504027de:	12000073          	sfence.vma
ffffffc0504027e2:	0001                	nop
ffffffc0504027e4:	6422                	ld	s0,8(sp)
ffffffc0504027e6:	0141                	addi	sp,sp,16
ffffffc0504027e8:	8082                	ret

ffffffc0504027ea <set_satp>:
ffffffc0504027ea:	7179                	addi	sp,sp,-48
ffffffc0504027ec:	f422                	sd	s0,40(sp)
ffffffc0504027ee:	1800                	addi	s0,sp,48
ffffffc0504027f0:	87aa                	mv	a5,a0
ffffffc0504027f2:	872e                	mv	a4,a1
ffffffc0504027f4:	fcc43823          	sd	a2,-48(s0)
ffffffc0504027f8:	fcf42e23          	sw	a5,-36(s0)
ffffffc0504027fc:	87ba                	mv	a5,a4
ffffffc0504027fe:	fcf42c23          	sw	a5,-40(s0)
ffffffc050402802:	fdc46783          	lwu	a5,-36(s0)
ffffffc050402806:	03c79713          	slli	a4,a5,0x3c
ffffffc05040280a:	fd846783          	lwu	a5,-40(s0)
ffffffc05040280e:	17b2                	slli	a5,a5,0x2c
ffffffc050402810:	8fd9                	or	a5,a5,a4
ffffffc050402812:	fd043703          	ld	a4,-48(s0)
ffffffc050402816:	8fd9                	or	a5,a5,a4
ffffffc050402818:	fef43423          	sd	a5,-24(s0)
ffffffc05040281c:	fe843783          	ld	a5,-24(s0)
ffffffc050402820:	12000073          	sfence.vma
ffffffc050402824:	18079073          	csrw	satp,a5
ffffffc050402828:	0001                	nop
ffffffc05040282a:	7422                	ld	s0,40(sp)
ffffffc05040282c:	6145                	addi	sp,sp,48
ffffffc05040282e:	8082                	ret

ffffffc050402830 <kva2pa>:
ffffffc050402830:	1101                	addi	sp,sp,-32
ffffffc050402832:	ec22                	sd	s0,24(sp)
ffffffc050402834:	1000                	addi	s0,sp,32
ffffffc050402836:	fea43423          	sd	a0,-24(s0)
ffffffc05040283a:	fe843703          	ld	a4,-24(s0)
ffffffc05040283e:	4785                	li	a5,1
ffffffc050402840:	179a                	slli	a5,a5,0x26
ffffffc050402842:	97ba                	add	a5,a5,a4
ffffffc050402844:	853e                	mv	a0,a5
ffffffc050402846:	6462                	ld	s0,24(sp)
ffffffc050402848:	6105                	addi	sp,sp,32
ffffffc05040284a:	8082                	ret

ffffffc05040284c <pa2kva>:
ffffffc05040284c:	1101                	addi	sp,sp,-32
ffffffc05040284e:	ec22                	sd	s0,24(sp)
ffffffc050402850:	1000                	addi	s0,sp,32
ffffffc050402852:	fea43423          	sd	a0,-24(s0)
ffffffc050402856:	fe843703          	ld	a4,-24(s0)
ffffffc05040285a:	57fd                	li	a5,-1
ffffffc05040285c:	179a                	slli	a5,a5,0x26
ffffffc05040285e:	97ba                	add	a5,a5,a4
ffffffc050402860:	853e                	mv	a0,a5
ffffffc050402862:	6462                	ld	s0,24(sp)
ffffffc050402864:	6105                	addi	sp,sp,32
ffffffc050402866:	8082                	ret

ffffffc050402868 <get_pa>:
ffffffc050402868:	1101                	addi	sp,sp,-32
ffffffc05040286a:	ec22                	sd	s0,24(sp)
ffffffc05040286c:	1000                	addi	s0,sp,32
ffffffc05040286e:	fea43423          	sd	a0,-24(s0)
ffffffc050402872:	fe843783          	ld	a5,-24(s0)
ffffffc050402876:	83a9                	srli	a5,a5,0xa
ffffffc050402878:	00c79713          	slli	a4,a5,0xc
ffffffc05040287c:	fff007b7          	lui	a5,0xfff00
ffffffc050402880:	83a1                	srli	a5,a5,0x8
ffffffc050402882:	8ff9                	and	a5,a5,a4
ffffffc050402884:	853e                	mv	a0,a5
ffffffc050402886:	6462                	ld	s0,24(sp)
ffffffc050402888:	6105                	addi	sp,sp,32
ffffffc05040288a:	8082                	ret

ffffffc05040288c <get_kva_of>:
ffffffc05040288c:	7159                	addi	sp,sp,-112
ffffffc05040288e:	f486                	sd	ra,104(sp)
ffffffc050402890:	f0a2                	sd	s0,96(sp)
ffffffc050402892:	1880                	addi	s0,sp,112
ffffffc050402894:	f8a43c23          	sd	a0,-104(s0)
ffffffc050402898:	f8b43823          	sd	a1,-112(s0)
ffffffc05040289c:	f9843783          	ld	a5,-104(s0)
ffffffc0504028a0:	83f9                	srli	a5,a5,0x1e
ffffffc0504028a2:	2781                	sext.w	a5,a5
ffffffc0504028a4:	1ff7f793          	andi	a5,a5,511
ffffffc0504028a8:	fef42623          	sw	a5,-20(s0)
ffffffc0504028ac:	f9843783          	ld	a5,-104(s0)
ffffffc0504028b0:	83d5                	srli	a5,a5,0x15
ffffffc0504028b2:	2781                	sext.w	a5,a5
ffffffc0504028b4:	1ff7f793          	andi	a5,a5,511
ffffffc0504028b8:	fef42423          	sw	a5,-24(s0)
ffffffc0504028bc:	f9843783          	ld	a5,-104(s0)
ffffffc0504028c0:	83b1                	srli	a5,a5,0xc
ffffffc0504028c2:	2781                	sext.w	a5,a5
ffffffc0504028c4:	1ff7f793          	andi	a5,a5,511
ffffffc0504028c8:	fef42223          	sw	a5,-28(s0)
ffffffc0504028cc:	f9043783          	ld	a5,-112(s0)
ffffffc0504028d0:	fcf43c23          	sd	a5,-40(s0)
ffffffc0504028d4:	fec46783          	lwu	a5,-20(s0)
ffffffc0504028d8:	078e                	slli	a5,a5,0x3
ffffffc0504028da:	fd843703          	ld	a4,-40(s0)
ffffffc0504028de:	97ba                	add	a5,a5,a4
ffffffc0504028e0:	639c                	ld	a5,0(a5)
ffffffc0504028e2:	853e                	mv	a0,a5
ffffffc0504028e4:	f85ff0ef          	jal	ra,ffffffc050402868 <get_pa>
ffffffc0504028e8:	87aa                	mv	a5,a0
ffffffc0504028ea:	fcf43823          	sd	a5,-48(s0)
ffffffc0504028ee:	fd043783          	ld	a5,-48(s0)
ffffffc0504028f2:	853e                	mv	a0,a5
ffffffc0504028f4:	f59ff0ef          	jal	ra,ffffffc05040284c <pa2kva>
ffffffc0504028f8:	87aa                	mv	a5,a0
ffffffc0504028fa:	fcf43423          	sd	a5,-56(s0)
ffffffc0504028fe:	fe846783          	lwu	a5,-24(s0)
ffffffc050402902:	078e                	slli	a5,a5,0x3
ffffffc050402904:	fc843703          	ld	a4,-56(s0)
ffffffc050402908:	97ba                	add	a5,a5,a4
ffffffc05040290a:	639c                	ld	a5,0(a5)
ffffffc05040290c:	853e                	mv	a0,a5
ffffffc05040290e:	f5bff0ef          	jal	ra,ffffffc050402868 <get_pa>
ffffffc050402912:	87aa                	mv	a5,a0
ffffffc050402914:	fcf43023          	sd	a5,-64(s0)
ffffffc050402918:	fc043783          	ld	a5,-64(s0)
ffffffc05040291c:	853e                	mv	a0,a5
ffffffc05040291e:	f2fff0ef          	jal	ra,ffffffc05040284c <pa2kva>
ffffffc050402922:	87aa                	mv	a5,a0
ffffffc050402924:	faf43c23          	sd	a5,-72(s0)
ffffffc050402928:	fe446783          	lwu	a5,-28(s0)
ffffffc05040292c:	078e                	slli	a5,a5,0x3
ffffffc05040292e:	fb843703          	ld	a4,-72(s0)
ffffffc050402932:	97ba                	add	a5,a5,a4
ffffffc050402934:	639c                	ld	a5,0(a5)
ffffffc050402936:	853e                	mv	a0,a5
ffffffc050402938:	f31ff0ef          	jal	ra,ffffffc050402868 <get_pa>
ffffffc05040293c:	faa43823          	sd	a0,-80(s0)
ffffffc050402940:	fb043503          	ld	a0,-80(s0)
ffffffc050402944:	f09ff0ef          	jal	ra,ffffffc05040284c <pa2kva>
ffffffc050402948:	faa43423          	sd	a0,-88(s0)
ffffffc05040294c:	fa843783          	ld	a5,-88(s0)
ffffffc050402950:	853e                	mv	a0,a5
ffffffc050402952:	70a6                	ld	ra,104(sp)
ffffffc050402954:	7406                	ld	s0,96(sp)
ffffffc050402956:	6165                	addi	sp,sp,112
ffffffc050402958:	8082                	ret

ffffffc05040295a <set_pfn>:
ffffffc05040295a:	7179                	addi	sp,sp,-48
ffffffc05040295c:	f422                	sd	s0,40(sp)
ffffffc05040295e:	1800                	addi	s0,sp,48
ffffffc050402960:	fca43c23          	sd	a0,-40(s0)
ffffffc050402964:	fcb43823          	sd	a1,-48(s0)
ffffffc050402968:	fd843783          	ld	a5,-40(s0)
ffffffc05040296c:	639c                	ld	a5,0(a5)
ffffffc05040296e:	3ff7f793          	andi	a5,a5,1023
ffffffc050402972:	fef43423          	sd	a5,-24(s0)
ffffffc050402976:	fd043783          	ld	a5,-48(s0)
ffffffc05040297a:	00a79713          	slli	a4,a5,0xa
ffffffc05040297e:	fe843783          	ld	a5,-24(s0)
ffffffc050402982:	8f5d                	or	a4,a4,a5
ffffffc050402984:	fd843783          	ld	a5,-40(s0)
ffffffc050402988:	e398                	sd	a4,0(a5)
ffffffc05040298a:	0001                	nop
ffffffc05040298c:	7422                	ld	s0,40(sp)
ffffffc05040298e:	6145                	addi	sp,sp,48
ffffffc050402990:	8082                	ret

ffffffc050402992 <set_attribute>:
ffffffc050402992:	1101                	addi	sp,sp,-32
ffffffc050402994:	ec22                	sd	s0,24(sp)
ffffffc050402996:	1000                	addi	s0,sp,32
ffffffc050402998:	fea43423          	sd	a0,-24(s0)
ffffffc05040299c:	feb43023          	sd	a1,-32(s0)
ffffffc0504029a0:	fe843783          	ld	a5,-24(s0)
ffffffc0504029a4:	6398                	ld	a4,0(a5)
ffffffc0504029a6:	fe043783          	ld	a5,-32(s0)
ffffffc0504029aa:	8f5d                	or	a4,a4,a5
ffffffc0504029ac:	fe843783          	ld	a5,-24(s0)
ffffffc0504029b0:	e398                	sd	a4,0(a5)
ffffffc0504029b2:	0001                	nop
ffffffc0504029b4:	6462                	ld	s0,24(sp)
ffffffc0504029b6:	6105                	addi	sp,sp,32
ffffffc0504029b8:	8082                	ret

ffffffc0504029ba <is_elf_format>:
ffffffc0504029ba:	7179                	addi	sp,sp,-48
ffffffc0504029bc:	f422                	sd	s0,40(sp)
ffffffc0504029be:	1800                	addi	s0,sp,48
ffffffc0504029c0:	fca43c23          	sd	a0,-40(s0)
ffffffc0504029c4:	fd843783          	ld	a5,-40(s0)
ffffffc0504029c8:	fef43423          	sd	a5,-24(s0)
ffffffc0504029cc:	fe843783          	ld	a5,-24(s0)
ffffffc0504029d0:	0007c783          	lbu	a5,0(a5) # fffffffffff00000 <__BSS_END__+0x3fafa8bc18>
ffffffc0504029d4:	eb9d                	bnez	a5,ffffffc050402a0a <is_elf_format+0x50>
ffffffc0504029d6:	fe843783          	ld	a5,-24(s0)
ffffffc0504029da:	0017c783          	lbu	a5,1(a5)
ffffffc0504029de:	873e                	mv	a4,a5
ffffffc0504029e0:	4785                	li	a5,1
ffffffc0504029e2:	02f71463          	bne	a4,a5,ffffffc050402a0a <is_elf_format+0x50>
ffffffc0504029e6:	fe843783          	ld	a5,-24(s0)
ffffffc0504029ea:	0027c783          	lbu	a5,2(a5)
ffffffc0504029ee:	873e                	mv	a4,a5
ffffffc0504029f0:	4789                	li	a5,2
ffffffc0504029f2:	00f71c63          	bne	a4,a5,ffffffc050402a0a <is_elf_format+0x50>
ffffffc0504029f6:	fe843783          	ld	a5,-24(s0)
ffffffc0504029fa:	0037c783          	lbu	a5,3(a5)
ffffffc0504029fe:	873e                	mv	a4,a5
ffffffc050402a00:	478d                	li	a5,3
ffffffc050402a02:	00f71463          	bne	a4,a5,ffffffc050402a0a <is_elf_format+0x50>
ffffffc050402a06:	4781                	li	a5,0
ffffffc050402a08:	a011                	j	ffffffc050402a0c <is_elf_format+0x52>
ffffffc050402a0a:	4785                	li	a5,1
ffffffc050402a0c:	853e                	mv	a0,a5
ffffffc050402a0e:	7422                	ld	s0,40(sp)
ffffffc050402a10:	6145                	addi	sp,sp,48
ffffffc050402a12:	8082                	ret

ffffffc050402a14 <load_elf>:
ffffffc050402a14:	7159                	addi	sp,sp,-112
ffffffc050402a16:	f486                	sd	ra,104(sp)
ffffffc050402a18:	f0a2                	sd	s0,96(sp)
ffffffc050402a1a:	1880                	addi	s0,sp,112
ffffffc050402a1c:	faa43423          	sd	a0,-88(s0)
ffffffc050402a20:	87ae                	mv	a5,a1
ffffffc050402a22:	f8c43c23          	sd	a2,-104(s0)
ffffffc050402a26:	f8d43823          	sd	a3,-112(s0)
ffffffc050402a2a:	faf42223          	sw	a5,-92(s0)
ffffffc050402a2e:	fa843783          	ld	a5,-88(s0)
ffffffc050402a32:	fcf43823          	sd	a5,-48(s0)
ffffffc050402a36:	fc043423          	sd	zero,-56(s0)
ffffffc050402a3a:	fe043423          	sd	zero,-24(s0)
ffffffc050402a3e:	fe042023          	sw	zero,-32(s0)
ffffffc050402a42:	fa442783          	lw	a5,-92(s0)
ffffffc050402a46:	0007871b          	sext.w	a4,a5
ffffffc050402a4a:	478d                	li	a5,3
ffffffc050402a4c:	00e7f863          	bgeu	a5,a4,ffffffc050402a5c <load_elf+0x48>
ffffffc050402a50:	fa843503          	ld	a0,-88(s0)
ffffffc050402a54:	f67ff0ef          	jal	ra,ffffffc0504029ba <is_elf_format>
ffffffc050402a58:	87aa                	mv	a5,a0
ffffffc050402a5a:	e399                	bnez	a5,ffffffc050402a60 <load_elf+0x4c>
ffffffc050402a5c:	4781                	li	a5,0
ffffffc050402a5e:	a259                	j	ffffffc050402be4 <load_elf+0x1d0>
ffffffc050402a60:	fd043783          	ld	a5,-48(s0)
ffffffc050402a64:	739c                	ld	a5,32(a5)
ffffffc050402a66:	fa843703          	ld	a4,-88(s0)
ffffffc050402a6a:	97ba                	add	a5,a5,a4
ffffffc050402a6c:	fef43423          	sd	a5,-24(s0)
ffffffc050402a70:	fd043783          	ld	a5,-48(s0)
ffffffc050402a74:	0387d783          	lhu	a5,56(a5)
ffffffc050402a78:	fef41323          	sh	a5,-26(s0)
ffffffc050402a7c:	fd043783          	ld	a5,-48(s0)
ffffffc050402a80:	0367d783          	lhu	a5,54(a5)
ffffffc050402a84:	fcf41323          	sh	a5,-58(s0)
ffffffc050402a88:	a299                	j	ffffffc050402bce <load_elf+0x1ba>
ffffffc050402a8a:	fe843783          	ld	a5,-24(s0)
ffffffc050402a8e:	fcf43423          	sd	a5,-56(s0)
ffffffc050402a92:	fc843783          	ld	a5,-56(s0)
ffffffc050402a96:	439c                	lw	a5,0(a5)
ffffffc050402a98:	873e                	mv	a4,a5
ffffffc050402a9a:	4785                	li	a5,1
ffffffc050402a9c:	12f71263          	bne	a4,a5,ffffffc050402bc0 <load_elf+0x1ac>
ffffffc050402aa0:	fe042023          	sw	zero,-32(s0)
ffffffc050402aa4:	a239                	j	ffffffc050402bb2 <load_elf+0x19e>
ffffffc050402aa6:	fe042703          	lw	a4,-32(s0)
ffffffc050402aaa:	fc843783          	ld	a5,-56(s0)
ffffffc050402aae:	739c                	ld	a5,32(a5)
ffffffc050402ab0:	0af77463          	bgeu	a4,a5,ffffffc050402b58 <load_elf+0x144>
ffffffc050402ab4:	fc843783          	ld	a5,-56(s0)
ffffffc050402ab8:	6b98                	ld	a4,16(a5)
ffffffc050402aba:	fe042783          	lw	a5,-32(s0)
ffffffc050402abe:	97ba                	add	a5,a5,a4
ffffffc050402ac0:	f9043703          	ld	a4,-112(s0)
ffffffc050402ac4:	f9843583          	ld	a1,-104(s0)
ffffffc050402ac8:	853e                	mv	a0,a5
ffffffc050402aca:	9702                	jalr	a4
ffffffc050402acc:	87aa                	mv	a5,a0
ffffffc050402ace:	faf43823          	sd	a5,-80(s0)
ffffffc050402ad2:	fc843783          	ld	a5,-56(s0)
ffffffc050402ad6:	6798                	ld	a4,8(a5)
ffffffc050402ad8:	fe042783          	lw	a5,-32(s0)
ffffffc050402adc:	97ba                	add	a5,a5,a4
ffffffc050402ade:	fa843703          	ld	a4,-88(s0)
ffffffc050402ae2:	00f706b3          	add	a3,a4,a5
ffffffc050402ae6:	fc843783          	ld	a5,-56(s0)
ffffffc050402aea:	7398                	ld	a4,32(a5)
ffffffc050402aec:	fe042783          	lw	a5,-32(s0)
ffffffc050402af0:	40f707b3          	sub	a5,a4,a5
ffffffc050402af4:	6705                	lui	a4,0x1
ffffffc050402af6:	00f77363          	bgeu	a4,a5,ffffffc050402afc <load_elf+0xe8>
ffffffc050402afa:	6785                	lui	a5,0x1
ffffffc050402afc:	2781                	sext.w	a5,a5
ffffffc050402afe:	863e                	mv	a2,a5
ffffffc050402b00:	85b6                	mv	a1,a3
ffffffc050402b02:	fb043503          	ld	a0,-80(s0)
ffffffc050402b06:	0cd030ef          	jal	ra,ffffffc0504063d2 <memcpy>
ffffffc050402b0a:	fc843783          	ld	a5,-56(s0)
ffffffc050402b0e:	7398                	ld	a4,32(a5)
ffffffc050402b10:	fe042783          	lw	a5,-32(s0)
ffffffc050402b14:	8f1d                	sub	a4,a4,a5
ffffffc050402b16:	6785                	lui	a5,0x1
ffffffc050402b18:	08f77663          	bgeu	a4,a5,ffffffc050402ba4 <load_elf+0x190>
ffffffc050402b1c:	fc843783          	ld	a5,-56(s0)
ffffffc050402b20:	739c                	ld	a5,32(a5)
ffffffc050402b22:	0007871b          	sext.w	a4,a5
ffffffc050402b26:	6785                	lui	a5,0x1
ffffffc050402b28:	17fd                	addi	a5,a5,-1
ffffffc050402b2a:	8ff9                	and	a5,a5,a4
ffffffc050402b2c:	fcf42e23          	sw	a5,-36(s0)
ffffffc050402b30:	a829                	j	ffffffc050402b4a <load_elf+0x136>
ffffffc050402b32:	fdc42783          	lw	a5,-36(s0)
ffffffc050402b36:	fb043703          	ld	a4,-80(s0)
ffffffc050402b3a:	97ba                	add	a5,a5,a4
ffffffc050402b3c:	00078023          	sb	zero,0(a5) # 1000 <_start-0xffffffc0503ff000>
ffffffc050402b40:	fdc42783          	lw	a5,-36(s0)
ffffffc050402b44:	2785                	addiw	a5,a5,1
ffffffc050402b46:	fcf42e23          	sw	a5,-36(s0)
ffffffc050402b4a:	fdc42783          	lw	a5,-36(s0)
ffffffc050402b4e:	873e                	mv	a4,a5
ffffffc050402b50:	6785                	lui	a5,0x1
ffffffc050402b52:	fef760e3          	bltu	a4,a5,ffffffc050402b32 <load_elf+0x11e>
ffffffc050402b56:	a0b9                	j	ffffffc050402ba4 <load_elf+0x190>
ffffffc050402b58:	fc843783          	ld	a5,-56(s0)
ffffffc050402b5c:	6b98                	ld	a4,16(a5)
ffffffc050402b5e:	fe042783          	lw	a5,-32(s0)
ffffffc050402b62:	97ba                	add	a5,a5,a4
ffffffc050402b64:	f9043703          	ld	a4,-112(s0)
ffffffc050402b68:	f9843583          	ld	a1,-104(s0)
ffffffc050402b6c:	853e                	mv	a0,a5
ffffffc050402b6e:	9702                	jalr	a4
ffffffc050402b70:	87aa                	mv	a5,a0
ffffffc050402b72:	faf43c23          	sd	a5,-72(s0)
ffffffc050402b76:	fc042c23          	sw	zero,-40(s0)
ffffffc050402b7a:	a831                	j	ffffffc050402b96 <load_elf+0x182>
ffffffc050402b7c:	fd842783          	lw	a5,-40(s0)
ffffffc050402b80:	078e                	slli	a5,a5,0x3
ffffffc050402b82:	fb843703          	ld	a4,-72(s0)
ffffffc050402b86:	97ba                	add	a5,a5,a4
ffffffc050402b88:	0007b023          	sd	zero,0(a5) # 1000 <_start-0xffffffc0503ff000>
ffffffc050402b8c:	fd842783          	lw	a5,-40(s0)
ffffffc050402b90:	2785                	addiw	a5,a5,1
ffffffc050402b92:	fcf42c23          	sw	a5,-40(s0)
ffffffc050402b96:	fd842783          	lw	a5,-40(s0)
ffffffc050402b9a:	873e                	mv	a4,a5
ffffffc050402b9c:	1ff00793          	li	a5,511
ffffffc050402ba0:	fce7fee3          	bgeu	a5,a4,ffffffc050402b7c <load_elf+0x168>
ffffffc050402ba4:	fe042703          	lw	a4,-32(s0)
ffffffc050402ba8:	6785                	lui	a5,0x1
ffffffc050402baa:	9fb9                	addw	a5,a5,a4
ffffffc050402bac:	2781                	sext.w	a5,a5
ffffffc050402bae:	fef42023          	sw	a5,-32(s0)
ffffffc050402bb2:	fe042703          	lw	a4,-32(s0)
ffffffc050402bb6:	fc843783          	ld	a5,-56(s0)
ffffffc050402bba:	779c                	ld	a5,40(a5)
ffffffc050402bbc:	eef765e3          	bltu	a4,a5,ffffffc050402aa6 <load_elf+0x92>
ffffffc050402bc0:	fc645783          	lhu	a5,-58(s0)
ffffffc050402bc4:	fe843703          	ld	a4,-24(s0)
ffffffc050402bc8:	97ba                	add	a5,a5,a4
ffffffc050402bca:	fef43423          	sd	a5,-24(s0)
ffffffc050402bce:	fe645783          	lhu	a5,-26(s0)
ffffffc050402bd2:	fff7871b          	addiw	a4,a5,-1
ffffffc050402bd6:	fee41323          	sh	a4,-26(s0)
ffffffc050402bda:	ea0798e3          	bnez	a5,ffffffc050402a8a <load_elf+0x76>
ffffffc050402bde:	fd043783          	ld	a5,-48(s0)
ffffffc050402be2:	6f9c                	ld	a5,24(a5)
ffffffc050402be4:	853e                	mv	a0,a5
ffffffc050402be6:	70a6                	ld	ra,104(sp)
ffffffc050402be8:	7406                	ld	s0,96(sp)
ffffffc050402bea:	6165                	addi	sp,sp,112
ffffffc050402bec:	8082                	ret

ffffffc050402bee <do_scheduler>:
ffffffc050402bee:	715d                	addi	sp,sp,-80
ffffffc050402bf0:	e486                	sd	ra,72(sp)
ffffffc050402bf2:	e0a2                	sd	s0,64(sp)
ffffffc050402bf4:	fc26                	sd	s1,56(sp)
ffffffc050402bf6:	0880                	addi	s0,sp,80
ffffffc050402bf8:	f48fd0ef          	jal	ra,ffffffc050400340 <get_current_cpu_id>
ffffffc050402bfc:	87aa                	mv	a5,a0
ffffffc050402bfe:	fcf42223          	sw	a5,-60(s0)
ffffffc050402c02:	7e8010ef          	jal	ra,ffffffc0504043ea <get_timer>
ffffffc050402c06:	faa43c23          	sd	a0,-72(s0)
ffffffc050402c0a:	00070797          	auipc	a5,0x70
ffffffc050402c0e:	29678793          	addi	a5,a5,662 # ffffffc050472ea0 <sleep_queue>
ffffffc050402c12:	fcf43423          	sd	a5,-56(s0)
ffffffc050402c16:	a841                	j	ffffffc050402ca6 <do_scheduler+0xb8>
ffffffc050402c18:	fc843783          	ld	a5,-56(s0)
ffffffc050402c1c:	679c                	ld	a5,8(a5)
ffffffc050402c1e:	4394                	lw	a3,0(a5)
ffffffc050402c20:	00070717          	auipc	a4,0x70
ffffffc050402c24:	29870713          	addi	a4,a4,664 # ffffffc050472eb8 <pcb>
ffffffc050402c28:	09800793          	li	a5,152
ffffffc050402c2c:	02f687b3          	mul	a5,a3,a5
ffffffc050402c30:	97ba                	add	a5,a5,a4
ffffffc050402c32:	77bc                	ld	a5,104(a5)
ffffffc050402c34:	fb843703          	ld	a4,-72(s0)
ffffffc050402c38:	06f76263          	bltu	a4,a5,ffffffc050402c9c <do_scheduler+0xae>
ffffffc050402c3c:	fc843783          	ld	a5,-56(s0)
ffffffc050402c40:	679c                	ld	a5,8(a5)
ffffffc050402c42:	4394                	lw	a3,0(a5)
ffffffc050402c44:	00070717          	auipc	a4,0x70
ffffffc050402c48:	27470713          	addi	a4,a4,628 # ffffffc050472eb8 <pcb>
ffffffc050402c4c:	09800793          	li	a5,152
ffffffc050402c50:	02f687b3          	mul	a5,a3,a5
ffffffc050402c54:	97ba                	add	a5,a5,a4
ffffffc050402c56:	470d                	li	a4,3
ffffffc050402c58:	cff8                	sw	a4,92(a5)
ffffffc050402c5a:	fc843783          	ld	a5,-56(s0)
ffffffc050402c5e:	679c                	ld	a5,8(a5)
ffffffc050402c60:	4394                	lw	a3,0(a5)
ffffffc050402c62:	00070717          	auipc	a4,0x70
ffffffc050402c66:	25670713          	addi	a4,a4,598 # ffffffc050472eb8 <pcb>
ffffffc050402c6a:	09800793          	li	a5,152
ffffffc050402c6e:	02f687b3          	mul	a5,a3,a5
ffffffc050402c72:	97ba                	add	a5,a5,a4
ffffffc050402c74:	00070717          	auipc	a4,0x70
ffffffc050402c78:	20470713          	addi	a4,a4,516 # ffffffc050472e78 <ready_queue>
ffffffc050402c7c:	e7b8                	sd	a4,72(a5)
ffffffc050402c7e:	fc843783          	ld	a5,-56(s0)
ffffffc050402c82:	679c                	ld	a5,8(a5)
ffffffc050402c84:	00070617          	auipc	a2,0x70
ffffffc050402c88:	21c60613          	addi	a2,a2,540 # ffffffc050472ea0 <sleep_queue>
ffffffc050402c8c:	00070597          	auipc	a1,0x70
ffffffc050402c90:	1ec58593          	addi	a1,a1,492 # ffffffc050472e78 <ready_queue>
ffffffc050402c94:	853e                	mv	a0,a5
ffffffc050402c96:	384000ef          	jal	ra,ffffffc05040301a <move_node>
ffffffc050402c9a:	a031                	j	ffffffc050402ca6 <do_scheduler+0xb8>
ffffffc050402c9c:	fc843783          	ld	a5,-56(s0)
ffffffc050402ca0:	679c                	ld	a5,8(a5)
ffffffc050402ca2:	fcf43423          	sd	a5,-56(s0)
ffffffc050402ca6:	00070797          	auipc	a5,0x70
ffffffc050402caa:	1fa78793          	addi	a5,a5,506 # ffffffc050472ea0 <sleep_queue>
ffffffc050402cae:	439c                	lw	a5,0(a5)
ffffffc050402cb0:	00f05663          	blez	a5,ffffffc050402cbc <do_scheduler+0xce>
ffffffc050402cb4:	fc843783          	ld	a5,-56(s0)
ffffffc050402cb8:	679c                	ld	a5,8(a5)
ffffffc050402cba:	ffb9                	bnez	a5,ffffffc050402c18 <do_scheduler+0x2a>
ffffffc050402cbc:	00070797          	auipc	a5,0x70
ffffffc050402cc0:	1bc78793          	addi	a5,a5,444 # ffffffc050472e78 <ready_queue>
ffffffc050402cc4:	439c                	lw	a5,0(a5)
ffffffc050402cc6:	2a078063          	beqz	a5,ffffffc050402f66 <do_scheduler+0x378>
ffffffc050402cca:	00070717          	auipc	a4,0x70
ffffffc050402cce:	1c670713          	addi	a4,a4,454 # ffffffc050472e90 <current_running>
ffffffc050402cd2:	fc442783          	lw	a5,-60(s0)
ffffffc050402cd6:	078e                	slli	a5,a5,0x3
ffffffc050402cd8:	97ba                	add	a5,a5,a4
ffffffc050402cda:	639c                	ld	a5,0(a5)
ffffffc050402cdc:	faf43823          	sd	a5,-80(s0)
ffffffc050402ce0:	00070717          	auipc	a4,0x70
ffffffc050402ce4:	18870713          	addi	a4,a4,392 # ffffffc050472e68 <screen_cursor_x>
ffffffc050402ce8:	fc442783          	lw	a5,-60(s0)
ffffffc050402cec:	078a                	slli	a5,a5,0x2
ffffffc050402cee:	97ba                	add	a5,a5,a4
ffffffc050402cf0:	4398                	lw	a4,0(a5)
ffffffc050402cf2:	fb043783          	ld	a5,-80(s0)
ffffffc050402cf6:	08e7a423          	sw	a4,136(a5)
ffffffc050402cfa:	00070717          	auipc	a4,0x70
ffffffc050402cfe:	17670713          	addi	a4,a4,374 # ffffffc050472e70 <screen_cursor_y>
ffffffc050402d02:	fc442783          	lw	a5,-60(s0)
ffffffc050402d06:	078a                	slli	a5,a5,0x2
ffffffc050402d08:	97ba                	add	a5,a5,a4
ffffffc050402d0a:	4398                	lw	a4,0(a5)
ffffffc050402d0c:	fb043783          	ld	a5,-80(s0)
ffffffc050402d10:	08e7a623          	sw	a4,140(a5)
ffffffc050402d14:	fb043783          	ld	a5,-80(s0)
ffffffc050402d18:	4ffc                	lw	a5,92(a5)
ffffffc050402d1a:	873e                	mv	a4,a5
ffffffc050402d1c:	4789                	li	a5,2
ffffffc050402d1e:	00f71663          	bne	a4,a5,ffffffc050402d2a <do_scheduler+0x13c>
ffffffc050402d22:	fb043783          	ld	a5,-80(s0)
ffffffc050402d26:	470d                	li	a4,3
ffffffc050402d28:	cff8                	sw	a4,92(a5)
ffffffc050402d2a:	0005f717          	auipc	a4,0x5f
ffffffc050402d2e:	c7670713          	addi	a4,a4,-906 # ffffffc0504619a0 <cpu_pcb_pointer>
ffffffc050402d32:	fc442783          	lw	a5,-60(s0)
ffffffc050402d36:	078e                	slli	a5,a5,0x3
ffffffc050402d38:	97ba                	add	a5,a5,a4
ffffffc050402d3a:	639c                	ld	a5,0(a5)
ffffffc050402d3c:	873e                	mv	a4,a5
ffffffc050402d3e:	fb043783          	ld	a5,-80(s0)
ffffffc050402d42:	00e79a63          	bne	a5,a4,ffffffc050402d56 <do_scheduler+0x168>
ffffffc050402d46:	4705                	li	a4,1
ffffffc050402d48:	fc442783          	lw	a5,-60(s0)
ffffffc050402d4c:	40f707bb          	subw	a5,a4,a5
ffffffc050402d50:	fcf42a23          	sw	a5,-44(s0)
ffffffc050402d54:	a0d1                	j	ffffffc050402e18 <do_scheduler+0x22a>
ffffffc050402d56:	fb043783          	ld	a5,-80(s0)
ffffffc050402d5a:	739c                	ld	a5,32(a5)
ffffffc050402d5c:	fcf43c23          	sd	a5,-40(s0)
ffffffc050402d60:	fb043783          	ld	a5,-80(s0)
ffffffc050402d64:	07e1                	addi	a5,a5,24
ffffffc050402d66:	fd843703          	ld	a4,-40(s0)
ffffffc050402d6a:	0af70163          	beq	a4,a5,ffffffc050402e0c <do_scheduler+0x21e>
ffffffc050402d6e:	fd843783          	ld	a5,-40(s0)
ffffffc050402d72:	cb89                	beqz	a5,ffffffc050402d84 <do_scheduler+0x196>
ffffffc050402d74:	fd843703          	ld	a4,-40(s0)
ffffffc050402d78:	00070797          	auipc	a5,0x70
ffffffc050402d7c:	10078793          	addi	a5,a5,256 # ffffffc050472e78 <ready_queue>
ffffffc050402d80:	00f71a63          	bne	a4,a5,ffffffc050402d94 <do_scheduler+0x1a6>
ffffffc050402d84:	00070797          	auipc	a5,0x70
ffffffc050402d88:	0f478793          	addi	a5,a5,244 # ffffffc050472e78 <ready_queue>
ffffffc050402d8c:	679c                	ld	a5,8(a5)
ffffffc050402d8e:	fcf43c23          	sd	a5,-40(s0)
ffffffc050402d92:	a8a5                	j	ffffffc050402e0a <do_scheduler+0x21c>
ffffffc050402d94:	fd843783          	ld	a5,-40(s0)
ffffffc050402d98:	439c                	lw	a5,0(a5)
ffffffc050402d9a:	fcf42a23          	sw	a5,-44(s0)
ffffffc050402d9e:	00070717          	auipc	a4,0x70
ffffffc050402da2:	11a70713          	addi	a4,a4,282 # ffffffc050472eb8 <pcb>
ffffffc050402da6:	fd442683          	lw	a3,-44(s0)
ffffffc050402daa:	09800793          	li	a5,152
ffffffc050402dae:	02f687b3          	mul	a5,a3,a5
ffffffc050402db2:	97ba                	add	a5,a5,a4
ffffffc050402db4:	4ffc                	lw	a5,92(a5)
ffffffc050402db6:	873e                	mv	a4,a5
ffffffc050402db8:	478d                	li	a5,3
ffffffc050402dba:	04f71363          	bne	a4,a5,ffffffc050402e00 <do_scheduler+0x212>
ffffffc050402dbe:	00070717          	auipc	a4,0x70
ffffffc050402dc2:	0fa70713          	addi	a4,a4,250 # ffffffc050472eb8 <pcb>
ffffffc050402dc6:	fd442683          	lw	a3,-44(s0)
ffffffc050402dca:	09800793          	li	a5,152
ffffffc050402dce:	02f687b3          	mul	a5,a3,a5
ffffffc050402dd2:	97ba                	add	a5,a5,a4
ffffffc050402dd4:	4bfc                	lw	a5,84(a5)
ffffffc050402dd6:	873e                	mv	a4,a5
ffffffc050402dd8:	57fd                	li	a5,-1
ffffffc050402dda:	02f70a63          	beq	a4,a5,ffffffc050402e0e <do_scheduler+0x220>
ffffffc050402dde:	00070717          	auipc	a4,0x70
ffffffc050402de2:	0da70713          	addi	a4,a4,218 # ffffffc050472eb8 <pcb>
ffffffc050402de6:	fd442683          	lw	a3,-44(s0)
ffffffc050402dea:	09800793          	li	a5,152
ffffffc050402dee:	02f687b3          	mul	a5,a3,a5
ffffffc050402df2:	97ba                	add	a5,a5,a4
ffffffc050402df4:	4bf8                	lw	a4,84(a5)
ffffffc050402df6:	fc442783          	lw	a5,-60(s0)
ffffffc050402dfa:	2781                	sext.w	a5,a5
ffffffc050402dfc:	00e78963          	beq	a5,a4,ffffffc050402e0e <do_scheduler+0x220>
ffffffc050402e00:	fd843783          	ld	a5,-40(s0)
ffffffc050402e04:	679c                	ld	a5,8(a5)
ffffffc050402e06:	fcf43c23          	sd	a5,-40(s0)
ffffffc050402e0a:	bf99                	j	ffffffc050402d60 <do_scheduler+0x172>
ffffffc050402e0c:	0001                	nop
ffffffc050402e0e:	fd843783          	ld	a5,-40(s0)
ffffffc050402e12:	439c                	lw	a5,0(a5)
ffffffc050402e14:	fcf42a23          	sw	a5,-44(s0)
ffffffc050402e18:	fd442703          	lw	a4,-44(s0)
ffffffc050402e1c:	09800793          	li	a5,152
ffffffc050402e20:	02f70733          	mul	a4,a4,a5
ffffffc050402e24:	00070797          	auipc	a5,0x70
ffffffc050402e28:	09478793          	addi	a5,a5,148 # ffffffc050472eb8 <pcb>
ffffffc050402e2c:	973e                	add	a4,a4,a5
ffffffc050402e2e:	00070697          	auipc	a3,0x70
ffffffc050402e32:	06268693          	addi	a3,a3,98 # ffffffc050472e90 <current_running>
ffffffc050402e36:	fc442783          	lw	a5,-60(s0)
ffffffc050402e3a:	078e                	slli	a5,a5,0x3
ffffffc050402e3c:	97b6                	add	a5,a5,a3
ffffffc050402e3e:	e398                	sd	a4,0(a5)
ffffffc050402e40:	00070717          	auipc	a4,0x70
ffffffc050402e44:	05070713          	addi	a4,a4,80 # ffffffc050472e90 <current_running>
ffffffc050402e48:	fc442783          	lw	a5,-60(s0)
ffffffc050402e4c:	078e                	slli	a5,a5,0x3
ffffffc050402e4e:	97ba                	add	a5,a5,a4
ffffffc050402e50:	639c                	ld	a5,0(a5)
ffffffc050402e52:	4709                	li	a4,2
ffffffc050402e54:	cff8                	sw	a4,92(a5)
ffffffc050402e56:	00070717          	auipc	a4,0x70
ffffffc050402e5a:	03a70713          	addi	a4,a4,58 # ffffffc050472e90 <current_running>
ffffffc050402e5e:	fc442783          	lw	a5,-60(s0)
ffffffc050402e62:	078e                	slli	a5,a5,0x3
ffffffc050402e64:	97ba                	add	a5,a5,a4
ffffffc050402e66:	639c                	ld	a5,0(a5)
ffffffc050402e68:	0887a683          	lw	a3,136(a5)
ffffffc050402e6c:	00070717          	auipc	a4,0x70
ffffffc050402e70:	02470713          	addi	a4,a4,36 # ffffffc050472e90 <current_running>
ffffffc050402e74:	fc442783          	lw	a5,-60(s0)
ffffffc050402e78:	078e                	slli	a5,a5,0x3
ffffffc050402e7a:	97ba                	add	a5,a5,a4
ffffffc050402e7c:	639c                	ld	a5,0(a5)
ffffffc050402e7e:	08c7a783          	lw	a5,140(a5)
ffffffc050402e82:	85be                	mv	a1,a5
ffffffc050402e84:	8536                	mv	a0,a3
ffffffc050402e86:	d07fe0ef          	jal	ra,ffffffc050401b8c <vt100_move_cursor>
ffffffc050402e8a:	00070717          	auipc	a4,0x70
ffffffc050402e8e:	00670713          	addi	a4,a4,6 # ffffffc050472e90 <current_running>
ffffffc050402e92:	fc442783          	lw	a5,-60(s0)
ffffffc050402e96:	078e                	slli	a5,a5,0x3
ffffffc050402e98:	97ba                	add	a5,a5,a4
ffffffc050402e9a:	639c                	ld	a5,0(a5)
ffffffc050402e9c:	0887a703          	lw	a4,136(a5)
ffffffc050402ea0:	00070697          	auipc	a3,0x70
ffffffc050402ea4:	fc868693          	addi	a3,a3,-56 # ffffffc050472e68 <screen_cursor_x>
ffffffc050402ea8:	fc442783          	lw	a5,-60(s0)
ffffffc050402eac:	078a                	slli	a5,a5,0x2
ffffffc050402eae:	97b6                	add	a5,a5,a3
ffffffc050402eb0:	c398                	sw	a4,0(a5)
ffffffc050402eb2:	00070717          	auipc	a4,0x70
ffffffc050402eb6:	fde70713          	addi	a4,a4,-34 # ffffffc050472e90 <current_running>
ffffffc050402eba:	fc442783          	lw	a5,-60(s0)
ffffffc050402ebe:	078e                	slli	a5,a5,0x3
ffffffc050402ec0:	97ba                	add	a5,a5,a4
ffffffc050402ec2:	639c                	ld	a5,0(a5)
ffffffc050402ec4:	08c7a703          	lw	a4,140(a5)
ffffffc050402ec8:	00070697          	auipc	a3,0x70
ffffffc050402ecc:	fa868693          	addi	a3,a3,-88 # ffffffc050472e70 <screen_cursor_y>
ffffffc050402ed0:	fc442783          	lw	a5,-60(s0)
ffffffc050402ed4:	078a                	slli	a5,a5,0x2
ffffffc050402ed6:	97b6                	add	a5,a5,a3
ffffffc050402ed8:	c398                	sw	a4,0(a5)
ffffffc050402eda:	aa8ff0ef          	jal	ra,ffffffc050402182 <screen_reflush>
ffffffc050402ede:	fb043783          	ld	a5,-80(s0)
ffffffc050402ee2:	6bd8                	ld	a4,144(a5)
ffffffc050402ee4:	00070697          	auipc	a3,0x70
ffffffc050402ee8:	fac68693          	addi	a3,a3,-84 # ffffffc050472e90 <current_running>
ffffffc050402eec:	fc442783          	lw	a5,-60(s0)
ffffffc050402ef0:	078e                	slli	a5,a5,0x3
ffffffc050402ef2:	97b6                	add	a5,a5,a3
ffffffc050402ef4:	639c                	ld	a5,0(a5)
ffffffc050402ef6:	6bdc                	ld	a5,144(a5)
ffffffc050402ef8:	04f70863          	beq	a4,a5,ffffffc050402f48 <do_scheduler+0x35a>
ffffffc050402efc:	00070717          	auipc	a4,0x70
ffffffc050402f00:	f9470713          	addi	a4,a4,-108 # ffffffc050472e90 <current_running>
ffffffc050402f04:	fc442783          	lw	a5,-60(s0)
ffffffc050402f08:	078e                	slli	a5,a5,0x3
ffffffc050402f0a:	97ba                	add	a5,a5,a4
ffffffc050402f0c:	639c                	ld	a5,0(a5)
ffffffc050402f0e:	4bbc                	lw	a5,80(a5)
ffffffc050402f10:	0007849b          	sext.w	s1,a5
ffffffc050402f14:	00070717          	auipc	a4,0x70
ffffffc050402f18:	f7c70713          	addi	a4,a4,-132 # ffffffc050472e90 <current_running>
ffffffc050402f1c:	fc442783          	lw	a5,-60(s0)
ffffffc050402f20:	078e                	slli	a5,a5,0x3
ffffffc050402f22:	97ba                	add	a5,a5,a4
ffffffc050402f24:	639c                	ld	a5,0(a5)
ffffffc050402f26:	6bdc                	ld	a5,144(a5)
ffffffc050402f28:	853e                	mv	a0,a5
ffffffc050402f2a:	907ff0ef          	jal	ra,ffffffc050402830 <kva2pa>
ffffffc050402f2e:	87aa                	mv	a5,a0
ffffffc050402f30:	00c7d713          	srli	a4,a5,0xc
ffffffc050402f34:	57fd                	li	a5,-1
ffffffc050402f36:	83d1                	srli	a5,a5,0x14
ffffffc050402f38:	8ff9                	and	a5,a5,a4
ffffffc050402f3a:	863e                	mv	a2,a5
ffffffc050402f3c:	85a6                	mv	a1,s1
ffffffc050402f3e:	4521                	li	a0,8
ffffffc050402f40:	8abff0ef          	jal	ra,ffffffc0504027ea <set_satp>
ffffffc050402f44:	895ff0ef          	jal	ra,ffffffc0504027d8 <local_flush_tlb_all>
ffffffc050402f48:	00070717          	auipc	a4,0x70
ffffffc050402f4c:	f4870713          	addi	a4,a4,-184 # ffffffc050472e90 <current_running>
ffffffc050402f50:	fc442783          	lw	a5,-60(s0)
ffffffc050402f54:	078e                	slli	a5,a5,0x3
ffffffc050402f56:	97ba                	add	a5,a5,a4
ffffffc050402f58:	639c                	ld	a5,0(a5)
ffffffc050402f5a:	85be                	mv	a1,a5
ffffffc050402f5c:	fb043503          	ld	a0,-80(s0)
ffffffc050402f60:	968fd0ef          	jal	ra,ffffffc0504000c8 <switch_to>
ffffffc050402f64:	a011                	j	ffffffc050402f68 <do_scheduler+0x37a>
ffffffc050402f66:	0001                	nop
ffffffc050402f68:	60a6                	ld	ra,72(sp)
ffffffc050402f6a:	6406                	ld	s0,64(sp)
ffffffc050402f6c:	74e2                	ld	s1,56(sp)
ffffffc050402f6e:	6161                	addi	sp,sp,80
ffffffc050402f70:	8082                	ret

ffffffc050402f72 <do_sleep>:
ffffffc050402f72:	7139                	addi	sp,sp,-64
ffffffc050402f74:	fc06                	sd	ra,56(sp)
ffffffc050402f76:	f822                	sd	s0,48(sp)
ffffffc050402f78:	f426                	sd	s1,40(sp)
ffffffc050402f7a:	0080                	addi	s0,sp,64
ffffffc050402f7c:	87aa                	mv	a5,a0
ffffffc050402f7e:	fcf42623          	sw	a5,-52(s0)
ffffffc050402f82:	bbefd0ef          	jal	ra,ffffffc050400340 <get_current_cpu_id>
ffffffc050402f86:	87aa                	mv	a5,a0
ffffffc050402f88:	fcf42e23          	sw	a5,-36(s0)
ffffffc050402f8c:	00070717          	auipc	a4,0x70
ffffffc050402f90:	f0470713          	addi	a4,a4,-252 # ffffffc050472e90 <current_running>
ffffffc050402f94:	fdc42783          	lw	a5,-36(s0)
ffffffc050402f98:	078e                	slli	a5,a5,0x3
ffffffc050402f9a:	97ba                	add	a5,a5,a4
ffffffc050402f9c:	639c                	ld	a5,0(a5)
ffffffc050402f9e:	4705                	li	a4,1
ffffffc050402fa0:	cff8                	sw	a4,92(a5)
ffffffc050402fa2:	fcc46483          	lwu	s1,-52(s0)
ffffffc050402fa6:	444010ef          	jal	ra,ffffffc0504043ea <get_timer>
ffffffc050402faa:	86aa                	mv	a3,a0
ffffffc050402fac:	00070717          	auipc	a4,0x70
ffffffc050402fb0:	ee470713          	addi	a4,a4,-284 # ffffffc050472e90 <current_running>
ffffffc050402fb4:	fdc42783          	lw	a5,-36(s0)
ffffffc050402fb8:	078e                	slli	a5,a5,0x3
ffffffc050402fba:	97ba                	add	a5,a5,a4
ffffffc050402fbc:	639c                	ld	a5,0(a5)
ffffffc050402fbe:	00d48733          	add	a4,s1,a3
ffffffc050402fc2:	f7b8                	sd	a4,104(a5)
ffffffc050402fc4:	00070717          	auipc	a4,0x70
ffffffc050402fc8:	ecc70713          	addi	a4,a4,-308 # ffffffc050472e90 <current_running>
ffffffc050402fcc:	fdc42783          	lw	a5,-36(s0)
ffffffc050402fd0:	078e                	slli	a5,a5,0x3
ffffffc050402fd2:	97ba                	add	a5,a5,a4
ffffffc050402fd4:	639c                	ld	a5,0(a5)
ffffffc050402fd6:	00070717          	auipc	a4,0x70
ffffffc050402fda:	eca70713          	addi	a4,a4,-310 # ffffffc050472ea0 <sleep_queue>
ffffffc050402fde:	e7b8                	sd	a4,72(a5)
ffffffc050402fe0:	00070717          	auipc	a4,0x70
ffffffc050402fe4:	eb070713          	addi	a4,a4,-336 # ffffffc050472e90 <current_running>
ffffffc050402fe8:	fdc42783          	lw	a5,-36(s0)
ffffffc050402fec:	078e                	slli	a5,a5,0x3
ffffffc050402fee:	97ba                	add	a5,a5,a4
ffffffc050402ff0:	639c                	ld	a5,0(a5)
ffffffc050402ff2:	07e1                	addi	a5,a5,24
ffffffc050402ff4:	00070617          	auipc	a2,0x70
ffffffc050402ff8:	e8460613          	addi	a2,a2,-380 # ffffffc050472e78 <ready_queue>
ffffffc050402ffc:	00070597          	auipc	a1,0x70
ffffffc050403000:	ea458593          	addi	a1,a1,-348 # ffffffc050472ea0 <sleep_queue>
ffffffc050403004:	853e                	mv	a0,a5
ffffffc050403006:	014000ef          	jal	ra,ffffffc05040301a <move_node>
ffffffc05040300a:	be5ff0ef          	jal	ra,ffffffc050402bee <do_scheduler>
ffffffc05040300e:	0001                	nop
ffffffc050403010:	70e2                	ld	ra,56(sp)
ffffffc050403012:	7442                	ld	s0,48(sp)
ffffffc050403014:	74a2                	ld	s1,40(sp)
ffffffc050403016:	6121                	addi	sp,sp,64
ffffffc050403018:	8082                	ret

ffffffc05040301a <move_node>:
ffffffc05040301a:	715d                	addi	sp,sp,-80
ffffffc05040301c:	e4a2                	sd	s0,72(sp)
ffffffc05040301e:	0880                	addi	s0,sp,80
ffffffc050403020:	fca43423          	sd	a0,-56(s0)
ffffffc050403024:	fcb43023          	sd	a1,-64(s0)
ffffffc050403028:	fac43c23          	sd	a2,-72(s0)
ffffffc05040302c:	fc843783          	ld	a5,-56(s0)
ffffffc050403030:	6b9c                	ld	a5,16(a5)
ffffffc050403032:	fef43023          	sd	a5,-32(s0)
ffffffc050403036:	fc843783          	ld	a5,-56(s0)
ffffffc05040303a:	679c                	ld	a5,8(a5)
ffffffc05040303c:	fcf43c23          	sd	a5,-40(s0)
ffffffc050403040:	fe043783          	ld	a5,-32(s0)
ffffffc050403044:	c799                	beqz	a5,ffffffc050403052 <move_node+0x38>
ffffffc050403046:	fe043783          	ld	a5,-32(s0)
ffffffc05040304a:	fd843703          	ld	a4,-40(s0)
ffffffc05040304e:	e798                	sd	a4,8(a5)
ffffffc050403050:	a031                	j	ffffffc05040305c <move_node+0x42>
ffffffc050403052:	fb843783          	ld	a5,-72(s0)
ffffffc050403056:	fd843703          	ld	a4,-40(s0)
ffffffc05040305a:	e798                	sd	a4,8(a5)
ffffffc05040305c:	fd843783          	ld	a5,-40(s0)
ffffffc050403060:	c799                	beqz	a5,ffffffc05040306e <move_node+0x54>
ffffffc050403062:	fd843783          	ld	a5,-40(s0)
ffffffc050403066:	fe043703          	ld	a4,-32(s0)
ffffffc05040306a:	eb98                	sd	a4,16(a5)
ffffffc05040306c:	a031                	j	ffffffc050403078 <move_node+0x5e>
ffffffc05040306e:	fb843783          	ld	a5,-72(s0)
ffffffc050403072:	fe043703          	ld	a4,-32(s0)
ffffffc050403076:	eb98                	sd	a4,16(a5)
ffffffc050403078:	fb843783          	ld	a5,-72(s0)
ffffffc05040307c:	439c                	lw	a5,0(a5)
ffffffc05040307e:	37fd                	addiw	a5,a5,-1
ffffffc050403080:	0007871b          	sext.w	a4,a5
ffffffc050403084:	fb843783          	ld	a5,-72(s0)
ffffffc050403088:	c398                	sw	a4,0(a5)
ffffffc05040308a:	fc043783          	ld	a5,-64(s0)
ffffffc05040308e:	439c                	lw	a5,0(a5)
ffffffc050403090:	e791                	bnez	a5,ffffffc05040309c <move_node+0x82>
ffffffc050403092:	fc043783          	ld	a5,-64(s0)
ffffffc050403096:	fef43423          	sd	a5,-24(s0)
ffffffc05040309a:	a031                	j	ffffffc0504030a6 <move_node+0x8c>
ffffffc05040309c:	fc043783          	ld	a5,-64(s0)
ffffffc0504030a0:	6b9c                	ld	a5,16(a5)
ffffffc0504030a2:	fef43423          	sd	a5,-24(s0)
ffffffc0504030a6:	fe843783          	ld	a5,-24(s0)
ffffffc0504030aa:	fc843703          	ld	a4,-56(s0)
ffffffc0504030ae:	e798                	sd	a4,8(a5)
ffffffc0504030b0:	fc843783          	ld	a5,-56(s0)
ffffffc0504030b4:	fe843703          	ld	a4,-24(s0)
ffffffc0504030b8:	eb98                	sd	a4,16(a5)
ffffffc0504030ba:	fc843783          	ld	a5,-56(s0)
ffffffc0504030be:	0007b423          	sd	zero,8(a5)
ffffffc0504030c2:	fc043783          	ld	a5,-64(s0)
ffffffc0504030c6:	fc843703          	ld	a4,-56(s0)
ffffffc0504030ca:	eb98                	sd	a4,16(a5)
ffffffc0504030cc:	fc043783          	ld	a5,-64(s0)
ffffffc0504030d0:	439c                	lw	a5,0(a5)
ffffffc0504030d2:	2785                	addiw	a5,a5,1
ffffffc0504030d4:	0007871b          	sext.w	a4,a5
ffffffc0504030d8:	fc043783          	ld	a5,-64(s0)
ffffffc0504030dc:	c398                	sw	a4,0(a5)
ffffffc0504030de:	0001                	nop
ffffffc0504030e0:	6426                	ld	s0,72(sp)
ffffffc0504030e2:	6161                	addi	sp,sp,80
ffffffc0504030e4:	8082                	ret

ffffffc0504030e6 <alloc_new_pcb>:
ffffffc0504030e6:	1101                	addi	sp,sp,-32
ffffffc0504030e8:	ec22                	sd	s0,24(sp)
ffffffc0504030ea:	1000                	addi	s0,sp,32
ffffffc0504030ec:	fe042423          	sw	zero,-24(s0)
ffffffc0504030f0:	fe042623          	sw	zero,-20(s0)
ffffffc0504030f4:	a03d                	j	ffffffc050403122 <alloc_new_pcb+0x3c>
ffffffc0504030f6:	00070717          	auipc	a4,0x70
ffffffc0504030fa:	dc270713          	addi	a4,a4,-574 # ffffffc050472eb8 <pcb>
ffffffc0504030fe:	fec42683          	lw	a3,-20(s0)
ffffffc050403102:	09800793          	li	a5,152
ffffffc050403106:	02f687b3          	mul	a5,a3,a5
ffffffc05040310a:	97ba                	add	a5,a5,a4
ffffffc05040310c:	4ffc                	lw	a5,92(a5)
ffffffc05040310e:	e789                	bnez	a5,ffffffc050403118 <alloc_new_pcb+0x32>
ffffffc050403110:	4785                	li	a5,1
ffffffc050403112:	fef42423          	sw	a5,-24(s0)
ffffffc050403116:	a829                	j	ffffffc050403130 <alloc_new_pcb+0x4a>
ffffffc050403118:	fec42783          	lw	a5,-20(s0)
ffffffc05040311c:	2785                	addiw	a5,a5,1
ffffffc05040311e:	fef42623          	sw	a5,-20(s0)
ffffffc050403122:	fec42783          	lw	a5,-20(s0)
ffffffc050403126:	0007871b          	sext.w	a4,a5
ffffffc05040312a:	47fd                	li	a5,31
ffffffc05040312c:	fce7d5e3          	bge	a5,a4,ffffffc0504030f6 <alloc_new_pcb+0x10>
ffffffc050403130:	fe842783          	lw	a5,-24(s0)
ffffffc050403134:	0007871b          	sext.w	a4,a5
ffffffc050403138:	4785                	li	a5,1
ffffffc05040313a:	02f71463          	bne	a4,a5,ffffffc050403162 <alloc_new_pcb+0x7c>
ffffffc05040313e:	81818793          	addi	a5,gp,-2024 # ffffffc05045f8d0 <process_id>
ffffffc050403142:	4398                	lw	a4,0(a5)
ffffffc050403144:	00070697          	auipc	a3,0x70
ffffffc050403148:	d7468693          	addi	a3,a3,-652 # ffffffc050472eb8 <pcb>
ffffffc05040314c:	fec42603          	lw	a2,-20(s0)
ffffffc050403150:	09800793          	li	a5,152
ffffffc050403154:	02f607b3          	mul	a5,a2,a5
ffffffc050403158:	97b6                	add	a5,a5,a3
ffffffc05040315a:	cbb8                	sw	a4,80(a5)
ffffffc05040315c:	fec42783          	lw	a5,-20(s0)
ffffffc050403160:	a011                	j	ffffffc050403164 <alloc_new_pcb+0x7e>
ffffffc050403162:	57fd                	li	a5,-1
ffffffc050403164:	853e                	mv	a0,a5
ffffffc050403166:	6462                	ld	s0,24(sp)
ffffffc050403168:	6105                	addi	sp,sp,32
ffffffc05040316a:	8082                	ret

ffffffc05040316c <set_pcb_ready>:
ffffffc05040316c:	7179                	addi	sp,sp,-48
ffffffc05040316e:	f406                	sd	ra,40(sp)
ffffffc050403170:	f022                	sd	s0,32(sp)
ffffffc050403172:	1800                	addi	s0,sp,48
ffffffc050403174:	87aa                	mv	a5,a0
ffffffc050403176:	fcf42e23          	sw	a5,-36(s0)
ffffffc05040317a:	00070717          	auipc	a4,0x70
ffffffc05040317e:	d3e70713          	addi	a4,a4,-706 # ffffffc050472eb8 <pcb>
ffffffc050403182:	fdc42683          	lw	a3,-36(s0)
ffffffc050403186:	09800793          	li	a5,152
ffffffc05040318a:	02f687b3          	mul	a5,a3,a5
ffffffc05040318e:	97ba                	add	a5,a5,a4
ffffffc050403190:	470d                	li	a4,3
ffffffc050403192:	cff8                	sw	a4,92(a5)
ffffffc050403194:	00070717          	auipc	a4,0x70
ffffffc050403198:	d2470713          	addi	a4,a4,-732 # ffffffc050472eb8 <pcb>
ffffffc05040319c:	fdc42683          	lw	a3,-36(s0)
ffffffc0504031a0:	09800793          	li	a5,152
ffffffc0504031a4:	02f687b3          	mul	a5,a3,a5
ffffffc0504031a8:	97ba                	add	a5,a5,a4
ffffffc0504031aa:	67b8                	ld	a4,72(a5)
ffffffc0504031ac:	00071797          	auipc	a5,0x71
ffffffc0504031b0:	02478793          	addi	a5,a5,36 # ffffffc0504741d0 <exit_queue>
ffffffc0504031b4:	04f71c63          	bne	a4,a5,ffffffc05040320c <set_pcb_ready+0xa0>
ffffffc0504031b8:	fdc42703          	lw	a4,-36(s0)
ffffffc0504031bc:	09800793          	li	a5,152
ffffffc0504031c0:	02f707b3          	mul	a5,a4,a5
ffffffc0504031c4:	01078713          	addi	a4,a5,16
ffffffc0504031c8:	00070797          	auipc	a5,0x70
ffffffc0504031cc:	cf078793          	addi	a5,a5,-784 # ffffffc050472eb8 <pcb>
ffffffc0504031d0:	97ba                	add	a5,a5,a4
ffffffc0504031d2:	07a1                	addi	a5,a5,8
ffffffc0504031d4:	00071617          	auipc	a2,0x71
ffffffc0504031d8:	ffc60613          	addi	a2,a2,-4 # ffffffc0504741d0 <exit_queue>
ffffffc0504031dc:	00070597          	auipc	a1,0x70
ffffffc0504031e0:	c9c58593          	addi	a1,a1,-868 # ffffffc050472e78 <ready_queue>
ffffffc0504031e4:	853e                	mv	a0,a5
ffffffc0504031e6:	e35ff0ef          	jal	ra,ffffffc05040301a <move_node>
ffffffc0504031ea:	00070717          	auipc	a4,0x70
ffffffc0504031ee:	cce70713          	addi	a4,a4,-818 # ffffffc050472eb8 <pcb>
ffffffc0504031f2:	fdc42683          	lw	a3,-36(s0)
ffffffc0504031f6:	09800793          	li	a5,152
ffffffc0504031fa:	02f687b3          	mul	a5,a3,a5
ffffffc0504031fe:	97ba                	add	a5,a5,a4
ffffffc050403200:	00070717          	auipc	a4,0x70
ffffffc050403204:	c7870713          	addi	a4,a4,-904 # ffffffc050472e78 <ready_queue>
ffffffc050403208:	e7b8                	sd	a4,72(a5)
ffffffc05040320a:	a055                	j	ffffffc0504032ae <set_pcb_ready+0x142>
ffffffc05040320c:	00070717          	auipc	a4,0x70
ffffffc050403210:	cac70713          	addi	a4,a4,-852 # ffffffc050472eb8 <pcb>
ffffffc050403214:	fdc42683          	lw	a3,-36(s0)
ffffffc050403218:	09800793          	li	a5,152
ffffffc05040321c:	02f687b3          	mul	a5,a3,a5
ffffffc050403220:	97ba                	add	a5,a5,a4
ffffffc050403222:	00070717          	auipc	a4,0x70
ffffffc050403226:	c5670713          	addi	a4,a4,-938 # ffffffc050472e78 <ready_queue>
ffffffc05040322a:	e7b8                	sd	a4,72(a5)
ffffffc05040322c:	00070797          	auipc	a5,0x70
ffffffc050403230:	c4c78793          	addi	a5,a5,-948 # ffffffc050472e78 <ready_queue>
ffffffc050403234:	679c                	ld	a5,8(a5)
ffffffc050403236:	fef43423          	sd	a5,-24(s0)
ffffffc05040323a:	fdc42703          	lw	a4,-36(s0)
ffffffc05040323e:	09800793          	li	a5,152
ffffffc050403242:	02f707b3          	mul	a5,a4,a5
ffffffc050403246:	01078713          	addi	a4,a5,16
ffffffc05040324a:	00070797          	auipc	a5,0x70
ffffffc05040324e:	c6e78793          	addi	a5,a5,-914 # ffffffc050472eb8 <pcb>
ffffffc050403252:	97ba                	add	a5,a5,a4
ffffffc050403254:	07a1                	addi	a5,a5,8
ffffffc050403256:	fef43023          	sd	a5,-32(s0)
ffffffc05040325a:	fe043783          	ld	a5,-32(s0)
ffffffc05040325e:	fdc42703          	lw	a4,-36(s0)
ffffffc050403262:	c398                	sw	a4,0(a5)
ffffffc050403264:	fe043783          	ld	a5,-32(s0)
ffffffc050403268:	fe843703          	ld	a4,-24(s0)
ffffffc05040326c:	e798                	sd	a4,8(a5)
ffffffc05040326e:	fe043783          	ld	a5,-32(s0)
ffffffc050403272:	00070717          	auipc	a4,0x70
ffffffc050403276:	c0670713          	addi	a4,a4,-1018 # ffffffc050472e78 <ready_queue>
ffffffc05040327a:	eb98                	sd	a4,16(a5)
ffffffc05040327c:	fe843783          	ld	a5,-24(s0)
ffffffc050403280:	fe043703          	ld	a4,-32(s0)
ffffffc050403284:	eb98                	sd	a4,16(a5)
ffffffc050403286:	00070797          	auipc	a5,0x70
ffffffc05040328a:	bf278793          	addi	a5,a5,-1038 # ffffffc050472e78 <ready_queue>
ffffffc05040328e:	fe043703          	ld	a4,-32(s0)
ffffffc050403292:	e798                	sd	a4,8(a5)
ffffffc050403294:	00070797          	auipc	a5,0x70
ffffffc050403298:	be478793          	addi	a5,a5,-1052 # ffffffc050472e78 <ready_queue>
ffffffc05040329c:	439c                	lw	a5,0(a5)
ffffffc05040329e:	2785                	addiw	a5,a5,1
ffffffc0504032a0:	0007871b          	sext.w	a4,a5
ffffffc0504032a4:	00070797          	auipc	a5,0x70
ffffffc0504032a8:	bd478793          	addi	a5,a5,-1068 # ffffffc050472e78 <ready_queue>
ffffffc0504032ac:	c398                	sw	a4,0(a5)
ffffffc0504032ae:	70a2                	ld	ra,40(sp)
ffffffc0504032b0:	7402                	ld	s0,32(sp)
ffffffc0504032b2:	6145                	addi	sp,sp,48
ffffffc0504032b4:	8082                	ret

ffffffc0504032b6 <do_fork>:
ffffffc0504032b6:	1141                	addi	sp,sp,-16
ffffffc0504032b8:	e422                	sd	s0,8(sp)
ffffffc0504032ba:	0800                	addi	s0,sp,16
ffffffc0504032bc:	81818793          	addi	a5,gp,-2024 # ffffffc05045f8d0 <process_id>
ffffffc0504032c0:	439c                	lw	a5,0(a5)
ffffffc0504032c2:	0017871b          	addiw	a4,a5,1
ffffffc0504032c6:	0007069b          	sext.w	a3,a4
ffffffc0504032ca:	81818713          	addi	a4,gp,-2024 # ffffffc05045f8d0 <process_id>
ffffffc0504032ce:	c314                	sw	a3,0(a4)
ffffffc0504032d0:	853e                	mv	a0,a5
ffffffc0504032d2:	6422                	ld	s0,8(sp)
ffffffc0504032d4:	0141                	addi	sp,sp,16
ffffffc0504032d6:	8082                	ret

ffffffc0504032d8 <do_prior>:
ffffffc0504032d8:	7179                	addi	sp,sp,-48
ffffffc0504032da:	f406                	sd	ra,40(sp)
ffffffc0504032dc:	f022                	sd	s0,32(sp)
ffffffc0504032de:	1800                	addi	s0,sp,48
ffffffc0504032e0:	87aa                	mv	a5,a0
ffffffc0504032e2:	fcf42e23          	sw	a5,-36(s0)
ffffffc0504032e6:	85afd0ef          	jal	ra,ffffffc050400340 <get_current_cpu_id>
ffffffc0504032ea:	87aa                	mv	a5,a0
ffffffc0504032ec:	fef42623          	sw	a5,-20(s0)
ffffffc0504032f0:	fdc42783          	lw	a5,-36(s0)
ffffffc0504032f4:	2785                	addiw	a5,a5,1
ffffffc0504032f6:	0007871b          	sext.w	a4,a5
ffffffc0504032fa:	000257b7          	lui	a5,0x25
ffffffc0504032fe:	9f07879b          	addiw	a5,a5,-1552
ffffffc050403302:	02f707bb          	mulw	a5,a4,a5
ffffffc050403306:	2781                	sext.w	a5,a5
ffffffc050403308:	863e                	mv	a2,a5
ffffffc05040330a:	0005c797          	auipc	a5,0x5c
ffffffc05040330e:	5be78793          	addi	a5,a5,1470 # ffffffc05045f8c8 <timer>
ffffffc050403312:	6398                	ld	a4,0(a5)
ffffffc050403314:	00070697          	auipc	a3,0x70
ffffffc050403318:	b7c68693          	addi	a3,a3,-1156 # ffffffc050472e90 <current_running>
ffffffc05040331c:	fec42783          	lw	a5,-20(s0)
ffffffc050403320:	078e                	slli	a5,a5,0x3
ffffffc050403322:	97b6                	add	a5,a5,a3
ffffffc050403324:	639c                	ld	a5,0(a5)
ffffffc050403326:	9732                	add	a4,a4,a2
ffffffc050403328:	fbb8                	sd	a4,112(a5)
ffffffc05040332a:	0001                	nop
ffffffc05040332c:	70a2                	ld	ra,40(sp)
ffffffc05040332e:	7402                	ld	s0,32(sp)
ffffffc050403330:	6145                	addi	sp,sp,48
ffffffc050403332:	8082                	ret

ffffffc050403334 <do_spawn>:
ffffffc050403334:	7179                	addi	sp,sp,-48
ffffffc050403336:	f422                	sd	s0,40(sp)
ffffffc050403338:	1800                	addi	s0,sp,48
ffffffc05040333a:	fea43423          	sd	a0,-24(s0)
ffffffc05040333e:	feb43023          	sd	a1,-32(s0)
ffffffc050403342:	87b2                	mv	a5,a2
ffffffc050403344:	fcf42e23          	sw	a5,-36(s0)
ffffffc050403348:	81818793          	addi	a5,gp,-2024 # ffffffc05045f8d0 <process_id>
ffffffc05040334c:	439c                	lw	a5,0(a5)
ffffffc05040334e:	0017871b          	addiw	a4,a5,1
ffffffc050403352:	0007069b          	sext.w	a3,a4
ffffffc050403356:	81818713          	addi	a4,gp,-2024 # ffffffc05045f8d0 <process_id>
ffffffc05040335a:	c314                	sw	a3,0(a4)
ffffffc05040335c:	853e                	mv	a0,a5
ffffffc05040335e:	7422                	ld	s0,40(sp)
ffffffc050403360:	6145                	addi	sp,sp,48
ffffffc050403362:	8082                	ret

ffffffc050403364 <release_wait_list>:
ffffffc050403364:	7139                	addi	sp,sp,-64
ffffffc050403366:	fc22                	sd	s0,56(sp)
ffffffc050403368:	0080                	addi	s0,sp,64
ffffffc05040336a:	fca43423          	sd	a0,-56(s0)
ffffffc05040336e:	fc843783          	ld	a5,-56(s0)
ffffffc050403372:	679c                	ld	a5,8(a5)
ffffffc050403374:	fef43023          	sd	a5,-32(s0)
ffffffc050403378:	fc843783          	ld	a5,-56(s0)
ffffffc05040337c:	6b9c                	ld	a5,16(a5)
ffffffc05040337e:	fcf43c23          	sd	a5,-40(s0)
ffffffc050403382:	fe043783          	ld	a5,-32(s0)
ffffffc050403386:	fef43423          	sd	a5,-24(s0)
ffffffc05040338a:	a0a9                	j	ffffffc0504033d4 <release_wait_list+0x70>
ffffffc05040338c:	fe843783          	ld	a5,-24(s0)
ffffffc050403390:	4394                	lw	a3,0(a5)
ffffffc050403392:	00070717          	auipc	a4,0x70
ffffffc050403396:	b2670713          	addi	a4,a4,-1242 # ffffffc050472eb8 <pcb>
ffffffc05040339a:	09800793          	li	a5,152
ffffffc05040339e:	02f687b3          	mul	a5,a3,a5
ffffffc0504033a2:	97ba                	add	a5,a5,a4
ffffffc0504033a4:	00070717          	auipc	a4,0x70
ffffffc0504033a8:	ad470713          	addi	a4,a4,-1324 # ffffffc050472e78 <ready_queue>
ffffffc0504033ac:	e7b8                	sd	a4,72(a5)
ffffffc0504033ae:	fe843783          	ld	a5,-24(s0)
ffffffc0504033b2:	4394                	lw	a3,0(a5)
ffffffc0504033b4:	00070717          	auipc	a4,0x70
ffffffc0504033b8:	b0470713          	addi	a4,a4,-1276 # ffffffc050472eb8 <pcb>
ffffffc0504033bc:	09800793          	li	a5,152
ffffffc0504033c0:	02f687b3          	mul	a5,a3,a5
ffffffc0504033c4:	97ba                	add	a5,a5,a4
ffffffc0504033c6:	470d                	li	a4,3
ffffffc0504033c8:	cff8                	sw	a4,92(a5)
ffffffc0504033ca:	fe843783          	ld	a5,-24(s0)
ffffffc0504033ce:	679c                	ld	a5,8(a5)
ffffffc0504033d0:	fef43423          	sd	a5,-24(s0)
ffffffc0504033d4:	fe843783          	ld	a5,-24(s0)
ffffffc0504033d8:	fbd5                	bnez	a5,ffffffc05040338c <release_wait_list+0x28>
ffffffc0504033da:	00070797          	auipc	a5,0x70
ffffffc0504033de:	a9e78793          	addi	a5,a5,-1378 # ffffffc050472e78 <ready_queue>
ffffffc0504033e2:	6b9c                	ld	a5,16(a5)
ffffffc0504033e4:	fcf43823          	sd	a5,-48(s0)
ffffffc0504033e8:	fd043783          	ld	a5,-48(s0)
ffffffc0504033ec:	fe043703          	ld	a4,-32(s0)
ffffffc0504033f0:	e798                	sd	a4,8(a5)
ffffffc0504033f2:	fe043783          	ld	a5,-32(s0)
ffffffc0504033f6:	fd043703          	ld	a4,-48(s0)
ffffffc0504033fa:	eb98                	sd	a4,16(a5)
ffffffc0504033fc:	fd843783          	ld	a5,-40(s0)
ffffffc050403400:	00070717          	auipc	a4,0x70
ffffffc050403404:	a7870713          	addi	a4,a4,-1416 # ffffffc050472e78 <ready_queue>
ffffffc050403408:	e798                	sd	a4,8(a5)
ffffffc05040340a:	00070797          	auipc	a5,0x70
ffffffc05040340e:	a6e78793          	addi	a5,a5,-1426 # ffffffc050472e78 <ready_queue>
ffffffc050403412:	fd843703          	ld	a4,-40(s0)
ffffffc050403416:	eb98                	sd	a4,16(a5)
ffffffc050403418:	00070797          	auipc	a5,0x70
ffffffc05040341c:	a6078793          	addi	a5,a5,-1440 # ffffffc050472e78 <ready_queue>
ffffffc050403420:	4398                	lw	a4,0(a5)
ffffffc050403422:	fc843783          	ld	a5,-56(s0)
ffffffc050403426:	439c                	lw	a5,0(a5)
ffffffc050403428:	9fb9                	addw	a5,a5,a4
ffffffc05040342a:	0007871b          	sext.w	a4,a5
ffffffc05040342e:	00070797          	auipc	a5,0x70
ffffffc050403432:	a4a78793          	addi	a5,a5,-1462 # ffffffc050472e78 <ready_queue>
ffffffc050403436:	c398                	sw	a4,0(a5)
ffffffc050403438:	fc843783          	ld	a5,-56(s0)
ffffffc05040343c:	0007b823          	sd	zero,16(a5)
ffffffc050403440:	fc843783          	ld	a5,-56(s0)
ffffffc050403444:	0007b423          	sd	zero,8(a5)
ffffffc050403448:	fc843783          	ld	a5,-56(s0)
ffffffc05040344c:	0007a023          	sw	zero,0(a5)
ffffffc050403450:	0001                	nop
ffffffc050403452:	7462                	ld	s0,56(sp)
ffffffc050403454:	6121                	addi	sp,sp,64
ffffffc050403456:	8082                	ret

ffffffc050403458 <lock_exit>:
ffffffc050403458:	7179                	addi	sp,sp,-48
ffffffc05040345a:	f406                	sd	ra,40(sp)
ffffffc05040345c:	f022                	sd	s0,32(sp)
ffffffc05040345e:	1800                	addi	s0,sp,48
ffffffc050403460:	fca43c23          	sd	a0,-40(s0)
ffffffc050403464:	fe042623          	sw	zero,-20(s0)
ffffffc050403468:	a0a1                	j	ffffffc0504034b0 <lock_exit+0x58>
ffffffc05040346a:	0005e697          	auipc	a3,0x5e
ffffffc05040346e:	54668693          	addi	a3,a3,1350 # ffffffc0504619b0 <lock_array>
ffffffc050403472:	fec42703          	lw	a4,-20(s0)
ffffffc050403476:	87ba                	mv	a5,a4
ffffffc050403478:	078a                	slli	a5,a5,0x2
ffffffc05040347a:	97ba                	add	a5,a5,a4
ffffffc05040347c:	078e                	slli	a5,a5,0x3
ffffffc05040347e:	97b6                	add	a5,a5,a3
ffffffc050403480:	679c                	ld	a5,8(a5)
ffffffc050403482:	fd843703          	ld	a4,-40(s0)
ffffffc050403486:	02f71063          	bne	a4,a5,ffffffc0504034a6 <lock_exit+0x4e>
ffffffc05040348a:	fec42703          	lw	a4,-20(s0)
ffffffc05040348e:	87ba                	mv	a5,a4
ffffffc050403490:	078a                	slli	a5,a5,0x2
ffffffc050403492:	97ba                	add	a5,a5,a4
ffffffc050403494:	078e                	slli	a5,a5,0x3
ffffffc050403496:	0005e717          	auipc	a4,0x5e
ffffffc05040349a:	51a70713          	addi	a4,a4,1306 # ffffffc0504619b0 <lock_array>
ffffffc05040349e:	97ba                	add	a5,a5,a4
ffffffc0504034a0:	853e                	mv	a0,a5
ffffffc0504034a2:	81cff0ef          	jal	ra,ffffffc0504024be <do_mutex_lock_release>
ffffffc0504034a6:	fec42783          	lw	a5,-20(s0)
ffffffc0504034aa:	2785                	addiw	a5,a5,1
ffffffc0504034ac:	fef42623          	sw	a5,-20(s0)
ffffffc0504034b0:	fec42783          	lw	a5,-20(s0)
ffffffc0504034b4:	0007871b          	sext.w	a4,a5
ffffffc0504034b8:	479d                	li	a5,7
ffffffc0504034ba:	fae7d8e3          	bge	a5,a4,ffffffc05040346a <lock_exit+0x12>
ffffffc0504034be:	0001                	nop
ffffffc0504034c0:	0001                	nop
ffffffc0504034c2:	70a2                	ld	ra,40(sp)
ffffffc0504034c4:	7402                	ld	s0,32(sp)
ffffffc0504034c6:	6145                	addi	sp,sp,48
ffffffc0504034c8:	8082                	ret

ffffffc0504034ca <do_exit>:
ffffffc0504034ca:	7179                	addi	sp,sp,-48
ffffffc0504034cc:	f406                	sd	ra,40(sp)
ffffffc0504034ce:	f022                	sd	s0,32(sp)
ffffffc0504034d0:	1800                	addi	s0,sp,48
ffffffc0504034d2:	e6ffc0ef          	jal	ra,ffffffc050400340 <get_current_cpu_id>
ffffffc0504034d6:	87aa                	mv	a5,a0
ffffffc0504034d8:	fef42623          	sw	a5,-20(s0)
ffffffc0504034dc:	00070717          	auipc	a4,0x70
ffffffc0504034e0:	9b470713          	addi	a4,a4,-1612 # ffffffc050472e90 <current_running>
ffffffc0504034e4:	fec42783          	lw	a5,-20(s0)
ffffffc0504034e8:	078e                	slli	a5,a5,0x3
ffffffc0504034ea:	97ba                	add	a5,a5,a4
ffffffc0504034ec:	639c                	ld	a5,0(a5)
ffffffc0504034ee:	fef43023          	sd	a5,-32(s0)
ffffffc0504034f2:	fe043783          	ld	a5,-32(s0)
ffffffc0504034f6:	07e1                	addi	a5,a5,24
ffffffc0504034f8:	fcf43c23          	sd	a5,-40(s0)
ffffffc0504034fc:	0005e717          	auipc	a4,0x5e
ffffffc050403500:	4a470713          	addi	a4,a4,1188 # ffffffc0504619a0 <cpu_pcb_pointer>
ffffffc050403504:	fec42783          	lw	a5,-20(s0)
ffffffc050403508:	078e                	slli	a5,a5,0x3
ffffffc05040350a:	97ba                	add	a5,a5,a4
ffffffc05040350c:	639c                	ld	a5,0(a5)
ffffffc05040350e:	86be                	mv	a3,a5
ffffffc050403510:	00070717          	auipc	a4,0x70
ffffffc050403514:	98070713          	addi	a4,a4,-1664 # ffffffc050472e90 <current_running>
ffffffc050403518:	fec42783          	lw	a5,-20(s0)
ffffffc05040351c:	078e                	slli	a5,a5,0x3
ffffffc05040351e:	97ba                	add	a5,a5,a4
ffffffc050403520:	e394                	sd	a3,0(a5)
ffffffc050403522:	fe043783          	ld	a5,-32(s0)
ffffffc050403526:	7fb8                	ld	a4,120(a5)
ffffffc050403528:	fe043783          	ld	a5,-32(s0)
ffffffc05040352c:	e398                	sd	a4,0(a5)
ffffffc05040352e:	fe043783          	ld	a5,-32(s0)
ffffffc050403532:	63d8                	ld	a4,128(a5)
ffffffc050403534:	fe043783          	ld	a5,-32(s0)
ffffffc050403538:	e798                	sd	a4,8(a5)
ffffffc05040353a:	00070717          	auipc	a4,0x70
ffffffc05040353e:	95670713          	addi	a4,a4,-1706 # ffffffc050472e90 <current_running>
ffffffc050403542:	fec42783          	lw	a5,-20(s0)
ffffffc050403546:	078e                	slli	a5,a5,0x3
ffffffc050403548:	97ba                	add	a5,a5,a4
ffffffc05040354a:	6398                	ld	a4,0(a5)
ffffffc05040354c:	00070697          	auipc	a3,0x70
ffffffc050403550:	94468693          	addi	a3,a3,-1724 # ffffffc050472e90 <current_running>
ffffffc050403554:	fec42783          	lw	a5,-20(s0)
ffffffc050403558:	078e                	slli	a5,a5,0x3
ffffffc05040355a:	97b6                	add	a5,a5,a3
ffffffc05040355c:	639c                	ld	a5,0(a5)
ffffffc05040355e:	7f38                	ld	a4,120(a4)
ffffffc050403560:	e398                	sd	a4,0(a5)
ffffffc050403562:	fe043783          	ld	a5,-32(s0)
ffffffc050403566:	5b9c                	lw	a5,48(a5)
ffffffc050403568:	04f05163          	blez	a5,ffffffc0504035aa <do_exit+0xe0>
ffffffc05040356c:	fe043783          	ld	a5,-32(s0)
ffffffc050403570:	03078793          	addi	a5,a5,48
ffffffc050403574:	853e                	mv	a0,a5
ffffffc050403576:	defff0ef          	jal	ra,ffffffc050403364 <release_wait_list>
ffffffc05040357a:	fe043783          	ld	a5,-32(s0)
ffffffc05040357e:	0407ae23          	sw	zero,92(a5)
ffffffc050403582:	fe043783          	ld	a5,-32(s0)
ffffffc050403586:	00071717          	auipc	a4,0x71
ffffffc05040358a:	c4a70713          	addi	a4,a4,-950 # ffffffc0504741d0 <exit_queue>
ffffffc05040358e:	e7b8                	sd	a4,72(a5)
ffffffc050403590:	00070617          	auipc	a2,0x70
ffffffc050403594:	8e860613          	addi	a2,a2,-1816 # ffffffc050472e78 <ready_queue>
ffffffc050403598:	00071597          	auipc	a1,0x71
ffffffc05040359c:	c3858593          	addi	a1,a1,-968 # ffffffc0504741d0 <exit_queue>
ffffffc0504035a0:	fd843503          	ld	a0,-40(s0)
ffffffc0504035a4:	a77ff0ef          	jal	ra,ffffffc05040301a <move_node>
ffffffc0504035a8:	a0bd                	j	ffffffc050403616 <do_exit+0x14c>
ffffffc0504035aa:	fe043783          	ld	a5,-32(s0)
ffffffc0504035ae:	53bc                	lw	a5,96(a5)
ffffffc0504035b0:	873e                	mv	a4,a5
ffffffc0504035b2:	4785                	li	a5,1
ffffffc0504035b4:	02f71a63          	bne	a4,a5,ffffffc0504035e8 <do_exit+0x11e>
ffffffc0504035b8:	fe043783          	ld	a5,-32(s0)
ffffffc0504035bc:	4711                	li	a4,4
ffffffc0504035be:	cff8                	sw	a4,92(a5)
ffffffc0504035c0:	fe043783          	ld	a5,-32(s0)
ffffffc0504035c4:	00071717          	auipc	a4,0x71
ffffffc0504035c8:	bf470713          	addi	a4,a4,-1036 # ffffffc0504741b8 <zombie_queue>
ffffffc0504035cc:	e7b8                	sd	a4,72(a5)
ffffffc0504035ce:	00070617          	auipc	a2,0x70
ffffffc0504035d2:	8aa60613          	addi	a2,a2,-1878 # ffffffc050472e78 <ready_queue>
ffffffc0504035d6:	00071597          	auipc	a1,0x71
ffffffc0504035da:	be258593          	addi	a1,a1,-1054 # ffffffc0504741b8 <zombie_queue>
ffffffc0504035de:	fd843503          	ld	a0,-40(s0)
ffffffc0504035e2:	a39ff0ef          	jal	ra,ffffffc05040301a <move_node>
ffffffc0504035e6:	a805                	j	ffffffc050403616 <do_exit+0x14c>
ffffffc0504035e8:	fe043783          	ld	a5,-32(s0)
ffffffc0504035ec:	0407ae23          	sw	zero,92(a5)
ffffffc0504035f0:	fe043783          	ld	a5,-32(s0)
ffffffc0504035f4:	00071717          	auipc	a4,0x71
ffffffc0504035f8:	bdc70713          	addi	a4,a4,-1060 # ffffffc0504741d0 <exit_queue>
ffffffc0504035fc:	e7b8                	sd	a4,72(a5)
ffffffc0504035fe:	00070617          	auipc	a2,0x70
ffffffc050403602:	87a60613          	addi	a2,a2,-1926 # ffffffc050472e78 <ready_queue>
ffffffc050403606:	00071597          	auipc	a1,0x71
ffffffc05040360a:	bca58593          	addi	a1,a1,-1078 # ffffffc0504741d0 <exit_queue>
ffffffc05040360e:	fd843503          	ld	a0,-40(s0)
ffffffc050403612:	a09ff0ef          	jal	ra,ffffffc05040301a <move_node>
ffffffc050403616:	fe043783          	ld	a5,-32(s0)
ffffffc05040361a:	6bdc                	ld	a5,144(a5)
ffffffc05040361c:	853e                	mv	a0,a5
ffffffc05040361e:	396020ef          	jal	ra,ffffffc0504059b4 <dealloc_uvm>
ffffffc050403622:	67a020ef          	jal	ra,ffffffc050405c9c <switch_init_kdir>
ffffffc050403626:	fe043783          	ld	a5,-32(s0)
ffffffc05040362a:	6bdc                	ld	a5,144(a5)
ffffffc05040362c:	853e                	mv	a0,a5
ffffffc05040362e:	5be020ef          	jal	ra,ffffffc050405bec <unmap_kvm>
ffffffc050403632:	fe043503          	ld	a0,-32(s0)
ffffffc050403636:	e23ff0ef          	jal	ra,ffffffc050403458 <lock_exit>
ffffffc05040363a:	db4ff0ef          	jal	ra,ffffffc050402bee <do_scheduler>
ffffffc05040363e:	0001                	nop
ffffffc050403640:	70a2                	ld	ra,40(sp)
ffffffc050403642:	7402                	ld	s0,32(sp)
ffffffc050403644:	6145                	addi	sp,sp,48
ffffffc050403646:	8082                	ret

ffffffc050403648 <do_waitpid>:
ffffffc050403648:	7179                	addi	sp,sp,-48
ffffffc05040364a:	f406                	sd	ra,40(sp)
ffffffc05040364c:	f022                	sd	s0,32(sp)
ffffffc05040364e:	1800                	addi	s0,sp,48
ffffffc050403650:	87aa                	mv	a5,a0
ffffffc050403652:	fcf42e23          	sw	a5,-36(s0)
ffffffc050403656:	fe042623          	sw	zero,-20(s0)
ffffffc05040365a:	ce7fc0ef          	jal	ra,ffffffc050400340 <get_current_cpu_id>
ffffffc05040365e:	87aa                	mv	a5,a0
ffffffc050403660:	fef42223          	sw	a5,-28(s0)
ffffffc050403664:	fe042423          	sw	zero,-24(s0)
ffffffc050403668:	a81d                	j	ffffffc05040369e <do_waitpid+0x56>
ffffffc05040366a:	00070717          	auipc	a4,0x70
ffffffc05040366e:	84e70713          	addi	a4,a4,-1970 # ffffffc050472eb8 <pcb>
ffffffc050403672:	fe842683          	lw	a3,-24(s0)
ffffffc050403676:	09800793          	li	a5,152
ffffffc05040367a:	02f687b3          	mul	a5,a3,a5
ffffffc05040367e:	97ba                	add	a5,a5,a4
ffffffc050403680:	4bb8                	lw	a4,80(a5)
ffffffc050403682:	fdc42783          	lw	a5,-36(s0)
ffffffc050403686:	2781                	sext.w	a5,a5
ffffffc050403688:	00e79663          	bne	a5,a4,ffffffc050403694 <do_waitpid+0x4c>
ffffffc05040368c:	4785                	li	a5,1
ffffffc05040368e:	fef42623          	sw	a5,-20(s0)
ffffffc050403692:	a829                	j	ffffffc0504036ac <do_waitpid+0x64>
ffffffc050403694:	fe842783          	lw	a5,-24(s0)
ffffffc050403698:	2785                	addiw	a5,a5,1
ffffffc05040369a:	fef42423          	sw	a5,-24(s0)
ffffffc05040369e:	fe842783          	lw	a5,-24(s0)
ffffffc0504036a2:	0007871b          	sext.w	a4,a5
ffffffc0504036a6:	47fd                	li	a5,31
ffffffc0504036a8:	fce7d1e3          	bge	a5,a4,ffffffc05040366a <do_waitpid+0x22>
ffffffc0504036ac:	fec42783          	lw	a5,-20(s0)
ffffffc0504036b0:	2781                	sext.w	a5,a5
ffffffc0504036b2:	e399                	bnez	a5,ffffffc0504036b8 <do_waitpid+0x70>
ffffffc0504036b4:	57fd                	li	a5,-1
ffffffc0504036b6:	aa39                	j	ffffffc0504037d4 <do_waitpid+0x18c>
ffffffc0504036b8:	00070717          	auipc	a4,0x70
ffffffc0504036bc:	80070713          	addi	a4,a4,-2048 # ffffffc050472eb8 <pcb>
ffffffc0504036c0:	fe842683          	lw	a3,-24(s0)
ffffffc0504036c4:	09800793          	li	a5,152
ffffffc0504036c8:	02f687b3          	mul	a5,a3,a5
ffffffc0504036cc:	97ba                	add	a5,a5,a4
ffffffc0504036ce:	4ffc                	lw	a5,92(a5)
ffffffc0504036d0:	e399                	bnez	a5,ffffffc0504036d6 <do_waitpid+0x8e>
ffffffc0504036d2:	57f9                	li	a5,-2
ffffffc0504036d4:	a201                	j	ffffffc0504037d4 <do_waitpid+0x18c>
ffffffc0504036d6:	0006f717          	auipc	a4,0x6f
ffffffc0504036da:	7e270713          	addi	a4,a4,2018 # ffffffc050472eb8 <pcb>
ffffffc0504036de:	fe842683          	lw	a3,-24(s0)
ffffffc0504036e2:	09800793          	li	a5,152
ffffffc0504036e6:	02f687b3          	mul	a5,a3,a5
ffffffc0504036ea:	97ba                	add	a5,a5,a4
ffffffc0504036ec:	4ffc                	lw	a5,92(a5)
ffffffc0504036ee:	873e                	mv	a4,a5
ffffffc0504036f0:	4791                	li	a5,4
ffffffc0504036f2:	04f71b63          	bne	a4,a5,ffffffc050403748 <do_waitpid+0x100>
ffffffc0504036f6:	fe842703          	lw	a4,-24(s0)
ffffffc0504036fa:	09800793          	li	a5,152
ffffffc0504036fe:	02f707b3          	mul	a5,a4,a5
ffffffc050403702:	01078713          	addi	a4,a5,16
ffffffc050403706:	0006f797          	auipc	a5,0x6f
ffffffc05040370a:	7b278793          	addi	a5,a5,1970 # ffffffc050472eb8 <pcb>
ffffffc05040370e:	97ba                	add	a5,a5,a4
ffffffc050403710:	07a1                	addi	a5,a5,8
ffffffc050403712:	00071617          	auipc	a2,0x71
ffffffc050403716:	aa660613          	addi	a2,a2,-1370 # ffffffc0504741b8 <zombie_queue>
ffffffc05040371a:	00071597          	auipc	a1,0x71
ffffffc05040371e:	ab658593          	addi	a1,a1,-1354 # ffffffc0504741d0 <exit_queue>
ffffffc050403722:	853e                	mv	a0,a5
ffffffc050403724:	8f7ff0ef          	jal	ra,ffffffc05040301a <move_node>
ffffffc050403728:	0006f717          	auipc	a4,0x6f
ffffffc05040372c:	79070713          	addi	a4,a4,1936 # ffffffc050472eb8 <pcb>
ffffffc050403730:	fe842683          	lw	a3,-24(s0)
ffffffc050403734:	09800793          	li	a5,152
ffffffc050403738:	02f687b3          	mul	a5,a3,a5
ffffffc05040373c:	97ba                	add	a5,a5,a4
ffffffc05040373e:	0407ae23          	sw	zero,92(a5)
ffffffc050403742:	fdc42783          	lw	a5,-36(s0)
ffffffc050403746:	a079                	j	ffffffc0504037d4 <do_waitpid+0x18c>
ffffffc050403748:	0006f717          	auipc	a4,0x6f
ffffffc05040374c:	74870713          	addi	a4,a4,1864 # ffffffc050472e90 <current_running>
ffffffc050403750:	fe442783          	lw	a5,-28(s0)
ffffffc050403754:	078e                	slli	a5,a5,0x3
ffffffc050403756:	97ba                	add	a5,a5,a4
ffffffc050403758:	639c                	ld	a5,0(a5)
ffffffc05040375a:	4705                	li	a4,1
ffffffc05040375c:	cff8                	sw	a4,92(a5)
ffffffc05040375e:	0006f717          	auipc	a4,0x6f
ffffffc050403762:	73270713          	addi	a4,a4,1842 # ffffffc050472e90 <current_running>
ffffffc050403766:	fe442783          	lw	a5,-28(s0)
ffffffc05040376a:	078e                	slli	a5,a5,0x3
ffffffc05040376c:	97ba                	add	a5,a5,a4
ffffffc05040376e:	639c                	ld	a5,0(a5)
ffffffc050403770:	fe842683          	lw	a3,-24(s0)
ffffffc050403774:	09800713          	li	a4,152
ffffffc050403778:	02e68733          	mul	a4,a3,a4
ffffffc05040377c:	03070693          	addi	a3,a4,48
ffffffc050403780:	0006f717          	auipc	a4,0x6f
ffffffc050403784:	73870713          	addi	a4,a4,1848 # ffffffc050472eb8 <pcb>
ffffffc050403788:	9736                	add	a4,a4,a3
ffffffc05040378a:	e7b8                	sd	a4,72(a5)
ffffffc05040378c:	0006f717          	auipc	a4,0x6f
ffffffc050403790:	70470713          	addi	a4,a4,1796 # ffffffc050472e90 <current_running>
ffffffc050403794:	fe442783          	lw	a5,-28(s0)
ffffffc050403798:	078e                	slli	a5,a5,0x3
ffffffc05040379a:	97ba                	add	a5,a5,a4
ffffffc05040379c:	639c                	ld	a5,0(a5)
ffffffc05040379e:	01878693          	addi	a3,a5,24
ffffffc0504037a2:	fe842703          	lw	a4,-24(s0)
ffffffc0504037a6:	09800793          	li	a5,152
ffffffc0504037aa:	02f707b3          	mul	a5,a4,a5
ffffffc0504037ae:	03078713          	addi	a4,a5,48
ffffffc0504037b2:	0006f797          	auipc	a5,0x6f
ffffffc0504037b6:	70678793          	addi	a5,a5,1798 # ffffffc050472eb8 <pcb>
ffffffc0504037ba:	97ba                	add	a5,a5,a4
ffffffc0504037bc:	0006f617          	auipc	a2,0x6f
ffffffc0504037c0:	6bc60613          	addi	a2,a2,1724 # ffffffc050472e78 <ready_queue>
ffffffc0504037c4:	85be                	mv	a1,a5
ffffffc0504037c6:	8536                	mv	a0,a3
ffffffc0504037c8:	853ff0ef          	jal	ra,ffffffc05040301a <move_node>
ffffffc0504037cc:	c22ff0ef          	jal	ra,ffffffc050402bee <do_scheduler>
ffffffc0504037d0:	fdc42783          	lw	a5,-36(s0)
ffffffc0504037d4:	853e                	mv	a0,a5
ffffffc0504037d6:	70a2                	ld	ra,40(sp)
ffffffc0504037d8:	7402                	ld	s0,32(sp)
ffffffc0504037da:	6145                	addi	sp,sp,48
ffffffc0504037dc:	8082                	ret

ffffffc0504037de <do_kill>:
ffffffc0504037de:	7179                	addi	sp,sp,-48
ffffffc0504037e0:	f406                	sd	ra,40(sp)
ffffffc0504037e2:	f022                	sd	s0,32(sp)
ffffffc0504037e4:	1800                	addi	s0,sp,48
ffffffc0504037e6:	87aa                	mv	a5,a0
ffffffc0504037e8:	fcf42e23          	sw	a5,-36(s0)
ffffffc0504037ec:	fe042623          	sw	zero,-20(s0)
ffffffc0504037f0:	b51fc0ef          	jal	ra,ffffffc050400340 <get_current_cpu_id>
ffffffc0504037f4:	87aa                	mv	a5,a0
ffffffc0504037f6:	fef42023          	sw	a5,-32(s0)
ffffffc0504037fa:	0006f717          	auipc	a4,0x6f
ffffffc0504037fe:	69670713          	addi	a4,a4,1686 # ffffffc050472e90 <current_running>
ffffffc050403802:	fe042783          	lw	a5,-32(s0)
ffffffc050403806:	078e                	slli	a5,a5,0x3
ffffffc050403808:	97ba                	add	a5,a5,a4
ffffffc05040380a:	639c                	ld	a5,0(a5)
ffffffc05040380c:	4bb8                	lw	a4,80(a5)
ffffffc05040380e:	fdc42783          	lw	a5,-36(s0)
ffffffc050403812:	2781                	sext.w	a5,a5
ffffffc050403814:	00e78d63          	beq	a5,a4,ffffffc05040382e <do_kill+0x50>
ffffffc050403818:	fdc42783          	lw	a5,-36(s0)
ffffffc05040381c:	2781                	sext.w	a5,a5
ffffffc05040381e:	cb81                	beqz	a5,ffffffc05040382e <do_kill+0x50>
ffffffc050403820:	fdc42783          	lw	a5,-36(s0)
ffffffc050403824:	0007871b          	sext.w	a4,a5
ffffffc050403828:	4785                	li	a5,1
ffffffc05040382a:	00f71463          	bne	a4,a5,ffffffc050403832 <do_kill+0x54>
ffffffc05040382e:	57fd                	li	a5,-1
ffffffc050403830:	a131                	j	ffffffc050403c3c <do_kill+0x45e>
ffffffc050403832:	fe042423          	sw	zero,-24(s0)
ffffffc050403836:	a81d                	j	ffffffc05040386c <do_kill+0x8e>
ffffffc050403838:	0006f717          	auipc	a4,0x6f
ffffffc05040383c:	68070713          	addi	a4,a4,1664 # ffffffc050472eb8 <pcb>
ffffffc050403840:	fe842683          	lw	a3,-24(s0)
ffffffc050403844:	09800793          	li	a5,152
ffffffc050403848:	02f687b3          	mul	a5,a3,a5
ffffffc05040384c:	97ba                	add	a5,a5,a4
ffffffc05040384e:	4bb8                	lw	a4,80(a5)
ffffffc050403850:	fdc42783          	lw	a5,-36(s0)
ffffffc050403854:	2781                	sext.w	a5,a5
ffffffc050403856:	00e79663          	bne	a5,a4,ffffffc050403862 <do_kill+0x84>
ffffffc05040385a:	4785                	li	a5,1
ffffffc05040385c:	fef42623          	sw	a5,-20(s0)
ffffffc050403860:	a829                	j	ffffffc05040387a <do_kill+0x9c>
ffffffc050403862:	fe842783          	lw	a5,-24(s0)
ffffffc050403866:	2785                	addiw	a5,a5,1
ffffffc050403868:	fef42423          	sw	a5,-24(s0)
ffffffc05040386c:	fe842783          	lw	a5,-24(s0)
ffffffc050403870:	0007871b          	sext.w	a4,a5
ffffffc050403874:	47fd                	li	a5,31
ffffffc050403876:	fce7d1e3          	bge	a5,a4,ffffffc050403838 <do_kill+0x5a>
ffffffc05040387a:	fec42783          	lw	a5,-20(s0)
ffffffc05040387e:	2781                	sext.w	a5,a5
ffffffc050403880:	e399                	bnez	a5,ffffffc050403886 <do_kill+0xa8>
ffffffc050403882:	4781                	li	a5,0
ffffffc050403884:	ae65                	j	ffffffc050403c3c <do_kill+0x45e>
ffffffc050403886:	0006f717          	auipc	a4,0x6f
ffffffc05040388a:	63270713          	addi	a4,a4,1586 # ffffffc050472eb8 <pcb>
ffffffc05040388e:	fe842683          	lw	a3,-24(s0)
ffffffc050403892:	09800793          	li	a5,152
ffffffc050403896:	02f687b3          	mul	a5,a3,a5
ffffffc05040389a:	97ba                	add	a5,a5,a4
ffffffc05040389c:	4ffc                	lw	a5,92(a5)
ffffffc05040389e:	e399                	bnez	a5,ffffffc0504038a4 <do_kill+0xc6>
ffffffc0504038a0:	4781                	li	a5,0
ffffffc0504038a2:	ae69                	j	ffffffc050403c3c <do_kill+0x45e>
ffffffc0504038a4:	0006f717          	auipc	a4,0x6f
ffffffc0504038a8:	61470713          	addi	a4,a4,1556 # ffffffc050472eb8 <pcb>
ffffffc0504038ac:	fe842683          	lw	a3,-24(s0)
ffffffc0504038b0:	09800793          	li	a5,152
ffffffc0504038b4:	02f687b3          	mul	a5,a3,a5
ffffffc0504038b8:	97ba                	add	a5,a5,a4
ffffffc0504038ba:	4ffc                	lw	a5,92(a5)
ffffffc0504038bc:	873e                	mv	a4,a5
ffffffc0504038be:	4789                	li	a5,2
ffffffc0504038c0:	00f71463          	bne	a4,a5,ffffffc0504038c8 <do_kill+0xea>
ffffffc0504038c4:	57fd                	li	a5,-1
ffffffc0504038c6:	ae9d                	j	ffffffc050403c3c <do_kill+0x45e>
ffffffc0504038c8:	fe042623          	sw	zero,-20(s0)
ffffffc0504038cc:	fe042223          	sw	zero,-28(s0)
ffffffc0504038d0:	a8a1                	j	ffffffc050403928 <do_kill+0x14a>
ffffffc0504038d2:	0006f717          	auipc	a4,0x6f
ffffffc0504038d6:	5e670713          	addi	a4,a4,1510 # ffffffc050472eb8 <pcb>
ffffffc0504038da:	fe442683          	lw	a3,-28(s0)
ffffffc0504038de:	09800793          	li	a5,152
ffffffc0504038e2:	02f687b3          	mul	a5,a3,a5
ffffffc0504038e6:	97ba                	add	a5,a5,a4
ffffffc0504038e8:	6bd8                	ld	a4,144(a5)
ffffffc0504038ea:	0006f697          	auipc	a3,0x6f
ffffffc0504038ee:	5ce68693          	addi	a3,a3,1486 # ffffffc050472eb8 <pcb>
ffffffc0504038f2:	fe842603          	lw	a2,-24(s0)
ffffffc0504038f6:	09800793          	li	a5,152
ffffffc0504038fa:	02f607b3          	mul	a5,a2,a5
ffffffc0504038fe:	97b6                	add	a5,a5,a3
ffffffc050403900:	6bdc                	ld	a5,144(a5)
ffffffc050403902:	00f71e63          	bne	a4,a5,ffffffc05040391e <do_kill+0x140>
ffffffc050403906:	fe442703          	lw	a4,-28(s0)
ffffffc05040390a:	fe842783          	lw	a5,-24(s0)
ffffffc05040390e:	2701                	sext.w	a4,a4
ffffffc050403910:	2781                	sext.w	a5,a5
ffffffc050403912:	00f70663          	beq	a4,a5,ffffffc05040391e <do_kill+0x140>
ffffffc050403916:	4785                	li	a5,1
ffffffc050403918:	fef42623          	sw	a5,-20(s0)
ffffffc05040391c:	a829                	j	ffffffc050403936 <do_kill+0x158>
ffffffc05040391e:	fe442783          	lw	a5,-28(s0)
ffffffc050403922:	2785                	addiw	a5,a5,1
ffffffc050403924:	fef42223          	sw	a5,-28(s0)
ffffffc050403928:	fe442783          	lw	a5,-28(s0)
ffffffc05040392c:	0007871b          	sext.w	a4,a5
ffffffc050403930:	47fd                	li	a5,31
ffffffc050403932:	fae7d0e3          	bge	a5,a4,ffffffc0504038d2 <do_kill+0xf4>
ffffffc050403936:	fec42783          	lw	a5,-20(s0)
ffffffc05040393a:	0007871b          	sext.w	a4,a5
ffffffc05040393e:	4785                	li	a5,1
ffffffc050403940:	02f71463          	bne	a4,a5,ffffffc050403968 <do_kill+0x18a>
ffffffc050403944:	0006f717          	auipc	a4,0x6f
ffffffc050403948:	57470713          	addi	a4,a4,1396 # ffffffc050472eb8 <pcb>
ffffffc05040394c:	fe442683          	lw	a3,-28(s0)
ffffffc050403950:	09800793          	li	a5,152
ffffffc050403954:	02f687b3          	mul	a5,a3,a5
ffffffc050403958:	97ba                	add	a5,a5,a4
ffffffc05040395a:	4ffc                	lw	a5,92(a5)
ffffffc05040395c:	873e                	mv	a4,a5
ffffffc05040395e:	4789                	li	a5,2
ffffffc050403960:	00f71463          	bne	a4,a5,ffffffc050403968 <do_kill+0x18a>
ffffffc050403964:	57fd                	li	a5,-1
ffffffc050403966:	acd9                	j	ffffffc050403c3c <do_kill+0x45e>
ffffffc050403968:	0006f717          	auipc	a4,0x6f
ffffffc05040396c:	55070713          	addi	a4,a4,1360 # ffffffc050472eb8 <pcb>
ffffffc050403970:	fe842683          	lw	a3,-24(s0)
ffffffc050403974:	09800793          	li	a5,152
ffffffc050403978:	02f687b3          	mul	a5,a3,a5
ffffffc05040397c:	97ba                	add	a5,a5,a4
ffffffc05040397e:	5b9c                	lw	a5,48(a5)
ffffffc050403980:	02f05263          	blez	a5,ffffffc0504039a4 <do_kill+0x1c6>
ffffffc050403984:	fe842703          	lw	a4,-24(s0)
ffffffc050403988:	09800793          	li	a5,152
ffffffc05040398c:	02f707b3          	mul	a5,a4,a5
ffffffc050403990:	03078713          	addi	a4,a5,48
ffffffc050403994:	0006f797          	auipc	a5,0x6f
ffffffc050403998:	52478793          	addi	a5,a5,1316 # ffffffc050472eb8 <pcb>
ffffffc05040399c:	97ba                	add	a5,a5,a4
ffffffc05040399e:	853e                	mv	a0,a5
ffffffc0504039a0:	9c5ff0ef          	jal	ra,ffffffc050403364 <release_wait_list>
ffffffc0504039a4:	fe842703          	lw	a4,-24(s0)
ffffffc0504039a8:	09800793          	li	a5,152
ffffffc0504039ac:	02f707b3          	mul	a5,a4,a5
ffffffc0504039b0:	01078713          	addi	a4,a5,16
ffffffc0504039b4:	0006f797          	auipc	a5,0x6f
ffffffc0504039b8:	50478793          	addi	a5,a5,1284 # ffffffc050472eb8 <pcb>
ffffffc0504039bc:	97ba                	add	a5,a5,a4
ffffffc0504039be:	00878513          	addi	a0,a5,8
ffffffc0504039c2:	0006f717          	auipc	a4,0x6f
ffffffc0504039c6:	4f670713          	addi	a4,a4,1270 # ffffffc050472eb8 <pcb>
ffffffc0504039ca:	fe842683          	lw	a3,-24(s0)
ffffffc0504039ce:	09800793          	li	a5,152
ffffffc0504039d2:	02f687b3          	mul	a5,a3,a5
ffffffc0504039d6:	97ba                	add	a5,a5,a4
ffffffc0504039d8:	67bc                	ld	a5,72(a5)
ffffffc0504039da:	863e                	mv	a2,a5
ffffffc0504039dc:	00070597          	auipc	a1,0x70
ffffffc0504039e0:	7f458593          	addi	a1,a1,2036 # ffffffc0504741d0 <exit_queue>
ffffffc0504039e4:	e36ff0ef          	jal	ra,ffffffc05040301a <move_node>
ffffffc0504039e8:	0006f717          	auipc	a4,0x6f
ffffffc0504039ec:	4d070713          	addi	a4,a4,1232 # ffffffc050472eb8 <pcb>
ffffffc0504039f0:	fe842683          	lw	a3,-24(s0)
ffffffc0504039f4:	09800793          	li	a5,152
ffffffc0504039f8:	02f687b3          	mul	a5,a3,a5
ffffffc0504039fc:	97ba                	add	a5,a5,a4
ffffffc0504039fe:	0407ae23          	sw	zero,92(a5)
ffffffc050403a02:	0006f717          	auipc	a4,0x6f
ffffffc050403a06:	4b670713          	addi	a4,a4,1206 # ffffffc050472eb8 <pcb>
ffffffc050403a0a:	fe842683          	lw	a3,-24(s0)
ffffffc050403a0e:	09800793          	li	a5,152
ffffffc050403a12:	02f687b3          	mul	a5,a3,a5
ffffffc050403a16:	97ba                	add	a5,a5,a4
ffffffc050403a18:	00070717          	auipc	a4,0x70
ffffffc050403a1c:	7b870713          	addi	a4,a4,1976 # ffffffc0504741d0 <exit_queue>
ffffffc050403a20:	e7b8                	sd	a4,72(a5)
ffffffc050403a22:	0006f717          	auipc	a4,0x6f
ffffffc050403a26:	49670713          	addi	a4,a4,1174 # ffffffc050472eb8 <pcb>
ffffffc050403a2a:	fe842683          	lw	a3,-24(s0)
ffffffc050403a2e:	09800793          	li	a5,152
ffffffc050403a32:	02f687b3          	mul	a5,a3,a5
ffffffc050403a36:	97ba                	add	a5,a5,a4
ffffffc050403a38:	7fb8                	ld	a4,120(a5)
ffffffc050403a3a:	0006f697          	auipc	a3,0x6f
ffffffc050403a3e:	47e68693          	addi	a3,a3,1150 # ffffffc050472eb8 <pcb>
ffffffc050403a42:	fe842603          	lw	a2,-24(s0)
ffffffc050403a46:	09800793          	li	a5,152
ffffffc050403a4a:	02f607b3          	mul	a5,a2,a5
ffffffc050403a4e:	97b6                	add	a5,a5,a3
ffffffc050403a50:	e398                	sd	a4,0(a5)
ffffffc050403a52:	0006f717          	auipc	a4,0x6f
ffffffc050403a56:	46670713          	addi	a4,a4,1126 # ffffffc050472eb8 <pcb>
ffffffc050403a5a:	fe842683          	lw	a3,-24(s0)
ffffffc050403a5e:	09800793          	li	a5,152
ffffffc050403a62:	02f687b3          	mul	a5,a3,a5
ffffffc050403a66:	97ba                	add	a5,a5,a4
ffffffc050403a68:	63d8                	ld	a4,128(a5)
ffffffc050403a6a:	0006f697          	auipc	a3,0x6f
ffffffc050403a6e:	44e68693          	addi	a3,a3,1102 # ffffffc050472eb8 <pcb>
ffffffc050403a72:	fe842603          	lw	a2,-24(s0)
ffffffc050403a76:	09800793          	li	a5,152
ffffffc050403a7a:	02f607b3          	mul	a5,a2,a5
ffffffc050403a7e:	97b6                	add	a5,a5,a3
ffffffc050403a80:	e798                	sd	a4,8(a5)
ffffffc050403a82:	fe842703          	lw	a4,-24(s0)
ffffffc050403a86:	09800793          	li	a5,152
ffffffc050403a8a:	02f70733          	mul	a4,a4,a5
ffffffc050403a8e:	0006f797          	auipc	a5,0x6f
ffffffc050403a92:	42a78793          	addi	a5,a5,1066 # ffffffc050472eb8 <pcb>
ffffffc050403a96:	97ba                	add	a5,a5,a4
ffffffc050403a98:	853e                	mv	a0,a5
ffffffc050403a9a:	9bfff0ef          	jal	ra,ffffffc050403458 <lock_exit>
ffffffc050403a9e:	fec42783          	lw	a5,-20(s0)
ffffffc050403aa2:	0007871b          	sext.w	a4,a5
ffffffc050403aa6:	4785                	li	a5,1
ffffffc050403aa8:	14f71b63          	bne	a4,a5,ffffffc050403bfe <do_kill+0x420>
ffffffc050403aac:	0006f717          	auipc	a4,0x6f
ffffffc050403ab0:	40c70713          	addi	a4,a4,1036 # ffffffc050472eb8 <pcb>
ffffffc050403ab4:	fe442683          	lw	a3,-28(s0)
ffffffc050403ab8:	09800793          	li	a5,152
ffffffc050403abc:	02f687b3          	mul	a5,a3,a5
ffffffc050403ac0:	97ba                	add	a5,a5,a4
ffffffc050403ac2:	4ffc                	lw	a5,92(a5)
ffffffc050403ac4:	12078d63          	beqz	a5,ffffffc050403bfe <do_kill+0x420>
ffffffc050403ac8:	0006f717          	auipc	a4,0x6f
ffffffc050403acc:	3f070713          	addi	a4,a4,1008 # ffffffc050472eb8 <pcb>
ffffffc050403ad0:	fe442683          	lw	a3,-28(s0)
ffffffc050403ad4:	09800793          	li	a5,152
ffffffc050403ad8:	02f687b3          	mul	a5,a3,a5
ffffffc050403adc:	97ba                	add	a5,a5,a4
ffffffc050403ade:	5b9c                	lw	a5,48(a5)
ffffffc050403ae0:	02f05263          	blez	a5,ffffffc050403b04 <do_kill+0x326>
ffffffc050403ae4:	fe442703          	lw	a4,-28(s0)
ffffffc050403ae8:	09800793          	li	a5,152
ffffffc050403aec:	02f707b3          	mul	a5,a4,a5
ffffffc050403af0:	03078713          	addi	a4,a5,48
ffffffc050403af4:	0006f797          	auipc	a5,0x6f
ffffffc050403af8:	3c478793          	addi	a5,a5,964 # ffffffc050472eb8 <pcb>
ffffffc050403afc:	97ba                	add	a5,a5,a4
ffffffc050403afe:	853e                	mv	a0,a5
ffffffc050403b00:	865ff0ef          	jal	ra,ffffffc050403364 <release_wait_list>
ffffffc050403b04:	fe442703          	lw	a4,-28(s0)
ffffffc050403b08:	09800793          	li	a5,152
ffffffc050403b0c:	02f707b3          	mul	a5,a4,a5
ffffffc050403b10:	01078713          	addi	a4,a5,16
ffffffc050403b14:	0006f797          	auipc	a5,0x6f
ffffffc050403b18:	3a478793          	addi	a5,a5,932 # ffffffc050472eb8 <pcb>
ffffffc050403b1c:	97ba                	add	a5,a5,a4
ffffffc050403b1e:	00878513          	addi	a0,a5,8
ffffffc050403b22:	0006f717          	auipc	a4,0x6f
ffffffc050403b26:	39670713          	addi	a4,a4,918 # ffffffc050472eb8 <pcb>
ffffffc050403b2a:	fe442683          	lw	a3,-28(s0)
ffffffc050403b2e:	09800793          	li	a5,152
ffffffc050403b32:	02f687b3          	mul	a5,a3,a5
ffffffc050403b36:	97ba                	add	a5,a5,a4
ffffffc050403b38:	67bc                	ld	a5,72(a5)
ffffffc050403b3a:	863e                	mv	a2,a5
ffffffc050403b3c:	00070597          	auipc	a1,0x70
ffffffc050403b40:	69458593          	addi	a1,a1,1684 # ffffffc0504741d0 <exit_queue>
ffffffc050403b44:	cd6ff0ef          	jal	ra,ffffffc05040301a <move_node>
ffffffc050403b48:	0006f717          	auipc	a4,0x6f
ffffffc050403b4c:	37070713          	addi	a4,a4,880 # ffffffc050472eb8 <pcb>
ffffffc050403b50:	fe442683          	lw	a3,-28(s0)
ffffffc050403b54:	09800793          	li	a5,152
ffffffc050403b58:	02f687b3          	mul	a5,a3,a5
ffffffc050403b5c:	97ba                	add	a5,a5,a4
ffffffc050403b5e:	0407ae23          	sw	zero,92(a5)
ffffffc050403b62:	0006f717          	auipc	a4,0x6f
ffffffc050403b66:	35670713          	addi	a4,a4,854 # ffffffc050472eb8 <pcb>
ffffffc050403b6a:	fe442683          	lw	a3,-28(s0)
ffffffc050403b6e:	09800793          	li	a5,152
ffffffc050403b72:	02f687b3          	mul	a5,a3,a5
ffffffc050403b76:	97ba                	add	a5,a5,a4
ffffffc050403b78:	00070717          	auipc	a4,0x70
ffffffc050403b7c:	65870713          	addi	a4,a4,1624 # ffffffc0504741d0 <exit_queue>
ffffffc050403b80:	e7b8                	sd	a4,72(a5)
ffffffc050403b82:	0006f717          	auipc	a4,0x6f
ffffffc050403b86:	33670713          	addi	a4,a4,822 # ffffffc050472eb8 <pcb>
ffffffc050403b8a:	fe442683          	lw	a3,-28(s0)
ffffffc050403b8e:	09800793          	li	a5,152
ffffffc050403b92:	02f687b3          	mul	a5,a3,a5
ffffffc050403b96:	97ba                	add	a5,a5,a4
ffffffc050403b98:	7fb8                	ld	a4,120(a5)
ffffffc050403b9a:	0006f697          	auipc	a3,0x6f
ffffffc050403b9e:	31e68693          	addi	a3,a3,798 # ffffffc050472eb8 <pcb>
ffffffc050403ba2:	fe442603          	lw	a2,-28(s0)
ffffffc050403ba6:	09800793          	li	a5,152
ffffffc050403baa:	02f607b3          	mul	a5,a2,a5
ffffffc050403bae:	97b6                	add	a5,a5,a3
ffffffc050403bb0:	e398                	sd	a4,0(a5)
ffffffc050403bb2:	0006f717          	auipc	a4,0x6f
ffffffc050403bb6:	30670713          	addi	a4,a4,774 # ffffffc050472eb8 <pcb>
ffffffc050403bba:	fe442683          	lw	a3,-28(s0)
ffffffc050403bbe:	09800793          	li	a5,152
ffffffc050403bc2:	02f687b3          	mul	a5,a3,a5
ffffffc050403bc6:	97ba                	add	a5,a5,a4
ffffffc050403bc8:	63d8                	ld	a4,128(a5)
ffffffc050403bca:	0006f697          	auipc	a3,0x6f
ffffffc050403bce:	2ee68693          	addi	a3,a3,750 # ffffffc050472eb8 <pcb>
ffffffc050403bd2:	fe442603          	lw	a2,-28(s0)
ffffffc050403bd6:	09800793          	li	a5,152
ffffffc050403bda:	02f607b3          	mul	a5,a2,a5
ffffffc050403bde:	97b6                	add	a5,a5,a3
ffffffc050403be0:	e798                	sd	a4,8(a5)
ffffffc050403be2:	fe442703          	lw	a4,-28(s0)
ffffffc050403be6:	09800793          	li	a5,152
ffffffc050403bea:	02f70733          	mul	a4,a4,a5
ffffffc050403bee:	0006f797          	auipc	a5,0x6f
ffffffc050403bf2:	2ca78793          	addi	a5,a5,714 # ffffffc050472eb8 <pcb>
ffffffc050403bf6:	97ba                	add	a5,a5,a4
ffffffc050403bf8:	853e                	mv	a0,a5
ffffffc050403bfa:	85fff0ef          	jal	ra,ffffffc050403458 <lock_exit>
ffffffc050403bfe:	0006f717          	auipc	a4,0x6f
ffffffc050403c02:	2ba70713          	addi	a4,a4,698 # ffffffc050472eb8 <pcb>
ffffffc050403c06:	fe842683          	lw	a3,-24(s0)
ffffffc050403c0a:	09800793          	li	a5,152
ffffffc050403c0e:	02f687b3          	mul	a5,a3,a5
ffffffc050403c12:	97ba                	add	a5,a5,a4
ffffffc050403c14:	6bdc                	ld	a5,144(a5)
ffffffc050403c16:	853e                	mv	a0,a5
ffffffc050403c18:	59d010ef          	jal	ra,ffffffc0504059b4 <dealloc_uvm>
ffffffc050403c1c:	0006f717          	auipc	a4,0x6f
ffffffc050403c20:	29c70713          	addi	a4,a4,668 # ffffffc050472eb8 <pcb>
ffffffc050403c24:	fe842683          	lw	a3,-24(s0)
ffffffc050403c28:	09800793          	li	a5,152
ffffffc050403c2c:	02f687b3          	mul	a5,a3,a5
ffffffc050403c30:	97ba                	add	a5,a5,a4
ffffffc050403c32:	6bdc                	ld	a5,144(a5)
ffffffc050403c34:	853e                	mv	a0,a5
ffffffc050403c36:	7b7010ef          	jal	ra,ffffffc050405bec <unmap_kvm>
ffffffc050403c3a:	4785                	li	a5,1
ffffffc050403c3c:	853e                	mv	a0,a5
ffffffc050403c3e:	70a2                	ld	ra,40(sp)
ffffffc050403c40:	7402                	ld	s0,32(sp)
ffffffc050403c42:	6145                	addi	sp,sp,48
ffffffc050403c44:	8082                	ret

ffffffc050403c46 <do_getpid>:
ffffffc050403c46:	1101                	addi	sp,sp,-32
ffffffc050403c48:	ec06                	sd	ra,24(sp)
ffffffc050403c4a:	e822                	sd	s0,16(sp)
ffffffc050403c4c:	1000                	addi	s0,sp,32
ffffffc050403c4e:	ef2fc0ef          	jal	ra,ffffffc050400340 <get_current_cpu_id>
ffffffc050403c52:	87aa                	mv	a5,a0
ffffffc050403c54:	fef42623          	sw	a5,-20(s0)
ffffffc050403c58:	0006f717          	auipc	a4,0x6f
ffffffc050403c5c:	23870713          	addi	a4,a4,568 # ffffffc050472e90 <current_running>
ffffffc050403c60:	fec42783          	lw	a5,-20(s0)
ffffffc050403c64:	078e                	slli	a5,a5,0x3
ffffffc050403c66:	97ba                	add	a5,a5,a4
ffffffc050403c68:	639c                	ld	a5,0(a5)
ffffffc050403c6a:	4bbc                	lw	a5,80(a5)
ffffffc050403c6c:	853e                	mv	a0,a5
ffffffc050403c6e:	60e2                	ld	ra,24(sp)
ffffffc050403c70:	6442                	ld	s0,16(sp)
ffffffc050403c72:	6105                	addi	sp,sp,32
ffffffc050403c74:	8082                	ret

ffffffc050403c76 <do_taskset>:
ffffffc050403c76:	1101                	addi	sp,sp,-32
ffffffc050403c78:	ec22                	sd	s0,24(sp)
ffffffc050403c7a:	1000                	addi	s0,sp,32
ffffffc050403c7c:	87aa                	mv	a5,a0
ffffffc050403c7e:	872e                	mv	a4,a1
ffffffc050403c80:	fef42623          	sw	a5,-20(s0)
ffffffc050403c84:	87ba                	mv	a5,a4
ffffffc050403c86:	fef42423          	sw	a5,-24(s0)
ffffffc050403c8a:	81818793          	addi	a5,gp,-2024 # ffffffc05045f8d0 <process_id>
ffffffc050403c8e:	4398                	lw	a4,0(a5)
ffffffc050403c90:	fec42783          	lw	a5,-20(s0)
ffffffc050403c94:	2781                	sext.w	a5,a5
ffffffc050403c96:	00e7c463          	blt	a5,a4,ffffffc050403c9e <do_taskset+0x28>
ffffffc050403c9a:	57fd                	li	a5,-1
ffffffc050403c9c:	a005                	j	ffffffc050403cbc <do_taskset+0x46>
ffffffc050403c9e:	0006f717          	auipc	a4,0x6f
ffffffc050403ca2:	21a70713          	addi	a4,a4,538 # ffffffc050472eb8 <pcb>
ffffffc050403ca6:	fec42683          	lw	a3,-20(s0)
ffffffc050403caa:	09800793          	li	a5,152
ffffffc050403cae:	02f687b3          	mul	a5,a3,a5
ffffffc050403cb2:	97ba                	add	a5,a5,a4
ffffffc050403cb4:	fe842703          	lw	a4,-24(s0)
ffffffc050403cb8:	cbf8                	sw	a4,84(a5)
ffffffc050403cba:	4785                	li	a5,1
ffffffc050403cbc:	853e                	mv	a0,a5
ffffffc050403cbe:	6462                	ld	s0,24(sp)
ffffffc050403cc0:	6105                	addi	sp,sp,32
ffffffc050403cc2:	8082                	ret

ffffffc050403cc4 <copy_user_arg>:
ffffffc050403cc4:	7159                	addi	sp,sp,-112
ffffffc050403cc6:	f4a2                	sd	s0,104(sp)
ffffffc050403cc8:	1880                	addi	s0,sp,112
ffffffc050403cca:	87aa                	mv	a5,a0
ffffffc050403ccc:	fab43023          	sd	a1,-96(s0)
ffffffc050403cd0:	f8c43c23          	sd	a2,-104(s0)
ffffffc050403cd4:	faf42623          	sw	a5,-84(s0)
ffffffc050403cd8:	f9843783          	ld	a5,-104(s0)
ffffffc050403cdc:	fcf43c23          	sd	a5,-40(s0)
ffffffc050403ce0:	fac42703          	lw	a4,-84(s0)
ffffffc050403ce4:	fd843783          	ld	a5,-40(s0)
ffffffc050403ce8:	e398                	sd	a4,0(a5)
ffffffc050403cea:	f9843783          	ld	a5,-104(s0)
ffffffc050403cee:	07a1                	addi	a5,a5,8
ffffffc050403cf0:	fcf43823          	sd	a5,-48(s0)
ffffffc050403cf4:	f9843703          	ld	a4,-104(s0)
ffffffc050403cf8:	e20007b7          	lui	a5,0xe2000
ffffffc050403cfc:	e0178793          	addi	a5,a5,-511 # ffffffffe1fffe01 <__BSS_END__+0x3f91b8ba19>
ffffffc050403d00:	079e                	slli	a5,a5,0x7
ffffffc050403d02:	97ba                	add	a5,a5,a4
ffffffc050403d04:	fcf43423          	sd	a5,-56(s0)
ffffffc050403d08:	f9843783          	ld	a5,-104(s0)
ffffffc050403d0c:	07c1                	addi	a5,a5,16
ffffffc050403d0e:	fcf43023          	sd	a5,-64(s0)
ffffffc050403d12:	fac42783          	lw	a5,-84(s0)
ffffffc050403d16:	00379713          	slli	a4,a5,0x3
ffffffc050403d1a:	f9843783          	ld	a5,-104(s0)
ffffffc050403d1e:	97ba                	add	a5,a5,a4
ffffffc050403d20:	07c1                	addi	a5,a5,16
ffffffc050403d22:	faf43c23          	sd	a5,-72(s0)
ffffffc050403d26:	fe042623          	sw	zero,-20(s0)
ffffffc050403d2a:	fe042423          	sw	zero,-24(s0)
ffffffc050403d2e:	a04d                	j	ffffffc050403dd0 <copy_user_arg+0x10c>
ffffffc050403d30:	fe842783          	lw	a5,-24(s0)
ffffffc050403d34:	fb843703          	ld	a4,-72(s0)
ffffffc050403d38:	97ba                	add	a5,a5,a4
ffffffc050403d3a:	873e                	mv	a4,a5
ffffffc050403d3c:	fc843783          	ld	a5,-56(s0)
ffffffc050403d40:	40f706b3          	sub	a3,a4,a5
ffffffc050403d44:	fec42783          	lw	a5,-20(s0)
ffffffc050403d48:	078e                	slli	a5,a5,0x3
ffffffc050403d4a:	fc043703          	ld	a4,-64(s0)
ffffffc050403d4e:	97ba                	add	a5,a5,a4
ffffffc050403d50:	8736                	mv	a4,a3
ffffffc050403d52:	e398                	sd	a4,0(a5)
ffffffc050403d54:	fe042223          	sw	zero,-28(s0)
ffffffc050403d58:	a835                	j	ffffffc050403d94 <copy_user_arg+0xd0>
ffffffc050403d5a:	fec42783          	lw	a5,-20(s0)
ffffffc050403d5e:	078e                	slli	a5,a5,0x3
ffffffc050403d60:	fa043703          	ld	a4,-96(s0)
ffffffc050403d64:	97ba                	add	a5,a5,a4
ffffffc050403d66:	6398                	ld	a4,0(a5)
ffffffc050403d68:	fe442783          	lw	a5,-28(s0)
ffffffc050403d6c:	973e                	add	a4,a4,a5
ffffffc050403d6e:	fe842783          	lw	a5,-24(s0)
ffffffc050403d72:	fb843683          	ld	a3,-72(s0)
ffffffc050403d76:	97b6                	add	a5,a5,a3
ffffffc050403d78:	00074703          	lbu	a4,0(a4)
ffffffc050403d7c:	00e78023          	sb	a4,0(a5)
ffffffc050403d80:	fe842783          	lw	a5,-24(s0)
ffffffc050403d84:	2785                	addiw	a5,a5,1
ffffffc050403d86:	fef42423          	sw	a5,-24(s0)
ffffffc050403d8a:	fe442783          	lw	a5,-28(s0)
ffffffc050403d8e:	2785                	addiw	a5,a5,1
ffffffc050403d90:	fef42223          	sw	a5,-28(s0)
ffffffc050403d94:	fec42783          	lw	a5,-20(s0)
ffffffc050403d98:	078e                	slli	a5,a5,0x3
ffffffc050403d9a:	fa043703          	ld	a4,-96(s0)
ffffffc050403d9e:	97ba                	add	a5,a5,a4
ffffffc050403da0:	6398                	ld	a4,0(a5)
ffffffc050403da2:	fe442783          	lw	a5,-28(s0)
ffffffc050403da6:	97ba                	add	a5,a5,a4
ffffffc050403da8:	0007c783          	lbu	a5,0(a5)
ffffffc050403dac:	f7dd                	bnez	a5,ffffffc050403d5a <copy_user_arg+0x96>
ffffffc050403dae:	fe842783          	lw	a5,-24(s0)
ffffffc050403db2:	0017871b          	addiw	a4,a5,1
ffffffc050403db6:	fee42423          	sw	a4,-24(s0)
ffffffc050403dba:	873e                	mv	a4,a5
ffffffc050403dbc:	fb843783          	ld	a5,-72(s0)
ffffffc050403dc0:	97ba                	add	a5,a5,a4
ffffffc050403dc2:	00078023          	sb	zero,0(a5)
ffffffc050403dc6:	fec42783          	lw	a5,-20(s0)
ffffffc050403dca:	2785                	addiw	a5,a5,1
ffffffc050403dcc:	fef42623          	sw	a5,-20(s0)
ffffffc050403dd0:	fec42703          	lw	a4,-20(s0)
ffffffc050403dd4:	fac42783          	lw	a5,-84(s0)
ffffffc050403dd8:	2701                	sext.w	a4,a4
ffffffc050403dda:	2781                	sext.w	a5,a5
ffffffc050403ddc:	f4f74ae3          	blt	a4,a5,ffffffc050403d30 <copy_user_arg+0x6c>
ffffffc050403de0:	fc043703          	ld	a4,-64(s0)
ffffffc050403de4:	fc843783          	ld	a5,-56(s0)
ffffffc050403de8:	40f707b3          	sub	a5,a4,a5
ffffffc050403dec:	873e                	mv	a4,a5
ffffffc050403dee:	fd043783          	ld	a5,-48(s0)
ffffffc050403df2:	e398                	sd	a4,0(a5)
ffffffc050403df4:	0001                	nop
ffffffc050403df6:	7426                	ld	s0,104(sp)
ffffffc050403df8:	6165                	addi	sp,sp,112
ffffffc050403dfa:	8082                	ret

ffffffc050403dfc <do_exec>:
ffffffc050403dfc:	711d                	addi	sp,sp,-96
ffffffc050403dfe:	ec86                	sd	ra,88(sp)
ffffffc050403e00:	e8a2                	sd	s0,80(sp)
ffffffc050403e02:	1080                	addi	s0,sp,96
ffffffc050403e04:	faa43c23          	sd	a0,-72(s0)
ffffffc050403e08:	87ae                	mv	a5,a1
ffffffc050403e0a:	fac43423          	sd	a2,-88(s0)
ffffffc050403e0e:	8736                	mv	a4,a3
ffffffc050403e10:	faf42a23          	sw	a5,-76(s0)
ffffffc050403e14:	87ba                	mv	a5,a4
ffffffc050403e16:	faf42823          	sw	a5,-80(s0)
ffffffc050403e1a:	accff0ef          	jal	ra,ffffffc0504030e6 <alloc_new_pcb>
ffffffc050403e1e:	87aa                	mv	a5,a0
ffffffc050403e20:	fef42623          	sw	a5,-20(s0)
ffffffc050403e24:	fec42783          	lw	a5,-20(s0)
ffffffc050403e28:	2781                	sext.w	a5,a5
ffffffc050403e2a:	0007d463          	bgez	a5,ffffffc050403e32 <do_exec+0x36>
ffffffc050403e2e:	57fd                	li	a5,-1
ffffffc050403e30:	aac9                	j	ffffffc050404002 <do_exec+0x206>
ffffffc050403e32:	d0efc0ef          	jal	ra,ffffffc050400340 <get_current_cpu_id>
ffffffc050403e36:	87aa                	mv	a5,a0
ffffffc050403e38:	fef42423          	sw	a5,-24(s0)
ffffffc050403e3c:	0006f717          	auipc	a4,0x6f
ffffffc050403e40:	07c70713          	addi	a4,a4,124 # ffffffc050472eb8 <pcb>
ffffffc050403e44:	fec42683          	lw	a3,-20(s0)
ffffffc050403e48:	09800793          	li	a5,152
ffffffc050403e4c:	02f687b3          	mul	a5,a3,a5
ffffffc050403e50:	97ba                	add	a5,a5,a4
ffffffc050403e52:	0007b823          	sd	zero,16(a5)
ffffffc050403e56:	0006f717          	auipc	a4,0x6f
ffffffc050403e5a:	06270713          	addi	a4,a4,98 # ffffffc050472eb8 <pcb>
ffffffc050403e5e:	fec42683          	lw	a3,-20(s0)
ffffffc050403e62:	09800793          	li	a5,152
ffffffc050403e66:	02f687b3          	mul	a5,a3,a5
ffffffc050403e6a:	97ba                	add	a5,a5,a4
ffffffc050403e6c:	4709                	li	a4,2
ffffffc050403e6e:	cfb8                	sw	a4,88(a5)
ffffffc050403e70:	0006f717          	auipc	a4,0x6f
ffffffc050403e74:	04870713          	addi	a4,a4,72 # ffffffc050472eb8 <pcb>
ffffffc050403e78:	fec42683          	lw	a3,-20(s0)
ffffffc050403e7c:	09800793          	li	a5,152
ffffffc050403e80:	02f687b3          	mul	a5,a3,a5
ffffffc050403e84:	97ba                	add	a5,a5,a4
ffffffc050403e86:	0807a423          	sw	zero,136(a5)
ffffffc050403e8a:	0006f717          	auipc	a4,0x6f
ffffffc050403e8e:	02e70713          	addi	a4,a4,46 # ffffffc050472eb8 <pcb>
ffffffc050403e92:	fec42683          	lw	a3,-20(s0)
ffffffc050403e96:	09800793          	li	a5,152
ffffffc050403e9a:	02f687b3          	mul	a5,a3,a5
ffffffc050403e9e:	97ba                	add	a5,a5,a4
ffffffc050403ea0:	0807a623          	sw	zero,140(a5)
ffffffc050403ea4:	0006f717          	auipc	a4,0x6f
ffffffc050403ea8:	01470713          	addi	a4,a4,20 # ffffffc050472eb8 <pcb>
ffffffc050403eac:	fec42683          	lw	a3,-20(s0)
ffffffc050403eb0:	09800793          	li	a5,152
ffffffc050403eb4:	02f687b3          	mul	a5,a3,a5
ffffffc050403eb8:	97ba                	add	a5,a5,a4
ffffffc050403eba:	0607b423          	sd	zero,104(a5)
ffffffc050403ebe:	0006f717          	auipc	a4,0x6f
ffffffc050403ec2:	ffa70713          	addi	a4,a4,-6 # ffffffc050472eb8 <pcb>
ffffffc050403ec6:	fec42683          	lw	a3,-20(s0)
ffffffc050403eca:	09800793          	li	a5,152
ffffffc050403ece:	02f687b3          	mul	a5,a3,a5
ffffffc050403ed2:	97ba                	add	a5,a5,a4
ffffffc050403ed4:	fb042703          	lw	a4,-80(s0)
ffffffc050403ed8:	d3b8                	sw	a4,96(a5)
ffffffc050403eda:	0006f717          	auipc	a4,0x6f
ffffffc050403ede:	fde70713          	addi	a4,a4,-34 # ffffffc050472eb8 <pcb>
ffffffc050403ee2:	fec42683          	lw	a3,-20(s0)
ffffffc050403ee6:	09800793          	li	a5,152
ffffffc050403eea:	02f687b3          	mul	a5,a3,a5
ffffffc050403eee:	97ba                	add	a5,a5,a4
ffffffc050403ef0:	577d                	li	a4,-1
ffffffc050403ef2:	cbf8                	sw	a4,84(a5)
ffffffc050403ef4:	fc440713          	addi	a4,s0,-60
ffffffc050403ef8:	fc840793          	addi	a5,s0,-56
ffffffc050403efc:	863a                	mv	a2,a4
ffffffc050403efe:	85be                	mv	a1,a5
ffffffc050403f00:	fb843503          	ld	a0,-72(s0)
ffffffc050403f04:	5dd020ef          	jal	ra,ffffffc050406ce0 <get_elf_file>
ffffffc050403f08:	fc442783          	lw	a5,-60(s0)
ffffffc050403f0c:	853e                	mv	a0,a5
ffffffc050403f0e:	041010ef          	jal	ra,ffffffc05040574e <alloc_uvm>
ffffffc050403f12:	fea43023          	sd	a0,-32(s0)
ffffffc050403f16:	fe043503          	ld	a0,-32(s0)
ffffffc050403f1a:	6b3010ef          	jal	ra,ffffffc050405dcc <map_kvm>
ffffffc050403f1e:	8bbfe0ef          	jal	ra,ffffffc0504027d8 <local_flush_tlb_all>
ffffffc050403f22:	fc843783          	ld	a5,-56(s0)
ffffffc050403f26:	fc442703          	lw	a4,-60(s0)
ffffffc050403f2a:	fe043603          	ld	a2,-32(s0)
ffffffc050403f2e:	fffff697          	auipc	a3,0xfffff
ffffffc050403f32:	95e68693          	addi	a3,a3,-1698 # ffffffc05040288c <get_kva_of>
ffffffc050403f36:	85ba                	mv	a1,a4
ffffffc050403f38:	853e                	mv	a0,a5
ffffffc050403f3a:	adbfe0ef          	jal	ra,ffffffc050402a14 <load_elf>
ffffffc050403f3e:	fca43c23          	sd	a0,-40(s0)
ffffffc050403f42:	0006f717          	auipc	a4,0x6f
ffffffc050403f46:	f7670713          	addi	a4,a4,-138 # ffffffc050472eb8 <pcb>
ffffffc050403f4a:	fec42683          	lw	a3,-20(s0)
ffffffc050403f4e:	09800793          	li	a5,152
ffffffc050403f52:	02f687b3          	mul	a5,a3,a5
ffffffc050403f56:	97ba                	add	a5,a5,a4
ffffffc050403f58:	7fa8                	ld	a0,120(a5)
ffffffc050403f5a:	0006f717          	auipc	a4,0x6f
ffffffc050403f5e:	f5e70713          	addi	a4,a4,-162 # ffffffc050472eb8 <pcb>
ffffffc050403f62:	fec42683          	lw	a3,-20(s0)
ffffffc050403f66:	09800793          	li	a5,152
ffffffc050403f6a:	02f687b3          	mul	a5,a3,a5
ffffffc050403f6e:	97ba                	add	a5,a5,a4
ffffffc050403f70:	63cc                	ld	a1,128(a5)
ffffffc050403f72:	fec42703          	lw	a4,-20(s0)
ffffffc050403f76:	09800793          	li	a5,152
ffffffc050403f7a:	02f70733          	mul	a4,a4,a5
ffffffc050403f7e:	0006f797          	auipc	a5,0x6f
ffffffc050403f82:	f3a78793          	addi	a5,a5,-198 # ffffffc050472eb8 <pcb>
ffffffc050403f86:	97ba                	add	a5,a5,a4
ffffffc050403f88:	86be                	mv	a3,a5
ffffffc050403f8a:	fd843603          	ld	a2,-40(s0)
ffffffc050403f8e:	f42fc0ef          	jal	ra,ffffffc0504006d0 <init_pcb_stack>
ffffffc050403f92:	fe043783          	ld	a5,-32(s0)
ffffffc050403f96:	85be                	mv	a1,a5
ffffffc050403f98:	1e0007b7          	lui	a5,0x1e000
ffffffc050403f9c:	1ff78793          	addi	a5,a5,511 # 1e0001ff <_start-0xffffffc0323ffe01>
ffffffc050403fa0:	00779513          	slli	a0,a5,0x7
ffffffc050403fa4:	8e9fe0ef          	jal	ra,ffffffc05040288c <get_kva_of>
ffffffc050403fa8:	872a                	mv	a4,a0
ffffffc050403faa:	6785                	lui	a5,0x1
ffffffc050403fac:	f8078793          	addi	a5,a5,-128 # f80 <_start-0xffffffc0503ff080>
ffffffc050403fb0:	97ba                	add	a5,a5,a4
ffffffc050403fb2:	fcf43823          	sd	a5,-48(s0)
ffffffc050403fb6:	fb442783          	lw	a5,-76(s0)
ffffffc050403fba:	fd043603          	ld	a2,-48(s0)
ffffffc050403fbe:	fa843583          	ld	a1,-88(s0)
ffffffc050403fc2:	853e                	mv	a0,a5
ffffffc050403fc4:	d01ff0ef          	jal	ra,ffffffc050403cc4 <copy_user_arg>
ffffffc050403fc8:	fec42783          	lw	a5,-20(s0)
ffffffc050403fcc:	853e                	mv	a0,a5
ffffffc050403fce:	99eff0ef          	jal	ra,ffffffc05040316c <set_pcb_ready>
ffffffc050403fd2:	0006f717          	auipc	a4,0x6f
ffffffc050403fd6:	ee670713          	addi	a4,a4,-282 # ffffffc050472eb8 <pcb>
ffffffc050403fda:	fec42683          	lw	a3,-20(s0)
ffffffc050403fde:	09800793          	li	a5,152
ffffffc050403fe2:	02f687b3          	mul	a5,a3,a5
ffffffc050403fe6:	97ba                	add	a5,a5,a4
ffffffc050403fe8:	fe043703          	ld	a4,-32(s0)
ffffffc050403fec:	ebd8                	sd	a4,144(a5)
ffffffc050403fee:	81818793          	addi	a5,gp,-2024 # ffffffc05045f8d0 <process_id>
ffffffc050403ff2:	439c                	lw	a5,0(a5)
ffffffc050403ff4:	0017871b          	addiw	a4,a5,1
ffffffc050403ff8:	0007069b          	sext.w	a3,a4
ffffffc050403ffc:	81818713          	addi	a4,gp,-2024 # ffffffc05045f8d0 <process_id>
ffffffc050404000:	c314                	sw	a3,0(a4)
ffffffc050404002:	853e                	mv	a0,a5
ffffffc050404004:	60e6                	ld	ra,88(sp)
ffffffc050404006:	6446                	ld	s0,80(sp)
ffffffc050404008:	6125                	addi	sp,sp,96
ffffffc05040400a:	8082                	ret

ffffffc05040400c <do_thread_create>:
ffffffc05040400c:	7171                	addi	sp,sp,-176
ffffffc05040400e:	f506                	sd	ra,168(sp)
ffffffc050404010:	f122                	sd	s0,160(sp)
ffffffc050404012:	ed26                	sd	s1,152(sp)
ffffffc050404014:	1900                	addi	s0,sp,176
ffffffc050404016:	f6a43423          	sd	a0,-152(s0)
ffffffc05040401a:	f6b43023          	sd	a1,-160(s0)
ffffffc05040401e:	f4c43c23          	sd	a2,-168(s0)
ffffffc050404022:	8c4ff0ef          	jal	ra,ffffffc0504030e6 <alloc_new_pcb>
ffffffc050404026:	87aa                	mv	a5,a0
ffffffc050404028:	fcf42e23          	sw	a5,-36(s0)
ffffffc05040402c:	fdc42783          	lw	a5,-36(s0)
ffffffc050404030:	2781                	sext.w	a5,a5
ffffffc050404032:	0007d463          	bgez	a5,ffffffc05040403a <do_thread_create+0x2e>
ffffffc050404036:	57fd                	li	a5,-1
ffffffc050404038:	a661                	j	ffffffc0504043c0 <do_thread_create+0x3b4>
ffffffc05040403a:	b06fc0ef          	jal	ra,ffffffc050400340 <get_current_cpu_id>
ffffffc05040403e:	87aa                	mv	a5,a0
ffffffc050404040:	fcf42c23          	sw	a5,-40(s0)
ffffffc050404044:	0006f717          	auipc	a4,0x6f
ffffffc050404048:	e4c70713          	addi	a4,a4,-436 # ffffffc050472e90 <current_running>
ffffffc05040404c:	fd842783          	lw	a5,-40(s0)
ffffffc050404050:	078e                	slli	a5,a5,0x3
ffffffc050404052:	97ba                	add	a5,a5,a4
ffffffc050404054:	639c                	ld	a5,0(a5)
ffffffc050404056:	6b98                	ld	a4,16(a5)
ffffffc050404058:	0006f697          	auipc	a3,0x6f
ffffffc05040405c:	e6068693          	addi	a3,a3,-416 # ffffffc050472eb8 <pcb>
ffffffc050404060:	fdc42603          	lw	a2,-36(s0)
ffffffc050404064:	09800793          	li	a5,152
ffffffc050404068:	02f607b3          	mul	a5,a2,a5
ffffffc05040406c:	97b6                	add	a5,a5,a3
ffffffc05040406e:	eb98                	sd	a4,16(a5)
ffffffc050404070:	0006f717          	auipc	a4,0x6f
ffffffc050404074:	e4870713          	addi	a4,a4,-440 # ffffffc050472eb8 <pcb>
ffffffc050404078:	fdc42683          	lw	a3,-36(s0)
ffffffc05040407c:	09800793          	li	a5,152
ffffffc050404080:	02f687b3          	mul	a5,a3,a5
ffffffc050404084:	97ba                	add	a5,a5,a4
ffffffc050404086:	470d                	li	a4,3
ffffffc050404088:	cfb8                	sw	a4,88(a5)
ffffffc05040408a:	0006f717          	auipc	a4,0x6f
ffffffc05040408e:	e0670713          	addi	a4,a4,-506 # ffffffc050472e90 <current_running>
ffffffc050404092:	fd842783          	lw	a5,-40(s0)
ffffffc050404096:	078e                	slli	a5,a5,0x3
ffffffc050404098:	97ba                	add	a5,a5,a4
ffffffc05040409a:	639c                	ld	a5,0(a5)
ffffffc05040409c:	0887a703          	lw	a4,136(a5)
ffffffc0504040a0:	0006f697          	auipc	a3,0x6f
ffffffc0504040a4:	e1868693          	addi	a3,a3,-488 # ffffffc050472eb8 <pcb>
ffffffc0504040a8:	fdc42603          	lw	a2,-36(s0)
ffffffc0504040ac:	09800793          	li	a5,152
ffffffc0504040b0:	02f607b3          	mul	a5,a2,a5
ffffffc0504040b4:	97b6                	add	a5,a5,a3
ffffffc0504040b6:	08e7a423          	sw	a4,136(a5)
ffffffc0504040ba:	0006f717          	auipc	a4,0x6f
ffffffc0504040be:	dd670713          	addi	a4,a4,-554 # ffffffc050472e90 <current_running>
ffffffc0504040c2:	fd842783          	lw	a5,-40(s0)
ffffffc0504040c6:	078e                	slli	a5,a5,0x3
ffffffc0504040c8:	97ba                	add	a5,a5,a4
ffffffc0504040ca:	639c                	ld	a5,0(a5)
ffffffc0504040cc:	08c7a703          	lw	a4,140(a5)
ffffffc0504040d0:	0006f697          	auipc	a3,0x6f
ffffffc0504040d4:	de868693          	addi	a3,a3,-536 # ffffffc050472eb8 <pcb>
ffffffc0504040d8:	fdc42603          	lw	a2,-36(s0)
ffffffc0504040dc:	09800793          	li	a5,152
ffffffc0504040e0:	02f607b3          	mul	a5,a2,a5
ffffffc0504040e4:	97b6                	add	a5,a5,a3
ffffffc0504040e6:	08e7a623          	sw	a4,140(a5)
ffffffc0504040ea:	0006f717          	auipc	a4,0x6f
ffffffc0504040ee:	da670713          	addi	a4,a4,-602 # ffffffc050472e90 <current_running>
ffffffc0504040f2:	fd842783          	lw	a5,-40(s0)
ffffffc0504040f6:	078e                	slli	a5,a5,0x3
ffffffc0504040f8:	97ba                	add	a5,a5,a4
ffffffc0504040fa:	639c                	ld	a5,0(a5)
ffffffc0504040fc:	77b8                	ld	a4,104(a5)
ffffffc0504040fe:	0006f697          	auipc	a3,0x6f
ffffffc050404102:	dba68693          	addi	a3,a3,-582 # ffffffc050472eb8 <pcb>
ffffffc050404106:	fdc42603          	lw	a2,-36(s0)
ffffffc05040410a:	09800793          	li	a5,152
ffffffc05040410e:	02f607b3          	mul	a5,a2,a5
ffffffc050404112:	97b6                	add	a5,a5,a3
ffffffc050404114:	f7b8                	sd	a4,104(a5)
ffffffc050404116:	0006f717          	auipc	a4,0x6f
ffffffc05040411a:	d7a70713          	addi	a4,a4,-646 # ffffffc050472e90 <current_running>
ffffffc05040411e:	fd842783          	lw	a5,-40(s0)
ffffffc050404122:	078e                	slli	a5,a5,0x3
ffffffc050404124:	97ba                	add	a5,a5,a4
ffffffc050404126:	639c                	ld	a5,0(a5)
ffffffc050404128:	53b8                	lw	a4,96(a5)
ffffffc05040412a:	0006f697          	auipc	a3,0x6f
ffffffc05040412e:	d8e68693          	addi	a3,a3,-626 # ffffffc050472eb8 <pcb>
ffffffc050404132:	fdc42603          	lw	a2,-36(s0)
ffffffc050404136:	09800793          	li	a5,152
ffffffc05040413a:	02f607b3          	mul	a5,a2,a5
ffffffc05040413e:	97b6                	add	a5,a5,a3
ffffffc050404140:	d3b8                	sw	a4,96(a5)
ffffffc050404142:	0006f717          	auipc	a4,0x6f
ffffffc050404146:	d4e70713          	addi	a4,a4,-690 # ffffffc050472e90 <current_running>
ffffffc05040414a:	fd842783          	lw	a5,-40(s0)
ffffffc05040414e:	078e                	slli	a5,a5,0x3
ffffffc050404150:	97ba                	add	a5,a5,a4
ffffffc050404152:	639c                	ld	a5,0(a5)
ffffffc050404154:	4bf8                	lw	a4,84(a5)
ffffffc050404156:	0006f697          	auipc	a3,0x6f
ffffffc05040415a:	d6268693          	addi	a3,a3,-670 # ffffffc050472eb8 <pcb>
ffffffc05040415e:	fdc42603          	lw	a2,-36(s0)
ffffffc050404162:	09800793          	li	a5,152
ffffffc050404166:	02f607b3          	mul	a5,a2,a5
ffffffc05040416a:	97b6                	add	a5,a5,a3
ffffffc05040416c:	cbf8                	sw	a4,84(a5)
ffffffc05040416e:	000f07b7          	lui	a5,0xf0
ffffffc050404172:	0785                	addi	a5,a5,1
ffffffc050404174:	07c2                	slli	a5,a5,0x10
ffffffc050404176:	fcf43823          	sd	a5,-48(s0)
ffffffc05040417a:	fd043783          	ld	a5,-48(s0)
ffffffc05040417e:	83f9                	srli	a5,a5,0x1e
ffffffc050404180:	1ff7f793          	andi	a5,a5,511
ffffffc050404184:	fcf43423          	sd	a5,-56(s0)
ffffffc050404188:	fd043783          	ld	a5,-48(s0)
ffffffc05040418c:	83d5                	srli	a5,a5,0x15
ffffffc05040418e:	1ff7f793          	andi	a5,a5,511
ffffffc050404192:	fcf43023          	sd	a5,-64(s0)
ffffffc050404196:	fd043783          	ld	a5,-48(s0)
ffffffc05040419a:	83b1                	srli	a5,a5,0xc
ffffffc05040419c:	1ff7f793          	andi	a5,a5,511
ffffffc0504041a0:	faf43c23          	sd	a5,-72(s0)
ffffffc0504041a4:	0006f717          	auipc	a4,0x6f
ffffffc0504041a8:	cec70713          	addi	a4,a4,-788 # ffffffc050472e90 <current_running>
ffffffc0504041ac:	fd842783          	lw	a5,-40(s0)
ffffffc0504041b0:	078e                	slli	a5,a5,0x3
ffffffc0504041b2:	97ba                	add	a5,a5,a4
ffffffc0504041b4:	639c                	ld	a5,0(a5)
ffffffc0504041b6:	6bdc                	ld	a5,144(a5)
ffffffc0504041b8:	faf43823          	sd	a5,-80(s0)
ffffffc0504041bc:	fc843783          	ld	a5,-56(s0)
ffffffc0504041c0:	078e                	slli	a5,a5,0x3
ffffffc0504041c2:	fb043703          	ld	a4,-80(s0)
ffffffc0504041c6:	97ba                	add	a5,a5,a4
ffffffc0504041c8:	639c                	ld	a5,0(a5)
ffffffc0504041ca:	853e                	mv	a0,a5
ffffffc0504041cc:	e9cfe0ef          	jal	ra,ffffffc050402868 <get_pa>
ffffffc0504041d0:	87aa                	mv	a5,a0
ffffffc0504041d2:	853e                	mv	a0,a5
ffffffc0504041d4:	e78fe0ef          	jal	ra,ffffffc05040284c <pa2kva>
ffffffc0504041d8:	87aa                	mv	a5,a0
ffffffc0504041da:	faf43423          	sd	a5,-88(s0)
ffffffc0504041de:	fc043783          	ld	a5,-64(s0)
ffffffc0504041e2:	078e                	slli	a5,a5,0x3
ffffffc0504041e4:	fa843703          	ld	a4,-88(s0)
ffffffc0504041e8:	97ba                	add	a5,a5,a4
ffffffc0504041ea:	639c                	ld	a5,0(a5)
ffffffc0504041ec:	853e                	mv	a0,a5
ffffffc0504041ee:	e7afe0ef          	jal	ra,ffffffc050402868 <get_pa>
ffffffc0504041f2:	87aa                	mv	a5,a0
ffffffc0504041f4:	853e                	mv	a0,a5
ffffffc0504041f6:	e56fe0ef          	jal	ra,ffffffc05040284c <pa2kva>
ffffffc0504041fa:	87aa                	mv	a5,a0
ffffffc0504041fc:	faf43023          	sd	a5,-96(s0)
ffffffc050404200:	fb843783          	ld	a5,-72(s0)
ffffffc050404204:	078e                	slli	a5,a5,0x3
ffffffc050404206:	fa043703          	ld	a4,-96(s0)
ffffffc05040420a:	97ba                	add	a5,a5,a4
ffffffc05040420c:	853e                	mv	a0,a5
ffffffc05040420e:	1be010ef          	jal	ra,ffffffc0504053cc <alloc_ph_page>
ffffffc050404212:	f8a43c23          	sd	a0,-104(s0)
ffffffc050404216:	f9843783          	ld	a5,-104(s0)
ffffffc05040421a:	6605                	lui	a2,0x1
ffffffc05040421c:	4581                	li	a1,0
ffffffc05040421e:	853e                	mv	a0,a5
ffffffc050404220:	7e5010ef          	jal	ra,ffffffc050406204 <kmemset>
ffffffc050404224:	fb843783          	ld	a5,-72(s0)
ffffffc050404228:	078e                	slli	a5,a5,0x3
ffffffc05040422a:	fa043703          	ld	a4,-96(s0)
ffffffc05040422e:	00f704b3          	add	s1,a4,a5
ffffffc050404232:	f9843503          	ld	a0,-104(s0)
ffffffc050404236:	dfafe0ef          	jal	ra,ffffffc050402830 <kva2pa>
ffffffc05040423a:	87aa                	mv	a5,a0
ffffffc05040423c:	83b1                	srli	a5,a5,0xc
ffffffc05040423e:	85be                	mv	a1,a5
ffffffc050404240:	8526                	mv	a0,s1
ffffffc050404242:	f18fe0ef          	jal	ra,ffffffc05040295a <set_pfn>
ffffffc050404246:	fb843783          	ld	a5,-72(s0)
ffffffc05040424a:	078e                	slli	a5,a5,0x3
ffffffc05040424c:	fa043703          	ld	a4,-96(s0)
ffffffc050404250:	97ba                	add	a5,a5,a4
ffffffc050404252:	0df00593          	li	a1,223
ffffffc050404256:	853e                	mv	a0,a5
ffffffc050404258:	f3afe0ef          	jal	ra,ffffffc050402992 <set_attribute>
ffffffc05040425c:	d7cfe0ef          	jal	ra,ffffffc0504027d8 <local_flush_tlb_all>
ffffffc050404260:	0006f717          	auipc	a4,0x6f
ffffffc050404264:	c5870713          	addi	a4,a4,-936 # ffffffc050472eb8 <pcb>
ffffffc050404268:	fdc42683          	lw	a3,-36(s0)
ffffffc05040426c:	09800793          	li	a5,152
ffffffc050404270:	02f687b3          	mul	a5,a3,a5
ffffffc050404274:	97ba                	add	a5,a5,a4
ffffffc050404276:	fb043703          	ld	a4,-80(s0)
ffffffc05040427a:	ebd8                	sd	a4,144(a5)
ffffffc05040427c:	fd043703          	ld	a4,-48(s0)
ffffffc050404280:	6785                	lui	a5,0x1
ffffffc050404282:	f8078793          	addi	a5,a5,-128 # f80 <_start-0xffffffc0503ff080>
ffffffc050404286:	973e                	add	a4,a4,a5
ffffffc050404288:	0006f697          	auipc	a3,0x6f
ffffffc05040428c:	c3068693          	addi	a3,a3,-976 # ffffffc050472eb8 <pcb>
ffffffc050404290:	fdc42603          	lw	a2,-36(s0)
ffffffc050404294:	09800793          	li	a5,152
ffffffc050404298:	02f607b3          	mul	a5,a2,a5
ffffffc05040429c:	97b6                	add	a5,a5,a3
ffffffc05040429e:	e798                	sd	a4,8(a5)
ffffffc0504042a0:	fd043703          	ld	a4,-48(s0)
ffffffc0504042a4:	6785                	lui	a5,0x1
ffffffc0504042a6:	f8078793          	addi	a5,a5,-128 # f80 <_start-0xffffffc0503ff080>
ffffffc0504042aa:	973e                	add	a4,a4,a5
ffffffc0504042ac:	0006f697          	auipc	a3,0x6f
ffffffc0504042b0:	c0c68693          	addi	a3,a3,-1012 # ffffffc050472eb8 <pcb>
ffffffc0504042b4:	fdc42603          	lw	a2,-36(s0)
ffffffc0504042b8:	09800793          	li	a5,152
ffffffc0504042bc:	02f607b3          	mul	a5,a2,a5
ffffffc0504042c0:	97b6                	add	a5,a5,a3
ffffffc0504042c2:	e3d8                	sd	a4,128(a5)
ffffffc0504042c4:	f6043783          	ld	a5,-160(s0)
ffffffc0504042c8:	f8f43823          	sd	a5,-112(s0)
ffffffc0504042cc:	0006f717          	auipc	a4,0x6f
ffffffc0504042d0:	bec70713          	addi	a4,a4,-1044 # ffffffc050472eb8 <pcb>
ffffffc0504042d4:	fdc42683          	lw	a3,-36(s0)
ffffffc0504042d8:	09800793          	li	a5,152
ffffffc0504042dc:	02f687b3          	mul	a5,a3,a5
ffffffc0504042e0:	97ba                	add	a5,a5,a4
ffffffc0504042e2:	7fa8                	ld	a0,120(a5)
ffffffc0504042e4:	0006f717          	auipc	a4,0x6f
ffffffc0504042e8:	bd470713          	addi	a4,a4,-1068 # ffffffc050472eb8 <pcb>
ffffffc0504042ec:	fdc42683          	lw	a3,-36(s0)
ffffffc0504042f0:	09800793          	li	a5,152
ffffffc0504042f4:	02f687b3          	mul	a5,a3,a5
ffffffc0504042f8:	97ba                	add	a5,a5,a4
ffffffc0504042fa:	63cc                	ld	a1,128(a5)
ffffffc0504042fc:	fdc42703          	lw	a4,-36(s0)
ffffffc050404300:	09800793          	li	a5,152
ffffffc050404304:	02f70733          	mul	a4,a4,a5
ffffffc050404308:	0006f797          	auipc	a5,0x6f
ffffffc05040430c:	bb078793          	addi	a5,a5,-1104 # ffffffc050472eb8 <pcb>
ffffffc050404310:	97ba                	add	a5,a5,a4
ffffffc050404312:	86be                	mv	a3,a5
ffffffc050404314:	f9043603          	ld	a2,-112(s0)
ffffffc050404318:	bb8fc0ef          	jal	ra,ffffffc0504006d0 <init_pcb_stack>
ffffffc05040431c:	0006f717          	auipc	a4,0x6f
ffffffc050404320:	b7470713          	addi	a4,a4,-1164 # ffffffc050472e90 <current_running>
ffffffc050404324:	fd842783          	lw	a5,-40(s0)
ffffffc050404328:	078e                	slli	a5,a5,0x3
ffffffc05040432a:	97ba                	add	a5,a5,a4
ffffffc05040432c:	639c                	ld	a5,0(a5)
ffffffc05040432e:	7fbc                	ld	a5,120(a5)
ffffffc050404330:	ee078793          	addi	a5,a5,-288
ffffffc050404334:	f8f43423          	sd	a5,-120(s0)
ffffffc050404338:	0006f717          	auipc	a4,0x6f
ffffffc05040433c:	b8070713          	addi	a4,a4,-1152 # ffffffc050472eb8 <pcb>
ffffffc050404340:	fdc42683          	lw	a3,-36(s0)
ffffffc050404344:	09800793          	li	a5,152
ffffffc050404348:	02f687b3          	mul	a5,a3,a5
ffffffc05040434c:	97ba                	add	a5,a5,a4
ffffffc05040434e:	7fbc                	ld	a5,120(a5)
ffffffc050404350:	ee078793          	addi	a5,a5,-288
ffffffc050404354:	f8f43023          	sd	a5,-128(s0)
ffffffc050404358:	f8843783          	ld	a5,-120(s0)
ffffffc05040435c:	f6f43c23          	sd	a5,-136(s0)
ffffffc050404360:	f8043783          	ld	a5,-128(s0)
ffffffc050404364:	f6f43823          	sd	a5,-144(s0)
ffffffc050404368:	f7043783          	ld	a5,-144(s0)
ffffffc05040436c:	07e1                	addi	a5,a5,24
ffffffc05040436e:	f7843703          	ld	a4,-136(s0)
ffffffc050404372:	6f18                	ld	a4,24(a4)
ffffffc050404374:	e398                	sd	a4,0(a5)
ffffffc050404376:	f7043783          	ld	a5,-144(s0)
ffffffc05040437a:	05078793          	addi	a5,a5,80
ffffffc05040437e:	f5843703          	ld	a4,-168(s0)
ffffffc050404382:	e398                	sd	a4,0(a5)
ffffffc050404384:	0006f717          	auipc	a4,0x6f
ffffffc050404388:	b3470713          	addi	a4,a4,-1228 # ffffffc050472eb8 <pcb>
ffffffc05040438c:	fdc42683          	lw	a3,-36(s0)
ffffffc050404390:	09800793          	li	a5,152
ffffffc050404394:	02f687b3          	mul	a5,a3,a5
ffffffc050404398:	97ba                	add	a5,a5,a4
ffffffc05040439a:	4bb8                	lw	a4,80(a5)
ffffffc05040439c:	f6843783          	ld	a5,-152(s0)
ffffffc0504043a0:	c398                	sw	a4,0(a5)
ffffffc0504043a2:	fdc42783          	lw	a5,-36(s0)
ffffffc0504043a6:	853e                	mv	a0,a5
ffffffc0504043a8:	dc5fe0ef          	jal	ra,ffffffc05040316c <set_pcb_ready>
ffffffc0504043ac:	81818793          	addi	a5,gp,-2024 # ffffffc05045f8d0 <process_id>
ffffffc0504043b0:	439c                	lw	a5,0(a5)
ffffffc0504043b2:	0017871b          	addiw	a4,a5,1
ffffffc0504043b6:	0007069b          	sext.w	a3,a4
ffffffc0504043ba:	81818713          	addi	a4,gp,-2024 # ffffffc05045f8d0 <process_id>
ffffffc0504043be:	c314                	sw	a3,0(a4)
ffffffc0504043c0:	853e                	mv	a0,a5
ffffffc0504043c2:	70aa                	ld	ra,168(sp)
ffffffc0504043c4:	740a                	ld	s0,160(sp)
ffffffc0504043c6:	64ea                	ld	s1,152(sp)
ffffffc0504043c8:	614d                	addi	sp,sp,176
ffffffc0504043ca:	8082                	ret

ffffffc0504043cc <get_ticks>:
ffffffc0504043cc:	1141                	addi	sp,sp,-16
ffffffc0504043ce:	e422                	sd	s0,8(sp)
ffffffc0504043d0:	0800                	addi	s0,sp,16
ffffffc0504043d2:	c0102773          	rdtime	a4
ffffffc0504043d6:	88018793          	addi	a5,gp,-1920 # ffffffc05045f938 <time_elapsed>
ffffffc0504043da:	e398                	sd	a4,0(a5)
ffffffc0504043dc:	88018793          	addi	a5,gp,-1920 # ffffffc05045f938 <time_elapsed>
ffffffc0504043e0:	639c                	ld	a5,0(a5)
ffffffc0504043e2:	853e                	mv	a0,a5
ffffffc0504043e4:	6422                	ld	s0,8(sp)
ffffffc0504043e6:	0141                	addi	sp,sp,16
ffffffc0504043e8:	8082                	ret

ffffffc0504043ea <get_timer>:
ffffffc0504043ea:	1141                	addi	sp,sp,-16
ffffffc0504043ec:	e406                	sd	ra,8(sp)
ffffffc0504043ee:	e022                	sd	s0,0(sp)
ffffffc0504043f0:	0800                	addi	s0,sp,16
ffffffc0504043f2:	fdbff0ef          	jal	ra,ffffffc0504043cc <get_ticks>
ffffffc0504043f6:	872a                	mv	a4,a0
ffffffc0504043f8:	88818793          	addi	a5,gp,-1912 # ffffffc05045f940 <time_base>
ffffffc0504043fc:	439c                	lw	a5,0(a5)
ffffffc0504043fe:	1782                	slli	a5,a5,0x20
ffffffc050404400:	9381                	srli	a5,a5,0x20
ffffffc050404402:	02f757b3          	divu	a5,a4,a5
ffffffc050404406:	853e                	mv	a0,a5
ffffffc050404408:	60a2                	ld	ra,8(sp)
ffffffc05040440a:	6402                	ld	s0,0(sp)
ffffffc05040440c:	0141                	addi	sp,sp,16
ffffffc05040440e:	8082                	ret

ffffffc050404410 <get_time_base>:
ffffffc050404410:	1141                	addi	sp,sp,-16
ffffffc050404412:	e422                	sd	s0,8(sp)
ffffffc050404414:	0800                	addi	s0,sp,16
ffffffc050404416:	88818793          	addi	a5,gp,-1912 # ffffffc05045f940 <time_base>
ffffffc05040441a:	439c                	lw	a5,0(a5)
ffffffc05040441c:	1782                	slli	a5,a5,0x20
ffffffc05040441e:	9381                	srli	a5,a5,0x20
ffffffc050404420:	853e                	mv	a0,a5
ffffffc050404422:	6422                	ld	s0,8(sp)
ffffffc050404424:	0141                	addi	sp,sp,16
ffffffc050404426:	8082                	ret

ffffffc050404428 <latency>:
ffffffc050404428:	7179                	addi	sp,sp,-48
ffffffc05040442a:	f406                	sd	ra,40(sp)
ffffffc05040442c:	f022                	sd	s0,32(sp)
ffffffc05040442e:	1800                	addi	s0,sp,48
ffffffc050404430:	fca43c23          	sd	a0,-40(s0)
ffffffc050404434:	fb7ff0ef          	jal	ra,ffffffc0504043ea <get_timer>
ffffffc050404438:	fea43423          	sd	a0,-24(s0)
ffffffc05040443c:	0001                	nop
ffffffc05040443e:	fadff0ef          	jal	ra,ffffffc0504043ea <get_timer>
ffffffc050404442:	872a                	mv	a4,a0
ffffffc050404444:	fe843783          	ld	a5,-24(s0)
ffffffc050404448:	40f707b3          	sub	a5,a4,a5
ffffffc05040444c:	fd843703          	ld	a4,-40(s0)
ffffffc050404450:	fee7e7e3          	bltu	a5,a4,ffffffc05040443e <latency+0x16>
ffffffc050404454:	0001                	nop
ffffffc050404456:	70a2                	ld	ra,40(sp)
ffffffc050404458:	7402                	ld	s0,32(sp)
ffffffc05040445a:	6145                	addi	sp,sp,48
ffffffc05040445c:	8082                	ret

ffffffc05040445e <get_walltime>:
ffffffc05040445e:	1101                	addi	sp,sp,-32
ffffffc050404460:	ec06                	sd	ra,24(sp)
ffffffc050404462:	e822                	sd	s0,16(sp)
ffffffc050404464:	1000                	addi	s0,sp,32
ffffffc050404466:	fea43423          	sd	a0,-24(s0)
ffffffc05040446a:	f63ff0ef          	jal	ra,ffffffc0504043cc <get_ticks>
ffffffc05040446e:	87aa                	mv	a5,a0
ffffffc050404470:	0007871b          	sext.w	a4,a5
ffffffc050404474:	fe843783          	ld	a5,-24(s0)
ffffffc050404478:	c398                	sw	a4,0(a5)
ffffffc05040447a:	88818793          	addi	a5,gp,-1912 # ffffffc05045f940 <time_base>
ffffffc05040447e:	439c                	lw	a5,0(a5)
ffffffc050404480:	853e                	mv	a0,a5
ffffffc050404482:	60e2                	ld	ra,24(sp)
ffffffc050404484:	6442                	ld	s0,16(sp)
ffffffc050404486:	6105                	addi	sp,sp,32
ffffffc050404488:	8082                	ret

ffffffc05040448a <sbi_send_ipi>:
ffffffc05040448a:	1101                	addi	sp,sp,-32
ffffffc05040448c:	ec22                	sd	s0,24(sp)
ffffffc05040448e:	1000                	addi	s0,sp,32
ffffffc050404490:	fea43423          	sd	a0,-24(s0)
ffffffc050404494:	fe843783          	ld	a5,-24(s0)
ffffffc050404498:	853e                	mv	a0,a5
ffffffc05040449a:	4581                	li	a1,0
ffffffc05040449c:	4601                	li	a2,0
ffffffc05040449e:	4891                	li	a7,4
ffffffc0504044a0:	00000073          	ecall
ffffffc0504044a4:	0001                	nop
ffffffc0504044a6:	6462                	ld	s0,24(sp)
ffffffc0504044a8:	6105                	addi	sp,sp,32
ffffffc0504044aa:	8082                	ret

ffffffc0504044ac <smp_init>:
ffffffc0504044ac:	1141                	addi	sp,sp,-16
ffffffc0504044ae:	e422                	sd	s0,8(sp)
ffffffc0504044b0:	0800                	addi	s0,sp,16
ffffffc0504044b2:	0001                	nop
ffffffc0504044b4:	6422                	ld	s0,8(sp)
ffffffc0504044b6:	0141                	addi	sp,sp,16
ffffffc0504044b8:	8082                	ret

ffffffc0504044ba <wakeup_other_hart>:
ffffffc0504044ba:	1141                	addi	sp,sp,-16
ffffffc0504044bc:	e406                	sd	ra,8(sp)
ffffffc0504044be:	e022                	sd	s0,0(sp)
ffffffc0504044c0:	0800                	addi	s0,sp,16
ffffffc0504044c2:	4501                	li	a0,0
ffffffc0504044c4:	fc7ff0ef          	jal	ra,ffffffc05040448a <sbi_send_ipi>
ffffffc0504044c8:	0001                	nop
ffffffc0504044ca:	60a2                	ld	ra,8(sp)
ffffffc0504044cc:	6402                	ld	s0,0(sp)
ffffffc0504044ce:	0141                	addi	sp,sp,16
ffffffc0504044d0:	8082                	ret

ffffffc0504044d2 <lock_kernel>:
ffffffc0504044d2:	1141                	addi	sp,sp,-16
ffffffc0504044d4:	e406                	sd	ra,8(sp)
ffffffc0504044d6:	e022                	sd	s0,0(sp)
ffffffc0504044d8:	0800                	addi	s0,sp,16
ffffffc0504044da:	00065517          	auipc	a0,0x65
ffffffc0504044de:	41650513          	addi	a0,a0,1046 # ffffffc0504698f0 <kernel_lock>
ffffffc0504044e2:	962fe0ef          	jal	ra,ffffffc050402644 <spin_lock_acquire>
ffffffc0504044e6:	0001                	nop
ffffffc0504044e8:	60a2                	ld	ra,8(sp)
ffffffc0504044ea:	6402                	ld	s0,0(sp)
ffffffc0504044ec:	0141                	addi	sp,sp,16
ffffffc0504044ee:	8082                	ret

ffffffc0504044f0 <unlock_kernel>:
ffffffc0504044f0:	1141                	addi	sp,sp,-16
ffffffc0504044f2:	e406                	sd	ra,8(sp)
ffffffc0504044f4:	e022                	sd	s0,0(sp)
ffffffc0504044f6:	0800                	addi	s0,sp,16
ffffffc0504044f8:	00065517          	auipc	a0,0x65
ffffffc0504044fc:	3f850513          	addi	a0,a0,1016 # ffffffc0504698f0 <kernel_lock>
ffffffc050404500:	978fe0ef          	jal	ra,ffffffc050402678 <spin_lock_release>
ffffffc050404504:	0001                	nop
ffffffc050404506:	60a2                	ld	ra,8(sp)
ffffffc050404508:	6402                	ld	s0,0(sp)
ffffffc05040450a:	0141                	addi	sp,sp,16
ffffffc05040450c:	8082                	ret

ffffffc05040450e <do_barrier_init>:
ffffffc05040450e:	7179                	addi	sp,sp,-48
ffffffc050404510:	f422                	sd	s0,40(sp)
ffffffc050404512:	1800                	addi	s0,sp,48
ffffffc050404514:	fea43423          	sd	a0,-24(s0)
ffffffc050404518:	87ae                	mv	a5,a1
ffffffc05040451a:	fcc43c23          	sd	a2,-40(s0)
ffffffc05040451e:	fef42223          	sw	a5,-28(s0)
ffffffc050404522:	88c18793          	addi	a5,gp,-1908 # ffffffc05045f944 <barrier_num>
ffffffc050404526:	439c                	lw	a5,0(a5)
ffffffc050404528:	00065717          	auipc	a4,0x65
ffffffc05040452c:	2c870713          	addi	a4,a4,712 # ffffffc0504697f0 <barrier_array>
ffffffc050404530:	0796                	slli	a5,a5,0x5
ffffffc050404532:	97ba                	add	a5,a5,a4
ffffffc050404534:	4705                	li	a4,1
ffffffc050404536:	c398                	sw	a4,0(a5)
ffffffc050404538:	88c18793          	addi	a5,gp,-1908 # ffffffc05045f944 <barrier_num>
ffffffc05040453c:	439c                	lw	a5,0(a5)
ffffffc05040453e:	fe442703          	lw	a4,-28(s0)
ffffffc050404542:	00065697          	auipc	a3,0x65
ffffffc050404546:	2ae68693          	addi	a3,a3,686 # ffffffc0504697f0 <barrier_array>
ffffffc05040454a:	0796                	slli	a5,a5,0x5
ffffffc05040454c:	97b6                	add	a5,a5,a3
ffffffc05040454e:	c3d8                	sw	a4,4(a5)
ffffffc050404550:	88c18793          	addi	a5,gp,-1908 # ffffffc05045f944 <barrier_num>
ffffffc050404554:	439c                	lw	a5,0(a5)
ffffffc050404556:	00065717          	auipc	a4,0x65
ffffffc05040455a:	29a70713          	addi	a4,a4,666 # ffffffc0504697f0 <barrier_array>
ffffffc05040455e:	0796                	slli	a5,a5,0x5
ffffffc050404560:	97ba                	add	a5,a5,a4
ffffffc050404562:	0007b823          	sd	zero,16(a5)
ffffffc050404566:	88c18793          	addi	a5,gp,-1908 # ffffffc05045f944 <barrier_num>
ffffffc05040456a:	439c                	lw	a5,0(a5)
ffffffc05040456c:	00065717          	auipc	a4,0x65
ffffffc050404570:	28470713          	addi	a4,a4,644 # ffffffc0504697f0 <barrier_array>
ffffffc050404574:	0796                	slli	a5,a5,0x5
ffffffc050404576:	97ba                	add	a5,a5,a4
ffffffc050404578:	0007bc23          	sd	zero,24(a5)
ffffffc05040457c:	88c18793          	addi	a5,gp,-1908 # ffffffc05045f944 <barrier_num>
ffffffc050404580:	439c                	lw	a5,0(a5)
ffffffc050404582:	00065717          	auipc	a4,0x65
ffffffc050404586:	26e70713          	addi	a4,a4,622 # ffffffc0504697f0 <barrier_array>
ffffffc05040458a:	0796                	slli	a5,a5,0x5
ffffffc05040458c:	97ba                	add	a5,a5,a4
ffffffc05040458e:	0007a423          	sw	zero,8(a5)
ffffffc050404592:	fd843783          	ld	a5,-40(s0)
ffffffc050404596:	4705                	li	a4,1
ffffffc050404598:	c398                	sw	a4,0(a5)
ffffffc05040459a:	88c18793          	addi	a5,gp,-1908 # ffffffc05045f944 <barrier_num>
ffffffc05040459e:	439c                	lw	a5,0(a5)
ffffffc0504045a0:	0017871b          	addiw	a4,a5,1
ffffffc0504045a4:	0007069b          	sext.w	a3,a4
ffffffc0504045a8:	88c18713          	addi	a4,gp,-1908 # ffffffc05045f944 <barrier_num>
ffffffc0504045ac:	c314                	sw	a3,0(a4)
ffffffc0504045ae:	853e                	mv	a0,a5
ffffffc0504045b0:	7422                	ld	s0,40(sp)
ffffffc0504045b2:	6145                	addi	sp,sp,48
ffffffc0504045b4:	8082                	ret

ffffffc0504045b6 <do_barrier_wait>:
ffffffc0504045b6:	7179                	addi	sp,sp,-48
ffffffc0504045b8:	f406                	sd	ra,40(sp)
ffffffc0504045ba:	f022                	sd	s0,32(sp)
ffffffc0504045bc:	1800                	addi	s0,sp,48
ffffffc0504045be:	87aa                	mv	a5,a0
ffffffc0504045c0:	fcf42e23          	sw	a5,-36(s0)
ffffffc0504045c4:	d7dfb0ef          	jal	ra,ffffffc050400340 <get_current_cpu_id>
ffffffc0504045c8:	87aa                	mv	a5,a0
ffffffc0504045ca:	fef42623          	sw	a5,-20(s0)
ffffffc0504045ce:	00065717          	auipc	a4,0x65
ffffffc0504045d2:	22270713          	addi	a4,a4,546 # ffffffc0504697f0 <barrier_array>
ffffffc0504045d6:	fdc42783          	lw	a5,-36(s0)
ffffffc0504045da:	0796                	slli	a5,a5,0x5
ffffffc0504045dc:	97ba                	add	a5,a5,a4
ffffffc0504045de:	4794                	lw	a3,8(a5)
ffffffc0504045e0:	00065717          	auipc	a4,0x65
ffffffc0504045e4:	21070713          	addi	a4,a4,528 # ffffffc0504697f0 <barrier_array>
ffffffc0504045e8:	fdc42783          	lw	a5,-36(s0)
ffffffc0504045ec:	0796                	slli	a5,a5,0x5
ffffffc0504045ee:	97ba                	add	a5,a5,a4
ffffffc0504045f0:	43dc                	lw	a5,4(a5)
ffffffc0504045f2:	37fd                	addiw	a5,a5,-1
ffffffc0504045f4:	2781                	sext.w	a5,a5
ffffffc0504045f6:	8736                	mv	a4,a3
ffffffc0504045f8:	02f74063          	blt	a4,a5,ffffffc050404618 <do_barrier_wait+0x62>
ffffffc0504045fc:	fdc42783          	lw	a5,-36(s0)
ffffffc050404600:	00579713          	slli	a4,a5,0x5
ffffffc050404604:	00065797          	auipc	a5,0x65
ffffffc050404608:	1ec78793          	addi	a5,a5,492 # ffffffc0504697f0 <barrier_array>
ffffffc05040460c:	97ba                	add	a5,a5,a4
ffffffc05040460e:	07a1                	addi	a5,a5,8
ffffffc050404610:	853e                	mv	a0,a5
ffffffc050404612:	d53fe0ef          	jal	ra,ffffffc050403364 <release_wait_list>
ffffffc050404616:	a8bd                	j	ffffffc050404694 <do_barrier_wait+0xde>
ffffffc050404618:	0006f717          	auipc	a4,0x6f
ffffffc05040461c:	87870713          	addi	a4,a4,-1928 # ffffffc050472e90 <current_running>
ffffffc050404620:	fec42783          	lw	a5,-20(s0)
ffffffc050404624:	078e                	slli	a5,a5,0x3
ffffffc050404626:	97ba                	add	a5,a5,a4
ffffffc050404628:	639c                	ld	a5,0(a5)
ffffffc05040462a:	4705                	li	a4,1
ffffffc05040462c:	cff8                	sw	a4,92(a5)
ffffffc05040462e:	0006f717          	auipc	a4,0x6f
ffffffc050404632:	86270713          	addi	a4,a4,-1950 # ffffffc050472e90 <current_running>
ffffffc050404636:	fec42783          	lw	a5,-20(s0)
ffffffc05040463a:	078e                	slli	a5,a5,0x3
ffffffc05040463c:	97ba                	add	a5,a5,a4
ffffffc05040463e:	639c                	ld	a5,0(a5)
ffffffc050404640:	fdc42703          	lw	a4,-36(s0)
ffffffc050404644:	00571693          	slli	a3,a4,0x5
ffffffc050404648:	00065717          	auipc	a4,0x65
ffffffc05040464c:	1a870713          	addi	a4,a4,424 # ffffffc0504697f0 <barrier_array>
ffffffc050404650:	9736                	add	a4,a4,a3
ffffffc050404652:	0721                	addi	a4,a4,8
ffffffc050404654:	e7b8                	sd	a4,72(a5)
ffffffc050404656:	0006f717          	auipc	a4,0x6f
ffffffc05040465a:	83a70713          	addi	a4,a4,-1990 # ffffffc050472e90 <current_running>
ffffffc05040465e:	fec42783          	lw	a5,-20(s0)
ffffffc050404662:	078e                	slli	a5,a5,0x3
ffffffc050404664:	97ba                	add	a5,a5,a4
ffffffc050404666:	639c                	ld	a5,0(a5)
ffffffc050404668:	01878693          	addi	a3,a5,24
ffffffc05040466c:	fdc42783          	lw	a5,-36(s0)
ffffffc050404670:	00579713          	slli	a4,a5,0x5
ffffffc050404674:	00065797          	auipc	a5,0x65
ffffffc050404678:	17c78793          	addi	a5,a5,380 # ffffffc0504697f0 <barrier_array>
ffffffc05040467c:	97ba                	add	a5,a5,a4
ffffffc05040467e:	07a1                	addi	a5,a5,8
ffffffc050404680:	0006e617          	auipc	a2,0x6e
ffffffc050404684:	7f860613          	addi	a2,a2,2040 # ffffffc050472e78 <ready_queue>
ffffffc050404688:	85be                	mv	a1,a5
ffffffc05040468a:	8536                	mv	a0,a3
ffffffc05040468c:	98ffe0ef          	jal	ra,ffffffc05040301a <move_node>
ffffffc050404690:	d5efe0ef          	jal	ra,ffffffc050402bee <do_scheduler>
ffffffc050404694:	4781                	li	a5,0
ffffffc050404696:	853e                	mv	a0,a5
ffffffc050404698:	70a2                	ld	ra,40(sp)
ffffffc05040469a:	7402                	ld	s0,32(sp)
ffffffc05040469c:	6145                	addi	sp,sp,48
ffffffc05040469e:	8082                	ret

ffffffc0504046a0 <do_barrier_destroy>:
ffffffc0504046a0:	1101                	addi	sp,sp,-32
ffffffc0504046a2:	ec22                	sd	s0,24(sp)
ffffffc0504046a4:	1000                	addi	s0,sp,32
ffffffc0504046a6:	87aa                	mv	a5,a0
ffffffc0504046a8:	feb43023          	sd	a1,-32(s0)
ffffffc0504046ac:	fef42623          	sw	a5,-20(s0)
ffffffc0504046b0:	00065717          	auipc	a4,0x65
ffffffc0504046b4:	14070713          	addi	a4,a4,320 # ffffffc0504697f0 <barrier_array>
ffffffc0504046b8:	fec42783          	lw	a5,-20(s0)
ffffffc0504046bc:	0796                	slli	a5,a5,0x5
ffffffc0504046be:	97ba                	add	a5,a5,a4
ffffffc0504046c0:	0007a223          	sw	zero,4(a5)
ffffffc0504046c4:	00065717          	auipc	a4,0x65
ffffffc0504046c8:	12c70713          	addi	a4,a4,300 # ffffffc0504697f0 <barrier_array>
ffffffc0504046cc:	fec42783          	lw	a5,-20(s0)
ffffffc0504046d0:	0796                	slli	a5,a5,0x5
ffffffc0504046d2:	97ba                	add	a5,a5,a4
ffffffc0504046d4:	0007a023          	sw	zero,0(a5)
ffffffc0504046d8:	fe043783          	ld	a5,-32(s0)
ffffffc0504046dc:	0007a023          	sw	zero,0(a5)
ffffffc0504046e0:	4781                	li	a5,0
ffffffc0504046e2:	853e                	mv	a0,a5
ffffffc0504046e4:	6462                	ld	s0,24(sp)
ffffffc0504046e6:	6105                	addi	sp,sp,32
ffffffc0504046e8:	8082                	ret

ffffffc0504046ea <do_semaphore_init>:
ffffffc0504046ea:	7179                	addi	sp,sp,-48
ffffffc0504046ec:	f422                	sd	s0,40(sp)
ffffffc0504046ee:	1800                	addi	s0,sp,48
ffffffc0504046f0:	fea43423          	sd	a0,-24(s0)
ffffffc0504046f4:	87ae                	mv	a5,a1
ffffffc0504046f6:	fcc43c23          	sd	a2,-40(s0)
ffffffc0504046fa:	fef42223          	sw	a5,-28(s0)
ffffffc0504046fe:	89018793          	addi	a5,gp,-1904 # ffffffc05045f948 <semaphore_num>
ffffffc050404702:	439c                	lw	a5,0(a5)
ffffffc050404704:	0005d717          	auipc	a4,0x5d
ffffffc050404708:	18c70713          	addi	a4,a4,396 # ffffffc050461890 <semaphore_array>
ffffffc05040470c:	0796                	slli	a5,a5,0x5
ffffffc05040470e:	97ba                	add	a5,a5,a4
ffffffc050404710:	4705                	li	a4,1
ffffffc050404712:	c398                	sw	a4,0(a5)
ffffffc050404714:	89018793          	addi	a5,gp,-1904 # ffffffc05045f948 <semaphore_num>
ffffffc050404718:	439c                	lw	a5,0(a5)
ffffffc05040471a:	0005d717          	auipc	a4,0x5d
ffffffc05040471e:	17670713          	addi	a4,a4,374 # ffffffc050461890 <semaphore_array>
ffffffc050404722:	0796                	slli	a5,a5,0x5
ffffffc050404724:	97ba                	add	a5,a5,a4
ffffffc050404726:	fe442703          	lw	a4,-28(s0)
ffffffc05040472a:	c3d8                	sw	a4,4(a5)
ffffffc05040472c:	89018793          	addi	a5,gp,-1904 # ffffffc05045f948 <semaphore_num>
ffffffc050404730:	439c                	lw	a5,0(a5)
ffffffc050404732:	0005d717          	auipc	a4,0x5d
ffffffc050404736:	15e70713          	addi	a4,a4,350 # ffffffc050461890 <semaphore_array>
ffffffc05040473a:	0796                	slli	a5,a5,0x5
ffffffc05040473c:	97ba                	add	a5,a5,a4
ffffffc05040473e:	0007b823          	sd	zero,16(a5)
ffffffc050404742:	89018793          	addi	a5,gp,-1904 # ffffffc05045f948 <semaphore_num>
ffffffc050404746:	439c                	lw	a5,0(a5)
ffffffc050404748:	0005d717          	auipc	a4,0x5d
ffffffc05040474c:	14870713          	addi	a4,a4,328 # ffffffc050461890 <semaphore_array>
ffffffc050404750:	0796                	slli	a5,a5,0x5
ffffffc050404752:	97ba                	add	a5,a5,a4
ffffffc050404754:	0007bc23          	sd	zero,24(a5)
ffffffc050404758:	89018793          	addi	a5,gp,-1904 # ffffffc05045f948 <semaphore_num>
ffffffc05040475c:	439c                	lw	a5,0(a5)
ffffffc05040475e:	0005d717          	auipc	a4,0x5d
ffffffc050404762:	13270713          	addi	a4,a4,306 # ffffffc050461890 <semaphore_array>
ffffffc050404766:	0796                	slli	a5,a5,0x5
ffffffc050404768:	97ba                	add	a5,a5,a4
ffffffc05040476a:	0007a423          	sw	zero,8(a5)
ffffffc05040476e:	fd843783          	ld	a5,-40(s0)
ffffffc050404772:	4705                	li	a4,1
ffffffc050404774:	c398                	sw	a4,0(a5)
ffffffc050404776:	89018793          	addi	a5,gp,-1904 # ffffffc05045f948 <semaphore_num>
ffffffc05040477a:	439c                	lw	a5,0(a5)
ffffffc05040477c:	0017871b          	addiw	a4,a5,1
ffffffc050404780:	0007069b          	sext.w	a3,a4
ffffffc050404784:	89018713          	addi	a4,gp,-1904 # ffffffc05045f948 <semaphore_num>
ffffffc050404788:	c314                	sw	a3,0(a4)
ffffffc05040478a:	853e                	mv	a0,a5
ffffffc05040478c:	7422                	ld	s0,40(sp)
ffffffc05040478e:	6145                	addi	sp,sp,48
ffffffc050404790:	8082                	ret

ffffffc050404792 <do_semaphore_up>:
ffffffc050404792:	7179                	addi	sp,sp,-48
ffffffc050404794:	f406                	sd	ra,40(sp)
ffffffc050404796:	f022                	sd	s0,32(sp)
ffffffc050404798:	1800                	addi	s0,sp,48
ffffffc05040479a:	87aa                	mv	a5,a0
ffffffc05040479c:	fcf42e23          	sw	a5,-36(s0)
ffffffc0504047a0:	fdc42783          	lw	a5,-36(s0)
ffffffc0504047a4:	00579713          	slli	a4,a5,0x5
ffffffc0504047a8:	0005d797          	auipc	a5,0x5d
ffffffc0504047ac:	0e878793          	addi	a5,a5,232 # ffffffc050461890 <semaphore_array>
ffffffc0504047b0:	97ba                	add	a5,a5,a4
ffffffc0504047b2:	07a1                	addi	a5,a5,8
ffffffc0504047b4:	fef43423          	sd	a5,-24(s0)
ffffffc0504047b8:	fe843783          	ld	a5,-24(s0)
ffffffc0504047bc:	439c                	lw	a5,0(a5)
ffffffc0504047be:	06f05063          	blez	a5,ffffffc05040481e <do_semaphore_up+0x8c>
ffffffc0504047c2:	fe843783          	ld	a5,-24(s0)
ffffffc0504047c6:	679c                	ld	a5,8(a5)
ffffffc0504047c8:	4394                	lw	a3,0(a5)
ffffffc0504047ca:	0006e717          	auipc	a4,0x6e
ffffffc0504047ce:	6ee70713          	addi	a4,a4,1774 # ffffffc050472eb8 <pcb>
ffffffc0504047d2:	09800793          	li	a5,152
ffffffc0504047d6:	02f687b3          	mul	a5,a3,a5
ffffffc0504047da:	97ba                	add	a5,a5,a4
ffffffc0504047dc:	470d                	li	a4,3
ffffffc0504047de:	cff8                	sw	a4,92(a5)
ffffffc0504047e0:	fe843783          	ld	a5,-24(s0)
ffffffc0504047e4:	679c                	ld	a5,8(a5)
ffffffc0504047e6:	4394                	lw	a3,0(a5)
ffffffc0504047e8:	0006e717          	auipc	a4,0x6e
ffffffc0504047ec:	6d070713          	addi	a4,a4,1744 # ffffffc050472eb8 <pcb>
ffffffc0504047f0:	09800793          	li	a5,152
ffffffc0504047f4:	02f687b3          	mul	a5,a3,a5
ffffffc0504047f8:	97ba                	add	a5,a5,a4
ffffffc0504047fa:	0006e717          	auipc	a4,0x6e
ffffffc0504047fe:	67e70713          	addi	a4,a4,1662 # ffffffc050472e78 <ready_queue>
ffffffc050404802:	e7b8                	sd	a4,72(a5)
ffffffc050404804:	fe843783          	ld	a5,-24(s0)
ffffffc050404808:	679c                	ld	a5,8(a5)
ffffffc05040480a:	fe843603          	ld	a2,-24(s0)
ffffffc05040480e:	0006e597          	auipc	a1,0x6e
ffffffc050404812:	66a58593          	addi	a1,a1,1642 # ffffffc050472e78 <ready_queue>
ffffffc050404816:	853e                	mv	a0,a5
ffffffc050404818:	803fe0ef          	jal	ra,ffffffc05040301a <move_node>
ffffffc05040481c:	a035                	j	ffffffc050404848 <do_semaphore_up+0xb6>
ffffffc05040481e:	0005d717          	auipc	a4,0x5d
ffffffc050404822:	07270713          	addi	a4,a4,114 # ffffffc050461890 <semaphore_array>
ffffffc050404826:	fdc42783          	lw	a5,-36(s0)
ffffffc05040482a:	0796                	slli	a5,a5,0x5
ffffffc05040482c:	97ba                	add	a5,a5,a4
ffffffc05040482e:	43dc                	lw	a5,4(a5)
ffffffc050404830:	2785                	addiw	a5,a5,1
ffffffc050404832:	0007871b          	sext.w	a4,a5
ffffffc050404836:	0005d697          	auipc	a3,0x5d
ffffffc05040483a:	05a68693          	addi	a3,a3,90 # ffffffc050461890 <semaphore_array>
ffffffc05040483e:	fdc42783          	lw	a5,-36(s0)
ffffffc050404842:	0796                	slli	a5,a5,0x5
ffffffc050404844:	97b6                	add	a5,a5,a3
ffffffc050404846:	c3d8                	sw	a4,4(a5)
ffffffc050404848:	4781                	li	a5,0
ffffffc05040484a:	853e                	mv	a0,a5
ffffffc05040484c:	70a2                	ld	ra,40(sp)
ffffffc05040484e:	7402                	ld	s0,32(sp)
ffffffc050404850:	6145                	addi	sp,sp,48
ffffffc050404852:	8082                	ret

ffffffc050404854 <do_semaphore_down>:
ffffffc050404854:	7179                	addi	sp,sp,-48
ffffffc050404856:	f406                	sd	ra,40(sp)
ffffffc050404858:	f022                	sd	s0,32(sp)
ffffffc05040485a:	1800                	addi	s0,sp,48
ffffffc05040485c:	87aa                	mv	a5,a0
ffffffc05040485e:	fcf42e23          	sw	a5,-36(s0)
ffffffc050404862:	adffb0ef          	jal	ra,ffffffc050400340 <get_current_cpu_id>
ffffffc050404866:	87aa                	mv	a5,a0
ffffffc050404868:	fef42623          	sw	a5,-20(s0)
ffffffc05040486c:	0005d717          	auipc	a4,0x5d
ffffffc050404870:	02470713          	addi	a4,a4,36 # ffffffc050461890 <semaphore_array>
ffffffc050404874:	fdc42783          	lw	a5,-36(s0)
ffffffc050404878:	0796                	slli	a5,a5,0x5
ffffffc05040487a:	97ba                	add	a5,a5,a4
ffffffc05040487c:	43dc                	lw	a5,4(a5)
ffffffc05040487e:	02f05863          	blez	a5,ffffffc0504048ae <do_semaphore_down+0x5a>
ffffffc050404882:	0005d717          	auipc	a4,0x5d
ffffffc050404886:	00e70713          	addi	a4,a4,14 # ffffffc050461890 <semaphore_array>
ffffffc05040488a:	fdc42783          	lw	a5,-36(s0)
ffffffc05040488e:	0796                	slli	a5,a5,0x5
ffffffc050404890:	97ba                	add	a5,a5,a4
ffffffc050404892:	43dc                	lw	a5,4(a5)
ffffffc050404894:	37fd                	addiw	a5,a5,-1
ffffffc050404896:	0007871b          	sext.w	a4,a5
ffffffc05040489a:	0005d697          	auipc	a3,0x5d
ffffffc05040489e:	ff668693          	addi	a3,a3,-10 # ffffffc050461890 <semaphore_array>
ffffffc0504048a2:	fdc42783          	lw	a5,-36(s0)
ffffffc0504048a6:	0796                	slli	a5,a5,0x5
ffffffc0504048a8:	97b6                	add	a5,a5,a3
ffffffc0504048aa:	c3d8                	sw	a4,4(a5)
ffffffc0504048ac:	a8bd                	j	ffffffc05040492a <do_semaphore_down+0xd6>
ffffffc0504048ae:	0006e717          	auipc	a4,0x6e
ffffffc0504048b2:	5e270713          	addi	a4,a4,1506 # ffffffc050472e90 <current_running>
ffffffc0504048b6:	fec42783          	lw	a5,-20(s0)
ffffffc0504048ba:	078e                	slli	a5,a5,0x3
ffffffc0504048bc:	97ba                	add	a5,a5,a4
ffffffc0504048be:	639c                	ld	a5,0(a5)
ffffffc0504048c0:	4705                	li	a4,1
ffffffc0504048c2:	cff8                	sw	a4,92(a5)
ffffffc0504048c4:	0006e717          	auipc	a4,0x6e
ffffffc0504048c8:	5cc70713          	addi	a4,a4,1484 # ffffffc050472e90 <current_running>
ffffffc0504048cc:	fec42783          	lw	a5,-20(s0)
ffffffc0504048d0:	078e                	slli	a5,a5,0x3
ffffffc0504048d2:	97ba                	add	a5,a5,a4
ffffffc0504048d4:	639c                	ld	a5,0(a5)
ffffffc0504048d6:	fdc42703          	lw	a4,-36(s0)
ffffffc0504048da:	00571693          	slli	a3,a4,0x5
ffffffc0504048de:	0005d717          	auipc	a4,0x5d
ffffffc0504048e2:	fb270713          	addi	a4,a4,-78 # ffffffc050461890 <semaphore_array>
ffffffc0504048e6:	9736                	add	a4,a4,a3
ffffffc0504048e8:	0721                	addi	a4,a4,8
ffffffc0504048ea:	e7b8                	sd	a4,72(a5)
ffffffc0504048ec:	0006e717          	auipc	a4,0x6e
ffffffc0504048f0:	5a470713          	addi	a4,a4,1444 # ffffffc050472e90 <current_running>
ffffffc0504048f4:	fec42783          	lw	a5,-20(s0)
ffffffc0504048f8:	078e                	slli	a5,a5,0x3
ffffffc0504048fa:	97ba                	add	a5,a5,a4
ffffffc0504048fc:	639c                	ld	a5,0(a5)
ffffffc0504048fe:	01878693          	addi	a3,a5,24
ffffffc050404902:	fdc42783          	lw	a5,-36(s0)
ffffffc050404906:	00579713          	slli	a4,a5,0x5
ffffffc05040490a:	0005d797          	auipc	a5,0x5d
ffffffc05040490e:	f8678793          	addi	a5,a5,-122 # ffffffc050461890 <semaphore_array>
ffffffc050404912:	97ba                	add	a5,a5,a4
ffffffc050404914:	07a1                	addi	a5,a5,8
ffffffc050404916:	0006e617          	auipc	a2,0x6e
ffffffc05040491a:	56260613          	addi	a2,a2,1378 # ffffffc050472e78 <ready_queue>
ffffffc05040491e:	85be                	mv	a1,a5
ffffffc050404920:	8536                	mv	a0,a3
ffffffc050404922:	ef8fe0ef          	jal	ra,ffffffc05040301a <move_node>
ffffffc050404926:	ac8fe0ef          	jal	ra,ffffffc050402bee <do_scheduler>
ffffffc05040492a:	4781                	li	a5,0
ffffffc05040492c:	853e                	mv	a0,a5
ffffffc05040492e:	70a2                	ld	ra,40(sp)
ffffffc050404930:	7402                	ld	s0,32(sp)
ffffffc050404932:	6145                	addi	sp,sp,48
ffffffc050404934:	8082                	ret

ffffffc050404936 <do_semaphore_destroy>:
ffffffc050404936:	1101                	addi	sp,sp,-32
ffffffc050404938:	ec22                	sd	s0,24(sp)
ffffffc05040493a:	1000                	addi	s0,sp,32
ffffffc05040493c:	87aa                	mv	a5,a0
ffffffc05040493e:	feb43023          	sd	a1,-32(s0)
ffffffc050404942:	fef42623          	sw	a5,-20(s0)
ffffffc050404946:	0005d717          	auipc	a4,0x5d
ffffffc05040494a:	f4a70713          	addi	a4,a4,-182 # ffffffc050461890 <semaphore_array>
ffffffc05040494e:	fec42783          	lw	a5,-20(s0)
ffffffc050404952:	0796                	slli	a5,a5,0x5
ffffffc050404954:	97ba                	add	a5,a5,a4
ffffffc050404956:	0007a223          	sw	zero,4(a5)
ffffffc05040495a:	0005d717          	auipc	a4,0x5d
ffffffc05040495e:	f3670713          	addi	a4,a4,-202 # ffffffc050461890 <semaphore_array>
ffffffc050404962:	fec42783          	lw	a5,-20(s0)
ffffffc050404966:	0796                	slli	a5,a5,0x5
ffffffc050404968:	97ba                	add	a5,a5,a4
ffffffc05040496a:	0007a023          	sw	zero,0(a5)
ffffffc05040496e:	fe043783          	ld	a5,-32(s0)
ffffffc050404972:	0007a023          	sw	zero,0(a5)
ffffffc050404976:	4781                	li	a5,0
ffffffc050404978:	853e                	mv	a0,a5
ffffffc05040497a:	6462                	ld	s0,24(sp)
ffffffc05040497c:	6105                	addi	sp,sp,32
ffffffc05040497e:	8082                	ret

ffffffc050404980 <do_mbox_open>:
ffffffc050404980:	7179                	addi	sp,sp,-48
ffffffc050404982:	f406                	sd	ra,40(sp)
ffffffc050404984:	f022                	sd	s0,32(sp)
ffffffc050404986:	1800                	addi	s0,sp,48
ffffffc050404988:	fca43c23          	sd	a0,-40(s0)
ffffffc05040498c:	fe042623          	sw	zero,-20(s0)
ffffffc050404990:	a841                	j	ffffffc050404a20 <do_mbox_open+0xa0>
ffffffc050404992:	fec42703          	lw	a4,-20(s0)
ffffffc050404996:	16000793          	li	a5,352
ffffffc05040499a:	02f707b3          	mul	a5,a4,a5
ffffffc05040499e:	01078713          	addi	a4,a5,16
ffffffc0504049a2:	0006e797          	auipc	a5,0x6e
ffffffc0504049a6:	8de78793          	addi	a5,a5,-1826 # ffffffc050472280 <mbox_array>
ffffffc0504049aa:	97ba                	add	a5,a5,a4
ffffffc0504049ac:	85be                	mv	a1,a5
ffffffc0504049ae:	fd843503          	ld	a0,-40(s0)
ffffffc0504049b2:	0d1010ef          	jal	ra,ffffffc050406282 <kstrcmp>
ffffffc0504049b6:	87aa                	mv	a5,a0
ffffffc0504049b8:	efb9                	bnez	a5,ffffffc050404a16 <do_mbox_open+0x96>
ffffffc0504049ba:	0006e717          	auipc	a4,0x6e
ffffffc0504049be:	8c670713          	addi	a4,a4,-1850 # ffffffc050472280 <mbox_array>
ffffffc0504049c2:	fec42683          	lw	a3,-20(s0)
ffffffc0504049c6:	16000793          	li	a5,352
ffffffc0504049ca:	02f687b3          	mul	a5,a3,a5
ffffffc0504049ce:	97ba                	add	a5,a5,a4
ffffffc0504049d0:	439c                	lw	a5,0(a5)
ffffffc0504049d2:	873e                	mv	a4,a5
ffffffc0504049d4:	4785                	li	a5,1
ffffffc0504049d6:	04f71063          	bne	a4,a5,ffffffc050404a16 <do_mbox_open+0x96>
ffffffc0504049da:	0006e717          	auipc	a4,0x6e
ffffffc0504049de:	8a670713          	addi	a4,a4,-1882 # ffffffc050472280 <mbox_array>
ffffffc0504049e2:	fec42683          	lw	a3,-20(s0)
ffffffc0504049e6:	16000793          	li	a5,352
ffffffc0504049ea:	02f687b3          	mul	a5,a3,a5
ffffffc0504049ee:	97ba                	add	a5,a5,a4
ffffffc0504049f0:	47dc                	lw	a5,12(a5)
ffffffc0504049f2:	2785                	addiw	a5,a5,1
ffffffc0504049f4:	0007871b          	sext.w	a4,a5
ffffffc0504049f8:	0006e697          	auipc	a3,0x6e
ffffffc0504049fc:	88868693          	addi	a3,a3,-1912 # ffffffc050472280 <mbox_array>
ffffffc050404a00:	fec42603          	lw	a2,-20(s0)
ffffffc050404a04:	16000793          	li	a5,352
ffffffc050404a08:	02f607b3          	mul	a5,a2,a5
ffffffc050404a0c:	97b6                	add	a5,a5,a3
ffffffc050404a0e:	c7d8                	sw	a4,12(a5)
ffffffc050404a10:	fec42783          	lw	a5,-20(s0)
ffffffc050404a14:	aa65                	j	ffffffc050404bcc <do_mbox_open+0x24c>
ffffffc050404a16:	fec42783          	lw	a5,-20(s0)
ffffffc050404a1a:	2785                	addiw	a5,a5,1
ffffffc050404a1c:	fef42623          	sw	a5,-20(s0)
ffffffc050404a20:	fec42783          	lw	a5,-20(s0)
ffffffc050404a24:	0007871b          	sext.w	a4,a5
ffffffc050404a28:	479d                	li	a5,7
ffffffc050404a2a:	f6e7d4e3          	bge	a5,a4,ffffffc050404992 <do_mbox_open+0x12>
ffffffc050404a2e:	89418793          	addi	a5,gp,-1900 # ffffffc05045f94c <mbox_num>
ffffffc050404a32:	4394                	lw	a3,0(a5)
ffffffc050404a34:	0006e717          	auipc	a4,0x6e
ffffffc050404a38:	84c70713          	addi	a4,a4,-1972 # ffffffc050472280 <mbox_array>
ffffffc050404a3c:	16000793          	li	a5,352
ffffffc050404a40:	02f687b3          	mul	a5,a3,a5
ffffffc050404a44:	97ba                	add	a5,a5,a4
ffffffc050404a46:	4705                	li	a4,1
ffffffc050404a48:	c398                	sw	a4,0(a5)
ffffffc050404a4a:	89418793          	addi	a5,gp,-1900 # ffffffc05045f94c <mbox_num>
ffffffc050404a4e:	4394                	lw	a3,0(a5)
ffffffc050404a50:	0006e717          	auipc	a4,0x6e
ffffffc050404a54:	83070713          	addi	a4,a4,-2000 # ffffffc050472280 <mbox_array>
ffffffc050404a58:	16000793          	li	a5,352
ffffffc050404a5c:	02f687b3          	mul	a5,a3,a5
ffffffc050404a60:	97ba                	add	a5,a5,a4
ffffffc050404a62:	0007a223          	sw	zero,4(a5)
ffffffc050404a66:	89418793          	addi	a5,gp,-1900 # ffffffc05045f94c <mbox_num>
ffffffc050404a6a:	4394                	lw	a3,0(a5)
ffffffc050404a6c:	0006e717          	auipc	a4,0x6e
ffffffc050404a70:	81470713          	addi	a4,a4,-2028 # ffffffc050472280 <mbox_array>
ffffffc050404a74:	16000793          	li	a5,352
ffffffc050404a78:	02f687b3          	mul	a5,a3,a5
ffffffc050404a7c:	97ba                	add	a5,a5,a4
ffffffc050404a7e:	0007a423          	sw	zero,8(a5)
ffffffc050404a82:	89418793          	addi	a5,gp,-1900 # ffffffc05045f94c <mbox_num>
ffffffc050404a86:	4394                	lw	a3,0(a5)
ffffffc050404a88:	0006d717          	auipc	a4,0x6d
ffffffc050404a8c:	7f870713          	addi	a4,a4,2040 # ffffffc050472280 <mbox_array>
ffffffc050404a90:	16000793          	li	a5,352
ffffffc050404a94:	02f687b3          	mul	a5,a3,a5
ffffffc050404a98:	97ba                	add	a5,a5,a4
ffffffc050404a9a:	4705                	li	a4,1
ffffffc050404a9c:	c7d8                	sw	a4,12(a5)
ffffffc050404a9e:	fe042623          	sw	zero,-20(s0)
ffffffc050404aa2:	a835                	j	ffffffc050404ade <do_mbox_open+0x15e>
ffffffc050404aa4:	fec42783          	lw	a5,-20(s0)
ffffffc050404aa8:	fd843703          	ld	a4,-40(s0)
ffffffc050404aac:	97ba                	add	a5,a5,a4
ffffffc050404aae:	89418713          	addi	a4,gp,-1900 # ffffffc05045f94c <mbox_num>
ffffffc050404ab2:	430c                	lw	a1,0(a4)
ffffffc050404ab4:	0007c703          	lbu	a4,0(a5)
ffffffc050404ab8:	0006d617          	auipc	a2,0x6d
ffffffc050404abc:	7c860613          	addi	a2,a2,1992 # ffffffc050472280 <mbox_array>
ffffffc050404ac0:	fec42683          	lw	a3,-20(s0)
ffffffc050404ac4:	16000793          	li	a5,352
ffffffc050404ac8:	02f587b3          	mul	a5,a1,a5
ffffffc050404acc:	97b2                	add	a5,a5,a2
ffffffc050404ace:	97b6                	add	a5,a5,a3
ffffffc050404ad0:	00e78823          	sb	a4,16(a5)
ffffffc050404ad4:	fec42783          	lw	a5,-20(s0)
ffffffc050404ad8:	2785                	addiw	a5,a5,1
ffffffc050404ada:	fef42623          	sw	a5,-20(s0)
ffffffc050404ade:	fec42783          	lw	a5,-20(s0)
ffffffc050404ae2:	fd843703          	ld	a4,-40(s0)
ffffffc050404ae6:	97ba                	add	a5,a5,a4
ffffffc050404ae8:	0007c783          	lbu	a5,0(a5)
ffffffc050404aec:	ffc5                	bnez	a5,ffffffc050404aa4 <do_mbox_open+0x124>
ffffffc050404aee:	89418793          	addi	a5,gp,-1900 # ffffffc05045f94c <mbox_num>
ffffffc050404af2:	4390                	lw	a2,0(a5)
ffffffc050404af4:	0006d697          	auipc	a3,0x6d
ffffffc050404af8:	78c68693          	addi	a3,a3,1932 # ffffffc050472280 <mbox_array>
ffffffc050404afc:	fec42703          	lw	a4,-20(s0)
ffffffc050404b00:	16000793          	li	a5,352
ffffffc050404b04:	02f607b3          	mul	a5,a2,a5
ffffffc050404b08:	97b6                	add	a5,a5,a3
ffffffc050404b0a:	97ba                	add	a5,a5,a4
ffffffc050404b0c:	00078823          	sb	zero,16(a5)
ffffffc050404b10:	89418793          	addi	a5,gp,-1900 # ffffffc05045f94c <mbox_num>
ffffffc050404b14:	4394                	lw	a3,0(a5)
ffffffc050404b16:	0006d717          	auipc	a4,0x6d
ffffffc050404b1a:	76a70713          	addi	a4,a4,1898 # ffffffc050472280 <mbox_array>
ffffffc050404b1e:	16000793          	li	a5,352
ffffffc050404b22:	02f687b3          	mul	a5,a3,a5
ffffffc050404b26:	97ba                	add	a5,a5,a4
ffffffc050404b28:	0207bc23          	sd	zero,56(a5)
ffffffc050404b2c:	89418793          	addi	a5,gp,-1900 # ffffffc05045f94c <mbox_num>
ffffffc050404b30:	4394                	lw	a3,0(a5)
ffffffc050404b32:	0006d717          	auipc	a4,0x6d
ffffffc050404b36:	74e70713          	addi	a4,a4,1870 # ffffffc050472280 <mbox_array>
ffffffc050404b3a:	16000793          	li	a5,352
ffffffc050404b3e:	02f687b3          	mul	a5,a3,a5
ffffffc050404b42:	97ba                	add	a5,a5,a4
ffffffc050404b44:	0407b023          	sd	zero,64(a5)
ffffffc050404b48:	89418793          	addi	a5,gp,-1900 # ffffffc05045f94c <mbox_num>
ffffffc050404b4c:	4394                	lw	a3,0(a5)
ffffffc050404b4e:	0006d717          	auipc	a4,0x6d
ffffffc050404b52:	73270713          	addi	a4,a4,1842 # ffffffc050472280 <mbox_array>
ffffffc050404b56:	16000793          	li	a5,352
ffffffc050404b5a:	02f687b3          	mul	a5,a3,a5
ffffffc050404b5e:	97ba                	add	a5,a5,a4
ffffffc050404b60:	0207a823          	sw	zero,48(a5)
ffffffc050404b64:	89418793          	addi	a5,gp,-1900 # ffffffc05045f94c <mbox_num>
ffffffc050404b68:	4394                	lw	a3,0(a5)
ffffffc050404b6a:	0006d717          	auipc	a4,0x6d
ffffffc050404b6e:	71670713          	addi	a4,a4,1814 # ffffffc050472280 <mbox_array>
ffffffc050404b72:	16000793          	li	a5,352
ffffffc050404b76:	02f687b3          	mul	a5,a3,a5
ffffffc050404b7a:	97ba                	add	a5,a5,a4
ffffffc050404b7c:	0407b823          	sd	zero,80(a5)
ffffffc050404b80:	89418793          	addi	a5,gp,-1900 # ffffffc05045f94c <mbox_num>
ffffffc050404b84:	4394                	lw	a3,0(a5)
ffffffc050404b86:	0006d717          	auipc	a4,0x6d
ffffffc050404b8a:	6fa70713          	addi	a4,a4,1786 # ffffffc050472280 <mbox_array>
ffffffc050404b8e:	16000793          	li	a5,352
ffffffc050404b92:	02f687b3          	mul	a5,a3,a5
ffffffc050404b96:	97ba                	add	a5,a5,a4
ffffffc050404b98:	0407bc23          	sd	zero,88(a5)
ffffffc050404b9c:	89418793          	addi	a5,gp,-1900 # ffffffc05045f94c <mbox_num>
ffffffc050404ba0:	4394                	lw	a3,0(a5)
ffffffc050404ba2:	0006d717          	auipc	a4,0x6d
ffffffc050404ba6:	6de70713          	addi	a4,a4,1758 # ffffffc050472280 <mbox_array>
ffffffc050404baa:	16000793          	li	a5,352
ffffffc050404bae:	02f687b3          	mul	a5,a3,a5
ffffffc050404bb2:	97ba                	add	a5,a5,a4
ffffffc050404bb4:	0407a423          	sw	zero,72(a5)
ffffffc050404bb8:	89418793          	addi	a5,gp,-1900 # ffffffc05045f94c <mbox_num>
ffffffc050404bbc:	439c                	lw	a5,0(a5)
ffffffc050404bbe:	0017871b          	addiw	a4,a5,1
ffffffc050404bc2:	0007069b          	sext.w	a3,a4
ffffffc050404bc6:	89418713          	addi	a4,gp,-1900 # ffffffc05045f94c <mbox_num>
ffffffc050404bca:	c314                	sw	a3,0(a4)
ffffffc050404bcc:	853e                	mv	a0,a5
ffffffc050404bce:	70a2                	ld	ra,40(sp)
ffffffc050404bd0:	7402                	ld	s0,32(sp)
ffffffc050404bd2:	6145                	addi	sp,sp,48
ffffffc050404bd4:	8082                	ret

ffffffc050404bd6 <do_mbox_close>:
ffffffc050404bd6:	1101                	addi	sp,sp,-32
ffffffc050404bd8:	ec22                	sd	s0,24(sp)
ffffffc050404bda:	1000                	addi	s0,sp,32
ffffffc050404bdc:	87aa                	mv	a5,a0
ffffffc050404bde:	fef42623          	sw	a5,-20(s0)
ffffffc050404be2:	0006d717          	auipc	a4,0x6d
ffffffc050404be6:	69e70713          	addi	a4,a4,1694 # ffffffc050472280 <mbox_array>
ffffffc050404bea:	fec42683          	lw	a3,-20(s0)
ffffffc050404bee:	16000793          	li	a5,352
ffffffc050404bf2:	02f687b3          	mul	a5,a3,a5
ffffffc050404bf6:	97ba                	add	a5,a5,a4
ffffffc050404bf8:	0007a023          	sw	zero,0(a5)
ffffffc050404bfc:	0006d717          	auipc	a4,0x6d
ffffffc050404c00:	68470713          	addi	a4,a4,1668 # ffffffc050472280 <mbox_array>
ffffffc050404c04:	fec42683          	lw	a3,-20(s0)
ffffffc050404c08:	16000793          	li	a5,352
ffffffc050404c0c:	02f687b3          	mul	a5,a3,a5
ffffffc050404c10:	97ba                	add	a5,a5,a4
ffffffc050404c12:	439c                	lw	a5,0(a5)
ffffffc050404c14:	eff9                	bnez	a5,ffffffc050404cf2 <do_mbox_close+0x11c>
ffffffc050404c16:	0006d717          	auipc	a4,0x6d
ffffffc050404c1a:	66a70713          	addi	a4,a4,1642 # ffffffc050472280 <mbox_array>
ffffffc050404c1e:	fec42683          	lw	a3,-20(s0)
ffffffc050404c22:	16000793          	li	a5,352
ffffffc050404c26:	02f687b3          	mul	a5,a3,a5
ffffffc050404c2a:	97ba                	add	a5,a5,a4
ffffffc050404c2c:	47dc                	lw	a5,12(a5)
ffffffc050404c2e:	873e                	mv	a4,a5
ffffffc050404c30:	4785                	li	a5,1
ffffffc050404c32:	08e7c463          	blt	a5,a4,ffffffc050404cba <do_mbox_close+0xe4>
ffffffc050404c36:	0006d717          	auipc	a4,0x6d
ffffffc050404c3a:	64a70713          	addi	a4,a4,1610 # ffffffc050472280 <mbox_array>
ffffffc050404c3e:	fec42683          	lw	a3,-20(s0)
ffffffc050404c42:	16000793          	li	a5,352
ffffffc050404c46:	02f687b3          	mul	a5,a3,a5
ffffffc050404c4a:	97ba                	add	a5,a5,a4
ffffffc050404c4c:	0007a623          	sw	zero,12(a5)
ffffffc050404c50:	0006d717          	auipc	a4,0x6d
ffffffc050404c54:	63070713          	addi	a4,a4,1584 # ffffffc050472280 <mbox_array>
ffffffc050404c58:	fec42683          	lw	a3,-20(s0)
ffffffc050404c5c:	16000793          	li	a5,352
ffffffc050404c60:	02f687b3          	mul	a5,a3,a5
ffffffc050404c64:	97ba                	add	a5,a5,a4
ffffffc050404c66:	0007a023          	sw	zero,0(a5)
ffffffc050404c6a:	0006d717          	auipc	a4,0x6d
ffffffc050404c6e:	61670713          	addi	a4,a4,1558 # ffffffc050472280 <mbox_array>
ffffffc050404c72:	fec42683          	lw	a3,-20(s0)
ffffffc050404c76:	16000793          	li	a5,352
ffffffc050404c7a:	02f687b3          	mul	a5,a3,a5
ffffffc050404c7e:	97ba                	add	a5,a5,a4
ffffffc050404c80:	00078823          	sb	zero,16(a5)
ffffffc050404c84:	0006d717          	auipc	a4,0x6d
ffffffc050404c88:	5fc70713          	addi	a4,a4,1532 # ffffffc050472280 <mbox_array>
ffffffc050404c8c:	fec42683          	lw	a3,-20(s0)
ffffffc050404c90:	16000793          	li	a5,352
ffffffc050404c94:	02f687b3          	mul	a5,a3,a5
ffffffc050404c98:	97ba                	add	a5,a5,a4
ffffffc050404c9a:	0007a223          	sw	zero,4(a5)
ffffffc050404c9e:	0006d717          	auipc	a4,0x6d
ffffffc050404ca2:	5e270713          	addi	a4,a4,1506 # ffffffc050472280 <mbox_array>
ffffffc050404ca6:	fec42683          	lw	a3,-20(s0)
ffffffc050404caa:	16000793          	li	a5,352
ffffffc050404cae:	02f687b3          	mul	a5,a3,a5
ffffffc050404cb2:	97ba                	add	a5,a5,a4
ffffffc050404cb4:	0007a423          	sw	zero,8(a5)
ffffffc050404cb8:	a835                	j	ffffffc050404cf4 <do_mbox_close+0x11e>
ffffffc050404cba:	0006d717          	auipc	a4,0x6d
ffffffc050404cbe:	5c670713          	addi	a4,a4,1478 # ffffffc050472280 <mbox_array>
ffffffc050404cc2:	fec42683          	lw	a3,-20(s0)
ffffffc050404cc6:	16000793          	li	a5,352
ffffffc050404cca:	02f687b3          	mul	a5,a3,a5
ffffffc050404cce:	97ba                	add	a5,a5,a4
ffffffc050404cd0:	47dc                	lw	a5,12(a5)
ffffffc050404cd2:	37fd                	addiw	a5,a5,-1
ffffffc050404cd4:	0007871b          	sext.w	a4,a5
ffffffc050404cd8:	0006d697          	auipc	a3,0x6d
ffffffc050404cdc:	5a868693          	addi	a3,a3,1448 # ffffffc050472280 <mbox_array>
ffffffc050404ce0:	fec42603          	lw	a2,-20(s0)
ffffffc050404ce4:	16000793          	li	a5,352
ffffffc050404ce8:	02f607b3          	mul	a5,a2,a5
ffffffc050404cec:	97b6                	add	a5,a5,a3
ffffffc050404cee:	c7d8                	sw	a4,12(a5)
ffffffc050404cf0:	a011                	j	ffffffc050404cf4 <do_mbox_close+0x11e>
ffffffc050404cf2:	0001                	nop
ffffffc050404cf4:	6462                	ld	s0,24(sp)
ffffffc050404cf6:	6105                	addi	sp,sp,32
ffffffc050404cf8:	8082                	ret

ffffffc050404cfa <return_v>:
ffffffc050404cfa:	7139                	addi	sp,sp,-64
ffffffc050404cfc:	fc06                	sd	ra,56(sp)
ffffffc050404cfe:	f822                	sd	s0,48(sp)
ffffffc050404d00:	0080                	addi	s0,sp,64
ffffffc050404d02:	fca43423          	sd	a0,-56(s0)
ffffffc050404d06:	e3afb0ef          	jal	ra,ffffffc050400340 <get_current_cpu_id>
ffffffc050404d0a:	87aa                	mv	a5,a0
ffffffc050404d0c:	fef42623          	sw	a5,-20(s0)
ffffffc050404d10:	0006e717          	auipc	a4,0x6e
ffffffc050404d14:	18070713          	addi	a4,a4,384 # ffffffc050472e90 <current_running>
ffffffc050404d18:	fec42783          	lw	a5,-20(s0)
ffffffc050404d1c:	078e                	slli	a5,a5,0x3
ffffffc050404d1e:	97ba                	add	a5,a5,a4
ffffffc050404d20:	639c                	ld	a5,0(a5)
ffffffc050404d22:	7fbc                	ld	a5,120(a5)
ffffffc050404d24:	ee078793          	addi	a5,a5,-288
ffffffc050404d28:	fef43023          	sd	a5,-32(s0)
ffffffc050404d2c:	fe043783          	ld	a5,-32(s0)
ffffffc050404d30:	fcf43c23          	sd	a5,-40(s0)
ffffffc050404d34:	fd843783          	ld	a5,-40(s0)
ffffffc050404d38:	05078793          	addi	a5,a5,80
ffffffc050404d3c:	fc843703          	ld	a4,-56(s0)
ffffffc050404d40:	e398                	sd	a4,0(a5)
ffffffc050404d42:	0001                	nop
ffffffc050404d44:	70e2                	ld	ra,56(sp)
ffffffc050404d46:	7442                	ld	s0,48(sp)
ffffffc050404d48:	6121                	addi	sp,sp,64
ffffffc050404d4a:	8082                	ret

ffffffc050404d4c <do_mbox_send>:
ffffffc050404d4c:	7179                	addi	sp,sp,-48
ffffffc050404d4e:	f406                	sd	ra,40(sp)
ffffffc050404d50:	f022                	sd	s0,32(sp)
ffffffc050404d52:	1800                	addi	s0,sp,48
ffffffc050404d54:	87aa                	mv	a5,a0
ffffffc050404d56:	fcb43823          	sd	a1,-48(s0)
ffffffc050404d5a:	8732                	mv	a4,a2
ffffffc050404d5c:	fcf42e23          	sw	a5,-36(s0)
ffffffc050404d60:	87ba                	mv	a5,a4
ffffffc050404d62:	fcf42c23          	sw	a5,-40(s0)
ffffffc050404d66:	ddafb0ef          	jal	ra,ffffffc050400340 <get_current_cpu_id>
ffffffc050404d6a:	87aa                	mv	a5,a0
ffffffc050404d6c:	fef42623          	sw	a5,-20(s0)
ffffffc050404d70:	0006d717          	auipc	a4,0x6d
ffffffc050404d74:	51070713          	addi	a4,a4,1296 # ffffffc050472280 <mbox_array>
ffffffc050404d78:	fdc42683          	lw	a3,-36(s0)
ffffffc050404d7c:	16000793          	li	a5,352
ffffffc050404d80:	02f687b3          	mul	a5,a3,a5
ffffffc050404d84:	97ba                	add	a5,a5,a4
ffffffc050404d86:	479c                	lw	a5,8(a5)
ffffffc050404d88:	fd842703          	lw	a4,-40(s0)
ffffffc050404d8c:	9fb9                	addw	a5,a5,a4
ffffffc050404d8e:	2781                	sext.w	a5,a5
ffffffc050404d90:	873e                	mv	a4,a5
ffffffc050404d92:	0ff00793          	li	a5,255
ffffffc050404d96:	08e7da63          	bge	a5,a4,ffffffc050404e2a <do_mbox_send+0xde>
ffffffc050404d9a:	0006e717          	auipc	a4,0x6e
ffffffc050404d9e:	0f670713          	addi	a4,a4,246 # ffffffc050472e90 <current_running>
ffffffc050404da2:	fec42783          	lw	a5,-20(s0)
ffffffc050404da6:	078e                	slli	a5,a5,0x3
ffffffc050404da8:	97ba                	add	a5,a5,a4
ffffffc050404daa:	639c                	ld	a5,0(a5)
ffffffc050404dac:	4705                	li	a4,1
ffffffc050404dae:	cff8                	sw	a4,92(a5)
ffffffc050404db0:	0006e717          	auipc	a4,0x6e
ffffffc050404db4:	0e070713          	addi	a4,a4,224 # ffffffc050472e90 <current_running>
ffffffc050404db8:	fec42783          	lw	a5,-20(s0)
ffffffc050404dbc:	078e                	slli	a5,a5,0x3
ffffffc050404dbe:	97ba                	add	a5,a5,a4
ffffffc050404dc0:	639c                	ld	a5,0(a5)
ffffffc050404dc2:	fdc42683          	lw	a3,-36(s0)
ffffffc050404dc6:	16000713          	li	a4,352
ffffffc050404dca:	02e68733          	mul	a4,a3,a4
ffffffc050404dce:	03070693          	addi	a3,a4,48
ffffffc050404dd2:	0006d717          	auipc	a4,0x6d
ffffffc050404dd6:	4ae70713          	addi	a4,a4,1198 # ffffffc050472280 <mbox_array>
ffffffc050404dda:	9736                	add	a4,a4,a3
ffffffc050404ddc:	e7b8                	sd	a4,72(a5)
ffffffc050404dde:	0006e717          	auipc	a4,0x6e
ffffffc050404de2:	0b270713          	addi	a4,a4,178 # ffffffc050472e90 <current_running>
ffffffc050404de6:	fec42783          	lw	a5,-20(s0)
ffffffc050404dea:	078e                	slli	a5,a5,0x3
ffffffc050404dec:	97ba                	add	a5,a5,a4
ffffffc050404dee:	639c                	ld	a5,0(a5)
ffffffc050404df0:	01878693          	addi	a3,a5,24
ffffffc050404df4:	fdc42703          	lw	a4,-36(s0)
ffffffc050404df8:	16000793          	li	a5,352
ffffffc050404dfc:	02f707b3          	mul	a5,a4,a5
ffffffc050404e00:	03078713          	addi	a4,a5,48
ffffffc050404e04:	0006d797          	auipc	a5,0x6d
ffffffc050404e08:	47c78793          	addi	a5,a5,1148 # ffffffc050472280 <mbox_array>
ffffffc050404e0c:	97ba                	add	a5,a5,a4
ffffffc050404e0e:	0006e617          	auipc	a2,0x6e
ffffffc050404e12:	06a60613          	addi	a2,a2,106 # ffffffc050472e78 <ready_queue>
ffffffc050404e16:	85be                	mv	a1,a5
ffffffc050404e18:	8536                	mv	a0,a3
ffffffc050404e1a:	a00fe0ef          	jal	ra,ffffffc05040301a <move_node>
ffffffc050404e1e:	4501                	li	a0,0
ffffffc050404e20:	edbff0ef          	jal	ra,ffffffc050404cfa <return_v>
ffffffc050404e24:	dcbfd0ef          	jal	ra,ffffffc050402bee <do_scheduler>
ffffffc050404e28:	a221                	j	ffffffc050404f30 <do_mbox_send+0x1e4>
ffffffc050404e2a:	0006d717          	auipc	a4,0x6d
ffffffc050404e2e:	45670713          	addi	a4,a4,1110 # ffffffc050472280 <mbox_array>
ffffffc050404e32:	fdc42683          	lw	a3,-36(s0)
ffffffc050404e36:	16000793          	li	a5,352
ffffffc050404e3a:	02f687b3          	mul	a5,a3,a5
ffffffc050404e3e:	97ba                	add	a5,a5,a4
ffffffc050404e40:	4798                	lw	a4,8(a5)
ffffffc050404e42:	fdc42683          	lw	a3,-36(s0)
ffffffc050404e46:	16000793          	li	a5,352
ffffffc050404e4a:	02f687b3          	mul	a5,a3,a5
ffffffc050404e4e:	97ba                	add	a5,a5,a4
ffffffc050404e50:	06078713          	addi	a4,a5,96
ffffffc050404e54:	0006d797          	auipc	a5,0x6d
ffffffc050404e58:	42c78793          	addi	a5,a5,1068 # ffffffc050472280 <mbox_array>
ffffffc050404e5c:	97ba                	add	a5,a5,a4
ffffffc050404e5e:	fd842703          	lw	a4,-40(s0)
ffffffc050404e62:	863a                	mv	a2,a4
ffffffc050404e64:	fd043583          	ld	a1,-48(s0)
ffffffc050404e68:	853e                	mv	a0,a5
ffffffc050404e6a:	348010ef          	jal	ra,ffffffc0504061b2 <kmemcpy>
ffffffc050404e6e:	0006d717          	auipc	a4,0x6d
ffffffc050404e72:	41270713          	addi	a4,a4,1042 # ffffffc050472280 <mbox_array>
ffffffc050404e76:	fdc42683          	lw	a3,-36(s0)
ffffffc050404e7a:	16000793          	li	a5,352
ffffffc050404e7e:	02f687b3          	mul	a5,a3,a5
ffffffc050404e82:	97ba                	add	a5,a5,a4
ffffffc050404e84:	479c                	lw	a5,8(a5)
ffffffc050404e86:	fd842703          	lw	a4,-40(s0)
ffffffc050404e8a:	9fb9                	addw	a5,a5,a4
ffffffc050404e8c:	0007871b          	sext.w	a4,a5
ffffffc050404e90:	0006d697          	auipc	a3,0x6d
ffffffc050404e94:	3f068693          	addi	a3,a3,1008 # ffffffc050472280 <mbox_array>
ffffffc050404e98:	fdc42603          	lw	a2,-36(s0)
ffffffc050404e9c:	16000793          	li	a5,352
ffffffc050404ea0:	02f607b3          	mul	a5,a2,a5
ffffffc050404ea4:	97b6                	add	a5,a5,a3
ffffffc050404ea6:	c798                	sw	a4,8(a5)
ffffffc050404ea8:	fdc42703          	lw	a4,-36(s0)
ffffffc050404eac:	16000793          	li	a5,352
ffffffc050404eb0:	02f707b3          	mul	a5,a4,a5
ffffffc050404eb4:	04078713          	addi	a4,a5,64
ffffffc050404eb8:	0006d797          	auipc	a5,0x6d
ffffffc050404ebc:	3c878793          	addi	a5,a5,968 # ffffffc050472280 <mbox_array>
ffffffc050404ec0:	97ba                	add	a5,a5,a4
ffffffc050404ec2:	07a1                	addi	a5,a5,8
ffffffc050404ec4:	fef43023          	sd	a5,-32(s0)
ffffffc050404ec8:	fe043783          	ld	a5,-32(s0)
ffffffc050404ecc:	439c                	lw	a5,0(a5)
ffffffc050404ece:	04f05f63          	blez	a5,ffffffc050404f2c <do_mbox_send+0x1e0>
ffffffc050404ed2:	fe043783          	ld	a5,-32(s0)
ffffffc050404ed6:	679c                	ld	a5,8(a5)
ffffffc050404ed8:	4394                	lw	a3,0(a5)
ffffffc050404eda:	0006e717          	auipc	a4,0x6e
ffffffc050404ede:	fde70713          	addi	a4,a4,-34 # ffffffc050472eb8 <pcb>
ffffffc050404ee2:	09800793          	li	a5,152
ffffffc050404ee6:	02f687b3          	mul	a5,a3,a5
ffffffc050404eea:	97ba                	add	a5,a5,a4
ffffffc050404eec:	470d                	li	a4,3
ffffffc050404eee:	cff8                	sw	a4,92(a5)
ffffffc050404ef0:	fe043783          	ld	a5,-32(s0)
ffffffc050404ef4:	679c                	ld	a5,8(a5)
ffffffc050404ef6:	4394                	lw	a3,0(a5)
ffffffc050404ef8:	0006e717          	auipc	a4,0x6e
ffffffc050404efc:	fc070713          	addi	a4,a4,-64 # ffffffc050472eb8 <pcb>
ffffffc050404f00:	09800793          	li	a5,152
ffffffc050404f04:	02f687b3          	mul	a5,a3,a5
ffffffc050404f08:	97ba                	add	a5,a5,a4
ffffffc050404f0a:	0006e717          	auipc	a4,0x6e
ffffffc050404f0e:	f6e70713          	addi	a4,a4,-146 # ffffffc050472e78 <ready_queue>
ffffffc050404f12:	e7b8                	sd	a4,72(a5)
ffffffc050404f14:	fe043783          	ld	a5,-32(s0)
ffffffc050404f18:	679c                	ld	a5,8(a5)
ffffffc050404f1a:	fe043603          	ld	a2,-32(s0)
ffffffc050404f1e:	0006e597          	auipc	a1,0x6e
ffffffc050404f22:	f5a58593          	addi	a1,a1,-166 # ffffffc050472e78 <ready_queue>
ffffffc050404f26:	853e                	mv	a0,a5
ffffffc050404f28:	8f2fe0ef          	jal	ra,ffffffc05040301a <move_node>
ffffffc050404f2c:	fd842783          	lw	a5,-40(s0)
ffffffc050404f30:	853e                	mv	a0,a5
ffffffc050404f32:	70a2                	ld	ra,40(sp)
ffffffc050404f34:	7402                	ld	s0,32(sp)
ffffffc050404f36:	6145                	addi	sp,sp,48
ffffffc050404f38:	8082                	ret

ffffffc050404f3a <do_mbox_recv>:
ffffffc050404f3a:	7179                	addi	sp,sp,-48
ffffffc050404f3c:	f406                	sd	ra,40(sp)
ffffffc050404f3e:	f022                	sd	s0,32(sp)
ffffffc050404f40:	1800                	addi	s0,sp,48
ffffffc050404f42:	87aa                	mv	a5,a0
ffffffc050404f44:	fcb43823          	sd	a1,-48(s0)
ffffffc050404f48:	8732                	mv	a4,a2
ffffffc050404f4a:	fcf42e23          	sw	a5,-36(s0)
ffffffc050404f4e:	87ba                	mv	a5,a4
ffffffc050404f50:	fcf42c23          	sw	a5,-40(s0)
ffffffc050404f54:	becfb0ef          	jal	ra,ffffffc050400340 <get_current_cpu_id>
ffffffc050404f58:	87aa                	mv	a5,a0
ffffffc050404f5a:	fef42623          	sw	a5,-20(s0)
ffffffc050404f5e:	0006d717          	auipc	a4,0x6d
ffffffc050404f62:	32270713          	addi	a4,a4,802 # ffffffc050472280 <mbox_array>
ffffffc050404f66:	fdc42683          	lw	a3,-36(s0)
ffffffc050404f6a:	16000793          	li	a5,352
ffffffc050404f6e:	02f687b3          	mul	a5,a3,a5
ffffffc050404f72:	97ba                	add	a5,a5,a4
ffffffc050404f74:	4798                	lw	a4,8(a5)
ffffffc050404f76:	fd842783          	lw	a5,-40(s0)
ffffffc050404f7a:	2781                	sext.w	a5,a5
ffffffc050404f7c:	08f75c63          	bge	a4,a5,ffffffc050405014 <do_mbox_recv+0xda>
ffffffc050404f80:	0006e717          	auipc	a4,0x6e
ffffffc050404f84:	f1070713          	addi	a4,a4,-240 # ffffffc050472e90 <current_running>
ffffffc050404f88:	fec42783          	lw	a5,-20(s0)
ffffffc050404f8c:	078e                	slli	a5,a5,0x3
ffffffc050404f8e:	97ba                	add	a5,a5,a4
ffffffc050404f90:	639c                	ld	a5,0(a5)
ffffffc050404f92:	4705                	li	a4,1
ffffffc050404f94:	cff8                	sw	a4,92(a5)
ffffffc050404f96:	0006e717          	auipc	a4,0x6e
ffffffc050404f9a:	efa70713          	addi	a4,a4,-262 # ffffffc050472e90 <current_running>
ffffffc050404f9e:	fec42783          	lw	a5,-20(s0)
ffffffc050404fa2:	078e                	slli	a5,a5,0x3
ffffffc050404fa4:	97ba                	add	a5,a5,a4
ffffffc050404fa6:	639c                	ld	a5,0(a5)
ffffffc050404fa8:	fdc42683          	lw	a3,-36(s0)
ffffffc050404fac:	16000713          	li	a4,352
ffffffc050404fb0:	02e68733          	mul	a4,a3,a4
ffffffc050404fb4:	04070693          	addi	a3,a4,64
ffffffc050404fb8:	0006d717          	auipc	a4,0x6d
ffffffc050404fbc:	2c870713          	addi	a4,a4,712 # ffffffc050472280 <mbox_array>
ffffffc050404fc0:	9736                	add	a4,a4,a3
ffffffc050404fc2:	0721                	addi	a4,a4,8
ffffffc050404fc4:	e7b8                	sd	a4,72(a5)
ffffffc050404fc6:	0006e717          	auipc	a4,0x6e
ffffffc050404fca:	eca70713          	addi	a4,a4,-310 # ffffffc050472e90 <current_running>
ffffffc050404fce:	fec42783          	lw	a5,-20(s0)
ffffffc050404fd2:	078e                	slli	a5,a5,0x3
ffffffc050404fd4:	97ba                	add	a5,a5,a4
ffffffc050404fd6:	639c                	ld	a5,0(a5)
ffffffc050404fd8:	01878693          	addi	a3,a5,24
ffffffc050404fdc:	fdc42703          	lw	a4,-36(s0)
ffffffc050404fe0:	16000793          	li	a5,352
ffffffc050404fe4:	02f707b3          	mul	a5,a4,a5
ffffffc050404fe8:	04078713          	addi	a4,a5,64
ffffffc050404fec:	0006d797          	auipc	a5,0x6d
ffffffc050404ff0:	29478793          	addi	a5,a5,660 # ffffffc050472280 <mbox_array>
ffffffc050404ff4:	97ba                	add	a5,a5,a4
ffffffc050404ff6:	07a1                	addi	a5,a5,8
ffffffc050404ff8:	0006e617          	auipc	a2,0x6e
ffffffc050404ffc:	e8060613          	addi	a2,a2,-384 # ffffffc050472e78 <ready_queue>
ffffffc050405000:	85be                	mv	a1,a5
ffffffc050405002:	8536                	mv	a0,a3
ffffffc050405004:	816fe0ef          	jal	ra,ffffffc05040301a <move_node>
ffffffc050405008:	4501                	li	a0,0
ffffffc05040500a:	cf1ff0ef          	jal	ra,ffffffc050404cfa <return_v>
ffffffc05040500e:	be1fd0ef          	jal	ra,ffffffc050402bee <do_scheduler>
ffffffc050405012:	a221                	j	ffffffc05040511a <do_mbox_recv+0x1e0>
ffffffc050405014:	0006d717          	auipc	a4,0x6d
ffffffc050405018:	26c70713          	addi	a4,a4,620 # ffffffc050472280 <mbox_array>
ffffffc05040501c:	fdc42683          	lw	a3,-36(s0)
ffffffc050405020:	16000793          	li	a5,352
ffffffc050405024:	02f687b3          	mul	a5,a3,a5
ffffffc050405028:	97ba                	add	a5,a5,a4
ffffffc05040502a:	4798                	lw	a4,8(a5)
ffffffc05040502c:	fd842783          	lw	a5,-40(s0)
ffffffc050405030:	40f707bb          	subw	a5,a4,a5
ffffffc050405034:	0007871b          	sext.w	a4,a5
ffffffc050405038:	0006d697          	auipc	a3,0x6d
ffffffc05040503c:	24868693          	addi	a3,a3,584 # ffffffc050472280 <mbox_array>
ffffffc050405040:	fdc42603          	lw	a2,-36(s0)
ffffffc050405044:	16000793          	li	a5,352
ffffffc050405048:	02f607b3          	mul	a5,a2,a5
ffffffc05040504c:	97b6                	add	a5,a5,a3
ffffffc05040504e:	c798                	sw	a4,8(a5)
ffffffc050405050:	0006d717          	auipc	a4,0x6d
ffffffc050405054:	23070713          	addi	a4,a4,560 # ffffffc050472280 <mbox_array>
ffffffc050405058:	fdc42683          	lw	a3,-36(s0)
ffffffc05040505c:	16000793          	li	a5,352
ffffffc050405060:	02f687b3          	mul	a5,a3,a5
ffffffc050405064:	97ba                	add	a5,a5,a4
ffffffc050405066:	4798                	lw	a4,8(a5)
ffffffc050405068:	fdc42683          	lw	a3,-36(s0)
ffffffc05040506c:	16000793          	li	a5,352
ffffffc050405070:	02f687b3          	mul	a5,a3,a5
ffffffc050405074:	97ba                	add	a5,a5,a4
ffffffc050405076:	06078713          	addi	a4,a5,96
ffffffc05040507a:	0006d797          	auipc	a5,0x6d
ffffffc05040507e:	20678793          	addi	a5,a5,518 # ffffffc050472280 <mbox_array>
ffffffc050405082:	97ba                	add	a5,a5,a4
ffffffc050405084:	fd842703          	lw	a4,-40(s0)
ffffffc050405088:	863a                	mv	a2,a4
ffffffc05040508a:	85be                	mv	a1,a5
ffffffc05040508c:	fd043503          	ld	a0,-48(s0)
ffffffc050405090:	122010ef          	jal	ra,ffffffc0504061b2 <kmemcpy>
ffffffc050405094:	fdc42703          	lw	a4,-36(s0)
ffffffc050405098:	16000793          	li	a5,352
ffffffc05040509c:	02f707b3          	mul	a5,a4,a5
ffffffc0504050a0:	03078713          	addi	a4,a5,48
ffffffc0504050a4:	0006d797          	auipc	a5,0x6d
ffffffc0504050a8:	1dc78793          	addi	a5,a5,476 # ffffffc050472280 <mbox_array>
ffffffc0504050ac:	97ba                	add	a5,a5,a4
ffffffc0504050ae:	fef43023          	sd	a5,-32(s0)
ffffffc0504050b2:	fe043783          	ld	a5,-32(s0)
ffffffc0504050b6:	439c                	lw	a5,0(a5)
ffffffc0504050b8:	04f05f63          	blez	a5,ffffffc050405116 <do_mbox_recv+0x1dc>
ffffffc0504050bc:	fe043783          	ld	a5,-32(s0)
ffffffc0504050c0:	679c                	ld	a5,8(a5)
ffffffc0504050c2:	4394                	lw	a3,0(a5)
ffffffc0504050c4:	0006e717          	auipc	a4,0x6e
ffffffc0504050c8:	df470713          	addi	a4,a4,-524 # ffffffc050472eb8 <pcb>
ffffffc0504050cc:	09800793          	li	a5,152
ffffffc0504050d0:	02f687b3          	mul	a5,a3,a5
ffffffc0504050d4:	97ba                	add	a5,a5,a4
ffffffc0504050d6:	470d                	li	a4,3
ffffffc0504050d8:	cff8                	sw	a4,92(a5)
ffffffc0504050da:	fe043783          	ld	a5,-32(s0)
ffffffc0504050de:	679c                	ld	a5,8(a5)
ffffffc0504050e0:	4394                	lw	a3,0(a5)
ffffffc0504050e2:	0006e717          	auipc	a4,0x6e
ffffffc0504050e6:	dd670713          	addi	a4,a4,-554 # ffffffc050472eb8 <pcb>
ffffffc0504050ea:	09800793          	li	a5,152
ffffffc0504050ee:	02f687b3          	mul	a5,a3,a5
ffffffc0504050f2:	97ba                	add	a5,a5,a4
ffffffc0504050f4:	0006e717          	auipc	a4,0x6e
ffffffc0504050f8:	d8470713          	addi	a4,a4,-636 # ffffffc050472e78 <ready_queue>
ffffffc0504050fc:	e7b8                	sd	a4,72(a5)
ffffffc0504050fe:	fe043783          	ld	a5,-32(s0)
ffffffc050405102:	679c                	ld	a5,8(a5)
ffffffc050405104:	fe043603          	ld	a2,-32(s0)
ffffffc050405108:	0006e597          	auipc	a1,0x6e
ffffffc05040510c:	d7058593          	addi	a1,a1,-656 # ffffffc050472e78 <ready_queue>
ffffffc050405110:	853e                	mv	a0,a5
ffffffc050405112:	f09fd0ef          	jal	ra,ffffffc05040301a <move_node>
ffffffc050405116:	fd842783          	lw	a5,-40(s0)
ffffffc05040511a:	853e                	mv	a0,a5
ffffffc05040511c:	70a2                	ld	ra,40(sp)
ffffffc05040511e:	7402                	ld	s0,32(sp)
ffffffc050405120:	6145                	addi	sp,sp,48
ffffffc050405122:	8082                	ret

ffffffc050405124 <sbi_sd_write>:
ffffffc050405124:	1101                	addi	sp,sp,-32
ffffffc050405126:	ec22                	sd	s0,24(sp)
ffffffc050405128:	1000                	addi	s0,sp,32
ffffffc05040512a:	87aa                	mv	a5,a0
ffffffc05040512c:	86ae                	mv	a3,a1
ffffffc05040512e:	8732                	mv	a4,a2
ffffffc050405130:	fef42623          	sw	a5,-20(s0)
ffffffc050405134:	87b6                	mv	a5,a3
ffffffc050405136:	fef42423          	sw	a5,-24(s0)
ffffffc05040513a:	87ba                	mv	a5,a4
ffffffc05040513c:	fef42223          	sw	a5,-28(s0)
ffffffc050405140:	fec46783          	lwu	a5,-20(s0)
ffffffc050405144:	853e                	mv	a0,a5
ffffffc050405146:	fe846783          	lwu	a5,-24(s0)
ffffffc05040514a:	85be                	mv	a1,a5
ffffffc05040514c:	fe446783          	lwu	a5,-28(s0)
ffffffc050405150:	863e                	mv	a2,a5
ffffffc050405152:	48a9                	li	a7,10
ffffffc050405154:	00000073          	ecall
ffffffc050405158:	87aa                	mv	a5,a0
ffffffc05040515a:	853e                	mv	a0,a5
ffffffc05040515c:	6462                	ld	s0,24(sp)
ffffffc05040515e:	6105                	addi	sp,sp,32
ffffffc050405160:	8082                	ret

ffffffc050405162 <sbi_sd_read>:
ffffffc050405162:	1101                	addi	sp,sp,-32
ffffffc050405164:	ec22                	sd	s0,24(sp)
ffffffc050405166:	1000                	addi	s0,sp,32
ffffffc050405168:	87aa                	mv	a5,a0
ffffffc05040516a:	86ae                	mv	a3,a1
ffffffc05040516c:	8732                	mv	a4,a2
ffffffc05040516e:	fef42623          	sw	a5,-20(s0)
ffffffc050405172:	87b6                	mv	a5,a3
ffffffc050405174:	fef42423          	sw	a5,-24(s0)
ffffffc050405178:	87ba                	mv	a5,a4
ffffffc05040517a:	fef42223          	sw	a5,-28(s0)
ffffffc05040517e:	fec46783          	lwu	a5,-20(s0)
ffffffc050405182:	853e                	mv	a0,a5
ffffffc050405184:	fe846783          	lwu	a5,-24(s0)
ffffffc050405188:	85be                	mv	a1,a5
ffffffc05040518a:	fe446783          	lwu	a5,-28(s0)
ffffffc05040518e:	863e                	mv	a2,a5
ffffffc050405190:	48ad                	li	a7,11
ffffffc050405192:	00000073          	ecall
ffffffc050405196:	87aa                	mv	a5,a0
ffffffc050405198:	853e                	mv	a0,a5
ffffffc05040519a:	6462                	ld	s0,24(sp)
ffffffc05040519c:	6105                	addi	sp,sp,32
ffffffc05040519e:	8082                	ret

ffffffc0504051a0 <local_flush_tlb_all>:
ffffffc0504051a0:	1141                	addi	sp,sp,-16
ffffffc0504051a2:	e422                	sd	s0,8(sp)
ffffffc0504051a4:	0800                	addi	s0,sp,16
ffffffc0504051a6:	12000073          	sfence.vma
ffffffc0504051aa:	0001                	nop
ffffffc0504051ac:	6422                	ld	s0,8(sp)
ffffffc0504051ae:	0141                	addi	sp,sp,16
ffffffc0504051b0:	8082                	ret

ffffffc0504051b2 <local_flush_icache_all>:
ffffffc0504051b2:	1141                	addi	sp,sp,-16
ffffffc0504051b4:	e422                	sd	s0,8(sp)
ffffffc0504051b6:	0800                	addi	s0,sp,16
ffffffc0504051b8:	0000100f          	fence.i
ffffffc0504051bc:	0001                	nop
ffffffc0504051be:	6422                	ld	s0,8(sp)
ffffffc0504051c0:	0141                	addi	sp,sp,16
ffffffc0504051c2:	8082                	ret

ffffffc0504051c4 <set_satp>:
ffffffc0504051c4:	7179                	addi	sp,sp,-48
ffffffc0504051c6:	f422                	sd	s0,40(sp)
ffffffc0504051c8:	1800                	addi	s0,sp,48
ffffffc0504051ca:	87aa                	mv	a5,a0
ffffffc0504051cc:	872e                	mv	a4,a1
ffffffc0504051ce:	fcc43823          	sd	a2,-48(s0)
ffffffc0504051d2:	fcf42e23          	sw	a5,-36(s0)
ffffffc0504051d6:	87ba                	mv	a5,a4
ffffffc0504051d8:	fcf42c23          	sw	a5,-40(s0)
ffffffc0504051dc:	fdc46783          	lwu	a5,-36(s0)
ffffffc0504051e0:	03c79713          	slli	a4,a5,0x3c
ffffffc0504051e4:	fd846783          	lwu	a5,-40(s0)
ffffffc0504051e8:	17b2                	slli	a5,a5,0x2c
ffffffc0504051ea:	8fd9                	or	a5,a5,a4
ffffffc0504051ec:	fd043703          	ld	a4,-48(s0)
ffffffc0504051f0:	8fd9                	or	a5,a5,a4
ffffffc0504051f2:	fef43423          	sd	a5,-24(s0)
ffffffc0504051f6:	fe843783          	ld	a5,-24(s0)
ffffffc0504051fa:	12000073          	sfence.vma
ffffffc0504051fe:	18079073          	csrw	satp,a5
ffffffc050405202:	0001                	nop
ffffffc050405204:	7422                	ld	s0,40(sp)
ffffffc050405206:	6145                	addi	sp,sp,48
ffffffc050405208:	8082                	ret

ffffffc05040520a <kva2pa>:
ffffffc05040520a:	1101                	addi	sp,sp,-32
ffffffc05040520c:	ec22                	sd	s0,24(sp)
ffffffc05040520e:	1000                	addi	s0,sp,32
ffffffc050405210:	fea43423          	sd	a0,-24(s0)
ffffffc050405214:	fe843703          	ld	a4,-24(s0)
ffffffc050405218:	4785                	li	a5,1
ffffffc05040521a:	179a                	slli	a5,a5,0x26
ffffffc05040521c:	97ba                	add	a5,a5,a4
ffffffc05040521e:	853e                	mv	a0,a5
ffffffc050405220:	6462                	ld	s0,24(sp)
ffffffc050405222:	6105                	addi	sp,sp,32
ffffffc050405224:	8082                	ret

ffffffc050405226 <pa2kva>:
ffffffc050405226:	1101                	addi	sp,sp,-32
ffffffc050405228:	ec22                	sd	s0,24(sp)
ffffffc05040522a:	1000                	addi	s0,sp,32
ffffffc05040522c:	fea43423          	sd	a0,-24(s0)
ffffffc050405230:	fe843703          	ld	a4,-24(s0)
ffffffc050405234:	57fd                	li	a5,-1
ffffffc050405236:	179a                	slli	a5,a5,0x26
ffffffc050405238:	97ba                	add	a5,a5,a4
ffffffc05040523a:	853e                	mv	a0,a5
ffffffc05040523c:	6462                	ld	s0,24(sp)
ffffffc05040523e:	6105                	addi	sp,sp,32
ffffffc050405240:	8082                	ret

ffffffc050405242 <get_pa>:
ffffffc050405242:	1101                	addi	sp,sp,-32
ffffffc050405244:	ec22                	sd	s0,24(sp)
ffffffc050405246:	1000                	addi	s0,sp,32
ffffffc050405248:	fea43423          	sd	a0,-24(s0)
ffffffc05040524c:	fe843783          	ld	a5,-24(s0)
ffffffc050405250:	83a9                	srli	a5,a5,0xa
ffffffc050405252:	00c79713          	slli	a4,a5,0xc
ffffffc050405256:	fff007b7          	lui	a5,0xfff00
ffffffc05040525a:	83a1                	srli	a5,a5,0x8
ffffffc05040525c:	8ff9                	and	a5,a5,a4
ffffffc05040525e:	853e                	mv	a0,a5
ffffffc050405260:	6462                	ld	s0,24(sp)
ffffffc050405262:	6105                	addi	sp,sp,32
ffffffc050405264:	8082                	ret

ffffffc050405266 <get_pfn>:
ffffffc050405266:	1101                	addi	sp,sp,-32
ffffffc050405268:	ec22                	sd	s0,24(sp)
ffffffc05040526a:	1000                	addi	s0,sp,32
ffffffc05040526c:	fea43423          	sd	a0,-24(s0)
ffffffc050405270:	fe843783          	ld	a5,-24(s0)
ffffffc050405274:	83a9                	srli	a5,a5,0xa
ffffffc050405276:	873e                	mv	a4,a5
ffffffc050405278:	57fd                	li	a5,-1
ffffffc05040527a:	83d1                	srli	a5,a5,0x14
ffffffc05040527c:	8ff9                	and	a5,a5,a4
ffffffc05040527e:	853e                	mv	a0,a5
ffffffc050405280:	6462                	ld	s0,24(sp)
ffffffc050405282:	6105                	addi	sp,sp,32
ffffffc050405284:	8082                	ret

ffffffc050405286 <set_pfn>:
ffffffc050405286:	7179                	addi	sp,sp,-48
ffffffc050405288:	f422                	sd	s0,40(sp)
ffffffc05040528a:	1800                	addi	s0,sp,48
ffffffc05040528c:	fca43c23          	sd	a0,-40(s0)
ffffffc050405290:	fcb43823          	sd	a1,-48(s0)
ffffffc050405294:	fd843783          	ld	a5,-40(s0)
ffffffc050405298:	639c                	ld	a5,0(a5)
ffffffc05040529a:	3ff7f793          	andi	a5,a5,1023
ffffffc05040529e:	fef43423          	sd	a5,-24(s0)
ffffffc0504052a2:	fd043783          	ld	a5,-48(s0)
ffffffc0504052a6:	00a79713          	slli	a4,a5,0xa
ffffffc0504052aa:	fe843783          	ld	a5,-24(s0)
ffffffc0504052ae:	8f5d                	or	a4,a4,a5
ffffffc0504052b0:	fd843783          	ld	a5,-40(s0)
ffffffc0504052b4:	e398                	sd	a4,0(a5)
ffffffc0504052b6:	0001                	nop
ffffffc0504052b8:	7422                	ld	s0,40(sp)
ffffffc0504052ba:	6145                	addi	sp,sp,48
ffffffc0504052bc:	8082                	ret

ffffffc0504052be <set_attribute>:
ffffffc0504052be:	1101                	addi	sp,sp,-32
ffffffc0504052c0:	ec22                	sd	s0,24(sp)
ffffffc0504052c2:	1000                	addi	s0,sp,32
ffffffc0504052c4:	fea43423          	sd	a0,-24(s0)
ffffffc0504052c8:	feb43023          	sd	a1,-32(s0)
ffffffc0504052cc:	fe843783          	ld	a5,-24(s0)
ffffffc0504052d0:	6398                	ld	a4,0(a5)
ffffffc0504052d2:	fe043783          	ld	a5,-32(s0)
ffffffc0504052d6:	8f5d                	or	a4,a4,a5
ffffffc0504052d8:	fe843783          	ld	a5,-24(s0)
ffffffc0504052dc:	e398                	sd	a4,0(a5)
ffffffc0504052de:	0001                	nop
ffffffc0504052e0:	6462                	ld	s0,24(sp)
ffffffc0504052e2:	6105                	addi	sp,sp,32
ffffffc0504052e4:	8082                	ret

ffffffc0504052e6 <clear_pgdir>:
ffffffc0504052e6:	1101                	addi	sp,sp,-32
ffffffc0504052e8:	ec06                	sd	ra,24(sp)
ffffffc0504052ea:	e822                	sd	s0,16(sp)
ffffffc0504052ec:	1000                	addi	s0,sp,32
ffffffc0504052ee:	fea43423          	sd	a0,-24(s0)
ffffffc0504052f2:	fe843783          	ld	a5,-24(s0)
ffffffc0504052f6:	6605                	lui	a2,0x1
ffffffc0504052f8:	4581                	li	a1,0
ffffffc0504052fa:	853e                	mv	a0,a5
ffffffc0504052fc:	709000ef          	jal	ra,ffffffc050406204 <kmemset>
ffffffc050405300:	0001                	nop
ffffffc050405302:	60e2                	ld	ra,24(sp)
ffffffc050405304:	6442                	ld	s0,16(sp)
ffffffc050405306:	6105                	addi	sp,sp,32
ffffffc050405308:	8082                	ret

ffffffc05040530a <_panic>:
ffffffc05040530a:	7179                	addi	sp,sp,-48
ffffffc05040530c:	f406                	sd	ra,40(sp)
ffffffc05040530e:	f022                	sd	s0,32(sp)
ffffffc050405310:	1800                	addi	s0,sp,48
ffffffc050405312:	fea43423          	sd	a0,-24(s0)
ffffffc050405316:	87ae                	mv	a5,a1
ffffffc050405318:	fcc43c23          	sd	a2,-40(s0)
ffffffc05040531c:	fef42223          	sw	a5,-28(s0)
ffffffc050405320:	fe442783          	lw	a5,-28(s0)
ffffffc050405324:	86be                	mv	a3,a5
ffffffc050405326:	fe843603          	ld	a2,-24(s0)
ffffffc05040532a:	fd843583          	ld	a1,-40(s0)
ffffffc05040532e:	00002517          	auipc	a0,0x2
ffffffc050405332:	f5250513          	addi	a0,a0,-174 # ffffffc050407280 <__FUNCTION__.1563+0x30>
ffffffc050405336:	0cb010ef          	jal	ra,ffffffc050406c00 <printk>
ffffffc05040533a:	a001                	j	ffffffc05040533a <_panic+0x30>

ffffffc05040533c <allocPage>:
ffffffc05040533c:	7179                	addi	sp,sp,-48
ffffffc05040533e:	f422                	sd	s0,40(sp)
ffffffc050405340:	1800                	addi	s0,sp,48
ffffffc050405342:	87aa                	mv	a5,a0
ffffffc050405344:	fcf42e23          	sw	a5,-36(s0)
ffffffc050405348:	82018793          	addi	a5,gp,-2016 # ffffffc05045f8d8 <memCurr>
ffffffc05040534c:	6398                	ld	a4,0(a5)
ffffffc05040534e:	6785                	lui	a5,0x1
ffffffc050405350:	17fd                	addi	a5,a5,-1
ffffffc050405352:	973e                	add	a4,a4,a5
ffffffc050405354:	77fd                	lui	a5,0xfffff
ffffffc050405356:	8ff9                	and	a5,a5,a4
ffffffc050405358:	fef43423          	sd	a5,-24(s0)
ffffffc05040535c:	fdc42783          	lw	a5,-36(s0)
ffffffc050405360:	00c7979b          	slliw	a5,a5,0xc
ffffffc050405364:	2781                	sext.w	a5,a5
ffffffc050405366:	873e                	mv	a4,a5
ffffffc050405368:	fe843783          	ld	a5,-24(s0)
ffffffc05040536c:	973e                	add	a4,a4,a5
ffffffc05040536e:	82018793          	addi	a5,gp,-2016 # ffffffc05045f8d8 <memCurr>
ffffffc050405372:	e398                	sd	a4,0(a5)
ffffffc050405374:	fe843783          	ld	a5,-24(s0)
ffffffc050405378:	853e                	mv	a0,a5
ffffffc05040537a:	7422                	ld	s0,40(sp)
ffffffc05040537c:	6145                	addi	sp,sp,48
ffffffc05040537e:	8082                	ret

ffffffc050405380 <freePage>:
ffffffc050405380:	1101                	addi	sp,sp,-32
ffffffc050405382:	ec22                	sd	s0,24(sp)
ffffffc050405384:	1000                	addi	s0,sp,32
ffffffc050405386:	fea43423          	sd	a0,-24(s0)
ffffffc05040538a:	87ae                	mv	a5,a1
ffffffc05040538c:	fef42223          	sw	a5,-28(s0)
ffffffc050405390:	0001                	nop
ffffffc050405392:	6462                	ld	s0,24(sp)
ffffffc050405394:	6105                	addi	sp,sp,32
ffffffc050405396:	8082                	ret

ffffffc050405398 <kmalloc>:
ffffffc050405398:	7179                	addi	sp,sp,-48
ffffffc05040539a:	f422                	sd	s0,40(sp)
ffffffc05040539c:	1800                	addi	s0,sp,48
ffffffc05040539e:	fca43c23          	sd	a0,-40(s0)
ffffffc0504053a2:	82018793          	addi	a5,gp,-2016 # ffffffc05045f8d8 <memCurr>
ffffffc0504053a6:	639c                	ld	a5,0(a5)
ffffffc0504053a8:	078d                	addi	a5,a5,3
ffffffc0504053aa:	9bf1                	andi	a5,a5,-4
ffffffc0504053ac:	fef43423          	sd	a5,-24(s0)
ffffffc0504053b0:	fe843703          	ld	a4,-24(s0)
ffffffc0504053b4:	fd843783          	ld	a5,-40(s0)
ffffffc0504053b8:	973e                	add	a4,a4,a5
ffffffc0504053ba:	82018793          	addi	a5,gp,-2016 # ffffffc05045f8d8 <memCurr>
ffffffc0504053be:	e398                	sd	a4,0(a5)
ffffffc0504053c0:	fe843783          	ld	a5,-24(s0)
ffffffc0504053c4:	853e                	mv	a0,a5
ffffffc0504053c6:	7422                	ld	s0,40(sp)
ffffffc0504053c8:	6145                	addi	sp,sp,48
ffffffc0504053ca:	8082                	ret

ffffffc0504053cc <alloc_ph_page>:
ffffffc0504053cc:	715d                	addi	sp,sp,-80
ffffffc0504053ce:	e486                	sd	ra,72(sp)
ffffffc0504053d0:	e0a2                	sd	s0,64(sp)
ffffffc0504053d2:	0880                	addi	s0,sp,80
ffffffc0504053d4:	faa43c23          	sd	a0,-72(s0)
ffffffc0504053d8:	fe042223          	sw	zero,-28(s0)
ffffffc0504053dc:	85018793          	addi	a5,gp,-1968 # ffffffc05045f908 <last_search.1434>
ffffffc0504053e0:	439c                	lw	a5,0(a5)
ffffffc0504053e2:	2785                	addiw	a5,a5,1
ffffffc0504053e4:	fef42623          	sw	a5,-20(s0)
ffffffc0504053e8:	fe042423          	sw	zero,-24(s0)
ffffffc0504053ec:	a0a1                	j	ffffffc050405434 <alloc_ph_page+0x68>
ffffffc0504053ee:	00064717          	auipc	a4,0x64
ffffffc0504053f2:	69270713          	addi	a4,a4,1682 # ffffffc050469a80 <ph_page_array>
ffffffc0504053f6:	fec42783          	lw	a5,-20(s0)
ffffffc0504053fa:	0792                	slli	a5,a5,0x4
ffffffc0504053fc:	97ba                	add	a5,a5,a4
ffffffc0504053fe:	439c                	lw	a5,0(a5)
ffffffc050405400:	e789                	bnez	a5,ffffffc05040540a <alloc_ph_page+0x3e>
ffffffc050405402:	4785                	li	a5,1
ffffffc050405404:	fef42223          	sw	a5,-28(s0)
ffffffc050405408:	a835                	j	ffffffc050405444 <alloc_ph_page+0x78>
ffffffc05040540a:	fe842783          	lw	a5,-24(s0)
ffffffc05040540e:	2785                	addiw	a5,a5,1
ffffffc050405410:	fef42423          	sw	a5,-24(s0)
ffffffc050405414:	fec42783          	lw	a5,-20(s0)
ffffffc050405418:	2785                	addiw	a5,a5,1
ffffffc05040541a:	2781                	sext.w	a5,a5
ffffffc05040541c:	873e                	mv	a4,a5
ffffffc05040541e:	41f7579b          	sraiw	a5,a4,0x1f
ffffffc050405422:	0197d79b          	srliw	a5,a5,0x19
ffffffc050405426:	9f3d                	addw	a4,a4,a5
ffffffc050405428:	07f77713          	andi	a4,a4,127
ffffffc05040542c:	40f707bb          	subw	a5,a4,a5
ffffffc050405430:	fef42623          	sw	a5,-20(s0)
ffffffc050405434:	fe842783          	lw	a5,-24(s0)
ffffffc050405438:	0007871b          	sext.w	a4,a5
ffffffc05040543c:	07f00793          	li	a5,127
ffffffc050405440:	fae7d7e3          	bge	a5,a4,ffffffc0504053ee <alloc_ph_page+0x22>
ffffffc050405444:	fe442783          	lw	a5,-28(s0)
ffffffc050405448:	0007871b          	sext.w	a4,a5
ffffffc05040544c:	4785                	li	a5,1
ffffffc05040544e:	06f71863          	bne	a4,a5,ffffffc0504054be <alloc_ph_page+0xf2>
ffffffc050405452:	00064717          	auipc	a4,0x64
ffffffc050405456:	62e70713          	addi	a4,a4,1582 # ffffffc050469a80 <ph_page_array>
ffffffc05040545a:	fec42783          	lw	a5,-20(s0)
ffffffc05040545e:	0792                	slli	a5,a5,0x4
ffffffc050405460:	97ba                	add	a5,a5,a4
ffffffc050405462:	4705                	li	a4,1
ffffffc050405464:	c398                	sw	a4,0(a5)
ffffffc050405466:	00064717          	auipc	a4,0x64
ffffffc05040546a:	61a70713          	addi	a4,a4,1562 # ffffffc050469a80 <ph_page_array>
ffffffc05040546e:	fec42783          	lw	a5,-20(s0)
ffffffc050405472:	0792                	slli	a5,a5,0x4
ffffffc050405474:	97ba                	add	a5,a5,a4
ffffffc050405476:	fb843703          	ld	a4,-72(s0)
ffffffc05040547a:	e798                	sd	a4,8(a5)
ffffffc05040547c:	fec42783          	lw	a5,-20(s0)
ffffffc050405480:	0007871b          	sext.w	a4,a5
ffffffc050405484:	07f00793          	li	a5,127
ffffffc050405488:	00f71763          	bne	a4,a5,ffffffc050405496 <alloc_ph_page+0xca>
ffffffc05040548c:	85018793          	addi	a5,gp,-1968 # ffffffc05045f908 <last_search.1434>
ffffffc050405490:	577d                	li	a4,-1
ffffffc050405492:	c398                	sw	a4,0(a5)
ffffffc050405494:	a031                	j	ffffffc0504054a0 <alloc_ph_page+0xd4>
ffffffc050405496:	85018793          	addi	a5,gp,-1968 # ffffffc05045f908 <last_search.1434>
ffffffc05040549a:	fec42703          	lw	a4,-20(s0)
ffffffc05040549e:	c398                	sw	a4,0(a5)
ffffffc0504054a0:	fec42783          	lw	a5,-20(s0)
ffffffc0504054a4:	00c7979b          	slliw	a5,a5,0xc
ffffffc0504054a8:	2781                	sext.w	a5,a5
ffffffc0504054aa:	873e                	mv	a4,a5
ffffffc0504054ac:	83818793          	addi	a5,gp,-1992 # ffffffc05045f8f0 <user_free_space>
ffffffc0504054b0:	639c                	ld	a5,0(a5)
ffffffc0504054b2:	97ba                	add	a5,a5,a4
ffffffc0504054b4:	853e                	mv	a0,a5
ffffffc0504054b6:	d71ff0ef          	jal	ra,ffffffc050405226 <pa2kva>
ffffffc0504054ba:	87aa                	mv	a5,a0
ffffffc0504054bc:	aa95                	j	ffffffc050405630 <alloc_ph_page+0x264>
ffffffc0504054be:	85418793          	addi	a5,gp,-1964 # ffffffc05045f90c <next_replace.1438>
ffffffc0504054c2:	439c                	lw	a5,0(a5)
ffffffc0504054c4:	00064717          	auipc	a4,0x64
ffffffc0504054c8:	5bc70713          	addi	a4,a4,1468 # ffffffc050469a80 <ph_page_array>
ffffffc0504054cc:	0792                	slli	a5,a5,0x4
ffffffc0504054ce:	97ba                	add	a5,a5,a4
ffffffc0504054d0:	679c                	ld	a5,8(a5)
ffffffc0504054d2:	fcf43c23          	sd	a5,-40(s0)
ffffffc0504054d6:	fe042223          	sw	zero,-28(s0)
ffffffc0504054da:	fe042423          	sw	zero,-24(s0)
ffffffc0504054de:	a025                	j	ffffffc050405506 <alloc_ph_page+0x13a>
ffffffc0504054e0:	00065717          	auipc	a4,0x65
ffffffc0504054e4:	da070713          	addi	a4,a4,-608 # ffffffc05046a280 <swap_page_array>
ffffffc0504054e8:	fe842783          	lw	a5,-24(s0)
ffffffc0504054ec:	078a                	slli	a5,a5,0x2
ffffffc0504054ee:	97ba                	add	a5,a5,a4
ffffffc0504054f0:	439c                	lw	a5,0(a5)
ffffffc0504054f2:	e789                	bnez	a5,ffffffc0504054fc <alloc_ph_page+0x130>
ffffffc0504054f4:	4785                	li	a5,1
ffffffc0504054f6:	fef42223          	sw	a5,-28(s0)
ffffffc0504054fa:	a829                	j	ffffffc050405514 <alloc_ph_page+0x148>
ffffffc0504054fc:	fe842783          	lw	a5,-24(s0)
ffffffc050405500:	2785                	addiw	a5,a5,1
ffffffc050405502:	fef42423          	sw	a5,-24(s0)
ffffffc050405506:	fe842783          	lw	a5,-24(s0)
ffffffc05040550a:	0007871b          	sext.w	a4,a5
ffffffc05040550e:	6789                	lui	a5,0x2
ffffffc050405510:	fcf748e3          	blt	a4,a5,ffffffc0504054e0 <alloc_ph_page+0x114>
ffffffc050405514:	fe442783          	lw	a5,-28(s0)
ffffffc050405518:	2781                	sext.w	a5,a5
ffffffc05040551a:	ef89                	bnez	a5,ffffffc050405534 <alloc_ph_page+0x168>
ffffffc05040551c:	00002617          	auipc	a2,0x2
ffffffc050405520:	da460613          	addi	a2,a2,-604 # ffffffc0504072c0 <__FUNCTION__.1446>
ffffffc050405524:	06200593          	li	a1,98
ffffffc050405528:	00002517          	auipc	a0,0x2
ffffffc05040552c:	d8050513          	addi	a0,a0,-640 # ffffffc0504072a8 <__FUNCTION__.1563+0x58>
ffffffc050405530:	ddbff0ef          	jal	ra,ffffffc05040530a <_panic>
ffffffc050405534:	fe842783          	lw	a5,-24(s0)
ffffffc050405538:	0037979b          	slliw	a5,a5,0x3
ffffffc05040553c:	0007871b          	sext.w	a4,a5
ffffffc050405540:	6785                	lui	a5,0x1
ffffffc050405542:	8007879b          	addiw	a5,a5,-2048
ffffffc050405546:	9fb9                	addw	a5,a5,a4
ffffffc050405548:	fcf42a23          	sw	a5,-44(s0)
ffffffc05040554c:	00065717          	auipc	a4,0x65
ffffffc050405550:	d3470713          	addi	a4,a4,-716 # ffffffc05046a280 <swap_page_array>
ffffffc050405554:	fe842783          	lw	a5,-24(s0)
ffffffc050405558:	078a                	slli	a5,a5,0x2
ffffffc05040555a:	97ba                	add	a5,a5,a4
ffffffc05040555c:	4705                	li	a4,1
ffffffc05040555e:	c398                	sw	a4,0(a5)
ffffffc050405560:	fd843783          	ld	a5,-40(s0)
ffffffc050405564:	639c                	ld	a5,0(a5)
ffffffc050405566:	853e                	mv	a0,a5
ffffffc050405568:	cdbff0ef          	jal	ra,ffffffc050405242 <get_pa>
ffffffc05040556c:	fca43423          	sd	a0,-56(s0)
ffffffc050405570:	fc843783          	ld	a5,-56(s0)
ffffffc050405574:	2781                	sext.w	a5,a5
ffffffc050405576:	fd442703          	lw	a4,-44(s0)
ffffffc05040557a:	863a                	mv	a2,a4
ffffffc05040557c:	45a1                	li	a1,8
ffffffc05040557e:	853e                	mv	a0,a5
ffffffc050405580:	ba5ff0ef          	jal	ra,ffffffc050405124 <sbi_sd_write>
ffffffc050405584:	fd843783          	ld	a5,-40(s0)
ffffffc050405588:	0007b023          	sd	zero,0(a5) # 1000 <_start-0xffffffc0503ff000>
ffffffc05040558c:	fd442783          	lw	a5,-44(s0)
ffffffc050405590:	85be                	mv	a1,a5
ffffffc050405592:	fd843503          	ld	a0,-40(s0)
ffffffc050405596:	cf1ff0ef          	jal	ra,ffffffc050405286 <set_pfn>
ffffffc05040559a:	10000593          	li	a1,256
ffffffc05040559e:	fd843503          	ld	a0,-40(s0)
ffffffc0504055a2:	d1dff0ef          	jal	ra,ffffffc0504052be <set_attribute>
ffffffc0504055a6:	bfbff0ef          	jal	ra,ffffffc0504051a0 <local_flush_tlb_all>
ffffffc0504055aa:	85418793          	addi	a5,gp,-1964 # ffffffc05045f90c <next_replace.1438>
ffffffc0504055ae:	439c                	lw	a5,0(a5)
ffffffc0504055b0:	00064717          	auipc	a4,0x64
ffffffc0504055b4:	4d070713          	addi	a4,a4,1232 # ffffffc050469a80 <ph_page_array>
ffffffc0504055b8:	0792                	slli	a5,a5,0x4
ffffffc0504055ba:	97ba                	add	a5,a5,a4
ffffffc0504055bc:	4705                	li	a4,1
ffffffc0504055be:	c398                	sw	a4,0(a5)
ffffffc0504055c0:	85418793          	addi	a5,gp,-1964 # ffffffc05045f90c <next_replace.1438>
ffffffc0504055c4:	439c                	lw	a5,0(a5)
ffffffc0504055c6:	00064717          	auipc	a4,0x64
ffffffc0504055ca:	4ba70713          	addi	a4,a4,1210 # ffffffc050469a80 <ph_page_array>
ffffffc0504055ce:	0792                	slli	a5,a5,0x4
ffffffc0504055d0:	97ba                	add	a5,a5,a4
ffffffc0504055d2:	fb843703          	ld	a4,-72(s0)
ffffffc0504055d6:	e798                	sd	a4,8(a5)
ffffffc0504055d8:	85418793          	addi	a5,gp,-1964 # ffffffc05045f90c <next_replace.1438>
ffffffc0504055dc:	439c                	lw	a5,0(a5)
ffffffc0504055de:	fef42623          	sw	a5,-20(s0)
ffffffc0504055e2:	85418793          	addi	a5,gp,-1964 # ffffffc05045f90c <next_replace.1438>
ffffffc0504055e6:	439c                	lw	a5,0(a5)
ffffffc0504055e8:	873e                	mv	a4,a5
ffffffc0504055ea:	07f00793          	li	a5,127
ffffffc0504055ee:	00f71763          	bne	a4,a5,ffffffc0504055fc <alloc_ph_page+0x230>
ffffffc0504055f2:	85418793          	addi	a5,gp,-1964 # ffffffc05045f90c <next_replace.1438>
ffffffc0504055f6:	4779                	li	a4,30
ffffffc0504055f8:	c398                	sw	a4,0(a5)
ffffffc0504055fa:	a811                	j	ffffffc05040560e <alloc_ph_page+0x242>
ffffffc0504055fc:	85418793          	addi	a5,gp,-1964 # ffffffc05045f90c <next_replace.1438>
ffffffc050405600:	439c                	lw	a5,0(a5)
ffffffc050405602:	2785                	addiw	a5,a5,1
ffffffc050405604:	0007871b          	sext.w	a4,a5
ffffffc050405608:	85418793          	addi	a5,gp,-1964 # ffffffc05045f90c <next_replace.1438>
ffffffc05040560c:	c398                	sw	a4,0(a5)
ffffffc05040560e:	fec42783          	lw	a5,-20(s0)
ffffffc050405612:	00c7979b          	slliw	a5,a5,0xc
ffffffc050405616:	2781                	sext.w	a5,a5
ffffffc050405618:	873e                	mv	a4,a5
ffffffc05040561a:	83818793          	addi	a5,gp,-1992 # ffffffc05045f8f0 <user_free_space>
ffffffc05040561e:	639c                	ld	a5,0(a5)
ffffffc050405620:	97ba                	add	a5,a5,a4
ffffffc050405622:	fcf43423          	sd	a5,-56(s0)
ffffffc050405626:	fc843503          	ld	a0,-56(s0)
ffffffc05040562a:	bfdff0ef          	jal	ra,ffffffc050405226 <pa2kva>
ffffffc05040562e:	87aa                	mv	a5,a0
ffffffc050405630:	853e                	mv	a0,a5
ffffffc050405632:	60a6                	ld	ra,72(sp)
ffffffc050405634:	6406                	ld	s0,64(sp)
ffffffc050405636:	6161                	addi	sp,sp,80
ffffffc050405638:	8082                	ret

ffffffc05040563a <shm_page_get>:
ffffffc05040563a:	1101                	addi	sp,sp,-32
ffffffc05040563c:	ec22                	sd	s0,24(sp)
ffffffc05040563e:	1000                	addi	s0,sp,32
ffffffc050405640:	87aa                	mv	a5,a0
ffffffc050405642:	fef42623          	sw	a5,-20(s0)
ffffffc050405646:	0001                	nop
ffffffc050405648:	853e                	mv	a0,a5
ffffffc05040564a:	6462                	ld	s0,24(sp)
ffffffc05040564c:	6105                	addi	sp,sp,32
ffffffc05040564e:	8082                	ret

ffffffc050405650 <shm_page_dt>:
ffffffc050405650:	1101                	addi	sp,sp,-32
ffffffc050405652:	ec22                	sd	s0,24(sp)
ffffffc050405654:	1000                	addi	s0,sp,32
ffffffc050405656:	fea43423          	sd	a0,-24(s0)
ffffffc05040565a:	0001                	nop
ffffffc05040565c:	6462                	ld	s0,24(sp)
ffffffc05040565e:	6105                	addi	sp,sp,32
ffffffc050405660:	8082                	ret

ffffffc050405662 <share_pgtable>:
ffffffc050405662:	1101                	addi	sp,sp,-32
ffffffc050405664:	ec22                	sd	s0,24(sp)
ffffffc050405666:	1000                	addi	s0,sp,32
ffffffc050405668:	fea43423          	sd	a0,-24(s0)
ffffffc05040566c:	feb43023          	sd	a1,-32(s0)
ffffffc050405670:	0001                	nop
ffffffc050405672:	6462                	ld	s0,24(sp)
ffffffc050405674:	6105                	addi	sp,sp,32
ffffffc050405676:	8082                	ret

ffffffc050405678 <alloc_pgtab>:
ffffffc050405678:	1101                	addi	sp,sp,-32
ffffffc05040567a:	ec06                	sd	ra,24(sp)
ffffffc05040567c:	e822                	sd	s0,16(sp)
ffffffc05040567e:	1000                	addi	s0,sp,32
ffffffc050405680:	fe042223          	sw	zero,-28(s0)
ffffffc050405684:	85818793          	addi	a5,gp,-1960 # ffffffc05045f910 <last_search.1461>
ffffffc050405688:	439c                	lw	a5,0(a5)
ffffffc05040568a:	2785                	addiw	a5,a5,1
ffffffc05040568c:	fef42623          	sw	a5,-20(s0)
ffffffc050405690:	fe042423          	sw	zero,-24(s0)
ffffffc050405694:	a081                	j	ffffffc0504056d4 <alloc_pgtab+0x5c>
ffffffc050405696:	0005c717          	auipc	a4,0x5c
ffffffc05040569a:	45a70713          	addi	a4,a4,1114 # ffffffc050461af0 <page_tab_array>
ffffffc05040569e:	fec42783          	lw	a5,-20(s0)
ffffffc0504056a2:	078a                	slli	a5,a5,0x2
ffffffc0504056a4:	97ba                	add	a5,a5,a4
ffffffc0504056a6:	439c                	lw	a5,0(a5)
ffffffc0504056a8:	e789                	bnez	a5,ffffffc0504056b2 <alloc_pgtab+0x3a>
ffffffc0504056aa:	4785                	li	a5,1
ffffffc0504056ac:	fef42223          	sw	a5,-28(s0)
ffffffc0504056b0:	a81d                	j	ffffffc0504056e6 <alloc_pgtab+0x6e>
ffffffc0504056b2:	fe842783          	lw	a5,-24(s0)
ffffffc0504056b6:	2785                	addiw	a5,a5,1
ffffffc0504056b8:	fef42423          	sw	a5,-24(s0)
ffffffc0504056bc:	fec42783          	lw	a5,-20(s0)
ffffffc0504056c0:	2785                	addiw	a5,a5,1
ffffffc0504056c2:	2781                	sext.w	a5,a5
ffffffc0504056c4:	873e                	mv	a4,a5
ffffffc0504056c6:	6789                	lui	a5,0x2
ffffffc0504056c8:	f407879b          	addiw	a5,a5,-192
ffffffc0504056cc:	02f767bb          	remw	a5,a4,a5
ffffffc0504056d0:	fef42623          	sw	a5,-20(s0)
ffffffc0504056d4:	fe842783          	lw	a5,-24(s0)
ffffffc0504056d8:	0007871b          	sext.w	a4,a5
ffffffc0504056dc:	6789                	lui	a5,0x2
ffffffc0504056de:	f3f78793          	addi	a5,a5,-193 # 1f3f <_start-0xffffffc0503fe0c1>
ffffffc0504056e2:	fae7dae3          	bge	a5,a4,ffffffc050405696 <alloc_pgtab+0x1e>
ffffffc0504056e6:	fe442783          	lw	a5,-28(s0)
ffffffc0504056ea:	0007871b          	sext.w	a4,a5
ffffffc0504056ee:	4785                	li	a5,1
ffffffc0504056f0:	02f71e63          	bne	a4,a5,ffffffc05040572c <alloc_pgtab+0xb4>
ffffffc0504056f4:	0005c717          	auipc	a4,0x5c
ffffffc0504056f8:	3fc70713          	addi	a4,a4,1020 # ffffffc050461af0 <page_tab_array>
ffffffc0504056fc:	fec42783          	lw	a5,-20(s0)
ffffffc050405700:	078a                	slli	a5,a5,0x2
ffffffc050405702:	97ba                	add	a5,a5,a4
ffffffc050405704:	4705                	li	a4,1
ffffffc050405706:	c398                	sw	a4,0(a5)
ffffffc050405708:	85818793          	addi	a5,gp,-1960 # ffffffc05045f910 <last_search.1461>
ffffffc05040570c:	fec42703          	lw	a4,-20(s0)
ffffffc050405710:	c398                	sw	a4,0(a5)
ffffffc050405712:	fec42783          	lw	a5,-20(s0)
ffffffc050405716:	00c7979b          	slliw	a5,a5,0xc
ffffffc05040571a:	2781                	sext.w	a5,a5
ffffffc05040571c:	873e                	mv	a4,a5
ffffffc05040571e:	ff0187b7          	lui	a5,0xff018
ffffffc050405722:	80178793          	addi	a5,a5,-2047 # ffffffffff017801 <__BSS_END__+0x3faeba3419>
ffffffc050405726:	07ba                	slli	a5,a5,0xe
ffffffc050405728:	97ba                	add	a5,a5,a4
ffffffc05040572a:	a829                	j	ffffffc050405744 <alloc_pgtab+0xcc>
ffffffc05040572c:	00002617          	auipc	a2,0x2
ffffffc050405730:	ba460613          	addi	a2,a2,-1116 # ffffffc0504072d0 <__FUNCTION__.1468>
ffffffc050405734:	0a600593          	li	a1,166
ffffffc050405738:	00002517          	auipc	a0,0x2
ffffffc05040573c:	b7050513          	addi	a0,a0,-1168 # ffffffc0504072a8 <__FUNCTION__.1563+0x58>
ffffffc050405740:	bcbff0ef          	jal	ra,ffffffc05040530a <_panic>
ffffffc050405744:	853e                	mv	a0,a5
ffffffc050405746:	60e2                	ld	ra,24(sp)
ffffffc050405748:	6442                	ld	s0,16(sp)
ffffffc05040574a:	6105                	addi	sp,sp,32
ffffffc05040574c:	8082                	ret

ffffffc05040574e <alloc_uvm>:
ffffffc05040574e:	7119                	addi	sp,sp,-128
ffffffc050405750:	fc86                	sd	ra,120(sp)
ffffffc050405752:	f8a2                	sd	s0,112(sp)
ffffffc050405754:	f4a6                	sd	s1,104(sp)
ffffffc050405756:	0100                	addi	s0,sp,128
ffffffc050405758:	87aa                	mv	a5,a0
ffffffc05040575a:	f8f42623          	sw	a5,-116(s0)
ffffffc05040575e:	f1bff0ef          	jal	ra,ffffffc050405678 <alloc_pgtab>
ffffffc050405762:	87aa                	mv	a5,a0
ffffffc050405764:	fcf43423          	sd	a5,-56(s0)
ffffffc050405768:	f11ff0ef          	jal	ra,ffffffc050405678 <alloc_pgtab>
ffffffc05040576c:	87aa                	mv	a5,a0
ffffffc05040576e:	fcf43023          	sd	a5,-64(s0)
ffffffc050405772:	f07ff0ef          	jal	ra,ffffffc050405678 <alloc_pgtab>
ffffffc050405776:	87aa                	mv	a5,a0
ffffffc050405778:	faf43c23          	sd	a5,-72(s0)
ffffffc05040577c:	fc843783          	ld	a5,-56(s0)
ffffffc050405780:	853e                	mv	a0,a5
ffffffc050405782:	b65ff0ef          	jal	ra,ffffffc0504052e6 <clear_pgdir>
ffffffc050405786:	fc043783          	ld	a5,-64(s0)
ffffffc05040578a:	853e                	mv	a0,a5
ffffffc05040578c:	b5bff0ef          	jal	ra,ffffffc0504052e6 <clear_pgdir>
ffffffc050405790:	fb843783          	ld	a5,-72(s0)
ffffffc050405794:	853e                	mv	a0,a5
ffffffc050405796:	b51ff0ef          	jal	ra,ffffffc0504052e6 <clear_pgdir>
ffffffc05040579a:	fa043823          	sd	zero,-80(s0)
ffffffc05040579e:	fa043423          	sd	zero,-88(s0)
ffffffc0504057a2:	47c1                	li	a5,16
ffffffc0504057a4:	fcf43c23          	sd	a5,-40(s0)
ffffffc0504057a8:	fb043783          	ld	a5,-80(s0)
ffffffc0504057ac:	078e                	slli	a5,a5,0x3
ffffffc0504057ae:	fc843703          	ld	a4,-56(s0)
ffffffc0504057b2:	00f704b3          	add	s1,a4,a5
ffffffc0504057b6:	fc043783          	ld	a5,-64(s0)
ffffffc0504057ba:	853e                	mv	a0,a5
ffffffc0504057bc:	a4fff0ef          	jal	ra,ffffffc05040520a <kva2pa>
ffffffc0504057c0:	87aa                	mv	a5,a0
ffffffc0504057c2:	83b1                	srli	a5,a5,0xc
ffffffc0504057c4:	85be                	mv	a1,a5
ffffffc0504057c6:	8526                	mv	a0,s1
ffffffc0504057c8:	abfff0ef          	jal	ra,ffffffc050405286 <set_pfn>
ffffffc0504057cc:	fb043783          	ld	a5,-80(s0)
ffffffc0504057d0:	078e                	slli	a5,a5,0x3
ffffffc0504057d2:	fc843703          	ld	a4,-56(s0)
ffffffc0504057d6:	97ba                	add	a5,a5,a4
ffffffc0504057d8:	4585                	li	a1,1
ffffffc0504057da:	853e                	mv	a0,a5
ffffffc0504057dc:	ae3ff0ef          	jal	ra,ffffffc0504052be <set_attribute>
ffffffc0504057e0:	fa843783          	ld	a5,-88(s0)
ffffffc0504057e4:	078e                	slli	a5,a5,0x3
ffffffc0504057e6:	fc043703          	ld	a4,-64(s0)
ffffffc0504057ea:	00f704b3          	add	s1,a4,a5
ffffffc0504057ee:	fb843783          	ld	a5,-72(s0)
ffffffc0504057f2:	853e                	mv	a0,a5
ffffffc0504057f4:	a17ff0ef          	jal	ra,ffffffc05040520a <kva2pa>
ffffffc0504057f8:	87aa                	mv	a5,a0
ffffffc0504057fa:	83b1                	srli	a5,a5,0xc
ffffffc0504057fc:	85be                	mv	a1,a5
ffffffc0504057fe:	8526                	mv	a0,s1
ffffffc050405800:	a87ff0ef          	jal	ra,ffffffc050405286 <set_pfn>
ffffffc050405804:	fa843783          	ld	a5,-88(s0)
ffffffc050405808:	078e                	slli	a5,a5,0x3
ffffffc05040580a:	fc043703          	ld	a4,-64(s0)
ffffffc05040580e:	97ba                	add	a5,a5,a4
ffffffc050405810:	4585                	li	a1,1
ffffffc050405812:	853e                	mv	a0,a5
ffffffc050405814:	aabff0ef          	jal	ra,ffffffc0504052be <set_attribute>
ffffffc050405818:	fc042a23          	sw	zero,-44(s0)
ffffffc05040581c:	a895                	j	ffffffc050405890 <alloc_uvm+0x142>
ffffffc05040581e:	fd843783          	ld	a5,-40(s0)
ffffffc050405822:	078e                	slli	a5,a5,0x3
ffffffc050405824:	fb843703          	ld	a4,-72(s0)
ffffffc050405828:	97ba                	add	a5,a5,a4
ffffffc05040582a:	853e                	mv	a0,a5
ffffffc05040582c:	ba1ff0ef          	jal	ra,ffffffc0504053cc <alloc_ph_page>
ffffffc050405830:	f8a43c23          	sd	a0,-104(s0)
ffffffc050405834:	f9843783          	ld	a5,-104(s0)
ffffffc050405838:	6605                	lui	a2,0x1
ffffffc05040583a:	4581                	li	a1,0
ffffffc05040583c:	853e                	mv	a0,a5
ffffffc05040583e:	1c7000ef          	jal	ra,ffffffc050406204 <kmemset>
ffffffc050405842:	fd843783          	ld	a5,-40(s0)
ffffffc050405846:	078e                	slli	a5,a5,0x3
ffffffc050405848:	fb843703          	ld	a4,-72(s0)
ffffffc05040584c:	00f704b3          	add	s1,a4,a5
ffffffc050405850:	f9843503          	ld	a0,-104(s0)
ffffffc050405854:	9b7ff0ef          	jal	ra,ffffffc05040520a <kva2pa>
ffffffc050405858:	87aa                	mv	a5,a0
ffffffc05040585a:	83b1                	srli	a5,a5,0xc
ffffffc05040585c:	85be                	mv	a1,a5
ffffffc05040585e:	8526                	mv	a0,s1
ffffffc050405860:	a27ff0ef          	jal	ra,ffffffc050405286 <set_pfn>
ffffffc050405864:	fd843783          	ld	a5,-40(s0)
ffffffc050405868:	078e                	slli	a5,a5,0x3
ffffffc05040586a:	fb843703          	ld	a4,-72(s0)
ffffffc05040586e:	97ba                	add	a5,a5,a4
ffffffc050405870:	0df00593          	li	a1,223
ffffffc050405874:	853e                	mv	a0,a5
ffffffc050405876:	a49ff0ef          	jal	ra,ffffffc0504052be <set_attribute>
ffffffc05040587a:	fd843783          	ld	a5,-40(s0)
ffffffc05040587e:	0785                	addi	a5,a5,1
ffffffc050405880:	fcf43c23          	sd	a5,-40(s0)
ffffffc050405884:	fd442703          	lw	a4,-44(s0)
ffffffc050405888:	6785                	lui	a5,0x1
ffffffc05040588a:	9fb9                	addw	a5,a5,a4
ffffffc05040588c:	fcf42a23          	sw	a5,-44(s0)
ffffffc050405890:	fd442703          	lw	a4,-44(s0)
ffffffc050405894:	f8c42783          	lw	a5,-116(s0)
ffffffc050405898:	2781                	sext.w	a5,a5
ffffffc05040589a:	f8f762e3          	bltu	a4,a5,ffffffc05040581e <alloc_uvm+0xd0>
ffffffc05040589e:	ddbff0ef          	jal	ra,ffffffc050405678 <alloc_pgtab>
ffffffc0504058a2:	87aa                	mv	a5,a0
ffffffc0504058a4:	fcf43023          	sd	a5,-64(s0)
ffffffc0504058a8:	dd1ff0ef          	jal	ra,ffffffc050405678 <alloc_pgtab>
ffffffc0504058ac:	87aa                	mv	a5,a0
ffffffc0504058ae:	faf43c23          	sd	a5,-72(s0)
ffffffc0504058b2:	fc043783          	ld	a5,-64(s0)
ffffffc0504058b6:	853e                	mv	a0,a5
ffffffc0504058b8:	a2fff0ef          	jal	ra,ffffffc0504052e6 <clear_pgdir>
ffffffc0504058bc:	fb843783          	ld	a5,-72(s0)
ffffffc0504058c0:	853e                	mv	a0,a5
ffffffc0504058c2:	a25ff0ef          	jal	ra,ffffffc0504052e6 <clear_pgdir>
ffffffc0504058c6:	03c00793          	li	a5,60
ffffffc0504058ca:	faf43823          	sd	a5,-80(s0)
ffffffc0504058ce:	fa043423          	sd	zero,-88(s0)
ffffffc0504058d2:	47bd                	li	a5,15
ffffffc0504058d4:	fcf43c23          	sd	a5,-40(s0)
ffffffc0504058d8:	fb043783          	ld	a5,-80(s0)
ffffffc0504058dc:	078e                	slli	a5,a5,0x3
ffffffc0504058de:	fc843703          	ld	a4,-56(s0)
ffffffc0504058e2:	00f704b3          	add	s1,a4,a5
ffffffc0504058e6:	fc043783          	ld	a5,-64(s0)
ffffffc0504058ea:	853e                	mv	a0,a5
ffffffc0504058ec:	91fff0ef          	jal	ra,ffffffc05040520a <kva2pa>
ffffffc0504058f0:	87aa                	mv	a5,a0
ffffffc0504058f2:	83b1                	srli	a5,a5,0xc
ffffffc0504058f4:	85be                	mv	a1,a5
ffffffc0504058f6:	8526                	mv	a0,s1
ffffffc0504058f8:	98fff0ef          	jal	ra,ffffffc050405286 <set_pfn>
ffffffc0504058fc:	fb043783          	ld	a5,-80(s0)
ffffffc050405900:	078e                	slli	a5,a5,0x3
ffffffc050405902:	fc843703          	ld	a4,-56(s0)
ffffffc050405906:	97ba                	add	a5,a5,a4
ffffffc050405908:	4585                	li	a1,1
ffffffc05040590a:	853e                	mv	a0,a5
ffffffc05040590c:	9b3ff0ef          	jal	ra,ffffffc0504052be <set_attribute>
ffffffc050405910:	fa843783          	ld	a5,-88(s0)
ffffffc050405914:	078e                	slli	a5,a5,0x3
ffffffc050405916:	fc043703          	ld	a4,-64(s0)
ffffffc05040591a:	00f704b3          	add	s1,a4,a5
ffffffc05040591e:	fb843783          	ld	a5,-72(s0)
ffffffc050405922:	853e                	mv	a0,a5
ffffffc050405924:	8e7ff0ef          	jal	ra,ffffffc05040520a <kva2pa>
ffffffc050405928:	87aa                	mv	a5,a0
ffffffc05040592a:	83b1                	srli	a5,a5,0xc
ffffffc05040592c:	85be                	mv	a1,a5
ffffffc05040592e:	8526                	mv	a0,s1
ffffffc050405930:	957ff0ef          	jal	ra,ffffffc050405286 <set_pfn>
ffffffc050405934:	fa843783          	ld	a5,-88(s0)
ffffffc050405938:	078e                	slli	a5,a5,0x3
ffffffc05040593a:	fc043703          	ld	a4,-64(s0)
ffffffc05040593e:	97ba                	add	a5,a5,a4
ffffffc050405940:	4585                	li	a1,1
ffffffc050405942:	853e                	mv	a0,a5
ffffffc050405944:	97bff0ef          	jal	ra,ffffffc0504052be <set_attribute>
ffffffc050405948:	fd843783          	ld	a5,-40(s0)
ffffffc05040594c:	078e                	slli	a5,a5,0x3
ffffffc05040594e:	fb843703          	ld	a4,-72(s0)
ffffffc050405952:	97ba                	add	a5,a5,a4
ffffffc050405954:	853e                	mv	a0,a5
ffffffc050405956:	a77ff0ef          	jal	ra,ffffffc0504053cc <alloc_ph_page>
ffffffc05040595a:	faa43023          	sd	a0,-96(s0)
ffffffc05040595e:	fa043783          	ld	a5,-96(s0)
ffffffc050405962:	6605                	lui	a2,0x1
ffffffc050405964:	4581                	li	a1,0
ffffffc050405966:	853e                	mv	a0,a5
ffffffc050405968:	09d000ef          	jal	ra,ffffffc050406204 <kmemset>
ffffffc05040596c:	fd843783          	ld	a5,-40(s0)
ffffffc050405970:	078e                	slli	a5,a5,0x3
ffffffc050405972:	fb843703          	ld	a4,-72(s0)
ffffffc050405976:	00f704b3          	add	s1,a4,a5
ffffffc05040597a:	fa043503          	ld	a0,-96(s0)
ffffffc05040597e:	88dff0ef          	jal	ra,ffffffc05040520a <kva2pa>
ffffffc050405982:	87aa                	mv	a5,a0
ffffffc050405984:	83b1                	srli	a5,a5,0xc
ffffffc050405986:	85be                	mv	a1,a5
ffffffc050405988:	8526                	mv	a0,s1
ffffffc05040598a:	8fdff0ef          	jal	ra,ffffffc050405286 <set_pfn>
ffffffc05040598e:	fd843783          	ld	a5,-40(s0)
ffffffc050405992:	078e                	slli	a5,a5,0x3
ffffffc050405994:	fb843703          	ld	a4,-72(s0)
ffffffc050405998:	97ba                	add	a5,a5,a4
ffffffc05040599a:	0df00593          	li	a1,223
ffffffc05040599e:	853e                	mv	a0,a5
ffffffc0504059a0:	91fff0ef          	jal	ra,ffffffc0504052be <set_attribute>
ffffffc0504059a4:	fc843783          	ld	a5,-56(s0)
ffffffc0504059a8:	853e                	mv	a0,a5
ffffffc0504059aa:	70e6                	ld	ra,120(sp)
ffffffc0504059ac:	7446                	ld	s0,112(sp)
ffffffc0504059ae:	74a6                	ld	s1,104(sp)
ffffffc0504059b0:	6109                	addi	sp,sp,128
ffffffc0504059b2:	8082                	ret

ffffffc0504059b4 <dealloc_uvm>:
ffffffc0504059b4:	711d                	addi	sp,sp,-96
ffffffc0504059b6:	ec86                	sd	ra,88(sp)
ffffffc0504059b8:	e8a2                	sd	s0,80(sp)
ffffffc0504059ba:	1080                	addi	s0,sp,96
ffffffc0504059bc:	faa43423          	sd	a0,-88(s0)
ffffffc0504059c0:	fe042623          	sw	zero,-20(s0)
ffffffc0504059c4:	a439                	j	ffffffc050405bd2 <dealloc_uvm+0x21e>
ffffffc0504059c6:	fec42783          	lw	a5,-20(s0)
ffffffc0504059ca:	078e                	slli	a5,a5,0x3
ffffffc0504059cc:	fa843703          	ld	a4,-88(s0)
ffffffc0504059d0:	97ba                	add	a5,a5,a4
ffffffc0504059d2:	639c                	ld	a5,0(a5)
ffffffc0504059d4:	8b85                	andi	a5,a5,1
ffffffc0504059d6:	1e078163          	beqz	a5,ffffffc050405bb8 <dealloc_uvm+0x204>
ffffffc0504059da:	fec42783          	lw	a5,-20(s0)
ffffffc0504059de:	078e                	slli	a5,a5,0x3
ffffffc0504059e0:	fa843703          	ld	a4,-88(s0)
ffffffc0504059e4:	97ba                	add	a5,a5,a4
ffffffc0504059e6:	639c                	ld	a5,0(a5)
ffffffc0504059e8:	853e                	mv	a0,a5
ffffffc0504059ea:	859ff0ef          	jal	ra,ffffffc050405242 <get_pa>
ffffffc0504059ee:	87aa                	mv	a5,a0
ffffffc0504059f0:	853e                	mv	a0,a5
ffffffc0504059f2:	835ff0ef          	jal	ra,ffffffc050405226 <pa2kva>
ffffffc0504059f6:	87aa                	mv	a5,a0
ffffffc0504059f8:	fcf43c23          	sd	a5,-40(s0)
ffffffc0504059fc:	fe042423          	sw	zero,-24(s0)
ffffffc050405a00:	aaad                	j	ffffffc050405b7a <dealloc_uvm+0x1c6>
ffffffc050405a02:	fe842783          	lw	a5,-24(s0)
ffffffc050405a06:	078e                	slli	a5,a5,0x3
ffffffc050405a08:	fd843703          	ld	a4,-40(s0)
ffffffc050405a0c:	97ba                	add	a5,a5,a4
ffffffc050405a0e:	639c                	ld	a5,0(a5)
ffffffc050405a10:	8b85                	andi	a5,a5,1
ffffffc050405a12:	14078763          	beqz	a5,ffffffc050405b60 <dealloc_uvm+0x1ac>
ffffffc050405a16:	fe842783          	lw	a5,-24(s0)
ffffffc050405a1a:	078e                	slli	a5,a5,0x3
ffffffc050405a1c:	fd843703          	ld	a4,-40(s0)
ffffffc050405a20:	97ba                	add	a5,a5,a4
ffffffc050405a22:	639c                	ld	a5,0(a5)
ffffffc050405a24:	853e                	mv	a0,a5
ffffffc050405a26:	81dff0ef          	jal	ra,ffffffc050405242 <get_pa>
ffffffc050405a2a:	87aa                	mv	a5,a0
ffffffc050405a2c:	853e                	mv	a0,a5
ffffffc050405a2e:	ff8ff0ef          	jal	ra,ffffffc050405226 <pa2kva>
ffffffc050405a32:	87aa                	mv	a5,a0
ffffffc050405a34:	fcf43423          	sd	a5,-56(s0)
ffffffc050405a38:	fe042223          	sw	zero,-28(s0)
ffffffc050405a3c:	a0dd                	j	ffffffc050405b22 <dealloc_uvm+0x16e>
ffffffc050405a3e:	fe442783          	lw	a5,-28(s0)
ffffffc050405a42:	078e                	slli	a5,a5,0x3
ffffffc050405a44:	fc843703          	ld	a4,-56(s0)
ffffffc050405a48:	97ba                	add	a5,a5,a4
ffffffc050405a4a:	639c                	ld	a5,0(a5)
ffffffc050405a4c:	8b85                	andi	a5,a5,1
ffffffc050405a4e:	c3bd                	beqz	a5,ffffffc050405ab4 <dealloc_uvm+0x100>
ffffffc050405a50:	fe442783          	lw	a5,-28(s0)
ffffffc050405a54:	078e                	slli	a5,a5,0x3
ffffffc050405a56:	fc843703          	ld	a4,-56(s0)
ffffffc050405a5a:	97ba                	add	a5,a5,a4
ffffffc050405a5c:	639c                	ld	a5,0(a5)
ffffffc050405a5e:	853e                	mv	a0,a5
ffffffc050405a60:	fe2ff0ef          	jal	ra,ffffffc050405242 <get_pa>
ffffffc050405a64:	87aa                	mv	a5,a0
ffffffc050405a66:	faf43c23          	sd	a5,-72(s0)
ffffffc050405a6a:	fb843783          	ld	a5,-72(s0)
ffffffc050405a6e:	0007871b          	sext.w	a4,a5
ffffffc050405a72:	83818793          	addi	a5,gp,-1992 # ffffffc05045f8f0 <user_free_space>
ffffffc050405a76:	639c                	ld	a5,0(a5)
ffffffc050405a78:	2781                	sext.w	a5,a5
ffffffc050405a7a:	40f707bb          	subw	a5,a4,a5
ffffffc050405a7e:	2781                	sext.w	a5,a5
ffffffc050405a80:	00c7d79b          	srliw	a5,a5,0xc
ffffffc050405a84:	2781                	sext.w	a5,a5
ffffffc050405a86:	faf42a23          	sw	a5,-76(s0)
ffffffc050405a8a:	00064717          	auipc	a4,0x64
ffffffc050405a8e:	ff670713          	addi	a4,a4,-10 # ffffffc050469a80 <ph_page_array>
ffffffc050405a92:	fb442783          	lw	a5,-76(s0)
ffffffc050405a96:	0792                	slli	a5,a5,0x4
ffffffc050405a98:	97ba                	add	a5,a5,a4
ffffffc050405a9a:	0007a023          	sw	zero,0(a5) # 1000 <_start-0xffffffc0503ff000>
ffffffc050405a9e:	00064717          	auipc	a4,0x64
ffffffc050405aa2:	fe270713          	addi	a4,a4,-30 # ffffffc050469a80 <ph_page_array>
ffffffc050405aa6:	fb442783          	lw	a5,-76(s0)
ffffffc050405aaa:	0792                	slli	a5,a5,0x4
ffffffc050405aac:	97ba                	add	a5,a5,a4
ffffffc050405aae:	0007b423          	sd	zero,8(a5)
ffffffc050405ab2:	a899                	j	ffffffc050405b08 <dealloc_uvm+0x154>
ffffffc050405ab4:	fe442783          	lw	a5,-28(s0)
ffffffc050405ab8:	078e                	slli	a5,a5,0x3
ffffffc050405aba:	fc843703          	ld	a4,-56(s0)
ffffffc050405abe:	97ba                	add	a5,a5,a4
ffffffc050405ac0:	639c                	ld	a5,0(a5)
ffffffc050405ac2:	1007f793          	andi	a5,a5,256
ffffffc050405ac6:	c3a9                	beqz	a5,ffffffc050405b08 <dealloc_uvm+0x154>
ffffffc050405ac8:	fe442783          	lw	a5,-28(s0)
ffffffc050405acc:	078e                	slli	a5,a5,0x3
ffffffc050405ace:	fc843703          	ld	a4,-56(s0)
ffffffc050405ad2:	97ba                	add	a5,a5,a4
ffffffc050405ad4:	639c                	ld	a5,0(a5)
ffffffc050405ad6:	853e                	mv	a0,a5
ffffffc050405ad8:	f8eff0ef          	jal	ra,ffffffc050405266 <get_pfn>
ffffffc050405adc:	87aa                	mv	a5,a0
ffffffc050405ade:	fcf42023          	sw	a5,-64(s0)
ffffffc050405ae2:	fc042783          	lw	a5,-64(s0)
ffffffc050405ae6:	8007879b          	addiw	a5,a5,-2048
ffffffc050405aea:	2781                	sext.w	a5,a5
ffffffc050405aec:	2781                	sext.w	a5,a5
ffffffc050405aee:	0037d79b          	srliw	a5,a5,0x3
ffffffc050405af2:	2781                	sext.w	a5,a5
ffffffc050405af4:	00064717          	auipc	a4,0x64
ffffffc050405af8:	78c70713          	addi	a4,a4,1932 # ffffffc05046a280 <swap_page_array>
ffffffc050405afc:	1782                	slli	a5,a5,0x20
ffffffc050405afe:	9381                	srli	a5,a5,0x20
ffffffc050405b00:	078a                	slli	a5,a5,0x2
ffffffc050405b02:	97ba                	add	a5,a5,a4
ffffffc050405b04:	0007a023          	sw	zero,0(a5)
ffffffc050405b08:	fe442783          	lw	a5,-28(s0)
ffffffc050405b0c:	078e                	slli	a5,a5,0x3
ffffffc050405b0e:	fc843703          	ld	a4,-56(s0)
ffffffc050405b12:	97ba                	add	a5,a5,a4
ffffffc050405b14:	0007b023          	sd	zero,0(a5)
ffffffc050405b18:	fe442783          	lw	a5,-28(s0)
ffffffc050405b1c:	2785                	addiw	a5,a5,1
ffffffc050405b1e:	fef42223          	sw	a5,-28(s0)
ffffffc050405b22:	fe442783          	lw	a5,-28(s0)
ffffffc050405b26:	0007871b          	sext.w	a4,a5
ffffffc050405b2a:	1ff00793          	li	a5,511
ffffffc050405b2e:	f0e7d8e3          	bge	a5,a4,ffffffc050405a3e <dealloc_uvm+0x8a>
ffffffc050405b32:	fc843783          	ld	a5,-56(s0)
ffffffc050405b36:	0007871b          	sext.w	a4,a5
ffffffc050405b3a:	a1ffc7b7          	lui	a5,0xa1ffc
ffffffc050405b3e:	9fb9                	addw	a5,a5,a4
ffffffc050405b40:	2781                	sext.w	a5,a5
ffffffc050405b42:	00c7d79b          	srliw	a5,a5,0xc
ffffffc050405b46:	2781                	sext.w	a5,a5
ffffffc050405b48:	fcf42223          	sw	a5,-60(s0)
ffffffc050405b4c:	0005c717          	auipc	a4,0x5c
ffffffc050405b50:	fa470713          	addi	a4,a4,-92 # ffffffc050461af0 <page_tab_array>
ffffffc050405b54:	fc442783          	lw	a5,-60(s0)
ffffffc050405b58:	078a                	slli	a5,a5,0x2
ffffffc050405b5a:	97ba                	add	a5,a5,a4
ffffffc050405b5c:	0007a023          	sw	zero,0(a5) # ffffffffa1ffc000 <__BSS_END__+0x3f51b87c18>
ffffffc050405b60:	fe842783          	lw	a5,-24(s0)
ffffffc050405b64:	078e                	slli	a5,a5,0x3
ffffffc050405b66:	fd843703          	ld	a4,-40(s0)
ffffffc050405b6a:	97ba                	add	a5,a5,a4
ffffffc050405b6c:	0007b023          	sd	zero,0(a5)
ffffffc050405b70:	fe842783          	lw	a5,-24(s0)
ffffffc050405b74:	2785                	addiw	a5,a5,1
ffffffc050405b76:	fef42423          	sw	a5,-24(s0)
ffffffc050405b7a:	fe842783          	lw	a5,-24(s0)
ffffffc050405b7e:	0007871b          	sext.w	a4,a5
ffffffc050405b82:	1ff00793          	li	a5,511
ffffffc050405b86:	e6e7dee3          	bge	a5,a4,ffffffc050405a02 <dealloc_uvm+0x4e>
ffffffc050405b8a:	fd843783          	ld	a5,-40(s0)
ffffffc050405b8e:	0007871b          	sext.w	a4,a5
ffffffc050405b92:	a1ffc7b7          	lui	a5,0xa1ffc
ffffffc050405b96:	9fb9                	addw	a5,a5,a4
ffffffc050405b98:	2781                	sext.w	a5,a5
ffffffc050405b9a:	00c7d79b          	srliw	a5,a5,0xc
ffffffc050405b9e:	2781                	sext.w	a5,a5
ffffffc050405ba0:	fcf42a23          	sw	a5,-44(s0)
ffffffc050405ba4:	0005c717          	auipc	a4,0x5c
ffffffc050405ba8:	f4c70713          	addi	a4,a4,-180 # ffffffc050461af0 <page_tab_array>
ffffffc050405bac:	fd442783          	lw	a5,-44(s0)
ffffffc050405bb0:	078a                	slli	a5,a5,0x2
ffffffc050405bb2:	97ba                	add	a5,a5,a4
ffffffc050405bb4:	0007a023          	sw	zero,0(a5) # ffffffffa1ffc000 <__BSS_END__+0x3f51b87c18>
ffffffc050405bb8:	fec42783          	lw	a5,-20(s0)
ffffffc050405bbc:	078e                	slli	a5,a5,0x3
ffffffc050405bbe:	fa843703          	ld	a4,-88(s0)
ffffffc050405bc2:	97ba                	add	a5,a5,a4
ffffffc050405bc4:	0007b023          	sd	zero,0(a5)
ffffffc050405bc8:	fec42783          	lw	a5,-20(s0)
ffffffc050405bcc:	2785                	addiw	a5,a5,1
ffffffc050405bce:	fef42623          	sw	a5,-20(s0)
ffffffc050405bd2:	fec42783          	lw	a5,-20(s0)
ffffffc050405bd6:	873e                	mv	a4,a5
ffffffc050405bd8:	10000793          	li	a5,256
ffffffc050405bdc:	dee7f5e3          	bgeu	a5,a4,ffffffc0504059c6 <dealloc_uvm+0x12>
ffffffc050405be0:	0001                	nop
ffffffc050405be2:	0001                	nop
ffffffc050405be4:	60e6                	ld	ra,88(sp)
ffffffc050405be6:	6446                	ld	s0,80(sp)
ffffffc050405be8:	6125                	addi	sp,sp,96
ffffffc050405bea:	8082                	ret

ffffffc050405bec <unmap_kvm>:
ffffffc050405bec:	7139                	addi	sp,sp,-64
ffffffc050405bee:	fc06                	sd	ra,56(sp)
ffffffc050405bf0:	f822                	sd	s0,48(sp)
ffffffc050405bf2:	0080                	addi	s0,sp,64
ffffffc050405bf4:	fca43423          	sd	a0,-56(s0)
ffffffc050405bf8:	fc843703          	ld	a4,-56(s0)
ffffffc050405bfc:	6785                	lui	a5,0x1
ffffffc050405bfe:	80878793          	addi	a5,a5,-2040 # 808 <_start-0xffffffc0503ff7f8>
ffffffc050405c02:	97ba                	add	a5,a5,a4
ffffffc050405c04:	639c                	ld	a5,0(a5)
ffffffc050405c06:	853e                	mv	a0,a5
ffffffc050405c08:	e3aff0ef          	jal	ra,ffffffc050405242 <get_pa>
ffffffc050405c0c:	87aa                	mv	a5,a0
ffffffc050405c0e:	fef42423          	sw	a5,-24(s0)
ffffffc050405c12:	fe846783          	lwu	a5,-24(s0)
ffffffc050405c16:	853e                	mv	a0,a5
ffffffc050405c18:	e0eff0ef          	jal	ra,ffffffc050405226 <pa2kva>
ffffffc050405c1c:	87aa                	mv	a5,a0
ffffffc050405c1e:	fef43023          	sd	a5,-32(s0)
ffffffc050405c22:	08100793          	li	a5,129
ffffffc050405c26:	fef42623          	sw	a5,-20(s0)
ffffffc050405c2a:	a831                	j	ffffffc050405c46 <unmap_kvm+0x5a>
ffffffc050405c2c:	fec42783          	lw	a5,-20(s0)
ffffffc050405c30:	078e                	slli	a5,a5,0x3
ffffffc050405c32:	fe043703          	ld	a4,-32(s0)
ffffffc050405c36:	97ba                	add	a5,a5,a4
ffffffc050405c38:	0007b023          	sd	zero,0(a5)
ffffffc050405c3c:	fec42783          	lw	a5,-20(s0)
ffffffc050405c40:	2785                	addiw	a5,a5,1
ffffffc050405c42:	fef42623          	sw	a5,-20(s0)
ffffffc050405c46:	fec42783          	lw	a5,-20(s0)
ffffffc050405c4a:	873e                	mv	a4,a5
ffffffc050405c4c:	0ff00793          	li	a5,255
ffffffc050405c50:	fce7fee3          	bgeu	a5,a4,ffffffc050405c2c <unmap_kvm+0x40>
ffffffc050405c54:	fe043783          	ld	a5,-32(s0)
ffffffc050405c58:	0007871b          	sext.w	a4,a5
ffffffc050405c5c:	a1ffc7b7          	lui	a5,0xa1ffc
ffffffc050405c60:	9fb9                	addw	a5,a5,a4
ffffffc050405c62:	2781                	sext.w	a5,a5
ffffffc050405c64:	00c7d79b          	srliw	a5,a5,0xc
ffffffc050405c68:	2781                	sext.w	a5,a5
ffffffc050405c6a:	fcf42e23          	sw	a5,-36(s0)
ffffffc050405c6e:	0005c717          	auipc	a4,0x5c
ffffffc050405c72:	e8270713          	addi	a4,a4,-382 # ffffffc050461af0 <page_tab_array>
ffffffc050405c76:	fdc42783          	lw	a5,-36(s0)
ffffffc050405c7a:	078a                	slli	a5,a5,0x2
ffffffc050405c7c:	97ba                	add	a5,a5,a4
ffffffc050405c7e:	0007a023          	sw	zero,0(a5) # ffffffffa1ffc000 <__BSS_END__+0x3f51b87c18>
ffffffc050405c82:	fc843703          	ld	a4,-56(s0)
ffffffc050405c86:	6785                	lui	a5,0x1
ffffffc050405c88:	80878793          	addi	a5,a5,-2040 # 808 <_start-0xffffffc0503ff7f8>
ffffffc050405c8c:	97ba                	add	a5,a5,a4
ffffffc050405c8e:	0007b023          	sd	zero,0(a5)
ffffffc050405c92:	0001                	nop
ffffffc050405c94:	70e2                	ld	ra,56(sp)
ffffffc050405c96:	7442                	ld	s0,48(sp)
ffffffc050405c98:	6121                	addi	sp,sp,64
ffffffc050405c9a:	8082                	ret

ffffffc050405c9c <switch_init_kdir>:
ffffffc050405c9c:	1141                	addi	sp,sp,-16
ffffffc050405c9e:	e406                	sd	ra,8(sp)
ffffffc050405ca0:	e022                	sd	s0,0(sp)
ffffffc050405ca2:	0800                	addi	s0,sp,16
ffffffc050405ca4:	0005e637          	lui	a2,0x5e
ffffffc050405ca8:	4581                	li	a1,0
ffffffc050405caa:	4521                	li	a0,8
ffffffc050405cac:	d18ff0ef          	jal	ra,ffffffc0504051c4 <set_satp>
ffffffc050405cb0:	cf0ff0ef          	jal	ra,ffffffc0504051a0 <local_flush_tlb_all>
ffffffc050405cb4:	0001                	nop
ffffffc050405cb6:	60a2                	ld	ra,8(sp)
ffffffc050405cb8:	6402                	ld	s0,0(sp)
ffffffc050405cba:	0141                	addi	sp,sp,16
ffffffc050405cbc:	8082                	ret

ffffffc050405cbe <map_kernel_page>:
ffffffc050405cbe:	711d                	addi	sp,sp,-96
ffffffc050405cc0:	ec86                	sd	ra,88(sp)
ffffffc050405cc2:	e8a2                	sd	s0,80(sp)
ffffffc050405cc4:	e4a6                	sd	s1,72(sp)
ffffffc050405cc6:	1080                	addi	s0,sp,96
ffffffc050405cc8:	faa43c23          	sd	a0,-72(s0)
ffffffc050405ccc:	fab43823          	sd	a1,-80(s0)
ffffffc050405cd0:	fac43423          	sd	a2,-88(s0)
ffffffc050405cd4:	fb843703          	ld	a4,-72(s0)
ffffffc050405cd8:	57fd                	li	a5,-1
ffffffc050405cda:	83e5                	srli	a5,a5,0x19
ffffffc050405cdc:	8ff9                	and	a5,a5,a4
ffffffc050405cde:	faf43c23          	sd	a5,-72(s0)
ffffffc050405ce2:	fb843783          	ld	a5,-72(s0)
ffffffc050405ce6:	83f9                	srli	a5,a5,0x1e
ffffffc050405ce8:	fcf43c23          	sd	a5,-40(s0)
ffffffc050405cec:	fd843783          	ld	a5,-40(s0)
ffffffc050405cf0:	00979713          	slli	a4,a5,0x9
ffffffc050405cf4:	fb843783          	ld	a5,-72(s0)
ffffffc050405cf8:	83d5                	srli	a5,a5,0x15
ffffffc050405cfa:	8fb9                	xor	a5,a5,a4
ffffffc050405cfc:	fcf43823          	sd	a5,-48(s0)
ffffffc050405d00:	fd843783          	ld	a5,-40(s0)
ffffffc050405d04:	078e                	slli	a5,a5,0x3
ffffffc050405d06:	fa843703          	ld	a4,-88(s0)
ffffffc050405d0a:	97ba                	add	a5,a5,a4
ffffffc050405d0c:	639c                	ld	a5,0(a5)
ffffffc050405d0e:	e3a5                	bnez	a5,ffffffc050405d6e <map_kernel_page+0xb0>
ffffffc050405d10:	fd843783          	ld	a5,-40(s0)
ffffffc050405d14:	078e                	slli	a5,a5,0x3
ffffffc050405d16:	fa843703          	ld	a4,-88(s0)
ffffffc050405d1a:	00f704b3          	add	s1,a4,a5
ffffffc050405d1e:	95bff0ef          	jal	ra,ffffffc050405678 <alloc_pgtab>
ffffffc050405d22:	87aa                	mv	a5,a0
ffffffc050405d24:	853e                	mv	a0,a5
ffffffc050405d26:	ce4ff0ef          	jal	ra,ffffffc05040520a <kva2pa>
ffffffc050405d2a:	87aa                	mv	a5,a0
ffffffc050405d2c:	83b1                	srli	a5,a5,0xc
ffffffc050405d2e:	85be                	mv	a1,a5
ffffffc050405d30:	8526                	mv	a0,s1
ffffffc050405d32:	d54ff0ef          	jal	ra,ffffffc050405286 <set_pfn>
ffffffc050405d36:	fd843783          	ld	a5,-40(s0)
ffffffc050405d3a:	078e                	slli	a5,a5,0x3
ffffffc050405d3c:	fa843703          	ld	a4,-88(s0)
ffffffc050405d40:	97ba                	add	a5,a5,a4
ffffffc050405d42:	4585                	li	a1,1
ffffffc050405d44:	853e                	mv	a0,a5
ffffffc050405d46:	d78ff0ef          	jal	ra,ffffffc0504052be <set_attribute>
ffffffc050405d4a:	fd843783          	ld	a5,-40(s0)
ffffffc050405d4e:	078e                	slli	a5,a5,0x3
ffffffc050405d50:	fa843703          	ld	a4,-88(s0)
ffffffc050405d54:	97ba                	add	a5,a5,a4
ffffffc050405d56:	639c                	ld	a5,0(a5)
ffffffc050405d58:	853e                	mv	a0,a5
ffffffc050405d5a:	ce8ff0ef          	jal	ra,ffffffc050405242 <get_pa>
ffffffc050405d5e:	87aa                	mv	a5,a0
ffffffc050405d60:	853e                	mv	a0,a5
ffffffc050405d62:	cc4ff0ef          	jal	ra,ffffffc050405226 <pa2kva>
ffffffc050405d66:	87aa                	mv	a5,a0
ffffffc050405d68:	853e                	mv	a0,a5
ffffffc050405d6a:	d7cff0ef          	jal	ra,ffffffc0504052e6 <clear_pgdir>
ffffffc050405d6e:	fd843783          	ld	a5,-40(s0)
ffffffc050405d72:	078e                	slli	a5,a5,0x3
ffffffc050405d74:	fa843703          	ld	a4,-88(s0)
ffffffc050405d78:	97ba                	add	a5,a5,a4
ffffffc050405d7a:	639c                	ld	a5,0(a5)
ffffffc050405d7c:	853e                	mv	a0,a5
ffffffc050405d7e:	cc4ff0ef          	jal	ra,ffffffc050405242 <get_pa>
ffffffc050405d82:	87aa                	mv	a5,a0
ffffffc050405d84:	853e                	mv	a0,a5
ffffffc050405d86:	ca0ff0ef          	jal	ra,ffffffc050405226 <pa2kva>
ffffffc050405d8a:	87aa                	mv	a5,a0
ffffffc050405d8c:	fcf43423          	sd	a5,-56(s0)
ffffffc050405d90:	fd043783          	ld	a5,-48(s0)
ffffffc050405d94:	078e                	slli	a5,a5,0x3
ffffffc050405d96:	fc843703          	ld	a4,-56(s0)
ffffffc050405d9a:	973e                	add	a4,a4,a5
ffffffc050405d9c:	fb043783          	ld	a5,-80(s0)
ffffffc050405da0:	83b1                	srli	a5,a5,0xc
ffffffc050405da2:	85be                	mv	a1,a5
ffffffc050405da4:	853a                	mv	a0,a4
ffffffc050405da6:	ce0ff0ef          	jal	ra,ffffffc050405286 <set_pfn>
ffffffc050405daa:	fd043783          	ld	a5,-48(s0)
ffffffc050405dae:	078e                	slli	a5,a5,0x3
ffffffc050405db0:	fc843703          	ld	a4,-56(s0)
ffffffc050405db4:	97ba                	add	a5,a5,a4
ffffffc050405db6:	0cf00593          	li	a1,207
ffffffc050405dba:	853e                	mv	a0,a5
ffffffc050405dbc:	d02ff0ef          	jal	ra,ffffffc0504052be <set_attribute>
ffffffc050405dc0:	0001                	nop
ffffffc050405dc2:	60e6                	ld	ra,88(sp)
ffffffc050405dc4:	6446                	ld	s0,80(sp)
ffffffc050405dc6:	64a6                	ld	s1,72(sp)
ffffffc050405dc8:	6125                	addi	sp,sp,96
ffffffc050405dca:	8082                	ret

ffffffc050405dcc <map_kvm>:
ffffffc050405dcc:	7179                	addi	sp,sp,-48
ffffffc050405dce:	f406                	sd	ra,40(sp)
ffffffc050405dd0:	f022                	sd	s0,32(sp)
ffffffc050405dd2:	1800                	addi	s0,sp,48
ffffffc050405dd4:	fca43c23          	sd	a0,-40(s0)
ffffffc050405dd8:	e02817b7          	lui	a5,0xe0281
ffffffc050405ddc:	07a6                	slli	a5,a5,0x9
ffffffc050405dde:	fef43423          	sd	a5,-24(s0)
ffffffc050405de2:	a025                	j	ffffffc050405e0a <map_kvm+0x3e>
ffffffc050405de4:	fe843503          	ld	a0,-24(s0)
ffffffc050405de8:	c22ff0ef          	jal	ra,ffffffc05040520a <kva2pa>
ffffffc050405dec:	87aa                	mv	a5,a0
ffffffc050405dee:	fd843603          	ld	a2,-40(s0)
ffffffc050405df2:	85be                	mv	a1,a5
ffffffc050405df4:	fe843503          	ld	a0,-24(s0)
ffffffc050405df8:	ec7ff0ef          	jal	ra,ffffffc050405cbe <map_kernel_page>
ffffffc050405dfc:	fe843703          	ld	a4,-24(s0)
ffffffc050405e00:	002007b7          	lui	a5,0x200
ffffffc050405e04:	97ba                	add	a5,a5,a4
ffffffc050405e06:	fef43423          	sd	a5,-24(s0)
ffffffc050405e0a:	fe843703          	ld	a4,-24(s0)
ffffffc050405e0e:	e0300793          	li	a5,-509
ffffffc050405e12:	07f6                	slli	a5,a5,0x1d
ffffffc050405e14:	fcf768e3          	bltu	a4,a5,ffffffc050405de4 <map_kvm+0x18>
ffffffc050405e18:	0001                	nop
ffffffc050405e1a:	70a2                	ld	ra,40(sp)
ffffffc050405e1c:	7402                	ld	s0,32(sp)
ffffffc050405e1e:	6145                	addi	sp,sp,48
ffffffc050405e20:	8082                	ret

ffffffc050405e22 <alloc_page_helper>:
ffffffc050405e22:	7119                	addi	sp,sp,-128
ffffffc050405e24:	fc86                	sd	ra,120(sp)
ffffffc050405e26:	f8a2                	sd	s0,112(sp)
ffffffc050405e28:	f4a6                	sd	s1,104(sp)
ffffffc050405e2a:	0100                	addi	s0,sp,128
ffffffc050405e2c:	f8a43423          	sd	a0,-120(s0)
ffffffc050405e30:	f8b43023          	sd	a1,-128(s0)
ffffffc050405e34:	f8843703          	ld	a4,-120(s0)
ffffffc050405e38:	57fd                	li	a5,-1
ffffffc050405e3a:	83e5                	srli	a5,a5,0x19
ffffffc050405e3c:	8ff9                	and	a5,a5,a4
ffffffc050405e3e:	f8f43423          	sd	a5,-120(s0)
ffffffc050405e42:	f8843703          	ld	a4,-120(s0)
ffffffc050405e46:	57fd                	li	a5,-1
ffffffc050405e48:	179a                	slli	a5,a5,0x26
ffffffc050405e4a:	8ff9                	and	a5,a5,a4
ffffffc050405e4c:	2a079a63          	bnez	a5,ffffffc050406100 <alloc_page_helper+0x2de>
ffffffc050405e50:	f8843783          	ld	a5,-120(s0)
ffffffc050405e54:	83f9                	srli	a5,a5,0x1e
ffffffc050405e56:	1ff7f793          	andi	a5,a5,511
ffffffc050405e5a:	fcf43c23          	sd	a5,-40(s0)
ffffffc050405e5e:	f8843783          	ld	a5,-120(s0)
ffffffc050405e62:	83d5                	srli	a5,a5,0x15
ffffffc050405e64:	1ff7f793          	andi	a5,a5,511
ffffffc050405e68:	fcf43823          	sd	a5,-48(s0)
ffffffc050405e6c:	f8843783          	ld	a5,-120(s0)
ffffffc050405e70:	83b1                	srli	a5,a5,0xc
ffffffc050405e72:	1ff7f793          	andi	a5,a5,511
ffffffc050405e76:	fcf43423          	sd	a5,-56(s0)
ffffffc050405e7a:	f8843703          	ld	a4,-120(s0)
ffffffc050405e7e:	6785                	lui	a5,0x1
ffffffc050405e80:	17fd                	addi	a5,a5,-1
ffffffc050405e82:	8ff9                	and	a5,a5,a4
ffffffc050405e84:	fcf43023          	sd	a5,-64(s0)
ffffffc050405e88:	fd843783          	ld	a5,-40(s0)
ffffffc050405e8c:	078e                	slli	a5,a5,0x3
ffffffc050405e8e:	f8043703          	ld	a4,-128(s0)
ffffffc050405e92:	97ba                	add	a5,a5,a4
ffffffc050405e94:	639c                	ld	a5,0(a5)
ffffffc050405e96:	8b85                	andi	a5,a5,1
ffffffc050405e98:	e3a5                	bnez	a5,ffffffc050405ef8 <alloc_page_helper+0xd6>
ffffffc050405e9a:	fd843783          	ld	a5,-40(s0)
ffffffc050405e9e:	078e                	slli	a5,a5,0x3
ffffffc050405ea0:	f8043703          	ld	a4,-128(s0)
ffffffc050405ea4:	00f704b3          	add	s1,a4,a5
ffffffc050405ea8:	fd0ff0ef          	jal	ra,ffffffc050405678 <alloc_pgtab>
ffffffc050405eac:	87aa                	mv	a5,a0
ffffffc050405eae:	853e                	mv	a0,a5
ffffffc050405eb0:	b5aff0ef          	jal	ra,ffffffc05040520a <kva2pa>
ffffffc050405eb4:	87aa                	mv	a5,a0
ffffffc050405eb6:	83b1                	srli	a5,a5,0xc
ffffffc050405eb8:	85be                	mv	a1,a5
ffffffc050405eba:	8526                	mv	a0,s1
ffffffc050405ebc:	bcaff0ef          	jal	ra,ffffffc050405286 <set_pfn>
ffffffc050405ec0:	fd843783          	ld	a5,-40(s0)
ffffffc050405ec4:	078e                	slli	a5,a5,0x3
ffffffc050405ec6:	f8043703          	ld	a4,-128(s0)
ffffffc050405eca:	97ba                	add	a5,a5,a4
ffffffc050405ecc:	4585                	li	a1,1
ffffffc050405ece:	853e                	mv	a0,a5
ffffffc050405ed0:	beeff0ef          	jal	ra,ffffffc0504052be <set_attribute>
ffffffc050405ed4:	fd843783          	ld	a5,-40(s0)
ffffffc050405ed8:	078e                	slli	a5,a5,0x3
ffffffc050405eda:	f8043703          	ld	a4,-128(s0)
ffffffc050405ede:	97ba                	add	a5,a5,a4
ffffffc050405ee0:	639c                	ld	a5,0(a5)
ffffffc050405ee2:	853e                	mv	a0,a5
ffffffc050405ee4:	b5eff0ef          	jal	ra,ffffffc050405242 <get_pa>
ffffffc050405ee8:	87aa                	mv	a5,a0
ffffffc050405eea:	853e                	mv	a0,a5
ffffffc050405eec:	b3aff0ef          	jal	ra,ffffffc050405226 <pa2kva>
ffffffc050405ef0:	87aa                	mv	a5,a0
ffffffc050405ef2:	853e                	mv	a0,a5
ffffffc050405ef4:	bf2ff0ef          	jal	ra,ffffffc0504052e6 <clear_pgdir>
ffffffc050405ef8:	fd843783          	ld	a5,-40(s0)
ffffffc050405efc:	078e                	slli	a5,a5,0x3
ffffffc050405efe:	f8043703          	ld	a4,-128(s0)
ffffffc050405f02:	97ba                	add	a5,a5,a4
ffffffc050405f04:	639c                	ld	a5,0(a5)
ffffffc050405f06:	853e                	mv	a0,a5
ffffffc050405f08:	b3aff0ef          	jal	ra,ffffffc050405242 <get_pa>
ffffffc050405f0c:	87aa                	mv	a5,a0
ffffffc050405f0e:	853e                	mv	a0,a5
ffffffc050405f10:	b16ff0ef          	jal	ra,ffffffc050405226 <pa2kva>
ffffffc050405f14:	87aa                	mv	a5,a0
ffffffc050405f16:	faf43c23          	sd	a5,-72(s0)
ffffffc050405f1a:	fd043783          	ld	a5,-48(s0)
ffffffc050405f1e:	078e                	slli	a5,a5,0x3
ffffffc050405f20:	fb843703          	ld	a4,-72(s0)
ffffffc050405f24:	97ba                	add	a5,a5,a4
ffffffc050405f26:	639c                	ld	a5,0(a5)
ffffffc050405f28:	8b85                	andi	a5,a5,1
ffffffc050405f2a:	e3a5                	bnez	a5,ffffffc050405f8a <alloc_page_helper+0x168>
ffffffc050405f2c:	fd043783          	ld	a5,-48(s0)
ffffffc050405f30:	078e                	slli	a5,a5,0x3
ffffffc050405f32:	fb843703          	ld	a4,-72(s0)
ffffffc050405f36:	00f704b3          	add	s1,a4,a5
ffffffc050405f3a:	f3eff0ef          	jal	ra,ffffffc050405678 <alloc_pgtab>
ffffffc050405f3e:	87aa                	mv	a5,a0
ffffffc050405f40:	853e                	mv	a0,a5
ffffffc050405f42:	ac8ff0ef          	jal	ra,ffffffc05040520a <kva2pa>
ffffffc050405f46:	87aa                	mv	a5,a0
ffffffc050405f48:	83b1                	srli	a5,a5,0xc
ffffffc050405f4a:	85be                	mv	a1,a5
ffffffc050405f4c:	8526                	mv	a0,s1
ffffffc050405f4e:	b38ff0ef          	jal	ra,ffffffc050405286 <set_pfn>
ffffffc050405f52:	fd043783          	ld	a5,-48(s0)
ffffffc050405f56:	078e                	slli	a5,a5,0x3
ffffffc050405f58:	fb843703          	ld	a4,-72(s0)
ffffffc050405f5c:	97ba                	add	a5,a5,a4
ffffffc050405f5e:	4585                	li	a1,1
ffffffc050405f60:	853e                	mv	a0,a5
ffffffc050405f62:	b5cff0ef          	jal	ra,ffffffc0504052be <set_attribute>
ffffffc050405f66:	fd043783          	ld	a5,-48(s0)
ffffffc050405f6a:	078e                	slli	a5,a5,0x3
ffffffc050405f6c:	fb843703          	ld	a4,-72(s0)
ffffffc050405f70:	97ba                	add	a5,a5,a4
ffffffc050405f72:	639c                	ld	a5,0(a5)
ffffffc050405f74:	853e                	mv	a0,a5
ffffffc050405f76:	accff0ef          	jal	ra,ffffffc050405242 <get_pa>
ffffffc050405f7a:	87aa                	mv	a5,a0
ffffffc050405f7c:	853e                	mv	a0,a5
ffffffc050405f7e:	aa8ff0ef          	jal	ra,ffffffc050405226 <pa2kva>
ffffffc050405f82:	87aa                	mv	a5,a0
ffffffc050405f84:	853e                	mv	a0,a5
ffffffc050405f86:	b60ff0ef          	jal	ra,ffffffc0504052e6 <clear_pgdir>
ffffffc050405f8a:	fd043783          	ld	a5,-48(s0)
ffffffc050405f8e:	078e                	slli	a5,a5,0x3
ffffffc050405f90:	fb843703          	ld	a4,-72(s0)
ffffffc050405f94:	97ba                	add	a5,a5,a4
ffffffc050405f96:	639c                	ld	a5,0(a5)
ffffffc050405f98:	853e                	mv	a0,a5
ffffffc050405f9a:	aa8ff0ef          	jal	ra,ffffffc050405242 <get_pa>
ffffffc050405f9e:	87aa                	mv	a5,a0
ffffffc050405fa0:	853e                	mv	a0,a5
ffffffc050405fa2:	a84ff0ef          	jal	ra,ffffffc050405226 <pa2kva>
ffffffc050405fa6:	87aa                	mv	a5,a0
ffffffc050405fa8:	faf43823          	sd	a5,-80(s0)
ffffffc050405fac:	fc843783          	ld	a5,-56(s0)
ffffffc050405fb0:	078e                	slli	a5,a5,0x3
ffffffc050405fb2:	fb043703          	ld	a4,-80(s0)
ffffffc050405fb6:	97ba                	add	a5,a5,a4
ffffffc050405fb8:	639c                	ld	a5,0(a5)
ffffffc050405fba:	8b85                	andi	a5,a5,1
ffffffc050405fbc:	12079f63          	bnez	a5,ffffffc0504060fa <alloc_page_helper+0x2d8>
ffffffc050405fc0:	fc843783          	ld	a5,-56(s0)
ffffffc050405fc4:	078e                	slli	a5,a5,0x3
ffffffc050405fc6:	fb043703          	ld	a4,-80(s0)
ffffffc050405fca:	97ba                	add	a5,a5,a4
ffffffc050405fcc:	639c                	ld	a5,0(a5)
ffffffc050405fce:	1007f793          	andi	a5,a5,256
ffffffc050405fd2:	e3a5                	bnez	a5,ffffffc050406032 <alloc_page_helper+0x210>
ffffffc050405fd4:	fc843783          	ld	a5,-56(s0)
ffffffc050405fd8:	078e                	slli	a5,a5,0x3
ffffffc050405fda:	fb043703          	ld	a4,-80(s0)
ffffffc050405fde:	97ba                	add	a5,a5,a4
ffffffc050405fe0:	853e                	mv	a0,a5
ffffffc050405fe2:	beaff0ef          	jal	ra,ffffffc0504053cc <alloc_ph_page>
ffffffc050405fe6:	f8a43823          	sd	a0,-112(s0)
ffffffc050405fea:	f9043783          	ld	a5,-112(s0)
ffffffc050405fee:	6605                	lui	a2,0x1
ffffffc050405ff0:	4581                	li	a1,0
ffffffc050405ff2:	853e                	mv	a0,a5
ffffffc050405ff4:	210000ef          	jal	ra,ffffffc050406204 <kmemset>
ffffffc050405ff8:	fc843783          	ld	a5,-56(s0)
ffffffc050405ffc:	078e                	slli	a5,a5,0x3
ffffffc050405ffe:	fb043703          	ld	a4,-80(s0)
ffffffc050406002:	00f704b3          	add	s1,a4,a5
ffffffc050406006:	f9043503          	ld	a0,-112(s0)
ffffffc05040600a:	a00ff0ef          	jal	ra,ffffffc05040520a <kva2pa>
ffffffc05040600e:	87aa                	mv	a5,a0
ffffffc050406010:	83b1                	srli	a5,a5,0xc
ffffffc050406012:	85be                	mv	a1,a5
ffffffc050406014:	8526                	mv	a0,s1
ffffffc050406016:	a70ff0ef          	jal	ra,ffffffc050405286 <set_pfn>
ffffffc05040601a:	fc843783          	ld	a5,-56(s0)
ffffffc05040601e:	078e                	slli	a5,a5,0x3
ffffffc050406020:	fb043703          	ld	a4,-80(s0)
ffffffc050406024:	97ba                	add	a5,a5,a4
ffffffc050406026:	0df00593          	li	a1,223
ffffffc05040602a:	853e                	mv	a0,a5
ffffffc05040602c:	a92ff0ef          	jal	ra,ffffffc0504052be <set_attribute>
ffffffc050406030:	a0e9                	j	ffffffc0504060fa <alloc_page_helper+0x2d8>
ffffffc050406032:	fc843783          	ld	a5,-56(s0)
ffffffc050406036:	078e                	slli	a5,a5,0x3
ffffffc050406038:	fb043703          	ld	a4,-80(s0)
ffffffc05040603c:	97ba                	add	a5,a5,a4
ffffffc05040603e:	639c                	ld	a5,0(a5)
ffffffc050406040:	853e                	mv	a0,a5
ffffffc050406042:	a24ff0ef          	jal	ra,ffffffc050405266 <get_pfn>
ffffffc050406046:	87aa                	mv	a5,a0
ffffffc050406048:	faf42623          	sw	a5,-84(s0)
ffffffc05040604c:	fc843783          	ld	a5,-56(s0)
ffffffc050406050:	078e                	slli	a5,a5,0x3
ffffffc050406052:	fb043703          	ld	a4,-80(s0)
ffffffc050406056:	97ba                	add	a5,a5,a4
ffffffc050406058:	853e                	mv	a0,a5
ffffffc05040605a:	b72ff0ef          	jal	ra,ffffffc0504053cc <alloc_ph_page>
ffffffc05040605e:	faa43023          	sd	a0,-96(s0)
ffffffc050406062:	fa043503          	ld	a0,-96(s0)
ffffffc050406066:	9a4ff0ef          	jal	ra,ffffffc05040520a <kva2pa>
ffffffc05040606a:	f8a43c23          	sd	a0,-104(s0)
ffffffc05040606e:	fa043783          	ld	a5,-96(s0)
ffffffc050406072:	6605                	lui	a2,0x1
ffffffc050406074:	4581                	li	a1,0
ffffffc050406076:	853e                	mv	a0,a5
ffffffc050406078:	18c000ef          	jal	ra,ffffffc050406204 <kmemset>
ffffffc05040607c:	f9843783          	ld	a5,-104(s0)
ffffffc050406080:	2781                	sext.w	a5,a5
ffffffc050406082:	fac42703          	lw	a4,-84(s0)
ffffffc050406086:	863a                	mv	a2,a4
ffffffc050406088:	45a1                	li	a1,8
ffffffc05040608a:	853e                	mv	a0,a5
ffffffc05040608c:	8d6ff0ef          	jal	ra,ffffffc050405162 <sbi_sd_read>
ffffffc050406090:	922ff0ef          	jal	ra,ffffffc0504051b2 <local_flush_icache_all>
ffffffc050406094:	fac42783          	lw	a5,-84(s0)
ffffffc050406098:	8007879b          	addiw	a5,a5,-2048
ffffffc05040609c:	2781                	sext.w	a5,a5
ffffffc05040609e:	2781                	sext.w	a5,a5
ffffffc0504060a0:	0037d79b          	srliw	a5,a5,0x3
ffffffc0504060a4:	2781                	sext.w	a5,a5
ffffffc0504060a6:	00064717          	auipc	a4,0x64
ffffffc0504060aa:	1da70713          	addi	a4,a4,474 # ffffffc05046a280 <swap_page_array>
ffffffc0504060ae:	1782                	slli	a5,a5,0x20
ffffffc0504060b0:	9381                	srli	a5,a5,0x20
ffffffc0504060b2:	078a                	slli	a5,a5,0x2
ffffffc0504060b4:	97ba                	add	a5,a5,a4
ffffffc0504060b6:	0007a023          	sw	zero,0(a5) # 1000 <_start-0xffffffc0503ff000>
ffffffc0504060ba:	fc843783          	ld	a5,-56(s0)
ffffffc0504060be:	078e                	slli	a5,a5,0x3
ffffffc0504060c0:	fb043703          	ld	a4,-80(s0)
ffffffc0504060c4:	97ba                	add	a5,a5,a4
ffffffc0504060c6:	0007b023          	sd	zero,0(a5)
ffffffc0504060ca:	fc843783          	ld	a5,-56(s0)
ffffffc0504060ce:	078e                	slli	a5,a5,0x3
ffffffc0504060d0:	fb043703          	ld	a4,-80(s0)
ffffffc0504060d4:	973e                	add	a4,a4,a5
ffffffc0504060d6:	f9843783          	ld	a5,-104(s0)
ffffffc0504060da:	83b1                	srli	a5,a5,0xc
ffffffc0504060dc:	85be                	mv	a1,a5
ffffffc0504060de:	853a                	mv	a0,a4
ffffffc0504060e0:	9a6ff0ef          	jal	ra,ffffffc050405286 <set_pfn>
ffffffc0504060e4:	fc843783          	ld	a5,-56(s0)
ffffffc0504060e8:	078e                	slli	a5,a5,0x3
ffffffc0504060ea:	fb043703          	ld	a4,-80(s0)
ffffffc0504060ee:	97ba                	add	a5,a5,a4
ffffffc0504060f0:	0df00593          	li	a1,223
ffffffc0504060f4:	853e                	mv	a0,a5
ffffffc0504060f6:	9c8ff0ef          	jal	ra,ffffffc0504052be <set_attribute>
ffffffc0504060fa:	8a6ff0ef          	jal	ra,ffffffc0504051a0 <local_flush_tlb_all>
ffffffc0504060fe:	a011                	j	ffffffc050406102 <alloc_page_helper+0x2e0>
ffffffc050406100:	0001                	nop
ffffffc050406102:	70e6                	ld	ra,120(sp)
ffffffc050406104:	7446                	ld	s0,112(sp)
ffffffc050406106:	74a6                	ld	s1,104(sp)
ffffffc050406108:	6109                	addi	sp,sp,128
ffffffc05040610a:	8082                	ret

ffffffc05040610c <handle_syscall>:
ffffffc05040610c:	7179                	addi	sp,sp,-48
ffffffc05040610e:	f406                	sd	ra,40(sp)
ffffffc050406110:	f022                	sd	s0,32(sp)
ffffffc050406112:	1800                	addi	s0,sp,48
ffffffc050406114:	fea43423          	sd	a0,-24(s0)
ffffffc050406118:	feb43023          	sd	a1,-32(s0)
ffffffc05040611c:	fcc43c23          	sd	a2,-40(s0)
ffffffc050406120:	fe843783          	ld	a5,-24(s0)
ffffffc050406124:	1087b783          	ld	a5,264(a5)
ffffffc050406128:	00478713          	addi	a4,a5,4
ffffffc05040612c:	fe843783          	ld	a5,-24(s0)
ffffffc050406130:	10e7b423          	sd	a4,264(a5)
ffffffc050406134:	fe843783          	ld	a5,-24(s0)
ffffffc050406138:	67dc                	ld	a5,136(a5)
ffffffc05040613a:	0006e717          	auipc	a4,0x6e
ffffffc05040613e:	0ae70713          	addi	a4,a4,174 # ffffffc0504741e8 <syscall>
ffffffc050406142:	078e                	slli	a5,a5,0x3
ffffffc050406144:	97ba                	add	a5,a5,a4
ffffffc050406146:	0007b803          	ld	a6,0(a5)
ffffffc05040614a:	fe843783          	ld	a5,-24(s0)
ffffffc05040614e:	6bb8                	ld	a4,80(a5)
ffffffc050406150:	fe843783          	ld	a5,-24(s0)
ffffffc050406154:	6fac                	ld	a1,88(a5)
ffffffc050406156:	fe843783          	ld	a5,-24(s0)
ffffffc05040615a:	73b0                	ld	a2,96(a5)
ffffffc05040615c:	fe843783          	ld	a5,-24(s0)
ffffffc050406160:	77bc                	ld	a5,104(a5)
ffffffc050406162:	86be                	mv	a3,a5
ffffffc050406164:	853a                	mv	a0,a4
ffffffc050406166:	9802                	jalr	a6
ffffffc050406168:	87aa                	mv	a5,a0
ffffffc05040616a:	873e                	mv	a4,a5
ffffffc05040616c:	fe843783          	ld	a5,-24(s0)
ffffffc050406170:	ebb8                	sd	a4,80(a5)
ffffffc050406172:	0001                	nop
ffffffc050406174:	70a2                	ld	ra,40(sp)
ffffffc050406176:	7402                	ld	s0,32(sp)
ffffffc050406178:	6145                	addi	sp,sp,48
ffffffc05040617a:	8082                	ret

ffffffc05040617c <kstrlen>:
ffffffc05040617c:	7179                	addi	sp,sp,-48
ffffffc05040617e:	f422                	sd	s0,40(sp)
ffffffc050406180:	1800                	addi	s0,sp,48
ffffffc050406182:	fca43c23          	sd	a0,-40(s0)
ffffffc050406186:	fe042623          	sw	zero,-20(s0)
ffffffc05040618a:	a031                	j	ffffffc050406196 <kstrlen+0x1a>
ffffffc05040618c:	fec42783          	lw	a5,-20(s0)
ffffffc050406190:	2785                	addiw	a5,a5,1
ffffffc050406192:	fef42623          	sw	a5,-20(s0)
ffffffc050406196:	fec42783          	lw	a5,-20(s0)
ffffffc05040619a:	fd843703          	ld	a4,-40(s0)
ffffffc05040619e:	97ba                	add	a5,a5,a4
ffffffc0504061a0:	0007c783          	lbu	a5,0(a5)
ffffffc0504061a4:	f7e5                	bnez	a5,ffffffc05040618c <kstrlen+0x10>
ffffffc0504061a6:	fec42783          	lw	a5,-20(s0)
ffffffc0504061aa:	853e                	mv	a0,a5
ffffffc0504061ac:	7422                	ld	s0,40(sp)
ffffffc0504061ae:	6145                	addi	sp,sp,48
ffffffc0504061b0:	8082                	ret

ffffffc0504061b2 <kmemcpy>:
ffffffc0504061b2:	7179                	addi	sp,sp,-48
ffffffc0504061b4:	f422                	sd	s0,40(sp)
ffffffc0504061b6:	1800                	addi	s0,sp,48
ffffffc0504061b8:	fea43423          	sd	a0,-24(s0)
ffffffc0504061bc:	feb43023          	sd	a1,-32(s0)
ffffffc0504061c0:	87b2                	mv	a5,a2
ffffffc0504061c2:	fcf42e23          	sw	a5,-36(s0)
ffffffc0504061c6:	a035                	j	ffffffc0504061f2 <kmemcpy+0x40>
ffffffc0504061c8:	fe043703          	ld	a4,-32(s0)
ffffffc0504061cc:	00170793          	addi	a5,a4,1
ffffffc0504061d0:	fef43023          	sd	a5,-32(s0)
ffffffc0504061d4:	fe843783          	ld	a5,-24(s0)
ffffffc0504061d8:	00178693          	addi	a3,a5,1
ffffffc0504061dc:	fed43423          	sd	a3,-24(s0)
ffffffc0504061e0:	00074703          	lbu	a4,0(a4)
ffffffc0504061e4:	00e78023          	sb	a4,0(a5)
ffffffc0504061e8:	fdc42783          	lw	a5,-36(s0)
ffffffc0504061ec:	37fd                	addiw	a5,a5,-1
ffffffc0504061ee:	fcf42e23          	sw	a5,-36(s0)
ffffffc0504061f2:	fdc42783          	lw	a5,-36(s0)
ffffffc0504061f6:	2781                	sext.w	a5,a5
ffffffc0504061f8:	fbe1                	bnez	a5,ffffffc0504061c8 <kmemcpy+0x16>
ffffffc0504061fa:	0001                	nop
ffffffc0504061fc:	0001                	nop
ffffffc0504061fe:	7422                	ld	s0,40(sp)
ffffffc050406200:	6145                	addi	sp,sp,48
ffffffc050406202:	8082                	ret

ffffffc050406204 <kmemset>:
ffffffc050406204:	7179                	addi	sp,sp,-48
ffffffc050406206:	f422                	sd	s0,40(sp)
ffffffc050406208:	1800                	addi	s0,sp,48
ffffffc05040620a:	fca43c23          	sd	a0,-40(s0)
ffffffc05040620e:	87ae                	mv	a5,a1
ffffffc050406210:	8732                	mv	a4,a2
ffffffc050406212:	fcf40ba3          	sb	a5,-41(s0)
ffffffc050406216:	87ba                	mv	a5,a4
ffffffc050406218:	fcf42823          	sw	a5,-48(s0)
ffffffc05040621c:	fd843783          	ld	a5,-40(s0)
ffffffc050406220:	fef43423          	sd	a5,-24(s0)
ffffffc050406224:	a005                	j	ffffffc050406244 <kmemset+0x40>
ffffffc050406226:	fe843783          	ld	a5,-24(s0)
ffffffc05040622a:	00178713          	addi	a4,a5,1
ffffffc05040622e:	fee43423          	sd	a4,-24(s0)
ffffffc050406232:	fd744703          	lbu	a4,-41(s0)
ffffffc050406236:	00e78023          	sb	a4,0(a5)
ffffffc05040623a:	fd042783          	lw	a5,-48(s0)
ffffffc05040623e:	37fd                	addiw	a5,a5,-1
ffffffc050406240:	fcf42823          	sw	a5,-48(s0)
ffffffc050406244:	fd042783          	lw	a5,-48(s0)
ffffffc050406248:	2781                	sext.w	a5,a5
ffffffc05040624a:	fff1                	bnez	a5,ffffffc050406226 <kmemset+0x22>
ffffffc05040624c:	0001                	nop
ffffffc05040624e:	0001                	nop
ffffffc050406250:	7422                	ld	s0,40(sp)
ffffffc050406252:	6145                	addi	sp,sp,48
ffffffc050406254:	8082                	ret

ffffffc050406256 <kbzero>:
ffffffc050406256:	1101                	addi	sp,sp,-32
ffffffc050406258:	ec06                	sd	ra,24(sp)
ffffffc05040625a:	e822                	sd	s0,16(sp)
ffffffc05040625c:	1000                	addi	s0,sp,32
ffffffc05040625e:	fea43423          	sd	a0,-24(s0)
ffffffc050406262:	87ae                	mv	a5,a1
ffffffc050406264:	fef42223          	sw	a5,-28(s0)
ffffffc050406268:	fe442783          	lw	a5,-28(s0)
ffffffc05040626c:	863e                	mv	a2,a5
ffffffc05040626e:	4581                	li	a1,0
ffffffc050406270:	fe843503          	ld	a0,-24(s0)
ffffffc050406274:	f91ff0ef          	jal	ra,ffffffc050406204 <kmemset>
ffffffc050406278:	0001                	nop
ffffffc05040627a:	60e2                	ld	ra,24(sp)
ffffffc05040627c:	6442                	ld	s0,16(sp)
ffffffc05040627e:	6105                	addi	sp,sp,32
ffffffc050406280:	8082                	ret

ffffffc050406282 <kstrcmp>:
ffffffc050406282:	1101                	addi	sp,sp,-32
ffffffc050406284:	ec22                	sd	s0,24(sp)
ffffffc050406286:	1000                	addi	s0,sp,32
ffffffc050406288:	fea43423          	sd	a0,-24(s0)
ffffffc05040628c:	feb43023          	sd	a1,-32(s0)
ffffffc050406290:	a0a1                	j	ffffffc0504062d8 <kstrcmp+0x56>
ffffffc050406292:	fe843783          	ld	a5,-24(s0)
ffffffc050406296:	0007c703          	lbu	a4,0(a5)
ffffffc05040629a:	fe043783          	ld	a5,-32(s0)
ffffffc05040629e:	0007c783          	lbu	a5,0(a5)
ffffffc0504062a2:	02f70163          	beq	a4,a5,ffffffc0504062c4 <kstrcmp+0x42>
ffffffc0504062a6:	fe843783          	ld	a5,-24(s0)
ffffffc0504062aa:	0007c783          	lbu	a5,0(a5)
ffffffc0504062ae:	0007871b          	sext.w	a4,a5
ffffffc0504062b2:	fe043783          	ld	a5,-32(s0)
ffffffc0504062b6:	0007c783          	lbu	a5,0(a5)
ffffffc0504062ba:	2781                	sext.w	a5,a5
ffffffc0504062bc:	40f707bb          	subw	a5,a4,a5
ffffffc0504062c0:	2781                	sext.w	a5,a5
ffffffc0504062c2:	a099                	j	ffffffc050406308 <kstrcmp+0x86>
ffffffc0504062c4:	fe843783          	ld	a5,-24(s0)
ffffffc0504062c8:	0785                	addi	a5,a5,1
ffffffc0504062ca:	fef43423          	sd	a5,-24(s0)
ffffffc0504062ce:	fe043783          	ld	a5,-32(s0)
ffffffc0504062d2:	0785                	addi	a5,a5,1
ffffffc0504062d4:	fef43023          	sd	a5,-32(s0)
ffffffc0504062d8:	fe843783          	ld	a5,-24(s0)
ffffffc0504062dc:	0007c783          	lbu	a5,0(a5)
ffffffc0504062e0:	c791                	beqz	a5,ffffffc0504062ec <kstrcmp+0x6a>
ffffffc0504062e2:	fe043783          	ld	a5,-32(s0)
ffffffc0504062e6:	0007c783          	lbu	a5,0(a5)
ffffffc0504062ea:	f7c5                	bnez	a5,ffffffc050406292 <kstrcmp+0x10>
ffffffc0504062ec:	fe843783          	ld	a5,-24(s0)
ffffffc0504062f0:	0007c783          	lbu	a5,0(a5)
ffffffc0504062f4:	0007871b          	sext.w	a4,a5
ffffffc0504062f8:	fe043783          	ld	a5,-32(s0)
ffffffc0504062fc:	0007c783          	lbu	a5,0(a5)
ffffffc050406300:	2781                	sext.w	a5,a5
ffffffc050406302:	40f707bb          	subw	a5,a4,a5
ffffffc050406306:	2781                	sext.w	a5,a5
ffffffc050406308:	853e                	mv	a0,a5
ffffffc05040630a:	6462                	ld	s0,24(sp)
ffffffc05040630c:	6105                	addi	sp,sp,32
ffffffc05040630e:	8082                	ret

ffffffc050406310 <kstrcpy>:
ffffffc050406310:	7179                	addi	sp,sp,-48
ffffffc050406312:	f422                	sd	s0,40(sp)
ffffffc050406314:	1800                	addi	s0,sp,48
ffffffc050406316:	fca43c23          	sd	a0,-40(s0)
ffffffc05040631a:	fcb43823          	sd	a1,-48(s0)
ffffffc05040631e:	fd843783          	ld	a5,-40(s0)
ffffffc050406322:	fef43423          	sd	a5,-24(s0)
ffffffc050406326:	a00d                	j	ffffffc050406348 <kstrcpy+0x38>
ffffffc050406328:	fd043703          	ld	a4,-48(s0)
ffffffc05040632c:	00170793          	addi	a5,a4,1
ffffffc050406330:	fcf43823          	sd	a5,-48(s0)
ffffffc050406334:	fd843783          	ld	a5,-40(s0)
ffffffc050406338:	00178693          	addi	a3,a5,1
ffffffc05040633c:	fcd43c23          	sd	a3,-40(s0)
ffffffc050406340:	00074703          	lbu	a4,0(a4)
ffffffc050406344:	00e78023          	sb	a4,0(a5)
ffffffc050406348:	fd043783          	ld	a5,-48(s0)
ffffffc05040634c:	0007c783          	lbu	a5,0(a5)
ffffffc050406350:	ffe1                	bnez	a5,ffffffc050406328 <kstrcpy+0x18>
ffffffc050406352:	fd843783          	ld	a5,-40(s0)
ffffffc050406356:	00078023          	sb	zero,0(a5)
ffffffc05040635a:	fe843783          	ld	a5,-24(s0)
ffffffc05040635e:	853e                	mv	a0,a5
ffffffc050406360:	7422                	ld	s0,40(sp)
ffffffc050406362:	6145                	addi	sp,sp,48
ffffffc050406364:	8082                	ret

ffffffc050406366 <kstrcat>:
ffffffc050406366:	7179                	addi	sp,sp,-48
ffffffc050406368:	f422                	sd	s0,40(sp)
ffffffc05040636a:	1800                	addi	s0,sp,48
ffffffc05040636c:	fca43c23          	sd	a0,-40(s0)
ffffffc050406370:	fcb43823          	sd	a1,-48(s0)
ffffffc050406374:	fd843783          	ld	a5,-40(s0)
ffffffc050406378:	fef43423          	sd	a5,-24(s0)
ffffffc05040637c:	a031                	j	ffffffc050406388 <kstrcat+0x22>
ffffffc05040637e:	fd843783          	ld	a5,-40(s0)
ffffffc050406382:	0785                	addi	a5,a5,1
ffffffc050406384:	fcf43c23          	sd	a5,-40(s0)
ffffffc050406388:	fd843783          	ld	a5,-40(s0)
ffffffc05040638c:	0007c783          	lbu	a5,0(a5)
ffffffc050406390:	f7fd                	bnez	a5,ffffffc05040637e <kstrcat+0x18>
ffffffc050406392:	a00d                	j	ffffffc0504063b4 <kstrcat+0x4e>
ffffffc050406394:	fd043703          	ld	a4,-48(s0)
ffffffc050406398:	00170793          	addi	a5,a4,1
ffffffc05040639c:	fcf43823          	sd	a5,-48(s0)
ffffffc0504063a0:	fd843783          	ld	a5,-40(s0)
ffffffc0504063a4:	00178693          	addi	a3,a5,1
ffffffc0504063a8:	fcd43c23          	sd	a3,-40(s0)
ffffffc0504063ac:	00074703          	lbu	a4,0(a4)
ffffffc0504063b0:	00e78023          	sb	a4,0(a5)
ffffffc0504063b4:	fd043783          	ld	a5,-48(s0)
ffffffc0504063b8:	0007c783          	lbu	a5,0(a5)
ffffffc0504063bc:	ffe1                	bnez	a5,ffffffc050406394 <kstrcat+0x2e>
ffffffc0504063be:	fd843783          	ld	a5,-40(s0)
ffffffc0504063c2:	00078023          	sb	zero,0(a5)
ffffffc0504063c6:	fe843783          	ld	a5,-24(s0)
ffffffc0504063ca:	853e                	mv	a0,a5
ffffffc0504063cc:	7422                	ld	s0,40(sp)
ffffffc0504063ce:	6145                	addi	sp,sp,48
ffffffc0504063d0:	8082                	ret

ffffffc0504063d2 <memcpy>:
ffffffc0504063d2:	7179                	addi	sp,sp,-48
ffffffc0504063d4:	f422                	sd	s0,40(sp)
ffffffc0504063d6:	1800                	addi	s0,sp,48
ffffffc0504063d8:	fea43423          	sd	a0,-24(s0)
ffffffc0504063dc:	feb43023          	sd	a1,-32(s0)
ffffffc0504063e0:	87b2                	mv	a5,a2
ffffffc0504063e2:	fcf42e23          	sw	a5,-36(s0)
ffffffc0504063e6:	a035                	j	ffffffc050406412 <memcpy+0x40>
ffffffc0504063e8:	fe043703          	ld	a4,-32(s0)
ffffffc0504063ec:	00170793          	addi	a5,a4,1
ffffffc0504063f0:	fef43023          	sd	a5,-32(s0)
ffffffc0504063f4:	fe843783          	ld	a5,-24(s0)
ffffffc0504063f8:	00178693          	addi	a3,a5,1
ffffffc0504063fc:	fed43423          	sd	a3,-24(s0)
ffffffc050406400:	00074703          	lbu	a4,0(a4)
ffffffc050406404:	00e78023          	sb	a4,0(a5)
ffffffc050406408:	fdc42783          	lw	a5,-36(s0)
ffffffc05040640c:	37fd                	addiw	a5,a5,-1
ffffffc05040640e:	fcf42e23          	sw	a5,-36(s0)
ffffffc050406412:	fdc42783          	lw	a5,-36(s0)
ffffffc050406416:	2781                	sext.w	a5,a5
ffffffc050406418:	fbe1                	bnez	a5,ffffffc0504063e8 <memcpy+0x16>
ffffffc05040641a:	0001                	nop
ffffffc05040641c:	0001                	nop
ffffffc05040641e:	7422                	ld	s0,40(sp)
ffffffc050406420:	6145                	addi	sp,sp,48
ffffffc050406422:	8082                	ret

ffffffc050406424 <strcmp>:
ffffffc050406424:	1101                	addi	sp,sp,-32
ffffffc050406426:	ec22                	sd	s0,24(sp)
ffffffc050406428:	1000                	addi	s0,sp,32
ffffffc05040642a:	fea43423          	sd	a0,-24(s0)
ffffffc05040642e:	feb43023          	sd	a1,-32(s0)
ffffffc050406432:	a0a1                	j	ffffffc05040647a <strcmp+0x56>
ffffffc050406434:	fe843783          	ld	a5,-24(s0)
ffffffc050406438:	0007c703          	lbu	a4,0(a5)
ffffffc05040643c:	fe043783          	ld	a5,-32(s0)
ffffffc050406440:	0007c783          	lbu	a5,0(a5)
ffffffc050406444:	02f70163          	beq	a4,a5,ffffffc050406466 <strcmp+0x42>
ffffffc050406448:	fe843783          	ld	a5,-24(s0)
ffffffc05040644c:	0007c783          	lbu	a5,0(a5)
ffffffc050406450:	0007871b          	sext.w	a4,a5
ffffffc050406454:	fe043783          	ld	a5,-32(s0)
ffffffc050406458:	0007c783          	lbu	a5,0(a5)
ffffffc05040645c:	2781                	sext.w	a5,a5
ffffffc05040645e:	40f707bb          	subw	a5,a4,a5
ffffffc050406462:	2781                	sext.w	a5,a5
ffffffc050406464:	a099                	j	ffffffc0504064aa <strcmp+0x86>
ffffffc050406466:	fe843783          	ld	a5,-24(s0)
ffffffc05040646a:	0785                	addi	a5,a5,1
ffffffc05040646c:	fef43423          	sd	a5,-24(s0)
ffffffc050406470:	fe043783          	ld	a5,-32(s0)
ffffffc050406474:	0785                	addi	a5,a5,1
ffffffc050406476:	fef43023          	sd	a5,-32(s0)
ffffffc05040647a:	fe843783          	ld	a5,-24(s0)
ffffffc05040647e:	0007c783          	lbu	a5,0(a5)
ffffffc050406482:	c791                	beqz	a5,ffffffc05040648e <strcmp+0x6a>
ffffffc050406484:	fe043783          	ld	a5,-32(s0)
ffffffc050406488:	0007c783          	lbu	a5,0(a5)
ffffffc05040648c:	f7c5                	bnez	a5,ffffffc050406434 <strcmp+0x10>
ffffffc05040648e:	fe843783          	ld	a5,-24(s0)
ffffffc050406492:	0007c783          	lbu	a5,0(a5)
ffffffc050406496:	0007871b          	sext.w	a4,a5
ffffffc05040649a:	fe043783          	ld	a5,-32(s0)
ffffffc05040649e:	0007c783          	lbu	a5,0(a5)
ffffffc0504064a2:	2781                	sext.w	a5,a5
ffffffc0504064a4:	40f707bb          	subw	a5,a4,a5
ffffffc0504064a8:	2781                	sext.w	a5,a5
ffffffc0504064aa:	853e                	mv	a0,a5
ffffffc0504064ac:	6462                	ld	s0,24(sp)
ffffffc0504064ae:	6105                	addi	sp,sp,32
ffffffc0504064b0:	8082                	ret

ffffffc0504064b2 <mini_strlen>:
ffffffc0504064b2:	7179                	addi	sp,sp,-48
ffffffc0504064b4:	f422                	sd	s0,40(sp)
ffffffc0504064b6:	1800                	addi	s0,sp,48
ffffffc0504064b8:	fca43c23          	sd	a0,-40(s0)
ffffffc0504064bc:	fe042623          	sw	zero,-20(s0)
ffffffc0504064c0:	a031                	j	ffffffc0504064cc <mini_strlen+0x1a>
ffffffc0504064c2:	fec42783          	lw	a5,-20(s0)
ffffffc0504064c6:	2785                	addiw	a5,a5,1
ffffffc0504064c8:	fef42623          	sw	a5,-20(s0)
ffffffc0504064cc:	fec46783          	lwu	a5,-20(s0)
ffffffc0504064d0:	fd843703          	ld	a4,-40(s0)
ffffffc0504064d4:	97ba                	add	a5,a5,a4
ffffffc0504064d6:	0007c783          	lbu	a5,0(a5)
ffffffc0504064da:	f7e5                	bnez	a5,ffffffc0504064c2 <mini_strlen+0x10>
ffffffc0504064dc:	fec42783          	lw	a5,-20(s0)
ffffffc0504064e0:	853e                	mv	a0,a5
ffffffc0504064e2:	7422                	ld	s0,40(sp)
ffffffc0504064e4:	6145                	addi	sp,sp,48
ffffffc0504064e6:	8082                	ret

ffffffc0504064e8 <mini_itoa>:
ffffffc0504064e8:	715d                	addi	sp,sp,-80
ffffffc0504064ea:	e4a2                	sd	s0,72(sp)
ffffffc0504064ec:	0880                	addi	s0,sp,80
ffffffc0504064ee:	fca43423          	sd	a0,-56(s0)
ffffffc0504064f2:	fae43823          	sd	a4,-80(s0)
ffffffc0504064f6:	873e                	mv	a4,a5
ffffffc0504064f8:	87ae                	mv	a5,a1
ffffffc0504064fa:	fcf42223          	sw	a5,-60(s0)
ffffffc0504064fe:	87b2                	mv	a5,a2
ffffffc050406500:	fcf42023          	sw	a5,-64(s0)
ffffffc050406504:	87b6                	mv	a5,a3
ffffffc050406506:	faf42e23          	sw	a5,-68(s0)
ffffffc05040650a:	87ba                	mv	a5,a4
ffffffc05040650c:	faf42c23          	sw	a5,-72(s0)
ffffffc050406510:	fb043783          	ld	a5,-80(s0)
ffffffc050406514:	fef43423          	sd	a5,-24(s0)
ffffffc050406518:	fe042223          	sw	zero,-28(s0)
ffffffc05040651c:	fc442783          	lw	a5,-60(s0)
ffffffc050406520:	0007871b          	sext.w	a4,a5
ffffffc050406524:	47c1                	li	a5,16
ffffffc050406526:	00e7f463          	bgeu	a5,a4,ffffffc05040652e <mini_itoa+0x46>
ffffffc05040652a:	4781                	li	a5,0
ffffffc05040652c:	aae9                	j	ffffffc050406706 <mini_itoa+0x21e>
ffffffc05040652e:	fc843783          	ld	a5,-56(s0)
ffffffc050406532:	0007df63          	bgez	a5,ffffffc050406550 <mini_itoa+0x68>
ffffffc050406536:	fbc42783          	lw	a5,-68(s0)
ffffffc05040653a:	2781                	sext.w	a5,a5
ffffffc05040653c:	eb91                	bnez	a5,ffffffc050406550 <mini_itoa+0x68>
ffffffc05040653e:	4785                	li	a5,1
ffffffc050406540:	fef42223          	sw	a5,-28(s0)
ffffffc050406544:	fc843783          	ld	a5,-56(s0)
ffffffc050406548:	40f007b3          	neg	a5,a5
ffffffc05040654c:	fcf43423          	sd	a5,-56(s0)
ffffffc050406550:	fc042e23          	sw	zero,-36(s0)
ffffffc050406554:	fbc42783          	lw	a5,-68(s0)
ffffffc050406558:	2781                	sext.w	a5,a5
ffffffc05040655a:	cb91                	beqz	a5,ffffffc05040656e <mini_itoa+0x86>
ffffffc05040655c:	fc843703          	ld	a4,-56(s0)
ffffffc050406560:	fc446783          	lwu	a5,-60(s0)
ffffffc050406564:	02f777b3          	remu	a5,a4,a5
ffffffc050406568:	fcf42e23          	sw	a5,-36(s0)
ffffffc05040656c:	a809                	j	ffffffc05040657e <mini_itoa+0x96>
ffffffc05040656e:	fc446783          	lwu	a5,-60(s0)
ffffffc050406572:	fc843703          	ld	a4,-56(s0)
ffffffc050406576:	02f767b3          	rem	a5,a4,a5
ffffffc05040657a:	fcf42e23          	sw	a5,-36(s0)
ffffffc05040657e:	fdc42783          	lw	a5,-36(s0)
ffffffc050406582:	0007871b          	sext.w	a4,a5
ffffffc050406586:	47a5                	li	a5,9
ffffffc050406588:	00e7cb63          	blt	a5,a4,ffffffc05040659e <mini_itoa+0xb6>
ffffffc05040658c:	fdc42783          	lw	a5,-36(s0)
ffffffc050406590:	0ff7f793          	andi	a5,a5,255
ffffffc050406594:	0307879b          	addiw	a5,a5,48
ffffffc050406598:	0ff7f713          	andi	a4,a5,255
ffffffc05040659c:	a025                	j	ffffffc0504065c4 <mini_itoa+0xdc>
ffffffc05040659e:	fc042783          	lw	a5,-64(s0)
ffffffc0504065a2:	2781                	sext.w	a5,a5
ffffffc0504065a4:	c781                	beqz	a5,ffffffc0504065ac <mini_itoa+0xc4>
ffffffc0504065a6:	04100793          	li	a5,65
ffffffc0504065aa:	a019                	j	ffffffc0504065b0 <mini_itoa+0xc8>
ffffffc0504065ac:	06100793          	li	a5,97
ffffffc0504065b0:	fdc42703          	lw	a4,-36(s0)
ffffffc0504065b4:	0ff77713          	andi	a4,a4,255
ffffffc0504065b8:	9fb9                	addw	a5,a5,a4
ffffffc0504065ba:	0ff7f793          	andi	a5,a5,255
ffffffc0504065be:	37d9                	addiw	a5,a5,-10
ffffffc0504065c0:	0ff7f713          	andi	a4,a5,255
ffffffc0504065c4:	fe843783          	ld	a5,-24(s0)
ffffffc0504065c8:	00178693          	addi	a3,a5,1
ffffffc0504065cc:	fed43423          	sd	a3,-24(s0)
ffffffc0504065d0:	00e78023          	sb	a4,0(a5)
ffffffc0504065d4:	fbc42783          	lw	a5,-68(s0)
ffffffc0504065d8:	2781                	sext.w	a5,a5
ffffffc0504065da:	cb91                	beqz	a5,ffffffc0504065ee <mini_itoa+0x106>
ffffffc0504065dc:	fc843703          	ld	a4,-56(s0)
ffffffc0504065e0:	fc446783          	lwu	a5,-60(s0)
ffffffc0504065e4:	02f757b3          	divu	a5,a4,a5
ffffffc0504065e8:	fcf43423          	sd	a5,-56(s0)
ffffffc0504065ec:	a809                	j	ffffffc0504065fe <mini_itoa+0x116>
ffffffc0504065ee:	fc446783          	lwu	a5,-60(s0)
ffffffc0504065f2:	fc843703          	ld	a4,-56(s0)
ffffffc0504065f6:	02f747b3          	div	a5,a4,a5
ffffffc0504065fa:	fcf43423          	sd	a5,-56(s0)
ffffffc0504065fe:	fc843783          	ld	a5,-56(s0)
ffffffc050406602:	f7b9                	bnez	a5,ffffffc050406550 <mini_itoa+0x68>
ffffffc050406604:	fe843703          	ld	a4,-24(s0)
ffffffc050406608:	fb043783          	ld	a5,-80(s0)
ffffffc05040660c:	40f707b3          	sub	a5,a4,a5
ffffffc050406610:	fef42023          	sw	a5,-32(s0)
ffffffc050406614:	a005                	j	ffffffc050406634 <mini_itoa+0x14c>
ffffffc050406616:	fe843783          	ld	a5,-24(s0)
ffffffc05040661a:	00178713          	addi	a4,a5,1
ffffffc05040661e:	fee43423          	sd	a4,-24(s0)
ffffffc050406622:	03000713          	li	a4,48
ffffffc050406626:	00e78023          	sb	a4,0(a5)
ffffffc05040662a:	fe042783          	lw	a5,-32(s0)
ffffffc05040662e:	2785                	addiw	a5,a5,1
ffffffc050406630:	fef42023          	sw	a5,-32(s0)
ffffffc050406634:	fe042703          	lw	a4,-32(s0)
ffffffc050406638:	fb842783          	lw	a5,-72(s0)
ffffffc05040663c:	2701                	sext.w	a4,a4
ffffffc05040663e:	2781                	sext.w	a5,a5
ffffffc050406640:	fcf76be3          	bltu	a4,a5,ffffffc050406616 <mini_itoa+0x12e>
ffffffc050406644:	fe442783          	lw	a5,-28(s0)
ffffffc050406648:	2781                	sext.w	a5,a5
ffffffc05040664a:	cb99                	beqz	a5,ffffffc050406660 <mini_itoa+0x178>
ffffffc05040664c:	fe843783          	ld	a5,-24(s0)
ffffffc050406650:	00178713          	addi	a4,a5,1
ffffffc050406654:	fee43423          	sd	a4,-24(s0)
ffffffc050406658:	02d00713          	li	a4,45
ffffffc05040665c:	00e78023          	sb	a4,0(a5)
ffffffc050406660:	fe843783          	ld	a5,-24(s0)
ffffffc050406664:	00078023          	sb	zero,0(a5)
ffffffc050406668:	fe843703          	ld	a4,-24(s0)
ffffffc05040666c:	fb043783          	ld	a5,-80(s0)
ffffffc050406670:	40f707b3          	sub	a5,a4,a5
ffffffc050406674:	fcf42c23          	sw	a5,-40(s0)
ffffffc050406678:	fe042023          	sw	zero,-32(s0)
ffffffc05040667c:	a885                	j	ffffffc0504066ec <mini_itoa+0x204>
ffffffc05040667e:	fe046783          	lwu	a5,-32(s0)
ffffffc050406682:	fb043703          	ld	a4,-80(s0)
ffffffc050406686:	97ba                	add	a5,a5,a4
ffffffc050406688:	0007c783          	lbu	a5,0(a5)
ffffffc05040668c:	fcf40ba3          	sb	a5,-41(s0)
ffffffc050406690:	fd842703          	lw	a4,-40(s0)
ffffffc050406694:	fe042783          	lw	a5,-32(s0)
ffffffc050406698:	40f707bb          	subw	a5,a4,a5
ffffffc05040669c:	2781                	sext.w	a5,a5
ffffffc05040669e:	37fd                	addiw	a5,a5,-1
ffffffc0504066a0:	2781                	sext.w	a5,a5
ffffffc0504066a2:	1782                	slli	a5,a5,0x20
ffffffc0504066a4:	9381                	srli	a5,a5,0x20
ffffffc0504066a6:	fb043703          	ld	a4,-80(s0)
ffffffc0504066aa:	973e                	add	a4,a4,a5
ffffffc0504066ac:	fe046783          	lwu	a5,-32(s0)
ffffffc0504066b0:	fb043683          	ld	a3,-80(s0)
ffffffc0504066b4:	97b6                	add	a5,a5,a3
ffffffc0504066b6:	00074703          	lbu	a4,0(a4)
ffffffc0504066ba:	00e78023          	sb	a4,0(a5)
ffffffc0504066be:	fd842703          	lw	a4,-40(s0)
ffffffc0504066c2:	fe042783          	lw	a5,-32(s0)
ffffffc0504066c6:	40f707bb          	subw	a5,a4,a5
ffffffc0504066ca:	2781                	sext.w	a5,a5
ffffffc0504066cc:	37fd                	addiw	a5,a5,-1
ffffffc0504066ce:	2781                	sext.w	a5,a5
ffffffc0504066d0:	1782                	slli	a5,a5,0x20
ffffffc0504066d2:	9381                	srli	a5,a5,0x20
ffffffc0504066d4:	fb043703          	ld	a4,-80(s0)
ffffffc0504066d8:	97ba                	add	a5,a5,a4
ffffffc0504066da:	fd744703          	lbu	a4,-41(s0)
ffffffc0504066de:	00e78023          	sb	a4,0(a5)
ffffffc0504066e2:	fe042783          	lw	a5,-32(s0)
ffffffc0504066e6:	2785                	addiw	a5,a5,1
ffffffc0504066e8:	fef42023          	sw	a5,-32(s0)
ffffffc0504066ec:	fd842783          	lw	a5,-40(s0)
ffffffc0504066f0:	0017d79b          	srliw	a5,a5,0x1
ffffffc0504066f4:	0007871b          	sext.w	a4,a5
ffffffc0504066f8:	fe042783          	lw	a5,-32(s0)
ffffffc0504066fc:	2781                	sext.w	a5,a5
ffffffc0504066fe:	f8e7e0e3          	bltu	a5,a4,ffffffc05040667e <mini_itoa+0x196>
ffffffc050406702:	fd842783          	lw	a5,-40(s0)
ffffffc050406706:	853e                	mv	a0,a5
ffffffc050406708:	6426                	ld	s0,72(sp)
ffffffc05040670a:	6161                	addi	sp,sp,80
ffffffc05040670c:	8082                	ret

ffffffc05040670e <_putc>:
ffffffc05040670e:	1101                	addi	sp,sp,-32
ffffffc050406710:	ec22                	sd	s0,24(sp)
ffffffc050406712:	1000                	addi	s0,sp,32
ffffffc050406714:	87aa                	mv	a5,a0
ffffffc050406716:	feb43023          	sd	a1,-32(s0)
ffffffc05040671a:	fef42623          	sw	a5,-20(s0)
ffffffc05040671e:	fe043783          	ld	a5,-32(s0)
ffffffc050406722:	6798                	ld	a4,8(a5)
ffffffc050406724:	fe043783          	ld	a5,-32(s0)
ffffffc050406728:	639c                	ld	a5,0(a5)
ffffffc05040672a:	40f707b3          	sub	a5,a4,a5
ffffffc05040672e:	2781                	sext.w	a5,a5
ffffffc050406730:	2785                	addiw	a5,a5,1
ffffffc050406732:	0007871b          	sext.w	a4,a5
ffffffc050406736:	fe043783          	ld	a5,-32(s0)
ffffffc05040673a:	4b9c                	lw	a5,16(a5)
ffffffc05040673c:	00f76463          	bltu	a4,a5,ffffffc050406744 <_putc+0x36>
ffffffc050406740:	4781                	li	a5,0
ffffffc050406742:	a02d                	j	ffffffc05040676c <_putc+0x5e>
ffffffc050406744:	fe043783          	ld	a5,-32(s0)
ffffffc050406748:	679c                	ld	a5,8(a5)
ffffffc05040674a:	00178693          	addi	a3,a5,1
ffffffc05040674e:	fe043703          	ld	a4,-32(s0)
ffffffc050406752:	e714                	sd	a3,8(a4)
ffffffc050406754:	fec42703          	lw	a4,-20(s0)
ffffffc050406758:	0ff77713          	andi	a4,a4,255
ffffffc05040675c:	00e78023          	sb	a4,0(a5)
ffffffc050406760:	fe043783          	ld	a5,-32(s0)
ffffffc050406764:	679c                	ld	a5,8(a5)
ffffffc050406766:	00078023          	sb	zero,0(a5)
ffffffc05040676a:	4785                	li	a5,1
ffffffc05040676c:	853e                	mv	a0,a5
ffffffc05040676e:	6462                	ld	s0,24(sp)
ffffffc050406770:	6105                	addi	sp,sp,32
ffffffc050406772:	8082                	ret

ffffffc050406774 <_puts>:
ffffffc050406774:	7139                	addi	sp,sp,-64
ffffffc050406776:	fc22                	sd	s0,56(sp)
ffffffc050406778:	0080                	addi	s0,sp,64
ffffffc05040677a:	fca43c23          	sd	a0,-40(s0)
ffffffc05040677e:	87ae                	mv	a5,a1
ffffffc050406780:	fcc43423          	sd	a2,-56(s0)
ffffffc050406784:	fcf42a23          	sw	a5,-44(s0)
ffffffc050406788:	fc843783          	ld	a5,-56(s0)
ffffffc05040678c:	4b9c                	lw	a5,16(a5)
ffffffc05040678e:	02079713          	slli	a4,a5,0x20
ffffffc050406792:	9301                	srli	a4,a4,0x20
ffffffc050406794:	fc843783          	ld	a5,-56(s0)
ffffffc050406798:	6794                	ld	a3,8(a5)
ffffffc05040679a:	fc843783          	ld	a5,-56(s0)
ffffffc05040679e:	639c                	ld	a5,0(a5)
ffffffc0504067a0:	40f687b3          	sub	a5,a3,a5
ffffffc0504067a4:	8f1d                	sub	a4,a4,a5
ffffffc0504067a6:	fd446783          	lwu	a5,-44(s0)
ffffffc0504067aa:	02e7c463          	blt	a5,a4,ffffffc0504067d2 <_puts+0x5e>
ffffffc0504067ae:	fc843783          	ld	a5,-56(s0)
ffffffc0504067b2:	4b98                	lw	a4,16(a5)
ffffffc0504067b4:	fc843783          	ld	a5,-56(s0)
ffffffc0504067b8:	6794                	ld	a3,8(a5)
ffffffc0504067ba:	fc843783          	ld	a5,-56(s0)
ffffffc0504067be:	639c                	ld	a5,0(a5)
ffffffc0504067c0:	40f687b3          	sub	a5,a3,a5
ffffffc0504067c4:	2781                	sext.w	a5,a5
ffffffc0504067c6:	40f707bb          	subw	a5,a4,a5
ffffffc0504067ca:	2781                	sext.w	a5,a5
ffffffc0504067cc:	37fd                	addiw	a5,a5,-1
ffffffc0504067ce:	fcf42a23          	sw	a5,-44(s0)
ffffffc0504067d2:	fe042623          	sw	zero,-20(s0)
ffffffc0504067d6:	a03d                	j	ffffffc050406804 <_puts+0x90>
ffffffc0504067d8:	fec46783          	lwu	a5,-20(s0)
ffffffc0504067dc:	fd843703          	ld	a4,-40(s0)
ffffffc0504067e0:	973e                	add	a4,a4,a5
ffffffc0504067e2:	fc843783          	ld	a5,-56(s0)
ffffffc0504067e6:	679c                	ld	a5,8(a5)
ffffffc0504067e8:	00178613          	addi	a2,a5,1
ffffffc0504067ec:	fc843683          	ld	a3,-56(s0)
ffffffc0504067f0:	e690                	sd	a2,8(a3)
ffffffc0504067f2:	00074703          	lbu	a4,0(a4)
ffffffc0504067f6:	00e78023          	sb	a4,0(a5)
ffffffc0504067fa:	fec42783          	lw	a5,-20(s0)
ffffffc0504067fe:	2785                	addiw	a5,a5,1
ffffffc050406800:	fef42623          	sw	a5,-20(s0)
ffffffc050406804:	fec42703          	lw	a4,-20(s0)
ffffffc050406808:	fd442783          	lw	a5,-44(s0)
ffffffc05040680c:	2701                	sext.w	a4,a4
ffffffc05040680e:	2781                	sext.w	a5,a5
ffffffc050406810:	fcf764e3          	bltu	a4,a5,ffffffc0504067d8 <_puts+0x64>
ffffffc050406814:	fc843783          	ld	a5,-56(s0)
ffffffc050406818:	679c                	ld	a5,8(a5)
ffffffc05040681a:	00078023          	sb	zero,0(a5)
ffffffc05040681e:	fd442783          	lw	a5,-44(s0)
ffffffc050406822:	853e                	mv	a0,a5
ffffffc050406824:	7462                	ld	s0,56(sp)
ffffffc050406826:	6121                	addi	sp,sp,64
ffffffc050406828:	8082                	ret

ffffffc05040682a <mini_vsnprintf>:
ffffffc05040682a:	7119                	addi	sp,sp,-128
ffffffc05040682c:	fc86                	sd	ra,120(sp)
ffffffc05040682e:	f8a2                	sd	s0,112(sp)
ffffffc050406830:	0100                	addi	s0,sp,128
ffffffc050406832:	f8a43c23          	sd	a0,-104(s0)
ffffffc050406836:	87ae                	mv	a5,a1
ffffffc050406838:	f8c43423          	sd	a2,-120(s0)
ffffffc05040683c:	f8d43023          	sd	a3,-128(s0)
ffffffc050406840:	f8f42a23          	sw	a5,-108(s0)
ffffffc050406844:	f9843783          	ld	a5,-104(s0)
ffffffc050406848:	fcf43023          	sd	a5,-64(s0)
ffffffc05040684c:	f9843783          	ld	a5,-104(s0)
ffffffc050406850:	fcf43423          	sd	a5,-56(s0)
ffffffc050406854:	f9442783          	lw	a5,-108(s0)
ffffffc050406858:	fcf42823          	sw	a5,-48(s0)
ffffffc05040685c:	a4f9                	j	ffffffc050406b2a <mini_vsnprintf+0x300>
ffffffc05040685e:	fc843703          	ld	a4,-56(s0)
ffffffc050406862:	fc043783          	ld	a5,-64(s0)
ffffffc050406866:	40f707b3          	sub	a5,a4,a5
ffffffc05040686a:	2781                	sext.w	a5,a5
ffffffc05040686c:	2785                	addiw	a5,a5,1
ffffffc05040686e:	0007871b          	sext.w	a4,a5
ffffffc050406872:	fd042783          	lw	a5,-48(s0)
ffffffc050406876:	2cf77b63          	bgeu	a4,a5,ffffffc050406b4c <mini_vsnprintf+0x322>
ffffffc05040687a:	fef44783          	lbu	a5,-17(s0)
ffffffc05040687e:	0ff7f713          	andi	a4,a5,255
ffffffc050406882:	02500793          	li	a5,37
ffffffc050406886:	00f70c63          	beq	a4,a5,ffffffc05040689e <mini_vsnprintf+0x74>
ffffffc05040688a:	fef44783          	lbu	a5,-17(s0)
ffffffc05040688e:	2781                	sext.w	a5,a5
ffffffc050406890:	fc040713          	addi	a4,s0,-64
ffffffc050406894:	85ba                	mv	a1,a4
ffffffc050406896:	853e                	mv	a0,a5
ffffffc050406898:	e77ff0ef          	jal	ra,ffffffc05040670e <_putc>
ffffffc05040689c:	a479                	j	ffffffc050406b2a <mini_vsnprintf+0x300>
ffffffc05040689e:	fe040723          	sb	zero,-18(s0)
ffffffc0504068a2:	fe042423          	sw	zero,-24(s0)
ffffffc0504068a6:	f8843783          	ld	a5,-120(s0)
ffffffc0504068aa:	00178713          	addi	a4,a5,1
ffffffc0504068ae:	f8e43423          	sd	a4,-120(s0)
ffffffc0504068b2:	0007c783          	lbu	a5,0(a5)
ffffffc0504068b6:	fef407a3          	sb	a5,-17(s0)
ffffffc0504068ba:	fef44783          	lbu	a5,-17(s0)
ffffffc0504068be:	0ff7f713          	andi	a4,a5,255
ffffffc0504068c2:	03000793          	li	a5,48
ffffffc0504068c6:	06f71b63          	bne	a4,a5,ffffffc05040693c <mini_vsnprintf+0x112>
ffffffc0504068ca:	a891                	j	ffffffc05040691e <mini_vsnprintf+0xf4>
ffffffc0504068cc:	fef44783          	lbu	a5,-17(s0)
ffffffc0504068d0:	0ff7f793          	andi	a5,a5,255
ffffffc0504068d4:	26078e63          	beqz	a5,ffffffc050406b50 <mini_vsnprintf+0x326>
ffffffc0504068d8:	fef44783          	lbu	a5,-17(s0)
ffffffc0504068dc:	0ff7f713          	andi	a4,a5,255
ffffffc0504068e0:	02f00793          	li	a5,47
ffffffc0504068e4:	04e7fc63          	bgeu	a5,a4,ffffffc05040693c <mini_vsnprintf+0x112>
ffffffc0504068e8:	fef44783          	lbu	a5,-17(s0)
ffffffc0504068ec:	0ff7f713          	andi	a4,a5,255
ffffffc0504068f0:	03900793          	li	a5,57
ffffffc0504068f4:	04e7e463          	bltu	a5,a4,ffffffc05040693c <mini_vsnprintf+0x112>
ffffffc0504068f8:	fee44703          	lbu	a4,-18(s0)
ffffffc0504068fc:	87ba                	mv	a5,a4
ffffffc0504068fe:	0027979b          	slliw	a5,a5,0x2
ffffffc050406902:	9fb9                	addw	a5,a5,a4
ffffffc050406904:	0017979b          	slliw	a5,a5,0x1
ffffffc050406908:	0ff7f793          	andi	a5,a5,255
ffffffc05040690c:	fef44703          	lbu	a4,-17(s0)
ffffffc050406910:	9fb9                	addw	a5,a5,a4
ffffffc050406912:	0ff7f793          	andi	a5,a5,255
ffffffc050406916:	fd07879b          	addiw	a5,a5,-48
ffffffc05040691a:	fef40723          	sb	a5,-18(s0)
ffffffc05040691e:	f8843783          	ld	a5,-120(s0)
ffffffc050406922:	00178713          	addi	a4,a5,1
ffffffc050406926:	f8e43423          	sd	a4,-120(s0)
ffffffc05040692a:	0007c783          	lbu	a5,0(a5)
ffffffc05040692e:	fef407a3          	sb	a5,-17(s0)
ffffffc050406932:	fef44783          	lbu	a5,-17(s0)
ffffffc050406936:	0ff7f793          	andi	a5,a5,255
ffffffc05040693a:	fbc9                	bnez	a5,ffffffc0504068cc <mini_vsnprintf+0xa2>
ffffffc05040693c:	fef44783          	lbu	a5,-17(s0)
ffffffc050406940:	0ff7f713          	andi	a4,a5,255
ffffffc050406944:	06c00793          	li	a5,108
ffffffc050406948:	00f71f63          	bne	a4,a5,ffffffc050406966 <mini_vsnprintf+0x13c>
ffffffc05040694c:	4785                	li	a5,1
ffffffc05040694e:	fef42423          	sw	a5,-24(s0)
ffffffc050406952:	f8843783          	ld	a5,-120(s0)
ffffffc050406956:	00178713          	addi	a4,a5,1
ffffffc05040695a:	f8e43423          	sd	a4,-120(s0)
ffffffc05040695e:	0007c783          	lbu	a5,0(a5)
ffffffc050406962:	fef407a3          	sb	a5,-17(s0)
ffffffc050406966:	fef44783          	lbu	a5,-17(s0)
ffffffc05040696a:	2781                	sext.w	a5,a5
ffffffc05040696c:	1e078463          	beqz	a5,ffffffc050406b54 <mini_vsnprintf+0x32a>
ffffffc050406970:	873e                	mv	a4,a5
ffffffc050406972:	1a074263          	bltz	a4,ffffffc050406b16 <mini_vsnprintf+0x2ec>
ffffffc050406976:	86be                	mv	a3,a5
ffffffc050406978:	07800713          	li	a4,120
ffffffc05040697c:	18d74d63          	blt	a4,a3,ffffffc050406b16 <mini_vsnprintf+0x2ec>
ffffffc050406980:	86be                	mv	a3,a5
ffffffc050406982:	05800713          	li	a4,88
ffffffc050406986:	18e6c863          	blt	a3,a4,ffffffc050406b16 <mini_vsnprintf+0x2ec>
ffffffc05040698a:	fa87869b          	addiw	a3,a5,-88
ffffffc05040698e:	0006871b          	sext.w	a4,a3
ffffffc050406992:	02000793          	li	a5,32
ffffffc050406996:	18e7e063          	bltu	a5,a4,ffffffc050406b16 <mini_vsnprintf+0x2ec>
ffffffc05040699a:	02069793          	slli	a5,a3,0x20
ffffffc05040699e:	9381                	srli	a5,a5,0x20
ffffffc0504069a0:	00279713          	slli	a4,a5,0x2
ffffffc0504069a4:	00001797          	auipc	a5,0x1
ffffffc0504069a8:	93878793          	addi	a5,a5,-1736 # ffffffc0504072dc <__FUNCTION__.1468+0xc>
ffffffc0504069ac:	97ba                	add	a5,a5,a4
ffffffc0504069ae:	439c                	lw	a5,0(a5)
ffffffc0504069b0:	0007871b          	sext.w	a4,a5
ffffffc0504069b4:	00001797          	auipc	a5,0x1
ffffffc0504069b8:	92878793          	addi	a5,a5,-1752 # ffffffc0504072dc <__FUNCTION__.1468+0xc>
ffffffc0504069bc:	97ba                	add	a5,a5,a4
ffffffc0504069be:	8782                	jr	a5
ffffffc0504069c0:	4785                	li	a5,1
ffffffc0504069c2:	fef42423          	sw	a5,-24(s0)
ffffffc0504069c6:	a295                	j	ffffffc050406b2a <mini_vsnprintf+0x300>
ffffffc0504069c8:	fe842783          	lw	a5,-24(s0)
ffffffc0504069cc:	2781                	sext.w	a5,a5
ffffffc0504069ce:	ef81                	bnez	a5,ffffffc0504069e6 <mini_vsnprintf+0x1bc>
ffffffc0504069d0:	f8043783          	ld	a5,-128(s0)
ffffffc0504069d4:	00878713          	addi	a4,a5,8
ffffffc0504069d8:	f8e43023          	sd	a4,-128(s0)
ffffffc0504069dc:	439c                	lw	a5,0(a5)
ffffffc0504069de:	02079513          	slli	a0,a5,0x20
ffffffc0504069e2:	9101                	srli	a0,a0,0x20
ffffffc0504069e4:	a809                	j	ffffffc0504069f6 <mini_vsnprintf+0x1cc>
ffffffc0504069e6:	f8043783          	ld	a5,-128(s0)
ffffffc0504069ea:	00878713          	addi	a4,a5,8
ffffffc0504069ee:	f8e43023          	sd	a4,-128(s0)
ffffffc0504069f2:	639c                	ld	a5,0(a5)
ffffffc0504069f4:	853e                	mv	a0,a5
ffffffc0504069f6:	fef44783          	lbu	a5,-17(s0)
ffffffc0504069fa:	0007871b          	sext.w	a4,a5
ffffffc0504069fe:	07500793          	li	a5,117
ffffffc050406a02:	40f707b3          	sub	a5,a4,a5
ffffffc050406a06:	0017b793          	seqz	a5,a5
ffffffc050406a0a:	0ff7f793          	andi	a5,a5,255
ffffffc050406a0e:	0007869b          	sext.w	a3,a5
ffffffc050406a12:	fee44783          	lbu	a5,-18(s0)
ffffffc050406a16:	2781                	sext.w	a5,a5
ffffffc050406a18:	fa840713          	addi	a4,s0,-88
ffffffc050406a1c:	4601                	li	a2,0
ffffffc050406a1e:	45a9                	li	a1,10
ffffffc050406a20:	ac9ff0ef          	jal	ra,ffffffc0504064e8 <mini_itoa>
ffffffc050406a24:	87aa                	mv	a5,a0
ffffffc050406a26:	fcf42e23          	sw	a5,-36(s0)
ffffffc050406a2a:	fc040693          	addi	a3,s0,-64
ffffffc050406a2e:	fdc42703          	lw	a4,-36(s0)
ffffffc050406a32:	fa840793          	addi	a5,s0,-88
ffffffc050406a36:	8636                	mv	a2,a3
ffffffc050406a38:	85ba                	mv	a1,a4
ffffffc050406a3a:	853e                	mv	a0,a5
ffffffc050406a3c:	d39ff0ef          	jal	ra,ffffffc050406774 <_puts>
ffffffc050406a40:	fe042423          	sw	zero,-24(s0)
ffffffc050406a44:	a0dd                	j	ffffffc050406b2a <mini_vsnprintf+0x300>
ffffffc050406a46:	fe842783          	lw	a5,-24(s0)
ffffffc050406a4a:	2781                	sext.w	a5,a5
ffffffc050406a4c:	ef81                	bnez	a5,ffffffc050406a64 <mini_vsnprintf+0x23a>
ffffffc050406a4e:	f8043783          	ld	a5,-128(s0)
ffffffc050406a52:	00878713          	addi	a4,a5,8
ffffffc050406a56:	f8e43023          	sd	a4,-128(s0)
ffffffc050406a5a:	439c                	lw	a5,0(a5)
ffffffc050406a5c:	02079513          	slli	a0,a5,0x20
ffffffc050406a60:	9101                	srli	a0,a0,0x20
ffffffc050406a62:	a809                	j	ffffffc050406a74 <mini_vsnprintf+0x24a>
ffffffc050406a64:	f8043783          	ld	a5,-128(s0)
ffffffc050406a68:	00878713          	addi	a4,a5,8
ffffffc050406a6c:	f8e43023          	sd	a4,-128(s0)
ffffffc050406a70:	639c                	ld	a5,0(a5)
ffffffc050406a72:	853e                	mv	a0,a5
ffffffc050406a74:	fef44783          	lbu	a5,-17(s0)
ffffffc050406a78:	0007871b          	sext.w	a4,a5
ffffffc050406a7c:	05800793          	li	a5,88
ffffffc050406a80:	40f707b3          	sub	a5,a4,a5
ffffffc050406a84:	0017b793          	seqz	a5,a5
ffffffc050406a88:	0ff7f793          	andi	a5,a5,255
ffffffc050406a8c:	0007861b          	sext.w	a2,a5
ffffffc050406a90:	fee44783          	lbu	a5,-18(s0)
ffffffc050406a94:	2781                	sext.w	a5,a5
ffffffc050406a96:	fa840713          	addi	a4,s0,-88
ffffffc050406a9a:	4685                	li	a3,1
ffffffc050406a9c:	45c1                	li	a1,16
ffffffc050406a9e:	a4bff0ef          	jal	ra,ffffffc0504064e8 <mini_itoa>
ffffffc050406aa2:	87aa                	mv	a5,a0
ffffffc050406aa4:	fcf42e23          	sw	a5,-36(s0)
ffffffc050406aa8:	fc040693          	addi	a3,s0,-64
ffffffc050406aac:	fdc42703          	lw	a4,-36(s0)
ffffffc050406ab0:	fa840793          	addi	a5,s0,-88
ffffffc050406ab4:	8636                	mv	a2,a3
ffffffc050406ab6:	85ba                	mv	a1,a4
ffffffc050406ab8:	853e                	mv	a0,a5
ffffffc050406aba:	cbbff0ef          	jal	ra,ffffffc050406774 <_puts>
ffffffc050406abe:	fe042423          	sw	zero,-24(s0)
ffffffc050406ac2:	a0a5                	j	ffffffc050406b2a <mini_vsnprintf+0x300>
ffffffc050406ac4:	f8043783          	ld	a5,-128(s0)
ffffffc050406ac8:	00878713          	addi	a4,a5,8
ffffffc050406acc:	f8e43023          	sd	a4,-128(s0)
ffffffc050406ad0:	439c                	lw	a5,0(a5)
ffffffc050406ad2:	0ff7f793          	andi	a5,a5,255
ffffffc050406ad6:	2781                	sext.w	a5,a5
ffffffc050406ad8:	fc040713          	addi	a4,s0,-64
ffffffc050406adc:	85ba                	mv	a1,a4
ffffffc050406ade:	853e                	mv	a0,a5
ffffffc050406ae0:	c2fff0ef          	jal	ra,ffffffc05040670e <_putc>
ffffffc050406ae4:	a099                	j	ffffffc050406b2a <mini_vsnprintf+0x300>
ffffffc050406ae6:	f8043783          	ld	a5,-128(s0)
ffffffc050406aea:	00878713          	addi	a4,a5,8
ffffffc050406aee:	f8e43023          	sd	a4,-128(s0)
ffffffc050406af2:	639c                	ld	a5,0(a5)
ffffffc050406af4:	fef43023          	sd	a5,-32(s0)
ffffffc050406af8:	fe043503          	ld	a0,-32(s0)
ffffffc050406afc:	9b7ff0ef          	jal	ra,ffffffc0504064b2 <mini_strlen>
ffffffc050406b00:	87aa                	mv	a5,a0
ffffffc050406b02:	2781                	sext.w	a5,a5
ffffffc050406b04:	fc040713          	addi	a4,s0,-64
ffffffc050406b08:	863a                	mv	a2,a4
ffffffc050406b0a:	85be                	mv	a1,a5
ffffffc050406b0c:	fe043503          	ld	a0,-32(s0)
ffffffc050406b10:	c65ff0ef          	jal	ra,ffffffc050406774 <_puts>
ffffffc050406b14:	a819                	j	ffffffc050406b2a <mini_vsnprintf+0x300>
ffffffc050406b16:	fef44783          	lbu	a5,-17(s0)
ffffffc050406b1a:	2781                	sext.w	a5,a5
ffffffc050406b1c:	fc040713          	addi	a4,s0,-64
ffffffc050406b20:	85ba                	mv	a1,a4
ffffffc050406b22:	853e                	mv	a0,a5
ffffffc050406b24:	bebff0ef          	jal	ra,ffffffc05040670e <_putc>
ffffffc050406b28:	0001                	nop
ffffffc050406b2a:	f8843783          	ld	a5,-120(s0)
ffffffc050406b2e:	00178713          	addi	a4,a5,1
ffffffc050406b32:	f8e43423          	sd	a4,-120(s0)
ffffffc050406b36:	0007c783          	lbu	a5,0(a5)
ffffffc050406b3a:	fef407a3          	sb	a5,-17(s0)
ffffffc050406b3e:	fef44783          	lbu	a5,-17(s0)
ffffffc050406b42:	0ff7f793          	andi	a5,a5,255
ffffffc050406b46:	d0079ce3          	bnez	a5,ffffffc05040685e <mini_vsnprintf+0x34>
ffffffc050406b4a:	a031                	j	ffffffc050406b56 <mini_vsnprintf+0x32c>
ffffffc050406b4c:	0001                	nop
ffffffc050406b4e:	a021                	j	ffffffc050406b56 <mini_vsnprintf+0x32c>
ffffffc050406b50:	0001                	nop
ffffffc050406b52:	a011                	j	ffffffc050406b56 <mini_vsnprintf+0x32c>
ffffffc050406b54:	0001                	nop
ffffffc050406b56:	fc843703          	ld	a4,-56(s0)
ffffffc050406b5a:	fc043783          	ld	a5,-64(s0)
ffffffc050406b5e:	40f707b3          	sub	a5,a4,a5
ffffffc050406b62:	2781                	sext.w	a5,a5
ffffffc050406b64:	853e                	mv	a0,a5
ffffffc050406b66:	70e6                	ld	ra,120(sp)
ffffffc050406b68:	7446                	ld	s0,112(sp)
ffffffc050406b6a:	6109                	addi	sp,sp,128
ffffffc050406b6c:	8082                	ret

ffffffc050406b6e <_vprint>:
ffffffc050406b6e:	7129                	addi	sp,sp,-320
ffffffc050406b70:	fe06                	sd	ra,312(sp)
ffffffc050406b72:	fa22                	sd	s0,304(sp)
ffffffc050406b74:	0280                	addi	s0,sp,320
ffffffc050406b76:	eca43c23          	sd	a0,-296(s0)
ffffffc050406b7a:	ecb43823          	sd	a1,-304(s0)
ffffffc050406b7e:	ecc43423          	sd	a2,-312(s0)
ffffffc050406b82:	ed043783          	ld	a5,-304(s0)
ffffffc050406b86:	fef43023          	sd	a5,-32(s0)
ffffffc050406b8a:	fe043703          	ld	a4,-32(s0)
ffffffc050406b8e:	ee040793          	addi	a5,s0,-288
ffffffc050406b92:	86ba                	mv	a3,a4
ffffffc050406b94:	ed843603          	ld	a2,-296(s0)
ffffffc050406b98:	10000593          	li	a1,256
ffffffc050406b9c:	853e                	mv	a0,a5
ffffffc050406b9e:	c8dff0ef          	jal	ra,ffffffc05040682a <mini_vsnprintf>
ffffffc050406ba2:	87aa                	mv	a5,a0
ffffffc050406ba4:	fef42623          	sw	a5,-20(s0)
ffffffc050406ba8:	fec42783          	lw	a5,-20(s0)
ffffffc050406bac:	ff040713          	addi	a4,s0,-16
ffffffc050406bb0:	97ba                	add	a5,a5,a4
ffffffc050406bb2:	ee078823          	sb	zero,-272(a5)
ffffffc050406bb6:	ee040793          	addi	a5,s0,-288
ffffffc050406bba:	ec843703          	ld	a4,-312(s0)
ffffffc050406bbe:	853e                	mv	a0,a5
ffffffc050406bc0:	9702                	jalr	a4
ffffffc050406bc2:	fec42783          	lw	a5,-20(s0)
ffffffc050406bc6:	853e                	mv	a0,a5
ffffffc050406bc8:	70f2                	ld	ra,312(sp)
ffffffc050406bca:	7452                	ld	s0,304(sp)
ffffffc050406bcc:	6131                	addi	sp,sp,320
ffffffc050406bce:	8082                	ret

ffffffc050406bd0 <vprintk>:
ffffffc050406bd0:	1101                	addi	sp,sp,-32
ffffffc050406bd2:	ec06                	sd	ra,24(sp)
ffffffc050406bd4:	e822                	sd	s0,16(sp)
ffffffc050406bd6:	1000                	addi	s0,sp,32
ffffffc050406bd8:	fea43423          	sd	a0,-24(s0)
ffffffc050406bdc:	feb43023          	sd	a1,-32(s0)
ffffffc050406be0:	ffff9617          	auipc	a2,0xffff9
ffffffc050406be4:	72a60613          	addi	a2,a2,1834 # ffffffc05040030a <port_write>
ffffffc050406be8:	fe043583          	ld	a1,-32(s0)
ffffffc050406bec:	fe843503          	ld	a0,-24(s0)
ffffffc050406bf0:	f7fff0ef          	jal	ra,ffffffc050406b6e <_vprint>
ffffffc050406bf4:	87aa                	mv	a5,a0
ffffffc050406bf6:	853e                	mv	a0,a5
ffffffc050406bf8:	60e2                	ld	ra,24(sp)
ffffffc050406bfa:	6442                	ld	s0,16(sp)
ffffffc050406bfc:	6105                	addi	sp,sp,32
ffffffc050406bfe:	8082                	ret

ffffffc050406c00 <printk>:
ffffffc050406c00:	7159                	addi	sp,sp,-112
ffffffc050406c02:	f406                	sd	ra,40(sp)
ffffffc050406c04:	f022                	sd	s0,32(sp)
ffffffc050406c06:	1800                	addi	s0,sp,48
ffffffc050406c08:	fca43c23          	sd	a0,-40(s0)
ffffffc050406c0c:	e40c                	sd	a1,8(s0)
ffffffc050406c0e:	e810                	sd	a2,16(s0)
ffffffc050406c10:	ec14                	sd	a3,24(s0)
ffffffc050406c12:	f018                	sd	a4,32(s0)
ffffffc050406c14:	f41c                	sd	a5,40(s0)
ffffffc050406c16:	03043823          	sd	a6,48(s0)
ffffffc050406c1a:	03143c23          	sd	a7,56(s0)
ffffffc050406c1e:	fe042623          	sw	zero,-20(s0)
ffffffc050406c22:	04040793          	addi	a5,s0,64
ffffffc050406c26:	fcf43823          	sd	a5,-48(s0)
ffffffc050406c2a:	fd043783          	ld	a5,-48(s0)
ffffffc050406c2e:	fc878793          	addi	a5,a5,-56
ffffffc050406c32:	fef43023          	sd	a5,-32(s0)
ffffffc050406c36:	fe043783          	ld	a5,-32(s0)
ffffffc050406c3a:	85be                	mv	a1,a5
ffffffc050406c3c:	fd843503          	ld	a0,-40(s0)
ffffffc050406c40:	f91ff0ef          	jal	ra,ffffffc050406bd0 <vprintk>
ffffffc050406c44:	87aa                	mv	a5,a0
ffffffc050406c46:	fef42623          	sw	a5,-20(s0)
ffffffc050406c4a:	fec42783          	lw	a5,-20(s0)
ffffffc050406c4e:	853e                	mv	a0,a5
ffffffc050406c50:	70a2                	ld	ra,40(sp)
ffffffc050406c52:	7402                	ld	s0,32(sp)
ffffffc050406c54:	6165                	addi	sp,sp,112
ffffffc050406c56:	8082                	ret

ffffffc050406c58 <vprints>:
ffffffc050406c58:	1101                	addi	sp,sp,-32
ffffffc050406c5a:	ec06                	sd	ra,24(sp)
ffffffc050406c5c:	e822                	sd	s0,16(sp)
ffffffc050406c5e:	1000                	addi	s0,sp,32
ffffffc050406c60:	fea43423          	sd	a0,-24(s0)
ffffffc050406c64:	feb43023          	sd	a1,-32(s0)
ffffffc050406c68:	ffffb617          	auipc	a2,0xffffb
ffffffc050406c6c:	4bc60613          	addi	a2,a2,1212 # ffffffc050402124 <screen_write>
ffffffc050406c70:	fe043583          	ld	a1,-32(s0)
ffffffc050406c74:	fe843503          	ld	a0,-24(s0)
ffffffc050406c78:	ef7ff0ef          	jal	ra,ffffffc050406b6e <_vprint>
ffffffc050406c7c:	87aa                	mv	a5,a0
ffffffc050406c7e:	853e                	mv	a0,a5
ffffffc050406c80:	60e2                	ld	ra,24(sp)
ffffffc050406c82:	6442                	ld	s0,16(sp)
ffffffc050406c84:	6105                	addi	sp,sp,32
ffffffc050406c86:	8082                	ret

ffffffc050406c88 <prints>:
ffffffc050406c88:	7159                	addi	sp,sp,-112
ffffffc050406c8a:	f406                	sd	ra,40(sp)
ffffffc050406c8c:	f022                	sd	s0,32(sp)
ffffffc050406c8e:	1800                	addi	s0,sp,48
ffffffc050406c90:	fca43c23          	sd	a0,-40(s0)
ffffffc050406c94:	e40c                	sd	a1,8(s0)
ffffffc050406c96:	e810                	sd	a2,16(s0)
ffffffc050406c98:	ec14                	sd	a3,24(s0)
ffffffc050406c9a:	f018                	sd	a4,32(s0)
ffffffc050406c9c:	f41c                	sd	a5,40(s0)
ffffffc050406c9e:	03043823          	sd	a6,48(s0)
ffffffc050406ca2:	03143c23          	sd	a7,56(s0)
ffffffc050406ca6:	fe042623          	sw	zero,-20(s0)
ffffffc050406caa:	04040793          	addi	a5,s0,64
ffffffc050406cae:	fcf43823          	sd	a5,-48(s0)
ffffffc050406cb2:	fd043783          	ld	a5,-48(s0)
ffffffc050406cb6:	fc878793          	addi	a5,a5,-56
ffffffc050406cba:	fef43023          	sd	a5,-32(s0)
ffffffc050406cbe:	fe043783          	ld	a5,-32(s0)
ffffffc050406cc2:	85be                	mv	a1,a5
ffffffc050406cc4:	fd843503          	ld	a0,-40(s0)
ffffffc050406cc8:	f91ff0ef          	jal	ra,ffffffc050406c58 <vprints>
ffffffc050406ccc:	87aa                	mv	a5,a0
ffffffc050406cce:	fef42623          	sw	a5,-20(s0)
ffffffc050406cd2:	fec42783          	lw	a5,-20(s0)
ffffffc050406cd6:	853e                	mv	a0,a5
ffffffc050406cd8:	70a2                	ld	ra,40(sp)
ffffffc050406cda:	7402                	ld	s0,32(sp)
ffffffc050406cdc:	6165                	addi	sp,sp,112
ffffffc050406cde:	8082                	ret

ffffffc050406ce0 <get_elf_file>:
ffffffc050406ce0:	7139                	addi	sp,sp,-64
ffffffc050406ce2:	fc06                	sd	ra,56(sp)
ffffffc050406ce4:	f822                	sd	s0,48(sp)
ffffffc050406ce6:	0080                	addi	s0,sp,64
ffffffc050406ce8:	fca43c23          	sd	a0,-40(s0)
ffffffc050406cec:	fcb43823          	sd	a1,-48(s0)
ffffffc050406cf0:	fcc43423          	sd	a2,-56(s0)
ffffffc050406cf4:	fe042623          	sw	zero,-20(s0)
ffffffc050406cf8:	a895                	j	ffffffc050406d6c <get_elf_file+0x8c>
ffffffc050406cfa:	00059697          	auipc	a3,0x59
ffffffc050406cfe:	b1668693          	addi	a3,a3,-1258 # ffffffc05045f810 <elf_files>
ffffffc050406d02:	fec42703          	lw	a4,-20(s0)
ffffffc050406d06:	87ba                	mv	a5,a4
ffffffc050406d08:	0786                	slli	a5,a5,0x1
ffffffc050406d0a:	97ba                	add	a5,a5,a4
ffffffc050406d0c:	078e                	slli	a5,a5,0x3
ffffffc050406d0e:	97b6                	add	a5,a5,a3
ffffffc050406d10:	639c                	ld	a5,0(a5)
ffffffc050406d12:	fd843583          	ld	a1,-40(s0)
ffffffc050406d16:	853e                	mv	a0,a5
ffffffc050406d18:	f0cff0ef          	jal	ra,ffffffc050406424 <strcmp>
ffffffc050406d1c:	87aa                	mv	a5,a0
ffffffc050406d1e:	e3b1                	bnez	a5,ffffffc050406d62 <get_elf_file+0x82>
ffffffc050406d20:	00059697          	auipc	a3,0x59
ffffffc050406d24:	af068693          	addi	a3,a3,-1296 # ffffffc05045f810 <elf_files>
ffffffc050406d28:	fec42703          	lw	a4,-20(s0)
ffffffc050406d2c:	87ba                	mv	a5,a4
ffffffc050406d2e:	0786                	slli	a5,a5,0x1
ffffffc050406d30:	97ba                	add	a5,a5,a4
ffffffc050406d32:	078e                	slli	a5,a5,0x3
ffffffc050406d34:	97b6                	add	a5,a5,a3
ffffffc050406d36:	6798                	ld	a4,8(a5)
ffffffc050406d38:	fd043783          	ld	a5,-48(s0)
ffffffc050406d3c:	e398                	sd	a4,0(a5)
ffffffc050406d3e:	00059697          	auipc	a3,0x59
ffffffc050406d42:	ad268693          	addi	a3,a3,-1326 # ffffffc05045f810 <elf_files>
ffffffc050406d46:	fec42703          	lw	a4,-20(s0)
ffffffc050406d4a:	87ba                	mv	a5,a4
ffffffc050406d4c:	0786                	slli	a5,a5,0x1
ffffffc050406d4e:	97ba                	add	a5,a5,a4
ffffffc050406d50:	078e                	slli	a5,a5,0x3
ffffffc050406d52:	97b6                	add	a5,a5,a3
ffffffc050406d54:	6b9c                	ld	a5,16(a5)
ffffffc050406d56:	4398                	lw	a4,0(a5)
ffffffc050406d58:	fc843783          	ld	a5,-56(s0)
ffffffc050406d5c:	c398                	sw	a4,0(a5)
ffffffc050406d5e:	4785                	li	a5,1
ffffffc050406d60:	a831                	j	ffffffc050406d7c <get_elf_file+0x9c>
ffffffc050406d62:	fec42783          	lw	a5,-20(s0)
ffffffc050406d66:	2785                	addiw	a5,a5,1
ffffffc050406d68:	fef42623          	sw	a5,-20(s0)
ffffffc050406d6c:	fec42783          	lw	a5,-20(s0)
ffffffc050406d70:	0007871b          	sext.w	a4,a5
ffffffc050406d74:	4799                	li	a5,6
ffffffc050406d76:	f8e7d2e3          	bge	a5,a4,ffffffc050406cfa <get_elf_file+0x1a>
ffffffc050406d7a:	4781                	li	a5,0
ffffffc050406d7c:	853e                	mv	a0,a5
ffffffc050406d7e:	70e2                	ld	ra,56(sp)
ffffffc050406d80:	7442                	ld	s0,48(sp)
ffffffc050406d82:	6121                	addi	sp,sp,64
ffffffc050406d84:	8082                	ret
