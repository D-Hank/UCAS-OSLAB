
main:     file format elf64-littleriscv


Disassembly of section .text:

0000000050201000 <_start>:
    50201000:	10401073          	csrw	sie,zero
    50201004:	14401073          	csrw	sip,zero
    50201008:	6299                	lui	t0,0x6
    5020100a:	1002b073          	csrc	sstatus,t0
    5020100e:	00009197          	auipc	gp,0x9
    50201012:	e5218193          	addi	gp,gp,-430 # 50209e60 <__global_pointer$>
    50201016:	f14022f3          	csrr	t0,mhartid
    5020101a:	02029863          	bnez	t0,5020104a <setup_C_core1>
    5020101e:	84c18693          	addi	a3,gp,-1972 # 502096ac <_edata>
    50201022:	0000c717          	auipc	a4,0xc
    50201026:	7de70713          	addi	a4,a4,2014 # 5020d800 <__BSS_END__>
    5020102a:	00e6d763          	bge	a3,a4,50201038 <setup_C_core0>

000000005020102e <clear_bss>:
    5020102e:	0006b023          	sd	zero,0(a3)
    50201032:	06a1                	addi	a3,a3,8
    50201034:	fee6cde3          	blt	a3,a4,5020102e <clear_bss>

0000000050201038 <setup_C_core0>:
    50201038:	00008217          	auipc	tp,0x8
    5020103c:	41820213          	addi	tp,tp,1048 # 50209450 <pid0_pcb_core0>
    50201040:	00008117          	auipc	sp,0x8
    50201044:	62012103          	lw	sp,1568(sp) # 50209660 <pid0_stack_core0>
    50201048:	a809                	j	5020105a <head_done>

000000005020104a <setup_C_core1>:
    5020104a:	00008217          	auipc	tp,0x8
    5020104e:	49620213          	addi	tp,tp,1174 # 502094e0 <pid0_pcb_core1>
    50201052:	00008117          	auipc	sp,0x8
    50201056:	61612103          	lw	sp,1558(sp) # 50209668 <pid0_stack_core1>

000000005020105a <head_done>:
    5020105a:	14001073          	csrw	sscratch,zero
    5020105e:	0000b517          	auipc	a0,0xb
    50201062:	e0250513          	addi	a0,a0,-510 # 5020be60 <riscv_dtb>
    50201066:	e10c                	sd	a1,0(a0)
    50201068:	6ef000ef          	jal	ra,50201f56 <main>

000000005020106c <loop>:
    5020106c:	10500073          	wfi
    50201070:	bff5                	j	5020106c <loop>
	...

0000000050201074 <setup_exception>:
    50201074:	00000517          	auipc	a0,0x0
    50201078:	13450513          	addi	a0,a0,308 # 502011a8 <exception_handler_entry>
    5020107c:	10551073          	csrw	stvec,a0
    50201080:	14401073          	csrw	sip,zero
    50201084:	02200513          	li	a0,34
    50201088:	10052073          	csrs	sstatus,a0
    5020108c:	22200513          	li	a0,546
    50201090:	10452073          	csrs	sie,a0
    50201094:	8082                	ret
	...

0000000050201098 <enable_preempt>:
    50201098:	8082                	ret
    5020109a:	0001                	nop

000000005020109c <disable_preempt>:
    5020109c:	8082                	ret
    5020109e:	0001                	nop

00000000502010a0 <enable_interrupt>:
    502010a0:	4289                	li	t0,2
    502010a2:	1002a073          	csrs	sstatus,t0
    502010a6:	8082                	ret

00000000502010a8 <disable_interrupt>:
    502010a8:	4289                	li	t0,2
    502010aa:	1002b073          	csrc	sstatus,t0
    502010ae:	8082                	ret

00000000502010b0 <switch_to>:
    502010b0:	00053283          	ld	t0,0(a0)
    502010b4:	f9028293          	addi	t0,t0,-112 # 5f90 <_start-0x501fb070>
    502010b8:	0022b423          	sd	sp,8(t0)
    502010bc:	0082b823          	sd	s0,16(t0)
    502010c0:	0092bc23          	sd	s1,24(t0)
    502010c4:	0322b023          	sd	s2,32(t0)
    502010c8:	0332b423          	sd	s3,40(t0)
    502010cc:	0342b823          	sd	s4,48(t0)
    502010d0:	0352bc23          	sd	s5,56(t0)
    502010d4:	0562b023          	sd	s6,64(t0)
    502010d8:	0572b423          	sd	s7,72(t0)
    502010dc:	0582b823          	sd	s8,80(t0)
    502010e0:	0592bc23          	sd	s9,88(t0)
    502010e4:	07a2b023          	sd	s10,96(t0)
    502010e8:	07b2b423          	sd	s11,104(t0)
    502010ec:	00553023          	sd	t0,0(a0)
    502010f0:	0005b283          	ld	t0,0(a1)
    502010f4:	0082b103          	ld	sp,8(t0)
    502010f8:	0102b403          	ld	s0,16(t0)
    502010fc:	0182b483          	ld	s1,24(t0)
    50201100:	0202b903          	ld	s2,32(t0)
    50201104:	0282b983          	ld	s3,40(t0)
    50201108:	0302ba03          	ld	s4,48(t0)
    5020110c:	0382ba83          	ld	s5,56(t0)
    50201110:	0402bb03          	ld	s6,64(t0)
    50201114:	0482bb83          	ld	s7,72(t0)
    50201118:	0502bc03          	ld	s8,80(t0)
    5020111c:	0582bc83          	ld	s9,88(t0)
    50201120:	0602bd03          	ld	s10,96(t0)
    50201124:	0682bd83          	ld	s11,104(t0)
    50201128:	07028293          	addi	t0,t0,112
    5020112c:	0055b023          	sd	t0,0(a1)
    50201130:	00058233          	add	tp,a1,zero
    50201134:	a011                	j	50201138 <ret_from_exception>
    50201136:	0001                	nop

0000000050201138 <ret_from_exception>:
    50201138:	671030ef          	jal	ra,50204fa8 <unlock_kernel>
    5020113c:	14021073          	csrw	sscratch,tp
    50201140:	00023103          	ld	sp,0(tp) # 0 <_start-0x50201000>
    50201144:	6292                	ld	t0,256(sp)
    50201146:	6332                	ld	t1,264(sp)
    50201148:	10029073          	csrw	sstatus,t0
    5020114c:	14131073          	csrw	sepc,t1
    50201150:	60a2                	ld	ra,8(sp)
    50201152:	61e2                	ld	gp,24(sp)
    50201154:	72a2                	ld	t0,40(sp)
    50201156:	7342                	ld	t1,48(sp)
    50201158:	73e2                	ld	t2,56(sp)
    5020115a:	6406                	ld	s0,64(sp)
    5020115c:	64a6                	ld	s1,72(sp)
    5020115e:	6546                	ld	a0,80(sp)
    50201160:	65e6                	ld	a1,88(sp)
    50201162:	7606                	ld	a2,96(sp)
    50201164:	76a6                	ld	a3,104(sp)
    50201166:	7746                	ld	a4,112(sp)
    50201168:	77e6                	ld	a5,120(sp)
    5020116a:	680a                	ld	a6,128(sp)
    5020116c:	68aa                	ld	a7,136(sp)
    5020116e:	694a                	ld	s2,144(sp)
    50201170:	69ea                	ld	s3,152(sp)
    50201172:	7a0a                	ld	s4,160(sp)
    50201174:	7aaa                	ld	s5,168(sp)
    50201176:	7b4a                	ld	s6,176(sp)
    50201178:	7bea                	ld	s7,184(sp)
    5020117a:	6c0e                	ld	s8,192(sp)
    5020117c:	6cae                	ld	s9,200(sp)
    5020117e:	6d4e                	ld	s10,208(sp)
    50201180:	6dee                	ld	s11,216(sp)
    50201182:	7e0e                	ld	t3,224(sp)
    50201184:	7eae                	ld	t4,232(sp)
    50201186:	00010f33          	add	t5,sp,zero
    5020118a:	00020fb3          	add	t6,tp,zero
    5020118e:	6115                	addi	sp,sp,288
    50201190:	002fb023          	sd	sp,0(t6)
    50201194:	008fb103          	ld	sp,8(t6)
    50201198:	020f3203          	ld	tp,32(t5)
    5020119c:	0f8f3f83          	ld	t6,248(t5)
    502011a0:	0f0f3f03          	ld	t5,240(t5)
    502011a4:	10200073          	sret

00000000502011a8 <exception_handler_entry>:
    502011a8:	14021273          	csrrw	tp,sscratch,tp
    502011ac:	00021663          	bnez	tp,502011b8 <_save_context>

00000000502011b0 <_restore_kernel_tpsp>:
    502011b0:	14002273          	csrr	tp,sscratch
    502011b4:	00223023          	sd	sp,0(tp) # 0 <_start-0x50201000>

00000000502011b8 <_save_context>:
    502011b8:	00223423          	sd	sp,8(tp) # 8 <_start-0x50200ff8>
    502011bc:	00023103          	ld	sp,0(tp) # 0 <_start-0x50201000>
    502011c0:	712d                	addi	sp,sp,-288
    502011c2:	00223023          	sd	sp,0(tp) # 0 <_start-0x50201000>
    502011c6:	e002                	sd	zero,0(sp)
    502011c8:	e406                	sd	ra,8(sp)
    502011ca:	e80a                	sd	sp,16(sp)
    502011cc:	ec0e                	sd	gp,24(sp)
    502011ce:	f012                	sd	tp,32(sp)
    502011d0:	f416                	sd	t0,40(sp)
    502011d2:	f81a                	sd	t1,48(sp)
    502011d4:	fc1e                	sd	t2,56(sp)
    502011d6:	e0a2                	sd	s0,64(sp)
    502011d8:	e4a6                	sd	s1,72(sp)
    502011da:	e8aa                	sd	a0,80(sp)
    502011dc:	ecae                	sd	a1,88(sp)
    502011de:	f0b2                	sd	a2,96(sp)
    502011e0:	f4b6                	sd	a3,104(sp)
    502011e2:	f8ba                	sd	a4,112(sp)
    502011e4:	fcbe                	sd	a5,120(sp)
    502011e6:	e142                	sd	a6,128(sp)
    502011e8:	e546                	sd	a7,136(sp)
    502011ea:	e94a                	sd	s2,144(sp)
    502011ec:	ed4e                	sd	s3,152(sp)
    502011ee:	f152                	sd	s4,160(sp)
    502011f0:	f556                	sd	s5,168(sp)
    502011f2:	f95a                	sd	s6,176(sp)
    502011f4:	fd5e                	sd	s7,184(sp)
    502011f6:	e1e2                	sd	s8,192(sp)
    502011f8:	e5e6                	sd	s9,200(sp)
    502011fa:	e9ea                	sd	s10,208(sp)
    502011fc:	edee                	sd	s11,216(sp)
    502011fe:	f1f2                	sd	t3,224(sp)
    50201200:	f5f6                	sd	t4,232(sp)
    50201202:	f9fa                	sd	t5,240(sp)
    50201204:	fdfe                	sd	t6,248(sp)
    50201206:	000462b7          	lui	t0,0x46
    5020120a:	1002b073          	csrc	sstatus,t0
    5020120e:	100022f3          	csrr	t0,sstatus
    50201212:	14102373          	csrr	t1,sepc
    50201216:	143023f3          	csrr	t2,stval
    5020121a:	14202e73          	csrr	t3,scause
    5020121e:	e216                	sd	t0,256(sp)
    50201220:	e61a                	sd	t1,264(sp)
    50201222:	ea1e                	sd	t2,272(sp)
    50201224:	ee72                	sd	t3,280(sp)
    50201226:	14001073          	csrw	sscratch,zero
    5020122a:	00009197          	auipc	gp,0x9
    5020122e:	c3618193          	addi	gp,gp,-970 # 50209e60 <__global_pointer$>
    50201232:	559030ef          	jal	ra,50204f8a <lock_kernel>
    50201236:	00023503          	ld	a0,0(tp) # 0 <_start-0x50201000>
    5020123a:	143025f3          	csrr	a1,stval
    5020123e:	14202673          	csrr	a2,scause
    50201242:	751000ef          	jal	ra,50202192 <interrupt_helper>
    50201246:	bdcd                	j	50201138 <ret_from_exception>

0000000050201248 <get_current_cpu_id>:
    50201248:	f1402573          	csrr	a0,mhartid
    5020124c:	8082                	ret

000000005020124e <sbi_console_putstr>:
    5020124e:	1101                	addi	sp,sp,-32
    50201250:	ec22                	sd	s0,24(sp)
    50201252:	1000                	addi	s0,sp,32
    50201254:	fea43423          	sd	a0,-24(s0)
    50201258:	fe843783          	ld	a5,-24(s0)
    5020125c:	853e                	mv	a0,a5
    5020125e:	4581                	li	a1,0
    50201260:	4601                	li	a2,0
    50201262:	48a5                	li	a7,9
    50201264:	00000073          	ecall
    50201268:	0001                	nop
    5020126a:	6462                	ld	s0,24(sp)
    5020126c:	6105                	addi	sp,sp,32
    5020126e:	8082                	ret

0000000050201270 <sbi_console_putchar>:
    50201270:	1101                	addi	sp,sp,-32
    50201272:	ec22                	sd	s0,24(sp)
    50201274:	1000                	addi	s0,sp,32
    50201276:	87aa                	mv	a5,a0
    50201278:	fef42623          	sw	a5,-20(s0)
    5020127c:	fec42783          	lw	a5,-20(s0)
    50201280:	853e                	mv	a0,a5
    50201282:	4581                	li	a1,0
    50201284:	4601                	li	a2,0
    50201286:	4885                	li	a7,1
    50201288:	00000073          	ecall
    5020128c:	0001                	nop
    5020128e:	6462                	ld	s0,24(sp)
    50201290:	6105                	addi	sp,sp,32
    50201292:	8082                	ret

0000000050201294 <sbi_console_getchar>:
    50201294:	1141                	addi	sp,sp,-16
    50201296:	e422                	sd	s0,8(sp)
    50201298:	0800                	addi	s0,sp,16
    5020129a:	4501                	li	a0,0
    5020129c:	4581                	li	a1,0
    5020129e:	4601                	li	a2,0
    502012a0:	4889                	li	a7,2
    502012a2:	00000073          	ecall
    502012a6:	87aa                	mv	a5,a0
    502012a8:	2781                	sext.w	a5,a5
    502012aa:	853e                	mv	a0,a5
    502012ac:	6422                	ld	s0,8(sp)
    502012ae:	0141                	addi	sp,sp,16
    502012b0:	8082                	ret

00000000502012b2 <port_write_ch>:
    502012b2:	1101                	addi	sp,sp,-32
    502012b4:	ec06                	sd	ra,24(sp)
    502012b6:	e822                	sd	s0,16(sp)
    502012b8:	1000                	addi	s0,sp,32
    502012ba:	87aa                	mv	a5,a0
    502012bc:	fef407a3          	sb	a5,-17(s0)
    502012c0:	fef44783          	lbu	a5,-17(s0)
    502012c4:	2781                	sext.w	a5,a5
    502012c6:	853e                	mv	a0,a5
    502012c8:	fa9ff0ef          	jal	ra,50201270 <sbi_console_putchar>
    502012cc:	0001                	nop
    502012ce:	60e2                	ld	ra,24(sp)
    502012d0:	6442                	ld	s0,16(sp)
    502012d2:	6105                	addi	sp,sp,32
    502012d4:	8082                	ret

00000000502012d6 <port_write>:
    502012d6:	1101                	addi	sp,sp,-32
    502012d8:	ec06                	sd	ra,24(sp)
    502012da:	e822                	sd	s0,16(sp)
    502012dc:	1000                	addi	s0,sp,32
    502012de:	fea43423          	sd	a0,-24(s0)
    502012e2:	fe843503          	ld	a0,-24(s0)
    502012e6:	f69ff0ef          	jal	ra,5020124e <sbi_console_putstr>
    502012ea:	0001                	nop
    502012ec:	60e2                	ld	ra,24(sp)
    502012ee:	6442                	ld	s0,16(sp)
    502012f0:	6105                	addi	sp,sp,32
    502012f2:	8082                	ret

00000000502012f4 <port_read_ch>:
    502012f4:	1141                	addi	sp,sp,-16
    502012f6:	e406                	sd	ra,8(sp)
    502012f8:	e022                	sd	s0,0(sp)
    502012fa:	0800                	addi	s0,sp,16
    502012fc:	f99ff0ef          	jal	ra,50201294 <sbi_console_getchar>
    50201300:	87aa                	mv	a5,a0
    50201302:	853e                	mv	a0,a5
    50201304:	60a2                	ld	ra,8(sp)
    50201306:	6402                	ld	s0,0(sp)
    50201308:	0141                	addi	sp,sp,16
    5020130a:	8082                	ret

000000005020130c <sbi_set_timer>:
    5020130c:	1101                	addi	sp,sp,-32
    5020130e:	ec22                	sd	s0,24(sp)
    50201310:	1000                	addi	s0,sp,32
    50201312:	fea43423          	sd	a0,-24(s0)
    50201316:	fe843503          	ld	a0,-24(s0)
    5020131a:	4581                	li	a1,0
    5020131c:	4601                	li	a2,0
    5020131e:	4881                	li	a7,0
    50201320:	00000073          	ecall
    50201324:	0001                	nop
    50201326:	6462                	ld	s0,24(sp)
    50201328:	6105                	addi	sp,sp,32
    5020132a:	8082                	ret

000000005020132c <sbi_read_fdt>:
    5020132c:	1101                	addi	sp,sp,-32
    5020132e:	ec22                	sd	s0,24(sp)
    50201330:	1000                	addi	s0,sp,32
    50201332:	87aa                	mv	a5,a0
    50201334:	fef42623          	sw	a5,-20(s0)
    50201338:	fec42783          	lw	a5,-20(s0)
    5020133c:	853e                	mv	a0,a5
    5020133e:	4581                	li	a1,0
    50201340:	4601                	li	a2,0
    50201342:	48b1                	li	a7,12
    50201344:	00000073          	ecall
    50201348:	87aa                	mv	a5,a0
    5020134a:	2781                	sext.w	a5,a5
    5020134c:	853e                	mv	a0,a5
    5020134e:	6462                	ld	s0,24(sp)
    50201350:	6105                	addi	sp,sp,32
    50201352:	8082                	ret

0000000050201354 <init_pcb_stack>:
    50201354:	715d                	addi	sp,sp,-80
    50201356:	e4a2                	sd	s0,72(sp)
    50201358:	0880                	addi	s0,sp,80
    5020135a:	fca43423          	sd	a0,-56(s0)
    5020135e:	fcb43023          	sd	a1,-64(s0)
    50201362:	fac43c23          	sd	a2,-72(s0)
    50201366:	fad43823          	sd	a3,-80(s0)
    5020136a:	fc843783          	ld	a5,-56(s0)
    5020136e:	ee078793          	addi	a5,a5,-288
    50201372:	fef43423          	sd	a5,-24(s0)
    50201376:	fe843783          	ld	a5,-24(s0)
    5020137a:	fef43023          	sd	a5,-32(s0)
    5020137e:	fe043783          	ld	a5,-32(s0)
    50201382:	fcf43c23          	sd	a5,-40(s0)
    50201386:	fd843783          	ld	a5,-40(s0)
    5020138a:	0007b023          	sd	zero,0(a5)
    5020138e:	fd843783          	ld	a5,-40(s0)
    50201392:	07a1                	addi	a5,a5,8
    50201394:	fb843703          	ld	a4,-72(s0)
    50201398:	e398                	sd	a4,0(a5)
    5020139a:	fd843783          	ld	a5,-40(s0)
    5020139e:	07c1                	addi	a5,a5,16
    502013a0:	fe843703          	ld	a4,-24(s0)
    502013a4:	e398                	sd	a4,0(a5)
    502013a6:	fd843783          	ld	a5,-40(s0)
    502013aa:	07e1                	addi	a5,a5,24
    502013ac:	00018713          	mv	a4,gp
    502013b0:	e398                	sd	a4,0(a5)
    502013b2:	fd843783          	ld	a5,-40(s0)
    502013b6:	02078793          	addi	a5,a5,32
    502013ba:	0007b023          	sd	zero,0(a5)
    502013be:	fd843783          	ld	a5,-40(s0)
    502013c2:	02878793          	addi	a5,a5,40
    502013c6:	0007b023          	sd	zero,0(a5)
    502013ca:	fd843783          	ld	a5,-40(s0)
    502013ce:	03078793          	addi	a5,a5,48
    502013d2:	0007b023          	sd	zero,0(a5)
    502013d6:	fd843783          	ld	a5,-40(s0)
    502013da:	03878793          	addi	a5,a5,56
    502013de:	0007b023          	sd	zero,0(a5)
    502013e2:	fd843783          	ld	a5,-40(s0)
    502013e6:	04078793          	addi	a5,a5,64
    502013ea:	0007b023          	sd	zero,0(a5)
    502013ee:	fd843783          	ld	a5,-40(s0)
    502013f2:	04878793          	addi	a5,a5,72
    502013f6:	0007b023          	sd	zero,0(a5)
    502013fa:	fd843783          	ld	a5,-40(s0)
    502013fe:	05078793          	addi	a5,a5,80
    50201402:	0007b023          	sd	zero,0(a5)
    50201406:	fd843783          	ld	a5,-40(s0)
    5020140a:	05878793          	addi	a5,a5,88
    5020140e:	0007b023          	sd	zero,0(a5)
    50201412:	fd843783          	ld	a5,-40(s0)
    50201416:	06078793          	addi	a5,a5,96
    5020141a:	0007b023          	sd	zero,0(a5)
    5020141e:	fd843783          	ld	a5,-40(s0)
    50201422:	06878793          	addi	a5,a5,104
    50201426:	0007b023          	sd	zero,0(a5)
    5020142a:	fd843783          	ld	a5,-40(s0)
    5020142e:	07078793          	addi	a5,a5,112
    50201432:	0007b023          	sd	zero,0(a5)
    50201436:	fd843783          	ld	a5,-40(s0)
    5020143a:	07878793          	addi	a5,a5,120
    5020143e:	0007b023          	sd	zero,0(a5)
    50201442:	fd843783          	ld	a5,-40(s0)
    50201446:	08078793          	addi	a5,a5,128
    5020144a:	0007b023          	sd	zero,0(a5)
    5020144e:	fd843783          	ld	a5,-40(s0)
    50201452:	08878793          	addi	a5,a5,136
    50201456:	0007b023          	sd	zero,0(a5)
    5020145a:	fd843783          	ld	a5,-40(s0)
    5020145e:	09078793          	addi	a5,a5,144
    50201462:	0007b023          	sd	zero,0(a5)
    50201466:	fd843783          	ld	a5,-40(s0)
    5020146a:	09878793          	addi	a5,a5,152
    5020146e:	0007b023          	sd	zero,0(a5)
    50201472:	fd843783          	ld	a5,-40(s0)
    50201476:	0a078793          	addi	a5,a5,160
    5020147a:	0007b023          	sd	zero,0(a5)
    5020147e:	fd843783          	ld	a5,-40(s0)
    50201482:	0a878793          	addi	a5,a5,168
    50201486:	0007b023          	sd	zero,0(a5)
    5020148a:	fd843783          	ld	a5,-40(s0)
    5020148e:	0b078793          	addi	a5,a5,176
    50201492:	0007b023          	sd	zero,0(a5)
    50201496:	fd843783          	ld	a5,-40(s0)
    5020149a:	0b878793          	addi	a5,a5,184
    5020149e:	0007b023          	sd	zero,0(a5)
    502014a2:	fd843783          	ld	a5,-40(s0)
    502014a6:	0c078793          	addi	a5,a5,192
    502014aa:	0007b023          	sd	zero,0(a5)
    502014ae:	fd843783          	ld	a5,-40(s0)
    502014b2:	0c878793          	addi	a5,a5,200
    502014b6:	0007b023          	sd	zero,0(a5)
    502014ba:	fd843783          	ld	a5,-40(s0)
    502014be:	0d078793          	addi	a5,a5,208
    502014c2:	0007b023          	sd	zero,0(a5)
    502014c6:	fd843783          	ld	a5,-40(s0)
    502014ca:	0d878793          	addi	a5,a5,216
    502014ce:	0007b023          	sd	zero,0(a5)
    502014d2:	fd843783          	ld	a5,-40(s0)
    502014d6:	0e078793          	addi	a5,a5,224
    502014da:	0007b023          	sd	zero,0(a5)
    502014de:	fd843783          	ld	a5,-40(s0)
    502014e2:	0e878793          	addi	a5,a5,232
    502014e6:	0007b023          	sd	zero,0(a5)
    502014ea:	fd843783          	ld	a5,-40(s0)
    502014ee:	0f078793          	addi	a5,a5,240
    502014f2:	0007b023          	sd	zero,0(a5)
    502014f6:	fd843783          	ld	a5,-40(s0)
    502014fa:	0f878793          	addi	a5,a5,248
    502014fe:	0007b023          	sd	zero,0(a5)
    50201502:	fe043783          	ld	a5,-32(s0)
    50201506:	02000713          	li	a4,32
    5020150a:	10e7b023          	sd	a4,256(a5)
    5020150e:	fe043783          	ld	a5,-32(s0)
    50201512:	fb843703          	ld	a4,-72(s0)
    50201516:	10e7b423          	sd	a4,264(a5)
    5020151a:	fe043783          	ld	a5,-32(s0)
    5020151e:	1007b823          	sd	zero,272(a5)
    50201522:	fe043783          	ld	a5,-32(s0)
    50201526:	4721                	li	a4,8
    50201528:	10e7bc23          	sd	a4,280(a5)
    5020152c:	fe843783          	ld	a5,-24(s0)
    50201530:	f9078793          	addi	a5,a5,-112
    50201534:	fef43423          	sd	a5,-24(s0)
    50201538:	fe843783          	ld	a5,-24(s0)
    5020153c:	fcf43823          	sd	a5,-48(s0)
    50201540:	fd043783          	ld	a5,-48(s0)
    50201544:	fcf43c23          	sd	a5,-40(s0)
    50201548:	fd843783          	ld	a5,-40(s0)
    5020154c:	fb843703          	ld	a4,-72(s0)
    50201550:	e398                	sd	a4,0(a5)
    50201552:	fd843783          	ld	a5,-40(s0)
    50201556:	07a1                	addi	a5,a5,8
    50201558:	fe843703          	ld	a4,-24(s0)
    5020155c:	e398                	sd	a4,0(a5)
    5020155e:	fd843783          	ld	a5,-40(s0)
    50201562:	07c1                	addi	a5,a5,16
    50201564:	0007b023          	sd	zero,0(a5)
    50201568:	fd843783          	ld	a5,-40(s0)
    5020156c:	07e1                	addi	a5,a5,24
    5020156e:	0007b023          	sd	zero,0(a5)
    50201572:	fd843783          	ld	a5,-40(s0)
    50201576:	02078793          	addi	a5,a5,32
    5020157a:	0007b023          	sd	zero,0(a5)
    5020157e:	fd843783          	ld	a5,-40(s0)
    50201582:	02878793          	addi	a5,a5,40
    50201586:	0007b023          	sd	zero,0(a5)
    5020158a:	fd843783          	ld	a5,-40(s0)
    5020158e:	03078793          	addi	a5,a5,48
    50201592:	0007b023          	sd	zero,0(a5)
    50201596:	fd843783          	ld	a5,-40(s0)
    5020159a:	03878793          	addi	a5,a5,56
    5020159e:	0007b023          	sd	zero,0(a5)
    502015a2:	fd843783          	ld	a5,-40(s0)
    502015a6:	04078793          	addi	a5,a5,64
    502015aa:	0007b023          	sd	zero,0(a5)
    502015ae:	fd843783          	ld	a5,-40(s0)
    502015b2:	04878793          	addi	a5,a5,72
    502015b6:	0007b023          	sd	zero,0(a5)
    502015ba:	fd843783          	ld	a5,-40(s0)
    502015be:	05078793          	addi	a5,a5,80
    502015c2:	0007b023          	sd	zero,0(a5)
    502015c6:	fd843783          	ld	a5,-40(s0)
    502015ca:	05878793          	addi	a5,a5,88
    502015ce:	0007b023          	sd	zero,0(a5)
    502015d2:	fd843783          	ld	a5,-40(s0)
    502015d6:	06078793          	addi	a5,a5,96
    502015da:	0007b023          	sd	zero,0(a5)
    502015de:	fd843783          	ld	a5,-40(s0)
    502015e2:	06878793          	addi	a5,a5,104
    502015e6:	0007b023          	sd	zero,0(a5)
    502015ea:	fb043783          	ld	a5,-80(s0)
    502015ee:	fe843703          	ld	a4,-24(s0)
    502015f2:	e398                	sd	a4,0(a5)
    502015f4:	fb043783          	ld	a5,-80(s0)
    502015f8:	fc043703          	ld	a4,-64(s0)
    502015fc:	e798                	sd	a4,8(a5)
    502015fe:	0001                	nop
    50201600:	6426                	ld	s0,72(sp)
    50201602:	6161                	addi	sp,sp,80
    50201604:	8082                	ret

0000000050201606 <do_nothing>:
    50201606:	1141                	addi	sp,sp,-16
    50201608:	e422                	sd	s0,8(sp)
    5020160a:	0800                	addi	s0,sp,16
    5020160c:	0001                	nop
    5020160e:	6422                	ld	s0,8(sp)
    50201610:	0141                	addi	sp,sp,16
    50201612:	8082                	ret

0000000050201614 <init_pcb>:
    50201614:	7179                	addi	sp,sp,-48
    50201616:	f406                	sd	ra,40(sp)
    50201618:	f022                	sd	s0,32(sp)
    5020161a:	1800                	addi	s0,sp,48
    5020161c:	00008797          	auipc	a5,0x8
    50201620:	e3478793          	addi	a5,a5,-460 # 50209450 <pid0_pcb_core0>
    50201624:	470d                	li	a4,3
    50201626:	cff8                	sw	a4,92(a5)
    50201628:	00008797          	auipc	a5,0x8
    5020162c:	eb878793          	addi	a5,a5,-328 # 502094e0 <pid0_pcb_core1>
    50201630:	470d                	li	a4,3
    50201632:	cff8                	sw	a4,92(a5)
    50201634:	6505                	lui	a0,0x1
    50201636:	1d5030ef          	jal	ra,5020500a <kmalloc>
    5020163a:	87aa                	mv	a5,a0
    5020163c:	873e                	mv	a4,a5
    5020163e:	6785                	lui	a5,0x1
    50201640:	973e                	add	a4,a4,a5
    50201642:	83018793          	addi	a5,gp,-2000 # 50209690 <kernel_dynamic_start>
    50201646:	e398                	sd	a4,0(a5)
    50201648:	83818793          	addi	a5,gp,-1992 # 50209698 <user_dynamic_start>
    5020164c:	6398                	ld	a4,0(a5)
    5020164e:	6785                	lui	a5,0x1
    50201650:	973e                	add	a4,a4,a5
    50201652:	83818793          	addi	a5,gp,-1992 # 50209698 <user_dynamic_start>
    50201656:	e398                	sd	a4,0(a5)
    50201658:	83018793          	addi	a5,gp,-2000 # 50209690 <kernel_dynamic_start>
    5020165c:	6398                	ld	a4,0(a5)
    5020165e:	0000b797          	auipc	a5,0xb
    50201662:	8ba78793          	addi	a5,a5,-1862 # 5020bf18 <pcb>
    50201666:	ffb8                	sd	a4,120(a5)
    50201668:	83018793          	addi	a5,gp,-2000 # 50209690 <kernel_dynamic_start>
    5020166c:	6398                	ld	a4,0(a5)
    5020166e:	0000b797          	auipc	a5,0xb
    50201672:	8aa78793          	addi	a5,a5,-1878 # 5020bf18 <pcb>
    50201676:	e398                	sd	a4,0(a5)
    50201678:	83818793          	addi	a5,gp,-1992 # 50209698 <user_dynamic_start>
    5020167c:	6398                	ld	a4,0(a5)
    5020167e:	0000b797          	auipc	a5,0xb
    50201682:	89a78793          	addi	a5,a5,-1894 # 5020bf18 <pcb>
    50201686:	e3d8                	sd	a4,128(a5)
    50201688:	83818793          	addi	a5,gp,-1992 # 50209698 <user_dynamic_start>
    5020168c:	6398                	ld	a4,0(a5)
    5020168e:	0000b797          	auipc	a5,0xb
    50201692:	88a78793          	addi	a5,a5,-1910 # 5020bf18 <pcb>
    50201696:	e798                	sd	a4,8(a5)
    50201698:	0000b797          	auipc	a5,0xb
    5020169c:	88078793          	addi	a5,a5,-1920 # 5020bf18 <pcb>
    502016a0:	0007b823          	sd	zero,16(a5)
    502016a4:	0000b797          	auipc	a5,0xb
    502016a8:	87478793          	addi	a5,a5,-1932 # 5020bf18 <pcb>
    502016ac:	0407a823          	sw	zero,80(a5)
    502016b0:	0000b797          	auipc	a5,0xb
    502016b4:	86878793          	addi	a5,a5,-1944 # 5020bf18 <pcb>
    502016b8:	4705                	li	a4,1
    502016ba:	cbf8                	sw	a4,84(a5)
    502016bc:	0000b797          	auipc	a5,0xb
    502016c0:	85c78793          	addi	a5,a5,-1956 # 5020bf18 <pcb>
    502016c4:	4709                	li	a4,2
    502016c6:	cfb8                	sw	a4,88(a5)
    502016c8:	0000b797          	auipc	a5,0xb
    502016cc:	85078793          	addi	a5,a5,-1968 # 5020bf18 <pcb>
    502016d0:	470d                	li	a4,3
    502016d2:	cff8                	sw	a4,92(a5)
    502016d4:	0000b797          	auipc	a5,0xb
    502016d8:	84478793          	addi	a5,a5,-1980 # 5020bf18 <pcb>
    502016dc:	0807a423          	sw	zero,136(a5)
    502016e0:	0000b797          	auipc	a5,0xb
    502016e4:	83878793          	addi	a5,a5,-1992 # 5020bf18 <pcb>
    502016e8:	0807a623          	sw	zero,140(a5)
    502016ec:	0000b797          	auipc	a5,0xb
    502016f0:	82c78793          	addi	a5,a5,-2004 # 5020bf18 <pcb>
    502016f4:	0607b423          	sd	zero,104(a5)
    502016f8:	0000b797          	auipc	a5,0xb
    502016fc:	82078793          	addi	a5,a5,-2016 # 5020bf18 <pcb>
    50201700:	0607a023          	sw	zero,96(a5)
    50201704:	0000b797          	auipc	a5,0xb
    50201708:	81478793          	addi	a5,a5,-2028 # 5020bf18 <pcb>
    5020170c:	0000a717          	auipc	a4,0xa
    50201710:	7cc70713          	addi	a4,a4,1996 # 5020bed8 <ready_queue>
    50201714:	e7b8                	sd	a4,72(a5)
    50201716:	83018793          	addi	a5,gp,-2000 # 50209690 <kernel_dynamic_start>
    5020171a:	6398                	ld	a4,0(a5)
    5020171c:	83818793          	addi	a5,gp,-1992 # 50209698 <user_dynamic_start>
    50201720:	639c                	ld	a5,0(a5)
    50201722:	00000617          	auipc	a2,0x0
    50201726:	ee460613          	addi	a2,a2,-284 # 50201606 <do_nothing>
    5020172a:	0000a697          	auipc	a3,0xa
    5020172e:	7ee68693          	addi	a3,a3,2030 # 5020bf18 <pcb>
    50201732:	85be                	mv	a1,a5
    50201734:	853a                	mv	a0,a4
    50201736:	c1fff0ef          	jal	ra,50201354 <init_pcb_stack>
    5020173a:	6505                	lui	a0,0x1
    5020173c:	0cf030ef          	jal	ra,5020500a <kmalloc>
    50201740:	87aa                	mv	a5,a0
    50201742:	873e                	mv	a4,a5
    50201744:	6785                	lui	a5,0x1
    50201746:	973e                	add	a4,a4,a5
    50201748:	83018793          	addi	a5,gp,-2000 # 50209690 <kernel_dynamic_start>
    5020174c:	e398                	sd	a4,0(a5)
    5020174e:	83818793          	addi	a5,gp,-1992 # 50209698 <user_dynamic_start>
    50201752:	6398                	ld	a4,0(a5)
    50201754:	6785                	lui	a5,0x1
    50201756:	973e                	add	a4,a4,a5
    50201758:	83818793          	addi	a5,gp,-1992 # 50209698 <user_dynamic_start>
    5020175c:	e398                	sd	a4,0(a5)
    5020175e:	83018793          	addi	a5,gp,-2000 # 50209690 <kernel_dynamic_start>
    50201762:	6398                	ld	a4,0(a5)
    50201764:	0000a797          	auipc	a5,0xa
    50201768:	7b478793          	addi	a5,a5,1972 # 5020bf18 <pcb>
    5020176c:	10e7b423          	sd	a4,264(a5)
    50201770:	83018793          	addi	a5,gp,-2000 # 50209690 <kernel_dynamic_start>
    50201774:	6398                	ld	a4,0(a5)
    50201776:	0000a797          	auipc	a5,0xa
    5020177a:	7a278793          	addi	a5,a5,1954 # 5020bf18 <pcb>
    5020177e:	ebd8                	sd	a4,144(a5)
    50201780:	83818793          	addi	a5,gp,-1992 # 50209698 <user_dynamic_start>
    50201784:	6398                	ld	a4,0(a5)
    50201786:	0000a797          	auipc	a5,0xa
    5020178a:	79278793          	addi	a5,a5,1938 # 5020bf18 <pcb>
    5020178e:	10e7b823          	sd	a4,272(a5)
    50201792:	83818793          	addi	a5,gp,-1992 # 50209698 <user_dynamic_start>
    50201796:	6398                	ld	a4,0(a5)
    50201798:	0000a797          	auipc	a5,0xa
    5020179c:	78078793          	addi	a5,a5,1920 # 5020bf18 <pcb>
    502017a0:	efd8                	sd	a4,152(a5)
    502017a2:	0000a797          	auipc	a5,0xa
    502017a6:	77678793          	addi	a5,a5,1910 # 5020bf18 <pcb>
    502017aa:	0a07b023          	sd	zero,160(a5)
    502017ae:	0000a797          	auipc	a5,0xa
    502017b2:	76a78793          	addi	a5,a5,1898 # 5020bf18 <pcb>
    502017b6:	4705                	li	a4,1
    502017b8:	0ee7a023          	sw	a4,224(a5)
    502017bc:	0000a797          	auipc	a5,0xa
    502017c0:	75c78793          	addi	a5,a5,1884 # 5020bf18 <pcb>
    502017c4:	0e07a223          	sw	zero,228(a5)
    502017c8:	0000a797          	auipc	a5,0xa
    502017cc:	75078793          	addi	a5,a5,1872 # 5020bf18 <pcb>
    502017d0:	4709                	li	a4,2
    502017d2:	0ee7a423          	sw	a4,232(a5)
    502017d6:	0000a797          	auipc	a5,0xa
    502017da:	74278793          	addi	a5,a5,1858 # 5020bf18 <pcb>
    502017de:	470d                	li	a4,3
    502017e0:	0ee7a623          	sw	a4,236(a5)
    502017e4:	0000a797          	auipc	a5,0xa
    502017e8:	73478793          	addi	a5,a5,1844 # 5020bf18 <pcb>
    502017ec:	1007ac23          	sw	zero,280(a5)
    502017f0:	0000a797          	auipc	a5,0xa
    502017f4:	72878793          	addi	a5,a5,1832 # 5020bf18 <pcb>
    502017f8:	1007ae23          	sw	zero,284(a5)
    502017fc:	0000a797          	auipc	a5,0xa
    50201800:	71c78793          	addi	a5,a5,1820 # 5020bf18 <pcb>
    50201804:	0e07bc23          	sd	zero,248(a5)
    50201808:	0000a797          	auipc	a5,0xa
    5020180c:	71078793          	addi	a5,a5,1808 # 5020bf18 <pcb>
    50201810:	0e07a823          	sw	zero,240(a5)
    50201814:	0000a797          	auipc	a5,0xa
    50201818:	70478793          	addi	a5,a5,1796 # 5020bf18 <pcb>
    5020181c:	0000a717          	auipc	a4,0xa
    50201820:	6bc70713          	addi	a4,a4,1724 # 5020bed8 <ready_queue>
    50201824:	eff8                	sd	a4,216(a5)
    50201826:	83018793          	addi	a5,gp,-2000 # 50209690 <kernel_dynamic_start>
    5020182a:	6398                	ld	a4,0(a5)
    5020182c:	83818793          	addi	a5,gp,-1992 # 50209698 <user_dynamic_start>
    50201830:	639c                	ld	a5,0(a5)
    50201832:	00006617          	auipc	a2,0x6
    50201836:	9a860613          	addi	a2,a2,-1624 # 502071da <test_shell>
    5020183a:	0000a697          	auipc	a3,0xa
    5020183e:	76e68693          	addi	a3,a3,1902 # 5020bfa8 <pcb+0x90>
    50201842:	85be                	mv	a1,a5
    50201844:	853a                	mv	a0,a4
    50201846:	b0fff0ef          	jal	ra,50201354 <init_pcb_stack>
    5020184a:	0000a797          	auipc	a5,0xa
    5020184e:	6e678793          	addi	a5,a5,1766 # 5020bf30 <pcb+0x18>
    50201852:	fef43023          	sd	a5,-32(s0)
    50201856:	0000a797          	auipc	a5,0xa
    5020185a:	76a78793          	addi	a5,a5,1898 # 5020bfc0 <pcb+0xa8>
    5020185e:	fcf43c23          	sd	a5,-40(s0)
    50201862:	fe043783          	ld	a5,-32(s0)
    50201866:	0007a023          	sw	zero,0(a5)
    5020186a:	fd843783          	ld	a5,-40(s0)
    5020186e:	4705                	li	a4,1
    50201870:	c398                	sw	a4,0(a5)
    50201872:	0000a797          	auipc	a5,0xa
    50201876:	66678793          	addi	a5,a5,1638 # 5020bed8 <ready_queue>
    5020187a:	fe043703          	ld	a4,-32(s0)
    5020187e:	e798                	sd	a4,8(a5)
    50201880:	fe043783          	ld	a5,-32(s0)
    50201884:	0000a717          	auipc	a4,0xa
    50201888:	65470713          	addi	a4,a4,1620 # 5020bed8 <ready_queue>
    5020188c:	eb98                	sd	a4,16(a5)
    5020188e:	fe043783          	ld	a5,-32(s0)
    50201892:	fd843703          	ld	a4,-40(s0)
    50201896:	e798                	sd	a4,8(a5)
    50201898:	fd843783          	ld	a5,-40(s0)
    5020189c:	fe043703          	ld	a4,-32(s0)
    502018a0:	eb98                	sd	a4,16(a5)
    502018a2:	fd843783          	ld	a5,-40(s0)
    502018a6:	0007b423          	sd	zero,8(a5)
    502018aa:	0000a797          	auipc	a5,0xa
    502018ae:	62e78793          	addi	a5,a5,1582 # 5020bed8 <ready_queue>
    502018b2:	fd843703          	ld	a4,-40(s0)
    502018b6:	eb98                	sd	a4,16(a5)
    502018b8:	0000a797          	auipc	a5,0xa
    502018bc:	62078793          	addi	a5,a5,1568 # 5020bed8 <ready_queue>
    502018c0:	4709                	li	a4,2
    502018c2:	c398                	sw	a4,0(a5)
    502018c4:	82818793          	addi	a5,gp,-2008 # 50209688 <process_id>
    502018c8:	4709                	li	a4,2
    502018ca:	c398                	sw	a4,0(a5)
    502018cc:	0000a797          	auipc	a5,0xa
    502018d0:	62478793          	addi	a5,a5,1572 # 5020bef0 <current_running>
    502018d4:	00008717          	auipc	a4,0x8
    502018d8:	b7c70713          	addi	a4,a4,-1156 # 50209450 <pid0_pcb_core0>
    502018dc:	e398                	sd	a4,0(a5)
    502018de:	0000a797          	auipc	a5,0xa
    502018e2:	61278793          	addi	a5,a5,1554 # 5020bef0 <current_running>
    502018e6:	00008717          	auipc	a4,0x8
    502018ea:	bfa70713          	addi	a4,a4,-1030 # 502094e0 <pid0_pcb_core1>
    502018ee:	e798                	sd	a4,8(a5)
    502018f0:	4789                	li	a5,2
    502018f2:	fef42623          	sw	a5,-20(s0)
    502018f6:	a8dd                	j	502019ec <init_pcb+0x3d8>
    502018f8:	6505                	lui	a0,0x1
    502018fa:	710030ef          	jal	ra,5020500a <kmalloc>
    502018fe:	87aa                	mv	a5,a0
    50201900:	873e                	mv	a4,a5
    50201902:	6785                	lui	a5,0x1
    50201904:	973e                	add	a4,a4,a5
    50201906:	83018793          	addi	a5,gp,-2000 # 50209690 <kernel_dynamic_start>
    5020190a:	e398                	sd	a4,0(a5)
    5020190c:	83818793          	addi	a5,gp,-1992 # 50209698 <user_dynamic_start>
    50201910:	6398                	ld	a4,0(a5)
    50201912:	6785                	lui	a5,0x1
    50201914:	973e                	add	a4,a4,a5
    50201916:	83818793          	addi	a5,gp,-1992 # 50209698 <user_dynamic_start>
    5020191a:	e398                	sd	a4,0(a5)
    5020191c:	83018793          	addi	a5,gp,-2000 # 50209690 <kernel_dynamic_start>
    50201920:	6394                	ld	a3,0(a5)
    50201922:	0000a617          	auipc	a2,0xa
    50201926:	5f660613          	addi	a2,a2,1526 # 5020bf18 <pcb>
    5020192a:	fec42703          	lw	a4,-20(s0)
    5020192e:	87ba                	mv	a5,a4
    50201930:	078e                	slli	a5,a5,0x3
    50201932:	97ba                	add	a5,a5,a4
    50201934:	0792                	slli	a5,a5,0x4
    50201936:	97b2                	add	a5,a5,a2
    50201938:	ffb4                	sd	a3,120(a5)
    5020193a:	83018793          	addi	a5,gp,-2000 # 50209690 <kernel_dynamic_start>
    5020193e:	6394                	ld	a3,0(a5)
    50201940:	0000a617          	auipc	a2,0xa
    50201944:	5d860613          	addi	a2,a2,1496 # 5020bf18 <pcb>
    50201948:	fec42703          	lw	a4,-20(s0)
    5020194c:	87ba                	mv	a5,a4
    5020194e:	078e                	slli	a5,a5,0x3
    50201950:	97ba                	add	a5,a5,a4
    50201952:	0792                	slli	a5,a5,0x4
    50201954:	97b2                	add	a5,a5,a2
    50201956:	e394                	sd	a3,0(a5)
    50201958:	83818793          	addi	a5,gp,-1992 # 50209698 <user_dynamic_start>
    5020195c:	6394                	ld	a3,0(a5)
    5020195e:	0000a617          	auipc	a2,0xa
    50201962:	5ba60613          	addi	a2,a2,1466 # 5020bf18 <pcb>
    50201966:	fec42703          	lw	a4,-20(s0)
    5020196a:	87ba                	mv	a5,a4
    5020196c:	078e                	slli	a5,a5,0x3
    5020196e:	97ba                	add	a5,a5,a4
    50201970:	0792                	slli	a5,a5,0x4
    50201972:	97b2                	add	a5,a5,a2
    50201974:	e3d4                	sd	a3,128(a5)
    50201976:	83818793          	addi	a5,gp,-1992 # 50209698 <user_dynamic_start>
    5020197a:	6394                	ld	a3,0(a5)
    5020197c:	0000a617          	auipc	a2,0xa
    50201980:	59c60613          	addi	a2,a2,1436 # 5020bf18 <pcb>
    50201984:	fec42703          	lw	a4,-20(s0)
    50201988:	87ba                	mv	a5,a4
    5020198a:	078e                	slli	a5,a5,0x3
    5020198c:	97ba                	add	a5,a5,a4
    5020198e:	0792                	slli	a5,a5,0x4
    50201990:	97b2                	add	a5,a5,a2
    50201992:	e794                	sd	a3,8(a5)
    50201994:	0000a697          	auipc	a3,0xa
    50201998:	58468693          	addi	a3,a3,1412 # 5020bf18 <pcb>
    5020199c:	fec42703          	lw	a4,-20(s0)
    502019a0:	87ba                	mv	a5,a4
    502019a2:	078e                	slli	a5,a5,0x3
    502019a4:	97ba                	add	a5,a5,a4
    502019a6:	0792                	slli	a5,a5,0x4
    502019a8:	97b6                	add	a5,a5,a3
    502019aa:	4709                	li	a4,2
    502019ac:	cfb8                	sw	a4,88(a5)
    502019ae:	0000a697          	auipc	a3,0xa
    502019b2:	56a68693          	addi	a3,a3,1386 # 5020bf18 <pcb>
    502019b6:	fec42703          	lw	a4,-20(s0)
    502019ba:	87ba                	mv	a5,a4
    502019bc:	078e                	slli	a5,a5,0x3
    502019be:	97ba                	add	a5,a5,a4
    502019c0:	0792                	slli	a5,a5,0x4
    502019c2:	97b6                	add	a5,a5,a3
    502019c4:	0407ae23          	sw	zero,92(a5) # 105c <_start-0x501fffa4>
    502019c8:	0000a697          	auipc	a3,0xa
    502019cc:	55068693          	addi	a3,a3,1360 # 5020bf18 <pcb>
    502019d0:	fec42703          	lw	a4,-20(s0)
    502019d4:	87ba                	mv	a5,a4
    502019d6:	078e                	slli	a5,a5,0x3
    502019d8:	97ba                	add	a5,a5,a4
    502019da:	0792                	slli	a5,a5,0x4
    502019dc:	97b6                	add	a5,a5,a3
    502019de:	577d                	li	a4,-1
    502019e0:	cbf8                	sw	a4,84(a5)
    502019e2:	fec42783          	lw	a5,-20(s0)
    502019e6:	2785                	addiw	a5,a5,1
    502019e8:	fef42623          	sw	a5,-20(s0)
    502019ec:	fec42783          	lw	a5,-20(s0)
    502019f0:	0007871b          	sext.w	a4,a5
    502019f4:	47fd                	li	a5,31
    502019f6:	f0e7d1e3          	bge	a5,a4,502018f8 <init_pcb+0x2e4>
    502019fa:	0001                	nop
    502019fc:	0001                	nop
    502019fe:	70a2                	ld	ra,40(sp)
    50201a00:	7402                	ld	s0,32(sp)
    50201a02:	6145                	addi	sp,sp,48
    50201a04:	8082                	ret

0000000050201a06 <print_syscall>:
    50201a06:	7179                	addi	sp,sp,-48
    50201a08:	f406                	sd	ra,40(sp)
    50201a0a:	f022                	sd	s0,32(sp)
    50201a0c:	1800                	addi	s0,sp,48
    50201a0e:	fea43423          	sd	a0,-24(s0)
    50201a12:	feb43023          	sd	a1,-32(s0)
    50201a16:	fcc43c23          	sd	a2,-40(s0)
    50201a1a:	fd843683          	ld	a3,-40(s0)
    50201a1e:	fe043603          	ld	a2,-32(s0)
    50201a22:	fe843583          	ld	a1,-24(s0)
    50201a26:	00007517          	auipc	a0,0x7
    50201a2a:	e0a50513          	addi	a0,a0,-502 # 50208830 <waited_task+0x3a>
    50201a2e:	020040ef          	jal	ra,50205a4e <printk>
    50201a32:	0001                	nop
    50201a34:	70a2                	ld	ra,40(sp)
    50201a36:	7402                	ld	s0,32(sp)
    50201a38:	6145                	addi	sp,sp,48
    50201a3a:	8082                	ret

0000000050201a3c <do_process_show>:
    50201a3c:	1101                	addi	sp,sp,-32
    50201a3e:	ec06                	sd	ra,24(sp)
    50201a40:	e822                	sd	s0,16(sp)
    50201a42:	1000                	addi	s0,sp,32
    50201a44:	00007517          	auipc	a0,0x7
    50201a48:	e1c50513          	addi	a0,a0,-484 # 50208860 <waited_task+0x6a>
    50201a4c:	08a040ef          	jal	ra,50205ad6 <prints>
    50201a50:	fe042623          	sw	zero,-20(s0)
    50201a54:	aa0d                	j	50201b86 <do_process_show+0x14a>
    50201a56:	0000a697          	auipc	a3,0xa
    50201a5a:	4c268693          	addi	a3,a3,1218 # 5020bf18 <pcb>
    50201a5e:	fec42703          	lw	a4,-20(s0)
    50201a62:	87ba                	mv	a5,a4
    50201a64:	078e                	slli	a5,a5,0x3
    50201a66:	97ba                	add	a5,a5,a4
    50201a68:	0792                	slli	a5,a5,0x4
    50201a6a:	97b6                	add	a5,a5,a3
    50201a6c:	4ffc                	lw	a5,92(a5)
    50201a6e:	fef42423          	sw	a5,-24(s0)
    50201a72:	fe842783          	lw	a5,-24(s0)
    50201a76:	2781                	sext.w	a5,a5
    50201a78:	10078163          	beqz	a5,50201b7a <do_process_show+0x13e>
    50201a7c:	0000a697          	auipc	a3,0xa
    50201a80:	49c68693          	addi	a3,a3,1180 # 5020bf18 <pcb>
    50201a84:	fec42703          	lw	a4,-20(s0)
    50201a88:	87ba                	mv	a5,a4
    50201a8a:	078e                	slli	a5,a5,0x3
    50201a8c:	97ba                	add	a5,a5,a4
    50201a8e:	0792                	slli	a5,a5,0x4
    50201a90:	97b6                	add	a5,a5,a3
    50201a92:	4bb8                	lw	a4,80(a5)
    50201a94:	fec42783          	lw	a5,-20(s0)
    50201a98:	863a                	mv	a2,a4
    50201a9a:	85be                	mv	a1,a5
    50201a9c:	00007517          	auipc	a0,0x7
    50201aa0:	ddc50513          	addi	a0,a0,-548 # 50208878 <waited_task+0x82>
    50201aa4:	032040ef          	jal	ra,50205ad6 <prints>
    50201aa8:	fe842783          	lw	a5,-24(s0)
    50201aac:	0007871b          	sext.w	a4,a5
    50201ab0:	4785                	li	a5,1
    50201ab2:	00f71963          	bne	a4,a5,50201ac4 <do_process_show+0x88>
    50201ab6:	00007517          	auipc	a0,0x7
    50201aba:	dda50513          	addi	a0,a0,-550 # 50208890 <waited_task+0x9a>
    50201abe:	018040ef          	jal	ra,50205ad6 <prints>
    50201ac2:	a891                	j	50201b16 <do_process_show+0xda>
    50201ac4:	fe842783          	lw	a5,-24(s0)
    50201ac8:	0007871b          	sext.w	a4,a5
    50201acc:	4789                	li	a5,2
    50201ace:	00f71963          	bne	a4,a5,50201ae0 <do_process_show+0xa4>
    50201ad2:	00007517          	auipc	a0,0x7
    50201ad6:	dc650513          	addi	a0,a0,-570 # 50208898 <waited_task+0xa2>
    50201ada:	7fd030ef          	jal	ra,50205ad6 <prints>
    50201ade:	a825                	j	50201b16 <do_process_show+0xda>
    50201ae0:	fe842783          	lw	a5,-24(s0)
    50201ae4:	0007871b          	sext.w	a4,a5
    50201ae8:	478d                	li	a5,3
    50201aea:	00f71963          	bne	a4,a5,50201afc <do_process_show+0xc0>
    50201aee:	00007517          	auipc	a0,0x7
    50201af2:	db250513          	addi	a0,a0,-590 # 502088a0 <waited_task+0xaa>
    50201af6:	7e1030ef          	jal	ra,50205ad6 <prints>
    50201afa:	a831                	j	50201b16 <do_process_show+0xda>
    50201afc:	fe842783          	lw	a5,-24(s0)
    50201b00:	0007871b          	sext.w	a4,a5
    50201b04:	4791                	li	a5,4
    50201b06:	00f71863          	bne	a4,a5,50201b16 <do_process_show+0xda>
    50201b0a:	00007517          	auipc	a0,0x7
    50201b0e:	d9e50513          	addi	a0,a0,-610 # 502088a8 <waited_task+0xb2>
    50201b12:	7c5030ef          	jal	ra,50205ad6 <prints>
    50201b16:	0000a697          	auipc	a3,0xa
    50201b1a:	40268693          	addi	a3,a3,1026 # 5020bf18 <pcb>
    50201b1e:	fec42703          	lw	a4,-20(s0)
    50201b22:	87ba                	mv	a5,a4
    50201b24:	078e                	slli	a5,a5,0x3
    50201b26:	97ba                	add	a5,a5,a4
    50201b28:	0792                	slli	a5,a5,0x4
    50201b2a:	97b6                	add	a5,a5,a3
    50201b2c:	4bfc                	lw	a5,84(a5)
    50201b2e:	fef42223          	sw	a5,-28(s0)
    50201b32:	00007517          	auipc	a0,0x7
    50201b36:	d7e50513          	addi	a0,a0,-642 # 502088b0 <waited_task+0xba>
    50201b3a:	79d030ef          	jal	ra,50205ad6 <prints>
    50201b3e:	fe442783          	lw	a5,-28(s0)
    50201b42:	0007871b          	sext.w	a4,a5
    50201b46:	57fd                	li	a5,-1
    50201b48:	00f71963          	bne	a4,a5,50201b5a <do_process_show+0x11e>
    50201b4c:	00007517          	auipc	a0,0x7
    50201b50:	d7450513          	addi	a0,a0,-652 # 502088c0 <waited_task+0xca>
    50201b54:	783030ef          	jal	ra,50205ad6 <prints>
    50201b58:	a811                	j	50201b6c <do_process_show+0x130>
    50201b5a:	fe442783          	lw	a5,-28(s0)
    50201b5e:	85be                	mv	a1,a5
    50201b60:	00007517          	auipc	a0,0x7
    50201b64:	d6850513          	addi	a0,a0,-664 # 502088c8 <waited_task+0xd2>
    50201b68:	76f030ef          	jal	ra,50205ad6 <prints>
    50201b6c:	00007517          	auipc	a0,0x7
    50201b70:	d6450513          	addi	a0,a0,-668 # 502088d0 <waited_task+0xda>
    50201b74:	763030ef          	jal	ra,50205ad6 <prints>
    50201b78:	a011                	j	50201b7c <do_process_show+0x140>
    50201b7a:	0001                	nop
    50201b7c:	fec42783          	lw	a5,-20(s0)
    50201b80:	2785                	addiw	a5,a5,1
    50201b82:	fef42623          	sw	a5,-20(s0)
    50201b86:	fec42783          	lw	a5,-20(s0)
    50201b8a:	0007871b          	sext.w	a4,a5
    50201b8e:	47fd                	li	a5,31
    50201b90:	ece7d3e3          	bge	a5,a4,50201a56 <do_process_show+0x1a>
    50201b94:	014010ef          	jal	ra,50202ba8 <screen_reflush>
    50201b98:	0001                	nop
    50201b9a:	60e2                	ld	ra,24(sp)
    50201b9c:	6442                	ld	s0,16(sp)
    50201b9e:	6105                	addi	sp,sp,32
    50201ba0:	8082                	ret

0000000050201ba2 <init_syscall>:
    50201ba2:	1141                	addi	sp,sp,-16
    50201ba4:	e422                	sd	s0,8(sp)
    50201ba6:	0800                	addi	s0,sp,16
    50201ba8:	0000b797          	auipc	a5,0xb
    50201bac:	5a078793          	addi	a5,a5,1440 # 5020d148 <syscall>
    50201bb0:	00002717          	auipc	a4,0x2
    50201bb4:	ece70713          	addi	a4,a4,-306 # 50203a7e <do_spawn>
    50201bb8:	e398                	sd	a4,0(a5)
    50201bba:	0000b797          	auipc	a5,0xb
    50201bbe:	58e78793          	addi	a5,a5,1422 # 5020d148 <syscall>
    50201bc2:	00002717          	auipc	a4,0x2
    50201bc6:	1e070713          	addi	a4,a4,480 # 50203da2 <do_exit>
    50201bca:	e798                	sd	a4,8(a5)
    50201bcc:	0000b797          	auipc	a5,0xb
    50201bd0:	57c78793          	addi	a5,a5,1404 # 5020d148 <syscall>
    50201bd4:	00001717          	auipc	a4,0x1
    50201bd8:	7d870713          	addi	a4,a4,2008 # 502033ac <do_sleep>
    50201bdc:	eb98                	sd	a4,16(a5)
    50201bde:	0000b797          	auipc	a5,0xb
    50201be2:	56a78793          	addi	a5,a5,1386 # 5020d148 <syscall>
    50201be6:	00002717          	auipc	a4,0x2
    50201bea:	4b470713          	addi	a4,a4,1204 # 5020409a <do_kill>
    50201bee:	ef98                	sd	a4,24(a5)
    50201bf0:	0000b797          	auipc	a5,0xb
    50201bf4:	55878793          	addi	a5,a5,1368 # 5020d148 <syscall>
    50201bf8:	00002717          	auipc	a4,0x2
    50201bfc:	30c70713          	addi	a4,a4,780 # 50203f04 <do_waitpid>
    50201c00:	f398                	sd	a4,32(a5)
    50201c02:	0000b797          	auipc	a5,0xb
    50201c06:	54678793          	addi	a5,a5,1350 # 5020d148 <syscall>
    50201c0a:	00000717          	auipc	a4,0x0
    50201c0e:	e3270713          	addi	a4,a4,-462 # 50201a3c <do_process_show>
    50201c12:	f798                	sd	a4,40(a5)
    50201c14:	0000b797          	auipc	a5,0xb
    50201c18:	53478793          	addi	a5,a5,1332 # 5020d148 <syscall>
    50201c1c:	00002717          	auipc	a4,0x2
    50201c20:	68670713          	addi	a4,a4,1670 # 502042a2 <do_getpid>
    50201c24:	fb98                	sd	a4,48(a5)
    50201c26:	0000b797          	auipc	a5,0xb
    50201c2a:	52278793          	addi	a5,a5,1314 # 5020d148 <syscall>
    50201c2e:	00001717          	auipc	a4,0x1
    50201c32:	49e70713          	addi	a4,a4,1182 # 502030cc <do_scheduler>
    50201c36:	ff98                	sd	a4,56(a5)
    50201c38:	0000b797          	auipc	a5,0xb
    50201c3c:	51078793          	addi	a5,a5,1296 # 5020d148 <syscall>
    50201c40:	00002717          	auipc	a4,0x2
    50201c44:	9e470713          	addi	a4,a4,-1564 # 50203624 <do_fork>
    50201c48:	e3b8                	sd	a4,64(a5)
    50201c4a:	0000b797          	auipc	a5,0xb
    50201c4e:	4fe78793          	addi	a5,a5,1278 # 5020d148 <syscall>
    50201c52:	00002717          	auipc	a4,0x2
    50201c56:	dd470713          	addi	a4,a4,-556 # 50203a26 <do_prior>
    50201c5a:	e7b8                	sd	a4,72(a5)
    50201c5c:	0000b797          	auipc	a5,0xb
    50201c60:	4ec78793          	addi	a5,a5,1260 # 5020d148 <syscall>
    50201c64:	00000717          	auipc	a4,0x0
    50201c68:	9a270713          	addi	a4,a4,-1630 # 50201606 <do_nothing>
    50201c6c:	ebb8                	sd	a4,80(a5)
    50201c6e:	0000b797          	auipc	a5,0xb
    50201c72:	4da78793          	addi	a5,a5,1242 # 5020d148 <syscall>
    50201c76:	00000717          	auipc	a4,0x0
    50201c7a:	99070713          	addi	a4,a4,-1648 # 50201606 <do_nothing>
    50201c7e:	efb8                	sd	a4,88(a5)
    50201c80:	0000b797          	auipc	a5,0xb
    50201c84:	4c878793          	addi	a5,a5,1224 # 5020d148 <syscall>
    50201c88:	00000717          	auipc	a4,0x0
    50201c8c:	d7e70713          	addi	a4,a4,-642 # 50201a06 <print_syscall>
    50201c90:	f3b8                	sd	a4,96(a5)
    50201c92:	0000b797          	auipc	a5,0xb
    50201c96:	4b678793          	addi	a5,a5,1206 # 5020d148 <syscall>
    50201c9a:	00000717          	auipc	a4,0x0
    50201c9e:	d6c70713          	addi	a4,a4,-660 # 50201a06 <print_syscall>
    50201ca2:	f7b8                	sd	a4,104(a5)
    50201ca4:	0000b797          	auipc	a5,0xb
    50201ca8:	4a478793          	addi	a5,a5,1188 # 5020d148 <syscall>
    50201cac:	00000717          	auipc	a4,0x0
    50201cb0:	d5a70713          	addi	a4,a4,-678 # 50201a06 <print_syscall>
    50201cb4:	fbb8                	sd	a4,112(a5)
    50201cb6:	0000b797          	auipc	a5,0xb
    50201cba:	49278793          	addi	a5,a5,1170 # 5020d148 <syscall>
    50201cbe:	00000717          	auipc	a4,0x0
    50201cc2:	d4870713          	addi	a4,a4,-696 # 50201a06 <print_syscall>
    50201cc6:	ffb8                	sd	a4,120(a5)
    50201cc8:	0000b797          	auipc	a5,0xb
    50201ccc:	48078793          	addi	a5,a5,1152 # 5020d148 <syscall>
    50201cd0:	00000717          	auipc	a4,0x0
    50201cd4:	d3670713          	addi	a4,a4,-714 # 50201a06 <print_syscall>
    50201cd8:	e3d8                	sd	a4,128(a5)
    50201cda:	0000b797          	auipc	a5,0xb
    50201cde:	46e78793          	addi	a5,a5,1134 # 5020d148 <syscall>
    50201ce2:	00000717          	auipc	a4,0x0
    50201ce6:	d2470713          	addi	a4,a4,-732 # 50201a06 <print_syscall>
    50201cea:	e7d8                	sd	a4,136(a5)
    50201cec:	0000b797          	auipc	a5,0xb
    50201cf0:	45c78793          	addi	a5,a5,1116 # 5020d148 <syscall>
    50201cf4:	00000717          	auipc	a4,0x0
    50201cf8:	d1270713          	addi	a4,a4,-750 # 50201a06 <print_syscall>
    50201cfc:	ebd8                	sd	a4,144(a5)
    50201cfe:	0000b797          	auipc	a5,0xb
    50201d02:	44a78793          	addi	a5,a5,1098 # 5020d148 <syscall>
    50201d06:	00000717          	auipc	a4,0x0
    50201d0a:	d0070713          	addi	a4,a4,-768 # 50201a06 <print_syscall>
    50201d0e:	efd8                	sd	a4,152(a5)
    50201d10:	0000b797          	auipc	a5,0xb
    50201d14:	43878793          	addi	a5,a5,1080 # 5020d148 <syscall>
    50201d18:	00001717          	auipc	a4,0x1
    50201d1c:	e3270713          	addi	a4,a4,-462 # 50202b4a <screen_write>
    50201d20:	efd8                	sd	a4,152(a5)
    50201d22:	0000b797          	auipc	a5,0xb
    50201d26:	42678793          	addi	a5,a5,1062 # 5020d148 <syscall>
    50201d2a:	00000717          	auipc	a4,0x0
    50201d2e:	8dc70713          	addi	a4,a4,-1828 # 50201606 <do_nothing>
    50201d32:	f3d8                	sd	a4,160(a5)
    50201d34:	0000b797          	auipc	a5,0xb
    50201d38:	41478793          	addi	a5,a5,1044 # 5020d148 <syscall>
    50201d3c:	00001717          	auipc	a4,0x1
    50201d40:	d1470713          	addi	a4,a4,-748 # 50202a50 <screen_move_cursor>
    50201d44:	f7d8                	sd	a4,168(a5)
    50201d46:	0000b797          	auipc	a5,0xb
    50201d4a:	40278793          	addi	a5,a5,1026 # 5020d148 <syscall>
    50201d4e:	00001717          	auipc	a4,0x1
    50201d52:	da870713          	addi	a4,a4,-600 # 50202af6 <screen_get_cursor>
    50201d56:	fbd8                	sd	a4,176(a5)
    50201d58:	0000b797          	auipc	a5,0xb
    50201d5c:	3f078793          	addi	a5,a5,1008 # 5020d148 <syscall>
    50201d60:	00001717          	auipc	a4,0x1
    50201d64:	e4870713          	addi	a4,a4,-440 # 50202ba8 <screen_reflush>
    50201d68:	ffd8                	sd	a4,184(a5)
    50201d6a:	0000b797          	auipc	a5,0xb
    50201d6e:	3de78793          	addi	a5,a5,990 # 5020d148 <syscall>
    50201d72:	00000717          	auipc	a4,0x0
    50201d76:	89470713          	addi	a4,a4,-1900 # 50201606 <do_nothing>
    50201d7a:	e3f8                	sd	a4,192(a5)
    50201d7c:	0000b797          	auipc	a5,0xb
    50201d80:	3cc78793          	addi	a5,a5,972 # 5020d148 <syscall>
    50201d84:	00000717          	auipc	a4,0x0
    50201d88:	88270713          	addi	a4,a4,-1918 # 50201606 <do_nothing>
    50201d8c:	e7f8                	sd	a4,200(a5)
    50201d8e:	0000b797          	auipc	a5,0xb
    50201d92:	3ba78793          	addi	a5,a5,954 # 5020d148 <syscall>
    50201d96:	00000717          	auipc	a4,0x0
    50201d9a:	87070713          	addi	a4,a4,-1936 # 50201606 <do_nothing>
    50201d9e:	ebf8                	sd	a4,208(a5)
    50201da0:	0000b797          	auipc	a5,0xb
    50201da4:	3a878793          	addi	a5,a5,936 # 5020d148 <syscall>
    50201da8:	00001717          	auipc	a4,0x1
    50201dac:	bcc70713          	addi	a4,a4,-1076 # 50202974 <screen_clear>
    50201db0:	eff8                	sd	a4,216(a5)
    50201db2:	0000b797          	auipc	a5,0xb
    50201db6:	39678793          	addi	a5,a5,918 # 5020d148 <syscall>
    50201dba:	00001717          	auipc	a4,0x1
    50201dbe:	f7070713          	addi	a4,a4,-144 # 50202d2a <getch>
    50201dc2:	f3f8                	sd	a4,224(a5)
    50201dc4:	0000b797          	auipc	a5,0xb
    50201dc8:	38478793          	addi	a5,a5,900 # 5020d148 <syscall>
    50201dcc:	fffff717          	auipc	a4,0xfffff
    50201dd0:	4e670713          	addi	a4,a4,1254 # 502012b2 <port_write_ch>
    50201dd4:	f7f8                	sd	a4,232(a5)
    50201dd6:	0000b797          	auipc	a5,0xb
    50201dda:	37278793          	addi	a5,a5,882 # 5020d148 <syscall>
    50201dde:	00002717          	auipc	a4,0x2
    50201de2:	58670713          	addi	a4,a4,1414 # 50204364 <get_time_base>
    50201de6:	fbf8                	sd	a4,240(a5)
    50201de8:	0000b797          	auipc	a5,0xb
    50201dec:	36078793          	addi	a5,a5,864 # 5020d148 <syscall>
    50201df0:	00002717          	auipc	a4,0x2
    50201df4:	53070713          	addi	a4,a4,1328 # 50204320 <get_ticks>
    50201df8:	fff8                	sd	a4,248(a5)
    50201dfa:	0000b797          	auipc	a5,0xb
    50201dfe:	34e78793          	addi	a5,a5,846 # 5020d148 <syscall>
    50201e02:	00002717          	auipc	a4,0x2
    50201e06:	5b070713          	addi	a4,a4,1456 # 502043b2 <get_walltime>
    50201e0a:	10e7b023          	sd	a4,256(a5)
    50201e0e:	0000b797          	auipc	a5,0xb
    50201e12:	33a78793          	addi	a5,a5,826 # 5020d148 <syscall>
    50201e16:	00001717          	auipc	a4,0x1
    50201e1a:	17e70713          	addi	a4,a4,382 # 50202f94 <get_mutex>
    50201e1e:	10e7b423          	sd	a4,264(a5)
    50201e22:	0000b797          	auipc	a5,0xb
    50201e26:	32678793          	addi	a5,a5,806 # 5020d148 <syscall>
    50201e2a:	00001717          	auipc	a4,0x1
    50201e2e:	1b270713          	addi	a4,a4,434 # 50202fdc <lock_mutex>
    50201e32:	10e7b823          	sd	a4,272(a5)
    50201e36:	0000b797          	auipc	a5,0xb
    50201e3a:	31278793          	addi	a5,a5,786 # 5020d148 <syscall>
    50201e3e:	00001717          	auipc	a4,0x1
    50201e42:	1d470713          	addi	a4,a4,468 # 50203012 <unlock_mutex>
    50201e46:	10e7bc23          	sd	a4,280(a5)
    50201e4a:	0000b797          	auipc	a5,0xb
    50201e4e:	2fe78793          	addi	a5,a5,766 # 5020d148 <syscall>
    50201e52:	fffff717          	auipc	a4,0xfffff
    50201e56:	7b470713          	addi	a4,a4,1972 # 50201606 <do_nothing>
    50201e5a:	12e7b023          	sd	a4,288(a5)
    50201e5e:	0000b797          	auipc	a5,0xb
    50201e62:	2ea78793          	addi	a5,a5,746 # 5020d148 <syscall>
    50201e66:	00002717          	auipc	a4,0x2
    50201e6a:	57870713          	addi	a4,a4,1400 # 502043de <do_barrier_init>
    50201e6e:	12e7b423          	sd	a4,296(a5)
    50201e72:	0000b797          	auipc	a5,0xb
    50201e76:	2d678793          	addi	a5,a5,726 # 5020d148 <syscall>
    50201e7a:	00002717          	auipc	a4,0x2
    50201e7e:	60c70713          	addi	a4,a4,1548 # 50204486 <do_barrier_wait>
    50201e82:	12e7b823          	sd	a4,304(a5)
    50201e86:	0000b797          	auipc	a5,0xb
    50201e8a:	2c278793          	addi	a5,a5,706 # 5020d148 <syscall>
    50201e8e:	00002717          	auipc	a4,0x2
    50201e92:	6e270713          	addi	a4,a4,1762 # 50204570 <do_barrier_destroy>
    50201e96:	12e7bc23          	sd	a4,312(a5)
    50201e9a:	0000b797          	auipc	a5,0xb
    50201e9e:	2ae78793          	addi	a5,a5,686 # 5020d148 <syscall>
    50201ea2:	00002717          	auipc	a4,0x2
    50201ea6:	71870713          	addi	a4,a4,1816 # 502045ba <do_semaphore_init>
    50201eaa:	14e7b023          	sd	a4,320(a5)
    50201eae:	0000b797          	auipc	a5,0xb
    50201eb2:	29a78793          	addi	a5,a5,666 # 5020d148 <syscall>
    50201eb6:	00002717          	auipc	a4,0x2
    50201eba:	7ac70713          	addi	a4,a4,1964 # 50204662 <do_semaphore_up>
    50201ebe:	14e7b423          	sd	a4,328(a5)
    50201ec2:	0000b797          	auipc	a5,0xb
    50201ec6:	28678793          	addi	a5,a5,646 # 5020d148 <syscall>
    50201eca:	00003717          	auipc	a4,0x3
    50201ece:	85a70713          	addi	a4,a4,-1958 # 50204724 <do_semaphore_down>
    50201ed2:	14e7b823          	sd	a4,336(a5)
    50201ed6:	0000b797          	auipc	a5,0xb
    50201eda:	27278793          	addi	a5,a5,626 # 5020d148 <syscall>
    50201ede:	00003717          	auipc	a4,0x3
    50201ee2:	92870713          	addi	a4,a4,-1752 # 50204806 <do_semaphore_destroy>
    50201ee6:	14e7bc23          	sd	a4,344(a5)
    50201eea:	0000b797          	auipc	a5,0xb
    50201eee:	25e78793          	addi	a5,a5,606 # 5020d148 <syscall>
    50201ef2:	00003717          	auipc	a4,0x3
    50201ef6:	95e70713          	addi	a4,a4,-1698 # 50204850 <do_mbox_open>
    50201efa:	16e7b023          	sd	a4,352(a5)
    50201efe:	0000b797          	auipc	a5,0xb
    50201f02:	24a78793          	addi	a5,a5,586 # 5020d148 <syscall>
    50201f06:	00003717          	auipc	a4,0x3
    50201f0a:	b4a70713          	addi	a4,a4,-1206 # 50204a50 <do_mbox_close>
    50201f0e:	16e7b423          	sd	a4,360(a5)
    50201f12:	0000b797          	auipc	a5,0xb
    50201f16:	23678793          	addi	a5,a5,566 # 5020d148 <syscall>
    50201f1a:	00003717          	auipc	a4,0x3
    50201f1e:	c5a70713          	addi	a4,a4,-934 # 50204b74 <do_mbox_send>
    50201f22:	16e7b823          	sd	a4,368(a5)
    50201f26:	0000b797          	auipc	a5,0xb
    50201f2a:	22278793          	addi	a5,a5,546 # 5020d148 <syscall>
    50201f2e:	00003717          	auipc	a4,0x3
    50201f32:	e1e70713          	addi	a4,a4,-482 # 50204d4c <do_mbox_recv>
    50201f36:	16e7bc23          	sd	a4,376(a5)
    50201f3a:	0000b797          	auipc	a5,0xb
    50201f3e:	20e78793          	addi	a5,a5,526 # 5020d148 <syscall>
    50201f42:	00002717          	auipc	a4,0x2
    50201f46:	39070713          	addi	a4,a4,912 # 502042d2 <do_taskset>
    50201f4a:	18e7b023          	sd	a4,384(a5)
    50201f4e:	0001                	nop
    50201f50:	6422                	ld	s0,8(sp)
    50201f52:	0141                	addi	sp,sp,16
    50201f54:	8082                	ret

0000000050201f56 <main>:
    50201f56:	1141                	addi	sp,sp,-16
    50201f58:	e406                	sd	ra,8(sp)
    50201f5a:	e022                	sd	s0,0(sp)
    50201f5c:	0800                	addi	s0,sp,16
    50201f5e:	aeaff0ef          	jal	ra,50201248 <get_current_cpu_id>
    50201f62:	872a                	mv	a4,a0
    50201f64:	4785                	li	a5,1
    50201f66:	02f71763          	bne	a4,a5,50201f94 <main+0x3e>
    50201f6a:	00007517          	auipc	a0,0x7
    50201f6e:	96e50513          	addi	a0,a0,-1682 # 502088d8 <waited_task+0xe2>
    50201f72:	2dd030ef          	jal	ra,50205a4e <printk>
    50201f76:	8feff0ef          	jal	ra,50201074 <setup_exception>
    50201f7a:	3a6020ef          	jal	ra,50204320 <get_ticks>
    50201f7e:	872a                	mv	a4,a0
    50201f80:	67c1                	lui	a5,0x10
    50201f82:	97ba                	add	a5,a5,a4
    50201f84:	853e                	mv	a0,a5
    50201f86:	b86ff0ef          	jal	ra,5020130c <sbi_set_timer>
    50201f8a:	916ff0ef          	jal	ra,502010a0 <enable_interrupt>
    50201f8e:	e78ff0ef          	jal	ra,50201606 <do_nothing>
    50201f92:	bff5                	j	50201f8e <main+0x38>
    50201f94:	00007517          	auipc	a0,0x7
    50201f98:	95c50513          	addi	a0,a0,-1700 # 502088f0 <waited_task+0xfa>
    50201f9c:	2b3030ef          	jal	ra,50205a4e <printk>
    50201fa0:	5e7000ef          	jal	ra,50202d86 <getchar>
    50201fa4:	0000a517          	auipc	a0,0xa
    50201fa8:	9ec50513          	addi	a0,a0,-1556 # 5020b990 <kernel_lock>
    50201fac:	09c010ef          	jal	ra,50203048 <spin_lock_init>
    50201fb0:	e64ff0ef          	jal	ra,50201614 <init_pcb>
    50201fb4:	00007517          	auipc	a0,0x7
    50201fb8:	96450513          	addi	a0,a0,-1692 # 50208918 <waited_task+0x122>
    50201fbc:	293030ef          	jal	ra,50205a4e <printk>
    50201fc0:	4501                	li	a0,0
    50201fc2:	b6aff0ef          	jal	ra,5020132c <sbi_read_fdt>
    50201fc6:	87aa                	mv	a5,a0
    50201fc8:	0007871b          	sext.w	a4,a5
    50201fcc:	86018793          	addi	a5,gp,-1952 # 502096c0 <time_base>
    50201fd0:	c398                	sw	a4,0(a5)
    50201fd2:	bd1ff0ef          	jal	ra,50201ba2 <init_syscall>
    50201fd6:	00007517          	auipc	a0,0x7
    50201fda:	97250513          	addi	a0,a0,-1678 # 50208948 <waited_task+0x152>
    50201fde:	271030ef          	jal	ra,50205a4e <printk>
    50201fe2:	17d000ef          	jal	ra,5020295e <init_screen>
    50201fe6:	00007517          	auipc	a0,0x7
    50201fea:	99a50513          	addi	a0,a0,-1638 # 50208980 <waited_task+0x18a>
    50201fee:	261030ef          	jal	ra,50205a4e <printk>
    50201ff2:	00007797          	auipc	a5,0x7
    50201ff6:	66e78793          	addi	a5,a5,1646 # 50209660 <pid0_stack_core0>
    50201ffa:	6398                	ld	a4,0(a5)
    50201ffc:	00009797          	auipc	a5,0x9
    50202000:	73478793          	addi	a5,a5,1844 # 5020b730 <cpu_stack_pointer>
    50202004:	e398                	sd	a4,0(a5)
    50202006:	00007797          	auipc	a5,0x7
    5020200a:	66278793          	addi	a5,a5,1634 # 50209668 <pid0_stack_core1>
    5020200e:	6398                	ld	a4,0(a5)
    50202010:	00009797          	auipc	a5,0x9
    50202014:	72078793          	addi	a5,a5,1824 # 5020b730 <cpu_stack_pointer>
    50202018:	e798                	sd	a4,8(a5)
    5020201a:	00007717          	auipc	a4,0x7
    5020201e:	43670713          	addi	a4,a4,1078 # 50209450 <pid0_pcb_core0>
    50202022:	00009797          	auipc	a5,0x9
    50202026:	71e78793          	addi	a5,a5,1822 # 5020b740 <cpu_pcb_pointer>
    5020202a:	e398                	sd	a4,0(a5)
    5020202c:	00007717          	auipc	a4,0x7
    50202030:	4b470713          	addi	a4,a4,1204 # 502094e0 <pid0_pcb_core1>
    50202034:	00009797          	auipc	a5,0x9
    50202038:	70c78793          	addi	a5,a5,1804 # 5020b740 <cpu_pcb_pointer>
    5020203c:	e798                	sd	a4,8(a5)
    5020203e:	0000a797          	auipc	a5,0xa
    50202042:	ec278793          	addi	a5,a5,-318 # 5020bf00 <sleep_queue>
    50202046:	0007a023          	sw	zero,0(a5)
    5020204a:	0000a797          	auipc	a5,0xa
    5020204e:	eb678793          	addi	a5,a5,-330 # 5020bf00 <sleep_queue>
    50202052:	0007b823          	sd	zero,16(a5)
    50202056:	0000a797          	auipc	a5,0xa
    5020205a:	eaa78793          	addi	a5,a5,-342 # 5020bf00 <sleep_queue>
    5020205e:	0007b423          	sd	zero,8(a5)
    50202062:	0000b797          	auipc	a5,0xb
    50202066:	0ce78793          	addi	a5,a5,206 # 5020d130 <exit_queue>
    5020206a:	0007a023          	sw	zero,0(a5)
    5020206e:	0000b797          	auipc	a5,0xb
    50202072:	0c278793          	addi	a5,a5,194 # 5020d130 <exit_queue>
    50202076:	0007b823          	sd	zero,16(a5)
    5020207a:	0000b797          	auipc	a5,0xb
    5020207e:	0b678793          	addi	a5,a5,182 # 5020d130 <exit_queue>
    50202082:	0007b423          	sd	zero,8(a5)
    50202086:	00007517          	auipc	a0,0x7
    5020208a:	92a50513          	addi	a0,a0,-1750 # 502089b0 <waited_task+0x1ba>
    5020208e:	1c1030ef          	jal	ra,50205a4e <printk>
    50202092:	6e1020ef          	jal	ra,50204f72 <wakeup_other_hart>
    50202096:	192000ef          	jal	ra,50202228 <init_exception>
    5020209a:	00007517          	auipc	a0,0x7
    5020209e:	92e50513          	addi	a0,a0,-1746 # 502089c8 <waited_task+0x1d2>
    502020a2:	1ad030ef          	jal	ra,50205a4e <printk>
    502020a6:	27a020ef          	jal	ra,50204320 <get_ticks>
    502020aa:	872a                	mv	a4,a0
    502020ac:	86018793          	addi	a5,gp,-1952 # 502096c0 <time_base>
    502020b0:	439c                	lw	a5,0(a5)
    502020b2:	86be                	mv	a3,a5
    502020b4:	06400793          	li	a5,100
    502020b8:	02f6d7bb          	divuw	a5,a3,a5
    502020bc:	2781                	sext.w	a5,a5
    502020be:	1782                	slli	a5,a5,0x20
    502020c0:	9381                	srli	a5,a5,0x20
    502020c2:	97ba                	add	a5,a5,a4
    502020c4:	853e                	mv	a0,a5
    502020c6:	a46ff0ef          	jal	ra,5020130c <sbi_set_timer>
    502020ca:	fd7fe0ef          	jal	ra,502010a0 <enable_interrupt>
    502020ce:	d38ff0ef          	jal	ra,50201606 <do_nothing>
    502020d2:	bff5                	j	502020ce <main+0x178>

00000000502020d4 <_panic>:
    502020d4:	7179                	addi	sp,sp,-48
    502020d6:	f406                	sd	ra,40(sp)
    502020d8:	f022                	sd	s0,32(sp)
    502020da:	1800                	addi	s0,sp,48
    502020dc:	fea43423          	sd	a0,-24(s0)
    502020e0:	87ae                	mv	a5,a1
    502020e2:	fcc43c23          	sd	a2,-40(s0)
    502020e6:	fef42223          	sw	a5,-28(s0)
    502020ea:	fe442783          	lw	a5,-28(s0)
    502020ee:	86be                	mv	a3,a5
    502020f0:	fe843603          	ld	a2,-24(s0)
    502020f4:	fd843583          	ld	a1,-40(s0)
    502020f8:	00007517          	auipc	a0,0x7
    502020fc:	a1050513          	addi	a0,a0,-1520 # 50208b08 <waited_task+0x312>
    50202100:	14f030ef          	jal	ra,50205a4e <printk>
    50202104:	a001                	j	50202104 <_panic+0x30>

0000000050202106 <sbi_set_timer>:
    50202106:	1101                	addi	sp,sp,-32
    50202108:	ec22                	sd	s0,24(sp)
    5020210a:	1000                	addi	s0,sp,32
    5020210c:	fea43423          	sd	a0,-24(s0)
    50202110:	fe843503          	ld	a0,-24(s0)
    50202114:	4581                	li	a1,0
    50202116:	4601                	li	a2,0
    50202118:	4881                	li	a7,0
    5020211a:	00000073          	ecall
    5020211e:	0001                	nop
    50202120:	6462                	ld	s0,24(sp)
    50202122:	6105                	addi	sp,sp,32
    50202124:	8082                	ret

0000000050202126 <reset_irq_timer>:
    50202126:	1101                	addi	sp,sp,-32
    50202128:	ec06                	sd	ra,24(sp)
    5020212a:	e822                	sd	s0,16(sp)
    5020212c:	1000                	addi	s0,sp,32
    5020212e:	27b000ef          	jal	ra,50202ba8 <screen_reflush>
    50202132:	1ee020ef          	jal	ra,50204320 <get_ticks>
    50202136:	fea43423          	sd	a0,-24(s0)
    5020213a:	90eff0ef          	jal	ra,50201248 <get_current_cpu_id>
    5020213e:	87aa                	mv	a5,a0
    50202140:	fef42223          	sw	a5,-28(s0)
    50202144:	86018793          	addi	a5,gp,-1952 # 502096c0 <time_base>
    50202148:	439c                	lw	a5,0(a5)
    5020214a:	873e                	mv	a4,a5
    5020214c:	06400793          	li	a5,100
    50202150:	02f757bb          	divuw	a5,a4,a5
    50202154:	2781                	sext.w	a5,a5
    50202156:	02079713          	slli	a4,a5,0x20
    5020215a:	9301                	srli	a4,a4,0x20
    5020215c:	fe843783          	ld	a5,-24(s0)
    50202160:	97ba                	add	a5,a5,a4
    50202162:	853e                	mv	a0,a5
    50202164:	fa3ff0ef          	jal	ra,50202106 <sbi_set_timer>
    50202168:	0000a717          	auipc	a4,0xa
    5020216c:	d8870713          	addi	a4,a4,-632 # 5020bef0 <current_running>
    50202170:	fe442783          	lw	a5,-28(s0)
    50202174:	078e                	slli	a5,a5,0x3
    50202176:	97ba                	add	a5,a5,a4
    50202178:	639c                	ld	a5,0(a5)
    5020217a:	7bbc                	ld	a5,112(a5)
    5020217c:	fe843703          	ld	a4,-24(s0)
    50202180:	00e7f463          	bgeu	a5,a4,50202188 <reset_irq_timer+0x62>
    50202184:	749000ef          	jal	ra,502030cc <do_scheduler>
    50202188:	0001                	nop
    5020218a:	60e2                	ld	ra,24(sp)
    5020218c:	6442                	ld	s0,16(sp)
    5020218e:	6105                	addi	sp,sp,32
    50202190:	8082                	ret

0000000050202192 <interrupt_helper>:
    50202192:	7179                	addi	sp,sp,-48
    50202194:	f406                	sd	ra,40(sp)
    50202196:	f022                	sd	s0,32(sp)
    50202198:	1800                	addi	s0,sp,48
    5020219a:	fea43423          	sd	a0,-24(s0)
    5020219e:	feb43023          	sd	a1,-32(s0)
    502021a2:	fcc43c23          	sd	a2,-40(s0)
    502021a6:	fd843783          	ld	a5,-40(s0)
    502021aa:	0207d663          	bgez	a5,502021d6 <interrupt_helper+0x44>
    502021ae:	fd843703          	ld	a4,-40(s0)
    502021b2:	57fd                	li	a5,-1
    502021b4:	8385                	srli	a5,a5,0x1
    502021b6:	8ff9                	and	a5,a5,a4
    502021b8:	0000a717          	auipc	a4,0xa
    502021bc:	cb070713          	addi	a4,a4,-848 # 5020be68 <irq_table>
    502021c0:	078e                	slli	a5,a5,0x3
    502021c2:	97ba                	add	a5,a5,a4
    502021c4:	639c                	ld	a5,0(a5)
    502021c6:	fd843603          	ld	a2,-40(s0)
    502021ca:	fe043583          	ld	a1,-32(s0)
    502021ce:	fe843503          	ld	a0,-24(s0)
    502021d2:	9782                	jalr	a5
    502021d4:	a025                	j	502021fc <interrupt_helper+0x6a>
    502021d6:	fd843703          	ld	a4,-40(s0)
    502021da:	57fd                	li	a5,-1
    502021dc:	8385                	srli	a5,a5,0x1
    502021de:	8ff9                	and	a5,a5,a4
    502021e0:	0000a717          	auipc	a4,0xa
    502021e4:	c0070713          	addi	a4,a4,-1024 # 5020bde0 <exc_table>
    502021e8:	078e                	slli	a5,a5,0x3
    502021ea:	97ba                	add	a5,a5,a4
    502021ec:	639c                	ld	a5,0(a5)
    502021ee:	fd843603          	ld	a2,-40(s0)
    502021f2:	fe043583          	ld	a1,-32(s0)
    502021f6:	fe843503          	ld	a0,-24(s0)
    502021fa:	9782                	jalr	a5
    502021fc:	0001                	nop
    502021fe:	70a2                	ld	ra,40(sp)
    50202200:	7402                	ld	s0,32(sp)
    50202202:	6145                	addi	sp,sp,48
    50202204:	8082                	ret

0000000050202206 <handle_int>:
    50202206:	7179                	addi	sp,sp,-48
    50202208:	f406                	sd	ra,40(sp)
    5020220a:	f022                	sd	s0,32(sp)
    5020220c:	1800                	addi	s0,sp,48
    5020220e:	fea43423          	sd	a0,-24(s0)
    50202212:	feb43023          	sd	a1,-32(s0)
    50202216:	fcc43c23          	sd	a2,-40(s0)
    5020221a:	f0dff0ef          	jal	ra,50202126 <reset_irq_timer>
    5020221e:	0001                	nop
    50202220:	70a2                	ld	ra,40(sp)
    50202222:	7402                	ld	s0,32(sp)
    50202224:	6145                	addi	sp,sp,48
    50202226:	8082                	ret

0000000050202228 <init_exception>:
    50202228:	1141                	addi	sp,sp,-16
    5020222a:	e406                	sd	ra,8(sp)
    5020222c:	e022                	sd	s0,0(sp)
    5020222e:	0800                	addi	s0,sp,16
    50202230:	0000a797          	auipc	a5,0xa
    50202234:	c3878793          	addi	a5,a5,-968 # 5020be68 <irq_table>
    50202238:	00000717          	auipc	a4,0x0
    5020223c:	1b670713          	addi	a4,a4,438 # 502023ee <handle_other>
    50202240:	e398                	sd	a4,0(a5)
    50202242:	0000a797          	auipc	a5,0xa
    50202246:	c2678793          	addi	a5,a5,-986 # 5020be68 <irq_table>
    5020224a:	00000717          	auipc	a4,0x0
    5020224e:	1a470713          	addi	a4,a4,420 # 502023ee <handle_other>
    50202252:	e798                	sd	a4,8(a5)
    50202254:	0000a797          	auipc	a5,0xa
    50202258:	c1478793          	addi	a5,a5,-1004 # 5020be68 <irq_table>
    5020225c:	00000717          	auipc	a4,0x0
    50202260:	19270713          	addi	a4,a4,402 # 502023ee <handle_other>
    50202264:	eb98                	sd	a4,16(a5)
    50202266:	0000a797          	auipc	a5,0xa
    5020226a:	c0278793          	addi	a5,a5,-1022 # 5020be68 <irq_table>
    5020226e:	00000717          	auipc	a4,0x0
    50202272:	18070713          	addi	a4,a4,384 # 502023ee <handle_other>
    50202276:	ef98                	sd	a4,24(a5)
    50202278:	0000a797          	auipc	a5,0xa
    5020227c:	bf078793          	addi	a5,a5,-1040 # 5020be68 <irq_table>
    50202280:	00000717          	auipc	a4,0x0
    50202284:	16e70713          	addi	a4,a4,366 # 502023ee <handle_other>
    50202288:	f398                	sd	a4,32(a5)
    5020228a:	0000a797          	auipc	a5,0xa
    5020228e:	bde78793          	addi	a5,a5,-1058 # 5020be68 <irq_table>
    50202292:	00000717          	auipc	a4,0x0
    50202296:	f7470713          	addi	a4,a4,-140 # 50202206 <handle_int>
    5020229a:	f798                	sd	a4,40(a5)
    5020229c:	0000a797          	auipc	a5,0xa
    502022a0:	bcc78793          	addi	a5,a5,-1076 # 5020be68 <irq_table>
    502022a4:	00000717          	auipc	a4,0x0
    502022a8:	14a70713          	addi	a4,a4,330 # 502023ee <handle_other>
    502022ac:	fb98                	sd	a4,48(a5)
    502022ae:	0000a797          	auipc	a5,0xa
    502022b2:	bba78793          	addi	a5,a5,-1094 # 5020be68 <irq_table>
    502022b6:	00000717          	auipc	a4,0x0
    502022ba:	13870713          	addi	a4,a4,312 # 502023ee <handle_other>
    502022be:	ff98                	sd	a4,56(a5)
    502022c0:	0000a797          	auipc	a5,0xa
    502022c4:	ba878793          	addi	a5,a5,-1112 # 5020be68 <irq_table>
    502022c8:	00000717          	auipc	a4,0x0
    502022cc:	12670713          	addi	a4,a4,294 # 502023ee <handle_other>
    502022d0:	e3b8                	sd	a4,64(a5)
    502022d2:	0000a797          	auipc	a5,0xa
    502022d6:	b9678793          	addi	a5,a5,-1130 # 5020be68 <irq_table>
    502022da:	00000717          	auipc	a4,0x0
    502022de:	11470713          	addi	a4,a4,276 # 502023ee <handle_other>
    502022e2:	e7b8                	sd	a4,72(a5)
    502022e4:	0000a797          	auipc	a5,0xa
    502022e8:	b8478793          	addi	a5,a5,-1148 # 5020be68 <irq_table>
    502022ec:	00000717          	auipc	a4,0x0
    502022f0:	10270713          	addi	a4,a4,258 # 502023ee <handle_other>
    502022f4:	ebb8                	sd	a4,80(a5)
    502022f6:	0000a797          	auipc	a5,0xa
    502022fa:	b7278793          	addi	a5,a5,-1166 # 5020be68 <irq_table>
    502022fe:	00000717          	auipc	a4,0x0
    50202302:	0f070713          	addi	a4,a4,240 # 502023ee <handle_other>
    50202306:	efb8                	sd	a4,88(a5)
    50202308:	0000a797          	auipc	a5,0xa
    5020230c:	ad878793          	addi	a5,a5,-1320 # 5020bde0 <exc_table>
    50202310:	00000717          	auipc	a4,0x0
    50202314:	0de70713          	addi	a4,a4,222 # 502023ee <handle_other>
    50202318:	e398                	sd	a4,0(a5)
    5020231a:	0000a797          	auipc	a5,0xa
    5020231e:	ac678793          	addi	a5,a5,-1338 # 5020bde0 <exc_table>
    50202322:	00000717          	auipc	a4,0x0
    50202326:	0cc70713          	addi	a4,a4,204 # 502023ee <handle_other>
    5020232a:	e798                	sd	a4,8(a5)
    5020232c:	0000a797          	auipc	a5,0xa
    50202330:	ab478793          	addi	a5,a5,-1356 # 5020bde0 <exc_table>
    50202334:	00000717          	auipc	a4,0x0
    50202338:	0ba70713          	addi	a4,a4,186 # 502023ee <handle_other>
    5020233c:	eb98                	sd	a4,16(a5)
    5020233e:	0000a797          	auipc	a5,0xa
    50202342:	aa278793          	addi	a5,a5,-1374 # 5020bde0 <exc_table>
    50202346:	00000717          	auipc	a4,0x0
    5020234a:	0a870713          	addi	a4,a4,168 # 502023ee <handle_other>
    5020234e:	ef98                	sd	a4,24(a5)
    50202350:	0000a797          	auipc	a5,0xa
    50202354:	a9078793          	addi	a5,a5,-1392 # 5020bde0 <exc_table>
    50202358:	00000717          	auipc	a4,0x0
    5020235c:	09670713          	addi	a4,a4,150 # 502023ee <handle_other>
    50202360:	f398                	sd	a4,32(a5)
    50202362:	0000a797          	auipc	a5,0xa
    50202366:	a7e78793          	addi	a5,a5,-1410 # 5020bde0 <exc_table>
    5020236a:	00000717          	auipc	a4,0x0
    5020236e:	08470713          	addi	a4,a4,132 # 502023ee <handle_other>
    50202372:	f798                	sd	a4,40(a5)
    50202374:	0000a797          	auipc	a5,0xa
    50202378:	a6c78793          	addi	a5,a5,-1428 # 5020bde0 <exc_table>
    5020237c:	00000717          	auipc	a4,0x0
    50202380:	07270713          	addi	a4,a4,114 # 502023ee <handle_other>
    50202384:	ff98                	sd	a4,56(a5)
    50202386:	0000a797          	auipc	a5,0xa
    5020238a:	a5a78793          	addi	a5,a5,-1446 # 5020bde0 <exc_table>
    5020238e:	00003717          	auipc	a4,0x3
    50202392:	cb070713          	addi	a4,a4,-848 # 5020503e <handle_syscall>
    50202396:	e3b8                	sd	a4,64(a5)
    50202398:	0000a797          	auipc	a5,0xa
    5020239c:	a4878793          	addi	a5,a5,-1464 # 5020bde0 <exc_table>
    502023a0:	00000717          	auipc	a4,0x0
    502023a4:	04e70713          	addi	a4,a4,78 # 502023ee <handle_other>
    502023a8:	f3b8                	sd	a4,96(a5)
    502023aa:	0000a797          	auipc	a5,0xa
    502023ae:	a3678793          	addi	a5,a5,-1482 # 5020bde0 <exc_table>
    502023b2:	00000717          	auipc	a4,0x0
    502023b6:	03c70713          	addi	a4,a4,60 # 502023ee <handle_other>
    502023ba:	f7b8                	sd	a4,104(a5)
    502023bc:	0000a797          	auipc	a5,0xa
    502023c0:	a2478793          	addi	a5,a5,-1500 # 5020bde0 <exc_table>
    502023c4:	00000717          	auipc	a4,0x0
    502023c8:	02a70713          	addi	a4,a4,42 # 502023ee <handle_other>
    502023cc:	fbb8                	sd	a4,112(a5)
    502023ce:	0000a797          	auipc	a5,0xa
    502023d2:	a1278793          	addi	a5,a5,-1518 # 5020bde0 <exc_table>
    502023d6:	00000717          	auipc	a4,0x0
    502023da:	01870713          	addi	a4,a4,24 # 502023ee <handle_other>
    502023de:	ffb8                	sd	a4,120(a5)
    502023e0:	c95fe0ef          	jal	ra,50201074 <setup_exception>
    502023e4:	0001                	nop
    502023e6:	60a2                	ld	ra,8(sp)
    502023e8:	6402                	ld	s0,0(sp)
    502023ea:	0141                	addi	sp,sp,16
    502023ec:	8082                	ret

00000000502023ee <handle_other>:
    502023ee:	710d                	addi	sp,sp,-352
    502023f0:	ee86                	sd	ra,344(sp)
    502023f2:	eaa2                	sd	s0,336(sp)
    502023f4:	1280                	addi	s0,sp,352
    502023f6:	eaa43c23          	sd	a0,-328(s0)
    502023fa:	eab43823          	sd	a1,-336(s0)
    502023fe:	eac43423          	sd	a2,-344(s0)
    50202402:	00006717          	auipc	a4,0x6
    50202406:	7ee70713          	addi	a4,a4,2030 # 50208bf0 <waited_task+0x3fa>
    5020240a:	ec840793          	addi	a5,s0,-312
    5020240e:	86ba                	mv	a3,a4
    50202410:	10000713          	li	a4,256
    50202414:	863a                	mv	a2,a4
    50202416:	85b6                	mv	a1,a3
    50202418:	853e                	mv	a0,a5
    5020241a:	64f030ef          	jal	ra,50206268 <memcpy>
    5020241e:	fe042623          	sw	zero,-20(s0)
    50202422:	a061                	j	502024aa <handle_other+0xbc>
    50202424:	fe042423          	sw	zero,-24(s0)
    50202428:	a0a9                	j	50202472 <handle_other+0x84>
    5020242a:	fec42703          	lw	a4,-20(s0)
    5020242e:	fe842783          	lw	a5,-24(s0)
    50202432:	9fb9                	addw	a5,a5,a4
    50202434:	2781                	sext.w	a5,a5
    50202436:	078e                	slli	a5,a5,0x3
    50202438:	ff040713          	addi	a4,s0,-16
    5020243c:	97ba                	add	a5,a5,a4
    5020243e:	ed87b683          	ld	a3,-296(a5)
    50202442:	fec42703          	lw	a4,-20(s0)
    50202446:	fe842783          	lw	a5,-24(s0)
    5020244a:	9fb9                	addw	a5,a5,a4
    5020244c:	2781                	sext.w	a5,a5
    5020244e:	eb843703          	ld	a4,-328(s0)
    50202452:	078e                	slli	a5,a5,0x3
    50202454:	97ba                	add	a5,a5,a4
    50202456:	639c                	ld	a5,0(a5)
    50202458:	863e                	mv	a2,a5
    5020245a:	85b6                	mv	a1,a3
    5020245c:	00006517          	auipc	a0,0x6
    50202460:	6d450513          	addi	a0,a0,1748 # 50208b30 <waited_task+0x33a>
    50202464:	5ea030ef          	jal	ra,50205a4e <printk>
    50202468:	fe842783          	lw	a5,-24(s0)
    5020246c:	2785                	addiw	a5,a5,1
    5020246e:	fef42423          	sw	a5,-24(s0)
    50202472:	fe842783          	lw	a5,-24(s0)
    50202476:	0007871b          	sext.w	a4,a5
    5020247a:	4789                	li	a5,2
    5020247c:	00e7cc63          	blt	a5,a4,50202494 <handle_other+0xa6>
    50202480:	fec42703          	lw	a4,-20(s0)
    50202484:	fe842783          	lw	a5,-24(s0)
    50202488:	9fb9                	addw	a5,a5,a4
    5020248a:	2781                	sext.w	a5,a5
    5020248c:	873e                	mv	a4,a5
    5020248e:	47fd                	li	a5,31
    50202490:	f8e7dde3          	bge	a5,a4,5020242a <handle_other+0x3c>
    50202494:	00006517          	auipc	a0,0x6
    50202498:	6ac50513          	addi	a0,a0,1708 # 50208b40 <waited_task+0x34a>
    5020249c:	5b2030ef          	jal	ra,50205a4e <printk>
    502024a0:	fec42783          	lw	a5,-20(s0)
    502024a4:	278d                	addiw	a5,a5,3
    502024a6:	fef42623          	sw	a5,-20(s0)
    502024aa:	fec42783          	lw	a5,-20(s0)
    502024ae:	0007871b          	sext.w	a4,a5
    502024b2:	47fd                	li	a5,31
    502024b4:	f6e7d8e3          	bge	a5,a4,50202424 <handle_other+0x36>
    502024b8:	eb843783          	ld	a5,-328(s0)
    502024bc:	1007b703          	ld	a4,256(a5)
    502024c0:	eb843783          	ld	a5,-328(s0)
    502024c4:	1107b603          	ld	a2,272(a5)
    502024c8:	eb843783          	ld	a5,-328(s0)
    502024cc:	1187b783          	ld	a5,280(a5)
    502024d0:	86be                	mv	a3,a5
    502024d2:	85ba                	mv	a1,a4
    502024d4:	00006517          	auipc	a0,0x6
    502024d8:	67450513          	addi	a0,a0,1652 # 50208b48 <waited_task+0x352>
    502024dc:	572030ef          	jal	ra,50205a4e <printk>
    502024e0:	ea843603          	ld	a2,-344(s0)
    502024e4:	eb043583          	ld	a1,-336(s0)
    502024e8:	00006517          	auipc	a0,0x6
    502024ec:	69050513          	addi	a0,a0,1680 # 50208b78 <waited_task+0x382>
    502024f0:	55e030ef          	jal	ra,50205a4e <printk>
    502024f4:	eb843783          	ld	a5,-328(s0)
    502024f8:	1087b783          	ld	a5,264(a5)
    502024fc:	85be                	mv	a1,a5
    502024fe:	00006517          	auipc	a0,0x6
    50202502:	69a50513          	addi	a0,a0,1690 # 50208b98 <waited_task+0x3a2>
    50202506:	548030ef          	jal	ra,50205a4e <printk>
    5020250a:	eb843783          	ld	a5,-328(s0)
    5020250e:	63bc                	ld	a5,64(a5)
    50202510:	fef43023          	sd	a5,-32(s0)
    50202514:	eb843783          	ld	a5,-328(s0)
    50202518:	6b9c                	ld	a5,16(a5)
    5020251a:	fcf43c23          	sd	a5,-40(s0)
    5020251e:	00006517          	auipc	a0,0x6
    50202522:	68a50513          	addi	a0,a0,1674 # 50208ba8 <waited_task+0x3b2>
    50202526:	528030ef          	jal	ra,50205a4e <printk>
    5020252a:	eb843783          	ld	a5,-328(s0)
    5020252e:	679c                	ld	a5,8(a5)
    50202530:	17f1                	addi	a5,a5,-4
    50202532:	fe043683          	ld	a3,-32(s0)
    50202536:	fd843603          	ld	a2,-40(s0)
    5020253a:	85be                	mv	a1,a5
    5020253c:	00006517          	auipc	a0,0x6
    50202540:	67c50513          	addi	a0,a0,1660 # 50208bb8 <waited_task+0x3c2>
    50202544:	50a030ef          	jal	ra,50205a4e <printk>
    50202548:	a83d                	j	50202586 <handle_other+0x198>
    5020254a:	fe043783          	ld	a5,-32(s0)
    5020254e:	17e1                	addi	a5,a5,-8
    50202550:	639c                	ld	a5,0(a5)
    50202552:	fcf43823          	sd	a5,-48(s0)
    50202556:	fe043783          	ld	a5,-32(s0)
    5020255a:	17c1                	addi	a5,a5,-16
    5020255c:	639c                	ld	a5,0(a5)
    5020255e:	fcf43423          	sd	a5,-56(s0)
    50202562:	fd043783          	ld	a5,-48(s0)
    50202566:	17f1                	addi	a5,a5,-4
    50202568:	fc843683          	ld	a3,-56(s0)
    5020256c:	fe043603          	ld	a2,-32(s0)
    50202570:	85be                	mv	a1,a5
    50202572:	00006517          	auipc	a0,0x6
    50202576:	64650513          	addi	a0,a0,1606 # 50208bb8 <waited_task+0x3c2>
    5020257a:	4d4030ef          	jal	ra,50205a4e <printk>
    5020257e:	fc843783          	ld	a5,-56(s0)
    50202582:	fef43023          	sd	a5,-32(s0)
    50202586:	fe043703          	ld	a4,-32(s0)
    5020258a:	67c1                	lui	a5,0x10
    5020258c:	fae7efe3          	bltu	a5,a4,5020254a <handle_other+0x15c>
    50202590:	00006617          	auipc	a2,0x6
    50202594:	76060613          	addi	a2,a2,1888 # 50208cf0 <__FUNCTION__.1403>
    50202598:	09400593          	li	a1,148
    5020259c:	00006517          	auipc	a0,0x6
    502025a0:	63c50513          	addi	a0,a0,1596 # 50208bd8 <waited_task+0x3e2>
    502025a4:	b31ff0ef          	jal	ra,502020d4 <_panic>
    502025a8:	0001                	nop
    502025aa:	60f6                	ld	ra,344(sp)
    502025ac:	6456                	ld	s0,336(sp)
    502025ae:	6135                	addi	sp,sp,352
    502025b0:	8082                	ret

00000000502025b2 <vt100_move_cursor>:
    502025b2:	7179                	addi	sp,sp,-48
    502025b4:	f406                	sd	ra,40(sp)
    502025b6:	f022                	sd	s0,32(sp)
    502025b8:	1800                	addi	s0,sp,48
    502025ba:	87aa                	mv	a5,a0
    502025bc:	872e                	mv	a4,a1
    502025be:	fcf42e23          	sw	a5,-36(s0)
    502025c2:	87ba                	mv	a5,a4
    502025c4:	fcf42c23          	sw	a5,-40(s0)
    502025c8:	c81fe0ef          	jal	ra,50201248 <get_current_cpu_id>
    502025cc:	87aa                	mv	a5,a0
    502025ce:	fef42623          	sw	a5,-20(s0)
    502025d2:	fdc42703          	lw	a4,-36(s0)
    502025d6:	fd842783          	lw	a5,-40(s0)
    502025da:	86ba                	mv	a3,a4
    502025dc:	863e                	mv	a2,a5
    502025de:	45ed                	li	a1,27
    502025e0:	00006517          	auipc	a0,0x6
    502025e4:	72050513          	addi	a0,a0,1824 # 50208d00 <__FUNCTION__.1403+0x10>
    502025e8:	466030ef          	jal	ra,50205a4e <printk>
    502025ec:	0000a717          	auipc	a4,0xa
    502025f0:	90470713          	addi	a4,a4,-1788 # 5020bef0 <current_running>
    502025f4:	fec42783          	lw	a5,-20(s0)
    502025f8:	078e                	slli	a5,a5,0x3
    502025fa:	97ba                	add	a5,a5,a4
    502025fc:	639c                	ld	a5,0(a5)
    502025fe:	fdc42703          	lw	a4,-36(s0)
    50202602:	08e7a423          	sw	a4,136(a5) # 10088 <_start-0x501f0f78>
    50202606:	0000a717          	auipc	a4,0xa
    5020260a:	8ea70713          	addi	a4,a4,-1814 # 5020bef0 <current_running>
    5020260e:	fec42783          	lw	a5,-20(s0)
    50202612:	078e                	slli	a5,a5,0x3
    50202614:	97ba                	add	a5,a5,a4
    50202616:	639c                	ld	a5,0(a5)
    50202618:	fd842703          	lw	a4,-40(s0)
    5020261c:	08e7a623          	sw	a4,140(a5)
    50202620:	0001                	nop
    50202622:	70a2                	ld	ra,40(sp)
    50202624:	7402                	ld	s0,32(sp)
    50202626:	6145                	addi	sp,sp,48
    50202628:	8082                	ret

000000005020262a <vt100_clear>:
    5020262a:	1141                	addi	sp,sp,-16
    5020262c:	e406                	sd	ra,8(sp)
    5020262e:	e022                	sd	s0,0(sp)
    50202630:	0800                	addi	s0,sp,16
    50202632:	45ed                	li	a1,27
    50202634:	00006517          	auipc	a0,0x6
    50202638:	6dc50513          	addi	a0,a0,1756 # 50208d10 <__FUNCTION__.1403+0x20>
    5020263c:	412030ef          	jal	ra,50205a4e <printk>
    50202640:	0001                	nop
    50202642:	60a2                	ld	ra,8(sp)
    50202644:	6402                	ld	s0,0(sp)
    50202646:	0141                	addi	sp,sp,16
    50202648:	8082                	ret

000000005020264a <vt100_hidden_cursor>:
    5020264a:	1141                	addi	sp,sp,-16
    5020264c:	e406                	sd	ra,8(sp)
    5020264e:	e022                	sd	s0,0(sp)
    50202650:	0800                	addi	s0,sp,16
    50202652:	45ed                	li	a1,27
    50202654:	00006517          	auipc	a0,0x6
    50202658:	6c450513          	addi	a0,a0,1732 # 50208d18 <__FUNCTION__.1403+0x28>
    5020265c:	3f2030ef          	jal	ra,50205a4e <printk>
    50202660:	0001                	nop
    50202662:	60a2                	ld	ra,8(sp)
    50202664:	6402                	ld	s0,0(sp)
    50202666:	0141                	addi	sp,sp,16
    50202668:	8082                	ret

000000005020266a <screen_write_ch>:
    5020266a:	7179                	addi	sp,sp,-48
    5020266c:	f406                	sd	ra,40(sp)
    5020266e:	f022                	sd	s0,32(sp)
    50202670:	1800                	addi	s0,sp,48
    50202672:	87aa                	mv	a5,a0
    50202674:	fcf40fa3          	sb	a5,-33(s0)
    50202678:	bd1fe0ef          	jal	ra,50201248 <get_current_cpu_id>
    5020267c:	87aa                	mv	a5,a0
    5020267e:	fef42623          	sw	a5,-20(s0)
    50202682:	fdf44783          	lbu	a5,-33(s0)
    50202686:	0ff7f713          	andi	a4,a5,255
    5020268a:	47a9                	li	a5,10
    5020268c:	00f70963          	beq	a4,a5,5020269e <screen_write_ch+0x34>
    50202690:	fdf44783          	lbu	a5,-33(s0)
    50202694:	0ff7f713          	andi	a4,a5,255
    50202698:	47b5                	li	a5,13
    5020269a:	04f71263          	bne	a4,a5,502026de <screen_write_ch+0x74>
    5020269e:	0000a717          	auipc	a4,0xa
    502026a2:	82a70713          	addi	a4,a4,-2006 # 5020bec8 <screen_cursor_x>
    502026a6:	fec42783          	lw	a5,-20(s0)
    502026aa:	078a                	slli	a5,a5,0x2
    502026ac:	97ba                	add	a5,a5,a4
    502026ae:	0007a023          	sw	zero,0(a5)
    502026b2:	0000a717          	auipc	a4,0xa
    502026b6:	81e70713          	addi	a4,a4,-2018 # 5020bed0 <screen_cursor_y>
    502026ba:	fec42783          	lw	a5,-20(s0)
    502026be:	078a                	slli	a5,a5,0x2
    502026c0:	97ba                	add	a5,a5,a4
    502026c2:	439c                	lw	a5,0(a5)
    502026c4:	2785                	addiw	a5,a5,1
    502026c6:	0007871b          	sext.w	a4,a5
    502026ca:	0000a697          	auipc	a3,0xa
    502026ce:	80668693          	addi	a3,a3,-2042 # 5020bed0 <screen_cursor_y>
    502026d2:	fec42783          	lw	a5,-20(s0)
    502026d6:	078a                	slli	a5,a5,0x2
    502026d8:	97b6                	add	a5,a5,a3
    502026da:	c398                	sw	a4,0(a5)
    502026dc:	a239                	j	502027ea <screen_write_ch+0x180>
    502026de:	fdf44783          	lbu	a5,-33(s0)
    502026e2:	0ff7f713          	andi	a4,a5,255
    502026e6:	47a1                	li	a5,8
    502026e8:	00f70a63          	beq	a4,a5,502026fc <screen_write_ch+0x92>
    502026ec:	fdf44783          	lbu	a5,-33(s0)
    502026f0:	0ff7f713          	andi	a4,a5,255
    502026f4:	07f00793          	li	a5,127
    502026f8:	06f71e63          	bne	a4,a5,50202774 <screen_write_ch+0x10a>
    502026fc:	00009717          	auipc	a4,0x9
    50202700:	7cc70713          	addi	a4,a4,1996 # 5020bec8 <screen_cursor_x>
    50202704:	fec42783          	lw	a5,-20(s0)
    50202708:	078a                	slli	a5,a5,0x2
    5020270a:	97ba                	add	a5,a5,a4
    5020270c:	439c                	lw	a5,0(a5)
    5020270e:	37fd                	addiw	a5,a5,-1
    50202710:	0007871b          	sext.w	a4,a5
    50202714:	00009697          	auipc	a3,0x9
    50202718:	7b468693          	addi	a3,a3,1972 # 5020bec8 <screen_cursor_x>
    5020271c:	fec42783          	lw	a5,-20(s0)
    50202720:	078a                	slli	a5,a5,0x2
    50202722:	97b6                	add	a5,a5,a3
    50202724:	c398                	sw	a4,0(a5)
    50202726:	00009717          	auipc	a4,0x9
    5020272a:	7aa70713          	addi	a4,a4,1962 # 5020bed0 <screen_cursor_y>
    5020272e:	fec42783          	lw	a5,-20(s0)
    50202732:	078a                	slli	a5,a5,0x2
    50202734:	97ba                	add	a5,a5,a4
    50202736:	439c                	lw	a5,0(a5)
    50202738:	873e                	mv	a4,a5
    5020273a:	87ba                	mv	a5,a4
    5020273c:	0027979b          	slliw	a5,a5,0x2
    50202740:	9fb9                	addw	a5,a5,a4
    50202742:	0047979b          	slliw	a5,a5,0x4
    50202746:	0007871b          	sext.w	a4,a5
    5020274a:	00009697          	auipc	a3,0x9
    5020274e:	77e68693          	addi	a3,a3,1918 # 5020bec8 <screen_cursor_x>
    50202752:	fec42783          	lw	a5,-20(s0)
    50202756:	078a                	slli	a5,a5,0x2
    50202758:	97b6                	add	a5,a5,a3
    5020275a:	439c                	lw	a5,0(a5)
    5020275c:	9fb9                	addw	a5,a5,a4
    5020275e:	2781                	sext.w	a5,a5
    50202760:	00007717          	auipc	a4,0x7
    50202764:	f7870713          	addi	a4,a4,-136 # 502096d8 <new_screen>
    50202768:	97ba                	add	a5,a5,a4
    5020276a:	02000713          	li	a4,32
    5020276e:	00e78023          	sb	a4,0(a5)
    50202772:	a8a5                	j	502027ea <screen_write_ch+0x180>
    50202774:	00009717          	auipc	a4,0x9
    50202778:	75c70713          	addi	a4,a4,1884 # 5020bed0 <screen_cursor_y>
    5020277c:	fec42783          	lw	a5,-20(s0)
    50202780:	078a                	slli	a5,a5,0x2
    50202782:	97ba                	add	a5,a5,a4
    50202784:	439c                	lw	a5,0(a5)
    50202786:	873e                	mv	a4,a5
    50202788:	87ba                	mv	a5,a4
    5020278a:	0027979b          	slliw	a5,a5,0x2
    5020278e:	9fb9                	addw	a5,a5,a4
    50202790:	0047979b          	slliw	a5,a5,0x4
    50202794:	0007871b          	sext.w	a4,a5
    50202798:	00009697          	auipc	a3,0x9
    5020279c:	73068693          	addi	a3,a3,1840 # 5020bec8 <screen_cursor_x>
    502027a0:	fec42783          	lw	a5,-20(s0)
    502027a4:	078a                	slli	a5,a5,0x2
    502027a6:	97b6                	add	a5,a5,a3
    502027a8:	439c                	lw	a5,0(a5)
    502027aa:	9fb9                	addw	a5,a5,a4
    502027ac:	2781                	sext.w	a5,a5
    502027ae:	00007717          	auipc	a4,0x7
    502027b2:	f2a70713          	addi	a4,a4,-214 # 502096d8 <new_screen>
    502027b6:	97ba                	add	a5,a5,a4
    502027b8:	fdf44703          	lbu	a4,-33(s0)
    502027bc:	00e78023          	sb	a4,0(a5)
    502027c0:	00009717          	auipc	a4,0x9
    502027c4:	70870713          	addi	a4,a4,1800 # 5020bec8 <screen_cursor_x>
    502027c8:	fec42783          	lw	a5,-20(s0)
    502027cc:	078a                	slli	a5,a5,0x2
    502027ce:	97ba                	add	a5,a5,a4
    502027d0:	439c                	lw	a5,0(a5)
    502027d2:	2785                	addiw	a5,a5,1
    502027d4:	0007871b          	sext.w	a4,a5
    502027d8:	00009697          	auipc	a3,0x9
    502027dc:	6f068693          	addi	a3,a3,1776 # 5020bec8 <screen_cursor_x>
    502027e0:	fec42783          	lw	a5,-20(s0)
    502027e4:	078a                	slli	a5,a5,0x2
    502027e6:	97b6                	add	a5,a5,a3
    502027e8:	c398                	sw	a4,0(a5)
    502027ea:	00009717          	auipc	a4,0x9
    502027ee:	6de70713          	addi	a4,a4,1758 # 5020bec8 <screen_cursor_x>
    502027f2:	fec42783          	lw	a5,-20(s0)
    502027f6:	078a                	slli	a5,a5,0x2
    502027f8:	97ba                	add	a5,a5,a4
    502027fa:	439c                	lw	a5,0(a5)
    502027fc:	0207d663          	bgez	a5,50202828 <screen_write_ch+0x1be>
    50202800:	00009717          	auipc	a4,0x9
    50202804:	6c870713          	addi	a4,a4,1736 # 5020bec8 <screen_cursor_x>
    50202808:	fec42783          	lw	a5,-20(s0)
    5020280c:	078a                	slli	a5,a5,0x2
    5020280e:	97ba                	add	a5,a5,a4
    50202810:	0007a023          	sw	zero,0(a5)
    50202814:	00009717          	auipc	a4,0x9
    50202818:	6bc70713          	addi	a4,a4,1724 # 5020bed0 <screen_cursor_y>
    5020281c:	fec42783          	lw	a5,-20(s0)
    50202820:	078a                	slli	a5,a5,0x2
    50202822:	97ba                	add	a5,a5,a4
    50202824:	0007a023          	sw	zero,0(a5)
    50202828:	00009717          	auipc	a4,0x9
    5020282c:	6a070713          	addi	a4,a4,1696 # 5020bec8 <screen_cursor_x>
    50202830:	fec42783          	lw	a5,-20(s0)
    50202834:	078a                	slli	a5,a5,0x2
    50202836:	97ba                	add	a5,a5,a4
    50202838:	439c                	lw	a5,0(a5)
    5020283a:	873e                	mv	a4,a5
    5020283c:	04f00793          	li	a5,79
    50202840:	04e7d163          	bge	a5,a4,50202882 <screen_write_ch+0x218>
    50202844:	00009717          	auipc	a4,0x9
    50202848:	68c70713          	addi	a4,a4,1676 # 5020bed0 <screen_cursor_y>
    5020284c:	fec42783          	lw	a5,-20(s0)
    50202850:	078a                	slli	a5,a5,0x2
    50202852:	97ba                	add	a5,a5,a4
    50202854:	439c                	lw	a5,0(a5)
    50202856:	2785                	addiw	a5,a5,1
    50202858:	0007871b          	sext.w	a4,a5
    5020285c:	00009697          	auipc	a3,0x9
    50202860:	67468693          	addi	a3,a3,1652 # 5020bed0 <screen_cursor_y>
    50202864:	fec42783          	lw	a5,-20(s0)
    50202868:	078a                	slli	a5,a5,0x2
    5020286a:	97b6                	add	a5,a5,a3
    5020286c:	c398                	sw	a4,0(a5)
    5020286e:	00009717          	auipc	a4,0x9
    50202872:	65a70713          	addi	a4,a4,1626 # 5020bec8 <screen_cursor_x>
    50202876:	fec42783          	lw	a5,-20(s0)
    5020287a:	078a                	slli	a5,a5,0x2
    5020287c:	97ba                	add	a5,a5,a4
    5020287e:	0007a023          	sw	zero,0(a5)
    50202882:	00009717          	auipc	a4,0x9
    50202886:	64e70713          	addi	a4,a4,1614 # 5020bed0 <screen_cursor_y>
    5020288a:	fec42783          	lw	a5,-20(s0)
    5020288e:	078a                	slli	a5,a5,0x2
    50202890:	97ba                	add	a5,a5,a4
    50202892:	439c                	lw	a5,0(a5)
    50202894:	0207d663          	bgez	a5,502028c0 <screen_write_ch+0x256>
    50202898:	00009717          	auipc	a4,0x9
    5020289c:	63870713          	addi	a4,a4,1592 # 5020bed0 <screen_cursor_y>
    502028a0:	fec42783          	lw	a5,-20(s0)
    502028a4:	078a                	slli	a5,a5,0x2
    502028a6:	97ba                	add	a5,a5,a4
    502028a8:	0007a023          	sw	zero,0(a5)
    502028ac:	00009717          	auipc	a4,0x9
    502028b0:	61c70713          	addi	a4,a4,1564 # 5020bec8 <screen_cursor_x>
    502028b4:	fec42783          	lw	a5,-20(s0)
    502028b8:	078a                	slli	a5,a5,0x2
    502028ba:	97ba                	add	a5,a5,a4
    502028bc:	0007a023          	sw	zero,0(a5)
    502028c0:	00009717          	auipc	a4,0x9
    502028c4:	61070713          	addi	a4,a4,1552 # 5020bed0 <screen_cursor_y>
    502028c8:	fec42783          	lw	a5,-20(s0)
    502028cc:	078a                	slli	a5,a5,0x2
    502028ce:	97ba                	add	a5,a5,a4
    502028d0:	439c                	lw	a5,0(a5)
    502028d2:	873e                	mv	a4,a5
    502028d4:	03100793          	li	a5,49
    502028d8:	02e7d663          	bge	a5,a4,50202904 <screen_write_ch+0x29a>
    502028dc:	00009717          	auipc	a4,0x9
    502028e0:	5f470713          	addi	a4,a4,1524 # 5020bed0 <screen_cursor_y>
    502028e4:	fec42783          	lw	a5,-20(s0)
    502028e8:	078a                	slli	a5,a5,0x2
    502028ea:	97ba                	add	a5,a5,a4
    502028ec:	0007a023          	sw	zero,0(a5)
    502028f0:	00009717          	auipc	a4,0x9
    502028f4:	5d870713          	addi	a4,a4,1496 # 5020bec8 <screen_cursor_x>
    502028f8:	fec42783          	lw	a5,-20(s0)
    502028fc:	078a                	slli	a5,a5,0x2
    502028fe:	97ba                	add	a5,a5,a4
    50202900:	0007a023          	sw	zero,0(a5)
    50202904:	00009717          	auipc	a4,0x9
    50202908:	5ec70713          	addi	a4,a4,1516 # 5020bef0 <current_running>
    5020290c:	fec42783          	lw	a5,-20(s0)
    50202910:	078e                	slli	a5,a5,0x3
    50202912:	97ba                	add	a5,a5,a4
    50202914:	639c                	ld	a5,0(a5)
    50202916:	00009697          	auipc	a3,0x9
    5020291a:	5b268693          	addi	a3,a3,1458 # 5020bec8 <screen_cursor_x>
    5020291e:	fec42703          	lw	a4,-20(s0)
    50202922:	070a                	slli	a4,a4,0x2
    50202924:	9736                	add	a4,a4,a3
    50202926:	4318                	lw	a4,0(a4)
    50202928:	08e7a423          	sw	a4,136(a5)
    5020292c:	00009717          	auipc	a4,0x9
    50202930:	5c470713          	addi	a4,a4,1476 # 5020bef0 <current_running>
    50202934:	fec42783          	lw	a5,-20(s0)
    50202938:	078e                	slli	a5,a5,0x3
    5020293a:	97ba                	add	a5,a5,a4
    5020293c:	639c                	ld	a5,0(a5)
    5020293e:	00009697          	auipc	a3,0x9
    50202942:	59268693          	addi	a3,a3,1426 # 5020bed0 <screen_cursor_y>
    50202946:	fec42703          	lw	a4,-20(s0)
    5020294a:	070a                	slli	a4,a4,0x2
    5020294c:	9736                	add	a4,a4,a3
    5020294e:	4318                	lw	a4,0(a4)
    50202950:	08e7a623          	sw	a4,140(a5)
    50202954:	0001                	nop
    50202956:	70a2                	ld	ra,40(sp)
    50202958:	7402                	ld	s0,32(sp)
    5020295a:	6145                	addi	sp,sp,48
    5020295c:	8082                	ret

000000005020295e <init_screen>:
    5020295e:	1141                	addi	sp,sp,-16
    50202960:	e406                	sd	ra,8(sp)
    50202962:	e022                	sd	s0,0(sp)
    50202964:	0800                	addi	s0,sp,16
    50202966:	cc5ff0ef          	jal	ra,5020262a <vt100_clear>
    5020296a:	0001                	nop
    5020296c:	60a2                	ld	ra,8(sp)
    5020296e:	6402                	ld	s0,0(sp)
    50202970:	0141                	addi	sp,sp,16
    50202972:	8082                	ret

0000000050202974 <screen_clear>:
    50202974:	1101                	addi	sp,sp,-32
    50202976:	ec06                	sd	ra,24(sp)
    50202978:	e822                	sd	s0,16(sp)
    5020297a:	1000                	addi	s0,sp,32
    5020297c:	8cdfe0ef          	jal	ra,50201248 <get_current_cpu_id>
    50202980:	87aa                	mv	a5,a0
    50202982:	fef42223          	sw	a5,-28(s0)
    50202986:	fe042623          	sw	zero,-20(s0)
    5020298a:	a041                	j	50202a0a <screen_clear+0x96>
    5020298c:	fe042423          	sw	zero,-24(s0)
    50202990:	a085                	j	502029f0 <screen_clear+0x7c>
    50202992:	fec42703          	lw	a4,-20(s0)
    50202996:	87ba                	mv	a5,a4
    50202998:	0027979b          	slliw	a5,a5,0x2
    5020299c:	9fb9                	addw	a5,a5,a4
    5020299e:	0047979b          	slliw	a5,a5,0x4
    502029a2:	2781                	sext.w	a5,a5
    502029a4:	fe842703          	lw	a4,-24(s0)
    502029a8:	9fb9                	addw	a5,a5,a4
    502029aa:	2781                	sext.w	a5,a5
    502029ac:	00007717          	auipc	a4,0x7
    502029b0:	d2c70713          	addi	a4,a4,-724 # 502096d8 <new_screen>
    502029b4:	97ba                	add	a5,a5,a4
    502029b6:	02000713          	li	a4,32
    502029ba:	00e78023          	sb	a4,0(a5)
    502029be:	fec42703          	lw	a4,-20(s0)
    502029c2:	87ba                	mv	a5,a4
    502029c4:	0027979b          	slliw	a5,a5,0x2
    502029c8:	9fb9                	addw	a5,a5,a4
    502029ca:	0047979b          	slliw	a5,a5,0x4
    502029ce:	2781                	sext.w	a5,a5
    502029d0:	fe842703          	lw	a4,-24(s0)
    502029d4:	9fb9                	addw	a5,a5,a4
    502029d6:	2781                	sext.w	a5,a5
    502029d8:	00008717          	auipc	a4,0x8
    502029dc:	ca070713          	addi	a4,a4,-864 # 5020a678 <old_screen>
    502029e0:	97ba                	add	a5,a5,a4
    502029e2:	00078023          	sb	zero,0(a5)
    502029e6:	fe842783          	lw	a5,-24(s0)
    502029ea:	2785                	addiw	a5,a5,1
    502029ec:	fef42423          	sw	a5,-24(s0)
    502029f0:	fe842783          	lw	a5,-24(s0)
    502029f4:	0007871b          	sext.w	a4,a5
    502029f8:	04f00793          	li	a5,79
    502029fc:	f8e7dbe3          	bge	a5,a4,50202992 <screen_clear+0x1e>
    50202a00:	fec42783          	lw	a5,-20(s0)
    50202a04:	2785                	addiw	a5,a5,1
    50202a06:	fef42623          	sw	a5,-20(s0)
    50202a0a:	fec42783          	lw	a5,-20(s0)
    50202a0e:	0007871b          	sext.w	a4,a5
    50202a12:	03100793          	li	a5,49
    50202a16:	f6e7dbe3          	bge	a5,a4,5020298c <screen_clear+0x18>
    50202a1a:	00009717          	auipc	a4,0x9
    50202a1e:	4ae70713          	addi	a4,a4,1198 # 5020bec8 <screen_cursor_x>
    50202a22:	fe442783          	lw	a5,-28(s0)
    50202a26:	078a                	slli	a5,a5,0x2
    50202a28:	97ba                	add	a5,a5,a4
    50202a2a:	0007a023          	sw	zero,0(a5)
    50202a2e:	00009717          	auipc	a4,0x9
    50202a32:	4a270713          	addi	a4,a4,1186 # 5020bed0 <screen_cursor_y>
    50202a36:	fe442783          	lw	a5,-28(s0)
    50202a3a:	078a                	slli	a5,a5,0x2
    50202a3c:	97ba                	add	a5,a5,a4
    50202a3e:	0007a023          	sw	zero,0(a5)
    50202a42:	166000ef          	jal	ra,50202ba8 <screen_reflush>
    50202a46:	0001                	nop
    50202a48:	60e2                	ld	ra,24(sp)
    50202a4a:	6442                	ld	s0,16(sp)
    50202a4c:	6105                	addi	sp,sp,32
    50202a4e:	8082                	ret

0000000050202a50 <screen_move_cursor>:
    50202a50:	7179                	addi	sp,sp,-48
    50202a52:	f406                	sd	ra,40(sp)
    50202a54:	f022                	sd	s0,32(sp)
    50202a56:	1800                	addi	s0,sp,48
    50202a58:	87aa                	mv	a5,a0
    50202a5a:	872e                	mv	a4,a1
    50202a5c:	fcf42e23          	sw	a5,-36(s0)
    50202a60:	87ba                	mv	a5,a4
    50202a62:	fcf42c23          	sw	a5,-40(s0)
    50202a66:	fe2fe0ef          	jal	ra,50201248 <get_current_cpu_id>
    50202a6a:	87aa                	mv	a5,a0
    50202a6c:	fef42623          	sw	a5,-20(s0)
    50202a70:	00009717          	auipc	a4,0x9
    50202a74:	45870713          	addi	a4,a4,1112 # 5020bec8 <screen_cursor_x>
    50202a78:	fec42783          	lw	a5,-20(s0)
    50202a7c:	078a                	slli	a5,a5,0x2
    50202a7e:	97ba                	add	a5,a5,a4
    50202a80:	fdc42703          	lw	a4,-36(s0)
    50202a84:	c398                	sw	a4,0(a5)
    50202a86:	00009717          	auipc	a4,0x9
    50202a8a:	44a70713          	addi	a4,a4,1098 # 5020bed0 <screen_cursor_y>
    50202a8e:	fec42783          	lw	a5,-20(s0)
    50202a92:	078a                	slli	a5,a5,0x2
    50202a94:	97ba                	add	a5,a5,a4
    50202a96:	fd842703          	lw	a4,-40(s0)
    50202a9a:	c398                	sw	a4,0(a5)
    50202a9c:	00009717          	auipc	a4,0x9
    50202aa0:	45470713          	addi	a4,a4,1108 # 5020bef0 <current_running>
    50202aa4:	fec42783          	lw	a5,-20(s0)
    50202aa8:	078e                	slli	a5,a5,0x3
    50202aaa:	97ba                	add	a5,a5,a4
    50202aac:	639c                	ld	a5,0(a5)
    50202aae:	00009697          	auipc	a3,0x9
    50202ab2:	41a68693          	addi	a3,a3,1050 # 5020bec8 <screen_cursor_x>
    50202ab6:	fec42703          	lw	a4,-20(s0)
    50202aba:	070a                	slli	a4,a4,0x2
    50202abc:	9736                	add	a4,a4,a3
    50202abe:	4318                	lw	a4,0(a4)
    50202ac0:	08e7a423          	sw	a4,136(a5)
    50202ac4:	00009717          	auipc	a4,0x9
    50202ac8:	42c70713          	addi	a4,a4,1068 # 5020bef0 <current_running>
    50202acc:	fec42783          	lw	a5,-20(s0)
    50202ad0:	078e                	slli	a5,a5,0x3
    50202ad2:	97ba                	add	a5,a5,a4
    50202ad4:	639c                	ld	a5,0(a5)
    50202ad6:	00009697          	auipc	a3,0x9
    50202ada:	3fa68693          	addi	a3,a3,1018 # 5020bed0 <screen_cursor_y>
    50202ade:	fec42703          	lw	a4,-20(s0)
    50202ae2:	070a                	slli	a4,a4,0x2
    50202ae4:	9736                	add	a4,a4,a3
    50202ae6:	4318                	lw	a4,0(a4)
    50202ae8:	08e7a623          	sw	a4,140(a5)
    50202aec:	0001                	nop
    50202aee:	70a2                	ld	ra,40(sp)
    50202af0:	7402                	ld	s0,32(sp)
    50202af2:	6145                	addi	sp,sp,48
    50202af4:	8082                	ret

0000000050202af6 <screen_get_cursor>:
    50202af6:	7179                	addi	sp,sp,-48
    50202af8:	f406                	sd	ra,40(sp)
    50202afa:	f022                	sd	s0,32(sp)
    50202afc:	1800                	addi	s0,sp,48
    50202afe:	fca43c23          	sd	a0,-40(s0)
    50202b02:	fcb43823          	sd	a1,-48(s0)
    50202b06:	f42fe0ef          	jal	ra,50201248 <get_current_cpu_id>
    50202b0a:	87aa                	mv	a5,a0
    50202b0c:	fef42623          	sw	a5,-20(s0)
    50202b10:	00009717          	auipc	a4,0x9
    50202b14:	3b870713          	addi	a4,a4,952 # 5020bec8 <screen_cursor_x>
    50202b18:	fec42783          	lw	a5,-20(s0)
    50202b1c:	078a                	slli	a5,a5,0x2
    50202b1e:	97ba                	add	a5,a5,a4
    50202b20:	4398                	lw	a4,0(a5)
    50202b22:	fd843783          	ld	a5,-40(s0)
    50202b26:	c398                	sw	a4,0(a5)
    50202b28:	00009717          	auipc	a4,0x9
    50202b2c:	3a870713          	addi	a4,a4,936 # 5020bed0 <screen_cursor_y>
    50202b30:	fec42783          	lw	a5,-20(s0)
    50202b34:	078a                	slli	a5,a5,0x2
    50202b36:	97ba                	add	a5,a5,a4
    50202b38:	4398                	lw	a4,0(a5)
    50202b3a:	fd043783          	ld	a5,-48(s0)
    50202b3e:	c398                	sw	a4,0(a5)
    50202b40:	0001                	nop
    50202b42:	70a2                	ld	ra,40(sp)
    50202b44:	7402                	ld	s0,32(sp)
    50202b46:	6145                	addi	sp,sp,48
    50202b48:	8082                	ret

0000000050202b4a <screen_write>:
    50202b4a:	7179                	addi	sp,sp,-48
    50202b4c:	f406                	sd	ra,40(sp)
    50202b4e:	f022                	sd	s0,32(sp)
    50202b50:	1800                	addi	s0,sp,48
    50202b52:	fca43c23          	sd	a0,-40(s0)
    50202b56:	fe042623          	sw	zero,-20(s0)
    50202b5a:	fd843503          	ld	a0,-40(s0)
    50202b5e:	54c020ef          	jal	ra,502050aa <kstrlen>
    50202b62:	87aa                	mv	a5,a0
    50202b64:	fef42423          	sw	a5,-24(s0)
    50202b68:	fe042623          	sw	zero,-20(s0)
    50202b6c:	a005                	j	50202b8c <screen_write+0x42>
    50202b6e:	fec42783          	lw	a5,-20(s0)
    50202b72:	fd843703          	ld	a4,-40(s0)
    50202b76:	97ba                	add	a5,a5,a4
    50202b78:	0007c783          	lbu	a5,0(a5)
    50202b7c:	853e                	mv	a0,a5
    50202b7e:	aedff0ef          	jal	ra,5020266a <screen_write_ch>
    50202b82:	fec42783          	lw	a5,-20(s0)
    50202b86:	2785                	addiw	a5,a5,1
    50202b88:	fef42623          	sw	a5,-20(s0)
    50202b8c:	fec42703          	lw	a4,-20(s0)
    50202b90:	fe842783          	lw	a5,-24(s0)
    50202b94:	2701                	sext.w	a4,a4
    50202b96:	2781                	sext.w	a5,a5
    50202b98:	fcf74be3          	blt	a4,a5,50202b6e <screen_write+0x24>
    50202b9c:	0001                	nop
    50202b9e:	0001                	nop
    50202ba0:	70a2                	ld	ra,40(sp)
    50202ba2:	7402                	ld	s0,32(sp)
    50202ba4:	6145                	addi	sp,sp,48
    50202ba6:	8082                	ret

0000000050202ba8 <screen_reflush>:
    50202ba8:	1101                	addi	sp,sp,-32
    50202baa:	ec06                	sd	ra,24(sp)
    50202bac:	e822                	sd	s0,16(sp)
    50202bae:	1000                	addi	s0,sp,32
    50202bb0:	e98fe0ef          	jal	ra,50201248 <get_current_cpu_id>
    50202bb4:	87aa                	mv	a5,a0
    50202bb6:	fef42223          	sw	a5,-28(s0)
    50202bba:	fe042623          	sw	zero,-20(s0)
    50202bbe:	aa31                	j	50202cda <screen_reflush+0x132>
    50202bc0:	fe042423          	sw	zero,-24(s0)
    50202bc4:	a8f5                	j	50202cc0 <screen_reflush+0x118>
    50202bc6:	fec42703          	lw	a4,-20(s0)
    50202bca:	87ba                	mv	a5,a4
    50202bcc:	0027979b          	slliw	a5,a5,0x2
    50202bd0:	9fb9                	addw	a5,a5,a4
    50202bd2:	0047979b          	slliw	a5,a5,0x4
    50202bd6:	2781                	sext.w	a5,a5
    50202bd8:	fe842703          	lw	a4,-24(s0)
    50202bdc:	9fb9                	addw	a5,a5,a4
    50202bde:	2781                	sext.w	a5,a5
    50202be0:	00007717          	auipc	a4,0x7
    50202be4:	af870713          	addi	a4,a4,-1288 # 502096d8 <new_screen>
    50202be8:	97ba                	add	a5,a5,a4
    50202bea:	0007c683          	lbu	a3,0(a5)
    50202bee:	fec42703          	lw	a4,-20(s0)
    50202bf2:	87ba                	mv	a5,a4
    50202bf4:	0027979b          	slliw	a5,a5,0x2
    50202bf8:	9fb9                	addw	a5,a5,a4
    50202bfa:	0047979b          	slliw	a5,a5,0x4
    50202bfe:	2781                	sext.w	a5,a5
    50202c00:	fe842703          	lw	a4,-24(s0)
    50202c04:	9fb9                	addw	a5,a5,a4
    50202c06:	2781                	sext.w	a5,a5
    50202c08:	00008717          	auipc	a4,0x8
    50202c0c:	a7070713          	addi	a4,a4,-1424 # 5020a678 <old_screen>
    50202c10:	97ba                	add	a5,a5,a4
    50202c12:	0007c783          	lbu	a5,0(a5)
    50202c16:	8736                	mv	a4,a3
    50202c18:	08f70f63          	beq	a4,a5,50202cb6 <screen_reflush+0x10e>
    50202c1c:	fe842783          	lw	a5,-24(s0)
    50202c20:	2785                	addiw	a5,a5,1
    50202c22:	0007871b          	sext.w	a4,a5
    50202c26:	fec42783          	lw	a5,-20(s0)
    50202c2a:	2785                	addiw	a5,a5,1
    50202c2c:	2781                	sext.w	a5,a5
    50202c2e:	85be                	mv	a1,a5
    50202c30:	853a                	mv	a0,a4
    50202c32:	981ff0ef          	jal	ra,502025b2 <vt100_move_cursor>
    50202c36:	fec42703          	lw	a4,-20(s0)
    50202c3a:	87ba                	mv	a5,a4
    50202c3c:	0027979b          	slliw	a5,a5,0x2
    50202c40:	9fb9                	addw	a5,a5,a4
    50202c42:	0047979b          	slliw	a5,a5,0x4
    50202c46:	2781                	sext.w	a5,a5
    50202c48:	fe842703          	lw	a4,-24(s0)
    50202c4c:	9fb9                	addw	a5,a5,a4
    50202c4e:	2781                	sext.w	a5,a5
    50202c50:	00007717          	auipc	a4,0x7
    50202c54:	a8870713          	addi	a4,a4,-1400 # 502096d8 <new_screen>
    50202c58:	97ba                	add	a5,a5,a4
    50202c5a:	0007c783          	lbu	a5,0(a5)
    50202c5e:	853e                	mv	a0,a5
    50202c60:	e52fe0ef          	jal	ra,502012b2 <port_write_ch>
    50202c64:	fec42703          	lw	a4,-20(s0)
    50202c68:	87ba                	mv	a5,a4
    50202c6a:	0027979b          	slliw	a5,a5,0x2
    50202c6e:	9fb9                	addw	a5,a5,a4
    50202c70:	0047979b          	slliw	a5,a5,0x4
    50202c74:	2781                	sext.w	a5,a5
    50202c76:	fe842703          	lw	a4,-24(s0)
    50202c7a:	9fb9                	addw	a5,a5,a4
    50202c7c:	0007869b          	sext.w	a3,a5
    50202c80:	fec42703          	lw	a4,-20(s0)
    50202c84:	87ba                	mv	a5,a4
    50202c86:	0027979b          	slliw	a5,a5,0x2
    50202c8a:	9fb9                	addw	a5,a5,a4
    50202c8c:	0047979b          	slliw	a5,a5,0x4
    50202c90:	2781                	sext.w	a5,a5
    50202c92:	fe842703          	lw	a4,-24(s0)
    50202c96:	9fb9                	addw	a5,a5,a4
    50202c98:	2781                	sext.w	a5,a5
    50202c9a:	00007717          	auipc	a4,0x7
    50202c9e:	a3e70713          	addi	a4,a4,-1474 # 502096d8 <new_screen>
    50202ca2:	9736                	add	a4,a4,a3
    50202ca4:	00074703          	lbu	a4,0(a4)
    50202ca8:	00008697          	auipc	a3,0x8
    50202cac:	9d068693          	addi	a3,a3,-1584 # 5020a678 <old_screen>
    50202cb0:	97b6                	add	a5,a5,a3
    50202cb2:	00e78023          	sb	a4,0(a5)
    50202cb6:	fe842783          	lw	a5,-24(s0)
    50202cba:	2785                	addiw	a5,a5,1
    50202cbc:	fef42423          	sw	a5,-24(s0)
    50202cc0:	fe842783          	lw	a5,-24(s0)
    50202cc4:	0007871b          	sext.w	a4,a5
    50202cc8:	04f00793          	li	a5,79
    50202ccc:	eee7dde3          	bge	a5,a4,50202bc6 <screen_reflush+0x1e>
    50202cd0:	fec42783          	lw	a5,-20(s0)
    50202cd4:	2785                	addiw	a5,a5,1
    50202cd6:	fef42623          	sw	a5,-20(s0)
    50202cda:	fec42783          	lw	a5,-20(s0)
    50202cde:	0007871b          	sext.w	a4,a5
    50202ce2:	03100793          	li	a5,49
    50202ce6:	ece7dde3          	bge	a5,a4,50202bc0 <screen_reflush+0x18>
    50202cea:	00009717          	auipc	a4,0x9
    50202cee:	1de70713          	addi	a4,a4,478 # 5020bec8 <screen_cursor_x>
    50202cf2:	fe442783          	lw	a5,-28(s0)
    50202cf6:	078a                	slli	a5,a5,0x2
    50202cf8:	97ba                	add	a5,a5,a4
    50202cfa:	439c                	lw	a5,0(a5)
    50202cfc:	2785                	addiw	a5,a5,1
    50202cfe:	0007869b          	sext.w	a3,a5
    50202d02:	00009717          	auipc	a4,0x9
    50202d06:	1ce70713          	addi	a4,a4,462 # 5020bed0 <screen_cursor_y>
    50202d0a:	fe442783          	lw	a5,-28(s0)
    50202d0e:	078a                	slli	a5,a5,0x2
    50202d10:	97ba                	add	a5,a5,a4
    50202d12:	439c                	lw	a5,0(a5)
    50202d14:	2785                	addiw	a5,a5,1
    50202d16:	2781                	sext.w	a5,a5
    50202d18:	85be                	mv	a1,a5
    50202d1a:	8536                	mv	a0,a3
    50202d1c:	897ff0ef          	jal	ra,502025b2 <vt100_move_cursor>
    50202d20:	0001                	nop
    50202d22:	60e2                	ld	ra,24(sp)
    50202d24:	6442                	ld	s0,16(sp)
    50202d26:	6105                	addi	sp,sp,32
    50202d28:	8082                	ret

0000000050202d2a <getch>:
    50202d2a:	1101                	addi	sp,sp,-32
    50202d2c:	ec06                	sd	ra,24(sp)
    50202d2e:	e822                	sd	s0,16(sp)
    50202d30:	1000                	addi	s0,sp,32
    50202d32:	fe042423          	sw	zero,-24(s0)
    50202d36:	a805                	j	50202d66 <getch+0x3c>
    50202d38:	dbcfe0ef          	jal	ra,502012f4 <port_read_ch>
    50202d3c:	87aa                	mv	a5,a0
    50202d3e:	fef407a3          	sb	a5,-17(s0)
    50202d42:	fef44783          	lbu	a5,-17(s0)
    50202d46:	0ff7f793          	andi	a5,a5,255
    50202d4a:	cb89                	beqz	a5,50202d5c <getch+0x32>
    50202d4c:	fef40783          	lb	a5,-17(s0)
    50202d50:	0007c663          	bltz	a5,50202d5c <getch+0x32>
    50202d54:	fef44783          	lbu	a5,-17(s0)
    50202d58:	2781                	sext.w	a5,a5
    50202d5a:	a00d                	j	50202d7c <getch+0x52>
    50202d5c:	fe842783          	lw	a5,-24(s0)
    50202d60:	2785                	addiw	a5,a5,1
    50202d62:	fef42423          	sw	a5,-24(s0)
    50202d66:	fe842783          	lw	a5,-24(s0)
    50202d6a:	0007871b          	sext.w	a4,a5
    50202d6e:	06300793          	li	a5,99
    50202d72:	fce7d3e3          	bge	a5,a4,50202d38 <getch+0xe>
    50202d76:	fef44783          	lbu	a5,-17(s0)
    50202d7a:	2781                	sext.w	a5,a5
    50202d7c:	853e                	mv	a0,a5
    50202d7e:	60e2                	ld	ra,24(sp)
    50202d80:	6442                	ld	s0,16(sp)
    50202d82:	6105                	addi	sp,sp,32
    50202d84:	8082                	ret

0000000050202d86 <getchar>:
    50202d86:	1101                	addi	sp,sp,-32
    50202d88:	ec06                	sd	ra,24(sp)
    50202d8a:	e822                	sd	s0,16(sp)
    50202d8c:	1000                	addi	s0,sp,32
    50202d8e:	0001                	nop
    50202d90:	d64fe0ef          	jal	ra,502012f4 <port_read_ch>
    50202d94:	87aa                	mv	a5,a0
    50202d96:	fef407a3          	sb	a5,-17(s0)
    50202d9a:	fef40783          	lb	a5,-17(s0)
    50202d9e:	fe07c9e3          	bltz	a5,50202d90 <getchar+0xa>
    50202da2:	fef44783          	lbu	a5,-17(s0)
    50202da6:	2781                	sext.w	a5,a5
    50202da8:	853e                	mv	a0,a5
    50202daa:	60e2                	ld	ra,24(sp)
    50202dac:	6442                	ld	s0,16(sp)
    50202dae:	6105                	addi	sp,sp,32
    50202db0:	8082                	ret

0000000050202db2 <atomic_cmpxchg>:
    50202db2:	7179                	addi	sp,sp,-48
    50202db4:	f422                	sd	s0,40(sp)
    50202db6:	1800                	addi	s0,sp,48
    50202db8:	87aa                	mv	a5,a0
    50202dba:	872e                	mv	a4,a1
    50202dbc:	fcc43823          	sd	a2,-48(s0)
    50202dc0:	fcf42e23          	sw	a5,-36(s0)
    50202dc4:	87ba                	mv	a5,a4
    50202dc6:	fcf42c23          	sw	a5,-40(s0)
    50202dca:	fd043783          	ld	a5,-48(s0)
    50202dce:	fdc42703          	lw	a4,-36(s0)
    50202dd2:	fd842683          	lw	a3,-40(s0)
    50202dd6:	1007a62f          	lr.w	a2,(a5)
    50202dda:	00e61763          	bne	a2,a4,50202de8 <atomic_cmpxchg+0x36>
    50202dde:	1ad7a5af          	sc.w.rl	a1,a3,(a5)
    50202de2:	f9f5                	bnez	a1,50202dd6 <atomic_cmpxchg+0x24>
    50202de4:	0330000f          	fence	rw,rw
    50202de8:	fec42623          	sw	a2,-20(s0)
    50202dec:	fec42783          	lw	a5,-20(s0)
    50202df0:	853e                	mv	a0,a5
    50202df2:	7422                	ld	s0,40(sp)
    50202df4:	6145                	addi	sp,sp,48
    50202df6:	8082                	ret

0000000050202df8 <do_mutex_lock_init>:
    50202df8:	1101                	addi	sp,sp,-32
    50202dfa:	ec22                	sd	s0,24(sp)
    50202dfc:	1000                	addi	s0,sp,32
    50202dfe:	fea43423          	sd	a0,-24(s0)
    50202e02:	fe843783          	ld	a5,-24(s0)
    50202e06:	0007a023          	sw	zero,0(a5)
    50202e0a:	fe843783          	ld	a5,-24(s0)
    50202e0e:	0007b423          	sd	zero,8(a5)
    50202e12:	fe843783          	ld	a5,-24(s0)
    50202e16:	0007bc23          	sd	zero,24(a5)
    50202e1a:	fe843783          	ld	a5,-24(s0)
    50202e1e:	0207b023          	sd	zero,32(a5)
    50202e22:	fe843783          	ld	a5,-24(s0)
    50202e26:	0007a823          	sw	zero,16(a5)
    50202e2a:	0001                	nop
    50202e2c:	6462                	ld	s0,24(sp)
    50202e2e:	6105                	addi	sp,sp,32
    50202e30:	8082                	ret

0000000050202e32 <do_mutex_lock_acquire>:
    50202e32:	7179                	addi	sp,sp,-48
    50202e34:	f406                	sd	ra,40(sp)
    50202e36:	f022                	sd	s0,32(sp)
    50202e38:	1800                	addi	s0,sp,48
    50202e3a:	fca43c23          	sd	a0,-40(s0)
    50202e3e:	c0afe0ef          	jal	ra,50201248 <get_current_cpu_id>
    50202e42:	87aa                	mv	a5,a0
    50202e44:	fef42623          	sw	a5,-20(s0)
    50202e48:	fd843783          	ld	a5,-40(s0)
    50202e4c:	439c                	lw	a5,0(a5)
    50202e4e:	2781                	sext.w	a5,a5
    50202e50:	873e                	mv	a4,a5
    50202e52:	4785                	li	a5,1
    50202e54:	06f71363          	bne	a4,a5,50202eba <do_mutex_lock_acquire+0x88>
    50202e58:	00009717          	auipc	a4,0x9
    50202e5c:	09870713          	addi	a4,a4,152 # 5020bef0 <current_running>
    50202e60:	fec42783          	lw	a5,-20(s0)
    50202e64:	078e                	slli	a5,a5,0x3
    50202e66:	97ba                	add	a5,a5,a4
    50202e68:	639c                	ld	a5,0(a5)
    50202e6a:	4705                	li	a4,1
    50202e6c:	cff8                	sw	a4,92(a5)
    50202e6e:	00009717          	auipc	a4,0x9
    50202e72:	08270713          	addi	a4,a4,130 # 5020bef0 <current_running>
    50202e76:	fec42783          	lw	a5,-20(s0)
    50202e7a:	078e                	slli	a5,a5,0x3
    50202e7c:	97ba                	add	a5,a5,a4
    50202e7e:	639c                	ld	a5,0(a5)
    50202e80:	fd843703          	ld	a4,-40(s0)
    50202e84:	0741                	addi	a4,a4,16
    50202e86:	e7b8                	sd	a4,72(a5)
    50202e88:	00009717          	auipc	a4,0x9
    50202e8c:	06870713          	addi	a4,a4,104 # 5020bef0 <current_running>
    50202e90:	fec42783          	lw	a5,-20(s0)
    50202e94:	078e                	slli	a5,a5,0x3
    50202e96:	97ba                	add	a5,a5,a4
    50202e98:	639c                	ld	a5,0(a5)
    50202e9a:	01878713          	addi	a4,a5,24
    50202e9e:	fd843783          	ld	a5,-40(s0)
    50202ea2:	07c1                	addi	a5,a5,16
    50202ea4:	00009617          	auipc	a2,0x9
    50202ea8:	03460613          	addi	a2,a2,52 # 5020bed8 <ready_queue>
    50202eac:	85be                	mv	a1,a5
    50202eae:	853a                	mv	a0,a4
    50202eb0:	5a4000ef          	jal	ra,50203454 <move_node>
    50202eb4:	218000ef          	jal	ra,502030cc <do_scheduler>
    50202eb8:	a00d                	j	50202eda <do_mutex_lock_acquire+0xa8>
    50202eba:	fd843783          	ld	a5,-40(s0)
    50202ebe:	4705                	li	a4,1
    50202ec0:	c398                	sw	a4,0(a5)
    50202ec2:	00009717          	auipc	a4,0x9
    50202ec6:	02e70713          	addi	a4,a4,46 # 5020bef0 <current_running>
    50202eca:	fec42783          	lw	a5,-20(s0)
    50202ece:	078e                	slli	a5,a5,0x3
    50202ed0:	97ba                	add	a5,a5,a4
    50202ed2:	6398                	ld	a4,0(a5)
    50202ed4:	fd843783          	ld	a5,-40(s0)
    50202ed8:	e798                	sd	a4,8(a5)
    50202eda:	0001                	nop
    50202edc:	70a2                	ld	ra,40(sp)
    50202ede:	7402                	ld	s0,32(sp)
    50202ee0:	6145                	addi	sp,sp,48
    50202ee2:	8082                	ret

0000000050202ee4 <do_mutex_lock_release>:
    50202ee4:	1101                	addi	sp,sp,-32
    50202ee6:	ec06                	sd	ra,24(sp)
    50202ee8:	e822                	sd	s0,16(sp)
    50202eea:	1000                	addi	s0,sp,32
    50202eec:	fea43423          	sd	a0,-24(s0)
    50202ef0:	fe843783          	ld	a5,-24(s0)
    50202ef4:	4b9c                	lw	a5,16(a5)
    50202ef6:	08f05263          	blez	a5,50202f7a <do_mutex_lock_release+0x96>
    50202efa:	fe843783          	ld	a5,-24(s0)
    50202efe:	6f9c                	ld	a5,24(a5)
    50202f00:	4398                	lw	a4,0(a5)
    50202f02:	00009697          	auipc	a3,0x9
    50202f06:	01668693          	addi	a3,a3,22 # 5020bf18 <pcb>
    50202f0a:	87ba                	mv	a5,a4
    50202f0c:	078e                	slli	a5,a5,0x3
    50202f0e:	97ba                	add	a5,a5,a4
    50202f10:	0792                	slli	a5,a5,0x4
    50202f12:	97b6                	add	a5,a5,a3
    50202f14:	470d                	li	a4,3
    50202f16:	cff8                	sw	a4,92(a5)
    50202f18:	fe843783          	ld	a5,-24(s0)
    50202f1c:	6f9c                	ld	a5,24(a5)
    50202f1e:	4398                	lw	a4,0(a5)
    50202f20:	00009697          	auipc	a3,0x9
    50202f24:	ff868693          	addi	a3,a3,-8 # 5020bf18 <pcb>
    50202f28:	87ba                	mv	a5,a4
    50202f2a:	078e                	slli	a5,a5,0x3
    50202f2c:	97ba                	add	a5,a5,a4
    50202f2e:	0792                	slli	a5,a5,0x4
    50202f30:	97b6                	add	a5,a5,a3
    50202f32:	00009717          	auipc	a4,0x9
    50202f36:	fa670713          	addi	a4,a4,-90 # 5020bed8 <ready_queue>
    50202f3a:	e7b8                	sd	a4,72(a5)
    50202f3c:	fe843783          	ld	a5,-24(s0)
    50202f40:	6f98                	ld	a4,24(a5)
    50202f42:	fe843783          	ld	a5,-24(s0)
    50202f46:	07c1                	addi	a5,a5,16
    50202f48:	863e                	mv	a2,a5
    50202f4a:	00009597          	auipc	a1,0x9
    50202f4e:	f8e58593          	addi	a1,a1,-114 # 5020bed8 <ready_queue>
    50202f52:	853a                	mv	a0,a4
    50202f54:	500000ef          	jal	ra,50203454 <move_node>
    50202f58:	fe843783          	ld	a5,-24(s0)
    50202f5c:	6f9c                	ld	a5,24(a5)
    50202f5e:	4398                	lw	a4,0(a5)
    50202f60:	87ba                	mv	a5,a4
    50202f62:	078e                	slli	a5,a5,0x3
    50202f64:	97ba                	add	a5,a5,a4
    50202f66:	0792                	slli	a5,a5,0x4
    50202f68:	00009717          	auipc	a4,0x9
    50202f6c:	fb070713          	addi	a4,a4,-80 # 5020bf18 <pcb>
    50202f70:	973e                	add	a4,a4,a5
    50202f72:	fe843783          	ld	a5,-24(s0)
    50202f76:	e798                	sd	a4,8(a5)
    50202f78:	a809                	j	50202f8a <do_mutex_lock_release+0xa6>
    50202f7a:	fe843783          	ld	a5,-24(s0)
    50202f7e:	0007a023          	sw	zero,0(a5)
    50202f82:	fe843783          	ld	a5,-24(s0)
    50202f86:	0007b423          	sd	zero,8(a5)
    50202f8a:	0001                	nop
    50202f8c:	60e2                	ld	ra,24(sp)
    50202f8e:	6442                	ld	s0,16(sp)
    50202f90:	6105                	addi	sp,sp,32
    50202f92:	8082                	ret

0000000050202f94 <get_mutex>:
    50202f94:	1101                	addi	sp,sp,-32
    50202f96:	ec06                	sd	ra,24(sp)
    50202f98:	e822                	sd	s0,16(sp)
    50202f9a:	1000                	addi	s0,sp,32
    50202f9c:	fea43423          	sd	a0,-24(s0)
    50202fa0:	85018793          	addi	a5,gp,-1968 # 502096b0 <lock_num>
    50202fa4:	4398                	lw	a4,0(a5)
    50202fa6:	87ba                	mv	a5,a4
    50202fa8:	078a                	slli	a5,a5,0x2
    50202faa:	97ba                	add	a5,a5,a4
    50202fac:	078e                	slli	a5,a5,0x3
    50202fae:	00008717          	auipc	a4,0x8
    50202fb2:	7a270713          	addi	a4,a4,1954 # 5020b750 <lock_array>
    50202fb6:	97ba                	add	a5,a5,a4
    50202fb8:	853e                	mv	a0,a5
    50202fba:	e3fff0ef          	jal	ra,50202df8 <do_mutex_lock_init>
    50202fbe:	85018793          	addi	a5,gp,-1968 # 502096b0 <lock_num>
    50202fc2:	439c                	lw	a5,0(a5)
    50202fc4:	0017871b          	addiw	a4,a5,1
    50202fc8:	0007069b          	sext.w	a3,a4
    50202fcc:	85018713          	addi	a4,gp,-1968 # 502096b0 <lock_num>
    50202fd0:	c314                	sw	a3,0(a4)
    50202fd2:	853e                	mv	a0,a5
    50202fd4:	60e2                	ld	ra,24(sp)
    50202fd6:	6442                	ld	s0,16(sp)
    50202fd8:	6105                	addi	sp,sp,32
    50202fda:	8082                	ret

0000000050202fdc <lock_mutex>:
    50202fdc:	1101                	addi	sp,sp,-32
    50202fde:	ec06                	sd	ra,24(sp)
    50202fe0:	e822                	sd	s0,16(sp)
    50202fe2:	1000                	addi	s0,sp,32
    50202fe4:	87aa                	mv	a5,a0
    50202fe6:	fef42623          	sw	a5,-20(s0)
    50202fea:	fec42703          	lw	a4,-20(s0)
    50202fee:	87ba                	mv	a5,a4
    50202ff0:	078a                	slli	a5,a5,0x2
    50202ff2:	97ba                	add	a5,a5,a4
    50202ff4:	078e                	slli	a5,a5,0x3
    50202ff6:	00008717          	auipc	a4,0x8
    50202ffa:	75a70713          	addi	a4,a4,1882 # 5020b750 <lock_array>
    50202ffe:	97ba                	add	a5,a5,a4
    50203000:	853e                	mv	a0,a5
    50203002:	e31ff0ef          	jal	ra,50202e32 <do_mutex_lock_acquire>
    50203006:	4781                	li	a5,0
    50203008:	853e                	mv	a0,a5
    5020300a:	60e2                	ld	ra,24(sp)
    5020300c:	6442                	ld	s0,16(sp)
    5020300e:	6105                	addi	sp,sp,32
    50203010:	8082                	ret

0000000050203012 <unlock_mutex>:
    50203012:	1101                	addi	sp,sp,-32
    50203014:	ec06                	sd	ra,24(sp)
    50203016:	e822                	sd	s0,16(sp)
    50203018:	1000                	addi	s0,sp,32
    5020301a:	87aa                	mv	a5,a0
    5020301c:	fef42623          	sw	a5,-20(s0)
    50203020:	fec42703          	lw	a4,-20(s0)
    50203024:	87ba                	mv	a5,a4
    50203026:	078a                	slli	a5,a5,0x2
    50203028:	97ba                	add	a5,a5,a4
    5020302a:	078e                	slli	a5,a5,0x3
    5020302c:	00008717          	auipc	a4,0x8
    50203030:	72470713          	addi	a4,a4,1828 # 5020b750 <lock_array>
    50203034:	97ba                	add	a5,a5,a4
    50203036:	853e                	mv	a0,a5
    50203038:	eadff0ef          	jal	ra,50202ee4 <do_mutex_lock_release>
    5020303c:	4781                	li	a5,0
    5020303e:	853e                	mv	a0,a5
    50203040:	60e2                	ld	ra,24(sp)
    50203042:	6442                	ld	s0,16(sp)
    50203044:	6105                	addi	sp,sp,32
    50203046:	8082                	ret

0000000050203048 <spin_lock_init>:
    50203048:	1101                	addi	sp,sp,-32
    5020304a:	ec22                	sd	s0,24(sp)
    5020304c:	1000                	addi	s0,sp,32
    5020304e:	fea43423          	sd	a0,-24(s0)
    50203052:	fe843783          	ld	a5,-24(s0)
    50203056:	0007b423          	sd	zero,8(a5)
    5020305a:	fe843783          	ld	a5,-24(s0)
    5020305e:	0007a023          	sw	zero,0(a5)
    50203062:	0001                	nop
    50203064:	6462                	ld	s0,24(sp)
    50203066:	6105                	addi	sp,sp,32
    50203068:	8082                	ret

000000005020306a <spin_lock_acquire>:
    5020306a:	1101                	addi	sp,sp,-32
    5020306c:	ec06                	sd	ra,24(sp)
    5020306e:	e822                	sd	s0,16(sp)
    50203070:	1000                	addi	s0,sp,32
    50203072:	fea43423          	sd	a0,-24(s0)
    50203076:	0001                	nop
    50203078:	fe843783          	ld	a5,-24(s0)
    5020307c:	863e                	mv	a2,a5
    5020307e:	4585                	li	a1,1
    50203080:	4501                	li	a0,0
    50203082:	d31ff0ef          	jal	ra,50202db2 <atomic_cmpxchg>
    50203086:	87aa                	mv	a5,a0
    50203088:	2781                	sext.w	a5,a5
    5020308a:	873e                	mv	a4,a5
    5020308c:	4785                	li	a5,1
    5020308e:	fef705e3          	beq	a4,a5,50203078 <spin_lock_acquire+0xe>
    50203092:	0001                	nop
    50203094:	0001                	nop
    50203096:	60e2                	ld	ra,24(sp)
    50203098:	6442                	ld	s0,16(sp)
    5020309a:	6105                	addi	sp,sp,32
    5020309c:	8082                	ret

000000005020309e <spin_lock_release>:
    5020309e:	1101                	addi	sp,sp,-32
    502030a0:	ec06                	sd	ra,24(sp)
    502030a2:	e822                	sd	s0,16(sp)
    502030a4:	1000                	addi	s0,sp,32
    502030a6:	fea43423          	sd	a0,-24(s0)
    502030aa:	0001                	nop
    502030ac:	fe843783          	ld	a5,-24(s0)
    502030b0:	863e                	mv	a2,a5
    502030b2:	4581                	li	a1,0
    502030b4:	4505                	li	a0,1
    502030b6:	cfdff0ef          	jal	ra,50202db2 <atomic_cmpxchg>
    502030ba:	87aa                	mv	a5,a0
    502030bc:	2781                	sext.w	a5,a5
    502030be:	d7fd                	beqz	a5,502030ac <spin_lock_release+0xe>
    502030c0:	0001                	nop
    502030c2:	0001                	nop
    502030c4:	60e2                	ld	ra,24(sp)
    502030c6:	6442                	ld	s0,16(sp)
    502030c8:	6105                	addi	sp,sp,32
    502030ca:	8082                	ret

00000000502030cc <do_scheduler>:
    502030cc:	7139                	addi	sp,sp,-64
    502030ce:	fc06                	sd	ra,56(sp)
    502030d0:	f822                	sd	s0,48(sp)
    502030d2:	0080                	addi	s0,sp,64
    502030d4:	974fe0ef          	jal	ra,50201248 <get_current_cpu_id>
    502030d8:	87aa                	mv	a5,a0
    502030da:	fcf42e23          	sw	a5,-36(s0)
    502030de:	260010ef          	jal	ra,5020433e <get_timer>
    502030e2:	fca43823          	sd	a0,-48(s0)
    502030e6:	00009797          	auipc	a5,0x9
    502030ea:	e1a78793          	addi	a5,a5,-486 # 5020bf00 <sleep_queue>
    502030ee:	fef43023          	sd	a5,-32(s0)
    502030f2:	a841                	j	50203182 <do_scheduler+0xb6>
    502030f4:	fe043783          	ld	a5,-32(s0)
    502030f8:	679c                	ld	a5,8(a5)
    502030fa:	4398                	lw	a4,0(a5)
    502030fc:	00009697          	auipc	a3,0x9
    50203100:	e1c68693          	addi	a3,a3,-484 # 5020bf18 <pcb>
    50203104:	87ba                	mv	a5,a4
    50203106:	078e                	slli	a5,a5,0x3
    50203108:	97ba                	add	a5,a5,a4
    5020310a:	0792                	slli	a5,a5,0x4
    5020310c:	97b6                	add	a5,a5,a3
    5020310e:	77bc                	ld	a5,104(a5)
    50203110:	fd043703          	ld	a4,-48(s0)
    50203114:	06f76263          	bltu	a4,a5,50203178 <do_scheduler+0xac>
    50203118:	fe043783          	ld	a5,-32(s0)
    5020311c:	679c                	ld	a5,8(a5)
    5020311e:	4398                	lw	a4,0(a5)
    50203120:	00009697          	auipc	a3,0x9
    50203124:	df868693          	addi	a3,a3,-520 # 5020bf18 <pcb>
    50203128:	87ba                	mv	a5,a4
    5020312a:	078e                	slli	a5,a5,0x3
    5020312c:	97ba                	add	a5,a5,a4
    5020312e:	0792                	slli	a5,a5,0x4
    50203130:	97b6                	add	a5,a5,a3
    50203132:	470d                	li	a4,3
    50203134:	cff8                	sw	a4,92(a5)
    50203136:	fe043783          	ld	a5,-32(s0)
    5020313a:	679c                	ld	a5,8(a5)
    5020313c:	4398                	lw	a4,0(a5)
    5020313e:	00009697          	auipc	a3,0x9
    50203142:	dda68693          	addi	a3,a3,-550 # 5020bf18 <pcb>
    50203146:	87ba                	mv	a5,a4
    50203148:	078e                	slli	a5,a5,0x3
    5020314a:	97ba                	add	a5,a5,a4
    5020314c:	0792                	slli	a5,a5,0x4
    5020314e:	97b6                	add	a5,a5,a3
    50203150:	00009717          	auipc	a4,0x9
    50203154:	d8870713          	addi	a4,a4,-632 # 5020bed8 <ready_queue>
    50203158:	e7b8                	sd	a4,72(a5)
    5020315a:	fe043783          	ld	a5,-32(s0)
    5020315e:	679c                	ld	a5,8(a5)
    50203160:	00009617          	auipc	a2,0x9
    50203164:	da060613          	addi	a2,a2,-608 # 5020bf00 <sleep_queue>
    50203168:	00009597          	auipc	a1,0x9
    5020316c:	d7058593          	addi	a1,a1,-656 # 5020bed8 <ready_queue>
    50203170:	853e                	mv	a0,a5
    50203172:	2e2000ef          	jal	ra,50203454 <move_node>
    50203176:	a031                	j	50203182 <do_scheduler+0xb6>
    50203178:	fe043783          	ld	a5,-32(s0)
    5020317c:	679c                	ld	a5,8(a5)
    5020317e:	fef43023          	sd	a5,-32(s0)
    50203182:	00009797          	auipc	a5,0x9
    50203186:	d7e78793          	addi	a5,a5,-642 # 5020bf00 <sleep_queue>
    5020318a:	439c                	lw	a5,0(a5)
    5020318c:	00f05663          	blez	a5,50203198 <do_scheduler+0xcc>
    50203190:	fe043783          	ld	a5,-32(s0)
    50203194:	679c                	ld	a5,8(a5)
    50203196:	ffb9                	bnez	a5,502030f4 <do_scheduler+0x28>
    50203198:	00009797          	auipc	a5,0x9
    5020319c:	d4078793          	addi	a5,a5,-704 # 5020bed8 <ready_queue>
    502031a0:	439c                	lw	a5,0(a5)
    502031a2:	20078063          	beqz	a5,502033a2 <do_scheduler+0x2d6>
    502031a6:	00009717          	auipc	a4,0x9
    502031aa:	d4a70713          	addi	a4,a4,-694 # 5020bef0 <current_running>
    502031ae:	fdc42783          	lw	a5,-36(s0)
    502031b2:	078e                	slli	a5,a5,0x3
    502031b4:	97ba                	add	a5,a5,a4
    502031b6:	639c                	ld	a5,0(a5)
    502031b8:	fcf43423          	sd	a5,-56(s0)
    502031bc:	00009717          	auipc	a4,0x9
    502031c0:	d0c70713          	addi	a4,a4,-756 # 5020bec8 <screen_cursor_x>
    502031c4:	fdc42783          	lw	a5,-36(s0)
    502031c8:	078a                	slli	a5,a5,0x2
    502031ca:	97ba                	add	a5,a5,a4
    502031cc:	4398                	lw	a4,0(a5)
    502031ce:	fc843783          	ld	a5,-56(s0)
    502031d2:	08e7a423          	sw	a4,136(a5)
    502031d6:	00009717          	auipc	a4,0x9
    502031da:	cfa70713          	addi	a4,a4,-774 # 5020bed0 <screen_cursor_y>
    502031de:	fdc42783          	lw	a5,-36(s0)
    502031e2:	078a                	slli	a5,a5,0x2
    502031e4:	97ba                	add	a5,a5,a4
    502031e6:	4398                	lw	a4,0(a5)
    502031e8:	fc843783          	ld	a5,-56(s0)
    502031ec:	08e7a623          	sw	a4,140(a5)
    502031f0:	fc843783          	ld	a5,-56(s0)
    502031f4:	4ffc                	lw	a5,92(a5)
    502031f6:	873e                	mv	a4,a5
    502031f8:	4789                	li	a5,2
    502031fa:	00f71663          	bne	a4,a5,50203206 <do_scheduler+0x13a>
    502031fe:	fc843783          	ld	a5,-56(s0)
    50203202:	470d                	li	a4,3
    50203204:	cff8                	sw	a4,92(a5)
    50203206:	fc843783          	ld	a5,-56(s0)
    5020320a:	739c                	ld	a5,32(a5)
    5020320c:	fef43423          	sd	a5,-24(s0)
    50203210:	fe843783          	ld	a5,-24(s0)
    50203214:	439c                	lw	a5,0(a5)
    50203216:	fcf42223          	sw	a5,-60(s0)
    5020321a:	fc843783          	ld	a5,-56(s0)
    5020321e:	07e1                	addi	a5,a5,24
    50203220:	fe843703          	ld	a4,-24(s0)
    50203224:	08f70c63          	beq	a4,a5,502032bc <do_scheduler+0x1f0>
    50203228:	fe843783          	ld	a5,-24(s0)
    5020322c:	cb89                	beqz	a5,5020323e <do_scheduler+0x172>
    5020322e:	fe843703          	ld	a4,-24(s0)
    50203232:	00009797          	auipc	a5,0x9
    50203236:	ca678793          	addi	a5,a5,-858 # 5020bed8 <ready_queue>
    5020323a:	00f71a63          	bne	a4,a5,5020324e <do_scheduler+0x182>
    5020323e:	00009797          	auipc	a5,0x9
    50203242:	c9a78793          	addi	a5,a5,-870 # 5020bed8 <ready_queue>
    50203246:	679c                	ld	a5,8(a5)
    50203248:	fef43423          	sd	a5,-24(s0)
    5020324c:	a0bd                	j	502032ba <do_scheduler+0x1ee>
    5020324e:	00009697          	auipc	a3,0x9
    50203252:	cca68693          	addi	a3,a3,-822 # 5020bf18 <pcb>
    50203256:	fc442703          	lw	a4,-60(s0)
    5020325a:	87ba                	mv	a5,a4
    5020325c:	078e                	slli	a5,a5,0x3
    5020325e:	97ba                	add	a5,a5,a4
    50203260:	0792                	slli	a5,a5,0x4
    50203262:	97b6                	add	a5,a5,a3
    50203264:	4ffc                	lw	a5,92(a5)
    50203266:	873e                	mv	a4,a5
    50203268:	478d                	li	a5,3
    5020326a:	04f71363          	bne	a4,a5,502032b0 <do_scheduler+0x1e4>
    5020326e:	00009697          	auipc	a3,0x9
    50203272:	caa68693          	addi	a3,a3,-854 # 5020bf18 <pcb>
    50203276:	fc442703          	lw	a4,-60(s0)
    5020327a:	87ba                	mv	a5,a4
    5020327c:	078e                	slli	a5,a5,0x3
    5020327e:	97ba                	add	a5,a5,a4
    50203280:	0792                	slli	a5,a5,0x4
    50203282:	97b6                	add	a5,a5,a3
    50203284:	4bfc                	lw	a5,84(a5)
    50203286:	873e                	mv	a4,a5
    50203288:	57fd                	li	a5,-1
    5020328a:	02f70a63          	beq	a4,a5,502032be <do_scheduler+0x1f2>
    5020328e:	00009697          	auipc	a3,0x9
    50203292:	c8a68693          	addi	a3,a3,-886 # 5020bf18 <pcb>
    50203296:	fc442703          	lw	a4,-60(s0)
    5020329a:	87ba                	mv	a5,a4
    5020329c:	078e                	slli	a5,a5,0x3
    5020329e:	97ba                	add	a5,a5,a4
    502032a0:	0792                	slli	a5,a5,0x4
    502032a2:	97b6                	add	a5,a5,a3
    502032a4:	4bf8                	lw	a4,84(a5)
    502032a6:	fdc42783          	lw	a5,-36(s0)
    502032aa:	2781                	sext.w	a5,a5
    502032ac:	00e78963          	beq	a5,a4,502032be <do_scheduler+0x1f2>
    502032b0:	fe843783          	ld	a5,-24(s0)
    502032b4:	679c                	ld	a5,8(a5)
    502032b6:	fef43423          	sd	a5,-24(s0)
    502032ba:	bf99                	j	50203210 <do_scheduler+0x144>
    502032bc:	0001                	nop
    502032be:	fc442703          	lw	a4,-60(s0)
    502032c2:	87ba                	mv	a5,a4
    502032c4:	078e                	slli	a5,a5,0x3
    502032c6:	97ba                	add	a5,a5,a4
    502032c8:	0792                	slli	a5,a5,0x4
    502032ca:	00009717          	auipc	a4,0x9
    502032ce:	c4e70713          	addi	a4,a4,-946 # 5020bf18 <pcb>
    502032d2:	973e                	add	a4,a4,a5
    502032d4:	00009697          	auipc	a3,0x9
    502032d8:	c1c68693          	addi	a3,a3,-996 # 5020bef0 <current_running>
    502032dc:	fdc42783          	lw	a5,-36(s0)
    502032e0:	078e                	slli	a5,a5,0x3
    502032e2:	97b6                	add	a5,a5,a3
    502032e4:	e398                	sd	a4,0(a5)
    502032e6:	00009717          	auipc	a4,0x9
    502032ea:	c0a70713          	addi	a4,a4,-1014 # 5020bef0 <current_running>
    502032ee:	fdc42783          	lw	a5,-36(s0)
    502032f2:	078e                	slli	a5,a5,0x3
    502032f4:	97ba                	add	a5,a5,a4
    502032f6:	639c                	ld	a5,0(a5)
    502032f8:	4709                	li	a4,2
    502032fa:	cff8                	sw	a4,92(a5)
    502032fc:	00009717          	auipc	a4,0x9
    50203300:	bf470713          	addi	a4,a4,-1036 # 5020bef0 <current_running>
    50203304:	fdc42783          	lw	a5,-36(s0)
    50203308:	078e                	slli	a5,a5,0x3
    5020330a:	97ba                	add	a5,a5,a4
    5020330c:	639c                	ld	a5,0(a5)
    5020330e:	0887a683          	lw	a3,136(a5)
    50203312:	00009717          	auipc	a4,0x9
    50203316:	bde70713          	addi	a4,a4,-1058 # 5020bef0 <current_running>
    5020331a:	fdc42783          	lw	a5,-36(s0)
    5020331e:	078e                	slli	a5,a5,0x3
    50203320:	97ba                	add	a5,a5,a4
    50203322:	639c                	ld	a5,0(a5)
    50203324:	08c7a783          	lw	a5,140(a5)
    50203328:	85be                	mv	a1,a5
    5020332a:	8536                	mv	a0,a3
    5020332c:	a86ff0ef          	jal	ra,502025b2 <vt100_move_cursor>
    50203330:	00009717          	auipc	a4,0x9
    50203334:	bc070713          	addi	a4,a4,-1088 # 5020bef0 <current_running>
    50203338:	fdc42783          	lw	a5,-36(s0)
    5020333c:	078e                	slli	a5,a5,0x3
    5020333e:	97ba                	add	a5,a5,a4
    50203340:	639c                	ld	a5,0(a5)
    50203342:	0887a703          	lw	a4,136(a5)
    50203346:	00009697          	auipc	a3,0x9
    5020334a:	b8268693          	addi	a3,a3,-1150 # 5020bec8 <screen_cursor_x>
    5020334e:	fdc42783          	lw	a5,-36(s0)
    50203352:	078a                	slli	a5,a5,0x2
    50203354:	97b6                	add	a5,a5,a3
    50203356:	c398                	sw	a4,0(a5)
    50203358:	00009717          	auipc	a4,0x9
    5020335c:	b9870713          	addi	a4,a4,-1128 # 5020bef0 <current_running>
    50203360:	fdc42783          	lw	a5,-36(s0)
    50203364:	078e                	slli	a5,a5,0x3
    50203366:	97ba                	add	a5,a5,a4
    50203368:	639c                	ld	a5,0(a5)
    5020336a:	08c7a703          	lw	a4,140(a5)
    5020336e:	00009697          	auipc	a3,0x9
    50203372:	b6268693          	addi	a3,a3,-1182 # 5020bed0 <screen_cursor_y>
    50203376:	fdc42783          	lw	a5,-36(s0)
    5020337a:	078a                	slli	a5,a5,0x2
    5020337c:	97b6                	add	a5,a5,a3
    5020337e:	c398                	sw	a4,0(a5)
    50203380:	829ff0ef          	jal	ra,50202ba8 <screen_reflush>
    50203384:	00009717          	auipc	a4,0x9
    50203388:	b6c70713          	addi	a4,a4,-1172 # 5020bef0 <current_running>
    5020338c:	fdc42783          	lw	a5,-36(s0)
    50203390:	078e                	slli	a5,a5,0x3
    50203392:	97ba                	add	a5,a5,a4
    50203394:	639c                	ld	a5,0(a5)
    50203396:	85be                	mv	a1,a5
    50203398:	fc843503          	ld	a0,-56(s0)
    5020339c:	d15fd0ef          	jal	ra,502010b0 <switch_to>
    502033a0:	a011                	j	502033a4 <do_scheduler+0x2d8>
    502033a2:	0001                	nop
    502033a4:	70e2                	ld	ra,56(sp)
    502033a6:	7442                	ld	s0,48(sp)
    502033a8:	6121                	addi	sp,sp,64
    502033aa:	8082                	ret

00000000502033ac <do_sleep>:
    502033ac:	7139                	addi	sp,sp,-64
    502033ae:	fc06                	sd	ra,56(sp)
    502033b0:	f822                	sd	s0,48(sp)
    502033b2:	f426                	sd	s1,40(sp)
    502033b4:	0080                	addi	s0,sp,64
    502033b6:	87aa                	mv	a5,a0
    502033b8:	fcf42623          	sw	a5,-52(s0)
    502033bc:	e8dfd0ef          	jal	ra,50201248 <get_current_cpu_id>
    502033c0:	87aa                	mv	a5,a0
    502033c2:	fcf42e23          	sw	a5,-36(s0)
    502033c6:	00009717          	auipc	a4,0x9
    502033ca:	b2a70713          	addi	a4,a4,-1238 # 5020bef0 <current_running>
    502033ce:	fdc42783          	lw	a5,-36(s0)
    502033d2:	078e                	slli	a5,a5,0x3
    502033d4:	97ba                	add	a5,a5,a4
    502033d6:	639c                	ld	a5,0(a5)
    502033d8:	4705                	li	a4,1
    502033da:	cff8                	sw	a4,92(a5)
    502033dc:	fcc46483          	lwu	s1,-52(s0)
    502033e0:	75f000ef          	jal	ra,5020433e <get_timer>
    502033e4:	86aa                	mv	a3,a0
    502033e6:	00009717          	auipc	a4,0x9
    502033ea:	b0a70713          	addi	a4,a4,-1270 # 5020bef0 <current_running>
    502033ee:	fdc42783          	lw	a5,-36(s0)
    502033f2:	078e                	slli	a5,a5,0x3
    502033f4:	97ba                	add	a5,a5,a4
    502033f6:	639c                	ld	a5,0(a5)
    502033f8:	00d48733          	add	a4,s1,a3
    502033fc:	f7b8                	sd	a4,104(a5)
    502033fe:	00009717          	auipc	a4,0x9
    50203402:	af270713          	addi	a4,a4,-1294 # 5020bef0 <current_running>
    50203406:	fdc42783          	lw	a5,-36(s0)
    5020340a:	078e                	slli	a5,a5,0x3
    5020340c:	97ba                	add	a5,a5,a4
    5020340e:	639c                	ld	a5,0(a5)
    50203410:	00009717          	auipc	a4,0x9
    50203414:	af070713          	addi	a4,a4,-1296 # 5020bf00 <sleep_queue>
    50203418:	e7b8                	sd	a4,72(a5)
    5020341a:	00009717          	auipc	a4,0x9
    5020341e:	ad670713          	addi	a4,a4,-1322 # 5020bef0 <current_running>
    50203422:	fdc42783          	lw	a5,-36(s0)
    50203426:	078e                	slli	a5,a5,0x3
    50203428:	97ba                	add	a5,a5,a4
    5020342a:	639c                	ld	a5,0(a5)
    5020342c:	07e1                	addi	a5,a5,24
    5020342e:	00009617          	auipc	a2,0x9
    50203432:	aaa60613          	addi	a2,a2,-1366 # 5020bed8 <ready_queue>
    50203436:	00009597          	auipc	a1,0x9
    5020343a:	aca58593          	addi	a1,a1,-1334 # 5020bf00 <sleep_queue>
    5020343e:	853e                	mv	a0,a5
    50203440:	014000ef          	jal	ra,50203454 <move_node>
    50203444:	c89ff0ef          	jal	ra,502030cc <do_scheduler>
    50203448:	0001                	nop
    5020344a:	70e2                	ld	ra,56(sp)
    5020344c:	7442                	ld	s0,48(sp)
    5020344e:	74a2                	ld	s1,40(sp)
    50203450:	6121                	addi	sp,sp,64
    50203452:	8082                	ret

0000000050203454 <move_node>:
    50203454:	715d                	addi	sp,sp,-80
    50203456:	e4a2                	sd	s0,72(sp)
    50203458:	0880                	addi	s0,sp,80
    5020345a:	fca43423          	sd	a0,-56(s0)
    5020345e:	fcb43023          	sd	a1,-64(s0)
    50203462:	fac43c23          	sd	a2,-72(s0)
    50203466:	fc843783          	ld	a5,-56(s0)
    5020346a:	6b9c                	ld	a5,16(a5)
    5020346c:	fef43023          	sd	a5,-32(s0)
    50203470:	fc843783          	ld	a5,-56(s0)
    50203474:	679c                	ld	a5,8(a5)
    50203476:	fcf43c23          	sd	a5,-40(s0)
    5020347a:	fe043783          	ld	a5,-32(s0)
    5020347e:	c799                	beqz	a5,5020348c <move_node+0x38>
    50203480:	fe043783          	ld	a5,-32(s0)
    50203484:	fd843703          	ld	a4,-40(s0)
    50203488:	e798                	sd	a4,8(a5)
    5020348a:	a031                	j	50203496 <move_node+0x42>
    5020348c:	fb843783          	ld	a5,-72(s0)
    50203490:	fd843703          	ld	a4,-40(s0)
    50203494:	e798                	sd	a4,8(a5)
    50203496:	fd843783          	ld	a5,-40(s0)
    5020349a:	c799                	beqz	a5,502034a8 <move_node+0x54>
    5020349c:	fd843783          	ld	a5,-40(s0)
    502034a0:	fe043703          	ld	a4,-32(s0)
    502034a4:	eb98                	sd	a4,16(a5)
    502034a6:	a031                	j	502034b2 <move_node+0x5e>
    502034a8:	fb843783          	ld	a5,-72(s0)
    502034ac:	fe043703          	ld	a4,-32(s0)
    502034b0:	eb98                	sd	a4,16(a5)
    502034b2:	fb843783          	ld	a5,-72(s0)
    502034b6:	439c                	lw	a5,0(a5)
    502034b8:	37fd                	addiw	a5,a5,-1
    502034ba:	0007871b          	sext.w	a4,a5
    502034be:	fb843783          	ld	a5,-72(s0)
    502034c2:	c398                	sw	a4,0(a5)
    502034c4:	fc043783          	ld	a5,-64(s0)
    502034c8:	439c                	lw	a5,0(a5)
    502034ca:	e791                	bnez	a5,502034d6 <move_node+0x82>
    502034cc:	fc043783          	ld	a5,-64(s0)
    502034d0:	fef43423          	sd	a5,-24(s0)
    502034d4:	a031                	j	502034e0 <move_node+0x8c>
    502034d6:	fc043783          	ld	a5,-64(s0)
    502034da:	6b9c                	ld	a5,16(a5)
    502034dc:	fef43423          	sd	a5,-24(s0)
    502034e0:	fe843783          	ld	a5,-24(s0)
    502034e4:	fc843703          	ld	a4,-56(s0)
    502034e8:	e798                	sd	a4,8(a5)
    502034ea:	fc843783          	ld	a5,-56(s0)
    502034ee:	fe843703          	ld	a4,-24(s0)
    502034f2:	eb98                	sd	a4,16(a5)
    502034f4:	fc843783          	ld	a5,-56(s0)
    502034f8:	0007b423          	sd	zero,8(a5)
    502034fc:	fc043783          	ld	a5,-64(s0)
    50203500:	fc843703          	ld	a4,-56(s0)
    50203504:	eb98                	sd	a4,16(a5)
    50203506:	fc043783          	ld	a5,-64(s0)
    5020350a:	439c                	lw	a5,0(a5)
    5020350c:	2785                	addiw	a5,a5,1
    5020350e:	0007871b          	sext.w	a4,a5
    50203512:	fc043783          	ld	a5,-64(s0)
    50203516:	c398                	sw	a4,0(a5)
    50203518:	0001                	nop
    5020351a:	6426                	ld	s0,72(sp)
    5020351c:	6161                	addi	sp,sp,80
    5020351e:	8082                	ret

0000000050203520 <alloc_new_pcb>:
    50203520:	1141                	addi	sp,sp,-16
    50203522:	e422                	sd	s0,8(sp)
    50203524:	0800                	addi	s0,sp,16
    50203526:	82818793          	addi	a5,gp,-2008 # 50209688 <process_id>
    5020352a:	4398                	lw	a4,0(a5)
    5020352c:	82818793          	addi	a5,gp,-2008 # 50209688 <process_id>
    50203530:	4394                	lw	a3,0(a5)
    50203532:	00009617          	auipc	a2,0x9
    50203536:	9e660613          	addi	a2,a2,-1562 # 5020bf18 <pcb>
    5020353a:	87ba                	mv	a5,a4
    5020353c:	078e                	slli	a5,a5,0x3
    5020353e:	97ba                	add	a5,a5,a4
    50203540:	0792                	slli	a5,a5,0x4
    50203542:	97b2                	add	a5,a5,a2
    50203544:	cbb4                	sw	a3,80(a5)
    50203546:	82818793          	addi	a5,gp,-2008 # 50209688 <process_id>
    5020354a:	439c                	lw	a5,0(a5)
    5020354c:	853e                	mv	a0,a5
    5020354e:	6422                	ld	s0,8(sp)
    50203550:	0141                	addi	sp,sp,16
    50203552:	8082                	ret

0000000050203554 <set_pcb_ready>:
    50203554:	7179                	addi	sp,sp,-48
    50203556:	f422                	sd	s0,40(sp)
    50203558:	1800                	addi	s0,sp,48
    5020355a:	87aa                	mv	a5,a0
    5020355c:	fcf42e23          	sw	a5,-36(s0)
    50203560:	00009697          	auipc	a3,0x9
    50203564:	9b868693          	addi	a3,a3,-1608 # 5020bf18 <pcb>
    50203568:	fdc42703          	lw	a4,-36(s0)
    5020356c:	87ba                	mv	a5,a4
    5020356e:	078e                	slli	a5,a5,0x3
    50203570:	97ba                	add	a5,a5,a4
    50203572:	0792                	slli	a5,a5,0x4
    50203574:	97b6                	add	a5,a5,a3
    50203576:	00009717          	auipc	a4,0x9
    5020357a:	96270713          	addi	a4,a4,-1694 # 5020bed8 <ready_queue>
    5020357e:	e7b8                	sd	a4,72(a5)
    50203580:	00009697          	auipc	a3,0x9
    50203584:	99868693          	addi	a3,a3,-1640 # 5020bf18 <pcb>
    50203588:	fdc42703          	lw	a4,-36(s0)
    5020358c:	87ba                	mv	a5,a4
    5020358e:	078e                	slli	a5,a5,0x3
    50203590:	97ba                	add	a5,a5,a4
    50203592:	0792                	slli	a5,a5,0x4
    50203594:	97b6                	add	a5,a5,a3
    50203596:	470d                	li	a4,3
    50203598:	cff8                	sw	a4,92(a5)
    5020359a:	00009797          	auipc	a5,0x9
    5020359e:	93e78793          	addi	a5,a5,-1730 # 5020bed8 <ready_queue>
    502035a2:	679c                	ld	a5,8(a5)
    502035a4:	fef43423          	sd	a5,-24(s0)
    502035a8:	fdc42703          	lw	a4,-36(s0)
    502035ac:	87ba                	mv	a5,a4
    502035ae:	078e                	slli	a5,a5,0x3
    502035b0:	97ba                	add	a5,a5,a4
    502035b2:	0792                	slli	a5,a5,0x4
    502035b4:	01078713          	addi	a4,a5,16
    502035b8:	00009797          	auipc	a5,0x9
    502035bc:	96078793          	addi	a5,a5,-1696 # 5020bf18 <pcb>
    502035c0:	97ba                	add	a5,a5,a4
    502035c2:	07a1                	addi	a5,a5,8
    502035c4:	fef43023          	sd	a5,-32(s0)
    502035c8:	fe043783          	ld	a5,-32(s0)
    502035cc:	fdc42703          	lw	a4,-36(s0)
    502035d0:	c398                	sw	a4,0(a5)
    502035d2:	fe043783          	ld	a5,-32(s0)
    502035d6:	fe843703          	ld	a4,-24(s0)
    502035da:	e798                	sd	a4,8(a5)
    502035dc:	fe043783          	ld	a5,-32(s0)
    502035e0:	00009717          	auipc	a4,0x9
    502035e4:	8f870713          	addi	a4,a4,-1800 # 5020bed8 <ready_queue>
    502035e8:	eb98                	sd	a4,16(a5)
    502035ea:	fe843783          	ld	a5,-24(s0)
    502035ee:	fe043703          	ld	a4,-32(s0)
    502035f2:	eb98                	sd	a4,16(a5)
    502035f4:	00009797          	auipc	a5,0x9
    502035f8:	8e478793          	addi	a5,a5,-1820 # 5020bed8 <ready_queue>
    502035fc:	fe043703          	ld	a4,-32(s0)
    50203600:	e798                	sd	a4,8(a5)
    50203602:	00009797          	auipc	a5,0x9
    50203606:	8d678793          	addi	a5,a5,-1834 # 5020bed8 <ready_queue>
    5020360a:	439c                	lw	a5,0(a5)
    5020360c:	2785                	addiw	a5,a5,1
    5020360e:	0007871b          	sext.w	a4,a5
    50203612:	00009797          	auipc	a5,0x9
    50203616:	8c678793          	addi	a5,a5,-1850 # 5020bed8 <ready_queue>
    5020361a:	c398                	sw	a4,0(a5)
    5020361c:	0001                	nop
    5020361e:	7422                	ld	s0,40(sp)
    50203620:	6145                	addi	sp,sp,48
    50203622:	8082                	ret

0000000050203624 <do_fork>:
    50203624:	715d                	addi	sp,sp,-80
    50203626:	e486                	sd	ra,72(sp)
    50203628:	e0a2                	sd	s0,64(sp)
    5020362a:	0880                	addi	s0,sp,80
    5020362c:	ef5ff0ef          	jal	ra,50203520 <alloc_new_pcb>
    50203630:	87aa                	mv	a5,a0
    50203632:	fef42623          	sw	a5,-20(s0)
    50203636:	c13fd0ef          	jal	ra,50201248 <get_current_cpu_id>
    5020363a:	87aa                	mv	a5,a0
    5020363c:	fef42423          	sw	a5,-24(s0)
    50203640:	00009717          	auipc	a4,0x9
    50203644:	8b070713          	addi	a4,a4,-1872 # 5020bef0 <current_running>
    50203648:	fe842783          	lw	a5,-24(s0)
    5020364c:	078e                	slli	a5,a5,0x3
    5020364e:	97ba                	add	a5,a5,a4
    50203650:	639c                	ld	a5,0(a5)
    50203652:	6b94                	ld	a3,16(a5)
    50203654:	00009617          	auipc	a2,0x9
    50203658:	8c460613          	addi	a2,a2,-1852 # 5020bf18 <pcb>
    5020365c:	fec42703          	lw	a4,-20(s0)
    50203660:	87ba                	mv	a5,a4
    50203662:	078e                	slli	a5,a5,0x3
    50203664:	97ba                	add	a5,a5,a4
    50203666:	0792                	slli	a5,a5,0x4
    50203668:	97b2                	add	a5,a5,a2
    5020366a:	eb94                	sd	a3,16(a5)
    5020366c:	00009717          	auipc	a4,0x9
    50203670:	88470713          	addi	a4,a4,-1916 # 5020bef0 <current_running>
    50203674:	fe842783          	lw	a5,-24(s0)
    50203678:	078e                	slli	a5,a5,0x3
    5020367a:	97ba                	add	a5,a5,a4
    5020367c:	639c                	ld	a5,0(a5)
    5020367e:	4bf4                	lw	a3,84(a5)
    50203680:	00009617          	auipc	a2,0x9
    50203684:	89860613          	addi	a2,a2,-1896 # 5020bf18 <pcb>
    50203688:	fec42703          	lw	a4,-20(s0)
    5020368c:	87ba                	mv	a5,a4
    5020368e:	078e                	slli	a5,a5,0x3
    50203690:	97ba                	add	a5,a5,a4
    50203692:	0792                	slli	a5,a5,0x4
    50203694:	97b2                	add	a5,a5,a2
    50203696:	cbf4                	sw	a3,84(a5)
    50203698:	00009717          	auipc	a4,0x9
    5020369c:	85870713          	addi	a4,a4,-1960 # 5020bef0 <current_running>
    502036a0:	fe842783          	lw	a5,-24(s0)
    502036a4:	078e                	slli	a5,a5,0x3
    502036a6:	97ba                	add	a5,a5,a4
    502036a8:	639c                	ld	a5,0(a5)
    502036aa:	4fb4                	lw	a3,88(a5)
    502036ac:	00009617          	auipc	a2,0x9
    502036b0:	86c60613          	addi	a2,a2,-1940 # 5020bf18 <pcb>
    502036b4:	fec42703          	lw	a4,-20(s0)
    502036b8:	87ba                	mv	a5,a4
    502036ba:	078e                	slli	a5,a5,0x3
    502036bc:	97ba                	add	a5,a5,a4
    502036be:	0792                	slli	a5,a5,0x4
    502036c0:	97b2                	add	a5,a5,a2
    502036c2:	cfb4                	sw	a3,88(a5)
    502036c4:	00009717          	auipc	a4,0x9
    502036c8:	82c70713          	addi	a4,a4,-2004 # 5020bef0 <current_running>
    502036cc:	fe842783          	lw	a5,-24(s0)
    502036d0:	078e                	slli	a5,a5,0x3
    502036d2:	97ba                	add	a5,a5,a4
    502036d4:	639c                	ld	a5,0(a5)
    502036d6:	0887a683          	lw	a3,136(a5)
    502036da:	00009617          	auipc	a2,0x9
    502036de:	83e60613          	addi	a2,a2,-1986 # 5020bf18 <pcb>
    502036e2:	fec42703          	lw	a4,-20(s0)
    502036e6:	87ba                	mv	a5,a4
    502036e8:	078e                	slli	a5,a5,0x3
    502036ea:	97ba                	add	a5,a5,a4
    502036ec:	0792                	slli	a5,a5,0x4
    502036ee:	97b2                	add	a5,a5,a2
    502036f0:	08d7a423          	sw	a3,136(a5)
    502036f4:	00008717          	auipc	a4,0x8
    502036f8:	7fc70713          	addi	a4,a4,2044 # 5020bef0 <current_running>
    502036fc:	fe842783          	lw	a5,-24(s0)
    50203700:	078e                	slli	a5,a5,0x3
    50203702:	97ba                	add	a5,a5,a4
    50203704:	639c                	ld	a5,0(a5)
    50203706:	08c7a683          	lw	a3,140(a5)
    5020370a:	00009617          	auipc	a2,0x9
    5020370e:	80e60613          	addi	a2,a2,-2034 # 5020bf18 <pcb>
    50203712:	fec42703          	lw	a4,-20(s0)
    50203716:	87ba                	mv	a5,a4
    50203718:	078e                	slli	a5,a5,0x3
    5020371a:	97ba                	add	a5,a5,a4
    5020371c:	0792                	slli	a5,a5,0x4
    5020371e:	97b2                	add	a5,a5,a2
    50203720:	08d7a623          	sw	a3,140(a5)
    50203724:	00008717          	auipc	a4,0x8
    50203728:	7cc70713          	addi	a4,a4,1996 # 5020bef0 <current_running>
    5020372c:	fe842783          	lw	a5,-24(s0)
    50203730:	078e                	slli	a5,a5,0x3
    50203732:	97ba                	add	a5,a5,a4
    50203734:	639c                	ld	a5,0(a5)
    50203736:	77b4                	ld	a3,104(a5)
    50203738:	00008617          	auipc	a2,0x8
    5020373c:	7e060613          	addi	a2,a2,2016 # 5020bf18 <pcb>
    50203740:	fec42703          	lw	a4,-20(s0)
    50203744:	87ba                	mv	a5,a4
    50203746:	078e                	slli	a5,a5,0x3
    50203748:	97ba                	add	a5,a5,a4
    5020374a:	0792                	slli	a5,a5,0x4
    5020374c:	97b2                	add	a5,a5,a2
    5020374e:	f7b4                	sd	a3,104(a5)
    50203750:	00008717          	auipc	a4,0x8
    50203754:	7a070713          	addi	a4,a4,1952 # 5020bef0 <current_running>
    50203758:	fe842783          	lw	a5,-24(s0)
    5020375c:	078e                	slli	a5,a5,0x3
    5020375e:	97ba                	add	a5,a5,a4
    50203760:	639c                	ld	a5,0(a5)
    50203762:	53b4                	lw	a3,96(a5)
    50203764:	00008617          	auipc	a2,0x8
    50203768:	7b460613          	addi	a2,a2,1972 # 5020bf18 <pcb>
    5020376c:	fec42703          	lw	a4,-20(s0)
    50203770:	87ba                	mv	a5,a4
    50203772:	078e                	slli	a5,a5,0x3
    50203774:	97ba                	add	a5,a5,a4
    50203776:	0792                	slli	a5,a5,0x4
    50203778:	97b2                	add	a5,a5,a2
    5020377a:	d3b4                	sw	a3,96(a5)
    5020377c:	00008717          	auipc	a4,0x8
    50203780:	77470713          	addi	a4,a4,1908 # 5020bef0 <current_running>
    50203784:	fe842783          	lw	a5,-24(s0)
    50203788:	078e                	slli	a5,a5,0x3
    5020378a:	97ba                	add	a5,a5,a4
    5020378c:	639c                	ld	a5,0(a5)
    5020378e:	7fbc                	ld	a5,120(a5)
    50203790:	0007871b          	sext.w	a4,a5
    50203794:	00008697          	auipc	a3,0x8
    50203798:	75c68693          	addi	a3,a3,1884 # 5020bef0 <current_running>
    5020379c:	fe842783          	lw	a5,-24(s0)
    502037a0:	078e                	slli	a5,a5,0x3
    502037a2:	97b6                	add	a5,a5,a3
    502037a4:	639c                	ld	a5,0(a5)
    502037a6:	639c                	ld	a5,0(a5)
    502037a8:	2781                	sext.w	a5,a5
    502037aa:	40f707bb          	subw	a5,a4,a5
    502037ae:	2781                	sext.w	a5,a5
    502037b0:	fef42223          	sw	a5,-28(s0)
    502037b4:	00008717          	auipc	a4,0x8
    502037b8:	73c70713          	addi	a4,a4,1852 # 5020bef0 <current_running>
    502037bc:	fe842783          	lw	a5,-24(s0)
    502037c0:	078e                	slli	a5,a5,0x3
    502037c2:	97ba                	add	a5,a5,a4
    502037c4:	639c                	ld	a5,0(a5)
    502037c6:	63dc                	ld	a5,128(a5)
    502037c8:	0007871b          	sext.w	a4,a5
    502037cc:	00008697          	auipc	a3,0x8
    502037d0:	72468693          	addi	a3,a3,1828 # 5020bef0 <current_running>
    502037d4:	fe842783          	lw	a5,-24(s0)
    502037d8:	078e                	slli	a5,a5,0x3
    502037da:	97b6                	add	a5,a5,a3
    502037dc:	639c                	ld	a5,0(a5)
    502037de:	679c                	ld	a5,8(a5)
    502037e0:	2781                	sext.w	a5,a5
    502037e2:	40f707bb          	subw	a5,a4,a5
    502037e6:	2781                	sext.w	a5,a5
    502037e8:	fef42023          	sw	a5,-32(s0)
    502037ec:	00008697          	auipc	a3,0x8
    502037f0:	72c68693          	addi	a3,a3,1836 # 5020bf18 <pcb>
    502037f4:	fec42703          	lw	a4,-20(s0)
    502037f8:	87ba                	mv	a5,a4
    502037fa:	078e                	slli	a5,a5,0x3
    502037fc:	97ba                	add	a5,a5,a4
    502037fe:	0792                	slli	a5,a5,0x4
    50203800:	97b6                	add	a5,a5,a3
    50203802:	7fb8                	ld	a4,120(a5)
    50203804:	fe442783          	lw	a5,-28(s0)
    50203808:	40f707b3          	sub	a5,a4,a5
    5020380c:	fcf43c23          	sd	a5,-40(s0)
    50203810:	00008697          	auipc	a3,0x8
    50203814:	70868693          	addi	a3,a3,1800 # 5020bf18 <pcb>
    50203818:	fec42703          	lw	a4,-20(s0)
    5020381c:	87ba                	mv	a5,a4
    5020381e:	078e                	slli	a5,a5,0x3
    50203820:	97ba                	add	a5,a5,a4
    50203822:	0792                	slli	a5,a5,0x4
    50203824:	97b6                	add	a5,a5,a3
    50203826:	63d8                	ld	a4,128(a5)
    50203828:	fe042783          	lw	a5,-32(s0)
    5020382c:	40f707b3          	sub	a5,a4,a5
    50203830:	fcf43823          	sd	a5,-48(s0)
    50203834:	00008717          	auipc	a4,0x8
    50203838:	6bc70713          	addi	a4,a4,1724 # 5020bef0 <current_running>
    5020383c:	fe842783          	lw	a5,-24(s0)
    50203840:	078e                	slli	a5,a5,0x3
    50203842:	97ba                	add	a5,a5,a4
    50203844:	639c                	ld	a5,0(a5)
    50203846:	639c                	ld	a5,0(a5)
    50203848:	fe442703          	lw	a4,-28(s0)
    5020384c:	863a                	mv	a2,a4
    5020384e:	85be                	mv	a1,a5
    50203850:	fd843503          	ld	a0,-40(s0)
    50203854:	08d010ef          	jal	ra,502050e0 <kmemcpy>
    50203858:	00008717          	auipc	a4,0x8
    5020385c:	69870713          	addi	a4,a4,1688 # 5020bef0 <current_running>
    50203860:	fe842783          	lw	a5,-24(s0)
    50203864:	078e                	slli	a5,a5,0x3
    50203866:	97ba                	add	a5,a5,a4
    50203868:	639c                	ld	a5,0(a5)
    5020386a:	679c                	ld	a5,8(a5)
    5020386c:	fe042703          	lw	a4,-32(s0)
    50203870:	863a                	mv	a2,a4
    50203872:	85be                	mv	a1,a5
    50203874:	fd043503          	ld	a0,-48(s0)
    50203878:	069010ef          	jal	ra,502050e0 <kmemcpy>
    5020387c:	fd843783          	ld	a5,-40(s0)
    50203880:	fcf43423          	sd	a5,-56(s0)
    50203884:	fc843783          	ld	a5,-56(s0)
    50203888:	fcf43023          	sd	a5,-64(s0)
    5020388c:	fc043783          	ld	a5,-64(s0)
    50203890:	05078793          	addi	a5,a5,80
    50203894:	0007b023          	sd	zero,0(a5)
    50203898:	fc043783          	ld	a5,-64(s0)
    5020389c:	07c1                	addi	a5,a5,16
    5020389e:	fd043703          	ld	a4,-48(s0)
    502038a2:	e398                	sd	a4,0(a5)
    502038a4:	fc043783          	ld	a5,-64(s0)
    502038a8:	04078793          	addi	a5,a5,64
    502038ac:	6398                	ld	a4,0(a5)
    502038ae:	00008697          	auipc	a3,0x8
    502038b2:	64268693          	addi	a3,a3,1602 # 5020bef0 <current_running>
    502038b6:	fe842783          	lw	a5,-24(s0)
    502038ba:	078e                	slli	a5,a5,0x3
    502038bc:	97b6                	add	a5,a5,a3
    502038be:	639c                	ld	a5,0(a5)
    502038c0:	679c                	ld	a5,8(a5)
    502038c2:	40f706b3          	sub	a3,a4,a5
    502038c6:	fc043783          	ld	a5,-64(s0)
    502038ca:	04078793          	addi	a5,a5,64
    502038ce:	fd043703          	ld	a4,-48(s0)
    502038d2:	9736                	add	a4,a4,a3
    502038d4:	e398                	sd	a4,0(a5)
    502038d6:	fd843783          	ld	a5,-40(s0)
    502038da:	f9078793          	addi	a5,a5,-112
    502038de:	fcf43c23          	sd	a5,-40(s0)
    502038e2:	fd843783          	ld	a5,-40(s0)
    502038e6:	faf43c23          	sd	a5,-72(s0)
    502038ea:	fb843783          	ld	a5,-72(s0)
    502038ee:	faf43823          	sd	a5,-80(s0)
    502038f2:	fc043783          	ld	a5,-64(s0)
    502038f6:	6798                	ld	a4,8(a5)
    502038f8:	fb043783          	ld	a5,-80(s0)
    502038fc:	e398                	sd	a4,0(a5)
    502038fe:	fb043783          	ld	a5,-80(s0)
    50203902:	07a1                	addi	a5,a5,8
    50203904:	fd043703          	ld	a4,-48(s0)
    50203908:	e398                	sd	a4,0(a5)
    5020390a:	fb043783          	ld	a5,-80(s0)
    5020390e:	07c1                	addi	a5,a5,16
    50203910:	fc043703          	ld	a4,-64(s0)
    50203914:	6338                	ld	a4,64(a4)
    50203916:	e398                	sd	a4,0(a5)
    50203918:	fb043783          	ld	a5,-80(s0)
    5020391c:	07e1                	addi	a5,a5,24
    5020391e:	fc043703          	ld	a4,-64(s0)
    50203922:	6738                	ld	a4,72(a4)
    50203924:	e398                	sd	a4,0(a5)
    50203926:	fb043783          	ld	a5,-80(s0)
    5020392a:	02078793          	addi	a5,a5,32
    5020392e:	fc043703          	ld	a4,-64(s0)
    50203932:	6b58                	ld	a4,144(a4)
    50203934:	e398                	sd	a4,0(a5)
    50203936:	fb043783          	ld	a5,-80(s0)
    5020393a:	02878793          	addi	a5,a5,40
    5020393e:	fc043703          	ld	a4,-64(s0)
    50203942:	6f58                	ld	a4,152(a4)
    50203944:	e398                	sd	a4,0(a5)
    50203946:	fb043783          	ld	a5,-80(s0)
    5020394a:	03078793          	addi	a5,a5,48
    5020394e:	fc043703          	ld	a4,-64(s0)
    50203952:	7358                	ld	a4,160(a4)
    50203954:	e398                	sd	a4,0(a5)
    50203956:	fb043783          	ld	a5,-80(s0)
    5020395a:	03878793          	addi	a5,a5,56
    5020395e:	fc043703          	ld	a4,-64(s0)
    50203962:	7758                	ld	a4,168(a4)
    50203964:	e398                	sd	a4,0(a5)
    50203966:	fb043783          	ld	a5,-80(s0)
    5020396a:	04078793          	addi	a5,a5,64
    5020396e:	fc043703          	ld	a4,-64(s0)
    50203972:	7b58                	ld	a4,176(a4)
    50203974:	e398                	sd	a4,0(a5)
    50203976:	fb043783          	ld	a5,-80(s0)
    5020397a:	04878793          	addi	a5,a5,72
    5020397e:	fc043703          	ld	a4,-64(s0)
    50203982:	7f58                	ld	a4,184(a4)
    50203984:	e398                	sd	a4,0(a5)
    50203986:	fb043783          	ld	a5,-80(s0)
    5020398a:	05078793          	addi	a5,a5,80
    5020398e:	fc043703          	ld	a4,-64(s0)
    50203992:	6378                	ld	a4,192(a4)
    50203994:	e398                	sd	a4,0(a5)
    50203996:	fb043783          	ld	a5,-80(s0)
    5020399a:	05878793          	addi	a5,a5,88
    5020399e:	fc043703          	ld	a4,-64(s0)
    502039a2:	6778                	ld	a4,200(a4)
    502039a4:	e398                	sd	a4,0(a5)
    502039a6:	fb043783          	ld	a5,-80(s0)
    502039aa:	06078793          	addi	a5,a5,96
    502039ae:	fc043703          	ld	a4,-64(s0)
    502039b2:	6b78                	ld	a4,208(a4)
    502039b4:	e398                	sd	a4,0(a5)
    502039b6:	fb043783          	ld	a5,-80(s0)
    502039ba:	06878793          	addi	a5,a5,104
    502039be:	fc043703          	ld	a4,-64(s0)
    502039c2:	6f78                	ld	a4,216(a4)
    502039c4:	e398                	sd	a4,0(a5)
    502039c6:	00008697          	auipc	a3,0x8
    502039ca:	55268693          	addi	a3,a3,1362 # 5020bf18 <pcb>
    502039ce:	fec42703          	lw	a4,-20(s0)
    502039d2:	87ba                	mv	a5,a4
    502039d4:	078e                	slli	a5,a5,0x3
    502039d6:	97ba                	add	a5,a5,a4
    502039d8:	0792                	slli	a5,a5,0x4
    502039da:	97b6                	add	a5,a5,a3
    502039dc:	fd843703          	ld	a4,-40(s0)
    502039e0:	e398                	sd	a4,0(a5)
    502039e2:	00008697          	auipc	a3,0x8
    502039e6:	53668693          	addi	a3,a3,1334 # 5020bf18 <pcb>
    502039ea:	fec42703          	lw	a4,-20(s0)
    502039ee:	87ba                	mv	a5,a4
    502039f0:	078e                	slli	a5,a5,0x3
    502039f2:	97ba                	add	a5,a5,a4
    502039f4:	0792                	slli	a5,a5,0x4
    502039f6:	97b6                	add	a5,a5,a3
    502039f8:	fd043703          	ld	a4,-48(s0)
    502039fc:	e798                	sd	a4,8(a5)
    502039fe:	fec42783          	lw	a5,-20(s0)
    50203a02:	853e                	mv	a0,a5
    50203a04:	b51ff0ef          	jal	ra,50203554 <set_pcb_ready>
    50203a08:	82818793          	addi	a5,gp,-2008 # 50209688 <process_id>
    50203a0c:	439c                	lw	a5,0(a5)
    50203a0e:	0017871b          	addiw	a4,a5,1
    50203a12:	0007069b          	sext.w	a3,a4
    50203a16:	82818713          	addi	a4,gp,-2008 # 50209688 <process_id>
    50203a1a:	c314                	sw	a3,0(a4)
    50203a1c:	853e                	mv	a0,a5
    50203a1e:	60a6                	ld	ra,72(sp)
    50203a20:	6406                	ld	s0,64(sp)
    50203a22:	6161                	addi	sp,sp,80
    50203a24:	8082                	ret

0000000050203a26 <do_prior>:
    50203a26:	7179                	addi	sp,sp,-48
    50203a28:	f406                	sd	ra,40(sp)
    50203a2a:	f022                	sd	s0,32(sp)
    50203a2c:	1800                	addi	s0,sp,48
    50203a2e:	87aa                	mv	a5,a0
    50203a30:	fcf42e23          	sw	a5,-36(s0)
    50203a34:	815fd0ef          	jal	ra,50201248 <get_current_cpu_id>
    50203a38:	87aa                	mv	a5,a0
    50203a3a:	fef42623          	sw	a5,-20(s0)
    50203a3e:	fdc42783          	lw	a5,-36(s0)
    50203a42:	2785                	addiw	a5,a5,1
    50203a44:	0007871b          	sext.w	a4,a5
    50203a48:	000257b7          	lui	a5,0x25
    50203a4c:	9f07879b          	addiw	a5,a5,-1552
    50203a50:	02f707bb          	mulw	a5,a4,a5
    50203a54:	2781                	sext.w	a5,a5
    50203a56:	863e                	mv	a2,a5
    50203a58:	82018793          	addi	a5,gp,-2016 # 50209680 <timer>
    50203a5c:	6398                	ld	a4,0(a5)
    50203a5e:	00008697          	auipc	a3,0x8
    50203a62:	49268693          	addi	a3,a3,1170 # 5020bef0 <current_running>
    50203a66:	fec42783          	lw	a5,-20(s0)
    50203a6a:	078e                	slli	a5,a5,0x3
    50203a6c:	97b6                	add	a5,a5,a3
    50203a6e:	639c                	ld	a5,0(a5)
    50203a70:	9732                	add	a4,a4,a2
    50203a72:	fbb8                	sd	a4,112(a5)
    50203a74:	0001                	nop
    50203a76:	70a2                	ld	ra,40(sp)
    50203a78:	7402                	ld	s0,32(sp)
    50203a7a:	6145                	addi	sp,sp,48
    50203a7c:	8082                	ret

0000000050203a7e <do_spawn>:
    50203a7e:	715d                	addi	sp,sp,-80
    50203a80:	e486                	sd	ra,72(sp)
    50203a82:	e0a2                	sd	s0,64(sp)
    50203a84:	0880                	addi	s0,sp,80
    50203a86:	fca43423          	sd	a0,-56(s0)
    50203a8a:	fcb43023          	sd	a1,-64(s0)
    50203a8e:	87b2                	mv	a5,a2
    50203a90:	faf42e23          	sw	a5,-68(s0)
    50203a94:	a8dff0ef          	jal	ra,50203520 <alloc_new_pcb>
    50203a98:	87aa                	mv	a5,a0
    50203a9a:	fef42623          	sw	a5,-20(s0)
    50203a9e:	fec42783          	lw	a5,-20(s0)
    50203aa2:	2781                	sext.w	a5,a5
    50203aa4:	0007d463          	bgez	a5,50203aac <do_spawn+0x2e>
    50203aa8:	57fd                	li	a5,-1
    50203aaa:	a261                	j	50203c32 <do_spawn+0x1b4>
    50203aac:	f9cfd0ef          	jal	ra,50201248 <get_current_cpu_id>
    50203ab0:	87aa                	mv	a5,a0
    50203ab2:	fef42423          	sw	a5,-24(s0)
    50203ab6:	00008697          	auipc	a3,0x8
    50203aba:	46268693          	addi	a3,a3,1122 # 5020bf18 <pcb>
    50203abe:	fec42703          	lw	a4,-20(s0)
    50203ac2:	87ba                	mv	a5,a4
    50203ac4:	078e                	slli	a5,a5,0x3
    50203ac6:	97ba                	add	a5,a5,a4
    50203ac8:	0792                	slli	a5,a5,0x4
    50203aca:	97b6                	add	a5,a5,a3
    50203acc:	0007b823          	sd	zero,16(a5) # 25010 <_start-0x501dbff0>
    50203ad0:	fc843783          	ld	a5,-56(s0)
    50203ad4:	4794                	lw	a3,8(a5)
    50203ad6:	00008617          	auipc	a2,0x8
    50203ada:	44260613          	addi	a2,a2,1090 # 5020bf18 <pcb>
    50203ade:	fec42703          	lw	a4,-20(s0)
    50203ae2:	87ba                	mv	a5,a4
    50203ae4:	078e                	slli	a5,a5,0x3
    50203ae6:	97ba                	add	a5,a5,a4
    50203ae8:	0792                	slli	a5,a5,0x4
    50203aea:	97b2                	add	a5,a5,a2
    50203aec:	cfb4                	sw	a3,88(a5)
    50203aee:	00008697          	auipc	a3,0x8
    50203af2:	42a68693          	addi	a3,a3,1066 # 5020bf18 <pcb>
    50203af6:	fec42703          	lw	a4,-20(s0)
    50203afa:	87ba                	mv	a5,a4
    50203afc:	078e                	slli	a5,a5,0x3
    50203afe:	97ba                	add	a5,a5,a4
    50203b00:	0792                	slli	a5,a5,0x4
    50203b02:	97b6                	add	a5,a5,a3
    50203b04:	0807a423          	sw	zero,136(a5)
    50203b08:	00008697          	auipc	a3,0x8
    50203b0c:	41068693          	addi	a3,a3,1040 # 5020bf18 <pcb>
    50203b10:	fec42703          	lw	a4,-20(s0)
    50203b14:	87ba                	mv	a5,a4
    50203b16:	078e                	slli	a5,a5,0x3
    50203b18:	97ba                	add	a5,a5,a4
    50203b1a:	0792                	slli	a5,a5,0x4
    50203b1c:	97b6                	add	a5,a5,a3
    50203b1e:	0807a623          	sw	zero,140(a5)
    50203b22:	00008697          	auipc	a3,0x8
    50203b26:	3f668693          	addi	a3,a3,1014 # 5020bf18 <pcb>
    50203b2a:	fec42703          	lw	a4,-20(s0)
    50203b2e:	87ba                	mv	a5,a4
    50203b30:	078e                	slli	a5,a5,0x3
    50203b32:	97ba                	add	a5,a5,a4
    50203b34:	0792                	slli	a5,a5,0x4
    50203b36:	97b6                	add	a5,a5,a3
    50203b38:	0607b423          	sd	zero,104(a5)
    50203b3c:	00008697          	auipc	a3,0x8
    50203b40:	3dc68693          	addi	a3,a3,988 # 5020bf18 <pcb>
    50203b44:	fec42703          	lw	a4,-20(s0)
    50203b48:	87ba                	mv	a5,a4
    50203b4a:	078e                	slli	a5,a5,0x3
    50203b4c:	97ba                	add	a5,a5,a4
    50203b4e:	0792                	slli	a5,a5,0x4
    50203b50:	97b6                	add	a5,a5,a3
    50203b52:	fbc42703          	lw	a4,-68(s0)
    50203b56:	d3b8                	sw	a4,96(a5)
    50203b58:	00008717          	auipc	a4,0x8
    50203b5c:	39870713          	addi	a4,a4,920 # 5020bef0 <current_running>
    50203b60:	fe842783          	lw	a5,-24(s0)
    50203b64:	078e                	slli	a5,a5,0x3
    50203b66:	97ba                	add	a5,a5,a4
    50203b68:	639c                	ld	a5,0(a5)
    50203b6a:	4bf4                	lw	a3,84(a5)
    50203b6c:	00008617          	auipc	a2,0x8
    50203b70:	3ac60613          	addi	a2,a2,940 # 5020bf18 <pcb>
    50203b74:	fec42703          	lw	a4,-20(s0)
    50203b78:	87ba                	mv	a5,a4
    50203b7a:	078e                	slli	a5,a5,0x3
    50203b7c:	97ba                	add	a5,a5,a4
    50203b7e:	0792                	slli	a5,a5,0x4
    50203b80:	97b2                	add	a5,a5,a2
    50203b82:	cbf4                	sw	a3,84(a5)
    50203b84:	00008697          	auipc	a3,0x8
    50203b88:	39468693          	addi	a3,a3,916 # 5020bf18 <pcb>
    50203b8c:	fec42703          	lw	a4,-20(s0)
    50203b90:	87ba                	mv	a5,a4
    50203b92:	078e                	slli	a5,a5,0x3
    50203b94:	97ba                	add	a5,a5,a4
    50203b96:	0792                	slli	a5,a5,0x4
    50203b98:	97b6                	add	a5,a5,a3
    50203b9a:	7fa8                	ld	a0,120(a5)
    50203b9c:	00008697          	auipc	a3,0x8
    50203ba0:	37c68693          	addi	a3,a3,892 # 5020bf18 <pcb>
    50203ba4:	fec42703          	lw	a4,-20(s0)
    50203ba8:	87ba                	mv	a5,a4
    50203baa:	078e                	slli	a5,a5,0x3
    50203bac:	97ba                	add	a5,a5,a4
    50203bae:	0792                	slli	a5,a5,0x4
    50203bb0:	97b6                	add	a5,a5,a3
    50203bb2:	63cc                	ld	a1,128(a5)
    50203bb4:	fc843783          	ld	a5,-56(s0)
    50203bb8:	6390                	ld	a2,0(a5)
    50203bba:	fec42703          	lw	a4,-20(s0)
    50203bbe:	87ba                	mv	a5,a4
    50203bc0:	078e                	slli	a5,a5,0x3
    50203bc2:	97ba                	add	a5,a5,a4
    50203bc4:	0792                	slli	a5,a5,0x4
    50203bc6:	00008717          	auipc	a4,0x8
    50203bca:	35270713          	addi	a4,a4,850 # 5020bf18 <pcb>
    50203bce:	97ba                	add	a5,a5,a4
    50203bd0:	86be                	mv	a3,a5
    50203bd2:	f82fd0ef          	jal	ra,50201354 <init_pcb_stack>
    50203bd6:	00008697          	auipc	a3,0x8
    50203bda:	34268693          	addi	a3,a3,834 # 5020bf18 <pcb>
    50203bde:	fec42703          	lw	a4,-20(s0)
    50203be2:	87ba                	mv	a5,a4
    50203be4:	078e                	slli	a5,a5,0x3
    50203be6:	97ba                	add	a5,a5,a4
    50203be8:	0792                	slli	a5,a5,0x4
    50203bea:	97b6                	add	a5,a5,a3
    50203bec:	7fbc                	ld	a5,120(a5)
    50203bee:	ee078793          	addi	a5,a5,-288
    50203bf2:	fef43023          	sd	a5,-32(s0)
    50203bf6:	fe043783          	ld	a5,-32(s0)
    50203bfa:	fcf43c23          	sd	a5,-40(s0)
    50203bfe:	fd843783          	ld	a5,-40(s0)
    50203c02:	fcf43823          	sd	a5,-48(s0)
    50203c06:	fd043783          	ld	a5,-48(s0)
    50203c0a:	05078793          	addi	a5,a5,80
    50203c0e:	fc043703          	ld	a4,-64(s0)
    50203c12:	e398                	sd	a4,0(a5)
    50203c14:	fec42783          	lw	a5,-20(s0)
    50203c18:	853e                	mv	a0,a5
    50203c1a:	93bff0ef          	jal	ra,50203554 <set_pcb_ready>
    50203c1e:	82818793          	addi	a5,gp,-2008 # 50209688 <process_id>
    50203c22:	439c                	lw	a5,0(a5)
    50203c24:	0017871b          	addiw	a4,a5,1
    50203c28:	0007069b          	sext.w	a3,a4
    50203c2c:	82818713          	addi	a4,gp,-2008 # 50209688 <process_id>
    50203c30:	c314                	sw	a3,0(a4)
    50203c32:	853e                	mv	a0,a5
    50203c34:	60a6                	ld	ra,72(sp)
    50203c36:	6406                	ld	s0,64(sp)
    50203c38:	6161                	addi	sp,sp,80
    50203c3a:	8082                	ret

0000000050203c3c <release_wait_list>:
    50203c3c:	7139                	addi	sp,sp,-64
    50203c3e:	fc22                	sd	s0,56(sp)
    50203c40:	0080                	addi	s0,sp,64
    50203c42:	fca43423          	sd	a0,-56(s0)
    50203c46:	fc843783          	ld	a5,-56(s0)
    50203c4a:	679c                	ld	a5,8(a5)
    50203c4c:	fef43023          	sd	a5,-32(s0)
    50203c50:	fc843783          	ld	a5,-56(s0)
    50203c54:	6b9c                	ld	a5,16(a5)
    50203c56:	fcf43c23          	sd	a5,-40(s0)
    50203c5a:	fe043783          	ld	a5,-32(s0)
    50203c5e:	fef43423          	sd	a5,-24(s0)
    50203c62:	a0a9                	j	50203cac <release_wait_list+0x70>
    50203c64:	fe843783          	ld	a5,-24(s0)
    50203c68:	4398                	lw	a4,0(a5)
    50203c6a:	00008697          	auipc	a3,0x8
    50203c6e:	2ae68693          	addi	a3,a3,686 # 5020bf18 <pcb>
    50203c72:	87ba                	mv	a5,a4
    50203c74:	078e                	slli	a5,a5,0x3
    50203c76:	97ba                	add	a5,a5,a4
    50203c78:	0792                	slli	a5,a5,0x4
    50203c7a:	97b6                	add	a5,a5,a3
    50203c7c:	00008717          	auipc	a4,0x8
    50203c80:	25c70713          	addi	a4,a4,604 # 5020bed8 <ready_queue>
    50203c84:	e7b8                	sd	a4,72(a5)
    50203c86:	fe843783          	ld	a5,-24(s0)
    50203c8a:	4398                	lw	a4,0(a5)
    50203c8c:	00008697          	auipc	a3,0x8
    50203c90:	28c68693          	addi	a3,a3,652 # 5020bf18 <pcb>
    50203c94:	87ba                	mv	a5,a4
    50203c96:	078e                	slli	a5,a5,0x3
    50203c98:	97ba                	add	a5,a5,a4
    50203c9a:	0792                	slli	a5,a5,0x4
    50203c9c:	97b6                	add	a5,a5,a3
    50203c9e:	470d                	li	a4,3
    50203ca0:	cff8                	sw	a4,92(a5)
    50203ca2:	fe843783          	ld	a5,-24(s0)
    50203ca6:	679c                	ld	a5,8(a5)
    50203ca8:	fef43423          	sd	a5,-24(s0)
    50203cac:	fe843783          	ld	a5,-24(s0)
    50203cb0:	fbd5                	bnez	a5,50203c64 <release_wait_list+0x28>
    50203cb2:	00008797          	auipc	a5,0x8
    50203cb6:	22678793          	addi	a5,a5,550 # 5020bed8 <ready_queue>
    50203cba:	6b9c                	ld	a5,16(a5)
    50203cbc:	fcf43823          	sd	a5,-48(s0)
    50203cc0:	fd043783          	ld	a5,-48(s0)
    50203cc4:	fe043703          	ld	a4,-32(s0)
    50203cc8:	e798                	sd	a4,8(a5)
    50203cca:	fe043783          	ld	a5,-32(s0)
    50203cce:	fd043703          	ld	a4,-48(s0)
    50203cd2:	eb98                	sd	a4,16(a5)
    50203cd4:	fd843783          	ld	a5,-40(s0)
    50203cd8:	00008717          	auipc	a4,0x8
    50203cdc:	20070713          	addi	a4,a4,512 # 5020bed8 <ready_queue>
    50203ce0:	e798                	sd	a4,8(a5)
    50203ce2:	00008797          	auipc	a5,0x8
    50203ce6:	1f678793          	addi	a5,a5,502 # 5020bed8 <ready_queue>
    50203cea:	fd843703          	ld	a4,-40(s0)
    50203cee:	eb98                	sd	a4,16(a5)
    50203cf0:	00008797          	auipc	a5,0x8
    50203cf4:	1e878793          	addi	a5,a5,488 # 5020bed8 <ready_queue>
    50203cf8:	4398                	lw	a4,0(a5)
    50203cfa:	fc843783          	ld	a5,-56(s0)
    50203cfe:	439c                	lw	a5,0(a5)
    50203d00:	9fb9                	addw	a5,a5,a4
    50203d02:	0007871b          	sext.w	a4,a5
    50203d06:	00008797          	auipc	a5,0x8
    50203d0a:	1d278793          	addi	a5,a5,466 # 5020bed8 <ready_queue>
    50203d0e:	c398                	sw	a4,0(a5)
    50203d10:	fc843783          	ld	a5,-56(s0)
    50203d14:	0007b823          	sd	zero,16(a5)
    50203d18:	fc843783          	ld	a5,-56(s0)
    50203d1c:	0007b423          	sd	zero,8(a5)
    50203d20:	fc843783          	ld	a5,-56(s0)
    50203d24:	0007a023          	sw	zero,0(a5)
    50203d28:	0001                	nop
    50203d2a:	7462                	ld	s0,56(sp)
    50203d2c:	6121                	addi	sp,sp,64
    50203d2e:	8082                	ret

0000000050203d30 <lock_exit>:
    50203d30:	7179                	addi	sp,sp,-48
    50203d32:	f406                	sd	ra,40(sp)
    50203d34:	f022                	sd	s0,32(sp)
    50203d36:	1800                	addi	s0,sp,48
    50203d38:	fca43c23          	sd	a0,-40(s0)
    50203d3c:	fe042623          	sw	zero,-20(s0)
    50203d40:	a0a1                	j	50203d88 <lock_exit+0x58>
    50203d42:	00008697          	auipc	a3,0x8
    50203d46:	a0e68693          	addi	a3,a3,-1522 # 5020b750 <lock_array>
    50203d4a:	fec42703          	lw	a4,-20(s0)
    50203d4e:	87ba                	mv	a5,a4
    50203d50:	078a                	slli	a5,a5,0x2
    50203d52:	97ba                	add	a5,a5,a4
    50203d54:	078e                	slli	a5,a5,0x3
    50203d56:	97b6                	add	a5,a5,a3
    50203d58:	679c                	ld	a5,8(a5)
    50203d5a:	fd843703          	ld	a4,-40(s0)
    50203d5e:	02f71063          	bne	a4,a5,50203d7e <lock_exit+0x4e>
    50203d62:	fec42703          	lw	a4,-20(s0)
    50203d66:	87ba                	mv	a5,a4
    50203d68:	078a                	slli	a5,a5,0x2
    50203d6a:	97ba                	add	a5,a5,a4
    50203d6c:	078e                	slli	a5,a5,0x3
    50203d6e:	00008717          	auipc	a4,0x8
    50203d72:	9e270713          	addi	a4,a4,-1566 # 5020b750 <lock_array>
    50203d76:	97ba                	add	a5,a5,a4
    50203d78:	853e                	mv	a0,a5
    50203d7a:	96aff0ef          	jal	ra,50202ee4 <do_mutex_lock_release>
    50203d7e:	fec42783          	lw	a5,-20(s0)
    50203d82:	2785                	addiw	a5,a5,1
    50203d84:	fef42623          	sw	a5,-20(s0)
    50203d88:	fec42783          	lw	a5,-20(s0)
    50203d8c:	0007871b          	sext.w	a4,a5
    50203d90:	479d                	li	a5,7
    50203d92:	fae7d8e3          	bge	a5,a4,50203d42 <lock_exit+0x12>
    50203d96:	0001                	nop
    50203d98:	0001                	nop
    50203d9a:	70a2                	ld	ra,40(sp)
    50203d9c:	7402                	ld	s0,32(sp)
    50203d9e:	6145                	addi	sp,sp,48
    50203da0:	8082                	ret

0000000050203da2 <do_exit>:
    50203da2:	7179                	addi	sp,sp,-48
    50203da4:	f406                	sd	ra,40(sp)
    50203da6:	f022                	sd	s0,32(sp)
    50203da8:	1800                	addi	s0,sp,48
    50203daa:	c9efd0ef          	jal	ra,50201248 <get_current_cpu_id>
    50203dae:	87aa                	mv	a5,a0
    50203db0:	fef42623          	sw	a5,-20(s0)
    50203db4:	00008717          	auipc	a4,0x8
    50203db8:	13c70713          	addi	a4,a4,316 # 5020bef0 <current_running>
    50203dbc:	fec42783          	lw	a5,-20(s0)
    50203dc0:	078e                	slli	a5,a5,0x3
    50203dc2:	97ba                	add	a5,a5,a4
    50203dc4:	639c                	ld	a5,0(a5)
    50203dc6:	fef43023          	sd	a5,-32(s0)
    50203dca:	fe043783          	ld	a5,-32(s0)
    50203dce:	07e1                	addi	a5,a5,24
    50203dd0:	fcf43c23          	sd	a5,-40(s0)
    50203dd4:	00008717          	auipc	a4,0x8
    50203dd8:	96c70713          	addi	a4,a4,-1684 # 5020b740 <cpu_pcb_pointer>
    50203ddc:	fec42783          	lw	a5,-20(s0)
    50203de0:	078e                	slli	a5,a5,0x3
    50203de2:	97ba                	add	a5,a5,a4
    50203de4:	639c                	ld	a5,0(a5)
    50203de6:	86be                	mv	a3,a5
    50203de8:	00008717          	auipc	a4,0x8
    50203dec:	10870713          	addi	a4,a4,264 # 5020bef0 <current_running>
    50203df0:	fec42783          	lw	a5,-20(s0)
    50203df4:	078e                	slli	a5,a5,0x3
    50203df6:	97ba                	add	a5,a5,a4
    50203df8:	e394                	sd	a3,0(a5)
    50203dfa:	fe043783          	ld	a5,-32(s0)
    50203dfe:	7fb8                	ld	a4,120(a5)
    50203e00:	fe043783          	ld	a5,-32(s0)
    50203e04:	e398                	sd	a4,0(a5)
    50203e06:	fe043783          	ld	a5,-32(s0)
    50203e0a:	63d8                	ld	a4,128(a5)
    50203e0c:	fe043783          	ld	a5,-32(s0)
    50203e10:	e798                	sd	a4,8(a5)
    50203e12:	00008717          	auipc	a4,0x8
    50203e16:	0de70713          	addi	a4,a4,222 # 5020bef0 <current_running>
    50203e1a:	fec42783          	lw	a5,-20(s0)
    50203e1e:	078e                	slli	a5,a5,0x3
    50203e20:	97ba                	add	a5,a5,a4
    50203e22:	6398                	ld	a4,0(a5)
    50203e24:	00008697          	auipc	a3,0x8
    50203e28:	0cc68693          	addi	a3,a3,204 # 5020bef0 <current_running>
    50203e2c:	fec42783          	lw	a5,-20(s0)
    50203e30:	078e                	slli	a5,a5,0x3
    50203e32:	97b6                	add	a5,a5,a3
    50203e34:	639c                	ld	a5,0(a5)
    50203e36:	7f38                	ld	a4,120(a4)
    50203e38:	e398                	sd	a4,0(a5)
    50203e3a:	fe043783          	ld	a5,-32(s0)
    50203e3e:	5b9c                	lw	a5,48(a5)
    50203e40:	04f05163          	blez	a5,50203e82 <do_exit+0xe0>
    50203e44:	fe043783          	ld	a5,-32(s0)
    50203e48:	03078793          	addi	a5,a5,48
    50203e4c:	853e                	mv	a0,a5
    50203e4e:	defff0ef          	jal	ra,50203c3c <release_wait_list>
    50203e52:	fe043783          	ld	a5,-32(s0)
    50203e56:	0407ae23          	sw	zero,92(a5)
    50203e5a:	fe043783          	ld	a5,-32(s0)
    50203e5e:	00009717          	auipc	a4,0x9
    50203e62:	2d270713          	addi	a4,a4,722 # 5020d130 <exit_queue>
    50203e66:	e7b8                	sd	a4,72(a5)
    50203e68:	00008617          	auipc	a2,0x8
    50203e6c:	07060613          	addi	a2,a2,112 # 5020bed8 <ready_queue>
    50203e70:	00009597          	auipc	a1,0x9
    50203e74:	2c058593          	addi	a1,a1,704 # 5020d130 <exit_queue>
    50203e78:	fd843503          	ld	a0,-40(s0)
    50203e7c:	dd8ff0ef          	jal	ra,50203454 <move_node>
    50203e80:	a0bd                	j	50203eee <do_exit+0x14c>
    50203e82:	fe043783          	ld	a5,-32(s0)
    50203e86:	53bc                	lw	a5,96(a5)
    50203e88:	873e                	mv	a4,a5
    50203e8a:	4785                	li	a5,1
    50203e8c:	02f71a63          	bne	a4,a5,50203ec0 <do_exit+0x11e>
    50203e90:	fe043783          	ld	a5,-32(s0)
    50203e94:	4711                	li	a4,4
    50203e96:	cff8                	sw	a4,92(a5)
    50203e98:	fe043783          	ld	a5,-32(s0)
    50203e9c:	00009717          	auipc	a4,0x9
    50203ea0:	27c70713          	addi	a4,a4,636 # 5020d118 <zombie_queue>
    50203ea4:	e7b8                	sd	a4,72(a5)
    50203ea6:	00008617          	auipc	a2,0x8
    50203eaa:	03260613          	addi	a2,a2,50 # 5020bed8 <ready_queue>
    50203eae:	00009597          	auipc	a1,0x9
    50203eb2:	26a58593          	addi	a1,a1,618 # 5020d118 <zombie_queue>
    50203eb6:	fd843503          	ld	a0,-40(s0)
    50203eba:	d9aff0ef          	jal	ra,50203454 <move_node>
    50203ebe:	a805                	j	50203eee <do_exit+0x14c>
    50203ec0:	fe043783          	ld	a5,-32(s0)
    50203ec4:	0407ae23          	sw	zero,92(a5)
    50203ec8:	fe043783          	ld	a5,-32(s0)
    50203ecc:	00009717          	auipc	a4,0x9
    50203ed0:	26470713          	addi	a4,a4,612 # 5020d130 <exit_queue>
    50203ed4:	e7b8                	sd	a4,72(a5)
    50203ed6:	00008617          	auipc	a2,0x8
    50203eda:	00260613          	addi	a2,a2,2 # 5020bed8 <ready_queue>
    50203ede:	00009597          	auipc	a1,0x9
    50203ee2:	25258593          	addi	a1,a1,594 # 5020d130 <exit_queue>
    50203ee6:	fd843503          	ld	a0,-40(s0)
    50203eea:	d6aff0ef          	jal	ra,50203454 <move_node>
    50203eee:	fe043503          	ld	a0,-32(s0)
    50203ef2:	e3fff0ef          	jal	ra,50203d30 <lock_exit>
    50203ef6:	9d6ff0ef          	jal	ra,502030cc <do_scheduler>
    50203efa:	0001                	nop
    50203efc:	70a2                	ld	ra,40(sp)
    50203efe:	7402                	ld	s0,32(sp)
    50203f00:	6145                	addi	sp,sp,48
    50203f02:	8082                	ret

0000000050203f04 <do_waitpid>:
    50203f04:	7179                	addi	sp,sp,-48
    50203f06:	f406                	sd	ra,40(sp)
    50203f08:	f022                	sd	s0,32(sp)
    50203f0a:	1800                	addi	s0,sp,48
    50203f0c:	87aa                	mv	a5,a0
    50203f0e:	fcf42e23          	sw	a5,-36(s0)
    50203f12:	fe042623          	sw	zero,-20(s0)
    50203f16:	b32fd0ef          	jal	ra,50201248 <get_current_cpu_id>
    50203f1a:	87aa                	mv	a5,a0
    50203f1c:	fef42223          	sw	a5,-28(s0)
    50203f20:	fe042423          	sw	zero,-24(s0)
    50203f24:	a81d                	j	50203f5a <do_waitpid+0x56>
    50203f26:	00008697          	auipc	a3,0x8
    50203f2a:	ff268693          	addi	a3,a3,-14 # 5020bf18 <pcb>
    50203f2e:	fe842703          	lw	a4,-24(s0)
    50203f32:	87ba                	mv	a5,a4
    50203f34:	078e                	slli	a5,a5,0x3
    50203f36:	97ba                	add	a5,a5,a4
    50203f38:	0792                	slli	a5,a5,0x4
    50203f3a:	97b6                	add	a5,a5,a3
    50203f3c:	4bb8                	lw	a4,80(a5)
    50203f3e:	fdc42783          	lw	a5,-36(s0)
    50203f42:	2781                	sext.w	a5,a5
    50203f44:	00e79663          	bne	a5,a4,50203f50 <do_waitpid+0x4c>
    50203f48:	4785                	li	a5,1
    50203f4a:	fef42623          	sw	a5,-20(s0)
    50203f4e:	a829                	j	50203f68 <do_waitpid+0x64>
    50203f50:	fe842783          	lw	a5,-24(s0)
    50203f54:	2785                	addiw	a5,a5,1
    50203f56:	fef42423          	sw	a5,-24(s0)
    50203f5a:	fe842783          	lw	a5,-24(s0)
    50203f5e:	0007871b          	sext.w	a4,a5
    50203f62:	47fd                	li	a5,31
    50203f64:	fce7d1e3          	bge	a5,a4,50203f26 <do_waitpid+0x22>
    50203f68:	fec42783          	lw	a5,-20(s0)
    50203f6c:	2781                	sext.w	a5,a5
    50203f6e:	e399                	bnez	a5,50203f74 <do_waitpid+0x70>
    50203f70:	57fd                	li	a5,-1
    50203f72:	aa39                	j	50204090 <do_waitpid+0x18c>
    50203f74:	00008697          	auipc	a3,0x8
    50203f78:	fa468693          	addi	a3,a3,-92 # 5020bf18 <pcb>
    50203f7c:	fe842703          	lw	a4,-24(s0)
    50203f80:	87ba                	mv	a5,a4
    50203f82:	078e                	slli	a5,a5,0x3
    50203f84:	97ba                	add	a5,a5,a4
    50203f86:	0792                	slli	a5,a5,0x4
    50203f88:	97b6                	add	a5,a5,a3
    50203f8a:	4ffc                	lw	a5,92(a5)
    50203f8c:	e399                	bnez	a5,50203f92 <do_waitpid+0x8e>
    50203f8e:	57f9                	li	a5,-2
    50203f90:	a201                	j	50204090 <do_waitpid+0x18c>
    50203f92:	00008697          	auipc	a3,0x8
    50203f96:	f8668693          	addi	a3,a3,-122 # 5020bf18 <pcb>
    50203f9a:	fe842703          	lw	a4,-24(s0)
    50203f9e:	87ba                	mv	a5,a4
    50203fa0:	078e                	slli	a5,a5,0x3
    50203fa2:	97ba                	add	a5,a5,a4
    50203fa4:	0792                	slli	a5,a5,0x4
    50203fa6:	97b6                	add	a5,a5,a3
    50203fa8:	4ffc                	lw	a5,92(a5)
    50203faa:	873e                	mv	a4,a5
    50203fac:	4791                	li	a5,4
    50203fae:	04f71b63          	bne	a4,a5,50204004 <do_waitpid+0x100>
    50203fb2:	fe842703          	lw	a4,-24(s0)
    50203fb6:	87ba                	mv	a5,a4
    50203fb8:	078e                	slli	a5,a5,0x3
    50203fba:	97ba                	add	a5,a5,a4
    50203fbc:	0792                	slli	a5,a5,0x4
    50203fbe:	01078713          	addi	a4,a5,16
    50203fc2:	00008797          	auipc	a5,0x8
    50203fc6:	f5678793          	addi	a5,a5,-170 # 5020bf18 <pcb>
    50203fca:	97ba                	add	a5,a5,a4
    50203fcc:	07a1                	addi	a5,a5,8
    50203fce:	00009617          	auipc	a2,0x9
    50203fd2:	14a60613          	addi	a2,a2,330 # 5020d118 <zombie_queue>
    50203fd6:	00009597          	auipc	a1,0x9
    50203fda:	15a58593          	addi	a1,a1,346 # 5020d130 <exit_queue>
    50203fde:	853e                	mv	a0,a5
    50203fe0:	c74ff0ef          	jal	ra,50203454 <move_node>
    50203fe4:	00008697          	auipc	a3,0x8
    50203fe8:	f3468693          	addi	a3,a3,-204 # 5020bf18 <pcb>
    50203fec:	fe842703          	lw	a4,-24(s0)
    50203ff0:	87ba                	mv	a5,a4
    50203ff2:	078e                	slli	a5,a5,0x3
    50203ff4:	97ba                	add	a5,a5,a4
    50203ff6:	0792                	slli	a5,a5,0x4
    50203ff8:	97b6                	add	a5,a5,a3
    50203ffa:	0407ae23          	sw	zero,92(a5)
    50203ffe:	fdc42783          	lw	a5,-36(s0)
    50204002:	a079                	j	50204090 <do_waitpid+0x18c>
    50204004:	00008717          	auipc	a4,0x8
    50204008:	eec70713          	addi	a4,a4,-276 # 5020bef0 <current_running>
    5020400c:	fe442783          	lw	a5,-28(s0)
    50204010:	078e                	slli	a5,a5,0x3
    50204012:	97ba                	add	a5,a5,a4
    50204014:	639c                	ld	a5,0(a5)
    50204016:	4705                	li	a4,1
    50204018:	cff8                	sw	a4,92(a5)
    5020401a:	00008717          	auipc	a4,0x8
    5020401e:	ed670713          	addi	a4,a4,-298 # 5020bef0 <current_running>
    50204022:	fe442783          	lw	a5,-28(s0)
    50204026:	078e                	slli	a5,a5,0x3
    50204028:	97ba                	add	a5,a5,a4
    5020402a:	6394                	ld	a3,0(a5)
    5020402c:	fe842703          	lw	a4,-24(s0)
    50204030:	87ba                	mv	a5,a4
    50204032:	078e                	slli	a5,a5,0x3
    50204034:	97ba                	add	a5,a5,a4
    50204036:	0792                	slli	a5,a5,0x4
    50204038:	03078713          	addi	a4,a5,48
    5020403c:	00008797          	auipc	a5,0x8
    50204040:	edc78793          	addi	a5,a5,-292 # 5020bf18 <pcb>
    50204044:	97ba                	add	a5,a5,a4
    50204046:	e6bc                	sd	a5,72(a3)
    50204048:	00008717          	auipc	a4,0x8
    5020404c:	ea870713          	addi	a4,a4,-344 # 5020bef0 <current_running>
    50204050:	fe442783          	lw	a5,-28(s0)
    50204054:	078e                	slli	a5,a5,0x3
    50204056:	97ba                	add	a5,a5,a4
    50204058:	639c                	ld	a5,0(a5)
    5020405a:	01878693          	addi	a3,a5,24
    5020405e:	fe842703          	lw	a4,-24(s0)
    50204062:	87ba                	mv	a5,a4
    50204064:	078e                	slli	a5,a5,0x3
    50204066:	97ba                	add	a5,a5,a4
    50204068:	0792                	slli	a5,a5,0x4
    5020406a:	03078713          	addi	a4,a5,48
    5020406e:	00008797          	auipc	a5,0x8
    50204072:	eaa78793          	addi	a5,a5,-342 # 5020bf18 <pcb>
    50204076:	97ba                	add	a5,a5,a4
    50204078:	00008617          	auipc	a2,0x8
    5020407c:	e6060613          	addi	a2,a2,-416 # 5020bed8 <ready_queue>
    50204080:	85be                	mv	a1,a5
    50204082:	8536                	mv	a0,a3
    50204084:	bd0ff0ef          	jal	ra,50203454 <move_node>
    50204088:	844ff0ef          	jal	ra,502030cc <do_scheduler>
    5020408c:	fdc42783          	lw	a5,-36(s0)
    50204090:	853e                	mv	a0,a5
    50204092:	70a2                	ld	ra,40(sp)
    50204094:	7402                	ld	s0,32(sp)
    50204096:	6145                	addi	sp,sp,48
    50204098:	8082                	ret

000000005020409a <do_kill>:
    5020409a:	7179                	addi	sp,sp,-48
    5020409c:	f406                	sd	ra,40(sp)
    5020409e:	f022                	sd	s0,32(sp)
    502040a0:	1800                	addi	s0,sp,48
    502040a2:	87aa                	mv	a5,a0
    502040a4:	fcf42e23          	sw	a5,-36(s0)
    502040a8:	fe042623          	sw	zero,-20(s0)
    502040ac:	99cfd0ef          	jal	ra,50201248 <get_current_cpu_id>
    502040b0:	87aa                	mv	a5,a0
    502040b2:	fef42223          	sw	a5,-28(s0)
    502040b6:	00008717          	auipc	a4,0x8
    502040ba:	e3a70713          	addi	a4,a4,-454 # 5020bef0 <current_running>
    502040be:	fe442783          	lw	a5,-28(s0)
    502040c2:	078e                	slli	a5,a5,0x3
    502040c4:	97ba                	add	a5,a5,a4
    502040c6:	639c                	ld	a5,0(a5)
    502040c8:	4bb8                	lw	a4,80(a5)
    502040ca:	fdc42783          	lw	a5,-36(s0)
    502040ce:	2781                	sext.w	a5,a5
    502040d0:	00e78d63          	beq	a5,a4,502040ea <do_kill+0x50>
    502040d4:	fdc42783          	lw	a5,-36(s0)
    502040d8:	2781                	sext.w	a5,a5
    502040da:	cb81                	beqz	a5,502040ea <do_kill+0x50>
    502040dc:	fdc42783          	lw	a5,-36(s0)
    502040e0:	0007871b          	sext.w	a4,a5
    502040e4:	4785                	li	a5,1
    502040e6:	00f71463          	bne	a4,a5,502040ee <do_kill+0x54>
    502040ea:	57fd                	li	a5,-1
    502040ec:	a275                	j	50204298 <do_kill+0x1fe>
    502040ee:	fe042423          	sw	zero,-24(s0)
    502040f2:	a81d                	j	50204128 <do_kill+0x8e>
    502040f4:	00008697          	auipc	a3,0x8
    502040f8:	e2468693          	addi	a3,a3,-476 # 5020bf18 <pcb>
    502040fc:	fe842703          	lw	a4,-24(s0)
    50204100:	87ba                	mv	a5,a4
    50204102:	078e                	slli	a5,a5,0x3
    50204104:	97ba                	add	a5,a5,a4
    50204106:	0792                	slli	a5,a5,0x4
    50204108:	97b6                	add	a5,a5,a3
    5020410a:	4bb8                	lw	a4,80(a5)
    5020410c:	fdc42783          	lw	a5,-36(s0)
    50204110:	2781                	sext.w	a5,a5
    50204112:	00e79663          	bne	a5,a4,5020411e <do_kill+0x84>
    50204116:	4785                	li	a5,1
    50204118:	fef42623          	sw	a5,-20(s0)
    5020411c:	a829                	j	50204136 <do_kill+0x9c>
    5020411e:	fe842783          	lw	a5,-24(s0)
    50204122:	2785                	addiw	a5,a5,1
    50204124:	fef42423          	sw	a5,-24(s0)
    50204128:	fe842783          	lw	a5,-24(s0)
    5020412c:	0007871b          	sext.w	a4,a5
    50204130:	47fd                	li	a5,31
    50204132:	fce7d1e3          	bge	a5,a4,502040f4 <do_kill+0x5a>
    50204136:	fec42783          	lw	a5,-20(s0)
    5020413a:	2781                	sext.w	a5,a5
    5020413c:	e399                	bnez	a5,50204142 <do_kill+0xa8>
    5020413e:	4781                	li	a5,0
    50204140:	aaa1                	j	50204298 <do_kill+0x1fe>
    50204142:	00008697          	auipc	a3,0x8
    50204146:	dd668693          	addi	a3,a3,-554 # 5020bf18 <pcb>
    5020414a:	fe842703          	lw	a4,-24(s0)
    5020414e:	87ba                	mv	a5,a4
    50204150:	078e                	slli	a5,a5,0x3
    50204152:	97ba                	add	a5,a5,a4
    50204154:	0792                	slli	a5,a5,0x4
    50204156:	97b6                	add	a5,a5,a3
    50204158:	4ffc                	lw	a5,92(a5)
    5020415a:	e399                	bnez	a5,50204160 <do_kill+0xc6>
    5020415c:	4781                	li	a5,0
    5020415e:	aa2d                	j	50204298 <do_kill+0x1fe>
    50204160:	00008697          	auipc	a3,0x8
    50204164:	db868693          	addi	a3,a3,-584 # 5020bf18 <pcb>
    50204168:	fe842703          	lw	a4,-24(s0)
    5020416c:	87ba                	mv	a5,a4
    5020416e:	078e                	slli	a5,a5,0x3
    50204170:	97ba                	add	a5,a5,a4
    50204172:	0792                	slli	a5,a5,0x4
    50204174:	97b6                	add	a5,a5,a3
    50204176:	5b9c                	lw	a5,48(a5)
    50204178:	02f05263          	blez	a5,5020419c <do_kill+0x102>
    5020417c:	fe842703          	lw	a4,-24(s0)
    50204180:	87ba                	mv	a5,a4
    50204182:	078e                	slli	a5,a5,0x3
    50204184:	97ba                	add	a5,a5,a4
    50204186:	0792                	slli	a5,a5,0x4
    50204188:	03078713          	addi	a4,a5,48
    5020418c:	00008797          	auipc	a5,0x8
    50204190:	d8c78793          	addi	a5,a5,-628 # 5020bf18 <pcb>
    50204194:	97ba                	add	a5,a5,a4
    50204196:	853e                	mv	a0,a5
    50204198:	aa5ff0ef          	jal	ra,50203c3c <release_wait_list>
    5020419c:	fe842703          	lw	a4,-24(s0)
    502041a0:	87ba                	mv	a5,a4
    502041a2:	078e                	slli	a5,a5,0x3
    502041a4:	97ba                	add	a5,a5,a4
    502041a6:	0792                	slli	a5,a5,0x4
    502041a8:	01078713          	addi	a4,a5,16
    502041ac:	00008797          	auipc	a5,0x8
    502041b0:	d6c78793          	addi	a5,a5,-660 # 5020bf18 <pcb>
    502041b4:	97ba                	add	a5,a5,a4
    502041b6:	00878513          	addi	a0,a5,8
    502041ba:	00008697          	auipc	a3,0x8
    502041be:	d5e68693          	addi	a3,a3,-674 # 5020bf18 <pcb>
    502041c2:	fe842703          	lw	a4,-24(s0)
    502041c6:	87ba                	mv	a5,a4
    502041c8:	078e                	slli	a5,a5,0x3
    502041ca:	97ba                	add	a5,a5,a4
    502041cc:	0792                	slli	a5,a5,0x4
    502041ce:	97b6                	add	a5,a5,a3
    502041d0:	67bc                	ld	a5,72(a5)
    502041d2:	863e                	mv	a2,a5
    502041d4:	00009597          	auipc	a1,0x9
    502041d8:	f5c58593          	addi	a1,a1,-164 # 5020d130 <exit_queue>
    502041dc:	a78ff0ef          	jal	ra,50203454 <move_node>
    502041e0:	00008697          	auipc	a3,0x8
    502041e4:	d3868693          	addi	a3,a3,-712 # 5020bf18 <pcb>
    502041e8:	fe842703          	lw	a4,-24(s0)
    502041ec:	87ba                	mv	a5,a4
    502041ee:	078e                	slli	a5,a5,0x3
    502041f0:	97ba                	add	a5,a5,a4
    502041f2:	0792                	slli	a5,a5,0x4
    502041f4:	97b6                	add	a5,a5,a3
    502041f6:	0407ae23          	sw	zero,92(a5)
    502041fa:	00008697          	auipc	a3,0x8
    502041fe:	d1e68693          	addi	a3,a3,-738 # 5020bf18 <pcb>
    50204202:	fe842703          	lw	a4,-24(s0)
    50204206:	87ba                	mv	a5,a4
    50204208:	078e                	slli	a5,a5,0x3
    5020420a:	97ba                	add	a5,a5,a4
    5020420c:	0792                	slli	a5,a5,0x4
    5020420e:	97b6                	add	a5,a5,a3
    50204210:	00009717          	auipc	a4,0x9
    50204214:	f2070713          	addi	a4,a4,-224 # 5020d130 <exit_queue>
    50204218:	e7b8                	sd	a4,72(a5)
    5020421a:	00008697          	auipc	a3,0x8
    5020421e:	cfe68693          	addi	a3,a3,-770 # 5020bf18 <pcb>
    50204222:	fe842703          	lw	a4,-24(s0)
    50204226:	87ba                	mv	a5,a4
    50204228:	078e                	slli	a5,a5,0x3
    5020422a:	97ba                	add	a5,a5,a4
    5020422c:	0792                	slli	a5,a5,0x4
    5020422e:	97b6                	add	a5,a5,a3
    50204230:	7fb4                	ld	a3,120(a5)
    50204232:	00008617          	auipc	a2,0x8
    50204236:	ce660613          	addi	a2,a2,-794 # 5020bf18 <pcb>
    5020423a:	fe842703          	lw	a4,-24(s0)
    5020423e:	87ba                	mv	a5,a4
    50204240:	078e                	slli	a5,a5,0x3
    50204242:	97ba                	add	a5,a5,a4
    50204244:	0792                	slli	a5,a5,0x4
    50204246:	97b2                	add	a5,a5,a2
    50204248:	e394                	sd	a3,0(a5)
    5020424a:	00008697          	auipc	a3,0x8
    5020424e:	cce68693          	addi	a3,a3,-818 # 5020bf18 <pcb>
    50204252:	fe842703          	lw	a4,-24(s0)
    50204256:	87ba                	mv	a5,a4
    50204258:	078e                	slli	a5,a5,0x3
    5020425a:	97ba                	add	a5,a5,a4
    5020425c:	0792                	slli	a5,a5,0x4
    5020425e:	97b6                	add	a5,a5,a3
    50204260:	63d4                	ld	a3,128(a5)
    50204262:	00008617          	auipc	a2,0x8
    50204266:	cb660613          	addi	a2,a2,-842 # 5020bf18 <pcb>
    5020426a:	fe842703          	lw	a4,-24(s0)
    5020426e:	87ba                	mv	a5,a4
    50204270:	078e                	slli	a5,a5,0x3
    50204272:	97ba                	add	a5,a5,a4
    50204274:	0792                	slli	a5,a5,0x4
    50204276:	97b2                	add	a5,a5,a2
    50204278:	e794                	sd	a3,8(a5)
    5020427a:	fe842703          	lw	a4,-24(s0)
    5020427e:	87ba                	mv	a5,a4
    50204280:	078e                	slli	a5,a5,0x3
    50204282:	97ba                	add	a5,a5,a4
    50204284:	0792                	slli	a5,a5,0x4
    50204286:	00008717          	auipc	a4,0x8
    5020428a:	c9270713          	addi	a4,a4,-878 # 5020bf18 <pcb>
    5020428e:	97ba                	add	a5,a5,a4
    50204290:	853e                	mv	a0,a5
    50204292:	a9fff0ef          	jal	ra,50203d30 <lock_exit>
    50204296:	4785                	li	a5,1
    50204298:	853e                	mv	a0,a5
    5020429a:	70a2                	ld	ra,40(sp)
    5020429c:	7402                	ld	s0,32(sp)
    5020429e:	6145                	addi	sp,sp,48
    502042a0:	8082                	ret

00000000502042a2 <do_getpid>:
    502042a2:	1101                	addi	sp,sp,-32
    502042a4:	ec06                	sd	ra,24(sp)
    502042a6:	e822                	sd	s0,16(sp)
    502042a8:	1000                	addi	s0,sp,32
    502042aa:	f9ffc0ef          	jal	ra,50201248 <get_current_cpu_id>
    502042ae:	87aa                	mv	a5,a0
    502042b0:	fef42623          	sw	a5,-20(s0)
    502042b4:	00008717          	auipc	a4,0x8
    502042b8:	c3c70713          	addi	a4,a4,-964 # 5020bef0 <current_running>
    502042bc:	fec42783          	lw	a5,-20(s0)
    502042c0:	078e                	slli	a5,a5,0x3
    502042c2:	97ba                	add	a5,a5,a4
    502042c4:	639c                	ld	a5,0(a5)
    502042c6:	4bbc                	lw	a5,80(a5)
    502042c8:	853e                	mv	a0,a5
    502042ca:	60e2                	ld	ra,24(sp)
    502042cc:	6442                	ld	s0,16(sp)
    502042ce:	6105                	addi	sp,sp,32
    502042d0:	8082                	ret

00000000502042d2 <do_taskset>:
    502042d2:	1101                	addi	sp,sp,-32
    502042d4:	ec22                	sd	s0,24(sp)
    502042d6:	1000                	addi	s0,sp,32
    502042d8:	87aa                	mv	a5,a0
    502042da:	872e                	mv	a4,a1
    502042dc:	fef42623          	sw	a5,-20(s0)
    502042e0:	87ba                	mv	a5,a4
    502042e2:	fef42423          	sw	a5,-24(s0)
    502042e6:	82818793          	addi	a5,gp,-2008 # 50209688 <process_id>
    502042ea:	4398                	lw	a4,0(a5)
    502042ec:	fec42783          	lw	a5,-20(s0)
    502042f0:	2781                	sext.w	a5,a5
    502042f2:	00e7c463          	blt	a5,a4,502042fa <do_taskset+0x28>
    502042f6:	57fd                	li	a5,-1
    502042f8:	a005                	j	50204318 <do_taskset+0x46>
    502042fa:	00008697          	auipc	a3,0x8
    502042fe:	c1e68693          	addi	a3,a3,-994 # 5020bf18 <pcb>
    50204302:	fec42703          	lw	a4,-20(s0)
    50204306:	87ba                	mv	a5,a4
    50204308:	078e                	slli	a5,a5,0x3
    5020430a:	97ba                	add	a5,a5,a4
    5020430c:	0792                	slli	a5,a5,0x4
    5020430e:	97b6                	add	a5,a5,a3
    50204310:	fe842703          	lw	a4,-24(s0)
    50204314:	cbf8                	sw	a4,84(a5)
    50204316:	4785                	li	a5,1
    50204318:	853e                	mv	a0,a5
    5020431a:	6462                	ld	s0,24(sp)
    5020431c:	6105                	addi	sp,sp,32
    5020431e:	8082                	ret

0000000050204320 <get_ticks>:
    50204320:	1141                	addi	sp,sp,-16
    50204322:	e422                	sd	s0,8(sp)
    50204324:	0800                	addi	s0,sp,16
    50204326:	c0102773          	rdtime	a4
    5020432a:	85818793          	addi	a5,gp,-1960 # 502096b8 <time_elapsed>
    5020432e:	e398                	sd	a4,0(a5)
    50204330:	85818793          	addi	a5,gp,-1960 # 502096b8 <time_elapsed>
    50204334:	639c                	ld	a5,0(a5)
    50204336:	853e                	mv	a0,a5
    50204338:	6422                	ld	s0,8(sp)
    5020433a:	0141                	addi	sp,sp,16
    5020433c:	8082                	ret

000000005020433e <get_timer>:
    5020433e:	1141                	addi	sp,sp,-16
    50204340:	e406                	sd	ra,8(sp)
    50204342:	e022                	sd	s0,0(sp)
    50204344:	0800                	addi	s0,sp,16
    50204346:	fdbff0ef          	jal	ra,50204320 <get_ticks>
    5020434a:	872a                	mv	a4,a0
    5020434c:	86018793          	addi	a5,gp,-1952 # 502096c0 <time_base>
    50204350:	439c                	lw	a5,0(a5)
    50204352:	1782                	slli	a5,a5,0x20
    50204354:	9381                	srli	a5,a5,0x20
    50204356:	02f757b3          	divu	a5,a4,a5
    5020435a:	853e                	mv	a0,a5
    5020435c:	60a2                	ld	ra,8(sp)
    5020435e:	6402                	ld	s0,0(sp)
    50204360:	0141                	addi	sp,sp,16
    50204362:	8082                	ret

0000000050204364 <get_time_base>:
    50204364:	1141                	addi	sp,sp,-16
    50204366:	e422                	sd	s0,8(sp)
    50204368:	0800                	addi	s0,sp,16
    5020436a:	86018793          	addi	a5,gp,-1952 # 502096c0 <time_base>
    5020436e:	439c                	lw	a5,0(a5)
    50204370:	1782                	slli	a5,a5,0x20
    50204372:	9381                	srli	a5,a5,0x20
    50204374:	853e                	mv	a0,a5
    50204376:	6422                	ld	s0,8(sp)
    50204378:	0141                	addi	sp,sp,16
    5020437a:	8082                	ret

000000005020437c <latency>:
    5020437c:	7179                	addi	sp,sp,-48
    5020437e:	f406                	sd	ra,40(sp)
    50204380:	f022                	sd	s0,32(sp)
    50204382:	1800                	addi	s0,sp,48
    50204384:	fca43c23          	sd	a0,-40(s0)
    50204388:	fb7ff0ef          	jal	ra,5020433e <get_timer>
    5020438c:	fea43423          	sd	a0,-24(s0)
    50204390:	0001                	nop
    50204392:	fadff0ef          	jal	ra,5020433e <get_timer>
    50204396:	872a                	mv	a4,a0
    50204398:	fe843783          	ld	a5,-24(s0)
    5020439c:	40f707b3          	sub	a5,a4,a5
    502043a0:	fd843703          	ld	a4,-40(s0)
    502043a4:	fee7e7e3          	bltu	a5,a4,50204392 <latency+0x16>
    502043a8:	0001                	nop
    502043aa:	70a2                	ld	ra,40(sp)
    502043ac:	7402                	ld	s0,32(sp)
    502043ae:	6145                	addi	sp,sp,48
    502043b0:	8082                	ret

00000000502043b2 <get_walltime>:
    502043b2:	1101                	addi	sp,sp,-32
    502043b4:	ec06                	sd	ra,24(sp)
    502043b6:	e822                	sd	s0,16(sp)
    502043b8:	1000                	addi	s0,sp,32
    502043ba:	fea43423          	sd	a0,-24(s0)
    502043be:	f63ff0ef          	jal	ra,50204320 <get_ticks>
    502043c2:	87aa                	mv	a5,a0
    502043c4:	0007871b          	sext.w	a4,a5
    502043c8:	fe843783          	ld	a5,-24(s0)
    502043cc:	c398                	sw	a4,0(a5)
    502043ce:	86018793          	addi	a5,gp,-1952 # 502096c0 <time_base>
    502043d2:	439c                	lw	a5,0(a5)
    502043d4:	853e                	mv	a0,a5
    502043d6:	60e2                	ld	ra,24(sp)
    502043d8:	6442                	ld	s0,16(sp)
    502043da:	6105                	addi	sp,sp,32
    502043dc:	8082                	ret

00000000502043de <do_barrier_init>:
    502043de:	7179                	addi	sp,sp,-48
    502043e0:	f422                	sd	s0,40(sp)
    502043e2:	1800                	addi	s0,sp,48
    502043e4:	fea43423          	sd	a0,-24(s0)
    502043e8:	87ae                	mv	a5,a1
    502043ea:	fcc43c23          	sd	a2,-40(s0)
    502043ee:	fef42223          	sw	a5,-28(s0)
    502043f2:	86418793          	addi	a5,gp,-1948 # 502096c4 <barrier_num>
    502043f6:	439c                	lw	a5,0(a5)
    502043f8:	00007717          	auipc	a4,0x7
    502043fc:	49870713          	addi	a4,a4,1176 # 5020b890 <barrier_array>
    50204400:	0796                	slli	a5,a5,0x5
    50204402:	97ba                	add	a5,a5,a4
    50204404:	4705                	li	a4,1
    50204406:	c398                	sw	a4,0(a5)
    50204408:	86418793          	addi	a5,gp,-1948 # 502096c4 <barrier_num>
    5020440c:	439c                	lw	a5,0(a5)
    5020440e:	fe442703          	lw	a4,-28(s0)
    50204412:	00007697          	auipc	a3,0x7
    50204416:	47e68693          	addi	a3,a3,1150 # 5020b890 <barrier_array>
    5020441a:	0796                	slli	a5,a5,0x5
    5020441c:	97b6                	add	a5,a5,a3
    5020441e:	c3d8                	sw	a4,4(a5)
    50204420:	86418793          	addi	a5,gp,-1948 # 502096c4 <barrier_num>
    50204424:	439c                	lw	a5,0(a5)
    50204426:	00007717          	auipc	a4,0x7
    5020442a:	46a70713          	addi	a4,a4,1130 # 5020b890 <barrier_array>
    5020442e:	0796                	slli	a5,a5,0x5
    50204430:	97ba                	add	a5,a5,a4
    50204432:	0007b823          	sd	zero,16(a5)
    50204436:	86418793          	addi	a5,gp,-1948 # 502096c4 <barrier_num>
    5020443a:	439c                	lw	a5,0(a5)
    5020443c:	00007717          	auipc	a4,0x7
    50204440:	45470713          	addi	a4,a4,1108 # 5020b890 <barrier_array>
    50204444:	0796                	slli	a5,a5,0x5
    50204446:	97ba                	add	a5,a5,a4
    50204448:	0007bc23          	sd	zero,24(a5)
    5020444c:	86418793          	addi	a5,gp,-1948 # 502096c4 <barrier_num>
    50204450:	439c                	lw	a5,0(a5)
    50204452:	00007717          	auipc	a4,0x7
    50204456:	43e70713          	addi	a4,a4,1086 # 5020b890 <barrier_array>
    5020445a:	0796                	slli	a5,a5,0x5
    5020445c:	97ba                	add	a5,a5,a4
    5020445e:	0007a423          	sw	zero,8(a5)
    50204462:	fd843783          	ld	a5,-40(s0)
    50204466:	4705                	li	a4,1
    50204468:	c398                	sw	a4,0(a5)
    5020446a:	86418793          	addi	a5,gp,-1948 # 502096c4 <barrier_num>
    5020446e:	439c                	lw	a5,0(a5)
    50204470:	0017871b          	addiw	a4,a5,1
    50204474:	0007069b          	sext.w	a3,a4
    50204478:	86418713          	addi	a4,gp,-1948 # 502096c4 <barrier_num>
    5020447c:	c314                	sw	a3,0(a4)
    5020447e:	853e                	mv	a0,a5
    50204480:	7422                	ld	s0,40(sp)
    50204482:	6145                	addi	sp,sp,48
    50204484:	8082                	ret

0000000050204486 <do_barrier_wait>:
    50204486:	7179                	addi	sp,sp,-48
    50204488:	f406                	sd	ra,40(sp)
    5020448a:	f022                	sd	s0,32(sp)
    5020448c:	1800                	addi	s0,sp,48
    5020448e:	87aa                	mv	a5,a0
    50204490:	fcf42e23          	sw	a5,-36(s0)
    50204494:	db5fc0ef          	jal	ra,50201248 <get_current_cpu_id>
    50204498:	87aa                	mv	a5,a0
    5020449a:	fef42623          	sw	a5,-20(s0)
    5020449e:	00007717          	auipc	a4,0x7
    502044a2:	3f270713          	addi	a4,a4,1010 # 5020b890 <barrier_array>
    502044a6:	fdc42783          	lw	a5,-36(s0)
    502044aa:	0796                	slli	a5,a5,0x5
    502044ac:	97ba                	add	a5,a5,a4
    502044ae:	4794                	lw	a3,8(a5)
    502044b0:	00007717          	auipc	a4,0x7
    502044b4:	3e070713          	addi	a4,a4,992 # 5020b890 <barrier_array>
    502044b8:	fdc42783          	lw	a5,-36(s0)
    502044bc:	0796                	slli	a5,a5,0x5
    502044be:	97ba                	add	a5,a5,a4
    502044c0:	43dc                	lw	a5,4(a5)
    502044c2:	37fd                	addiw	a5,a5,-1
    502044c4:	2781                	sext.w	a5,a5
    502044c6:	8736                	mv	a4,a3
    502044c8:	02f74063          	blt	a4,a5,502044e8 <do_barrier_wait+0x62>
    502044cc:	fdc42783          	lw	a5,-36(s0)
    502044d0:	00579713          	slli	a4,a5,0x5
    502044d4:	00007797          	auipc	a5,0x7
    502044d8:	3bc78793          	addi	a5,a5,956 # 5020b890 <barrier_array>
    502044dc:	97ba                	add	a5,a5,a4
    502044de:	07a1                	addi	a5,a5,8
    502044e0:	853e                	mv	a0,a5
    502044e2:	f5aff0ef          	jal	ra,50203c3c <release_wait_list>
    502044e6:	a8bd                	j	50204564 <do_barrier_wait+0xde>
    502044e8:	00008717          	auipc	a4,0x8
    502044ec:	a0870713          	addi	a4,a4,-1528 # 5020bef0 <current_running>
    502044f0:	fec42783          	lw	a5,-20(s0)
    502044f4:	078e                	slli	a5,a5,0x3
    502044f6:	97ba                	add	a5,a5,a4
    502044f8:	639c                	ld	a5,0(a5)
    502044fa:	4705                	li	a4,1
    502044fc:	cff8                	sw	a4,92(a5)
    502044fe:	00008717          	auipc	a4,0x8
    50204502:	9f270713          	addi	a4,a4,-1550 # 5020bef0 <current_running>
    50204506:	fec42783          	lw	a5,-20(s0)
    5020450a:	078e                	slli	a5,a5,0x3
    5020450c:	97ba                	add	a5,a5,a4
    5020450e:	639c                	ld	a5,0(a5)
    50204510:	fdc42703          	lw	a4,-36(s0)
    50204514:	00571693          	slli	a3,a4,0x5
    50204518:	00007717          	auipc	a4,0x7
    5020451c:	37870713          	addi	a4,a4,888 # 5020b890 <barrier_array>
    50204520:	9736                	add	a4,a4,a3
    50204522:	0721                	addi	a4,a4,8
    50204524:	e7b8                	sd	a4,72(a5)
    50204526:	00008717          	auipc	a4,0x8
    5020452a:	9ca70713          	addi	a4,a4,-1590 # 5020bef0 <current_running>
    5020452e:	fec42783          	lw	a5,-20(s0)
    50204532:	078e                	slli	a5,a5,0x3
    50204534:	97ba                	add	a5,a5,a4
    50204536:	639c                	ld	a5,0(a5)
    50204538:	01878693          	addi	a3,a5,24
    5020453c:	fdc42783          	lw	a5,-36(s0)
    50204540:	00579713          	slli	a4,a5,0x5
    50204544:	00007797          	auipc	a5,0x7
    50204548:	34c78793          	addi	a5,a5,844 # 5020b890 <barrier_array>
    5020454c:	97ba                	add	a5,a5,a4
    5020454e:	07a1                	addi	a5,a5,8
    50204550:	00008617          	auipc	a2,0x8
    50204554:	98860613          	addi	a2,a2,-1656 # 5020bed8 <ready_queue>
    50204558:	85be                	mv	a1,a5
    5020455a:	8536                	mv	a0,a3
    5020455c:	ef9fe0ef          	jal	ra,50203454 <move_node>
    50204560:	b6dfe0ef          	jal	ra,502030cc <do_scheduler>
    50204564:	4781                	li	a5,0
    50204566:	853e                	mv	a0,a5
    50204568:	70a2                	ld	ra,40(sp)
    5020456a:	7402                	ld	s0,32(sp)
    5020456c:	6145                	addi	sp,sp,48
    5020456e:	8082                	ret

0000000050204570 <do_barrier_destroy>:
    50204570:	1101                	addi	sp,sp,-32
    50204572:	ec22                	sd	s0,24(sp)
    50204574:	1000                	addi	s0,sp,32
    50204576:	87aa                	mv	a5,a0
    50204578:	feb43023          	sd	a1,-32(s0)
    5020457c:	fef42623          	sw	a5,-20(s0)
    50204580:	00007717          	auipc	a4,0x7
    50204584:	31070713          	addi	a4,a4,784 # 5020b890 <barrier_array>
    50204588:	fec42783          	lw	a5,-20(s0)
    5020458c:	0796                	slli	a5,a5,0x5
    5020458e:	97ba                	add	a5,a5,a4
    50204590:	0007a223          	sw	zero,4(a5)
    50204594:	00007717          	auipc	a4,0x7
    50204598:	2fc70713          	addi	a4,a4,764 # 5020b890 <barrier_array>
    5020459c:	fec42783          	lw	a5,-20(s0)
    502045a0:	0796                	slli	a5,a5,0x5
    502045a2:	97ba                	add	a5,a5,a4
    502045a4:	0007a023          	sw	zero,0(a5)
    502045a8:	fe043783          	ld	a5,-32(s0)
    502045ac:	0007a023          	sw	zero,0(a5)
    502045b0:	4781                	li	a5,0
    502045b2:	853e                	mv	a0,a5
    502045b4:	6462                	ld	s0,24(sp)
    502045b6:	6105                	addi	sp,sp,32
    502045b8:	8082                	ret

00000000502045ba <do_semaphore_init>:
    502045ba:	7179                	addi	sp,sp,-48
    502045bc:	f422                	sd	s0,40(sp)
    502045be:	1800                	addi	s0,sp,48
    502045c0:	fea43423          	sd	a0,-24(s0)
    502045c4:	87ae                	mv	a5,a1
    502045c6:	fcc43c23          	sd	a2,-40(s0)
    502045ca:	fef42223          	sw	a5,-28(s0)
    502045ce:	86818793          	addi	a5,gp,-1944 # 502096c8 <semaphore_num>
    502045d2:	439c                	lw	a5,0(a5)
    502045d4:	00007717          	auipc	a4,0x7
    502045d8:	05c70713          	addi	a4,a4,92 # 5020b630 <semaphore_array>
    502045dc:	0796                	slli	a5,a5,0x5
    502045de:	97ba                	add	a5,a5,a4
    502045e0:	4705                	li	a4,1
    502045e2:	c398                	sw	a4,0(a5)
    502045e4:	86818793          	addi	a5,gp,-1944 # 502096c8 <semaphore_num>
    502045e8:	439c                	lw	a5,0(a5)
    502045ea:	00007717          	auipc	a4,0x7
    502045ee:	04670713          	addi	a4,a4,70 # 5020b630 <semaphore_array>
    502045f2:	0796                	slli	a5,a5,0x5
    502045f4:	97ba                	add	a5,a5,a4
    502045f6:	fe442703          	lw	a4,-28(s0)
    502045fa:	c3d8                	sw	a4,4(a5)
    502045fc:	86818793          	addi	a5,gp,-1944 # 502096c8 <semaphore_num>
    50204600:	439c                	lw	a5,0(a5)
    50204602:	00007717          	auipc	a4,0x7
    50204606:	02e70713          	addi	a4,a4,46 # 5020b630 <semaphore_array>
    5020460a:	0796                	slli	a5,a5,0x5
    5020460c:	97ba                	add	a5,a5,a4
    5020460e:	0007b823          	sd	zero,16(a5)
    50204612:	86818793          	addi	a5,gp,-1944 # 502096c8 <semaphore_num>
    50204616:	439c                	lw	a5,0(a5)
    50204618:	00007717          	auipc	a4,0x7
    5020461c:	01870713          	addi	a4,a4,24 # 5020b630 <semaphore_array>
    50204620:	0796                	slli	a5,a5,0x5
    50204622:	97ba                	add	a5,a5,a4
    50204624:	0007bc23          	sd	zero,24(a5)
    50204628:	86818793          	addi	a5,gp,-1944 # 502096c8 <semaphore_num>
    5020462c:	439c                	lw	a5,0(a5)
    5020462e:	00007717          	auipc	a4,0x7
    50204632:	00270713          	addi	a4,a4,2 # 5020b630 <semaphore_array>
    50204636:	0796                	slli	a5,a5,0x5
    50204638:	97ba                	add	a5,a5,a4
    5020463a:	0007a423          	sw	zero,8(a5)
    5020463e:	fd843783          	ld	a5,-40(s0)
    50204642:	4705                	li	a4,1
    50204644:	c398                	sw	a4,0(a5)
    50204646:	86818793          	addi	a5,gp,-1944 # 502096c8 <semaphore_num>
    5020464a:	439c                	lw	a5,0(a5)
    5020464c:	0017871b          	addiw	a4,a5,1
    50204650:	0007069b          	sext.w	a3,a4
    50204654:	86818713          	addi	a4,gp,-1944 # 502096c8 <semaphore_num>
    50204658:	c314                	sw	a3,0(a4)
    5020465a:	853e                	mv	a0,a5
    5020465c:	7422                	ld	s0,40(sp)
    5020465e:	6145                	addi	sp,sp,48
    50204660:	8082                	ret

0000000050204662 <do_semaphore_up>:
    50204662:	7179                	addi	sp,sp,-48
    50204664:	f406                	sd	ra,40(sp)
    50204666:	f022                	sd	s0,32(sp)
    50204668:	1800                	addi	s0,sp,48
    5020466a:	87aa                	mv	a5,a0
    5020466c:	fcf42e23          	sw	a5,-36(s0)
    50204670:	fdc42783          	lw	a5,-36(s0)
    50204674:	00579713          	slli	a4,a5,0x5
    50204678:	00007797          	auipc	a5,0x7
    5020467c:	fb878793          	addi	a5,a5,-72 # 5020b630 <semaphore_array>
    50204680:	97ba                	add	a5,a5,a4
    50204682:	07a1                	addi	a5,a5,8
    50204684:	fef43423          	sd	a5,-24(s0)
    50204688:	fe843783          	ld	a5,-24(s0)
    5020468c:	439c                	lw	a5,0(a5)
    5020468e:	06f05063          	blez	a5,502046ee <do_semaphore_up+0x8c>
    50204692:	fe843783          	ld	a5,-24(s0)
    50204696:	679c                	ld	a5,8(a5)
    50204698:	4398                	lw	a4,0(a5)
    5020469a:	00008697          	auipc	a3,0x8
    5020469e:	87e68693          	addi	a3,a3,-1922 # 5020bf18 <pcb>
    502046a2:	87ba                	mv	a5,a4
    502046a4:	078e                	slli	a5,a5,0x3
    502046a6:	97ba                	add	a5,a5,a4
    502046a8:	0792                	slli	a5,a5,0x4
    502046aa:	97b6                	add	a5,a5,a3
    502046ac:	470d                	li	a4,3
    502046ae:	cff8                	sw	a4,92(a5)
    502046b0:	fe843783          	ld	a5,-24(s0)
    502046b4:	679c                	ld	a5,8(a5)
    502046b6:	4398                	lw	a4,0(a5)
    502046b8:	00008697          	auipc	a3,0x8
    502046bc:	86068693          	addi	a3,a3,-1952 # 5020bf18 <pcb>
    502046c0:	87ba                	mv	a5,a4
    502046c2:	078e                	slli	a5,a5,0x3
    502046c4:	97ba                	add	a5,a5,a4
    502046c6:	0792                	slli	a5,a5,0x4
    502046c8:	97b6                	add	a5,a5,a3
    502046ca:	00008717          	auipc	a4,0x8
    502046ce:	80e70713          	addi	a4,a4,-2034 # 5020bed8 <ready_queue>
    502046d2:	e7b8                	sd	a4,72(a5)
    502046d4:	fe843783          	ld	a5,-24(s0)
    502046d8:	679c                	ld	a5,8(a5)
    502046da:	fe843603          	ld	a2,-24(s0)
    502046de:	00007597          	auipc	a1,0x7
    502046e2:	7fa58593          	addi	a1,a1,2042 # 5020bed8 <ready_queue>
    502046e6:	853e                	mv	a0,a5
    502046e8:	d6dfe0ef          	jal	ra,50203454 <move_node>
    502046ec:	a035                	j	50204718 <do_semaphore_up+0xb6>
    502046ee:	00007717          	auipc	a4,0x7
    502046f2:	f4270713          	addi	a4,a4,-190 # 5020b630 <semaphore_array>
    502046f6:	fdc42783          	lw	a5,-36(s0)
    502046fa:	0796                	slli	a5,a5,0x5
    502046fc:	97ba                	add	a5,a5,a4
    502046fe:	43dc                	lw	a5,4(a5)
    50204700:	2785                	addiw	a5,a5,1
    50204702:	0007871b          	sext.w	a4,a5
    50204706:	00007697          	auipc	a3,0x7
    5020470a:	f2a68693          	addi	a3,a3,-214 # 5020b630 <semaphore_array>
    5020470e:	fdc42783          	lw	a5,-36(s0)
    50204712:	0796                	slli	a5,a5,0x5
    50204714:	97b6                	add	a5,a5,a3
    50204716:	c3d8                	sw	a4,4(a5)
    50204718:	4781                	li	a5,0
    5020471a:	853e                	mv	a0,a5
    5020471c:	70a2                	ld	ra,40(sp)
    5020471e:	7402                	ld	s0,32(sp)
    50204720:	6145                	addi	sp,sp,48
    50204722:	8082                	ret

0000000050204724 <do_semaphore_down>:
    50204724:	7179                	addi	sp,sp,-48
    50204726:	f406                	sd	ra,40(sp)
    50204728:	f022                	sd	s0,32(sp)
    5020472a:	1800                	addi	s0,sp,48
    5020472c:	87aa                	mv	a5,a0
    5020472e:	fcf42e23          	sw	a5,-36(s0)
    50204732:	b17fc0ef          	jal	ra,50201248 <get_current_cpu_id>
    50204736:	87aa                	mv	a5,a0
    50204738:	fef42623          	sw	a5,-20(s0)
    5020473c:	00007717          	auipc	a4,0x7
    50204740:	ef470713          	addi	a4,a4,-268 # 5020b630 <semaphore_array>
    50204744:	fdc42783          	lw	a5,-36(s0)
    50204748:	0796                	slli	a5,a5,0x5
    5020474a:	97ba                	add	a5,a5,a4
    5020474c:	43dc                	lw	a5,4(a5)
    5020474e:	02f05863          	blez	a5,5020477e <do_semaphore_down+0x5a>
    50204752:	00007717          	auipc	a4,0x7
    50204756:	ede70713          	addi	a4,a4,-290 # 5020b630 <semaphore_array>
    5020475a:	fdc42783          	lw	a5,-36(s0)
    5020475e:	0796                	slli	a5,a5,0x5
    50204760:	97ba                	add	a5,a5,a4
    50204762:	43dc                	lw	a5,4(a5)
    50204764:	37fd                	addiw	a5,a5,-1
    50204766:	0007871b          	sext.w	a4,a5
    5020476a:	00007697          	auipc	a3,0x7
    5020476e:	ec668693          	addi	a3,a3,-314 # 5020b630 <semaphore_array>
    50204772:	fdc42783          	lw	a5,-36(s0)
    50204776:	0796                	slli	a5,a5,0x5
    50204778:	97b6                	add	a5,a5,a3
    5020477a:	c3d8                	sw	a4,4(a5)
    5020477c:	a8bd                	j	502047fa <do_semaphore_down+0xd6>
    5020477e:	00007717          	auipc	a4,0x7
    50204782:	77270713          	addi	a4,a4,1906 # 5020bef0 <current_running>
    50204786:	fec42783          	lw	a5,-20(s0)
    5020478a:	078e                	slli	a5,a5,0x3
    5020478c:	97ba                	add	a5,a5,a4
    5020478e:	639c                	ld	a5,0(a5)
    50204790:	4705                	li	a4,1
    50204792:	cff8                	sw	a4,92(a5)
    50204794:	00007717          	auipc	a4,0x7
    50204798:	75c70713          	addi	a4,a4,1884 # 5020bef0 <current_running>
    5020479c:	fec42783          	lw	a5,-20(s0)
    502047a0:	078e                	slli	a5,a5,0x3
    502047a2:	97ba                	add	a5,a5,a4
    502047a4:	639c                	ld	a5,0(a5)
    502047a6:	fdc42703          	lw	a4,-36(s0)
    502047aa:	00571693          	slli	a3,a4,0x5
    502047ae:	00007717          	auipc	a4,0x7
    502047b2:	e8270713          	addi	a4,a4,-382 # 5020b630 <semaphore_array>
    502047b6:	9736                	add	a4,a4,a3
    502047b8:	0721                	addi	a4,a4,8
    502047ba:	e7b8                	sd	a4,72(a5)
    502047bc:	00007717          	auipc	a4,0x7
    502047c0:	73470713          	addi	a4,a4,1844 # 5020bef0 <current_running>
    502047c4:	fec42783          	lw	a5,-20(s0)
    502047c8:	078e                	slli	a5,a5,0x3
    502047ca:	97ba                	add	a5,a5,a4
    502047cc:	639c                	ld	a5,0(a5)
    502047ce:	01878693          	addi	a3,a5,24
    502047d2:	fdc42783          	lw	a5,-36(s0)
    502047d6:	00579713          	slli	a4,a5,0x5
    502047da:	00007797          	auipc	a5,0x7
    502047de:	e5678793          	addi	a5,a5,-426 # 5020b630 <semaphore_array>
    502047e2:	97ba                	add	a5,a5,a4
    502047e4:	07a1                	addi	a5,a5,8
    502047e6:	00007617          	auipc	a2,0x7
    502047ea:	6f260613          	addi	a2,a2,1778 # 5020bed8 <ready_queue>
    502047ee:	85be                	mv	a1,a5
    502047f0:	8536                	mv	a0,a3
    502047f2:	c63fe0ef          	jal	ra,50203454 <move_node>
    502047f6:	8d7fe0ef          	jal	ra,502030cc <do_scheduler>
    502047fa:	4781                	li	a5,0
    502047fc:	853e                	mv	a0,a5
    502047fe:	70a2                	ld	ra,40(sp)
    50204800:	7402                	ld	s0,32(sp)
    50204802:	6145                	addi	sp,sp,48
    50204804:	8082                	ret

0000000050204806 <do_semaphore_destroy>:
    50204806:	1101                	addi	sp,sp,-32
    50204808:	ec22                	sd	s0,24(sp)
    5020480a:	1000                	addi	s0,sp,32
    5020480c:	87aa                	mv	a5,a0
    5020480e:	feb43023          	sd	a1,-32(s0)
    50204812:	fef42623          	sw	a5,-20(s0)
    50204816:	00007717          	auipc	a4,0x7
    5020481a:	e1a70713          	addi	a4,a4,-486 # 5020b630 <semaphore_array>
    5020481e:	fec42783          	lw	a5,-20(s0)
    50204822:	0796                	slli	a5,a5,0x5
    50204824:	97ba                	add	a5,a5,a4
    50204826:	0007a223          	sw	zero,4(a5)
    5020482a:	00007717          	auipc	a4,0x7
    5020482e:	e0670713          	addi	a4,a4,-506 # 5020b630 <semaphore_array>
    50204832:	fec42783          	lw	a5,-20(s0)
    50204836:	0796                	slli	a5,a5,0x5
    50204838:	97ba                	add	a5,a5,a4
    5020483a:	0007a023          	sw	zero,0(a5)
    5020483e:	fe043783          	ld	a5,-32(s0)
    50204842:	0007a023          	sw	zero,0(a5)
    50204846:	4781                	li	a5,0
    50204848:	853e                	mv	a0,a5
    5020484a:	6462                	ld	s0,24(sp)
    5020484c:	6105                	addi	sp,sp,32
    5020484e:	8082                	ret

0000000050204850 <do_mbox_open>:
    50204850:	7179                	addi	sp,sp,-48
    50204852:	f406                	sd	ra,40(sp)
    50204854:	f022                	sd	s0,32(sp)
    50204856:	1800                	addi	s0,sp,48
    50204858:	fca43c23          	sd	a0,-40(s0)
    5020485c:	fe042623          	sw	zero,-20(s0)
    50204860:	a079                	j	502048ee <do_mbox_open+0x9e>
    50204862:	00007697          	auipc	a3,0x7
    50204866:	13e68693          	addi	a3,a3,318 # 5020b9a0 <mbox_array>
    5020486a:	fec42703          	lw	a4,-20(s0)
    5020486e:	87ba                	mv	a5,a4
    50204870:	0792                	slli	a5,a5,0x4
    50204872:	97ba                	add	a5,a5,a4
    50204874:	078e                	slli	a5,a5,0x3
    50204876:	97b6                	add	a5,a5,a3
    50204878:	6b9c                	ld	a5,16(a5)
    5020487a:	85be                	mv	a1,a5
    5020487c:	fd843503          	ld	a0,-40(s0)
    50204880:	131000ef          	jal	ra,502051b0 <kstrcmp>
    50204884:	87aa                	mv	a5,a0
    50204886:	efb9                	bnez	a5,502048e4 <do_mbox_open+0x94>
    50204888:	00007697          	auipc	a3,0x7
    5020488c:	11868693          	addi	a3,a3,280 # 5020b9a0 <mbox_array>
    50204890:	fec42703          	lw	a4,-20(s0)
    50204894:	87ba                	mv	a5,a4
    50204896:	0792                	slli	a5,a5,0x4
    50204898:	97ba                	add	a5,a5,a4
    5020489a:	078e                	slli	a5,a5,0x3
    5020489c:	97b6                	add	a5,a5,a3
    5020489e:	439c                	lw	a5,0(a5)
    502048a0:	873e                	mv	a4,a5
    502048a2:	4785                	li	a5,1
    502048a4:	04f71063          	bne	a4,a5,502048e4 <do_mbox_open+0x94>
    502048a8:	00007697          	auipc	a3,0x7
    502048ac:	0f868693          	addi	a3,a3,248 # 5020b9a0 <mbox_array>
    502048b0:	fec42703          	lw	a4,-20(s0)
    502048b4:	87ba                	mv	a5,a4
    502048b6:	0792                	slli	a5,a5,0x4
    502048b8:	97ba                	add	a5,a5,a4
    502048ba:	078e                	slli	a5,a5,0x3
    502048bc:	97b6                	add	a5,a5,a3
    502048be:	47dc                	lw	a5,12(a5)
    502048c0:	2785                	addiw	a5,a5,1
    502048c2:	0007869b          	sext.w	a3,a5
    502048c6:	00007617          	auipc	a2,0x7
    502048ca:	0da60613          	addi	a2,a2,218 # 5020b9a0 <mbox_array>
    502048ce:	fec42703          	lw	a4,-20(s0)
    502048d2:	87ba                	mv	a5,a4
    502048d4:	0792                	slli	a5,a5,0x4
    502048d6:	97ba                	add	a5,a5,a4
    502048d8:	078e                	slli	a5,a5,0x3
    502048da:	97b2                	add	a5,a5,a2
    502048dc:	c7d4                	sw	a3,12(a5)
    502048de:	fec42783          	lw	a5,-20(s0)
    502048e2:	a295                	j	50204a46 <do_mbox_open+0x1f6>
    502048e4:	fec42783          	lw	a5,-20(s0)
    502048e8:	2785                	addiw	a5,a5,1
    502048ea:	fef42623          	sw	a5,-20(s0)
    502048ee:	fec42783          	lw	a5,-20(s0)
    502048f2:	0007871b          	sext.w	a4,a5
    502048f6:	479d                	li	a5,7
    502048f8:	f6e7d5e3          	bge	a5,a4,50204862 <do_mbox_open+0x12>
    502048fc:	86c18793          	addi	a5,gp,-1940 # 502096cc <mbox_num>
    50204900:	4398                	lw	a4,0(a5)
    50204902:	00007697          	auipc	a3,0x7
    50204906:	09e68693          	addi	a3,a3,158 # 5020b9a0 <mbox_array>
    5020490a:	87ba                	mv	a5,a4
    5020490c:	0792                	slli	a5,a5,0x4
    5020490e:	97ba                	add	a5,a5,a4
    50204910:	078e                	slli	a5,a5,0x3
    50204912:	97b6                	add	a5,a5,a3
    50204914:	4705                	li	a4,1
    50204916:	c398                	sw	a4,0(a5)
    50204918:	86c18793          	addi	a5,gp,-1940 # 502096cc <mbox_num>
    5020491c:	4398                	lw	a4,0(a5)
    5020491e:	00007697          	auipc	a3,0x7
    50204922:	08268693          	addi	a3,a3,130 # 5020b9a0 <mbox_array>
    50204926:	87ba                	mv	a5,a4
    50204928:	0792                	slli	a5,a5,0x4
    5020492a:	97ba                	add	a5,a5,a4
    5020492c:	078e                	slli	a5,a5,0x3
    5020492e:	97b6                	add	a5,a5,a3
    50204930:	0007a223          	sw	zero,4(a5)
    50204934:	86c18793          	addi	a5,gp,-1940 # 502096cc <mbox_num>
    50204938:	4398                	lw	a4,0(a5)
    5020493a:	00007697          	auipc	a3,0x7
    5020493e:	06668693          	addi	a3,a3,102 # 5020b9a0 <mbox_array>
    50204942:	87ba                	mv	a5,a4
    50204944:	0792                	slli	a5,a5,0x4
    50204946:	97ba                	add	a5,a5,a4
    50204948:	078e                	slli	a5,a5,0x3
    5020494a:	97b6                	add	a5,a5,a3
    5020494c:	0007a423          	sw	zero,8(a5)
    50204950:	86c18793          	addi	a5,gp,-1940 # 502096cc <mbox_num>
    50204954:	4398                	lw	a4,0(a5)
    50204956:	00007697          	auipc	a3,0x7
    5020495a:	04a68693          	addi	a3,a3,74 # 5020b9a0 <mbox_array>
    5020495e:	87ba                	mv	a5,a4
    50204960:	0792                	slli	a5,a5,0x4
    50204962:	97ba                	add	a5,a5,a4
    50204964:	078e                	slli	a5,a5,0x3
    50204966:	97b6                	add	a5,a5,a3
    50204968:	4705                	li	a4,1
    5020496a:	c7d8                	sw	a4,12(a5)
    5020496c:	86c18793          	addi	a5,gp,-1940 # 502096cc <mbox_num>
    50204970:	4398                	lw	a4,0(a5)
    50204972:	00007697          	auipc	a3,0x7
    50204976:	02e68693          	addi	a3,a3,46 # 5020b9a0 <mbox_array>
    5020497a:	87ba                	mv	a5,a4
    5020497c:	0792                	slli	a5,a5,0x4
    5020497e:	97ba                	add	a5,a5,a4
    50204980:	078e                	slli	a5,a5,0x3
    50204982:	97b6                	add	a5,a5,a3
    50204984:	fd843703          	ld	a4,-40(s0)
    50204988:	eb98                	sd	a4,16(a5)
    5020498a:	86c18793          	addi	a5,gp,-1940 # 502096cc <mbox_num>
    5020498e:	4398                	lw	a4,0(a5)
    50204990:	00007697          	auipc	a3,0x7
    50204994:	01068693          	addi	a3,a3,16 # 5020b9a0 <mbox_array>
    50204998:	87ba                	mv	a5,a4
    5020499a:	0792                	slli	a5,a5,0x4
    5020499c:	97ba                	add	a5,a5,a4
    5020499e:	078e                	slli	a5,a5,0x3
    502049a0:	97b6                	add	a5,a5,a3
    502049a2:	0207b023          	sd	zero,32(a5)
    502049a6:	86c18793          	addi	a5,gp,-1940 # 502096cc <mbox_num>
    502049aa:	4398                	lw	a4,0(a5)
    502049ac:	00007697          	auipc	a3,0x7
    502049b0:	ff468693          	addi	a3,a3,-12 # 5020b9a0 <mbox_array>
    502049b4:	87ba                	mv	a5,a4
    502049b6:	0792                	slli	a5,a5,0x4
    502049b8:	97ba                	add	a5,a5,a4
    502049ba:	078e                	slli	a5,a5,0x3
    502049bc:	97b6                	add	a5,a5,a3
    502049be:	0207b423          	sd	zero,40(a5)
    502049c2:	86c18793          	addi	a5,gp,-1940 # 502096cc <mbox_num>
    502049c6:	4398                	lw	a4,0(a5)
    502049c8:	00007697          	auipc	a3,0x7
    502049cc:	fd868693          	addi	a3,a3,-40 # 5020b9a0 <mbox_array>
    502049d0:	87ba                	mv	a5,a4
    502049d2:	0792                	slli	a5,a5,0x4
    502049d4:	97ba                	add	a5,a5,a4
    502049d6:	078e                	slli	a5,a5,0x3
    502049d8:	97b6                	add	a5,a5,a3
    502049da:	0007ac23          	sw	zero,24(a5)
    502049de:	86c18793          	addi	a5,gp,-1940 # 502096cc <mbox_num>
    502049e2:	4398                	lw	a4,0(a5)
    502049e4:	00007697          	auipc	a3,0x7
    502049e8:	fbc68693          	addi	a3,a3,-68 # 5020b9a0 <mbox_array>
    502049ec:	87ba                	mv	a5,a4
    502049ee:	0792                	slli	a5,a5,0x4
    502049f0:	97ba                	add	a5,a5,a4
    502049f2:	078e                	slli	a5,a5,0x3
    502049f4:	97b6                	add	a5,a5,a3
    502049f6:	0207bc23          	sd	zero,56(a5)
    502049fa:	86c18793          	addi	a5,gp,-1940 # 502096cc <mbox_num>
    502049fe:	4398                	lw	a4,0(a5)
    50204a00:	00007697          	auipc	a3,0x7
    50204a04:	fa068693          	addi	a3,a3,-96 # 5020b9a0 <mbox_array>
    50204a08:	87ba                	mv	a5,a4
    50204a0a:	0792                	slli	a5,a5,0x4
    50204a0c:	97ba                	add	a5,a5,a4
    50204a0e:	078e                	slli	a5,a5,0x3
    50204a10:	97b6                	add	a5,a5,a3
    50204a12:	0407b023          	sd	zero,64(a5)
    50204a16:	86c18793          	addi	a5,gp,-1940 # 502096cc <mbox_num>
    50204a1a:	4398                	lw	a4,0(a5)
    50204a1c:	00007697          	auipc	a3,0x7
    50204a20:	f8468693          	addi	a3,a3,-124 # 5020b9a0 <mbox_array>
    50204a24:	87ba                	mv	a5,a4
    50204a26:	0792                	slli	a5,a5,0x4
    50204a28:	97ba                	add	a5,a5,a4
    50204a2a:	078e                	slli	a5,a5,0x3
    50204a2c:	97b6                	add	a5,a5,a3
    50204a2e:	0207a823          	sw	zero,48(a5)
    50204a32:	86c18793          	addi	a5,gp,-1940 # 502096cc <mbox_num>
    50204a36:	439c                	lw	a5,0(a5)
    50204a38:	0017871b          	addiw	a4,a5,1
    50204a3c:	0007069b          	sext.w	a3,a4
    50204a40:	86c18713          	addi	a4,gp,-1940 # 502096cc <mbox_num>
    50204a44:	c314                	sw	a3,0(a4)
    50204a46:	853e                	mv	a0,a5
    50204a48:	70a2                	ld	ra,40(sp)
    50204a4a:	7402                	ld	s0,32(sp)
    50204a4c:	6145                	addi	sp,sp,48
    50204a4e:	8082                	ret

0000000050204a50 <do_mbox_close>:
    50204a50:	1101                	addi	sp,sp,-32
    50204a52:	ec22                	sd	s0,24(sp)
    50204a54:	1000                	addi	s0,sp,32
    50204a56:	87aa                	mv	a5,a0
    50204a58:	fef42623          	sw	a5,-20(s0)
    50204a5c:	00007697          	auipc	a3,0x7
    50204a60:	f4468693          	addi	a3,a3,-188 # 5020b9a0 <mbox_array>
    50204a64:	fec42703          	lw	a4,-20(s0)
    50204a68:	87ba                	mv	a5,a4
    50204a6a:	0792                	slli	a5,a5,0x4
    50204a6c:	97ba                	add	a5,a5,a4
    50204a6e:	078e                	slli	a5,a5,0x3
    50204a70:	97b6                	add	a5,a5,a3
    50204a72:	0007a023          	sw	zero,0(a5)
    50204a76:	00007697          	auipc	a3,0x7
    50204a7a:	f2a68693          	addi	a3,a3,-214 # 5020b9a0 <mbox_array>
    50204a7e:	fec42703          	lw	a4,-20(s0)
    50204a82:	87ba                	mv	a5,a4
    50204a84:	0792                	slli	a5,a5,0x4
    50204a86:	97ba                	add	a5,a5,a4
    50204a88:	078e                	slli	a5,a5,0x3
    50204a8a:	97b6                	add	a5,a5,a3
    50204a8c:	439c                	lw	a5,0(a5)
    50204a8e:	eff9                	bnez	a5,50204b6c <do_mbox_close+0x11c>
    50204a90:	00007697          	auipc	a3,0x7
    50204a94:	f1068693          	addi	a3,a3,-240 # 5020b9a0 <mbox_array>
    50204a98:	fec42703          	lw	a4,-20(s0)
    50204a9c:	87ba                	mv	a5,a4
    50204a9e:	0792                	slli	a5,a5,0x4
    50204aa0:	97ba                	add	a5,a5,a4
    50204aa2:	078e                	slli	a5,a5,0x3
    50204aa4:	97b6                	add	a5,a5,a3
    50204aa6:	47dc                	lw	a5,12(a5)
    50204aa8:	873e                	mv	a4,a5
    50204aaa:	4785                	li	a5,1
    50204aac:	08e7c463          	blt	a5,a4,50204b34 <do_mbox_close+0xe4>
    50204ab0:	00007697          	auipc	a3,0x7
    50204ab4:	ef068693          	addi	a3,a3,-272 # 5020b9a0 <mbox_array>
    50204ab8:	fec42703          	lw	a4,-20(s0)
    50204abc:	87ba                	mv	a5,a4
    50204abe:	0792                	slli	a5,a5,0x4
    50204ac0:	97ba                	add	a5,a5,a4
    50204ac2:	078e                	slli	a5,a5,0x3
    50204ac4:	97b6                	add	a5,a5,a3
    50204ac6:	0007a623          	sw	zero,12(a5)
    50204aca:	00007697          	auipc	a3,0x7
    50204ace:	ed668693          	addi	a3,a3,-298 # 5020b9a0 <mbox_array>
    50204ad2:	fec42703          	lw	a4,-20(s0)
    50204ad6:	87ba                	mv	a5,a4
    50204ad8:	0792                	slli	a5,a5,0x4
    50204ada:	97ba                	add	a5,a5,a4
    50204adc:	078e                	slli	a5,a5,0x3
    50204ade:	97b6                	add	a5,a5,a3
    50204ae0:	0007a023          	sw	zero,0(a5)
    50204ae4:	00007697          	auipc	a3,0x7
    50204ae8:	ebc68693          	addi	a3,a3,-324 # 5020b9a0 <mbox_array>
    50204aec:	fec42703          	lw	a4,-20(s0)
    50204af0:	87ba                	mv	a5,a4
    50204af2:	0792                	slli	a5,a5,0x4
    50204af4:	97ba                	add	a5,a5,a4
    50204af6:	078e                	slli	a5,a5,0x3
    50204af8:	97b6                	add	a5,a5,a3
    50204afa:	0007b823          	sd	zero,16(a5)
    50204afe:	00007697          	auipc	a3,0x7
    50204b02:	ea268693          	addi	a3,a3,-350 # 5020b9a0 <mbox_array>
    50204b06:	fec42703          	lw	a4,-20(s0)
    50204b0a:	87ba                	mv	a5,a4
    50204b0c:	0792                	slli	a5,a5,0x4
    50204b0e:	97ba                	add	a5,a5,a4
    50204b10:	078e                	slli	a5,a5,0x3
    50204b12:	97b6                	add	a5,a5,a3
    50204b14:	0007a223          	sw	zero,4(a5)
    50204b18:	00007697          	auipc	a3,0x7
    50204b1c:	e8868693          	addi	a3,a3,-376 # 5020b9a0 <mbox_array>
    50204b20:	fec42703          	lw	a4,-20(s0)
    50204b24:	87ba                	mv	a5,a4
    50204b26:	0792                	slli	a5,a5,0x4
    50204b28:	97ba                	add	a5,a5,a4
    50204b2a:	078e                	slli	a5,a5,0x3
    50204b2c:	97b6                	add	a5,a5,a3
    50204b2e:	0007a423          	sw	zero,8(a5)
    50204b32:	a835                	j	50204b6e <do_mbox_close+0x11e>
    50204b34:	00007697          	auipc	a3,0x7
    50204b38:	e6c68693          	addi	a3,a3,-404 # 5020b9a0 <mbox_array>
    50204b3c:	fec42703          	lw	a4,-20(s0)
    50204b40:	87ba                	mv	a5,a4
    50204b42:	0792                	slli	a5,a5,0x4
    50204b44:	97ba                	add	a5,a5,a4
    50204b46:	078e                	slli	a5,a5,0x3
    50204b48:	97b6                	add	a5,a5,a3
    50204b4a:	47dc                	lw	a5,12(a5)
    50204b4c:	37fd                	addiw	a5,a5,-1
    50204b4e:	0007869b          	sext.w	a3,a5
    50204b52:	00007617          	auipc	a2,0x7
    50204b56:	e4e60613          	addi	a2,a2,-434 # 5020b9a0 <mbox_array>
    50204b5a:	fec42703          	lw	a4,-20(s0)
    50204b5e:	87ba                	mv	a5,a4
    50204b60:	0792                	slli	a5,a5,0x4
    50204b62:	97ba                	add	a5,a5,a4
    50204b64:	078e                	slli	a5,a5,0x3
    50204b66:	97b2                	add	a5,a5,a2
    50204b68:	c7d4                	sw	a3,12(a5)
    50204b6a:	a011                	j	50204b6e <do_mbox_close+0x11e>
    50204b6c:	0001                	nop
    50204b6e:	6462                	ld	s0,24(sp)
    50204b70:	6105                	addi	sp,sp,32
    50204b72:	8082                	ret

0000000050204b74 <do_mbox_send>:
    50204b74:	7179                	addi	sp,sp,-48
    50204b76:	f406                	sd	ra,40(sp)
    50204b78:	f022                	sd	s0,32(sp)
    50204b7a:	1800                	addi	s0,sp,48
    50204b7c:	87aa                	mv	a5,a0
    50204b7e:	fcb43823          	sd	a1,-48(s0)
    50204b82:	8732                	mv	a4,a2
    50204b84:	fcf42e23          	sw	a5,-36(s0)
    50204b88:	87ba                	mv	a5,a4
    50204b8a:	fcf42c23          	sw	a5,-40(s0)
    50204b8e:	ebafc0ef          	jal	ra,50201248 <get_current_cpu_id>
    50204b92:	87aa                	mv	a5,a0
    50204b94:	fef42623          	sw	a5,-20(s0)
    50204b98:	00007697          	auipc	a3,0x7
    50204b9c:	e0868693          	addi	a3,a3,-504 # 5020b9a0 <mbox_array>
    50204ba0:	fdc42703          	lw	a4,-36(s0)
    50204ba4:	87ba                	mv	a5,a4
    50204ba6:	0792                	slli	a5,a5,0x4
    50204ba8:	97ba                	add	a5,a5,a4
    50204baa:	078e                	slli	a5,a5,0x3
    50204bac:	97b6                	add	a5,a5,a3
    50204bae:	4790                	lw	a2,8(a5)
    50204bb0:	00007697          	auipc	a3,0x7
    50204bb4:	df068693          	addi	a3,a3,-528 # 5020b9a0 <mbox_array>
    50204bb8:	fdc42703          	lw	a4,-36(s0)
    50204bbc:	87ba                	mv	a5,a4
    50204bbe:	0792                	slli	a5,a5,0x4
    50204bc0:	97ba                	add	a5,a5,a4
    50204bc2:	078e                	slli	a5,a5,0x3
    50204bc4:	97b6                	add	a5,a5,a3
    50204bc6:	43dc                	lw	a5,4(a5)
    50204bc8:	8732                	mv	a4,a2
    50204bca:	08e7d963          	bge	a5,a4,50204c5c <do_mbox_send+0xe8>
    50204bce:	00007717          	auipc	a4,0x7
    50204bd2:	32270713          	addi	a4,a4,802 # 5020bef0 <current_running>
    50204bd6:	fec42783          	lw	a5,-20(s0)
    50204bda:	078e                	slli	a5,a5,0x3
    50204bdc:	97ba                	add	a5,a5,a4
    50204bde:	639c                	ld	a5,0(a5)
    50204be0:	4705                	li	a4,1
    50204be2:	cff8                	sw	a4,92(a5)
    50204be4:	00007717          	auipc	a4,0x7
    50204be8:	30c70713          	addi	a4,a4,780 # 5020bef0 <current_running>
    50204bec:	fec42783          	lw	a5,-20(s0)
    50204bf0:	078e                	slli	a5,a5,0x3
    50204bf2:	97ba                	add	a5,a5,a4
    50204bf4:	6394                	ld	a3,0(a5)
    50204bf6:	fdc42703          	lw	a4,-36(s0)
    50204bfa:	87ba                	mv	a5,a4
    50204bfc:	0792                	slli	a5,a5,0x4
    50204bfe:	97ba                	add	a5,a5,a4
    50204c00:	078e                	slli	a5,a5,0x3
    50204c02:	01078713          	addi	a4,a5,16
    50204c06:	00007797          	auipc	a5,0x7
    50204c0a:	d9a78793          	addi	a5,a5,-614 # 5020b9a0 <mbox_array>
    50204c0e:	97ba                	add	a5,a5,a4
    50204c10:	07a1                	addi	a5,a5,8
    50204c12:	e6bc                	sd	a5,72(a3)
    50204c14:	00007717          	auipc	a4,0x7
    50204c18:	2dc70713          	addi	a4,a4,732 # 5020bef0 <current_running>
    50204c1c:	fec42783          	lw	a5,-20(s0)
    50204c20:	078e                	slli	a5,a5,0x3
    50204c22:	97ba                	add	a5,a5,a4
    50204c24:	639c                	ld	a5,0(a5)
    50204c26:	01878693          	addi	a3,a5,24
    50204c2a:	fdc42703          	lw	a4,-36(s0)
    50204c2e:	87ba                	mv	a5,a4
    50204c30:	0792                	slli	a5,a5,0x4
    50204c32:	97ba                	add	a5,a5,a4
    50204c34:	078e                	slli	a5,a5,0x3
    50204c36:	01078713          	addi	a4,a5,16
    50204c3a:	00007797          	auipc	a5,0x7
    50204c3e:	d6678793          	addi	a5,a5,-666 # 5020b9a0 <mbox_array>
    50204c42:	97ba                	add	a5,a5,a4
    50204c44:	07a1                	addi	a5,a5,8
    50204c46:	00007617          	auipc	a2,0x7
    50204c4a:	29260613          	addi	a2,a2,658 # 5020bed8 <ready_queue>
    50204c4e:	85be                	mv	a1,a5
    50204c50:	8536                	mv	a0,a3
    50204c52:	803fe0ef          	jal	ra,50203454 <move_node>
    50204c56:	c76fe0ef          	jal	ra,502030cc <do_scheduler>
    50204c5a:	a0dd                	j	50204d40 <do_mbox_send+0x1cc>
    50204c5c:	fdc42703          	lw	a4,-36(s0)
    50204c60:	87ba                	mv	a5,a4
    50204c62:	0792                	slli	a5,a5,0x4
    50204c64:	97ba                	add	a5,a5,a4
    50204c66:	078e                	slli	a5,a5,0x3
    50204c68:	04078713          	addi	a4,a5,64
    50204c6c:	00007797          	auipc	a5,0x7
    50204c70:	d3478793          	addi	a5,a5,-716 # 5020b9a0 <mbox_array>
    50204c74:	97ba                	add	a5,a5,a4
    50204c76:	07a1                	addi	a5,a5,8
    50204c78:	fd842703          	lw	a4,-40(s0)
    50204c7c:	863a                	mv	a2,a4
    50204c7e:	fd043583          	ld	a1,-48(s0)
    50204c82:	853e                	mv	a0,a5
    50204c84:	45c000ef          	jal	ra,502050e0 <kmemcpy>
    50204c88:	00007697          	auipc	a3,0x7
    50204c8c:	d1868693          	addi	a3,a3,-744 # 5020b9a0 <mbox_array>
    50204c90:	fdc42703          	lw	a4,-36(s0)
    50204c94:	87ba                	mv	a5,a4
    50204c96:	0792                	slli	a5,a5,0x4
    50204c98:	97ba                	add	a5,a5,a4
    50204c9a:	078e                	slli	a5,a5,0x3
    50204c9c:	97b6                	add	a5,a5,a3
    50204c9e:	0007a223          	sw	zero,4(a5)
    50204ca2:	00007697          	auipc	a3,0x7
    50204ca6:	cfe68693          	addi	a3,a3,-770 # 5020b9a0 <mbox_array>
    50204caa:	fdc42703          	lw	a4,-36(s0)
    50204cae:	87ba                	mv	a5,a4
    50204cb0:	0792                	slli	a5,a5,0x4
    50204cb2:	97ba                	add	a5,a5,a4
    50204cb4:	078e                	slli	a5,a5,0x3
    50204cb6:	97b6                	add	a5,a5,a3
    50204cb8:	fd842703          	lw	a4,-40(s0)
    50204cbc:	c798                	sw	a4,8(a5)
    50204cbe:	fdc42703          	lw	a4,-36(s0)
    50204cc2:	87ba                	mv	a5,a4
    50204cc4:	0792                	slli	a5,a5,0x4
    50204cc6:	97ba                	add	a5,a5,a4
    50204cc8:	078e                	slli	a5,a5,0x3
    50204cca:	03078713          	addi	a4,a5,48
    50204cce:	00007797          	auipc	a5,0x7
    50204cd2:	cd278793          	addi	a5,a5,-814 # 5020b9a0 <mbox_array>
    50204cd6:	97ba                	add	a5,a5,a4
    50204cd8:	fef43023          	sd	a5,-32(s0)
    50204cdc:	fe043783          	ld	a5,-32(s0)
    50204ce0:	439c                	lw	a5,0(a5)
    50204ce2:	04f05f63          	blez	a5,50204d40 <do_mbox_send+0x1cc>
    50204ce6:	fe043783          	ld	a5,-32(s0)
    50204cea:	679c                	ld	a5,8(a5)
    50204cec:	4398                	lw	a4,0(a5)
    50204cee:	00007697          	auipc	a3,0x7
    50204cf2:	22a68693          	addi	a3,a3,554 # 5020bf18 <pcb>
    50204cf6:	87ba                	mv	a5,a4
    50204cf8:	078e                	slli	a5,a5,0x3
    50204cfa:	97ba                	add	a5,a5,a4
    50204cfc:	0792                	slli	a5,a5,0x4
    50204cfe:	97b6                	add	a5,a5,a3
    50204d00:	470d                	li	a4,3
    50204d02:	cff8                	sw	a4,92(a5)
    50204d04:	fe043783          	ld	a5,-32(s0)
    50204d08:	679c                	ld	a5,8(a5)
    50204d0a:	4398                	lw	a4,0(a5)
    50204d0c:	00007697          	auipc	a3,0x7
    50204d10:	20c68693          	addi	a3,a3,524 # 5020bf18 <pcb>
    50204d14:	87ba                	mv	a5,a4
    50204d16:	078e                	slli	a5,a5,0x3
    50204d18:	97ba                	add	a5,a5,a4
    50204d1a:	0792                	slli	a5,a5,0x4
    50204d1c:	97b6                	add	a5,a5,a3
    50204d1e:	00007717          	auipc	a4,0x7
    50204d22:	1ba70713          	addi	a4,a4,442 # 5020bed8 <ready_queue>
    50204d26:	e7b8                	sd	a4,72(a5)
    50204d28:	fe043783          	ld	a5,-32(s0)
    50204d2c:	679c                	ld	a5,8(a5)
    50204d2e:	fe043603          	ld	a2,-32(s0)
    50204d32:	00007597          	auipc	a1,0x7
    50204d36:	1a658593          	addi	a1,a1,422 # 5020bed8 <ready_queue>
    50204d3a:	853e                	mv	a0,a5
    50204d3c:	f18fe0ef          	jal	ra,50203454 <move_node>
    50204d40:	4781                	li	a5,0
    50204d42:	853e                	mv	a0,a5
    50204d44:	70a2                	ld	ra,40(sp)
    50204d46:	7402                	ld	s0,32(sp)
    50204d48:	6145                	addi	sp,sp,48
    50204d4a:	8082                	ret

0000000050204d4c <do_mbox_recv>:
    50204d4c:	7179                	addi	sp,sp,-48
    50204d4e:	f406                	sd	ra,40(sp)
    50204d50:	f022                	sd	s0,32(sp)
    50204d52:	1800                	addi	s0,sp,48
    50204d54:	87aa                	mv	a5,a0
    50204d56:	fcb43823          	sd	a1,-48(s0)
    50204d5a:	8732                	mv	a4,a2
    50204d5c:	fcf42e23          	sw	a5,-36(s0)
    50204d60:	87ba                	mv	a5,a4
    50204d62:	fcf42c23          	sw	a5,-40(s0)
    50204d66:	ce2fc0ef          	jal	ra,50201248 <get_current_cpu_id>
    50204d6a:	87aa                	mv	a5,a0
    50204d6c:	fef42623          	sw	a5,-20(s0)
    50204d70:	00007697          	auipc	a3,0x7
    50204d74:	c3068693          	addi	a3,a3,-976 # 5020b9a0 <mbox_array>
    50204d78:	fdc42703          	lw	a4,-36(s0)
    50204d7c:	87ba                	mv	a5,a4
    50204d7e:	0792                	slli	a5,a5,0x4
    50204d80:	97ba                	add	a5,a5,a4
    50204d82:	078e                	slli	a5,a5,0x3
    50204d84:	97b6                	add	a5,a5,a3
    50204d86:	4790                	lw	a2,8(a5)
    50204d88:	00007697          	auipc	a3,0x7
    50204d8c:	c1868693          	addi	a3,a3,-1000 # 5020b9a0 <mbox_array>
    50204d90:	fdc42703          	lw	a4,-36(s0)
    50204d94:	87ba                	mv	a5,a4
    50204d96:	0792                	slli	a5,a5,0x4
    50204d98:	97ba                	add	a5,a5,a4
    50204d9a:	078e                	slli	a5,a5,0x3
    50204d9c:	97b6                	add	a5,a5,a3
    50204d9e:	43dc                	lw	a5,4(a5)
    50204da0:	8732                	mv	a4,a2
    50204da2:	08e7c763          	blt	a5,a4,50204e30 <do_mbox_recv+0xe4>
    50204da6:	00007717          	auipc	a4,0x7
    50204daa:	14a70713          	addi	a4,a4,330 # 5020bef0 <current_running>
    50204dae:	fec42783          	lw	a5,-20(s0)
    50204db2:	078e                	slli	a5,a5,0x3
    50204db4:	97ba                	add	a5,a5,a4
    50204db6:	639c                	ld	a5,0(a5)
    50204db8:	4705                	li	a4,1
    50204dba:	cff8                	sw	a4,92(a5)
    50204dbc:	00007717          	auipc	a4,0x7
    50204dc0:	13470713          	addi	a4,a4,308 # 5020bef0 <current_running>
    50204dc4:	fec42783          	lw	a5,-20(s0)
    50204dc8:	078e                	slli	a5,a5,0x3
    50204dca:	97ba                	add	a5,a5,a4
    50204dcc:	6394                	ld	a3,0(a5)
    50204dce:	fdc42703          	lw	a4,-36(s0)
    50204dd2:	87ba                	mv	a5,a4
    50204dd4:	0792                	slli	a5,a5,0x4
    50204dd6:	97ba                	add	a5,a5,a4
    50204dd8:	078e                	slli	a5,a5,0x3
    50204dda:	03078713          	addi	a4,a5,48
    50204dde:	00007797          	auipc	a5,0x7
    50204de2:	bc278793          	addi	a5,a5,-1086 # 5020b9a0 <mbox_array>
    50204de6:	97ba                	add	a5,a5,a4
    50204de8:	e6bc                	sd	a5,72(a3)
    50204dea:	00007717          	auipc	a4,0x7
    50204dee:	10670713          	addi	a4,a4,262 # 5020bef0 <current_running>
    50204df2:	fec42783          	lw	a5,-20(s0)
    50204df6:	078e                	slli	a5,a5,0x3
    50204df8:	97ba                	add	a5,a5,a4
    50204dfa:	639c                	ld	a5,0(a5)
    50204dfc:	01878693          	addi	a3,a5,24
    50204e00:	fdc42703          	lw	a4,-36(s0)
    50204e04:	87ba                	mv	a5,a4
    50204e06:	0792                	slli	a5,a5,0x4
    50204e08:	97ba                	add	a5,a5,a4
    50204e0a:	078e                	slli	a5,a5,0x3
    50204e0c:	03078713          	addi	a4,a5,48
    50204e10:	00007797          	auipc	a5,0x7
    50204e14:	b9078793          	addi	a5,a5,-1136 # 5020b9a0 <mbox_array>
    50204e18:	97ba                	add	a5,a5,a4
    50204e1a:	00007617          	auipc	a2,0x7
    50204e1e:	0be60613          	addi	a2,a2,190 # 5020bed8 <ready_queue>
    50204e22:	85be                	mv	a1,a5
    50204e24:	8536                	mv	a0,a3
    50204e26:	e2efe0ef          	jal	ra,50203454 <move_node>
    50204e2a:	aa2fe0ef          	jal	ra,502030cc <do_scheduler>
    50204e2e:	a221                	j	50204f36 <do_mbox_recv+0x1ea>
    50204e30:	fdc42703          	lw	a4,-36(s0)
    50204e34:	87ba                	mv	a5,a4
    50204e36:	0792                	slli	a5,a5,0x4
    50204e38:	97ba                	add	a5,a5,a4
    50204e3a:	078e                	slli	a5,a5,0x3
    50204e3c:	04078713          	addi	a4,a5,64
    50204e40:	00007797          	auipc	a5,0x7
    50204e44:	b6078793          	addi	a5,a5,-1184 # 5020b9a0 <mbox_array>
    50204e48:	97ba                	add	a5,a5,a4
    50204e4a:	00878693          	addi	a3,a5,8
    50204e4e:	00007617          	auipc	a2,0x7
    50204e52:	b5260613          	addi	a2,a2,-1198 # 5020b9a0 <mbox_array>
    50204e56:	fdc42703          	lw	a4,-36(s0)
    50204e5a:	87ba                	mv	a5,a4
    50204e5c:	0792                	slli	a5,a5,0x4
    50204e5e:	97ba                	add	a5,a5,a4
    50204e60:	078e                	slli	a5,a5,0x3
    50204e62:	97b2                	add	a5,a5,a2
    50204e64:	43dc                	lw	a5,4(a5)
    50204e66:	97b6                	add	a5,a5,a3
    50204e68:	fd842703          	lw	a4,-40(s0)
    50204e6c:	863a                	mv	a2,a4
    50204e6e:	85be                	mv	a1,a5
    50204e70:	fd043503          	ld	a0,-48(s0)
    50204e74:	26c000ef          	jal	ra,502050e0 <kmemcpy>
    50204e78:	00007697          	auipc	a3,0x7
    50204e7c:	b2868693          	addi	a3,a3,-1240 # 5020b9a0 <mbox_array>
    50204e80:	fdc42703          	lw	a4,-36(s0)
    50204e84:	87ba                	mv	a5,a4
    50204e86:	0792                	slli	a5,a5,0x4
    50204e88:	97ba                	add	a5,a5,a4
    50204e8a:	078e                	slli	a5,a5,0x3
    50204e8c:	97b6                	add	a5,a5,a3
    50204e8e:	43dc                	lw	a5,4(a5)
    50204e90:	fd842703          	lw	a4,-40(s0)
    50204e94:	9fb9                	addw	a5,a5,a4
    50204e96:	0007869b          	sext.w	a3,a5
    50204e9a:	00007617          	auipc	a2,0x7
    50204e9e:	b0660613          	addi	a2,a2,-1274 # 5020b9a0 <mbox_array>
    50204ea2:	fdc42703          	lw	a4,-36(s0)
    50204ea6:	87ba                	mv	a5,a4
    50204ea8:	0792                	slli	a5,a5,0x4
    50204eaa:	97ba                	add	a5,a5,a4
    50204eac:	078e                	slli	a5,a5,0x3
    50204eae:	97b2                	add	a5,a5,a2
    50204eb0:	c3d4                	sw	a3,4(a5)
    50204eb2:	fdc42703          	lw	a4,-36(s0)
    50204eb6:	87ba                	mv	a5,a4
    50204eb8:	0792                	slli	a5,a5,0x4
    50204eba:	97ba                	add	a5,a5,a4
    50204ebc:	078e                	slli	a5,a5,0x3
    50204ebe:	01078713          	addi	a4,a5,16
    50204ec2:	00007797          	auipc	a5,0x7
    50204ec6:	ade78793          	addi	a5,a5,-1314 # 5020b9a0 <mbox_array>
    50204eca:	97ba                	add	a5,a5,a4
    50204ecc:	07a1                	addi	a5,a5,8
    50204ece:	fef43023          	sd	a5,-32(s0)
    50204ed2:	fe043783          	ld	a5,-32(s0)
    50204ed6:	439c                	lw	a5,0(a5)
    50204ed8:	04f05f63          	blez	a5,50204f36 <do_mbox_recv+0x1ea>
    50204edc:	fe043783          	ld	a5,-32(s0)
    50204ee0:	679c                	ld	a5,8(a5)
    50204ee2:	4398                	lw	a4,0(a5)
    50204ee4:	00007697          	auipc	a3,0x7
    50204ee8:	03468693          	addi	a3,a3,52 # 5020bf18 <pcb>
    50204eec:	87ba                	mv	a5,a4
    50204eee:	078e                	slli	a5,a5,0x3
    50204ef0:	97ba                	add	a5,a5,a4
    50204ef2:	0792                	slli	a5,a5,0x4
    50204ef4:	97b6                	add	a5,a5,a3
    50204ef6:	470d                	li	a4,3
    50204ef8:	cff8                	sw	a4,92(a5)
    50204efa:	fe043783          	ld	a5,-32(s0)
    50204efe:	679c                	ld	a5,8(a5)
    50204f00:	4398                	lw	a4,0(a5)
    50204f02:	00007697          	auipc	a3,0x7
    50204f06:	01668693          	addi	a3,a3,22 # 5020bf18 <pcb>
    50204f0a:	87ba                	mv	a5,a4
    50204f0c:	078e                	slli	a5,a5,0x3
    50204f0e:	97ba                	add	a5,a5,a4
    50204f10:	0792                	slli	a5,a5,0x4
    50204f12:	97b6                	add	a5,a5,a3
    50204f14:	00007717          	auipc	a4,0x7
    50204f18:	fc470713          	addi	a4,a4,-60 # 5020bed8 <ready_queue>
    50204f1c:	e7b8                	sd	a4,72(a5)
    50204f1e:	fe043783          	ld	a5,-32(s0)
    50204f22:	679c                	ld	a5,8(a5)
    50204f24:	fe043603          	ld	a2,-32(s0)
    50204f28:	00007597          	auipc	a1,0x7
    50204f2c:	fb058593          	addi	a1,a1,-80 # 5020bed8 <ready_queue>
    50204f30:	853e                	mv	a0,a5
    50204f32:	d22fe0ef          	jal	ra,50203454 <move_node>
    50204f36:	4781                	li	a5,0
    50204f38:	853e                	mv	a0,a5
    50204f3a:	70a2                	ld	ra,40(sp)
    50204f3c:	7402                	ld	s0,32(sp)
    50204f3e:	6145                	addi	sp,sp,48
    50204f40:	8082                	ret

0000000050204f42 <sbi_send_ipi>:
    50204f42:	1101                	addi	sp,sp,-32
    50204f44:	ec22                	sd	s0,24(sp)
    50204f46:	1000                	addi	s0,sp,32
    50204f48:	fea43423          	sd	a0,-24(s0)
    50204f4c:	fe843783          	ld	a5,-24(s0)
    50204f50:	853e                	mv	a0,a5
    50204f52:	4581                	li	a1,0
    50204f54:	4601                	li	a2,0
    50204f56:	4891                	li	a7,4
    50204f58:	00000073          	ecall
    50204f5c:	0001                	nop
    50204f5e:	6462                	ld	s0,24(sp)
    50204f60:	6105                	addi	sp,sp,32
    50204f62:	8082                	ret

0000000050204f64 <smp_init>:
    50204f64:	1141                	addi	sp,sp,-16
    50204f66:	e422                	sd	s0,8(sp)
    50204f68:	0800                	addi	s0,sp,16
    50204f6a:	0001                	nop
    50204f6c:	6422                	ld	s0,8(sp)
    50204f6e:	0141                	addi	sp,sp,16
    50204f70:	8082                	ret

0000000050204f72 <wakeup_other_hart>:
    50204f72:	1141                	addi	sp,sp,-16
    50204f74:	e406                	sd	ra,8(sp)
    50204f76:	e022                	sd	s0,0(sp)
    50204f78:	0800                	addi	s0,sp,16
    50204f7a:	4501                	li	a0,0
    50204f7c:	fc7ff0ef          	jal	ra,50204f42 <sbi_send_ipi>
    50204f80:	0001                	nop
    50204f82:	60a2                	ld	ra,8(sp)
    50204f84:	6402                	ld	s0,0(sp)
    50204f86:	0141                	addi	sp,sp,16
    50204f88:	8082                	ret

0000000050204f8a <lock_kernel>:
    50204f8a:	1141                	addi	sp,sp,-16
    50204f8c:	e406                	sd	ra,8(sp)
    50204f8e:	e022                	sd	s0,0(sp)
    50204f90:	0800                	addi	s0,sp,16
    50204f92:	00007517          	auipc	a0,0x7
    50204f96:	9fe50513          	addi	a0,a0,-1538 # 5020b990 <kernel_lock>
    50204f9a:	8d0fe0ef          	jal	ra,5020306a <spin_lock_acquire>
    50204f9e:	0001                	nop
    50204fa0:	60a2                	ld	ra,8(sp)
    50204fa2:	6402                	ld	s0,0(sp)
    50204fa4:	0141                	addi	sp,sp,16
    50204fa6:	8082                	ret

0000000050204fa8 <unlock_kernel>:
    50204fa8:	1141                	addi	sp,sp,-16
    50204faa:	e406                	sd	ra,8(sp)
    50204fac:	e022                	sd	s0,0(sp)
    50204fae:	0800                	addi	s0,sp,16
    50204fb0:	00007517          	auipc	a0,0x7
    50204fb4:	9e050513          	addi	a0,a0,-1568 # 5020b990 <kernel_lock>
    50204fb8:	8e6fe0ef          	jal	ra,5020309e <spin_lock_release>
    50204fbc:	0001                	nop
    50204fbe:	60a2                	ld	ra,8(sp)
    50204fc0:	6402                	ld	s0,0(sp)
    50204fc2:	0141                	addi	sp,sp,16
    50204fc4:	8082                	ret

0000000050204fc6 <allocPage>:
    50204fc6:	7179                	addi	sp,sp,-48
    50204fc8:	f422                	sd	s0,40(sp)
    50204fca:	1800                	addi	s0,sp,48
    50204fcc:	87aa                	mv	a5,a0
    50204fce:	fcf42e23          	sw	a5,-36(s0)
    50204fd2:	84018793          	addi	a5,gp,-1984 # 502096a0 <memCurr>
    50204fd6:	6398                	ld	a4,0(a5)
    50204fd8:	6785                	lui	a5,0x1
    50204fda:	17fd                	addi	a5,a5,-1
    50204fdc:	973e                	add	a4,a4,a5
    50204fde:	77fd                	lui	a5,0xfffff
    50204fe0:	8ff9                	and	a5,a5,a4
    50204fe2:	fef43423          	sd	a5,-24(s0)
    50204fe6:	fdc42783          	lw	a5,-36(s0)
    50204fea:	00c7979b          	slliw	a5,a5,0xc
    50204fee:	2781                	sext.w	a5,a5
    50204ff0:	873e                	mv	a4,a5
    50204ff2:	fe843783          	ld	a5,-24(s0)
    50204ff6:	973e                	add	a4,a4,a5
    50204ff8:	84018793          	addi	a5,gp,-1984 # 502096a0 <memCurr>
    50204ffc:	e398                	sd	a4,0(a5)
    50204ffe:	fe843783          	ld	a5,-24(s0)
    50205002:	853e                	mv	a0,a5
    50205004:	7422                	ld	s0,40(sp)
    50205006:	6145                	addi	sp,sp,48
    50205008:	8082                	ret

000000005020500a <kmalloc>:
    5020500a:	7179                	addi	sp,sp,-48
    5020500c:	f422                	sd	s0,40(sp)
    5020500e:	1800                	addi	s0,sp,48
    50205010:	fca43c23          	sd	a0,-40(s0)
    50205014:	84018793          	addi	a5,gp,-1984 # 502096a0 <memCurr>
    50205018:	639c                	ld	a5,0(a5)
    5020501a:	078d                	addi	a5,a5,3
    5020501c:	9bf1                	andi	a5,a5,-4
    5020501e:	fef43423          	sd	a5,-24(s0)
    50205022:	fe843703          	ld	a4,-24(s0)
    50205026:	fd843783          	ld	a5,-40(s0)
    5020502a:	973e                	add	a4,a4,a5
    5020502c:	84018793          	addi	a5,gp,-1984 # 502096a0 <memCurr>
    50205030:	e398                	sd	a4,0(a5)
    50205032:	fe843783          	ld	a5,-24(s0)
    50205036:	853e                	mv	a0,a5
    50205038:	7422                	ld	s0,40(sp)
    5020503a:	6145                	addi	sp,sp,48
    5020503c:	8082                	ret

000000005020503e <handle_syscall>:
    5020503e:	7179                	addi	sp,sp,-48
    50205040:	f406                	sd	ra,40(sp)
    50205042:	f022                	sd	s0,32(sp)
    50205044:	1800                	addi	s0,sp,48
    50205046:	fea43423          	sd	a0,-24(s0)
    5020504a:	feb43023          	sd	a1,-32(s0)
    5020504e:	fcc43c23          	sd	a2,-40(s0)
    50205052:	fe843783          	ld	a5,-24(s0)
    50205056:	1087b783          	ld	a5,264(a5) # fffffffffffff108 <__BSS_END__+0xffffffffafdf1908>
    5020505a:	00478713          	addi	a4,a5,4
    5020505e:	fe843783          	ld	a5,-24(s0)
    50205062:	10e7b423          	sd	a4,264(a5)
    50205066:	fe843783          	ld	a5,-24(s0)
    5020506a:	67dc                	ld	a5,136(a5)
    5020506c:	00008717          	auipc	a4,0x8
    50205070:	0dc70713          	addi	a4,a4,220 # 5020d148 <syscall>
    50205074:	078e                	slli	a5,a5,0x3
    50205076:	97ba                	add	a5,a5,a4
    50205078:	0007b803          	ld	a6,0(a5)
    5020507c:	fe843783          	ld	a5,-24(s0)
    50205080:	6bb8                	ld	a4,80(a5)
    50205082:	fe843783          	ld	a5,-24(s0)
    50205086:	6fb4                	ld	a3,88(a5)
    50205088:	fe843783          	ld	a5,-24(s0)
    5020508c:	73bc                	ld	a5,96(a5)
    5020508e:	863e                	mv	a2,a5
    50205090:	85b6                	mv	a1,a3
    50205092:	853a                	mv	a0,a4
    50205094:	9802                	jalr	a6
    50205096:	87aa                	mv	a5,a0
    50205098:	873e                	mv	a4,a5
    5020509a:	fe843783          	ld	a5,-24(s0)
    5020509e:	ebb8                	sd	a4,80(a5)
    502050a0:	0001                	nop
    502050a2:	70a2                	ld	ra,40(sp)
    502050a4:	7402                	ld	s0,32(sp)
    502050a6:	6145                	addi	sp,sp,48
    502050a8:	8082                	ret

00000000502050aa <kstrlen>:
    502050aa:	7179                	addi	sp,sp,-48
    502050ac:	f422                	sd	s0,40(sp)
    502050ae:	1800                	addi	s0,sp,48
    502050b0:	fca43c23          	sd	a0,-40(s0)
    502050b4:	fe042623          	sw	zero,-20(s0)
    502050b8:	a031                	j	502050c4 <kstrlen+0x1a>
    502050ba:	fec42783          	lw	a5,-20(s0)
    502050be:	2785                	addiw	a5,a5,1
    502050c0:	fef42623          	sw	a5,-20(s0)
    502050c4:	fec42783          	lw	a5,-20(s0)
    502050c8:	fd843703          	ld	a4,-40(s0)
    502050cc:	97ba                	add	a5,a5,a4
    502050ce:	0007c783          	lbu	a5,0(a5)
    502050d2:	f7e5                	bnez	a5,502050ba <kstrlen+0x10>
    502050d4:	fec42783          	lw	a5,-20(s0)
    502050d8:	853e                	mv	a0,a5
    502050da:	7422                	ld	s0,40(sp)
    502050dc:	6145                	addi	sp,sp,48
    502050de:	8082                	ret

00000000502050e0 <kmemcpy>:
    502050e0:	7179                	addi	sp,sp,-48
    502050e2:	f422                	sd	s0,40(sp)
    502050e4:	1800                	addi	s0,sp,48
    502050e6:	fea43423          	sd	a0,-24(s0)
    502050ea:	feb43023          	sd	a1,-32(s0)
    502050ee:	87b2                	mv	a5,a2
    502050f0:	fcf42e23          	sw	a5,-36(s0)
    502050f4:	a035                	j	50205120 <kmemcpy+0x40>
    502050f6:	fe043703          	ld	a4,-32(s0)
    502050fa:	00170793          	addi	a5,a4,1
    502050fe:	fef43023          	sd	a5,-32(s0)
    50205102:	fe843783          	ld	a5,-24(s0)
    50205106:	00178693          	addi	a3,a5,1
    5020510a:	fed43423          	sd	a3,-24(s0)
    5020510e:	00074703          	lbu	a4,0(a4)
    50205112:	00e78023          	sb	a4,0(a5)
    50205116:	fdc42783          	lw	a5,-36(s0)
    5020511a:	37fd                	addiw	a5,a5,-1
    5020511c:	fcf42e23          	sw	a5,-36(s0)
    50205120:	fdc42783          	lw	a5,-36(s0)
    50205124:	2781                	sext.w	a5,a5
    50205126:	fbe1                	bnez	a5,502050f6 <kmemcpy+0x16>
    50205128:	0001                	nop
    5020512a:	0001                	nop
    5020512c:	7422                	ld	s0,40(sp)
    5020512e:	6145                	addi	sp,sp,48
    50205130:	8082                	ret

0000000050205132 <kmemset>:
    50205132:	7179                	addi	sp,sp,-48
    50205134:	f422                	sd	s0,40(sp)
    50205136:	1800                	addi	s0,sp,48
    50205138:	fca43c23          	sd	a0,-40(s0)
    5020513c:	87ae                	mv	a5,a1
    5020513e:	8732                	mv	a4,a2
    50205140:	fcf40ba3          	sb	a5,-41(s0)
    50205144:	87ba                	mv	a5,a4
    50205146:	fcf42823          	sw	a5,-48(s0)
    5020514a:	fd843783          	ld	a5,-40(s0)
    5020514e:	fef43423          	sd	a5,-24(s0)
    50205152:	a005                	j	50205172 <kmemset+0x40>
    50205154:	fe843783          	ld	a5,-24(s0)
    50205158:	00178713          	addi	a4,a5,1
    5020515c:	fee43423          	sd	a4,-24(s0)
    50205160:	fd744703          	lbu	a4,-41(s0)
    50205164:	00e78023          	sb	a4,0(a5)
    50205168:	fd042783          	lw	a5,-48(s0)
    5020516c:	37fd                	addiw	a5,a5,-1
    5020516e:	fcf42823          	sw	a5,-48(s0)
    50205172:	fd042783          	lw	a5,-48(s0)
    50205176:	2781                	sext.w	a5,a5
    50205178:	fff1                	bnez	a5,50205154 <kmemset+0x22>
    5020517a:	0001                	nop
    5020517c:	0001                	nop
    5020517e:	7422                	ld	s0,40(sp)
    50205180:	6145                	addi	sp,sp,48
    50205182:	8082                	ret

0000000050205184 <kbzero>:
    50205184:	1101                	addi	sp,sp,-32
    50205186:	ec06                	sd	ra,24(sp)
    50205188:	e822                	sd	s0,16(sp)
    5020518a:	1000                	addi	s0,sp,32
    5020518c:	fea43423          	sd	a0,-24(s0)
    50205190:	87ae                	mv	a5,a1
    50205192:	fef42223          	sw	a5,-28(s0)
    50205196:	fe442783          	lw	a5,-28(s0)
    5020519a:	863e                	mv	a2,a5
    5020519c:	4581                	li	a1,0
    5020519e:	fe843503          	ld	a0,-24(s0)
    502051a2:	f91ff0ef          	jal	ra,50205132 <kmemset>
    502051a6:	0001                	nop
    502051a8:	60e2                	ld	ra,24(sp)
    502051aa:	6442                	ld	s0,16(sp)
    502051ac:	6105                	addi	sp,sp,32
    502051ae:	8082                	ret

00000000502051b0 <kstrcmp>:
    502051b0:	1101                	addi	sp,sp,-32
    502051b2:	ec22                	sd	s0,24(sp)
    502051b4:	1000                	addi	s0,sp,32
    502051b6:	fea43423          	sd	a0,-24(s0)
    502051ba:	feb43023          	sd	a1,-32(s0)
    502051be:	a0a1                	j	50205206 <kstrcmp+0x56>
    502051c0:	fe843783          	ld	a5,-24(s0)
    502051c4:	0007c703          	lbu	a4,0(a5)
    502051c8:	fe043783          	ld	a5,-32(s0)
    502051cc:	0007c783          	lbu	a5,0(a5)
    502051d0:	02f70163          	beq	a4,a5,502051f2 <kstrcmp+0x42>
    502051d4:	fe843783          	ld	a5,-24(s0)
    502051d8:	0007c783          	lbu	a5,0(a5)
    502051dc:	0007871b          	sext.w	a4,a5
    502051e0:	fe043783          	ld	a5,-32(s0)
    502051e4:	0007c783          	lbu	a5,0(a5)
    502051e8:	2781                	sext.w	a5,a5
    502051ea:	40f707bb          	subw	a5,a4,a5
    502051ee:	2781                	sext.w	a5,a5
    502051f0:	a099                	j	50205236 <kstrcmp+0x86>
    502051f2:	fe843783          	ld	a5,-24(s0)
    502051f6:	0785                	addi	a5,a5,1
    502051f8:	fef43423          	sd	a5,-24(s0)
    502051fc:	fe043783          	ld	a5,-32(s0)
    50205200:	0785                	addi	a5,a5,1
    50205202:	fef43023          	sd	a5,-32(s0)
    50205206:	fe843783          	ld	a5,-24(s0)
    5020520a:	0007c783          	lbu	a5,0(a5)
    5020520e:	c791                	beqz	a5,5020521a <kstrcmp+0x6a>
    50205210:	fe043783          	ld	a5,-32(s0)
    50205214:	0007c783          	lbu	a5,0(a5)
    50205218:	f7c5                	bnez	a5,502051c0 <kstrcmp+0x10>
    5020521a:	fe843783          	ld	a5,-24(s0)
    5020521e:	0007c783          	lbu	a5,0(a5)
    50205222:	0007871b          	sext.w	a4,a5
    50205226:	fe043783          	ld	a5,-32(s0)
    5020522a:	0007c783          	lbu	a5,0(a5)
    5020522e:	2781                	sext.w	a5,a5
    50205230:	40f707bb          	subw	a5,a4,a5
    50205234:	2781                	sext.w	a5,a5
    50205236:	853e                	mv	a0,a5
    50205238:	6462                	ld	s0,24(sp)
    5020523a:	6105                	addi	sp,sp,32
    5020523c:	8082                	ret

000000005020523e <kstrcpy>:
    5020523e:	7179                	addi	sp,sp,-48
    50205240:	f422                	sd	s0,40(sp)
    50205242:	1800                	addi	s0,sp,48
    50205244:	fca43c23          	sd	a0,-40(s0)
    50205248:	fcb43823          	sd	a1,-48(s0)
    5020524c:	fd843783          	ld	a5,-40(s0)
    50205250:	fef43423          	sd	a5,-24(s0)
    50205254:	a00d                	j	50205276 <kstrcpy+0x38>
    50205256:	fd043703          	ld	a4,-48(s0)
    5020525a:	00170793          	addi	a5,a4,1
    5020525e:	fcf43823          	sd	a5,-48(s0)
    50205262:	fd843783          	ld	a5,-40(s0)
    50205266:	00178693          	addi	a3,a5,1
    5020526a:	fcd43c23          	sd	a3,-40(s0)
    5020526e:	00074703          	lbu	a4,0(a4)
    50205272:	00e78023          	sb	a4,0(a5)
    50205276:	fd043783          	ld	a5,-48(s0)
    5020527a:	0007c783          	lbu	a5,0(a5)
    5020527e:	ffe1                	bnez	a5,50205256 <kstrcpy+0x18>
    50205280:	fd843783          	ld	a5,-40(s0)
    50205284:	00078023          	sb	zero,0(a5)
    50205288:	fe843783          	ld	a5,-24(s0)
    5020528c:	853e                	mv	a0,a5
    5020528e:	7422                	ld	s0,40(sp)
    50205290:	6145                	addi	sp,sp,48
    50205292:	8082                	ret

0000000050205294 <kstrcat>:
    50205294:	7179                	addi	sp,sp,-48
    50205296:	f422                	sd	s0,40(sp)
    50205298:	1800                	addi	s0,sp,48
    5020529a:	fca43c23          	sd	a0,-40(s0)
    5020529e:	fcb43823          	sd	a1,-48(s0)
    502052a2:	fd843783          	ld	a5,-40(s0)
    502052a6:	fef43423          	sd	a5,-24(s0)
    502052aa:	a031                	j	502052b6 <kstrcat+0x22>
    502052ac:	fd843783          	ld	a5,-40(s0)
    502052b0:	0785                	addi	a5,a5,1
    502052b2:	fcf43c23          	sd	a5,-40(s0)
    502052b6:	fd843783          	ld	a5,-40(s0)
    502052ba:	0007c783          	lbu	a5,0(a5)
    502052be:	f7fd                	bnez	a5,502052ac <kstrcat+0x18>
    502052c0:	a00d                	j	502052e2 <kstrcat+0x4e>
    502052c2:	fd043703          	ld	a4,-48(s0)
    502052c6:	00170793          	addi	a5,a4,1
    502052ca:	fcf43823          	sd	a5,-48(s0)
    502052ce:	fd843783          	ld	a5,-40(s0)
    502052d2:	00178693          	addi	a3,a5,1
    502052d6:	fcd43c23          	sd	a3,-40(s0)
    502052da:	00074703          	lbu	a4,0(a4)
    502052de:	00e78023          	sb	a4,0(a5)
    502052e2:	fd043783          	ld	a5,-48(s0)
    502052e6:	0007c783          	lbu	a5,0(a5)
    502052ea:	ffe1                	bnez	a5,502052c2 <kstrcat+0x2e>
    502052ec:	fd843783          	ld	a5,-40(s0)
    502052f0:	00078023          	sb	zero,0(a5)
    502052f4:	fe843783          	ld	a5,-24(s0)
    502052f8:	853e                	mv	a0,a5
    502052fa:	7422                	ld	s0,40(sp)
    502052fc:	6145                	addi	sp,sp,48
    502052fe:	8082                	ret

0000000050205300 <mini_strlen>:
    50205300:	7179                	addi	sp,sp,-48
    50205302:	f422                	sd	s0,40(sp)
    50205304:	1800                	addi	s0,sp,48
    50205306:	fca43c23          	sd	a0,-40(s0)
    5020530a:	fe042623          	sw	zero,-20(s0)
    5020530e:	a031                	j	5020531a <mini_strlen+0x1a>
    50205310:	fec42783          	lw	a5,-20(s0)
    50205314:	2785                	addiw	a5,a5,1
    50205316:	fef42623          	sw	a5,-20(s0)
    5020531a:	fec46783          	lwu	a5,-20(s0)
    5020531e:	fd843703          	ld	a4,-40(s0)
    50205322:	97ba                	add	a5,a5,a4
    50205324:	0007c783          	lbu	a5,0(a5)
    50205328:	f7e5                	bnez	a5,50205310 <mini_strlen+0x10>
    5020532a:	fec42783          	lw	a5,-20(s0)
    5020532e:	853e                	mv	a0,a5
    50205330:	7422                	ld	s0,40(sp)
    50205332:	6145                	addi	sp,sp,48
    50205334:	8082                	ret

0000000050205336 <mini_itoa>:
    50205336:	715d                	addi	sp,sp,-80
    50205338:	e4a2                	sd	s0,72(sp)
    5020533a:	0880                	addi	s0,sp,80
    5020533c:	fca43423          	sd	a0,-56(s0)
    50205340:	fae43823          	sd	a4,-80(s0)
    50205344:	873e                	mv	a4,a5
    50205346:	87ae                	mv	a5,a1
    50205348:	fcf42223          	sw	a5,-60(s0)
    5020534c:	87b2                	mv	a5,a2
    5020534e:	fcf42023          	sw	a5,-64(s0)
    50205352:	87b6                	mv	a5,a3
    50205354:	faf42e23          	sw	a5,-68(s0)
    50205358:	87ba                	mv	a5,a4
    5020535a:	faf42c23          	sw	a5,-72(s0)
    5020535e:	fb043783          	ld	a5,-80(s0)
    50205362:	fef43423          	sd	a5,-24(s0)
    50205366:	fe042223          	sw	zero,-28(s0)
    5020536a:	fc442783          	lw	a5,-60(s0)
    5020536e:	0007871b          	sext.w	a4,a5
    50205372:	47c1                	li	a5,16
    50205374:	00e7f463          	bgeu	a5,a4,5020537c <mini_itoa+0x46>
    50205378:	4781                	li	a5,0
    5020537a:	aae9                	j	50205554 <mini_itoa+0x21e>
    5020537c:	fc843783          	ld	a5,-56(s0)
    50205380:	0007df63          	bgez	a5,5020539e <mini_itoa+0x68>
    50205384:	fbc42783          	lw	a5,-68(s0)
    50205388:	2781                	sext.w	a5,a5
    5020538a:	eb91                	bnez	a5,5020539e <mini_itoa+0x68>
    5020538c:	4785                	li	a5,1
    5020538e:	fef42223          	sw	a5,-28(s0)
    50205392:	fc843783          	ld	a5,-56(s0)
    50205396:	40f007b3          	neg	a5,a5
    5020539a:	fcf43423          	sd	a5,-56(s0)
    5020539e:	fc042e23          	sw	zero,-36(s0)
    502053a2:	fbc42783          	lw	a5,-68(s0)
    502053a6:	2781                	sext.w	a5,a5
    502053a8:	cb91                	beqz	a5,502053bc <mini_itoa+0x86>
    502053aa:	fc843703          	ld	a4,-56(s0)
    502053ae:	fc446783          	lwu	a5,-60(s0)
    502053b2:	02f777b3          	remu	a5,a4,a5
    502053b6:	fcf42e23          	sw	a5,-36(s0)
    502053ba:	a809                	j	502053cc <mini_itoa+0x96>
    502053bc:	fc446783          	lwu	a5,-60(s0)
    502053c0:	fc843703          	ld	a4,-56(s0)
    502053c4:	02f767b3          	rem	a5,a4,a5
    502053c8:	fcf42e23          	sw	a5,-36(s0)
    502053cc:	fdc42783          	lw	a5,-36(s0)
    502053d0:	0007871b          	sext.w	a4,a5
    502053d4:	47a5                	li	a5,9
    502053d6:	00e7cb63          	blt	a5,a4,502053ec <mini_itoa+0xb6>
    502053da:	fdc42783          	lw	a5,-36(s0)
    502053de:	0ff7f793          	andi	a5,a5,255
    502053e2:	0307879b          	addiw	a5,a5,48
    502053e6:	0ff7f713          	andi	a4,a5,255
    502053ea:	a025                	j	50205412 <mini_itoa+0xdc>
    502053ec:	fc042783          	lw	a5,-64(s0)
    502053f0:	2781                	sext.w	a5,a5
    502053f2:	c781                	beqz	a5,502053fa <mini_itoa+0xc4>
    502053f4:	04100793          	li	a5,65
    502053f8:	a019                	j	502053fe <mini_itoa+0xc8>
    502053fa:	06100793          	li	a5,97
    502053fe:	fdc42703          	lw	a4,-36(s0)
    50205402:	0ff77713          	andi	a4,a4,255
    50205406:	9fb9                	addw	a5,a5,a4
    50205408:	0ff7f793          	andi	a5,a5,255
    5020540c:	37d9                	addiw	a5,a5,-10
    5020540e:	0ff7f713          	andi	a4,a5,255
    50205412:	fe843783          	ld	a5,-24(s0)
    50205416:	00178693          	addi	a3,a5,1
    5020541a:	fed43423          	sd	a3,-24(s0)
    5020541e:	00e78023          	sb	a4,0(a5)
    50205422:	fbc42783          	lw	a5,-68(s0)
    50205426:	2781                	sext.w	a5,a5
    50205428:	cb91                	beqz	a5,5020543c <mini_itoa+0x106>
    5020542a:	fc843703          	ld	a4,-56(s0)
    5020542e:	fc446783          	lwu	a5,-60(s0)
    50205432:	02f757b3          	divu	a5,a4,a5
    50205436:	fcf43423          	sd	a5,-56(s0)
    5020543a:	a809                	j	5020544c <mini_itoa+0x116>
    5020543c:	fc446783          	lwu	a5,-60(s0)
    50205440:	fc843703          	ld	a4,-56(s0)
    50205444:	02f747b3          	div	a5,a4,a5
    50205448:	fcf43423          	sd	a5,-56(s0)
    5020544c:	fc843783          	ld	a5,-56(s0)
    50205450:	f7b9                	bnez	a5,5020539e <mini_itoa+0x68>
    50205452:	fe843703          	ld	a4,-24(s0)
    50205456:	fb043783          	ld	a5,-80(s0)
    5020545a:	40f707b3          	sub	a5,a4,a5
    5020545e:	fef42023          	sw	a5,-32(s0)
    50205462:	a005                	j	50205482 <mini_itoa+0x14c>
    50205464:	fe843783          	ld	a5,-24(s0)
    50205468:	00178713          	addi	a4,a5,1
    5020546c:	fee43423          	sd	a4,-24(s0)
    50205470:	03000713          	li	a4,48
    50205474:	00e78023          	sb	a4,0(a5)
    50205478:	fe042783          	lw	a5,-32(s0)
    5020547c:	2785                	addiw	a5,a5,1
    5020547e:	fef42023          	sw	a5,-32(s0)
    50205482:	fe042703          	lw	a4,-32(s0)
    50205486:	fb842783          	lw	a5,-72(s0)
    5020548a:	2701                	sext.w	a4,a4
    5020548c:	2781                	sext.w	a5,a5
    5020548e:	fcf76be3          	bltu	a4,a5,50205464 <mini_itoa+0x12e>
    50205492:	fe442783          	lw	a5,-28(s0)
    50205496:	2781                	sext.w	a5,a5
    50205498:	cb99                	beqz	a5,502054ae <mini_itoa+0x178>
    5020549a:	fe843783          	ld	a5,-24(s0)
    5020549e:	00178713          	addi	a4,a5,1
    502054a2:	fee43423          	sd	a4,-24(s0)
    502054a6:	02d00713          	li	a4,45
    502054aa:	00e78023          	sb	a4,0(a5)
    502054ae:	fe843783          	ld	a5,-24(s0)
    502054b2:	00078023          	sb	zero,0(a5)
    502054b6:	fe843703          	ld	a4,-24(s0)
    502054ba:	fb043783          	ld	a5,-80(s0)
    502054be:	40f707b3          	sub	a5,a4,a5
    502054c2:	fcf42c23          	sw	a5,-40(s0)
    502054c6:	fe042023          	sw	zero,-32(s0)
    502054ca:	a885                	j	5020553a <mini_itoa+0x204>
    502054cc:	fe046783          	lwu	a5,-32(s0)
    502054d0:	fb043703          	ld	a4,-80(s0)
    502054d4:	97ba                	add	a5,a5,a4
    502054d6:	0007c783          	lbu	a5,0(a5)
    502054da:	fcf40ba3          	sb	a5,-41(s0)
    502054de:	fd842703          	lw	a4,-40(s0)
    502054e2:	fe042783          	lw	a5,-32(s0)
    502054e6:	40f707bb          	subw	a5,a4,a5
    502054ea:	2781                	sext.w	a5,a5
    502054ec:	37fd                	addiw	a5,a5,-1
    502054ee:	2781                	sext.w	a5,a5
    502054f0:	1782                	slli	a5,a5,0x20
    502054f2:	9381                	srli	a5,a5,0x20
    502054f4:	fb043703          	ld	a4,-80(s0)
    502054f8:	973e                	add	a4,a4,a5
    502054fa:	fe046783          	lwu	a5,-32(s0)
    502054fe:	fb043683          	ld	a3,-80(s0)
    50205502:	97b6                	add	a5,a5,a3
    50205504:	00074703          	lbu	a4,0(a4)
    50205508:	00e78023          	sb	a4,0(a5)
    5020550c:	fd842703          	lw	a4,-40(s0)
    50205510:	fe042783          	lw	a5,-32(s0)
    50205514:	40f707bb          	subw	a5,a4,a5
    50205518:	2781                	sext.w	a5,a5
    5020551a:	37fd                	addiw	a5,a5,-1
    5020551c:	2781                	sext.w	a5,a5
    5020551e:	1782                	slli	a5,a5,0x20
    50205520:	9381                	srli	a5,a5,0x20
    50205522:	fb043703          	ld	a4,-80(s0)
    50205526:	97ba                	add	a5,a5,a4
    50205528:	fd744703          	lbu	a4,-41(s0)
    5020552c:	00e78023          	sb	a4,0(a5)
    50205530:	fe042783          	lw	a5,-32(s0)
    50205534:	2785                	addiw	a5,a5,1
    50205536:	fef42023          	sw	a5,-32(s0)
    5020553a:	fd842783          	lw	a5,-40(s0)
    5020553e:	0017d79b          	srliw	a5,a5,0x1
    50205542:	0007871b          	sext.w	a4,a5
    50205546:	fe042783          	lw	a5,-32(s0)
    5020554a:	2781                	sext.w	a5,a5
    5020554c:	f8e7e0e3          	bltu	a5,a4,502054cc <mini_itoa+0x196>
    50205550:	fd842783          	lw	a5,-40(s0)
    50205554:	853e                	mv	a0,a5
    50205556:	6426                	ld	s0,72(sp)
    50205558:	6161                	addi	sp,sp,80
    5020555a:	8082                	ret

000000005020555c <_putc>:
    5020555c:	1101                	addi	sp,sp,-32
    5020555e:	ec22                	sd	s0,24(sp)
    50205560:	1000                	addi	s0,sp,32
    50205562:	87aa                	mv	a5,a0
    50205564:	feb43023          	sd	a1,-32(s0)
    50205568:	fef42623          	sw	a5,-20(s0)
    5020556c:	fe043783          	ld	a5,-32(s0)
    50205570:	6798                	ld	a4,8(a5)
    50205572:	fe043783          	ld	a5,-32(s0)
    50205576:	639c                	ld	a5,0(a5)
    50205578:	40f707b3          	sub	a5,a4,a5
    5020557c:	2781                	sext.w	a5,a5
    5020557e:	2785                	addiw	a5,a5,1
    50205580:	0007871b          	sext.w	a4,a5
    50205584:	fe043783          	ld	a5,-32(s0)
    50205588:	4b9c                	lw	a5,16(a5)
    5020558a:	00f76463          	bltu	a4,a5,50205592 <_putc+0x36>
    5020558e:	4781                	li	a5,0
    50205590:	a02d                	j	502055ba <_putc+0x5e>
    50205592:	fe043783          	ld	a5,-32(s0)
    50205596:	679c                	ld	a5,8(a5)
    50205598:	00178693          	addi	a3,a5,1
    5020559c:	fe043703          	ld	a4,-32(s0)
    502055a0:	e714                	sd	a3,8(a4)
    502055a2:	fec42703          	lw	a4,-20(s0)
    502055a6:	0ff77713          	andi	a4,a4,255
    502055aa:	00e78023          	sb	a4,0(a5)
    502055ae:	fe043783          	ld	a5,-32(s0)
    502055b2:	679c                	ld	a5,8(a5)
    502055b4:	00078023          	sb	zero,0(a5)
    502055b8:	4785                	li	a5,1
    502055ba:	853e                	mv	a0,a5
    502055bc:	6462                	ld	s0,24(sp)
    502055be:	6105                	addi	sp,sp,32
    502055c0:	8082                	ret

00000000502055c2 <_puts>:
    502055c2:	7139                	addi	sp,sp,-64
    502055c4:	fc22                	sd	s0,56(sp)
    502055c6:	0080                	addi	s0,sp,64
    502055c8:	fca43c23          	sd	a0,-40(s0)
    502055cc:	87ae                	mv	a5,a1
    502055ce:	fcc43423          	sd	a2,-56(s0)
    502055d2:	fcf42a23          	sw	a5,-44(s0)
    502055d6:	fc843783          	ld	a5,-56(s0)
    502055da:	4b9c                	lw	a5,16(a5)
    502055dc:	02079713          	slli	a4,a5,0x20
    502055e0:	9301                	srli	a4,a4,0x20
    502055e2:	fc843783          	ld	a5,-56(s0)
    502055e6:	6794                	ld	a3,8(a5)
    502055e8:	fc843783          	ld	a5,-56(s0)
    502055ec:	639c                	ld	a5,0(a5)
    502055ee:	40f687b3          	sub	a5,a3,a5
    502055f2:	8f1d                	sub	a4,a4,a5
    502055f4:	fd446783          	lwu	a5,-44(s0)
    502055f8:	02e7c463          	blt	a5,a4,50205620 <_puts+0x5e>
    502055fc:	fc843783          	ld	a5,-56(s0)
    50205600:	4b98                	lw	a4,16(a5)
    50205602:	fc843783          	ld	a5,-56(s0)
    50205606:	6794                	ld	a3,8(a5)
    50205608:	fc843783          	ld	a5,-56(s0)
    5020560c:	639c                	ld	a5,0(a5)
    5020560e:	40f687b3          	sub	a5,a3,a5
    50205612:	2781                	sext.w	a5,a5
    50205614:	40f707bb          	subw	a5,a4,a5
    50205618:	2781                	sext.w	a5,a5
    5020561a:	37fd                	addiw	a5,a5,-1
    5020561c:	fcf42a23          	sw	a5,-44(s0)
    50205620:	fe042623          	sw	zero,-20(s0)
    50205624:	a03d                	j	50205652 <_puts+0x90>
    50205626:	fec46783          	lwu	a5,-20(s0)
    5020562a:	fd843703          	ld	a4,-40(s0)
    5020562e:	973e                	add	a4,a4,a5
    50205630:	fc843783          	ld	a5,-56(s0)
    50205634:	679c                	ld	a5,8(a5)
    50205636:	00178613          	addi	a2,a5,1
    5020563a:	fc843683          	ld	a3,-56(s0)
    5020563e:	e690                	sd	a2,8(a3)
    50205640:	00074703          	lbu	a4,0(a4)
    50205644:	00e78023          	sb	a4,0(a5)
    50205648:	fec42783          	lw	a5,-20(s0)
    5020564c:	2785                	addiw	a5,a5,1
    5020564e:	fef42623          	sw	a5,-20(s0)
    50205652:	fec42703          	lw	a4,-20(s0)
    50205656:	fd442783          	lw	a5,-44(s0)
    5020565a:	2701                	sext.w	a4,a4
    5020565c:	2781                	sext.w	a5,a5
    5020565e:	fcf764e3          	bltu	a4,a5,50205626 <_puts+0x64>
    50205662:	fc843783          	ld	a5,-56(s0)
    50205666:	679c                	ld	a5,8(a5)
    50205668:	00078023          	sb	zero,0(a5)
    5020566c:	fd442783          	lw	a5,-44(s0)
    50205670:	853e                	mv	a0,a5
    50205672:	7462                	ld	s0,56(sp)
    50205674:	6121                	addi	sp,sp,64
    50205676:	8082                	ret

0000000050205678 <mini_vsnprintf>:
    50205678:	7119                	addi	sp,sp,-128
    5020567a:	fc86                	sd	ra,120(sp)
    5020567c:	f8a2                	sd	s0,112(sp)
    5020567e:	0100                	addi	s0,sp,128
    50205680:	f8a43c23          	sd	a0,-104(s0)
    50205684:	87ae                	mv	a5,a1
    50205686:	f8c43423          	sd	a2,-120(s0)
    5020568a:	f8d43023          	sd	a3,-128(s0)
    5020568e:	f8f42a23          	sw	a5,-108(s0)
    50205692:	f9843783          	ld	a5,-104(s0)
    50205696:	fcf43023          	sd	a5,-64(s0)
    5020569a:	f9843783          	ld	a5,-104(s0)
    5020569e:	fcf43423          	sd	a5,-56(s0)
    502056a2:	f9442783          	lw	a5,-108(s0)
    502056a6:	fcf42823          	sw	a5,-48(s0)
    502056aa:	a4f9                	j	50205978 <mini_vsnprintf+0x300>
    502056ac:	fc843703          	ld	a4,-56(s0)
    502056b0:	fc043783          	ld	a5,-64(s0)
    502056b4:	40f707b3          	sub	a5,a4,a5
    502056b8:	2781                	sext.w	a5,a5
    502056ba:	2785                	addiw	a5,a5,1
    502056bc:	0007871b          	sext.w	a4,a5
    502056c0:	fd042783          	lw	a5,-48(s0)
    502056c4:	2cf77b63          	bgeu	a4,a5,5020599a <mini_vsnprintf+0x322>
    502056c8:	fef44783          	lbu	a5,-17(s0)
    502056cc:	0ff7f713          	andi	a4,a5,255
    502056d0:	02500793          	li	a5,37
    502056d4:	00f70c63          	beq	a4,a5,502056ec <mini_vsnprintf+0x74>
    502056d8:	fef44783          	lbu	a5,-17(s0)
    502056dc:	2781                	sext.w	a5,a5
    502056de:	fc040713          	addi	a4,s0,-64
    502056e2:	85ba                	mv	a1,a4
    502056e4:	853e                	mv	a0,a5
    502056e6:	e77ff0ef          	jal	ra,5020555c <_putc>
    502056ea:	a479                	j	50205978 <mini_vsnprintf+0x300>
    502056ec:	fe040723          	sb	zero,-18(s0)
    502056f0:	fe042423          	sw	zero,-24(s0)
    502056f4:	f8843783          	ld	a5,-120(s0)
    502056f8:	00178713          	addi	a4,a5,1
    502056fc:	f8e43423          	sd	a4,-120(s0)
    50205700:	0007c783          	lbu	a5,0(a5)
    50205704:	fef407a3          	sb	a5,-17(s0)
    50205708:	fef44783          	lbu	a5,-17(s0)
    5020570c:	0ff7f713          	andi	a4,a5,255
    50205710:	03000793          	li	a5,48
    50205714:	06f71b63          	bne	a4,a5,5020578a <mini_vsnprintf+0x112>
    50205718:	a891                	j	5020576c <mini_vsnprintf+0xf4>
    5020571a:	fef44783          	lbu	a5,-17(s0)
    5020571e:	0ff7f793          	andi	a5,a5,255
    50205722:	26078e63          	beqz	a5,5020599e <mini_vsnprintf+0x326>
    50205726:	fef44783          	lbu	a5,-17(s0)
    5020572a:	0ff7f713          	andi	a4,a5,255
    5020572e:	02f00793          	li	a5,47
    50205732:	04e7fc63          	bgeu	a5,a4,5020578a <mini_vsnprintf+0x112>
    50205736:	fef44783          	lbu	a5,-17(s0)
    5020573a:	0ff7f713          	andi	a4,a5,255
    5020573e:	03900793          	li	a5,57
    50205742:	04e7e463          	bltu	a5,a4,5020578a <mini_vsnprintf+0x112>
    50205746:	fee44703          	lbu	a4,-18(s0)
    5020574a:	87ba                	mv	a5,a4
    5020574c:	0027979b          	slliw	a5,a5,0x2
    50205750:	9fb9                	addw	a5,a5,a4
    50205752:	0017979b          	slliw	a5,a5,0x1
    50205756:	0ff7f793          	andi	a5,a5,255
    5020575a:	fef44703          	lbu	a4,-17(s0)
    5020575e:	9fb9                	addw	a5,a5,a4
    50205760:	0ff7f793          	andi	a5,a5,255
    50205764:	fd07879b          	addiw	a5,a5,-48
    50205768:	fef40723          	sb	a5,-18(s0)
    5020576c:	f8843783          	ld	a5,-120(s0)
    50205770:	00178713          	addi	a4,a5,1
    50205774:	f8e43423          	sd	a4,-120(s0)
    50205778:	0007c783          	lbu	a5,0(a5)
    5020577c:	fef407a3          	sb	a5,-17(s0)
    50205780:	fef44783          	lbu	a5,-17(s0)
    50205784:	0ff7f793          	andi	a5,a5,255
    50205788:	fbc9                	bnez	a5,5020571a <mini_vsnprintf+0xa2>
    5020578a:	fef44783          	lbu	a5,-17(s0)
    5020578e:	0ff7f713          	andi	a4,a5,255
    50205792:	06c00793          	li	a5,108
    50205796:	00f71f63          	bne	a4,a5,502057b4 <mini_vsnprintf+0x13c>
    5020579a:	4785                	li	a5,1
    5020579c:	fef42423          	sw	a5,-24(s0)
    502057a0:	f8843783          	ld	a5,-120(s0)
    502057a4:	00178713          	addi	a4,a5,1
    502057a8:	f8e43423          	sd	a4,-120(s0)
    502057ac:	0007c783          	lbu	a5,0(a5)
    502057b0:	fef407a3          	sb	a5,-17(s0)
    502057b4:	fef44783          	lbu	a5,-17(s0)
    502057b8:	2781                	sext.w	a5,a5
    502057ba:	1e078463          	beqz	a5,502059a2 <mini_vsnprintf+0x32a>
    502057be:	873e                	mv	a4,a5
    502057c0:	1a074263          	bltz	a4,50205964 <mini_vsnprintf+0x2ec>
    502057c4:	86be                	mv	a3,a5
    502057c6:	07800713          	li	a4,120
    502057ca:	18d74d63          	blt	a4,a3,50205964 <mini_vsnprintf+0x2ec>
    502057ce:	86be                	mv	a3,a5
    502057d0:	05800713          	li	a4,88
    502057d4:	18e6c863          	blt	a3,a4,50205964 <mini_vsnprintf+0x2ec>
    502057d8:	fa87869b          	addiw	a3,a5,-88
    502057dc:	0006871b          	sext.w	a4,a3
    502057e0:	02000793          	li	a5,32
    502057e4:	18e7e063          	bltu	a5,a4,50205964 <mini_vsnprintf+0x2ec>
    502057e8:	02069793          	slli	a5,a3,0x20
    502057ec:	9381                	srli	a5,a5,0x20
    502057ee:	00279713          	slli	a4,a5,0x2
    502057f2:	00003797          	auipc	a5,0x3
    502057f6:	52e78793          	addi	a5,a5,1326 # 50208d20 <__FUNCTION__.1403+0x30>
    502057fa:	97ba                	add	a5,a5,a4
    502057fc:	439c                	lw	a5,0(a5)
    502057fe:	0007871b          	sext.w	a4,a5
    50205802:	00003797          	auipc	a5,0x3
    50205806:	51e78793          	addi	a5,a5,1310 # 50208d20 <__FUNCTION__.1403+0x30>
    5020580a:	97ba                	add	a5,a5,a4
    5020580c:	8782                	jr	a5
    5020580e:	4785                	li	a5,1
    50205810:	fef42423          	sw	a5,-24(s0)
    50205814:	a295                	j	50205978 <mini_vsnprintf+0x300>
    50205816:	fe842783          	lw	a5,-24(s0)
    5020581a:	2781                	sext.w	a5,a5
    5020581c:	ef81                	bnez	a5,50205834 <mini_vsnprintf+0x1bc>
    5020581e:	f8043783          	ld	a5,-128(s0)
    50205822:	00878713          	addi	a4,a5,8
    50205826:	f8e43023          	sd	a4,-128(s0)
    5020582a:	439c                	lw	a5,0(a5)
    5020582c:	02079513          	slli	a0,a5,0x20
    50205830:	9101                	srli	a0,a0,0x20
    50205832:	a809                	j	50205844 <mini_vsnprintf+0x1cc>
    50205834:	f8043783          	ld	a5,-128(s0)
    50205838:	00878713          	addi	a4,a5,8
    5020583c:	f8e43023          	sd	a4,-128(s0)
    50205840:	639c                	ld	a5,0(a5)
    50205842:	853e                	mv	a0,a5
    50205844:	fef44783          	lbu	a5,-17(s0)
    50205848:	0007871b          	sext.w	a4,a5
    5020584c:	07500793          	li	a5,117
    50205850:	40f707b3          	sub	a5,a4,a5
    50205854:	0017b793          	seqz	a5,a5
    50205858:	0ff7f793          	andi	a5,a5,255
    5020585c:	0007869b          	sext.w	a3,a5
    50205860:	fee44783          	lbu	a5,-18(s0)
    50205864:	2781                	sext.w	a5,a5
    50205866:	fa840713          	addi	a4,s0,-88
    5020586a:	4601                	li	a2,0
    5020586c:	45a9                	li	a1,10
    5020586e:	ac9ff0ef          	jal	ra,50205336 <mini_itoa>
    50205872:	87aa                	mv	a5,a0
    50205874:	fcf42e23          	sw	a5,-36(s0)
    50205878:	fc040693          	addi	a3,s0,-64
    5020587c:	fdc42703          	lw	a4,-36(s0)
    50205880:	fa840793          	addi	a5,s0,-88
    50205884:	8636                	mv	a2,a3
    50205886:	85ba                	mv	a1,a4
    50205888:	853e                	mv	a0,a5
    5020588a:	d39ff0ef          	jal	ra,502055c2 <_puts>
    5020588e:	fe042423          	sw	zero,-24(s0)
    50205892:	a0dd                	j	50205978 <mini_vsnprintf+0x300>
    50205894:	fe842783          	lw	a5,-24(s0)
    50205898:	2781                	sext.w	a5,a5
    5020589a:	ef81                	bnez	a5,502058b2 <mini_vsnprintf+0x23a>
    5020589c:	f8043783          	ld	a5,-128(s0)
    502058a0:	00878713          	addi	a4,a5,8
    502058a4:	f8e43023          	sd	a4,-128(s0)
    502058a8:	439c                	lw	a5,0(a5)
    502058aa:	02079513          	slli	a0,a5,0x20
    502058ae:	9101                	srli	a0,a0,0x20
    502058b0:	a809                	j	502058c2 <mini_vsnprintf+0x24a>
    502058b2:	f8043783          	ld	a5,-128(s0)
    502058b6:	00878713          	addi	a4,a5,8
    502058ba:	f8e43023          	sd	a4,-128(s0)
    502058be:	639c                	ld	a5,0(a5)
    502058c0:	853e                	mv	a0,a5
    502058c2:	fef44783          	lbu	a5,-17(s0)
    502058c6:	0007871b          	sext.w	a4,a5
    502058ca:	05800793          	li	a5,88
    502058ce:	40f707b3          	sub	a5,a4,a5
    502058d2:	0017b793          	seqz	a5,a5
    502058d6:	0ff7f793          	andi	a5,a5,255
    502058da:	0007861b          	sext.w	a2,a5
    502058de:	fee44783          	lbu	a5,-18(s0)
    502058e2:	2781                	sext.w	a5,a5
    502058e4:	fa840713          	addi	a4,s0,-88
    502058e8:	4685                	li	a3,1
    502058ea:	45c1                	li	a1,16
    502058ec:	a4bff0ef          	jal	ra,50205336 <mini_itoa>
    502058f0:	87aa                	mv	a5,a0
    502058f2:	fcf42e23          	sw	a5,-36(s0)
    502058f6:	fc040693          	addi	a3,s0,-64
    502058fa:	fdc42703          	lw	a4,-36(s0)
    502058fe:	fa840793          	addi	a5,s0,-88
    50205902:	8636                	mv	a2,a3
    50205904:	85ba                	mv	a1,a4
    50205906:	853e                	mv	a0,a5
    50205908:	cbbff0ef          	jal	ra,502055c2 <_puts>
    5020590c:	fe042423          	sw	zero,-24(s0)
    50205910:	a0a5                	j	50205978 <mini_vsnprintf+0x300>
    50205912:	f8043783          	ld	a5,-128(s0)
    50205916:	00878713          	addi	a4,a5,8
    5020591a:	f8e43023          	sd	a4,-128(s0)
    5020591e:	439c                	lw	a5,0(a5)
    50205920:	0ff7f793          	andi	a5,a5,255
    50205924:	2781                	sext.w	a5,a5
    50205926:	fc040713          	addi	a4,s0,-64
    5020592a:	85ba                	mv	a1,a4
    5020592c:	853e                	mv	a0,a5
    5020592e:	c2fff0ef          	jal	ra,5020555c <_putc>
    50205932:	a099                	j	50205978 <mini_vsnprintf+0x300>
    50205934:	f8043783          	ld	a5,-128(s0)
    50205938:	00878713          	addi	a4,a5,8
    5020593c:	f8e43023          	sd	a4,-128(s0)
    50205940:	639c                	ld	a5,0(a5)
    50205942:	fef43023          	sd	a5,-32(s0)
    50205946:	fe043503          	ld	a0,-32(s0)
    5020594a:	9b7ff0ef          	jal	ra,50205300 <mini_strlen>
    5020594e:	87aa                	mv	a5,a0
    50205950:	2781                	sext.w	a5,a5
    50205952:	fc040713          	addi	a4,s0,-64
    50205956:	863a                	mv	a2,a4
    50205958:	85be                	mv	a1,a5
    5020595a:	fe043503          	ld	a0,-32(s0)
    5020595e:	c65ff0ef          	jal	ra,502055c2 <_puts>
    50205962:	a819                	j	50205978 <mini_vsnprintf+0x300>
    50205964:	fef44783          	lbu	a5,-17(s0)
    50205968:	2781                	sext.w	a5,a5
    5020596a:	fc040713          	addi	a4,s0,-64
    5020596e:	85ba                	mv	a1,a4
    50205970:	853e                	mv	a0,a5
    50205972:	bebff0ef          	jal	ra,5020555c <_putc>
    50205976:	0001                	nop
    50205978:	f8843783          	ld	a5,-120(s0)
    5020597c:	00178713          	addi	a4,a5,1
    50205980:	f8e43423          	sd	a4,-120(s0)
    50205984:	0007c783          	lbu	a5,0(a5)
    50205988:	fef407a3          	sb	a5,-17(s0)
    5020598c:	fef44783          	lbu	a5,-17(s0)
    50205990:	0ff7f793          	andi	a5,a5,255
    50205994:	d0079ce3          	bnez	a5,502056ac <mini_vsnprintf+0x34>
    50205998:	a031                	j	502059a4 <mini_vsnprintf+0x32c>
    5020599a:	0001                	nop
    5020599c:	a021                	j	502059a4 <mini_vsnprintf+0x32c>
    5020599e:	0001                	nop
    502059a0:	a011                	j	502059a4 <mini_vsnprintf+0x32c>
    502059a2:	0001                	nop
    502059a4:	fc843703          	ld	a4,-56(s0)
    502059a8:	fc043783          	ld	a5,-64(s0)
    502059ac:	40f707b3          	sub	a5,a4,a5
    502059b0:	2781                	sext.w	a5,a5
    502059b2:	853e                	mv	a0,a5
    502059b4:	70e6                	ld	ra,120(sp)
    502059b6:	7446                	ld	s0,112(sp)
    502059b8:	6109                	addi	sp,sp,128
    502059ba:	8082                	ret

00000000502059bc <_vprint>:
    502059bc:	7129                	addi	sp,sp,-320
    502059be:	fe06                	sd	ra,312(sp)
    502059c0:	fa22                	sd	s0,304(sp)
    502059c2:	0280                	addi	s0,sp,320
    502059c4:	eca43c23          	sd	a0,-296(s0)
    502059c8:	ecb43823          	sd	a1,-304(s0)
    502059cc:	ecc43423          	sd	a2,-312(s0)
    502059d0:	ed043783          	ld	a5,-304(s0)
    502059d4:	fef43023          	sd	a5,-32(s0)
    502059d8:	fe043703          	ld	a4,-32(s0)
    502059dc:	ee040793          	addi	a5,s0,-288
    502059e0:	86ba                	mv	a3,a4
    502059e2:	ed843603          	ld	a2,-296(s0)
    502059e6:	10000593          	li	a1,256
    502059ea:	853e                	mv	a0,a5
    502059ec:	c8dff0ef          	jal	ra,50205678 <mini_vsnprintf>
    502059f0:	87aa                	mv	a5,a0
    502059f2:	fef42623          	sw	a5,-20(s0)
    502059f6:	fec42783          	lw	a5,-20(s0)
    502059fa:	ff040713          	addi	a4,s0,-16
    502059fe:	97ba                	add	a5,a5,a4
    50205a00:	ee078823          	sb	zero,-272(a5)
    50205a04:	ee040793          	addi	a5,s0,-288
    50205a08:	ec843703          	ld	a4,-312(s0)
    50205a0c:	853e                	mv	a0,a5
    50205a0e:	9702                	jalr	a4
    50205a10:	fec42783          	lw	a5,-20(s0)
    50205a14:	853e                	mv	a0,a5
    50205a16:	70f2                	ld	ra,312(sp)
    50205a18:	7452                	ld	s0,304(sp)
    50205a1a:	6131                	addi	sp,sp,320
    50205a1c:	8082                	ret

0000000050205a1e <vprintk>:
    50205a1e:	1101                	addi	sp,sp,-32
    50205a20:	ec06                	sd	ra,24(sp)
    50205a22:	e822                	sd	s0,16(sp)
    50205a24:	1000                	addi	s0,sp,32
    50205a26:	fea43423          	sd	a0,-24(s0)
    50205a2a:	feb43023          	sd	a1,-32(s0)
    50205a2e:	ffffc617          	auipc	a2,0xffffc
    50205a32:	8a860613          	addi	a2,a2,-1880 # 502012d6 <port_write>
    50205a36:	fe043583          	ld	a1,-32(s0)
    50205a3a:	fe843503          	ld	a0,-24(s0)
    50205a3e:	f7fff0ef          	jal	ra,502059bc <_vprint>
    50205a42:	87aa                	mv	a5,a0
    50205a44:	853e                	mv	a0,a5
    50205a46:	60e2                	ld	ra,24(sp)
    50205a48:	6442                	ld	s0,16(sp)
    50205a4a:	6105                	addi	sp,sp,32
    50205a4c:	8082                	ret

0000000050205a4e <printk>:
    50205a4e:	7159                	addi	sp,sp,-112
    50205a50:	f406                	sd	ra,40(sp)
    50205a52:	f022                	sd	s0,32(sp)
    50205a54:	1800                	addi	s0,sp,48
    50205a56:	fca43c23          	sd	a0,-40(s0)
    50205a5a:	e40c                	sd	a1,8(s0)
    50205a5c:	e810                	sd	a2,16(s0)
    50205a5e:	ec14                	sd	a3,24(s0)
    50205a60:	f018                	sd	a4,32(s0)
    50205a62:	f41c                	sd	a5,40(s0)
    50205a64:	03043823          	sd	a6,48(s0)
    50205a68:	03143c23          	sd	a7,56(s0)
    50205a6c:	fe042623          	sw	zero,-20(s0)
    50205a70:	04040793          	addi	a5,s0,64
    50205a74:	fcf43823          	sd	a5,-48(s0)
    50205a78:	fd043783          	ld	a5,-48(s0)
    50205a7c:	fc878793          	addi	a5,a5,-56
    50205a80:	fef43023          	sd	a5,-32(s0)
    50205a84:	fe043783          	ld	a5,-32(s0)
    50205a88:	85be                	mv	a1,a5
    50205a8a:	fd843503          	ld	a0,-40(s0)
    50205a8e:	f91ff0ef          	jal	ra,50205a1e <vprintk>
    50205a92:	87aa                	mv	a5,a0
    50205a94:	fef42623          	sw	a5,-20(s0)
    50205a98:	fec42783          	lw	a5,-20(s0)
    50205a9c:	853e                	mv	a0,a5
    50205a9e:	70a2                	ld	ra,40(sp)
    50205aa0:	7402                	ld	s0,32(sp)
    50205aa2:	6165                	addi	sp,sp,112
    50205aa4:	8082                	ret

0000000050205aa6 <vprints>:
    50205aa6:	1101                	addi	sp,sp,-32
    50205aa8:	ec06                	sd	ra,24(sp)
    50205aaa:	e822                	sd	s0,16(sp)
    50205aac:	1000                	addi	s0,sp,32
    50205aae:	fea43423          	sd	a0,-24(s0)
    50205ab2:	feb43023          	sd	a1,-32(s0)
    50205ab6:	ffffd617          	auipc	a2,0xffffd
    50205aba:	09460613          	addi	a2,a2,148 # 50202b4a <screen_write>
    50205abe:	fe043583          	ld	a1,-32(s0)
    50205ac2:	fe843503          	ld	a0,-24(s0)
    50205ac6:	ef7ff0ef          	jal	ra,502059bc <_vprint>
    50205aca:	87aa                	mv	a5,a0
    50205acc:	853e                	mv	a0,a5
    50205ace:	60e2                	ld	ra,24(sp)
    50205ad0:	6442                	ld	s0,16(sp)
    50205ad2:	6105                	addi	sp,sp,32
    50205ad4:	8082                	ret

0000000050205ad6 <prints>:
    50205ad6:	7159                	addi	sp,sp,-112
    50205ad8:	f406                	sd	ra,40(sp)
    50205ada:	f022                	sd	s0,32(sp)
    50205adc:	1800                	addi	s0,sp,48
    50205ade:	fca43c23          	sd	a0,-40(s0)
    50205ae2:	e40c                	sd	a1,8(s0)
    50205ae4:	e810                	sd	a2,16(s0)
    50205ae6:	ec14                	sd	a3,24(s0)
    50205ae8:	f018                	sd	a4,32(s0)
    50205aea:	f41c                	sd	a5,40(s0)
    50205aec:	03043823          	sd	a6,48(s0)
    50205af0:	03143c23          	sd	a7,56(s0)
    50205af4:	fe042623          	sw	zero,-20(s0)
    50205af8:	04040793          	addi	a5,s0,64
    50205afc:	fcf43823          	sd	a5,-48(s0)
    50205b00:	fd043783          	ld	a5,-48(s0)
    50205b04:	fc878793          	addi	a5,a5,-56
    50205b08:	fef43023          	sd	a5,-32(s0)
    50205b0c:	fe043783          	ld	a5,-32(s0)
    50205b10:	85be                	mv	a1,a5
    50205b12:	fd843503          	ld	a0,-40(s0)
    50205b16:	f91ff0ef          	jal	ra,50205aa6 <vprints>
    50205b1a:	87aa                	mv	a5,a0
    50205b1c:	fef42623          	sw	a5,-20(s0)
    50205b20:	fec42783          	lw	a5,-20(s0)
    50205b24:	853e                	mv	a0,a5
    50205b26:	70a2                	ld	ra,40(sp)
    50205b28:	7402                	ld	s0,32(sp)
    50205b2a:	6165                	addi	sp,sp,112
    50205b2c:	8082                	ret

0000000050205b2e <mini_itoa>:
    50205b2e:	715d                	addi	sp,sp,-80
    50205b30:	e4a2                	sd	s0,72(sp)
    50205b32:	0880                	addi	s0,sp,80
    50205b34:	fca43423          	sd	a0,-56(s0)
    50205b38:	fae43823          	sd	a4,-80(s0)
    50205b3c:	873e                	mv	a4,a5
    50205b3e:	87ae                	mv	a5,a1
    50205b40:	fcf42223          	sw	a5,-60(s0)
    50205b44:	87b2                	mv	a5,a2
    50205b46:	fcf42023          	sw	a5,-64(s0)
    50205b4a:	87b6                	mv	a5,a3
    50205b4c:	faf42e23          	sw	a5,-68(s0)
    50205b50:	87ba                	mv	a5,a4
    50205b52:	faf42c23          	sw	a5,-72(s0)
    50205b56:	fb043783          	ld	a5,-80(s0)
    50205b5a:	fef43423          	sd	a5,-24(s0)
    50205b5e:	fe042223          	sw	zero,-28(s0)
    50205b62:	fc442783          	lw	a5,-60(s0)
    50205b66:	0007871b          	sext.w	a4,a5
    50205b6a:	47c1                	li	a5,16
    50205b6c:	00e7f463          	bgeu	a5,a4,50205b74 <mini_itoa+0x46>
    50205b70:	4781                	li	a5,0
    50205b72:	a255                	j	50205d16 <mini_itoa+0x1e8>
    50205b74:	fc843783          	ld	a5,-56(s0)
    50205b78:	0007df63          	bgez	a5,50205b96 <mini_itoa+0x68>
    50205b7c:	fbc42783          	lw	a5,-68(s0)
    50205b80:	2781                	sext.w	a5,a5
    50205b82:	eb91                	bnez	a5,50205b96 <mini_itoa+0x68>
    50205b84:	4785                	li	a5,1
    50205b86:	fef42223          	sw	a5,-28(s0)
    50205b8a:	fc843783          	ld	a5,-56(s0)
    50205b8e:	40f007b3          	neg	a5,a5
    50205b92:	fcf43423          	sd	a5,-56(s0)
    50205b96:	fc446783          	lwu	a5,-60(s0)
    50205b9a:	fc843703          	ld	a4,-56(s0)
    50205b9e:	02f767b3          	rem	a5,a4,a5
    50205ba2:	fcf42e23          	sw	a5,-36(s0)
    50205ba6:	fdc42783          	lw	a5,-36(s0)
    50205baa:	0007871b          	sext.w	a4,a5
    50205bae:	47a5                	li	a5,9
    50205bb0:	00e7cb63          	blt	a5,a4,50205bc6 <mini_itoa+0x98>
    50205bb4:	fdc42783          	lw	a5,-36(s0)
    50205bb8:	0ff7f793          	andi	a5,a5,255
    50205bbc:	0307879b          	addiw	a5,a5,48
    50205bc0:	0ff7f713          	andi	a4,a5,255
    50205bc4:	a025                	j	50205bec <mini_itoa+0xbe>
    50205bc6:	fc042783          	lw	a5,-64(s0)
    50205bca:	2781                	sext.w	a5,a5
    50205bcc:	c781                	beqz	a5,50205bd4 <mini_itoa+0xa6>
    50205bce:	04100793          	li	a5,65
    50205bd2:	a019                	j	50205bd8 <mini_itoa+0xaa>
    50205bd4:	06100793          	li	a5,97
    50205bd8:	fdc42703          	lw	a4,-36(s0)
    50205bdc:	0ff77713          	andi	a4,a4,255
    50205be0:	9fb9                	addw	a5,a5,a4
    50205be2:	0ff7f793          	andi	a5,a5,255
    50205be6:	37d9                	addiw	a5,a5,-10
    50205be8:	0ff7f713          	andi	a4,a5,255
    50205bec:	fe843783          	ld	a5,-24(s0)
    50205bf0:	00178693          	addi	a3,a5,1
    50205bf4:	fed43423          	sd	a3,-24(s0)
    50205bf8:	00e78023          	sb	a4,0(a5)
    50205bfc:	fc446783          	lwu	a5,-60(s0)
    50205c00:	fc843703          	ld	a4,-56(s0)
    50205c04:	02f747b3          	div	a5,a4,a5
    50205c08:	fcf43423          	sd	a5,-56(s0)
    50205c0c:	fc843783          	ld	a5,-56(s0)
    50205c10:	f8f043e3          	bgtz	a5,50205b96 <mini_itoa+0x68>
    50205c14:	fe843703          	ld	a4,-24(s0)
    50205c18:	fb043783          	ld	a5,-80(s0)
    50205c1c:	40f707b3          	sub	a5,a4,a5
    50205c20:	fef42023          	sw	a5,-32(s0)
    50205c24:	a005                	j	50205c44 <mini_itoa+0x116>
    50205c26:	fe843783          	ld	a5,-24(s0)
    50205c2a:	00178713          	addi	a4,a5,1
    50205c2e:	fee43423          	sd	a4,-24(s0)
    50205c32:	03000713          	li	a4,48
    50205c36:	00e78023          	sb	a4,0(a5)
    50205c3a:	fe042783          	lw	a5,-32(s0)
    50205c3e:	2785                	addiw	a5,a5,1
    50205c40:	fef42023          	sw	a5,-32(s0)
    50205c44:	fe042703          	lw	a4,-32(s0)
    50205c48:	fb842783          	lw	a5,-72(s0)
    50205c4c:	2701                	sext.w	a4,a4
    50205c4e:	2781                	sext.w	a5,a5
    50205c50:	fcf76be3          	bltu	a4,a5,50205c26 <mini_itoa+0xf8>
    50205c54:	fe442783          	lw	a5,-28(s0)
    50205c58:	2781                	sext.w	a5,a5
    50205c5a:	cb99                	beqz	a5,50205c70 <mini_itoa+0x142>
    50205c5c:	fe843783          	ld	a5,-24(s0)
    50205c60:	00178713          	addi	a4,a5,1
    50205c64:	fee43423          	sd	a4,-24(s0)
    50205c68:	02d00713          	li	a4,45
    50205c6c:	00e78023          	sb	a4,0(a5)
    50205c70:	fe843783          	ld	a5,-24(s0)
    50205c74:	00078023          	sb	zero,0(a5)
    50205c78:	fe843703          	ld	a4,-24(s0)
    50205c7c:	fb043783          	ld	a5,-80(s0)
    50205c80:	40f707b3          	sub	a5,a4,a5
    50205c84:	fcf42c23          	sw	a5,-40(s0)
    50205c88:	fe042023          	sw	zero,-32(s0)
    50205c8c:	a885                	j	50205cfc <mini_itoa+0x1ce>
    50205c8e:	fe046783          	lwu	a5,-32(s0)
    50205c92:	fb043703          	ld	a4,-80(s0)
    50205c96:	97ba                	add	a5,a5,a4
    50205c98:	0007c783          	lbu	a5,0(a5)
    50205c9c:	fcf40ba3          	sb	a5,-41(s0)
    50205ca0:	fd842703          	lw	a4,-40(s0)
    50205ca4:	fe042783          	lw	a5,-32(s0)
    50205ca8:	40f707bb          	subw	a5,a4,a5
    50205cac:	2781                	sext.w	a5,a5
    50205cae:	37fd                	addiw	a5,a5,-1
    50205cb0:	2781                	sext.w	a5,a5
    50205cb2:	1782                	slli	a5,a5,0x20
    50205cb4:	9381                	srli	a5,a5,0x20
    50205cb6:	fb043703          	ld	a4,-80(s0)
    50205cba:	973e                	add	a4,a4,a5
    50205cbc:	fe046783          	lwu	a5,-32(s0)
    50205cc0:	fb043683          	ld	a3,-80(s0)
    50205cc4:	97b6                	add	a5,a5,a3
    50205cc6:	00074703          	lbu	a4,0(a4)
    50205cca:	00e78023          	sb	a4,0(a5)
    50205cce:	fd842703          	lw	a4,-40(s0)
    50205cd2:	fe042783          	lw	a5,-32(s0)
    50205cd6:	40f707bb          	subw	a5,a4,a5
    50205cda:	2781                	sext.w	a5,a5
    50205cdc:	37fd                	addiw	a5,a5,-1
    50205cde:	2781                	sext.w	a5,a5
    50205ce0:	1782                	slli	a5,a5,0x20
    50205ce2:	9381                	srli	a5,a5,0x20
    50205ce4:	fb043703          	ld	a4,-80(s0)
    50205ce8:	97ba                	add	a5,a5,a4
    50205cea:	fd744703          	lbu	a4,-41(s0)
    50205cee:	00e78023          	sb	a4,0(a5)
    50205cf2:	fe042783          	lw	a5,-32(s0)
    50205cf6:	2785                	addiw	a5,a5,1
    50205cf8:	fef42023          	sw	a5,-32(s0)
    50205cfc:	fd842783          	lw	a5,-40(s0)
    50205d00:	0017d79b          	srliw	a5,a5,0x1
    50205d04:	0007871b          	sext.w	a4,a5
    50205d08:	fe042783          	lw	a5,-32(s0)
    50205d0c:	2781                	sext.w	a5,a5
    50205d0e:	f8e7e0e3          	bltu	a5,a4,50205c8e <mini_itoa+0x160>
    50205d12:	fd842783          	lw	a5,-40(s0)
    50205d16:	853e                	mv	a0,a5
    50205d18:	6426                	ld	s0,72(sp)
    50205d1a:	6161                	addi	sp,sp,80
    50205d1c:	8082                	ret

0000000050205d1e <_putc>:
    50205d1e:	1101                	addi	sp,sp,-32
    50205d20:	ec22                	sd	s0,24(sp)
    50205d22:	1000                	addi	s0,sp,32
    50205d24:	87aa                	mv	a5,a0
    50205d26:	feb43023          	sd	a1,-32(s0)
    50205d2a:	fef42623          	sw	a5,-20(s0)
    50205d2e:	fe043783          	ld	a5,-32(s0)
    50205d32:	6798                	ld	a4,8(a5)
    50205d34:	fe043783          	ld	a5,-32(s0)
    50205d38:	639c                	ld	a5,0(a5)
    50205d3a:	40f707b3          	sub	a5,a4,a5
    50205d3e:	2781                	sext.w	a5,a5
    50205d40:	2785                	addiw	a5,a5,1
    50205d42:	0007871b          	sext.w	a4,a5
    50205d46:	fe043783          	ld	a5,-32(s0)
    50205d4a:	4b9c                	lw	a5,16(a5)
    50205d4c:	00f76463          	bltu	a4,a5,50205d54 <_putc+0x36>
    50205d50:	4781                	li	a5,0
    50205d52:	a02d                	j	50205d7c <_putc+0x5e>
    50205d54:	fe043783          	ld	a5,-32(s0)
    50205d58:	679c                	ld	a5,8(a5)
    50205d5a:	00178693          	addi	a3,a5,1
    50205d5e:	fe043703          	ld	a4,-32(s0)
    50205d62:	e714                	sd	a3,8(a4)
    50205d64:	fec42703          	lw	a4,-20(s0)
    50205d68:	0ff77713          	andi	a4,a4,255
    50205d6c:	00e78023          	sb	a4,0(a5)
    50205d70:	fe043783          	ld	a5,-32(s0)
    50205d74:	679c                	ld	a5,8(a5)
    50205d76:	00078023          	sb	zero,0(a5)
    50205d7a:	4785                	li	a5,1
    50205d7c:	853e                	mv	a0,a5
    50205d7e:	6462                	ld	s0,24(sp)
    50205d80:	6105                	addi	sp,sp,32
    50205d82:	8082                	ret

0000000050205d84 <_puts>:
    50205d84:	7139                	addi	sp,sp,-64
    50205d86:	fc22                	sd	s0,56(sp)
    50205d88:	0080                	addi	s0,sp,64
    50205d8a:	fca43c23          	sd	a0,-40(s0)
    50205d8e:	87ae                	mv	a5,a1
    50205d90:	fcc43423          	sd	a2,-56(s0)
    50205d94:	fcf42a23          	sw	a5,-44(s0)
    50205d98:	fc843783          	ld	a5,-56(s0)
    50205d9c:	4b9c                	lw	a5,16(a5)
    50205d9e:	02079713          	slli	a4,a5,0x20
    50205da2:	9301                	srli	a4,a4,0x20
    50205da4:	fc843783          	ld	a5,-56(s0)
    50205da8:	6794                	ld	a3,8(a5)
    50205daa:	fc843783          	ld	a5,-56(s0)
    50205dae:	639c                	ld	a5,0(a5)
    50205db0:	40f687b3          	sub	a5,a3,a5
    50205db4:	8f1d                	sub	a4,a4,a5
    50205db6:	fd446783          	lwu	a5,-44(s0)
    50205dba:	02e7c463          	blt	a5,a4,50205de2 <_puts+0x5e>
    50205dbe:	fc843783          	ld	a5,-56(s0)
    50205dc2:	4b98                	lw	a4,16(a5)
    50205dc4:	fc843783          	ld	a5,-56(s0)
    50205dc8:	6794                	ld	a3,8(a5)
    50205dca:	fc843783          	ld	a5,-56(s0)
    50205dce:	639c                	ld	a5,0(a5)
    50205dd0:	40f687b3          	sub	a5,a3,a5
    50205dd4:	2781                	sext.w	a5,a5
    50205dd6:	40f707bb          	subw	a5,a4,a5
    50205dda:	2781                	sext.w	a5,a5
    50205ddc:	37fd                	addiw	a5,a5,-1
    50205dde:	fcf42a23          	sw	a5,-44(s0)
    50205de2:	fe042623          	sw	zero,-20(s0)
    50205de6:	a03d                	j	50205e14 <_puts+0x90>
    50205de8:	fec46783          	lwu	a5,-20(s0)
    50205dec:	fd843703          	ld	a4,-40(s0)
    50205df0:	973e                	add	a4,a4,a5
    50205df2:	fc843783          	ld	a5,-56(s0)
    50205df6:	679c                	ld	a5,8(a5)
    50205df8:	00178613          	addi	a2,a5,1
    50205dfc:	fc843683          	ld	a3,-56(s0)
    50205e00:	e690                	sd	a2,8(a3)
    50205e02:	00074703          	lbu	a4,0(a4)
    50205e06:	00e78023          	sb	a4,0(a5)
    50205e0a:	fec42783          	lw	a5,-20(s0)
    50205e0e:	2785                	addiw	a5,a5,1
    50205e10:	fef42623          	sw	a5,-20(s0)
    50205e14:	fec42703          	lw	a4,-20(s0)
    50205e18:	fd442783          	lw	a5,-44(s0)
    50205e1c:	2701                	sext.w	a4,a4
    50205e1e:	2781                	sext.w	a5,a5
    50205e20:	fcf764e3          	bltu	a4,a5,50205de8 <_puts+0x64>
    50205e24:	fc843783          	ld	a5,-56(s0)
    50205e28:	679c                	ld	a5,8(a5)
    50205e2a:	00078023          	sb	zero,0(a5)
    50205e2e:	fd442783          	lw	a5,-44(s0)
    50205e32:	853e                	mv	a0,a5
    50205e34:	7462                	ld	s0,56(sp)
    50205e36:	6121                	addi	sp,sp,64
    50205e38:	8082                	ret

0000000050205e3a <mini_vsnprintf>:
    50205e3a:	7119                	addi	sp,sp,-128
    50205e3c:	fc86                	sd	ra,120(sp)
    50205e3e:	f8a2                	sd	s0,112(sp)
    50205e40:	0100                	addi	s0,sp,128
    50205e42:	f8a43c23          	sd	a0,-104(s0)
    50205e46:	87ae                	mv	a5,a1
    50205e48:	f8c43423          	sd	a2,-120(s0)
    50205e4c:	f8d43023          	sd	a3,-128(s0)
    50205e50:	f8f42a23          	sw	a5,-108(s0)
    50205e54:	f9843783          	ld	a5,-104(s0)
    50205e58:	fcf43023          	sd	a5,-64(s0)
    50205e5c:	f9843783          	ld	a5,-104(s0)
    50205e60:	fcf43423          	sd	a5,-56(s0)
    50205e64:	f9442783          	lw	a5,-108(s0)
    50205e68:	fcf42823          	sw	a5,-48(s0)
    50205e6c:	a4f9                	j	5020613a <mini_vsnprintf+0x300>
    50205e6e:	fc843703          	ld	a4,-56(s0)
    50205e72:	fc043783          	ld	a5,-64(s0)
    50205e76:	40f707b3          	sub	a5,a4,a5
    50205e7a:	2781                	sext.w	a5,a5
    50205e7c:	2785                	addiw	a5,a5,1
    50205e7e:	0007871b          	sext.w	a4,a5
    50205e82:	fd042783          	lw	a5,-48(s0)
    50205e86:	2cf77b63          	bgeu	a4,a5,5020615c <mini_vsnprintf+0x322>
    50205e8a:	fef44783          	lbu	a5,-17(s0)
    50205e8e:	0ff7f713          	andi	a4,a5,255
    50205e92:	02500793          	li	a5,37
    50205e96:	00f70c63          	beq	a4,a5,50205eae <mini_vsnprintf+0x74>
    50205e9a:	fef44783          	lbu	a5,-17(s0)
    50205e9e:	2781                	sext.w	a5,a5
    50205ea0:	fc040713          	addi	a4,s0,-64
    50205ea4:	85ba                	mv	a1,a4
    50205ea6:	853e                	mv	a0,a5
    50205ea8:	e77ff0ef          	jal	ra,50205d1e <_putc>
    50205eac:	a479                	j	5020613a <mini_vsnprintf+0x300>
    50205eae:	fe040723          	sb	zero,-18(s0)
    50205eb2:	fe042423          	sw	zero,-24(s0)
    50205eb6:	f8843783          	ld	a5,-120(s0)
    50205eba:	00178713          	addi	a4,a5,1
    50205ebe:	f8e43423          	sd	a4,-120(s0)
    50205ec2:	0007c783          	lbu	a5,0(a5)
    50205ec6:	fef407a3          	sb	a5,-17(s0)
    50205eca:	fef44783          	lbu	a5,-17(s0)
    50205ece:	0ff7f713          	andi	a4,a5,255
    50205ed2:	03000793          	li	a5,48
    50205ed6:	06f71b63          	bne	a4,a5,50205f4c <mini_vsnprintf+0x112>
    50205eda:	a891                	j	50205f2e <mini_vsnprintf+0xf4>
    50205edc:	fef44783          	lbu	a5,-17(s0)
    50205ee0:	0ff7f793          	andi	a5,a5,255
    50205ee4:	26078e63          	beqz	a5,50206160 <mini_vsnprintf+0x326>
    50205ee8:	fef44783          	lbu	a5,-17(s0)
    50205eec:	0ff7f713          	andi	a4,a5,255
    50205ef0:	02f00793          	li	a5,47
    50205ef4:	04e7fc63          	bgeu	a5,a4,50205f4c <mini_vsnprintf+0x112>
    50205ef8:	fef44783          	lbu	a5,-17(s0)
    50205efc:	0ff7f713          	andi	a4,a5,255
    50205f00:	03900793          	li	a5,57
    50205f04:	04e7e463          	bltu	a5,a4,50205f4c <mini_vsnprintf+0x112>
    50205f08:	fee44703          	lbu	a4,-18(s0)
    50205f0c:	87ba                	mv	a5,a4
    50205f0e:	0027979b          	slliw	a5,a5,0x2
    50205f12:	9fb9                	addw	a5,a5,a4
    50205f14:	0017979b          	slliw	a5,a5,0x1
    50205f18:	0ff7f793          	andi	a5,a5,255
    50205f1c:	fef44703          	lbu	a4,-17(s0)
    50205f20:	9fb9                	addw	a5,a5,a4
    50205f22:	0ff7f793          	andi	a5,a5,255
    50205f26:	fd07879b          	addiw	a5,a5,-48
    50205f2a:	fef40723          	sb	a5,-18(s0)
    50205f2e:	f8843783          	ld	a5,-120(s0)
    50205f32:	00178713          	addi	a4,a5,1
    50205f36:	f8e43423          	sd	a4,-120(s0)
    50205f3a:	0007c783          	lbu	a5,0(a5)
    50205f3e:	fef407a3          	sb	a5,-17(s0)
    50205f42:	fef44783          	lbu	a5,-17(s0)
    50205f46:	0ff7f793          	andi	a5,a5,255
    50205f4a:	fbc9                	bnez	a5,50205edc <mini_vsnprintf+0xa2>
    50205f4c:	fef44783          	lbu	a5,-17(s0)
    50205f50:	0ff7f713          	andi	a4,a5,255
    50205f54:	06c00793          	li	a5,108
    50205f58:	00f71f63          	bne	a4,a5,50205f76 <mini_vsnprintf+0x13c>
    50205f5c:	4785                	li	a5,1
    50205f5e:	fef42423          	sw	a5,-24(s0)
    50205f62:	f8843783          	ld	a5,-120(s0)
    50205f66:	00178713          	addi	a4,a5,1
    50205f6a:	f8e43423          	sd	a4,-120(s0)
    50205f6e:	0007c783          	lbu	a5,0(a5)
    50205f72:	fef407a3          	sb	a5,-17(s0)
    50205f76:	fef44783          	lbu	a5,-17(s0)
    50205f7a:	2781                	sext.w	a5,a5
    50205f7c:	1e078463          	beqz	a5,50206164 <mini_vsnprintf+0x32a>
    50205f80:	873e                	mv	a4,a5
    50205f82:	1a074263          	bltz	a4,50206126 <mini_vsnprintf+0x2ec>
    50205f86:	86be                	mv	a3,a5
    50205f88:	07800713          	li	a4,120
    50205f8c:	18d74d63          	blt	a4,a3,50206126 <mini_vsnprintf+0x2ec>
    50205f90:	86be                	mv	a3,a5
    50205f92:	05800713          	li	a4,88
    50205f96:	18e6c863          	blt	a3,a4,50206126 <mini_vsnprintf+0x2ec>
    50205f9a:	fa87869b          	addiw	a3,a5,-88
    50205f9e:	0006871b          	sext.w	a4,a3
    50205fa2:	02000793          	li	a5,32
    50205fa6:	18e7e063          	bltu	a5,a4,50206126 <mini_vsnprintf+0x2ec>
    50205faa:	02069793          	slli	a5,a3,0x20
    50205fae:	9381                	srli	a5,a5,0x20
    50205fb0:	00279713          	slli	a4,a5,0x2
    50205fb4:	00003797          	auipc	a5,0x3
    50205fb8:	df078793          	addi	a5,a5,-528 # 50208da4 <__FUNCTION__.1403+0xb4>
    50205fbc:	97ba                	add	a5,a5,a4
    50205fbe:	439c                	lw	a5,0(a5)
    50205fc0:	0007871b          	sext.w	a4,a5
    50205fc4:	00003797          	auipc	a5,0x3
    50205fc8:	de078793          	addi	a5,a5,-544 # 50208da4 <__FUNCTION__.1403+0xb4>
    50205fcc:	97ba                	add	a5,a5,a4
    50205fce:	8782                	jr	a5
    50205fd0:	4785                	li	a5,1
    50205fd2:	fef42423          	sw	a5,-24(s0)
    50205fd6:	a295                	j	5020613a <mini_vsnprintf+0x300>
    50205fd8:	fe842783          	lw	a5,-24(s0)
    50205fdc:	2781                	sext.w	a5,a5
    50205fde:	ef81                	bnez	a5,50205ff6 <mini_vsnprintf+0x1bc>
    50205fe0:	f8043783          	ld	a5,-128(s0)
    50205fe4:	00878713          	addi	a4,a5,8
    50205fe8:	f8e43023          	sd	a4,-128(s0)
    50205fec:	439c                	lw	a5,0(a5)
    50205fee:	02079513          	slli	a0,a5,0x20
    50205ff2:	9101                	srli	a0,a0,0x20
    50205ff4:	a809                	j	50206006 <mini_vsnprintf+0x1cc>
    50205ff6:	f8043783          	ld	a5,-128(s0)
    50205ffa:	00878713          	addi	a4,a5,8
    50205ffe:	f8e43023          	sd	a4,-128(s0)
    50206002:	639c                	ld	a5,0(a5)
    50206004:	853e                	mv	a0,a5
    50206006:	fef44783          	lbu	a5,-17(s0)
    5020600a:	0007871b          	sext.w	a4,a5
    5020600e:	07500793          	li	a5,117
    50206012:	40f707b3          	sub	a5,a4,a5
    50206016:	0017b793          	seqz	a5,a5
    5020601a:	0ff7f793          	andi	a5,a5,255
    5020601e:	0007869b          	sext.w	a3,a5
    50206022:	fee44783          	lbu	a5,-18(s0)
    50206026:	2781                	sext.w	a5,a5
    50206028:	fa840713          	addi	a4,s0,-88
    5020602c:	4601                	li	a2,0
    5020602e:	45a9                	li	a1,10
    50206030:	affff0ef          	jal	ra,50205b2e <mini_itoa>
    50206034:	87aa                	mv	a5,a0
    50206036:	fcf42e23          	sw	a5,-36(s0)
    5020603a:	fc040693          	addi	a3,s0,-64
    5020603e:	fdc42703          	lw	a4,-36(s0)
    50206042:	fa840793          	addi	a5,s0,-88
    50206046:	8636                	mv	a2,a3
    50206048:	85ba                	mv	a1,a4
    5020604a:	853e                	mv	a0,a5
    5020604c:	d39ff0ef          	jal	ra,50205d84 <_puts>
    50206050:	fe042423          	sw	zero,-24(s0)
    50206054:	a0dd                	j	5020613a <mini_vsnprintf+0x300>
    50206056:	fe842783          	lw	a5,-24(s0)
    5020605a:	2781                	sext.w	a5,a5
    5020605c:	ef81                	bnez	a5,50206074 <mini_vsnprintf+0x23a>
    5020605e:	f8043783          	ld	a5,-128(s0)
    50206062:	00878713          	addi	a4,a5,8
    50206066:	f8e43023          	sd	a4,-128(s0)
    5020606a:	439c                	lw	a5,0(a5)
    5020606c:	02079513          	slli	a0,a5,0x20
    50206070:	9101                	srli	a0,a0,0x20
    50206072:	a809                	j	50206084 <mini_vsnprintf+0x24a>
    50206074:	f8043783          	ld	a5,-128(s0)
    50206078:	00878713          	addi	a4,a5,8
    5020607c:	f8e43023          	sd	a4,-128(s0)
    50206080:	639c                	ld	a5,0(a5)
    50206082:	853e                	mv	a0,a5
    50206084:	fef44783          	lbu	a5,-17(s0)
    50206088:	0007871b          	sext.w	a4,a5
    5020608c:	05800793          	li	a5,88
    50206090:	40f707b3          	sub	a5,a4,a5
    50206094:	0017b793          	seqz	a5,a5
    50206098:	0ff7f793          	andi	a5,a5,255
    5020609c:	0007861b          	sext.w	a2,a5
    502060a0:	fee44783          	lbu	a5,-18(s0)
    502060a4:	2781                	sext.w	a5,a5
    502060a6:	fa840713          	addi	a4,s0,-88
    502060aa:	4685                	li	a3,1
    502060ac:	45c1                	li	a1,16
    502060ae:	a81ff0ef          	jal	ra,50205b2e <mini_itoa>
    502060b2:	87aa                	mv	a5,a0
    502060b4:	fcf42e23          	sw	a5,-36(s0)
    502060b8:	fc040693          	addi	a3,s0,-64
    502060bc:	fdc42703          	lw	a4,-36(s0)
    502060c0:	fa840793          	addi	a5,s0,-88
    502060c4:	8636                	mv	a2,a3
    502060c6:	85ba                	mv	a1,a4
    502060c8:	853e                	mv	a0,a5
    502060ca:	cbbff0ef          	jal	ra,50205d84 <_puts>
    502060ce:	fe042423          	sw	zero,-24(s0)
    502060d2:	a0a5                	j	5020613a <mini_vsnprintf+0x300>
    502060d4:	f8043783          	ld	a5,-128(s0)
    502060d8:	00878713          	addi	a4,a5,8
    502060dc:	f8e43023          	sd	a4,-128(s0)
    502060e0:	439c                	lw	a5,0(a5)
    502060e2:	0ff7f793          	andi	a5,a5,255
    502060e6:	2781                	sext.w	a5,a5
    502060e8:	fc040713          	addi	a4,s0,-64
    502060ec:	85ba                	mv	a1,a4
    502060ee:	853e                	mv	a0,a5
    502060f0:	c2fff0ef          	jal	ra,50205d1e <_putc>
    502060f4:	a099                	j	5020613a <mini_vsnprintf+0x300>
    502060f6:	f8043783          	ld	a5,-128(s0)
    502060fa:	00878713          	addi	a4,a5,8
    502060fe:	f8e43023          	sd	a4,-128(s0)
    50206102:	639c                	ld	a5,0(a5)
    50206104:	fef43023          	sd	a5,-32(s0)
    50206108:	fe043503          	ld	a0,-32(s0)
    5020610c:	126000ef          	jal	ra,50206232 <strlen>
    50206110:	87aa                	mv	a5,a0
    50206112:	2781                	sext.w	a5,a5
    50206114:	fc040713          	addi	a4,s0,-64
    50206118:	863a                	mv	a2,a4
    5020611a:	85be                	mv	a1,a5
    5020611c:	fe043503          	ld	a0,-32(s0)
    50206120:	c65ff0ef          	jal	ra,50205d84 <_puts>
    50206124:	a819                	j	5020613a <mini_vsnprintf+0x300>
    50206126:	fef44783          	lbu	a5,-17(s0)
    5020612a:	2781                	sext.w	a5,a5
    5020612c:	fc040713          	addi	a4,s0,-64
    50206130:	85ba                	mv	a1,a4
    50206132:	853e                	mv	a0,a5
    50206134:	bebff0ef          	jal	ra,50205d1e <_putc>
    50206138:	0001                	nop
    5020613a:	f8843783          	ld	a5,-120(s0)
    5020613e:	00178713          	addi	a4,a5,1
    50206142:	f8e43423          	sd	a4,-120(s0)
    50206146:	0007c783          	lbu	a5,0(a5)
    5020614a:	fef407a3          	sb	a5,-17(s0)
    5020614e:	fef44783          	lbu	a5,-17(s0)
    50206152:	0ff7f793          	andi	a5,a5,255
    50206156:	d0079ce3          	bnez	a5,50205e6e <mini_vsnprintf+0x34>
    5020615a:	a031                	j	50206166 <mini_vsnprintf+0x32c>
    5020615c:	0001                	nop
    5020615e:	a021                	j	50206166 <mini_vsnprintf+0x32c>
    50206160:	0001                	nop
    50206162:	a011                	j	50206166 <mini_vsnprintf+0x32c>
    50206164:	0001                	nop
    50206166:	fc843703          	ld	a4,-56(s0)
    5020616a:	fc043783          	ld	a5,-64(s0)
    5020616e:	40f707b3          	sub	a5,a4,a5
    50206172:	2781                	sext.w	a5,a5
    50206174:	853e                	mv	a0,a5
    50206176:	70e6                	ld	ra,120(sp)
    50206178:	7446                	ld	s0,112(sp)
    5020617a:	6109                	addi	sp,sp,128
    5020617c:	8082                	ret

000000005020617e <vprintf>:
    5020617e:	7169                	addi	sp,sp,-304
    50206180:	f606                	sd	ra,296(sp)
    50206182:	f222                	sd	s0,288(sp)
    50206184:	1a00                	addi	s0,sp,304
    50206186:	eca43c23          	sd	a0,-296(s0)
    5020618a:	ecb43823          	sd	a1,-304(s0)
    5020618e:	ed043783          	ld	a5,-304(s0)
    50206192:	fef43023          	sd	a5,-32(s0)
    50206196:	fe043703          	ld	a4,-32(s0)
    5020619a:	ee040793          	addi	a5,s0,-288
    5020619e:	86ba                	mv	a3,a4
    502061a0:	ed843603          	ld	a2,-296(s0)
    502061a4:	10000593          	li	a1,256
    502061a8:	853e                	mv	a0,a5
    502061aa:	c91ff0ef          	jal	ra,50205e3a <mini_vsnprintf>
    502061ae:	87aa                	mv	a5,a0
    502061b0:	fef42623          	sw	a5,-20(s0)
    502061b4:	fec42783          	lw	a5,-20(s0)
    502061b8:	ff040713          	addi	a4,s0,-16
    502061bc:	97ba                	add	a5,a5,a4
    502061be:	ee078823          	sb	zero,-272(a5)
    502061c2:	ee040793          	addi	a5,s0,-288
    502061c6:	853e                	mv	a0,a5
    502061c8:	7a0000ef          	jal	ra,50206968 <sys_write>
    502061cc:	fec42783          	lw	a5,-20(s0)
    502061d0:	853e                	mv	a0,a5
    502061d2:	70b2                	ld	ra,296(sp)
    502061d4:	7412                	ld	s0,288(sp)
    502061d6:	6155                	addi	sp,sp,304
    502061d8:	8082                	ret

00000000502061da <printf>:
    502061da:	7159                	addi	sp,sp,-112
    502061dc:	f406                	sd	ra,40(sp)
    502061de:	f022                	sd	s0,32(sp)
    502061e0:	1800                	addi	s0,sp,48
    502061e2:	fca43c23          	sd	a0,-40(s0)
    502061e6:	e40c                	sd	a1,8(s0)
    502061e8:	e810                	sd	a2,16(s0)
    502061ea:	ec14                	sd	a3,24(s0)
    502061ec:	f018                	sd	a4,32(s0)
    502061ee:	f41c                	sd	a5,40(s0)
    502061f0:	03043823          	sd	a6,48(s0)
    502061f4:	03143c23          	sd	a7,56(s0)
    502061f8:	fe042623          	sw	zero,-20(s0)
    502061fc:	04040793          	addi	a5,s0,64
    50206200:	fcf43823          	sd	a5,-48(s0)
    50206204:	fd043783          	ld	a5,-48(s0)
    50206208:	fc878793          	addi	a5,a5,-56
    5020620c:	fef43023          	sd	a5,-32(s0)
    50206210:	fe043783          	ld	a5,-32(s0)
    50206214:	85be                	mv	a1,a5
    50206216:	fd843503          	ld	a0,-40(s0)
    5020621a:	f65ff0ef          	jal	ra,5020617e <vprintf>
    5020621e:	87aa                	mv	a5,a0
    50206220:	fef42623          	sw	a5,-20(s0)
    50206224:	fec42783          	lw	a5,-20(s0)
    50206228:	853e                	mv	a0,a5
    5020622a:	70a2                	ld	ra,40(sp)
    5020622c:	7402                	ld	s0,32(sp)
    5020622e:	6165                	addi	sp,sp,112
    50206230:	8082                	ret

0000000050206232 <strlen>:
    50206232:	7179                	addi	sp,sp,-48
    50206234:	f422                	sd	s0,40(sp)
    50206236:	1800                	addi	s0,sp,48
    50206238:	fca43c23          	sd	a0,-40(s0)
    5020623c:	fe042623          	sw	zero,-20(s0)
    50206240:	a031                	j	5020624c <strlen+0x1a>
    50206242:	fec42783          	lw	a5,-20(s0)
    50206246:	2785                	addiw	a5,a5,1
    50206248:	fef42623          	sw	a5,-20(s0)
    5020624c:	fec42783          	lw	a5,-20(s0)
    50206250:	fd843703          	ld	a4,-40(s0)
    50206254:	97ba                	add	a5,a5,a4
    50206256:	0007c783          	lbu	a5,0(a5)
    5020625a:	f7e5                	bnez	a5,50206242 <strlen+0x10>
    5020625c:	fec42783          	lw	a5,-20(s0)
    50206260:	853e                	mv	a0,a5
    50206262:	7422                	ld	s0,40(sp)
    50206264:	6145                	addi	sp,sp,48
    50206266:	8082                	ret

0000000050206268 <memcpy>:
    50206268:	7179                	addi	sp,sp,-48
    5020626a:	f422                	sd	s0,40(sp)
    5020626c:	1800                	addi	s0,sp,48
    5020626e:	fea43423          	sd	a0,-24(s0)
    50206272:	feb43023          	sd	a1,-32(s0)
    50206276:	87b2                	mv	a5,a2
    50206278:	fcf42e23          	sw	a5,-36(s0)
    5020627c:	a035                	j	502062a8 <memcpy+0x40>
    5020627e:	fe043703          	ld	a4,-32(s0)
    50206282:	00170793          	addi	a5,a4,1
    50206286:	fef43023          	sd	a5,-32(s0)
    5020628a:	fe843783          	ld	a5,-24(s0)
    5020628e:	00178693          	addi	a3,a5,1
    50206292:	fed43423          	sd	a3,-24(s0)
    50206296:	00074703          	lbu	a4,0(a4)
    5020629a:	00e78023          	sb	a4,0(a5)
    5020629e:	fdc42783          	lw	a5,-36(s0)
    502062a2:	37fd                	addiw	a5,a5,-1
    502062a4:	fcf42e23          	sw	a5,-36(s0)
    502062a8:	fdc42783          	lw	a5,-36(s0)
    502062ac:	2781                	sext.w	a5,a5
    502062ae:	fbe1                	bnez	a5,5020627e <memcpy+0x16>
    502062b0:	0001                	nop
    502062b2:	0001                	nop
    502062b4:	7422                	ld	s0,40(sp)
    502062b6:	6145                	addi	sp,sp,48
    502062b8:	8082                	ret

00000000502062ba <memset>:
    502062ba:	7179                	addi	sp,sp,-48
    502062bc:	f422                	sd	s0,40(sp)
    502062be:	1800                	addi	s0,sp,48
    502062c0:	fca43c23          	sd	a0,-40(s0)
    502062c4:	87ae                	mv	a5,a1
    502062c6:	8732                	mv	a4,a2
    502062c8:	fcf40ba3          	sb	a5,-41(s0)
    502062cc:	87ba                	mv	a5,a4
    502062ce:	fcf42823          	sw	a5,-48(s0)
    502062d2:	fd843783          	ld	a5,-40(s0)
    502062d6:	fef43423          	sd	a5,-24(s0)
    502062da:	a005                	j	502062fa <memset+0x40>
    502062dc:	fe843783          	ld	a5,-24(s0)
    502062e0:	00178713          	addi	a4,a5,1
    502062e4:	fee43423          	sd	a4,-24(s0)
    502062e8:	fd744703          	lbu	a4,-41(s0)
    502062ec:	00e78023          	sb	a4,0(a5)
    502062f0:	fd042783          	lw	a5,-48(s0)
    502062f4:	37fd                	addiw	a5,a5,-1
    502062f6:	fcf42823          	sw	a5,-48(s0)
    502062fa:	fd042783          	lw	a5,-48(s0)
    502062fe:	2781                	sext.w	a5,a5
    50206300:	fff1                	bnez	a5,502062dc <memset+0x22>
    50206302:	0001                	nop
    50206304:	0001                	nop
    50206306:	7422                	ld	s0,40(sp)
    50206308:	6145                	addi	sp,sp,48
    5020630a:	8082                	ret

000000005020630c <bzero>:
    5020630c:	1101                	addi	sp,sp,-32
    5020630e:	ec06                	sd	ra,24(sp)
    50206310:	e822                	sd	s0,16(sp)
    50206312:	1000                	addi	s0,sp,32
    50206314:	fea43423          	sd	a0,-24(s0)
    50206318:	87ae                	mv	a5,a1
    5020631a:	fef42223          	sw	a5,-28(s0)
    5020631e:	fe442783          	lw	a5,-28(s0)
    50206322:	863e                	mv	a2,a5
    50206324:	4581                	li	a1,0
    50206326:	fe843503          	ld	a0,-24(s0)
    5020632a:	f91ff0ef          	jal	ra,502062ba <memset>
    5020632e:	0001                	nop
    50206330:	60e2                	ld	ra,24(sp)
    50206332:	6442                	ld	s0,16(sp)
    50206334:	6105                	addi	sp,sp,32
    50206336:	8082                	ret

0000000050206338 <strcmp>:
    50206338:	1101                	addi	sp,sp,-32
    5020633a:	ec22                	sd	s0,24(sp)
    5020633c:	1000                	addi	s0,sp,32
    5020633e:	fea43423          	sd	a0,-24(s0)
    50206342:	feb43023          	sd	a1,-32(s0)
    50206346:	a0a1                	j	5020638e <strcmp+0x56>
    50206348:	fe843783          	ld	a5,-24(s0)
    5020634c:	0007c703          	lbu	a4,0(a5)
    50206350:	fe043783          	ld	a5,-32(s0)
    50206354:	0007c783          	lbu	a5,0(a5)
    50206358:	02f70163          	beq	a4,a5,5020637a <strcmp+0x42>
    5020635c:	fe843783          	ld	a5,-24(s0)
    50206360:	0007c783          	lbu	a5,0(a5)
    50206364:	0007871b          	sext.w	a4,a5
    50206368:	fe043783          	ld	a5,-32(s0)
    5020636c:	0007c783          	lbu	a5,0(a5)
    50206370:	2781                	sext.w	a5,a5
    50206372:	40f707bb          	subw	a5,a4,a5
    50206376:	2781                	sext.w	a5,a5
    50206378:	a099                	j	502063be <strcmp+0x86>
    5020637a:	fe843783          	ld	a5,-24(s0)
    5020637e:	0785                	addi	a5,a5,1
    50206380:	fef43423          	sd	a5,-24(s0)
    50206384:	fe043783          	ld	a5,-32(s0)
    50206388:	0785                	addi	a5,a5,1
    5020638a:	fef43023          	sd	a5,-32(s0)
    5020638e:	fe843783          	ld	a5,-24(s0)
    50206392:	0007c783          	lbu	a5,0(a5)
    50206396:	c791                	beqz	a5,502063a2 <strcmp+0x6a>
    50206398:	fe043783          	ld	a5,-32(s0)
    5020639c:	0007c783          	lbu	a5,0(a5)
    502063a0:	f7c5                	bnez	a5,50206348 <strcmp+0x10>
    502063a2:	fe843783          	ld	a5,-24(s0)
    502063a6:	0007c783          	lbu	a5,0(a5)
    502063aa:	0007871b          	sext.w	a4,a5
    502063ae:	fe043783          	ld	a5,-32(s0)
    502063b2:	0007c783          	lbu	a5,0(a5)
    502063b6:	2781                	sext.w	a5,a5
    502063b8:	40f707bb          	subw	a5,a4,a5
    502063bc:	2781                	sext.w	a5,a5
    502063be:	853e                	mv	a0,a5
    502063c0:	6462                	ld	s0,24(sp)
    502063c2:	6105                	addi	sp,sp,32
    502063c4:	8082                	ret

00000000502063c6 <strcpy>:
    502063c6:	7179                	addi	sp,sp,-48
    502063c8:	f422                	sd	s0,40(sp)
    502063ca:	1800                	addi	s0,sp,48
    502063cc:	fca43c23          	sd	a0,-40(s0)
    502063d0:	fcb43823          	sd	a1,-48(s0)
    502063d4:	fd843783          	ld	a5,-40(s0)
    502063d8:	fef43423          	sd	a5,-24(s0)
    502063dc:	a00d                	j	502063fe <strcpy+0x38>
    502063de:	fd043703          	ld	a4,-48(s0)
    502063e2:	00170793          	addi	a5,a4,1
    502063e6:	fcf43823          	sd	a5,-48(s0)
    502063ea:	fd843783          	ld	a5,-40(s0)
    502063ee:	00178693          	addi	a3,a5,1
    502063f2:	fcd43c23          	sd	a3,-40(s0)
    502063f6:	00074703          	lbu	a4,0(a4)
    502063fa:	00e78023          	sb	a4,0(a5)
    502063fe:	fd043783          	ld	a5,-48(s0)
    50206402:	0007c783          	lbu	a5,0(a5)
    50206406:	ffe1                	bnez	a5,502063de <strcpy+0x18>
    50206408:	fd843783          	ld	a5,-40(s0)
    5020640c:	00078023          	sb	zero,0(a5)
    50206410:	fe843783          	ld	a5,-24(s0)
    50206414:	853e                	mv	a0,a5
    50206416:	7422                	ld	s0,40(sp)
    50206418:	6145                	addi	sp,sp,48
    5020641a:	8082                	ret

000000005020641c <strcat>:
    5020641c:	7179                	addi	sp,sp,-48
    5020641e:	f422                	sd	s0,40(sp)
    50206420:	1800                	addi	s0,sp,48
    50206422:	fca43c23          	sd	a0,-40(s0)
    50206426:	fcb43823          	sd	a1,-48(s0)
    5020642a:	fd843783          	ld	a5,-40(s0)
    5020642e:	fef43423          	sd	a5,-24(s0)
    50206432:	a031                	j	5020643e <strcat+0x22>
    50206434:	fd843783          	ld	a5,-40(s0)
    50206438:	0785                	addi	a5,a5,1
    5020643a:	fcf43c23          	sd	a5,-40(s0)
    5020643e:	fd843783          	ld	a5,-40(s0)
    50206442:	0007c783          	lbu	a5,0(a5)
    50206446:	f7fd                	bnez	a5,50206434 <strcat+0x18>
    50206448:	a00d                	j	5020646a <strcat+0x4e>
    5020644a:	fd043703          	ld	a4,-48(s0)
    5020644e:	00170793          	addi	a5,a4,1
    50206452:	fcf43823          	sd	a5,-48(s0)
    50206456:	fd843783          	ld	a5,-40(s0)
    5020645a:	00178693          	addi	a3,a5,1
    5020645e:	fcd43c23          	sd	a3,-40(s0)
    50206462:	00074703          	lbu	a4,0(a4)
    50206466:	00e78023          	sb	a4,0(a5)
    5020646a:	fd043783          	ld	a5,-48(s0)
    5020646e:	0007c783          	lbu	a5,0(a5)
    50206472:	ffe1                	bnez	a5,5020644a <strcat+0x2e>
    50206474:	fd843783          	ld	a5,-40(s0)
    50206478:	00078023          	sb	zero,0(a5)
    5020647c:	fe843783          	ld	a5,-24(s0)
    50206480:	853e                	mv	a0,a5
    50206482:	7422                	ld	s0,40(sp)
    50206484:	6145                	addi	sp,sp,48
    50206486:	8082                	ret

0000000050206488 <atoi>:
    50206488:	7179                	addi	sp,sp,-48
    5020648a:	f422                	sd	s0,40(sp)
    5020648c:	1800                	addi	s0,sp,48
    5020648e:	fca43c23          	sd	a0,-40(s0)
    50206492:	fe042623          	sw	zero,-20(s0)
    50206496:	4785                	li	a5,1
    50206498:	fef42423          	sw	a5,-24(s0)
    5020649c:	fd843783          	ld	a5,-40(s0)
    502064a0:	eb81                	bnez	a5,502064b0 <atoi+0x28>
    502064a2:	4781                	li	a5,0
    502064a4:	a8c9                	j	50206576 <atoi+0xee>
    502064a6:	fd843783          	ld	a5,-40(s0)
    502064aa:	0785                	addi	a5,a5,1
    502064ac:	fcf43c23          	sd	a5,-40(s0)
    502064b0:	fd843783          	ld	a5,-40(s0)
    502064b4:	0007c783          	lbu	a5,0(a5)
    502064b8:	873e                	mv	a4,a5
    502064ba:	02000793          	li	a5,32
    502064be:	fef704e3          	beq	a4,a5,502064a6 <atoi+0x1e>
    502064c2:	fd843783          	ld	a5,-40(s0)
    502064c6:	0007c783          	lbu	a5,0(a5)
    502064ca:	873e                	mv	a4,a5
    502064cc:	02d00793          	li	a5,45
    502064d0:	00f71563          	bne	a4,a5,502064da <atoi+0x52>
    502064d4:	57fd                	li	a5,-1
    502064d6:	fef42423          	sw	a5,-24(s0)
    502064da:	fd843783          	ld	a5,-40(s0)
    502064de:	0007c783          	lbu	a5,0(a5)
    502064e2:	873e                	mv	a4,a5
    502064e4:	02d00793          	li	a5,45
    502064e8:	00f70b63          	beq	a4,a5,502064fe <atoi+0x76>
    502064ec:	fd843783          	ld	a5,-40(s0)
    502064f0:	0007c783          	lbu	a5,0(a5)
    502064f4:	873e                	mv	a4,a5
    502064f6:	02b00793          	li	a5,43
    502064fa:	04f71263          	bne	a4,a5,5020653e <atoi+0xb6>
    502064fe:	fd843783          	ld	a5,-40(s0)
    50206502:	0785                	addi	a5,a5,1
    50206504:	fcf43c23          	sd	a5,-40(s0)
    50206508:	a81d                	j	5020653e <atoi+0xb6>
    5020650a:	fec42703          	lw	a4,-20(s0)
    5020650e:	87ba                	mv	a5,a4
    50206510:	0027979b          	slliw	a5,a5,0x2
    50206514:	9fb9                	addw	a5,a5,a4
    50206516:	0017979b          	slliw	a5,a5,0x1
    5020651a:	0007871b          	sext.w	a4,a5
    5020651e:	fd843783          	ld	a5,-40(s0)
    50206522:	0007c783          	lbu	a5,0(a5)
    50206526:	2781                	sext.w	a5,a5
    50206528:	9fb9                	addw	a5,a5,a4
    5020652a:	2781                	sext.w	a5,a5
    5020652c:	fd07879b          	addiw	a5,a5,-48
    50206530:	fef42623          	sw	a5,-20(s0)
    50206534:	fd843783          	ld	a5,-40(s0)
    50206538:	0785                	addi	a5,a5,1
    5020653a:	fcf43c23          	sd	a5,-40(s0)
    5020653e:	fd843783          	ld	a5,-40(s0)
    50206542:	0007c783          	lbu	a5,0(a5)
    50206546:	873e                	mv	a4,a5
    50206548:	02f00793          	li	a5,47
    5020654c:	00e7fb63          	bgeu	a5,a4,50206562 <atoi+0xda>
    50206550:	fd843783          	ld	a5,-40(s0)
    50206554:	0007c783          	lbu	a5,0(a5)
    50206558:	873e                	mv	a4,a5
    5020655a:	03900793          	li	a5,57
    5020655e:	fae7f6e3          	bgeu	a5,a4,5020650a <atoi+0x82>
    50206562:	fec42703          	lw	a4,-20(s0)
    50206566:	fe842783          	lw	a5,-24(s0)
    5020656a:	02f707bb          	mulw	a5,a4,a5
    5020656e:	fef42623          	sw	a5,-20(s0)
    50206572:	fec42783          	lw	a5,-20(s0)
    50206576:	853e                	mv	a0,a5
    50206578:	7422                	ld	s0,40(sp)
    5020657a:	6145                	addi	sp,sp,48
    5020657c:	8082                	ret

000000005020657e <mthread_mutex_init>:
    5020657e:	7179                	addi	sp,sp,-48
    50206580:	f406                	sd	ra,40(sp)
    50206582:	f022                	sd	s0,32(sp)
    50206584:	1800                	addi	s0,sp,48
    50206586:	fca43c23          	sd	a0,-40(s0)
    5020658a:	fd843783          	ld	a5,-40(s0)
    5020658e:	fef43423          	sd	a5,-24(s0)
    50206592:	fd843503          	ld	a0,-40(s0)
    50206596:	584000ef          	jal	ra,50206b1a <sys_get_mutex>
    5020659a:	87aa                	mv	a5,a0
    5020659c:	873e                	mv	a4,a5
    5020659e:	fe843783          	ld	a5,-24(s0)
    502065a2:	c398                	sw	a4,0(a5)
    502065a4:	4781                	li	a5,0
    502065a6:	853e                	mv	a0,a5
    502065a8:	70a2                	ld	ra,40(sp)
    502065aa:	7402                	ld	s0,32(sp)
    502065ac:	6145                	addi	sp,sp,48
    502065ae:	8082                	ret

00000000502065b0 <mthread_mutex_lock>:
    502065b0:	1101                	addi	sp,sp,-32
    502065b2:	ec06                	sd	ra,24(sp)
    502065b4:	e822                	sd	s0,16(sp)
    502065b6:	1000                	addi	s0,sp,32
    502065b8:	fea43423          	sd	a0,-24(s0)
    502065bc:	fe843783          	ld	a5,-24(s0)
    502065c0:	439c                	lw	a5,0(a5)
    502065c2:	853e                	mv	a0,a5
    502065c4:	582000ef          	jal	ra,50206b46 <sys_lock_mutex>
    502065c8:	87aa                	mv	a5,a0
    502065ca:	853e                	mv	a0,a5
    502065cc:	60e2                	ld	ra,24(sp)
    502065ce:	6442                	ld	s0,16(sp)
    502065d0:	6105                	addi	sp,sp,32
    502065d2:	8082                	ret

00000000502065d4 <mthread_mutex_unlock>:
    502065d4:	1101                	addi	sp,sp,-32
    502065d6:	ec06                	sd	ra,24(sp)
    502065d8:	e822                	sd	s0,16(sp)
    502065da:	1000                	addi	s0,sp,32
    502065dc:	fea43423          	sd	a0,-24(s0)
    502065e0:	fe843783          	ld	a5,-24(s0)
    502065e4:	439c                	lw	a5,0(a5)
    502065e6:	853e                	mv	a0,a5
    502065e8:	58c000ef          	jal	ra,50206b74 <sys_unlock_mutex>
    502065ec:	87aa                	mv	a5,a0
    502065ee:	853e                	mv	a0,a5
    502065f0:	60e2                	ld	ra,24(sp)
    502065f2:	6442                	ld	s0,16(sp)
    502065f4:	6105                	addi	sp,sp,32
    502065f6:	8082                	ret

00000000502065f8 <mthread_barrier_init>:
    502065f8:	7139                	addi	sp,sp,-64
    502065fa:	fc06                	sd	ra,56(sp)
    502065fc:	f822                	sd	s0,48(sp)
    502065fe:	0080                	addi	s0,sp,64
    50206600:	fca43423          	sd	a0,-56(s0)
    50206604:	87ae                	mv	a5,a1
    50206606:	fcf42223          	sw	a5,-60(s0)
    5020660a:	fc843783          	ld	a5,-56(s0)
    5020660e:	fef43423          	sd	a5,-24(s0)
    50206612:	fe843783          	ld	a5,-24(s0)
    50206616:	0791                	addi	a5,a5,4
    50206618:	fef43023          	sd	a5,-32(s0)
    5020661c:	fe843783          	ld	a5,-24(s0)
    50206620:	fcf43c23          	sd	a5,-40(s0)
    50206624:	fc442783          	lw	a5,-60(s0)
    50206628:	fd843603          	ld	a2,-40(s0)
    5020662c:	85be                	mv	a1,a5
    5020662e:	fe043503          	ld	a0,-32(s0)
    50206632:	594000ef          	jal	ra,50206bc6 <sys_barrier_init>
    50206636:	87aa                	mv	a5,a0
    50206638:	873e                	mv	a4,a5
    5020663a:	fe043783          	ld	a5,-32(s0)
    5020663e:	c398                	sw	a4,0(a5)
    50206640:	4781                	li	a5,0
    50206642:	853e                	mv	a0,a5
    50206644:	70e2                	ld	ra,56(sp)
    50206646:	7442                	ld	s0,48(sp)
    50206648:	6121                	addi	sp,sp,64
    5020664a:	8082                	ret

000000005020664c <mthread_barrier_wait>:
    5020664c:	7179                	addi	sp,sp,-48
    5020664e:	f406                	sd	ra,40(sp)
    50206650:	f022                	sd	s0,32(sp)
    50206652:	1800                	addi	s0,sp,48
    50206654:	fca43c23          	sd	a0,-40(s0)
    50206658:	fd843783          	ld	a5,-40(s0)
    5020665c:	fef43423          	sd	a5,-24(s0)
    50206660:	fe843783          	ld	a5,-24(s0)
    50206664:	43dc                	lw	a5,4(a5)
    50206666:	fef42223          	sw	a5,-28(s0)
    5020666a:	fe442783          	lw	a5,-28(s0)
    5020666e:	853e                	mv	a0,a5
    50206670:	592000ef          	jal	ra,50206c02 <sys_barrier_wait>
    50206674:	87aa                	mv	a5,a0
    50206676:	853e                	mv	a0,a5
    50206678:	70a2                	ld	ra,40(sp)
    5020667a:	7402                	ld	s0,32(sp)
    5020667c:	6145                	addi	sp,sp,48
    5020667e:	8082                	ret

0000000050206680 <mthread_barrier_destroy>:
    50206680:	7139                	addi	sp,sp,-64
    50206682:	fc06                	sd	ra,56(sp)
    50206684:	f822                	sd	s0,48(sp)
    50206686:	0080                	addi	s0,sp,64
    50206688:	fca43423          	sd	a0,-56(s0)
    5020668c:	fc843783          	ld	a5,-56(s0)
    50206690:	fef43423          	sd	a5,-24(s0)
    50206694:	fe843783          	ld	a5,-24(s0)
    50206698:	43dc                	lw	a5,4(a5)
    5020669a:	fef42223          	sw	a5,-28(s0)
    5020669e:	fe843783          	ld	a5,-24(s0)
    502066a2:	fcf43c23          	sd	a5,-40(s0)
    502066a6:	fe442783          	lw	a5,-28(s0)
    502066aa:	fd843583          	ld	a1,-40(s0)
    502066ae:	853e                	mv	a0,a5
    502066b0:	580000ef          	jal	ra,50206c30 <sys_barrier_destroy>
    502066b4:	87aa                	mv	a5,a0
    502066b6:	853e                	mv	a0,a5
    502066b8:	70e2                	ld	ra,56(sp)
    502066ba:	7442                	ld	s0,48(sp)
    502066bc:	6121                	addi	sp,sp,64
    502066be:	8082                	ret

00000000502066c0 <mthread_semaphore_init>:
    502066c0:	7139                	addi	sp,sp,-64
    502066c2:	fc06                	sd	ra,56(sp)
    502066c4:	f822                	sd	s0,48(sp)
    502066c6:	0080                	addi	s0,sp,64
    502066c8:	fca43423          	sd	a0,-56(s0)
    502066cc:	87ae                	mv	a5,a1
    502066ce:	fcf42223          	sw	a5,-60(s0)
    502066d2:	fc843783          	ld	a5,-56(s0)
    502066d6:	fef43423          	sd	a5,-24(s0)
    502066da:	fe843783          	ld	a5,-24(s0)
    502066de:	0791                	addi	a5,a5,4
    502066e0:	fef43023          	sd	a5,-32(s0)
    502066e4:	fe843783          	ld	a5,-24(s0)
    502066e8:	fcf43c23          	sd	a5,-40(s0)
    502066ec:	fc442783          	lw	a5,-60(s0)
    502066f0:	fd843603          	ld	a2,-40(s0)
    502066f4:	85be                	mv	a1,a5
    502066f6:	fe043503          	ld	a0,-32(s0)
    502066fa:	56c000ef          	jal	ra,50206c66 <sys_semaphore_init>
    502066fe:	87aa                	mv	a5,a0
    50206700:	873e                	mv	a4,a5
    50206702:	fe043783          	ld	a5,-32(s0)
    50206706:	c398                	sw	a4,0(a5)
    50206708:	4781                	li	a5,0
    5020670a:	853e                	mv	a0,a5
    5020670c:	70e2                	ld	ra,56(sp)
    5020670e:	7442                	ld	s0,48(sp)
    50206710:	6121                	addi	sp,sp,64
    50206712:	8082                	ret

0000000050206714 <mthread_semaphore_up>:
    50206714:	7179                	addi	sp,sp,-48
    50206716:	f406                	sd	ra,40(sp)
    50206718:	f022                	sd	s0,32(sp)
    5020671a:	1800                	addi	s0,sp,48
    5020671c:	fca43c23          	sd	a0,-40(s0)
    50206720:	fd843783          	ld	a5,-40(s0)
    50206724:	fef43423          	sd	a5,-24(s0)
    50206728:	fe843783          	ld	a5,-24(s0)
    5020672c:	43dc                	lw	a5,4(a5)
    5020672e:	fef42223          	sw	a5,-28(s0)
    50206732:	fe442783          	lw	a5,-28(s0)
    50206736:	853e                	mv	a0,a5
    50206738:	56a000ef          	jal	ra,50206ca2 <sys_semaphore_up>
    5020673c:	87aa                	mv	a5,a0
    5020673e:	853e                	mv	a0,a5
    50206740:	70a2                	ld	ra,40(sp)
    50206742:	7402                	ld	s0,32(sp)
    50206744:	6145                	addi	sp,sp,48
    50206746:	8082                	ret

0000000050206748 <mthread_semaphore_down>:
    50206748:	7179                	addi	sp,sp,-48
    5020674a:	f406                	sd	ra,40(sp)
    5020674c:	f022                	sd	s0,32(sp)
    5020674e:	1800                	addi	s0,sp,48
    50206750:	fca43c23          	sd	a0,-40(s0)
    50206754:	fd843783          	ld	a5,-40(s0)
    50206758:	fef43423          	sd	a5,-24(s0)
    5020675c:	fe843783          	ld	a5,-24(s0)
    50206760:	43dc                	lw	a5,4(a5)
    50206762:	fef42223          	sw	a5,-28(s0)
    50206766:	fe442783          	lw	a5,-28(s0)
    5020676a:	853e                	mv	a0,a5
    5020676c:	564000ef          	jal	ra,50206cd0 <sys_semaphore_down>
    50206770:	87aa                	mv	a5,a0
    50206772:	853e                	mv	a0,a5
    50206774:	70a2                	ld	ra,40(sp)
    50206776:	7402                	ld	s0,32(sp)
    50206778:	6145                	addi	sp,sp,48
    5020677a:	8082                	ret

000000005020677c <mthread_semaphore_destroy>:
    5020677c:	7139                	addi	sp,sp,-64
    5020677e:	fc06                	sd	ra,56(sp)
    50206780:	f822                	sd	s0,48(sp)
    50206782:	0080                	addi	s0,sp,64
    50206784:	fca43423          	sd	a0,-56(s0)
    50206788:	fc843783          	ld	a5,-56(s0)
    5020678c:	fef43423          	sd	a5,-24(s0)
    50206790:	fe843783          	ld	a5,-24(s0)
    50206794:	43dc                	lw	a5,4(a5)
    50206796:	fef42223          	sw	a5,-28(s0)
    5020679a:	fe843783          	ld	a5,-24(s0)
    5020679e:	fcf43c23          	sd	a5,-40(s0)
    502067a2:	fe442783          	lw	a5,-28(s0)
    502067a6:	fd843583          	ld	a1,-40(s0)
    502067aa:	853e                	mv	a0,a5
    502067ac:	552000ef          	jal	ra,50206cfe <sys_semaphore_destroy>
    502067b0:	87aa                	mv	a5,a0
    502067b2:	853e                	mv	a0,a5
    502067b4:	70e2                	ld	ra,56(sp)
    502067b6:	7442                	ld	s0,48(sp)
    502067b8:	6121                	addi	sp,sp,64
    502067ba:	8082                	ret

00000000502067bc <sys_spawn>:
    502067bc:	7179                	addi	sp,sp,-48
    502067be:	f406                	sd	ra,40(sp)
    502067c0:	f022                	sd	s0,32(sp)
    502067c2:	1800                	addi	s0,sp,48
    502067c4:	fea43423          	sd	a0,-24(s0)
    502067c8:	feb43023          	sd	a1,-32(s0)
    502067cc:	87b2                	mv	a5,a2
    502067ce:	fcf42e23          	sw	a5,-36(s0)
    502067d2:	fe843783          	ld	a5,-24(s0)
    502067d6:	fe043703          	ld	a4,-32(s0)
    502067da:	fdc46683          	lwu	a3,-36(s0)
    502067de:	863a                	mv	a2,a4
    502067e0:	85be                	mv	a1,a5
    502067e2:	4501                	li	a0,0
    502067e4:	58c000ef          	jal	ra,50206d70 <invoke_syscall>
    502067e8:	87aa                	mv	a5,a0
    502067ea:	2781                	sext.w	a5,a5
    502067ec:	853e                	mv	a0,a5
    502067ee:	70a2                	ld	ra,40(sp)
    502067f0:	7402                	ld	s0,32(sp)
    502067f2:	6145                	addi	sp,sp,48
    502067f4:	8082                	ret

00000000502067f6 <sys_exit>:
    502067f6:	1141                	addi	sp,sp,-16
    502067f8:	e406                	sd	ra,8(sp)
    502067fa:	e022                	sd	s0,0(sp)
    502067fc:	0800                	addi	s0,sp,16
    502067fe:	4681                	li	a3,0
    50206800:	4601                	li	a2,0
    50206802:	4581                	li	a1,0
    50206804:	4505                	li	a0,1
    50206806:	56a000ef          	jal	ra,50206d70 <invoke_syscall>
    5020680a:	0001                	nop
    5020680c:	60a2                	ld	ra,8(sp)
    5020680e:	6402                	ld	s0,0(sp)
    50206810:	0141                	addi	sp,sp,16
    50206812:	8082                	ret

0000000050206814 <sys_sleep>:
    50206814:	1101                	addi	sp,sp,-32
    50206816:	ec06                	sd	ra,24(sp)
    50206818:	e822                	sd	s0,16(sp)
    5020681a:	1000                	addi	s0,sp,32
    5020681c:	87aa                	mv	a5,a0
    5020681e:	fef42623          	sw	a5,-20(s0)
    50206822:	fec46783          	lwu	a5,-20(s0)
    50206826:	4681                	li	a3,0
    50206828:	4601                	li	a2,0
    5020682a:	85be                	mv	a1,a5
    5020682c:	4509                	li	a0,2
    5020682e:	542000ef          	jal	ra,50206d70 <invoke_syscall>
    50206832:	0001                	nop
    50206834:	60e2                	ld	ra,24(sp)
    50206836:	6442                	ld	s0,16(sp)
    50206838:	6105                	addi	sp,sp,32
    5020683a:	8082                	ret

000000005020683c <sys_kill>:
    5020683c:	1101                	addi	sp,sp,-32
    5020683e:	ec06                	sd	ra,24(sp)
    50206840:	e822                	sd	s0,16(sp)
    50206842:	1000                	addi	s0,sp,32
    50206844:	87aa                	mv	a5,a0
    50206846:	fef42623          	sw	a5,-20(s0)
    5020684a:	fec42783          	lw	a5,-20(s0)
    5020684e:	4681                	li	a3,0
    50206850:	4601                	li	a2,0
    50206852:	85be                	mv	a1,a5
    50206854:	450d                	li	a0,3
    50206856:	51a000ef          	jal	ra,50206d70 <invoke_syscall>
    5020685a:	87aa                	mv	a5,a0
    5020685c:	2781                	sext.w	a5,a5
    5020685e:	853e                	mv	a0,a5
    50206860:	60e2                	ld	ra,24(sp)
    50206862:	6442                	ld	s0,16(sp)
    50206864:	6105                	addi	sp,sp,32
    50206866:	8082                	ret

0000000050206868 <sys_waitpid>:
    50206868:	1101                	addi	sp,sp,-32
    5020686a:	ec06                	sd	ra,24(sp)
    5020686c:	e822                	sd	s0,16(sp)
    5020686e:	1000                	addi	s0,sp,32
    50206870:	87aa                	mv	a5,a0
    50206872:	fef42623          	sw	a5,-20(s0)
    50206876:	fec42783          	lw	a5,-20(s0)
    5020687a:	4681                	li	a3,0
    5020687c:	4601                	li	a2,0
    5020687e:	85be                	mv	a1,a5
    50206880:	4511                	li	a0,4
    50206882:	4ee000ef          	jal	ra,50206d70 <invoke_syscall>
    50206886:	87aa                	mv	a5,a0
    50206888:	2781                	sext.w	a5,a5
    5020688a:	853e                	mv	a0,a5
    5020688c:	60e2                	ld	ra,24(sp)
    5020688e:	6442                	ld	s0,16(sp)
    50206890:	6105                	addi	sp,sp,32
    50206892:	8082                	ret

0000000050206894 <sys_process_show>:
    50206894:	1141                	addi	sp,sp,-16
    50206896:	e406                	sd	ra,8(sp)
    50206898:	e022                	sd	s0,0(sp)
    5020689a:	0800                	addi	s0,sp,16
    5020689c:	4681                	li	a3,0
    5020689e:	4601                	li	a2,0
    502068a0:	4581                	li	a1,0
    502068a2:	4515                	li	a0,5
    502068a4:	4cc000ef          	jal	ra,50206d70 <invoke_syscall>
    502068a8:	0001                	nop
    502068aa:	60a2                	ld	ra,8(sp)
    502068ac:	6402                	ld	s0,0(sp)
    502068ae:	0141                	addi	sp,sp,16
    502068b0:	8082                	ret

00000000502068b2 <sys_getpid>:
    502068b2:	1141                	addi	sp,sp,-16
    502068b4:	e406                	sd	ra,8(sp)
    502068b6:	e022                	sd	s0,0(sp)
    502068b8:	0800                	addi	s0,sp,16
    502068ba:	4681                	li	a3,0
    502068bc:	4601                	li	a2,0
    502068be:	4581                	li	a1,0
    502068c0:	4519                	li	a0,6
    502068c2:	4ae000ef          	jal	ra,50206d70 <invoke_syscall>
    502068c6:	87aa                	mv	a5,a0
    502068c8:	2781                	sext.w	a5,a5
    502068ca:	853e                	mv	a0,a5
    502068cc:	60a2                	ld	ra,8(sp)
    502068ce:	6402                	ld	s0,0(sp)
    502068d0:	0141                	addi	sp,sp,16
    502068d2:	8082                	ret

00000000502068d4 <sys_yield>:
    502068d4:	1141                	addi	sp,sp,-16
    502068d6:	e406                	sd	ra,8(sp)
    502068d8:	e022                	sd	s0,0(sp)
    502068da:	0800                	addi	s0,sp,16
    502068dc:	4681                	li	a3,0
    502068de:	4601                	li	a2,0
    502068e0:	4581                	li	a1,0
    502068e2:	451d                	li	a0,7
    502068e4:	48c000ef          	jal	ra,50206d70 <invoke_syscall>
    502068e8:	0001                	nop
    502068ea:	60a2                	ld	ra,8(sp)
    502068ec:	6402                	ld	s0,0(sp)
    502068ee:	0141                	addi	sp,sp,16
    502068f0:	8082                	ret

00000000502068f2 <sys_prior>:
    502068f2:	1101                	addi	sp,sp,-32
    502068f4:	ec06                	sd	ra,24(sp)
    502068f6:	e822                	sd	s0,16(sp)
    502068f8:	1000                	addi	s0,sp,32
    502068fa:	87aa                	mv	a5,a0
    502068fc:	fef42623          	sw	a5,-20(s0)
    50206900:	fec42783          	lw	a5,-20(s0)
    50206904:	4681                	li	a3,0
    50206906:	4601                	li	a2,0
    50206908:	85be                	mv	a1,a5
    5020690a:	4525                	li	a0,9
    5020690c:	464000ef          	jal	ra,50206d70 <invoke_syscall>
    50206910:	0001                	nop
    50206912:	60e2                	ld	ra,24(sp)
    50206914:	6442                	ld	s0,16(sp)
    50206916:	6105                	addi	sp,sp,32
    50206918:	8082                	ret

000000005020691a <sys_futex_wait>:
    5020691a:	1101                	addi	sp,sp,-32
    5020691c:	ec06                	sd	ra,24(sp)
    5020691e:	e822                	sd	s0,16(sp)
    50206920:	1000                	addi	s0,sp,32
    50206922:	fea43423          	sd	a0,-24(s0)
    50206926:	feb43023          	sd	a1,-32(s0)
    5020692a:	4681                	li	a3,0
    5020692c:	4601                	li	a2,0
    5020692e:	4581                	li	a1,0
    50206930:	4529                	li	a0,10
    50206932:	43e000ef          	jal	ra,50206d70 <invoke_syscall>
    50206936:	0001                	nop
    50206938:	60e2                	ld	ra,24(sp)
    5020693a:	6442                	ld	s0,16(sp)
    5020693c:	6105                	addi	sp,sp,32
    5020693e:	8082                	ret

0000000050206940 <sys_futex_wakeup>:
    50206940:	1101                	addi	sp,sp,-32
    50206942:	ec06                	sd	ra,24(sp)
    50206944:	e822                	sd	s0,16(sp)
    50206946:	1000                	addi	s0,sp,32
    50206948:	fea43423          	sd	a0,-24(s0)
    5020694c:	87ae                	mv	a5,a1
    5020694e:	fef42223          	sw	a5,-28(s0)
    50206952:	4681                	li	a3,0
    50206954:	4601                	li	a2,0
    50206956:	4581                	li	a1,0
    50206958:	452d                	li	a0,11
    5020695a:	416000ef          	jal	ra,50206d70 <invoke_syscall>
    5020695e:	0001                	nop
    50206960:	60e2                	ld	ra,24(sp)
    50206962:	6442                	ld	s0,16(sp)
    50206964:	6105                	addi	sp,sp,32
    50206966:	8082                	ret

0000000050206968 <sys_write>:
    50206968:	1101                	addi	sp,sp,-32
    5020696a:	ec06                	sd	ra,24(sp)
    5020696c:	e822                	sd	s0,16(sp)
    5020696e:	1000                	addi	s0,sp,32
    50206970:	fea43423          	sd	a0,-24(s0)
    50206974:	fe843783          	ld	a5,-24(s0)
    50206978:	4681                	li	a3,0
    5020697a:	4601                	li	a2,0
    5020697c:	85be                	mv	a1,a5
    5020697e:	454d                	li	a0,19
    50206980:	3f0000ef          	jal	ra,50206d70 <invoke_syscall>
    50206984:	0001                	nop
    50206986:	60e2                	ld	ra,24(sp)
    50206988:	6442                	ld	s0,16(sp)
    5020698a:	6105                	addi	sp,sp,32
    5020698c:	8082                	ret

000000005020698e <sys_read>:
    5020698e:	1141                	addi	sp,sp,-16
    50206990:	e406                	sd	ra,8(sp)
    50206992:	e022                	sd	s0,0(sp)
    50206994:	0800                	addi	s0,sp,16
    50206996:	4681                	li	a3,0
    50206998:	4601                	li	a2,0
    5020699a:	4581                	li	a1,0
    5020699c:	4551                	li	a0,20
    5020699e:	3d2000ef          	jal	ra,50206d70 <invoke_syscall>
    502069a2:	0001                	nop
    502069a4:	60a2                	ld	ra,8(sp)
    502069a6:	6402                	ld	s0,0(sp)
    502069a8:	0141                	addi	sp,sp,16
    502069aa:	8082                	ret

00000000502069ac <sys_move_cursor>:
    502069ac:	1101                	addi	sp,sp,-32
    502069ae:	ec06                	sd	ra,24(sp)
    502069b0:	e822                	sd	s0,16(sp)
    502069b2:	1000                	addi	s0,sp,32
    502069b4:	87aa                	mv	a5,a0
    502069b6:	872e                	mv	a4,a1
    502069b8:	fef42623          	sw	a5,-20(s0)
    502069bc:	87ba                	mv	a5,a4
    502069be:	fef42423          	sw	a5,-24(s0)
    502069c2:	fec42783          	lw	a5,-20(s0)
    502069c6:	fe842703          	lw	a4,-24(s0)
    502069ca:	4681                	li	a3,0
    502069cc:	863a                	mv	a2,a4
    502069ce:	85be                	mv	a1,a5
    502069d0:	4555                	li	a0,21
    502069d2:	39e000ef          	jal	ra,50206d70 <invoke_syscall>
    502069d6:	0001                	nop
    502069d8:	60e2                	ld	ra,24(sp)
    502069da:	6442                	ld	s0,16(sp)
    502069dc:	6105                	addi	sp,sp,32
    502069de:	8082                	ret

00000000502069e0 <sys_get_cursor>:
    502069e0:	1101                	addi	sp,sp,-32
    502069e2:	ec06                	sd	ra,24(sp)
    502069e4:	e822                	sd	s0,16(sp)
    502069e6:	1000                	addi	s0,sp,32
    502069e8:	fea43423          	sd	a0,-24(s0)
    502069ec:	feb43023          	sd	a1,-32(s0)
    502069f0:	fe843783          	ld	a5,-24(s0)
    502069f4:	fe043703          	ld	a4,-32(s0)
    502069f8:	4681                	li	a3,0
    502069fa:	863a                	mv	a2,a4
    502069fc:	85be                	mv	a1,a5
    502069fe:	4559                	li	a0,22
    50206a00:	370000ef          	jal	ra,50206d70 <invoke_syscall>
    50206a04:	0001                	nop
    50206a06:	60e2                	ld	ra,24(sp)
    50206a08:	6442                	ld	s0,16(sp)
    50206a0a:	6105                	addi	sp,sp,32
    50206a0c:	8082                	ret

0000000050206a0e <sys_reflush>:
    50206a0e:	1141                	addi	sp,sp,-16
    50206a10:	e406                	sd	ra,8(sp)
    50206a12:	e022                	sd	s0,0(sp)
    50206a14:	0800                	addi	s0,sp,16
    50206a16:	4681                	li	a3,0
    50206a18:	4601                	li	a2,0
    50206a1a:	4581                	li	a1,0
    50206a1c:	455d                	li	a0,23
    50206a1e:	352000ef          	jal	ra,50206d70 <invoke_syscall>
    50206a22:	0001                	nop
    50206a24:	60a2                	ld	ra,8(sp)
    50206a26:	6402                	ld	s0,0(sp)
    50206a28:	0141                	addi	sp,sp,16
    50206a2a:	8082                	ret

0000000050206a2c <sys_screen_clear>:
    50206a2c:	1141                	addi	sp,sp,-16
    50206a2e:	e406                	sd	ra,8(sp)
    50206a30:	e022                	sd	s0,0(sp)
    50206a32:	0800                	addi	s0,sp,16
    50206a34:	4681                	li	a3,0
    50206a36:	4601                	li	a2,0
    50206a38:	4581                	li	a1,0
    50206a3a:	456d                	li	a0,27
    50206a3c:	334000ef          	jal	ra,50206d70 <invoke_syscall>
    50206a40:	0001                	nop
    50206a42:	60a2                	ld	ra,8(sp)
    50206a44:	6402                	ld	s0,0(sp)
    50206a46:	0141                	addi	sp,sp,16
    50206a48:	8082                	ret

0000000050206a4a <sys_getchar>:
    50206a4a:	1101                	addi	sp,sp,-32
    50206a4c:	ec06                	sd	ra,24(sp)
    50206a4e:	e822                	sd	s0,16(sp)
    50206a50:	1000                	addi	s0,sp,32
    50206a52:	4681                	li	a3,0
    50206a54:	4601                	li	a2,0
    50206a56:	4581                	li	a1,0
    50206a58:	4571                	li	a0,28
    50206a5a:	316000ef          	jal	ra,50206d70 <invoke_syscall>
    50206a5e:	87aa                	mv	a5,a0
    50206a60:	fef407a3          	sb	a5,-17(s0)
    50206a64:	fef44783          	lbu	a5,-17(s0)
    50206a68:	0ff7f793          	andi	a5,a5,255
    50206a6c:	d3fd                	beqz	a5,50206a52 <sys_getchar+0x8>
    50206a6e:	fef40783          	lb	a5,-17(s0)
    50206a72:	fe07c0e3          	bltz	a5,50206a52 <sys_getchar+0x8>
    50206a76:	fef44783          	lbu	a5,-17(s0)
    50206a7a:	2781                	sext.w	a5,a5
    50206a7c:	853e                	mv	a0,a5
    50206a7e:	60e2                	ld	ra,24(sp)
    50206a80:	6442                	ld	s0,16(sp)
    50206a82:	6105                	addi	sp,sp,32
    50206a84:	8082                	ret

0000000050206a86 <sys_putchar>:
    50206a86:	1101                	addi	sp,sp,-32
    50206a88:	ec06                	sd	ra,24(sp)
    50206a8a:	e822                	sd	s0,16(sp)
    50206a8c:	1000                	addi	s0,sp,32
    50206a8e:	87aa                	mv	a5,a0
    50206a90:	fef407a3          	sb	a5,-17(s0)
    50206a94:	fef44783          	lbu	a5,-17(s0)
    50206a98:	4681                	li	a3,0
    50206a9a:	4601                	li	a2,0
    50206a9c:	85be                	mv	a1,a5
    50206a9e:	4575                	li	a0,29
    50206aa0:	2d0000ef          	jal	ra,50206d70 <invoke_syscall>
    50206aa4:	0001                	nop
    50206aa6:	60e2                	ld	ra,24(sp)
    50206aa8:	6442                	ld	s0,16(sp)
    50206aaa:	6105                	addi	sp,sp,32
    50206aac:	8082                	ret

0000000050206aae <sys_get_timebase>:
    50206aae:	1141                	addi	sp,sp,-16
    50206ab0:	e406                	sd	ra,8(sp)
    50206ab2:	e022                	sd	s0,0(sp)
    50206ab4:	0800                	addi	s0,sp,16
    50206ab6:	4681                	li	a3,0
    50206ab8:	4601                	li	a2,0
    50206aba:	4581                	li	a1,0
    50206abc:	4579                	li	a0,30
    50206abe:	2b2000ef          	jal	ra,50206d70 <invoke_syscall>
    50206ac2:	87aa                	mv	a5,a0
    50206ac4:	853e                	mv	a0,a5
    50206ac6:	60a2                	ld	ra,8(sp)
    50206ac8:	6402                	ld	s0,0(sp)
    50206aca:	0141                	addi	sp,sp,16
    50206acc:	8082                	ret

0000000050206ace <sys_get_tick>:
    50206ace:	1141                	addi	sp,sp,-16
    50206ad0:	e406                	sd	ra,8(sp)
    50206ad2:	e022                	sd	s0,0(sp)
    50206ad4:	0800                	addi	s0,sp,16
    50206ad6:	4681                	li	a3,0
    50206ad8:	4601                	li	a2,0
    50206ada:	4581                	li	a1,0
    50206adc:	457d                	li	a0,31
    50206ade:	292000ef          	jal	ra,50206d70 <invoke_syscall>
    50206ae2:	87aa                	mv	a5,a0
    50206ae4:	853e                	mv	a0,a5
    50206ae6:	60a2                	ld	ra,8(sp)
    50206ae8:	6402                	ld	s0,0(sp)
    50206aea:	0141                	addi	sp,sp,16
    50206aec:	8082                	ret

0000000050206aee <sys_get_walltime>:
    50206aee:	1101                	addi	sp,sp,-32
    50206af0:	ec06                	sd	ra,24(sp)
    50206af2:	e822                	sd	s0,16(sp)
    50206af4:	1000                	addi	s0,sp,32
    50206af6:	fea43423          	sd	a0,-24(s0)
    50206afa:	fe843783          	ld	a5,-24(s0)
    50206afe:	4681                	li	a3,0
    50206b00:	4601                	li	a2,0
    50206b02:	85be                	mv	a1,a5
    50206b04:	02000513          	li	a0,32
    50206b08:	268000ef          	jal	ra,50206d70 <invoke_syscall>
    50206b0c:	87aa                	mv	a5,a0
    50206b0e:	2781                	sext.w	a5,a5
    50206b10:	853e                	mv	a0,a5
    50206b12:	60e2                	ld	ra,24(sp)
    50206b14:	6442                	ld	s0,16(sp)
    50206b16:	6105                	addi	sp,sp,32
    50206b18:	8082                	ret

0000000050206b1a <sys_get_mutex>:
    50206b1a:	1101                	addi	sp,sp,-32
    50206b1c:	ec06                	sd	ra,24(sp)
    50206b1e:	e822                	sd	s0,16(sp)
    50206b20:	1000                	addi	s0,sp,32
    50206b22:	fea43423          	sd	a0,-24(s0)
    50206b26:	fe843783          	ld	a5,-24(s0)
    50206b2a:	4681                	li	a3,0
    50206b2c:	4601                	li	a2,0
    50206b2e:	85be                	mv	a1,a5
    50206b30:	02100513          	li	a0,33
    50206b34:	23c000ef          	jal	ra,50206d70 <invoke_syscall>
    50206b38:	87aa                	mv	a5,a0
    50206b3a:	2781                	sext.w	a5,a5
    50206b3c:	853e                	mv	a0,a5
    50206b3e:	60e2                	ld	ra,24(sp)
    50206b40:	6442                	ld	s0,16(sp)
    50206b42:	6105                	addi	sp,sp,32
    50206b44:	8082                	ret

0000000050206b46 <sys_lock_mutex>:
    50206b46:	1101                	addi	sp,sp,-32
    50206b48:	ec06                	sd	ra,24(sp)
    50206b4a:	e822                	sd	s0,16(sp)
    50206b4c:	1000                	addi	s0,sp,32
    50206b4e:	87aa                	mv	a5,a0
    50206b50:	fef42623          	sw	a5,-20(s0)
    50206b54:	fec42783          	lw	a5,-20(s0)
    50206b58:	4681                	li	a3,0
    50206b5a:	4601                	li	a2,0
    50206b5c:	85be                	mv	a1,a5
    50206b5e:	02200513          	li	a0,34
    50206b62:	20e000ef          	jal	ra,50206d70 <invoke_syscall>
    50206b66:	87aa                	mv	a5,a0
    50206b68:	2781                	sext.w	a5,a5
    50206b6a:	853e                	mv	a0,a5
    50206b6c:	60e2                	ld	ra,24(sp)
    50206b6e:	6442                	ld	s0,16(sp)
    50206b70:	6105                	addi	sp,sp,32
    50206b72:	8082                	ret

0000000050206b74 <sys_unlock_mutex>:
    50206b74:	1101                	addi	sp,sp,-32
    50206b76:	ec06                	sd	ra,24(sp)
    50206b78:	e822                	sd	s0,16(sp)
    50206b7a:	1000                	addi	s0,sp,32
    50206b7c:	87aa                	mv	a5,a0
    50206b7e:	fef42623          	sw	a5,-20(s0)
    50206b82:	fec42783          	lw	a5,-20(s0)
    50206b86:	4681                	li	a3,0
    50206b88:	4601                	li	a2,0
    50206b8a:	85be                	mv	a1,a5
    50206b8c:	02300513          	li	a0,35
    50206b90:	1e0000ef          	jal	ra,50206d70 <invoke_syscall>
    50206b94:	87aa                	mv	a5,a0
    50206b96:	2781                	sext.w	a5,a5
    50206b98:	853e                	mv	a0,a5
    50206b9a:	60e2                	ld	ra,24(sp)
    50206b9c:	6442                	ld	s0,16(sp)
    50206b9e:	6105                	addi	sp,sp,32
    50206ba0:	8082                	ret

0000000050206ba2 <sys_get_char>:
    50206ba2:	1141                	addi	sp,sp,-16
    50206ba4:	e406                	sd	ra,8(sp)
    50206ba6:	e022                	sd	s0,0(sp)
    50206ba8:	0800                	addi	s0,sp,16
    50206baa:	4681                	li	a3,0
    50206bac:	4601                	li	a2,0
    50206bae:	4581                	li	a1,0
    50206bb0:	02400513          	li	a0,36
    50206bb4:	1bc000ef          	jal	ra,50206d70 <invoke_syscall>
    50206bb8:	87aa                	mv	a5,a0
    50206bba:	2781                	sext.w	a5,a5
    50206bbc:	853e                	mv	a0,a5
    50206bbe:	60a2                	ld	ra,8(sp)
    50206bc0:	6402                	ld	s0,0(sp)
    50206bc2:	0141                	addi	sp,sp,16
    50206bc4:	8082                	ret

0000000050206bc6 <sys_barrier_init>:
    50206bc6:	7179                	addi	sp,sp,-48
    50206bc8:	f406                	sd	ra,40(sp)
    50206bca:	f022                	sd	s0,32(sp)
    50206bcc:	1800                	addi	s0,sp,48
    50206bce:	fea43423          	sd	a0,-24(s0)
    50206bd2:	87ae                	mv	a5,a1
    50206bd4:	fcc43c23          	sd	a2,-40(s0)
    50206bd8:	fef42223          	sw	a5,-28(s0)
    50206bdc:	fe843783          	ld	a5,-24(s0)
    50206be0:	fe446703          	lwu	a4,-28(s0)
    50206be4:	fd843683          	ld	a3,-40(s0)
    50206be8:	863a                	mv	a2,a4
    50206bea:	85be                	mv	a1,a5
    50206bec:	02500513          	li	a0,37
    50206bf0:	180000ef          	jal	ra,50206d70 <invoke_syscall>
    50206bf4:	87aa                	mv	a5,a0
    50206bf6:	2781                	sext.w	a5,a5
    50206bf8:	853e                	mv	a0,a5
    50206bfa:	70a2                	ld	ra,40(sp)
    50206bfc:	7402                	ld	s0,32(sp)
    50206bfe:	6145                	addi	sp,sp,48
    50206c00:	8082                	ret

0000000050206c02 <sys_barrier_wait>:
    50206c02:	1101                	addi	sp,sp,-32
    50206c04:	ec06                	sd	ra,24(sp)
    50206c06:	e822                	sd	s0,16(sp)
    50206c08:	1000                	addi	s0,sp,32
    50206c0a:	87aa                	mv	a5,a0
    50206c0c:	fef42623          	sw	a5,-20(s0)
    50206c10:	fec42783          	lw	a5,-20(s0)
    50206c14:	4681                	li	a3,0
    50206c16:	4601                	li	a2,0
    50206c18:	85be                	mv	a1,a5
    50206c1a:	02600513          	li	a0,38
    50206c1e:	152000ef          	jal	ra,50206d70 <invoke_syscall>
    50206c22:	87aa                	mv	a5,a0
    50206c24:	2781                	sext.w	a5,a5
    50206c26:	853e                	mv	a0,a5
    50206c28:	60e2                	ld	ra,24(sp)
    50206c2a:	6442                	ld	s0,16(sp)
    50206c2c:	6105                	addi	sp,sp,32
    50206c2e:	8082                	ret

0000000050206c30 <sys_barrier_destroy>:
    50206c30:	1101                	addi	sp,sp,-32
    50206c32:	ec06                	sd	ra,24(sp)
    50206c34:	e822                	sd	s0,16(sp)
    50206c36:	1000                	addi	s0,sp,32
    50206c38:	87aa                	mv	a5,a0
    50206c3a:	feb43023          	sd	a1,-32(s0)
    50206c3e:	fef42623          	sw	a5,-20(s0)
    50206c42:	fec42783          	lw	a5,-20(s0)
    50206c46:	fe043703          	ld	a4,-32(s0)
    50206c4a:	4681                	li	a3,0
    50206c4c:	863a                	mv	a2,a4
    50206c4e:	85be                	mv	a1,a5
    50206c50:	02700513          	li	a0,39
    50206c54:	11c000ef          	jal	ra,50206d70 <invoke_syscall>
    50206c58:	87aa                	mv	a5,a0
    50206c5a:	2781                	sext.w	a5,a5
    50206c5c:	853e                	mv	a0,a5
    50206c5e:	60e2                	ld	ra,24(sp)
    50206c60:	6442                	ld	s0,16(sp)
    50206c62:	6105                	addi	sp,sp,32
    50206c64:	8082                	ret

0000000050206c66 <sys_semaphore_init>:
    50206c66:	7179                	addi	sp,sp,-48
    50206c68:	f406                	sd	ra,40(sp)
    50206c6a:	f022                	sd	s0,32(sp)
    50206c6c:	1800                	addi	s0,sp,48
    50206c6e:	fea43423          	sd	a0,-24(s0)
    50206c72:	87ae                	mv	a5,a1
    50206c74:	fcc43c23          	sd	a2,-40(s0)
    50206c78:	fef42223          	sw	a5,-28(s0)
    50206c7c:	fe843783          	ld	a5,-24(s0)
    50206c80:	fe442703          	lw	a4,-28(s0)
    50206c84:	fd843683          	ld	a3,-40(s0)
    50206c88:	863a                	mv	a2,a4
    50206c8a:	85be                	mv	a1,a5
    50206c8c:	02800513          	li	a0,40
    50206c90:	0e0000ef          	jal	ra,50206d70 <invoke_syscall>
    50206c94:	87aa                	mv	a5,a0
    50206c96:	2781                	sext.w	a5,a5
    50206c98:	853e                	mv	a0,a5
    50206c9a:	70a2                	ld	ra,40(sp)
    50206c9c:	7402                	ld	s0,32(sp)
    50206c9e:	6145                	addi	sp,sp,48
    50206ca0:	8082                	ret

0000000050206ca2 <sys_semaphore_up>:
    50206ca2:	1101                	addi	sp,sp,-32
    50206ca4:	ec06                	sd	ra,24(sp)
    50206ca6:	e822                	sd	s0,16(sp)
    50206ca8:	1000                	addi	s0,sp,32
    50206caa:	87aa                	mv	a5,a0
    50206cac:	fef42623          	sw	a5,-20(s0)
    50206cb0:	fec42783          	lw	a5,-20(s0)
    50206cb4:	4681                	li	a3,0
    50206cb6:	4601                	li	a2,0
    50206cb8:	85be                	mv	a1,a5
    50206cba:	02900513          	li	a0,41
    50206cbe:	0b2000ef          	jal	ra,50206d70 <invoke_syscall>
    50206cc2:	87aa                	mv	a5,a0
    50206cc4:	2781                	sext.w	a5,a5
    50206cc6:	853e                	mv	a0,a5
    50206cc8:	60e2                	ld	ra,24(sp)
    50206cca:	6442                	ld	s0,16(sp)
    50206ccc:	6105                	addi	sp,sp,32
    50206cce:	8082                	ret

0000000050206cd0 <sys_semaphore_down>:
    50206cd0:	1101                	addi	sp,sp,-32
    50206cd2:	ec06                	sd	ra,24(sp)
    50206cd4:	e822                	sd	s0,16(sp)
    50206cd6:	1000                	addi	s0,sp,32
    50206cd8:	87aa                	mv	a5,a0
    50206cda:	fef42623          	sw	a5,-20(s0)
    50206cde:	fec42783          	lw	a5,-20(s0)
    50206ce2:	4681                	li	a3,0
    50206ce4:	4601                	li	a2,0
    50206ce6:	85be                	mv	a1,a5
    50206ce8:	02a00513          	li	a0,42
    50206cec:	084000ef          	jal	ra,50206d70 <invoke_syscall>
    50206cf0:	87aa                	mv	a5,a0
    50206cf2:	2781                	sext.w	a5,a5
    50206cf4:	853e                	mv	a0,a5
    50206cf6:	60e2                	ld	ra,24(sp)
    50206cf8:	6442                	ld	s0,16(sp)
    50206cfa:	6105                	addi	sp,sp,32
    50206cfc:	8082                	ret

0000000050206cfe <sys_semaphore_destroy>:
    50206cfe:	1101                	addi	sp,sp,-32
    50206d00:	ec06                	sd	ra,24(sp)
    50206d02:	e822                	sd	s0,16(sp)
    50206d04:	1000                	addi	s0,sp,32
    50206d06:	87aa                	mv	a5,a0
    50206d08:	feb43023          	sd	a1,-32(s0)
    50206d0c:	fef42623          	sw	a5,-20(s0)
    50206d10:	fec42783          	lw	a5,-20(s0)
    50206d14:	fe043703          	ld	a4,-32(s0)
    50206d18:	4681                	li	a3,0
    50206d1a:	863a                	mv	a2,a4
    50206d1c:	85be                	mv	a1,a5
    50206d1e:	02b00513          	li	a0,43
    50206d22:	04e000ef          	jal	ra,50206d70 <invoke_syscall>
    50206d26:	87aa                	mv	a5,a0
    50206d28:	2781                	sext.w	a5,a5
    50206d2a:	853e                	mv	a0,a5
    50206d2c:	60e2                	ld	ra,24(sp)
    50206d2e:	6442                	ld	s0,16(sp)
    50206d30:	6105                	addi	sp,sp,32
    50206d32:	8082                	ret

0000000050206d34 <sys_taskset>:
    50206d34:	1101                	addi	sp,sp,-32
    50206d36:	ec06                	sd	ra,24(sp)
    50206d38:	e822                	sd	s0,16(sp)
    50206d3a:	1000                	addi	s0,sp,32
    50206d3c:	87aa                	mv	a5,a0
    50206d3e:	872e                	mv	a4,a1
    50206d40:	fef42623          	sw	a5,-20(s0)
    50206d44:	87ba                	mv	a5,a4
    50206d46:	fef42423          	sw	a5,-24(s0)
    50206d4a:	fec42783          	lw	a5,-20(s0)
    50206d4e:	fe842703          	lw	a4,-24(s0)
    50206d52:	4681                	li	a3,0
    50206d54:	863a                	mv	a2,a4
    50206d56:	85be                	mv	a1,a5
    50206d58:	03000513          	li	a0,48
    50206d5c:	014000ef          	jal	ra,50206d70 <invoke_syscall>
    50206d60:	87aa                	mv	a5,a0
    50206d62:	2781                	sext.w	a5,a5
    50206d64:	853e                	mv	a0,a5
    50206d66:	60e2                	ld	ra,24(sp)
    50206d68:	6442                	ld	s0,16(sp)
    50206d6a:	6105                	addi	sp,sp,32
    50206d6c:	8082                	ret
	...

0000000050206d70 <invoke_syscall>:
    50206d70:	000508b3          	add	a7,a0,zero
    50206d74:	00058533          	add	a0,a1,zero
    50206d78:	000605b3          	add	a1,a2,zero
    50206d7c:	00068633          	add	a2,a3,zero
    50206d80:	00000073          	ecall
    50206d84:	0001                	nop
    50206d86:	8082                	ret

0000000050206d88 <sys_fork>:
    50206d88:	488d                	li	a7,3
    50206d8a:	00000073          	ecall
    50206d8e:	0001                	nop
    50206d90:	8082                	ret
	...

0000000050206d94 <clock>:
    50206d94:	1141                	addi	sp,sp,-16
    50206d96:	e406                	sd	ra,8(sp)
    50206d98:	e022                	sd	s0,0(sp)
    50206d9a:	0800                	addi	s0,sp,16
    50206d9c:	d33ff0ef          	jal	ra,50206ace <sys_get_tick>
    50206da0:	87aa                	mv	a5,a0
    50206da2:	853e                	mv	a0,a5
    50206da4:	60a2                	ld	ra,8(sp)
    50206da6:	6402                	ld	s0,0(sp)
    50206da8:	0141                	addi	sp,sp,16
    50206daa:	8082                	ret

0000000050206dac <mbox_init>:
    50206dac:	1101                	addi	sp,sp,-32
    50206dae:	ec06                	sd	ra,24(sp)
    50206db0:	e822                	sd	s0,16(sp)
    50206db2:	1000                	addi	s0,sp,32
    50206db4:	4585                	li	a1,1
    50206db6:	00006517          	auipc	a0,0x6
    50206dba:	59250513          	addi	a0,a0,1426 # 5020d348 <visit_mailbox>
    50206dbe:	903ff0ef          	jal	ra,502066c0 <mthread_semaphore_init>
    50206dc2:	fe042623          	sw	zero,-20(s0)
    50206dc6:	a01d                	j	50206dec <mbox_init+0x40>
    50206dc8:	00006717          	auipc	a4,0x6
    50206dcc:	58870713          	addi	a4,a4,1416 # 5020d350 <mailbox_array>
    50206dd0:	fec42683          	lw	a3,-20(s0)
    50206dd4:	09400793          	li	a5,148
    50206dd8:	02f687b3          	mul	a5,a3,a5
    50206ddc:	97ba                	add	a5,a5,a4
    50206dde:	0007a023          	sw	zero,0(a5)
    50206de2:	fec42783          	lw	a5,-20(s0)
    50206de6:	2785                	addiw	a5,a5,1
    50206de8:	fef42623          	sw	a5,-20(s0)
    50206dec:	fec42783          	lw	a5,-20(s0)
    50206df0:	0007871b          	sext.w	a4,a5
    50206df4:	479d                	li	a5,7
    50206df6:	fce7d9e3          	bge	a5,a4,50206dc8 <mbox_init+0x1c>
    50206dfa:	0001                	nop
    50206dfc:	0001                	nop
    50206dfe:	60e2                	ld	ra,24(sp)
    50206e00:	6442                	ld	s0,16(sp)
    50206e02:	6105                	addi	sp,sp,32
    50206e04:	8082                	ret

0000000050206e06 <mbox_open>:
    50206e06:	7179                	addi	sp,sp,-48
    50206e08:	f406                	sd	ra,40(sp)
    50206e0a:	f022                	sd	s0,32(sp)
    50206e0c:	1800                	addi	s0,sp,48
    50206e0e:	fca43c23          	sd	a0,-40(s0)
    50206e12:	00006517          	auipc	a0,0x6
    50206e16:	53650513          	addi	a0,a0,1334 # 5020d348 <visit_mailbox>
    50206e1a:	92fff0ef          	jal	ra,50206748 <mthread_semaphore_down>
    50206e1e:	fe042623          	sw	zero,-20(s0)
    50206e22:	a07d                	j	50206ed0 <mbox_open+0xca>
    50206e24:	fec42703          	lw	a4,-20(s0)
    50206e28:	09400793          	li	a5,148
    50206e2c:	02f707b3          	mul	a5,a4,a5
    50206e30:	02078713          	addi	a4,a5,32
    50206e34:	00006797          	auipc	a5,0x6
    50206e38:	51c78793          	addi	a5,a5,1308 # 5020d350 <mailbox_array>
    50206e3c:	97ba                	add	a5,a5,a4
    50206e3e:	85be                	mv	a1,a5
    50206e40:	fd843503          	ld	a0,-40(s0)
    50206e44:	cf4ff0ef          	jal	ra,50206338 <strcmp>
    50206e48:	87aa                	mv	a5,a0
    50206e4a:	efb5                	bnez	a5,50206ec6 <mbox_open+0xc0>
    50206e4c:	00006717          	auipc	a4,0x6
    50206e50:	50470713          	addi	a4,a4,1284 # 5020d350 <mailbox_array>
    50206e54:	fec42683          	lw	a3,-20(s0)
    50206e58:	09400793          	li	a5,148
    50206e5c:	02f687b3          	mul	a5,a3,a5
    50206e60:	97ba                	add	a5,a5,a4
    50206e62:	439c                	lw	a5,0(a5)
    50206e64:	873e                	mv	a4,a5
    50206e66:	4785                	li	a5,1
    50206e68:	04f71f63          	bne	a4,a5,50206ec6 <mbox_open+0xc0>
    50206e6c:	00006717          	auipc	a4,0x6
    50206e70:	4e470713          	addi	a4,a4,1252 # 5020d350 <mailbox_array>
    50206e74:	fec42683          	lw	a3,-20(s0)
    50206e78:	09400793          	li	a5,148
    50206e7c:	02f687b3          	mul	a5,a3,a5
    50206e80:	97ba                	add	a5,a5,a4
    50206e82:	47dc                	lw	a5,12(a5)
    50206e84:	2785                	addiw	a5,a5,1
    50206e86:	0007871b          	sext.w	a4,a5
    50206e8a:	00006697          	auipc	a3,0x6
    50206e8e:	4c668693          	addi	a3,a3,1222 # 5020d350 <mailbox_array>
    50206e92:	fec42603          	lw	a2,-20(s0)
    50206e96:	09400793          	li	a5,148
    50206e9a:	02f607b3          	mul	a5,a2,a5
    50206e9e:	97b6                	add	a5,a5,a3
    50206ea0:	c7d8                	sw	a4,12(a5)
    50206ea2:	00006517          	auipc	a0,0x6
    50206ea6:	4a650513          	addi	a0,a0,1190 # 5020d348 <visit_mailbox>
    50206eaa:	86bff0ef          	jal	ra,50206714 <mthread_semaphore_up>
    50206eae:	fec42703          	lw	a4,-20(s0)
    50206eb2:	09400793          	li	a5,148
    50206eb6:	02f70733          	mul	a4,a4,a5
    50206eba:	00006797          	auipc	a5,0x6
    50206ebe:	49678793          	addi	a5,a5,1174 # 5020d350 <mailbox_array>
    50206ec2:	97ba                	add	a5,a5,a4
    50206ec4:	a05d                	j	50206f6a <mbox_open+0x164>
    50206ec6:	fec42783          	lw	a5,-20(s0)
    50206eca:	2785                	addiw	a5,a5,1
    50206ecc:	fef42623          	sw	a5,-20(s0)
    50206ed0:	fec42783          	lw	a5,-20(s0)
    50206ed4:	0007871b          	sext.w	a4,a5
    50206ed8:	479d                	li	a5,7
    50206eda:	f4e7d5e3          	bge	a5,a4,50206e24 <mbox_open+0x1e>
    50206ede:	87018793          	addi	a5,gp,-1936 # 502096d0 <mailbox_num>
    50206ee2:	4398                	lw	a4,0(a5)
    50206ee4:	09400793          	li	a5,148
    50206ee8:	02f70733          	mul	a4,a4,a5
    50206eec:	00006797          	auipc	a5,0x6
    50206ef0:	46478793          	addi	a5,a5,1124 # 5020d350 <mailbox_array>
    50206ef4:	97ba                	add	a5,a5,a4
    50206ef6:	fef43023          	sd	a5,-32(s0)
    50206efa:	fe043783          	ld	a5,-32(s0)
    50206efe:	4705                	li	a4,1
    50206f00:	c398                	sw	a4,0(a5)
    50206f02:	fe043783          	ld	a5,-32(s0)
    50206f06:	0007a223          	sw	zero,4(a5)
    50206f0a:	fe043783          	ld	a5,-32(s0)
    50206f0e:	0007a423          	sw	zero,8(a5)
    50206f12:	fe043783          	ld	a5,-32(s0)
    50206f16:	4705                	li	a4,1
    50206f18:	c7d8                	sw	a4,12(a5)
    50206f1a:	fe043783          	ld	a5,-32(s0)
    50206f1e:	02078793          	addi	a5,a5,32
    50206f22:	fd843583          	ld	a1,-40(s0)
    50206f26:	853e                	mv	a0,a5
    50206f28:	c9eff0ef          	jal	ra,502063c6 <strcpy>
    50206f2c:	fe043783          	ld	a5,-32(s0)
    50206f30:	07e1                	addi	a5,a5,24
    50206f32:	4581                	li	a1,0
    50206f34:	853e                	mv	a0,a5
    50206f36:	f8aff0ef          	jal	ra,502066c0 <mthread_semaphore_init>
    50206f3a:	fe043783          	ld	a5,-32(s0)
    50206f3e:	07c1                	addi	a5,a5,16
    50206f40:	4585                	li	a1,1
    50206f42:	853e                	mv	a0,a5
    50206f44:	f7cff0ef          	jal	ra,502066c0 <mthread_semaphore_init>
    50206f48:	87018793          	addi	a5,gp,-1936 # 502096d0 <mailbox_num>
    50206f4c:	439c                	lw	a5,0(a5)
    50206f4e:	2785                	addiw	a5,a5,1
    50206f50:	0007871b          	sext.w	a4,a5
    50206f54:	87018793          	addi	a5,gp,-1936 # 502096d0 <mailbox_num>
    50206f58:	c398                	sw	a4,0(a5)
    50206f5a:	00006517          	auipc	a0,0x6
    50206f5e:	3ee50513          	addi	a0,a0,1006 # 5020d348 <visit_mailbox>
    50206f62:	fb2ff0ef          	jal	ra,50206714 <mthread_semaphore_up>
    50206f66:	fe043783          	ld	a5,-32(s0)
    50206f6a:	853e                	mv	a0,a5
    50206f6c:	70a2                	ld	ra,40(sp)
    50206f6e:	7402                	ld	s0,32(sp)
    50206f70:	6145                	addi	sp,sp,48
    50206f72:	8082                	ret

0000000050206f74 <mbox_close>:
    50206f74:	1101                	addi	sp,sp,-32
    50206f76:	ec06                	sd	ra,24(sp)
    50206f78:	e822                	sd	s0,16(sp)
    50206f7a:	1000                	addi	s0,sp,32
    50206f7c:	fea43423          	sd	a0,-24(s0)
    50206f80:	00006517          	auipc	a0,0x6
    50206f84:	3c850513          	addi	a0,a0,968 # 5020d348 <visit_mailbox>
    50206f88:	fc0ff0ef          	jal	ra,50206748 <mthread_semaphore_down>
    50206f8c:	fe843783          	ld	a5,-24(s0)
    50206f90:	439c                	lw	a5,0(a5)
    50206f92:	eb81                	bnez	a5,50206fa2 <mbox_close+0x2e>
    50206f94:	00006517          	auipc	a0,0x6
    50206f98:	3b450513          	addi	a0,a0,948 # 5020d348 <visit_mailbox>
    50206f9c:	f78ff0ef          	jal	ra,50206714 <mthread_semaphore_up>
    50206fa0:	a8b1                	j	50206ffc <mbox_close+0x88>
    50206fa2:	fe843783          	ld	a5,-24(s0)
    50206fa6:	47dc                	lw	a5,12(a5)
    50206fa8:	873e                	mv	a4,a5
    50206faa:	4785                	li	a5,1
    50206fac:	02e7c963          	blt	a5,a4,50206fde <mbox_close+0x6a>
    50206fb0:	fe843783          	ld	a5,-24(s0)
    50206fb4:	0007a623          	sw	zero,12(a5)
    50206fb8:	fe843783          	ld	a5,-24(s0)
    50206fbc:	0007a023          	sw	zero,0(a5)
    50206fc0:	fe843783          	ld	a5,-24(s0)
    50206fc4:	0007a223          	sw	zero,4(a5)
    50206fc8:	fe843783          	ld	a5,-24(s0)
    50206fcc:	0007a423          	sw	zero,8(a5)
    50206fd0:	00006517          	auipc	a0,0x6
    50206fd4:	37850513          	addi	a0,a0,888 # 5020d348 <visit_mailbox>
    50206fd8:	f3cff0ef          	jal	ra,50206714 <mthread_semaphore_up>
    50206fdc:	a005                	j	50206ffc <mbox_close+0x88>
    50206fde:	fe843783          	ld	a5,-24(s0)
    50206fe2:	47dc                	lw	a5,12(a5)
    50206fe4:	37fd                	addiw	a5,a5,-1
    50206fe6:	0007871b          	sext.w	a4,a5
    50206fea:	fe843783          	ld	a5,-24(s0)
    50206fee:	c7d8                	sw	a4,12(a5)
    50206ff0:	00006517          	auipc	a0,0x6
    50206ff4:	35850513          	addi	a0,a0,856 # 5020d348 <visit_mailbox>
    50206ff8:	f1cff0ef          	jal	ra,50206714 <mthread_semaphore_up>
    50206ffc:	60e2                	ld	ra,24(sp)
    50206ffe:	6442                	ld	s0,16(sp)
    50207000:	6105                	addi	sp,sp,32
    50207002:	8082                	ret

0000000050207004 <mbox_send>:
    50207004:	7139                	addi	sp,sp,-64
    50207006:	fc06                	sd	ra,56(sp)
    50207008:	f822                	sd	s0,48(sp)
    5020700a:	0080                	addi	s0,sp,64
    5020700c:	fca43c23          	sd	a0,-40(s0)
    50207010:	fcb43823          	sd	a1,-48(s0)
    50207014:	87b2                	mv	a5,a2
    50207016:	fcf42623          	sw	a5,-52(s0)
    5020701a:	fe042623          	sw	zero,-20(s0)
    5020701e:	00006517          	auipc	a0,0x6
    50207022:	32a50513          	addi	a0,a0,810 # 5020d348 <visit_mailbox>
    50207026:	f22ff0ef          	jal	ra,50206748 <mthread_semaphore_down>
    5020702a:	fd843783          	ld	a5,-40(s0)
    5020702e:	4798                	lw	a4,8(a5)
    50207030:	fd843783          	ld	a5,-40(s0)
    50207034:	43dc                	lw	a5,4(a5)
    50207036:	02e7d063          	bge	a5,a4,50207056 <mbox_send+0x52>
    5020703a:	00006517          	auipc	a0,0x6
    5020703e:	30e50513          	addi	a0,a0,782 # 5020d348 <visit_mailbox>
    50207042:	ed2ff0ef          	jal	ra,50206714 <mthread_semaphore_up>
    50207046:	fec42783          	lw	a5,-20(s0)
    5020704a:	2785                	addiw	a5,a5,1
    5020704c:	fef42623          	sw	a5,-20(s0)
    50207050:	885ff0ef          	jal	ra,502068d4 <sys_yield>
    50207054:	b7e9                	j	5020701e <mbox_send+0x1a>
    50207056:	0001                	nop
    50207058:	fd843783          	ld	a5,-40(s0)
    5020705c:	05278793          	addi	a5,a5,82
    50207060:	fcc42703          	lw	a4,-52(s0)
    50207064:	863a                	mv	a2,a4
    50207066:	fd043583          	ld	a1,-48(s0)
    5020706a:	853e                	mv	a0,a5
    5020706c:	9fcff0ef          	jal	ra,50206268 <memcpy>
    50207070:	fd843783          	ld	a5,-40(s0)
    50207074:	0007a223          	sw	zero,4(a5)
    50207078:	fd843783          	ld	a5,-40(s0)
    5020707c:	fcc42703          	lw	a4,-52(s0)
    50207080:	c798                	sw	a4,8(a5)
    50207082:	00006517          	auipc	a0,0x6
    50207086:	2c650513          	addi	a0,a0,710 # 5020d348 <visit_mailbox>
    5020708a:	e8aff0ef          	jal	ra,50206714 <mthread_semaphore_up>
    5020708e:	0f4000ef          	jal	ra,50207182 <rand>
    50207092:	87aa                	mv	a5,a0
    50207094:	873e                	mv	a4,a5
    50207096:	4795                	li	a5,5
    50207098:	02f767bb          	remw	a5,a4,a5
    5020709c:	2781                	sext.w	a5,a5
    5020709e:	2785                	addiw	a5,a5,1
    502070a0:	fef42423          	sw	a5,-24(s0)
    502070a4:	fe842783          	lw	a5,-24(s0)
    502070a8:	853e                	mv	a0,a5
    502070aa:	f6aff0ef          	jal	ra,50206814 <sys_sleep>
    502070ae:	fec42783          	lw	a5,-20(s0)
    502070b2:	853e                	mv	a0,a5
    502070b4:	70e2                	ld	ra,56(sp)
    502070b6:	7442                	ld	s0,48(sp)
    502070b8:	6121                	addi	sp,sp,64
    502070ba:	8082                	ret

00000000502070bc <mbox_recv>:
    502070bc:	7139                	addi	sp,sp,-64
    502070be:	fc06                	sd	ra,56(sp)
    502070c0:	f822                	sd	s0,48(sp)
    502070c2:	0080                	addi	s0,sp,64
    502070c4:	fca43c23          	sd	a0,-40(s0)
    502070c8:	fcb43823          	sd	a1,-48(s0)
    502070cc:	87b2                	mv	a5,a2
    502070ce:	fcf42623          	sw	a5,-52(s0)
    502070d2:	fe042623          	sw	zero,-20(s0)
    502070d6:	00006517          	auipc	a0,0x6
    502070da:	27250513          	addi	a0,a0,626 # 5020d348 <visit_mailbox>
    502070de:	e6aff0ef          	jal	ra,50206748 <mthread_semaphore_down>
    502070e2:	fd843783          	ld	a5,-40(s0)
    502070e6:	4798                	lw	a4,8(a5)
    502070e8:	fd843783          	ld	a5,-40(s0)
    502070ec:	43dc                	lw	a5,4(a5)
    502070ee:	02e7c063          	blt	a5,a4,5020710e <mbox_recv+0x52>
    502070f2:	00006517          	auipc	a0,0x6
    502070f6:	25650513          	addi	a0,a0,598 # 5020d348 <visit_mailbox>
    502070fa:	e1aff0ef          	jal	ra,50206714 <mthread_semaphore_up>
    502070fe:	fec42783          	lw	a5,-20(s0)
    50207102:	2785                	addiw	a5,a5,1
    50207104:	fef42623          	sw	a5,-20(s0)
    50207108:	fccff0ef          	jal	ra,502068d4 <sys_yield>
    5020710c:	b7e9                	j	502070d6 <mbox_recv+0x1a>
    5020710e:	0001                	nop
    50207110:	fd843783          	ld	a5,-40(s0)
    50207114:	05278793          	addi	a5,a5,82
    50207118:	fd843703          	ld	a4,-40(s0)
    5020711c:	4358                	lw	a4,4(a4)
    5020711e:	97ba                	add	a5,a5,a4
    50207120:	fcc42703          	lw	a4,-52(s0)
    50207124:	863a                	mv	a2,a4
    50207126:	85be                	mv	a1,a5
    50207128:	fd043503          	ld	a0,-48(s0)
    5020712c:	93cff0ef          	jal	ra,50206268 <memcpy>
    50207130:	fd843783          	ld	a5,-40(s0)
    50207134:	43dc                	lw	a5,4(a5)
    50207136:	fcc42703          	lw	a4,-52(s0)
    5020713a:	9fb9                	addw	a5,a5,a4
    5020713c:	0007871b          	sext.w	a4,a5
    50207140:	fd843783          	ld	a5,-40(s0)
    50207144:	c3d8                	sw	a4,4(a5)
    50207146:	00006517          	auipc	a0,0x6
    5020714a:	20250513          	addi	a0,a0,514 # 5020d348 <visit_mailbox>
    5020714e:	dc6ff0ef          	jal	ra,50206714 <mthread_semaphore_up>
    50207152:	fec42783          	lw	a5,-20(s0)
    50207156:	853e                	mv	a0,a5
    50207158:	70e2                	ld	ra,56(sp)
    5020715a:	7442                	ld	s0,48(sp)
    5020715c:	6121                	addi	sp,sp,64
    5020715e:	8082                	ret

0000000050207160 <srand>:
    50207160:	1101                	addi	sp,sp,-32
    50207162:	ec22                	sd	s0,24(sp)
    50207164:	1000                	addi	s0,sp,32
    50207166:	87aa                	mv	a5,a0
    50207168:	fef42623          	sw	a5,-20(s0)
    5020716c:	fec42703          	lw	a4,-20(s0)
    50207170:	00006797          	auipc	a5,0x6
    50207174:	68078793          	addi	a5,a5,1664 # 5020d7f0 <x>
    50207178:	c398                	sw	a4,0(a5)
    5020717a:	0001                	nop
    5020717c:	6462                	ld	s0,24(sp)
    5020717e:	6105                	addi	sp,sp,32
    50207180:	8082                	ret

0000000050207182 <rand>:
    50207182:	1101                	addi	sp,sp,-32
    50207184:	ec22                	sd	s0,24(sp)
    50207186:	1000                	addi	s0,sp,32
    50207188:	00006797          	auipc	a5,0x6
    5020718c:	66878793          	addi	a5,a5,1640 # 5020d7f0 <x>
    50207190:	439c                	lw	a5,0(a5)
    50207192:	873e                	mv	a4,a5
    50207194:	00002797          	auipc	a5,0x2
    50207198:	c9478793          	addi	a5,a5,-876 # 50208e28 <__FUNCTION__.1403+0x138>
    5020719c:	639c                	ld	a5,0(a5)
    5020719e:	02f707b3          	mul	a5,a4,a5
    502071a2:	07ad                	addi	a5,a5,11
    502071a4:	fef43423          	sd	a5,-24(s0)
    502071a8:	fe843783          	ld	a5,-24(s0)
    502071ac:	0007871b          	sext.w	a4,a5
    502071b0:	800007b7          	lui	a5,0x80000
    502071b4:	fff7c793          	not	a5,a5
    502071b8:	8ff9                	and	a5,a5,a4
    502071ba:	0007871b          	sext.w	a4,a5
    502071be:	00006797          	auipc	a5,0x6
    502071c2:	63278793          	addi	a5,a5,1586 # 5020d7f0 <x>
    502071c6:	c398                	sw	a4,0(a5)
    502071c8:	00006797          	auipc	a5,0x6
    502071cc:	62878793          	addi	a5,a5,1576 # 5020d7f0 <x>
    502071d0:	439c                	lw	a5,0(a5)
    502071d2:	853e                	mv	a0,a5
    502071d4:	6462                	ld	s0,24(sp)
    502071d6:	6105                	addi	sp,sp,32
    502071d8:	8082                	ret

00000000502071da <test_shell>:
    502071da:	de010113          	addi	sp,sp,-544
    502071de:	20113c23          	sd	ra,536(sp)
    502071e2:	20813823          	sd	s0,528(sp)
    502071e6:	1400                	addi	s0,sp,544
    502071e8:	845ff0ef          	jal	ra,50206a2c <sys_screen_clear>
    502071ec:	45e5                	li	a1,25
    502071ee:	4505                	li	a0,1
    502071f0:	fbcff0ef          	jal	ra,502069ac <sys_move_cursor>
    502071f4:	00002517          	auipc	a0,0x2
    502071f8:	c3c50513          	addi	a0,a0,-964 # 50208e30 <__FUNCTION__.1403+0x140>
    502071fc:	fdffe0ef          	jal	ra,502061da <printf>
    50207200:	00002517          	auipc	a0,0x2
    50207204:	c6850513          	addi	a0,a0,-920 # 50208e68 <__FUNCTION__.1403+0x178>
    50207208:	fd3fe0ef          	jal	ra,502061da <printf>
    5020720c:	803ff0ef          	jal	ra,50206a0e <sys_reflush>
    50207210:	f2043823          	sd	zero,-208(s0)
    50207214:	f2043c23          	sd	zero,-200(s0)
    50207218:	f4043023          	sd	zero,-192(s0)
    5020721c:	f4043423          	sd	zero,-184(s0)
    50207220:	f4043823          	sd	zero,-176(s0)
    50207224:	f4043c23          	sd	zero,-168(s0)
    50207228:	f6043023          	sd	zero,-160(s0)
    5020722c:	f6043423          	sd	zero,-152(s0)
    50207230:	f6043823          	sd	zero,-144(s0)
    50207234:	f6043c23          	sd	zero,-136(s0)
    50207238:	f8043023          	sd	zero,-128(s0)
    5020723c:	f8043423          	sd	zero,-120(s0)
    50207240:	f8043823          	sd	zero,-112(s0)
    50207244:	f8043c23          	sd	zero,-104(s0)
    50207248:	fa043023          	sd	zero,-96(s0)
    5020724c:	fa043423          	sd	zero,-88(s0)
    50207250:	fe042623          	sw	zero,-20(s0)
    50207254:	47c9                	li	a5,18
    50207256:	fcf42a23          	sw	a5,-44(s0)
    5020725a:	ff0ff0ef          	jal	ra,50206a4a <sys_getchar>
    5020725e:	87aa                	mv	a5,a0
    50207260:	fcf409a3          	sb	a5,-45(s0)
    50207264:	fd344783          	lbu	a5,-45(s0)
    50207268:	0ff7f713          	andi	a4,a5,255
    5020726c:	47a1                	li	a5,8
    5020726e:	00f70a63          	beq	a4,a5,50207282 <test_shell+0xa8>
    50207272:	fd344783          	lbu	a5,-45(s0)
    50207276:	0ff7f713          	andi	a4,a5,255
    5020727a:	07f00793          	li	a5,127
    5020727e:	02f71763          	bne	a4,a5,502072ac <test_shell+0xd2>
    50207282:	fec42783          	lw	a5,-20(s0)
    50207286:	2781                	sext.w	a5,a5
    50207288:	08f05f63          	blez	a5,50207326 <test_shell+0x14c>
    5020728c:	fec42783          	lw	a5,-20(s0)
    50207290:	37fd                	addiw	a5,a5,-1
    50207292:	fef42623          	sw	a5,-20(s0)
    50207296:	fd344783          	lbu	a5,-45(s0)
    5020729a:	2781                	sext.w	a5,a5
    5020729c:	85be                	mv	a1,a5
    5020729e:	00002517          	auipc	a0,0x2
    502072a2:	be250513          	addi	a0,a0,-1054 # 50208e80 <__FUNCTION__.1403+0x190>
    502072a6:	f35fe0ef          	jal	ra,502061da <printf>
    502072aa:	a8b5                	j	50207326 <test_shell+0x14c>
    502072ac:	fd344783          	lbu	a5,-45(s0)
    502072b0:	0ff7f713          	andi	a4,a5,255
    502072b4:	47a9                	li	a5,10
    502072b6:	00f70963          	beq	a4,a5,502072c8 <test_shell+0xee>
    502072ba:	fd344783          	lbu	a5,-45(s0)
    502072be:	0ff7f713          	andi	a4,a5,255
    502072c2:	47b5                	li	a5,13
    502072c4:	02f71a63          	bne	a4,a5,502072f8 <test_shell+0x11e>
    502072c8:	00002517          	auipc	a0,0x2
    502072cc:	bc050513          	addi	a0,a0,-1088 # 50208e88 <__FUNCTION__.1403+0x198>
    502072d0:	f0bfe0ef          	jal	ra,502061da <printf>
    502072d4:	fec42783          	lw	a5,-20(s0)
    502072d8:	ff040713          	addi	a4,s0,-16
    502072dc:	97ba                	add	a5,a5,a4
    502072de:	f4078023          	sb	zero,-192(a5)
    502072e2:	fe042623          	sw	zero,-20(s0)
    502072e6:	f28ff0ef          	jal	ra,50206a0e <sys_reflush>
    502072ea:	0001                	nop
    502072ec:	57fd                	li	a5,-1
    502072ee:	fef42423          	sw	a5,-24(s0)
    502072f2:	fe042223          	sw	zero,-28(s0)
    502072f6:	a81d                	j	5020732c <test_shell+0x152>
    502072f8:	fd344783          	lbu	a5,-45(s0)
    502072fc:	2781                	sext.w	a5,a5
    502072fe:	85be                	mv	a1,a5
    50207300:	00002517          	auipc	a0,0x2
    50207304:	b8050513          	addi	a0,a0,-1152 # 50208e80 <__FUNCTION__.1403+0x190>
    50207308:	ed3fe0ef          	jal	ra,502061da <printf>
    5020730c:	fec42783          	lw	a5,-20(s0)
    50207310:	0017871b          	addiw	a4,a5,1
    50207314:	fee42623          	sw	a4,-20(s0)
    50207318:	ff040713          	addi	a4,s0,-16
    5020731c:	97ba                	add	a5,a5,a4
    5020731e:	fd344703          	lbu	a4,-45(s0)
    50207322:	f4e78023          	sb	a4,-192(a5)
    50207326:	ee8ff0ef          	jal	ra,50206a0e <sys_reflush>
    5020732a:	bf05                	j	5020725a <test_shell+0x80>
    5020732c:	fe442783          	lw	a5,-28(s0)
    50207330:	ff040713          	addi	a4,s0,-16
    50207334:	97ba                	add	a5,a5,a4
    50207336:	f407c783          	lbu	a5,-192(a5)
    5020733a:	e781                	bnez	a5,50207342 <test_shell+0x168>
    5020733c:	fe042423          	sw	zero,-24(s0)
    50207340:	a091                	j	50207384 <test_shell+0x1aa>
    50207342:	fe442783          	lw	a5,-28(s0)
    50207346:	ff040713          	addi	a4,s0,-16
    5020734a:	97ba                	add	a5,a5,a4
    5020734c:	f407c783          	lbu	a5,-192(a5)
    50207350:	873e                	mv	a4,a5
    50207352:	02000793          	li	a5,32
    50207356:	02f70663          	beq	a4,a5,50207382 <test_shell+0x1a8>
    5020735a:	fe442783          	lw	a5,-28(s0)
    5020735e:	ff040713          	addi	a4,s0,-16
    50207362:	97ba                	add	a5,a5,a4
    50207364:	f407c703          	lbu	a4,-192(a5)
    50207368:	fe442783          	lw	a5,-28(s0)
    5020736c:	ff040693          	addi	a3,s0,-16
    50207370:	97b6                	add	a5,a5,a3
    50207372:	dee78c23          	sb	a4,-520(a5)
    50207376:	fe442783          	lw	a5,-28(s0)
    5020737a:	2785                	addiw	a5,a5,1
    5020737c:	fef42223          	sw	a5,-28(s0)
    50207380:	b775                	j	5020732c <test_shell+0x152>
    50207382:	0001                	nop
    50207384:	fe442783          	lw	a5,-28(s0)
    50207388:	ff040713          	addi	a4,s0,-16
    5020738c:	97ba                	add	a5,a5,a4
    5020738e:	de078c23          	sb	zero,-520(a5)
    50207392:	fe842783          	lw	a5,-24(s0)
    50207396:	2781                	sext.w	a5,a5
    50207398:	c7e5                	beqz	a5,50207480 <test_shell+0x2a6>
    5020739a:	fe442783          	lw	a5,-28(s0)
    5020739e:	2785                	addiw	a5,a5,1
    502073a0:	fef42223          	sw	a5,-28(s0)
    502073a4:	fe042023          	sw	zero,-32(s0)
    502073a8:	fc042e23          	sw	zero,-36(s0)
    502073ac:	fe042423          	sw	zero,-24(s0)
    502073b0:	fe442783          	lw	a5,-28(s0)
    502073b4:	ff040713          	addi	a4,s0,-16
    502073b8:	97ba                	add	a5,a5,a4
    502073ba:	f407c783          	lbu	a5,-192(a5)
    502073be:	e78d                	bnez	a5,502073e8 <test_shell+0x20e>
    502073c0:	fdc42683          	lw	a3,-36(s0)
    502073c4:	fe042703          	lw	a4,-32(s0)
    502073c8:	87ba                	mv	a5,a4
    502073ca:	078a                	slli	a5,a5,0x2
    502073cc:	97ba                	add	a5,a5,a4
    502073ce:	078a                	slli	a5,a5,0x2
    502073d0:	ff040713          	addi	a4,s0,-16
    502073d4:	97ba                	add	a5,a5,a4
    502073d6:	97b6                	add	a5,a5,a3
    502073d8:	e6078c23          	sb	zero,-392(a5)
    502073dc:	fe842783          	lw	a5,-24(s0)
    502073e0:	2785                	addiw	a5,a5,1
    502073e2:	fef42423          	sw	a5,-24(s0)
    502073e6:	a869                	j	50207480 <test_shell+0x2a6>
    502073e8:	fe442783          	lw	a5,-28(s0)
    502073ec:	ff040713          	addi	a4,s0,-16
    502073f0:	97ba                	add	a5,a5,a4
    502073f2:	f407c783          	lbu	a5,-192(a5)
    502073f6:	873e                	mv	a4,a5
    502073f8:	02000793          	li	a5,32
    502073fc:	04f71263          	bne	a4,a5,50207440 <test_shell+0x266>
    50207400:	fdc42683          	lw	a3,-36(s0)
    50207404:	fe042703          	lw	a4,-32(s0)
    50207408:	87ba                	mv	a5,a4
    5020740a:	078a                	slli	a5,a5,0x2
    5020740c:	97ba                	add	a5,a5,a4
    5020740e:	078a                	slli	a5,a5,0x2
    50207410:	ff040713          	addi	a4,s0,-16
    50207414:	97ba                	add	a5,a5,a4
    50207416:	97b6                	add	a5,a5,a3
    50207418:	e6078c23          	sb	zero,-392(a5)
    5020741c:	fe842783          	lw	a5,-24(s0)
    50207420:	2785                	addiw	a5,a5,1
    50207422:	fef42423          	sw	a5,-24(s0)
    50207426:	fe442783          	lw	a5,-28(s0)
    5020742a:	2785                	addiw	a5,a5,1
    5020742c:	fef42223          	sw	a5,-28(s0)
    50207430:	fe042783          	lw	a5,-32(s0)
    50207434:	2785                	addiw	a5,a5,1
    50207436:	fef42023          	sw	a5,-32(s0)
    5020743a:	fc042e23          	sw	zero,-36(s0)
    5020743e:	bf8d                	j	502073b0 <test_shell+0x1d6>
    50207440:	fe442783          	lw	a5,-28(s0)
    50207444:	ff040713          	addi	a4,s0,-16
    50207448:	97ba                	add	a5,a5,a4
    5020744a:	f407c683          	lbu	a3,-192(a5)
    5020744e:	fdc42603          	lw	a2,-36(s0)
    50207452:	fe042703          	lw	a4,-32(s0)
    50207456:	87ba                	mv	a5,a4
    50207458:	078a                	slli	a5,a5,0x2
    5020745a:	97ba                	add	a5,a5,a4
    5020745c:	078a                	slli	a5,a5,0x2
    5020745e:	ff040713          	addi	a4,s0,-16
    50207462:	97ba                	add	a5,a5,a4
    50207464:	97b2                	add	a5,a5,a2
    50207466:	e6d78c23          	sb	a3,-392(a5)
    5020746a:	fe442783          	lw	a5,-28(s0)
    5020746e:	2785                	addiw	a5,a5,1
    50207470:	fef42223          	sw	a5,-28(s0)
    50207474:	fdc42783          	lw	a5,-36(s0)
    50207478:	2785                	addiw	a5,a5,1
    5020747a:	fcf42e23          	sw	a5,-36(s0)
    5020747e:	bf0d                	j	502073b0 <test_shell+0x1d6>
    50207480:	de840793          	addi	a5,s0,-536
    50207484:	00002597          	auipc	a1,0x2
    50207488:	a0c58593          	addi	a1,a1,-1524 # 50208e90 <__FUNCTION__.1403+0x1a0>
    5020748c:	853e                	mv	a0,a5
    5020748e:	eabfe0ef          	jal	ra,50206338 <strcmp>
    50207492:	87aa                	mv	a5,a0
    50207494:	e781                	bnez	a5,5020749c <test_shell+0x2c2>
    50207496:	bfeff0ef          	jal	ra,50206894 <sys_process_show>
    5020749a:	ac65                	j	50207752 <test_shell+0x578>
    5020749c:	de840793          	addi	a5,s0,-536
    502074a0:	00002597          	auipc	a1,0x2
    502074a4:	9f858593          	addi	a1,a1,-1544 # 50208e98 <__FUNCTION__.1403+0x1a8>
    502074a8:	853e                	mv	a0,a5
    502074aa:	e8ffe0ef          	jal	ra,50206338 <strcmp>
    502074ae:	87aa                	mv	a5,a0
    502074b0:	ef91                	bnez	a5,502074cc <test_shell+0x2f2>
    502074b2:	d7aff0ef          	jal	ra,50206a2c <sys_screen_clear>
    502074b6:	45e5                	li	a1,25
    502074b8:	4505                	li	a0,1
    502074ba:	cf2ff0ef          	jal	ra,502069ac <sys_move_cursor>
    502074be:	00002517          	auipc	a0,0x2
    502074c2:	97250513          	addi	a0,a0,-1678 # 50208e30 <__FUNCTION__.1403+0x140>
    502074c6:	d15fe0ef          	jal	ra,502061da <printf>
    502074ca:	a461                	j	50207752 <test_shell+0x578>
    502074cc:	de840793          	addi	a5,s0,-536
    502074d0:	00002597          	auipc	a1,0x2
    502074d4:	9d058593          	addi	a1,a1,-1584 # 50208ea0 <__FUNCTION__.1403+0x1b0>
    502074d8:	853e                	mv	a0,a5
    502074da:	e5ffe0ef          	jal	ra,50206338 <strcmp>
    502074de:	87aa                	mv	a5,a0
    502074e0:	eba1                	bnez	a5,50207530 <test_shell+0x356>
    502074e2:	fc042c23          	sw	zero,-40(s0)
    502074e6:	a035                	j	50207512 <test_shell+0x338>
    502074e8:	e6840693          	addi	a3,s0,-408
    502074ec:	fd842703          	lw	a4,-40(s0)
    502074f0:	87ba                	mv	a5,a4
    502074f2:	078a                	slli	a5,a5,0x2
    502074f4:	97ba                	add	a5,a5,a4
    502074f6:	078a                	slli	a5,a5,0x2
    502074f8:	97b6                	add	a5,a5,a3
    502074fa:	85be                	mv	a1,a5
    502074fc:	00002517          	auipc	a0,0x2
    50207500:	9ac50513          	addi	a0,a0,-1620 # 50208ea8 <__FUNCTION__.1403+0x1b8>
    50207504:	cd7fe0ef          	jal	ra,502061da <printf>
    50207508:	fd842783          	lw	a5,-40(s0)
    5020750c:	2785                	addiw	a5,a5,1
    5020750e:	fcf42c23          	sw	a5,-40(s0)
    50207512:	fd842703          	lw	a4,-40(s0)
    50207516:	fe842783          	lw	a5,-24(s0)
    5020751a:	2701                	sext.w	a4,a4
    5020751c:	2781                	sext.w	a5,a5
    5020751e:	fcf745e3          	blt	a4,a5,502074e8 <test_shell+0x30e>
    50207522:	00002517          	auipc	a0,0x2
    50207526:	96650513          	addi	a0,a0,-1690 # 50208e88 <__FUNCTION__.1403+0x198>
    5020752a:	cb1fe0ef          	jal	ra,502061da <printf>
    5020752e:	a415                	j	50207752 <test_shell+0x578>
    50207530:	de840793          	addi	a5,s0,-536
    50207534:	00002597          	auipc	a1,0x2
    50207538:	97c58593          	addi	a1,a1,-1668 # 50208eb0 <__FUNCTION__.1403+0x1c0>
    5020753c:	853e                	mv	a0,a5
    5020753e:	dfbfe0ef          	jal	ra,50206338 <strcmp>
    50207542:	87aa                	mv	a5,a0
    50207544:	e7a1                	bnez	a5,5020758c <test_shell+0x3b2>
    50207546:	e6840793          	addi	a5,s0,-408
    5020754a:	853e                	mv	a0,a5
    5020754c:	f3dfe0ef          	jal	ra,50206488 <atoi>
    50207550:	87aa                	mv	a5,a0
    50207552:	faf42c23          	sw	a5,-72(s0)
    50207556:	00002717          	auipc	a4,0x2
    5020755a:	08a70713          	addi	a4,a4,138 # 502095e0 <test_tasks>
    5020755e:	fb842783          	lw	a5,-72(s0)
    50207562:	078e                	slli	a5,a5,0x3
    50207564:	97ba                	add	a5,a5,a4
    50207566:	639c                	ld	a5,0(a5)
    50207568:	4601                	li	a2,0
    5020756a:	4581                	li	a1,0
    5020756c:	853e                	mv	a0,a5
    5020756e:	a4eff0ef          	jal	ra,502067bc <sys_spawn>
    50207572:	87aa                	mv	a5,a0
    50207574:	faf42a23          	sw	a5,-76(s0)
    50207578:	fb842783          	lw	a5,-72(s0)
    5020757c:	85be                	mv	a1,a5
    5020757e:	00002517          	auipc	a0,0x2
    50207582:	93a50513          	addi	a0,a0,-1734 # 50208eb8 <__FUNCTION__.1403+0x1c8>
    50207586:	c55fe0ef          	jal	ra,502061da <printf>
    5020758a:	a2e1                	j	50207752 <test_shell+0x578>
    5020758c:	de840793          	addi	a5,s0,-536
    50207590:	00002597          	auipc	a1,0x2
    50207594:	94058593          	addi	a1,a1,-1728 # 50208ed0 <__FUNCTION__.1403+0x1e0>
    50207598:	853e                	mv	a0,a5
    5020759a:	d9ffe0ef          	jal	ra,50206338 <strcmp>
    5020759e:	87aa                	mv	a5,a0
    502075a0:	e7a5                	bnez	a5,50207608 <test_shell+0x42e>
    502075a2:	e6840793          	addi	a5,s0,-408
    502075a6:	853e                	mv	a0,a5
    502075a8:	ee1fe0ef          	jal	ra,50206488 <atoi>
    502075ac:	87aa                	mv	a5,a0
    502075ae:	fcf42023          	sw	a5,-64(s0)
    502075b2:	fc042783          	lw	a5,-64(s0)
    502075b6:	853e                	mv	a0,a5
    502075b8:	a84ff0ef          	jal	ra,5020683c <sys_kill>
    502075bc:	87aa                	mv	a5,a0
    502075be:	faf42e23          	sw	a5,-68(s0)
    502075c2:	fbc42783          	lw	a5,-68(s0)
    502075c6:	0007871b          	sext.w	a4,a5
    502075ca:	57fd                	li	a5,-1
    502075cc:	00f71963          	bne	a4,a5,502075de <test_shell+0x404>
    502075d0:	00002517          	auipc	a0,0x2
    502075d4:	90850513          	addi	a0,a0,-1784 # 50208ed8 <__FUNCTION__.1403+0x1e8>
    502075d8:	c03fe0ef          	jal	ra,502061da <printf>
    502075dc:	aa9d                	j	50207752 <test_shell+0x578>
    502075de:	fbc42783          	lw	a5,-68(s0)
    502075e2:	2781                	sext.w	a5,a5
    502075e4:	eb81                	bnez	a5,502075f4 <test_shell+0x41a>
    502075e6:	00002517          	auipc	a0,0x2
    502075ea:	90a50513          	addi	a0,a0,-1782 # 50208ef0 <__FUNCTION__.1403+0x200>
    502075ee:	bedfe0ef          	jal	ra,502061da <printf>
    502075f2:	a285                	j	50207752 <test_shell+0x578>
    502075f4:	fc042783          	lw	a5,-64(s0)
    502075f8:	85be                	mv	a1,a5
    502075fa:	00002517          	auipc	a0,0x2
    502075fe:	91650513          	addi	a0,a0,-1770 # 50208f10 <__FUNCTION__.1403+0x220>
    50207602:	bd9fe0ef          	jal	ra,502061da <printf>
    50207606:	a2b1                	j	50207752 <test_shell+0x578>
    50207608:	de840793          	addi	a5,s0,-536
    5020760c:	00002597          	auipc	a1,0x2
    50207610:	91c58593          	addi	a1,a1,-1764 # 50208f28 <__FUNCTION__.1403+0x238>
    50207614:	853e                	mv	a0,a5
    50207616:	d23fe0ef          	jal	ra,50206338 <strcmp>
    5020761a:	87aa                	mv	a5,a0
    5020761c:	12079563          	bnez	a5,50207746 <test_shell+0x56c>
    50207620:	e6840793          	addi	a5,s0,-408
    50207624:	00002597          	auipc	a1,0x2
    50207628:	90c58593          	addi	a1,a1,-1780 # 50208f30 <__FUNCTION__.1403+0x240>
    5020762c:	853e                	mv	a0,a5
    5020762e:	d0bfe0ef          	jal	ra,50206338 <strcmp>
    50207632:	87aa                	mv	a5,a0
    50207634:	eba5                	bnez	a5,502076a4 <test_shell+0x4ca>
    50207636:	e6840793          	addi	a5,s0,-408
    5020763a:	02878793          	addi	a5,a5,40
    5020763e:	853e                	mv	a0,a5
    50207640:	e49fe0ef          	jal	ra,50206488 <atoi>
    50207644:	87aa                	mv	a5,a0
    50207646:	fcf42223          	sw	a5,-60(s0)
    5020764a:	e6840793          	addi	a5,s0,-408
    5020764e:	07d1                	addi	a5,a5,20
    50207650:	00002597          	auipc	a1,0x2
    50207654:	8e858593          	addi	a1,a1,-1816 # 50208f38 <__FUNCTION__.1403+0x248>
    50207658:	853e                	mv	a0,a5
    5020765a:	cdffe0ef          	jal	ra,50206338 <strcmp>
    5020765e:	87aa                	mv	a5,a0
    50207660:	eb81                	bnez	a5,50207670 <test_shell+0x496>
    50207662:	fc442783          	lw	a5,-60(s0)
    50207666:	4581                	li	a1,0
    50207668:	853e                	mv	a0,a5
    5020766a:	ecaff0ef          	jal	ra,50206d34 <sys_taskset>
    5020766e:	a0d5                	j	50207752 <test_shell+0x578>
    50207670:	e6840793          	addi	a5,s0,-408
    50207674:	07d1                	addi	a5,a5,20
    50207676:	00002597          	auipc	a1,0x2
    5020767a:	8ca58593          	addi	a1,a1,-1846 # 50208f40 <__FUNCTION__.1403+0x250>
    5020767e:	853e                	mv	a0,a5
    50207680:	cb9fe0ef          	jal	ra,50206338 <strcmp>
    50207684:	87aa                	mv	a5,a0
    50207686:	eb81                	bnez	a5,50207696 <test_shell+0x4bc>
    50207688:	fc442783          	lw	a5,-60(s0)
    5020768c:	4585                	li	a1,1
    5020768e:	853e                	mv	a0,a5
    50207690:	ea4ff0ef          	jal	ra,50206d34 <sys_taskset>
    50207694:	a87d                	j	50207752 <test_shell+0x578>
    50207696:	fc442783          	lw	a5,-60(s0)
    5020769a:	55fd                	li	a1,-1
    5020769c:	853e                	mv	a0,a5
    5020769e:	e96ff0ef          	jal	ra,50206d34 <sys_taskset>
    502076a2:	a845                	j	50207752 <test_shell+0x578>
    502076a4:	e6840793          	addi	a5,s0,-408
    502076a8:	07d1                	addi	a5,a5,20
    502076aa:	853e                	mv	a0,a5
    502076ac:	dddfe0ef          	jal	ra,50206488 <atoi>
    502076b0:	87aa                	mv	a5,a0
    502076b2:	fcf42623          	sw	a5,-52(s0)
    502076b6:	e6840713          	addi	a4,s0,-408
    502076ba:	fcc42783          	lw	a5,-52(s0)
    502076be:	863a                	mv	a2,a4
    502076c0:	85be                	mv	a1,a5
    502076c2:	00002517          	auipc	a0,0x2
    502076c6:	88650513          	addi	a0,a0,-1914 # 50208f48 <__FUNCTION__.1403+0x258>
    502076ca:	c0cfe0ef          	jal	ra,50205ad6 <prints>
    502076ce:	00002717          	auipc	a4,0x2
    502076d2:	f1270713          	addi	a4,a4,-238 # 502095e0 <test_tasks>
    502076d6:	fcc42783          	lw	a5,-52(s0)
    502076da:	078e                	slli	a5,a5,0x3
    502076dc:	97ba                	add	a5,a5,a4
    502076de:	639c                	ld	a5,0(a5)
    502076e0:	4601                	li	a2,0
    502076e2:	4581                	li	a1,0
    502076e4:	853e                	mv	a0,a5
    502076e6:	8d6ff0ef          	jal	ra,502067bc <sys_spawn>
    502076ea:	87aa                	mv	a5,a0
    502076ec:	fcf42423          	sw	a5,-56(s0)
    502076f0:	e6840793          	addi	a5,s0,-408
    502076f4:	00002597          	auipc	a1,0x2
    502076f8:	84458593          	addi	a1,a1,-1980 # 50208f38 <__FUNCTION__.1403+0x248>
    502076fc:	853e                	mv	a0,a5
    502076fe:	c3bfe0ef          	jal	ra,50206338 <strcmp>
    50207702:	87aa                	mv	a5,a0
    50207704:	eb81                	bnez	a5,50207714 <test_shell+0x53a>
    50207706:	fc842783          	lw	a5,-56(s0)
    5020770a:	4581                	li	a1,0
    5020770c:	853e                	mv	a0,a5
    5020770e:	e26ff0ef          	jal	ra,50206d34 <sys_taskset>
    50207712:	a081                	j	50207752 <test_shell+0x578>
    50207714:	e6840793          	addi	a5,s0,-408
    50207718:	00002597          	auipc	a1,0x2
    5020771c:	82858593          	addi	a1,a1,-2008 # 50208f40 <__FUNCTION__.1403+0x250>
    50207720:	853e                	mv	a0,a5
    50207722:	c17fe0ef          	jal	ra,50206338 <strcmp>
    50207726:	87aa                	mv	a5,a0
    50207728:	eb81                	bnez	a5,50207738 <test_shell+0x55e>
    5020772a:	fc842783          	lw	a5,-56(s0)
    5020772e:	4585                	li	a1,1
    50207730:	853e                	mv	a0,a5
    50207732:	e02ff0ef          	jal	ra,50206d34 <sys_taskset>
    50207736:	a831                	j	50207752 <test_shell+0x578>
    50207738:	fc842783          	lw	a5,-56(s0)
    5020773c:	55fd                	li	a1,-1
    5020773e:	853e                	mv	a0,a5
    50207740:	df4ff0ef          	jal	ra,50206d34 <sys_taskset>
    50207744:	a039                	j	50207752 <test_shell+0x578>
    50207746:	00002517          	auipc	a0,0x2
    5020774a:	82a50513          	addi	a0,a0,-2006 # 50208f70 <__FUNCTION__.1403+0x280>
    5020774e:	a8dfe0ef          	jal	ra,502061da <printf>
    50207752:	00001517          	auipc	a0,0x1
    50207756:	71650513          	addi	a0,a0,1814 # 50208e68 <__FUNCTION__.1403+0x178>
    5020775a:	a81fe0ef          	jal	ra,502061da <printf>
    5020775e:	ab0ff0ef          	jal	ra,50206a0e <sys_reflush>
    50207762:	bce5                	j	5020725a <test_shell+0x80>

0000000050207764 <test_affinity>:
    50207764:	715d                	addi	sp,sp,-80
    50207766:	e486                	sd	ra,72(sp)
    50207768:	e0a2                	sd	s0,64(sp)
    5020776a:	0880                	addi	s0,sp,80
    5020776c:	02a00513          	li	a0,42
    50207770:	9f1ff0ef          	jal	ra,50207160 <srand>
    50207774:	4585                	li	a1,1
    50207776:	4505                	li	a0,1
    50207778:	a34ff0ef          	jal	ra,502069ac <sys_move_cursor>
    5020777c:	00002517          	auipc	a0,0x2
    50207780:	80c50513          	addi	a0,a0,-2036 # 50208f88 <__FUNCTION__.1403+0x298>
    50207784:	a57fe0ef          	jal	ra,502061da <printf>
    50207788:	fe042223          	sw	zero,-28(s0)
    5020778c:	00000797          	auipc	a5,0x0
    50207790:	0da78793          	addi	a5,a5,218 # 50207866 <integer_test_task>
    50207794:	fcf43823          	sd	a5,-48(s0)
    50207798:	4789                	li	a5,2
    5020779a:	fcf42c23          	sw	a5,-40(s0)
    5020779e:	fa043c23          	sd	zero,-72(s0)
    502077a2:	fc043023          	sd	zero,-64(s0)
    502077a6:	fc042423          	sw	zero,-56(s0)
    502077aa:	4521                	li	a0,8
    502077ac:	868ff0ef          	jal	ra,50206814 <sys_sleep>
    502077b0:	fe042623          	sw	zero,-20(s0)
    502077b4:	a899                	j	5020780a <test_affinity+0xa6>
    502077b6:	fec42783          	lw	a5,-20(s0)
    502077ba:	2789                	addiw	a5,a5,2
    502077bc:	2781                	sext.w	a5,a5
    502077be:	873e                	mv	a4,a5
    502077c0:	fd040793          	addi	a5,s0,-48
    502077c4:	4605                	li	a2,1
    502077c6:	85ba                	mv	a1,a4
    502077c8:	853e                	mv	a0,a5
    502077ca:	ff3fe0ef          	jal	ra,502067bc <sys_spawn>
    502077ce:	87aa                	mv	a5,a0
    502077d0:	873e                	mv	a4,a5
    502077d2:	fec42783          	lw	a5,-20(s0)
    502077d6:	078a                	slli	a5,a5,0x2
    502077d8:	ff040693          	addi	a3,s0,-16
    502077dc:	97b6                	add	a5,a5,a3
    502077de:	fce7a423          	sw	a4,-56(a5)
    502077e2:	fec42783          	lw	a5,-20(s0)
    502077e6:	078a                	slli	a5,a5,0x2
    502077e8:	ff040713          	addi	a4,s0,-16
    502077ec:	97ba                	add	a5,a5,a4
    502077ee:	fc87a783          	lw	a5,-56(a5)
    502077f2:	85be                	mv	a1,a5
    502077f4:	00001517          	auipc	a0,0x1
    502077f8:	7bc50513          	addi	a0,a0,1980 # 50208fb0 <__FUNCTION__.1403+0x2c0>
    502077fc:	9dffe0ef          	jal	ra,502061da <printf>
    50207800:	fec42783          	lw	a5,-20(s0)
    50207804:	2785                	addiw	a5,a5,1
    50207806:	fef42623          	sw	a5,-20(s0)
    5020780a:	fec42783          	lw	a5,-20(s0)
    5020780e:	0007871b          	sext.w	a4,a5
    50207812:	4791                	li	a5,4
    50207814:	fae7d1e3          	bge	a5,a4,502077b6 <test_affinity+0x52>
    50207818:	00001517          	auipc	a0,0x1
    5020781c:	7a050513          	addi	a0,a0,1952 # 50208fb8 <__FUNCTION__.1403+0x2c8>
    50207820:	9bbfe0ef          	jal	ra,502061da <printf>
    50207824:	fe042423          	sw	zero,-24(s0)
    50207828:	a00d                	j	5020784a <test_affinity+0xe6>
    5020782a:	fe842783          	lw	a5,-24(s0)
    5020782e:	078a                	slli	a5,a5,0x2
    50207830:	ff040713          	addi	a4,s0,-16
    50207834:	97ba                	add	a5,a5,a4
    50207836:	fc87a783          	lw	a5,-56(a5)
    5020783a:	853e                	mv	a0,a5
    5020783c:	82cff0ef          	jal	ra,50206868 <sys_waitpid>
    50207840:	fe842783          	lw	a5,-24(s0)
    50207844:	2785                	addiw	a5,a5,1
    50207846:	fef42423          	sw	a5,-24(s0)
    5020784a:	fe842783          	lw	a5,-24(s0)
    5020784e:	0007871b          	sext.w	a4,a5
    50207852:	4791                	li	a5,4
    50207854:	fce7dbe3          	bge	a5,a4,5020782a <test_affinity+0xc6>
    50207858:	f9ffe0ef          	jal	ra,502067f6 <sys_exit>
    5020785c:	0001                	nop
    5020785e:	60a6                	ld	ra,72(sp)
    50207860:	6406                	ld	s0,64(sp)
    50207862:	6161                	addi	sp,sp,80
    50207864:	8082                	ret

0000000050207866 <integer_test_task>:
    50207866:	7139                	addi	sp,sp,-64
    50207868:	fc06                	sd	ra,56(sp)
    5020786a:	f822                	sd	s0,48(sp)
    5020786c:	0080                	addi	s0,sp,64
    5020786e:	87aa                	mv	a5,a0
    50207870:	fcf42623          	sw	a5,-52(s0)
    50207874:	83eff0ef          	jal	ra,502068b2 <sys_getpid>
    50207878:	87aa                	mv	a5,a0
    5020787a:	fcf42e23          	sw	a5,-36(s0)
    5020787e:	fe043423          	sd	zero,-24(s0)
    50207882:	fe042223          	sw	zero,-28(s0)
    50207886:	a0ad                	j	502078f0 <integer_test_task+0x8a>
    50207888:	fe042023          	sw	zero,-32(s0)
    5020788c:	a839                	j	502078aa <integer_test_task+0x44>
    5020788e:	8f5ff0ef          	jal	ra,50207182 <rand>
    50207892:	87aa                	mv	a5,a0
    50207894:	873e                	mv	a4,a5
    50207896:	fe843783          	ld	a5,-24(s0)
    5020789a:	97ba                	add	a5,a5,a4
    5020789c:	fef43423          	sd	a5,-24(s0)
    502078a0:	fe042783          	lw	a5,-32(s0)
    502078a4:	2785                	addiw	a5,a5,1
    502078a6:	fef42023          	sw	a5,-32(s0)
    502078aa:	fe042783          	lw	a5,-32(s0)
    502078ae:	0007871b          	sext.w	a4,a5
    502078b2:	000f47b7          	lui	a5,0xf4
    502078b6:	23f78793          	addi	a5,a5,575 # f423f <_start-0x5010cdc1>
    502078ba:	fce7dae3          	bge	a5,a4,5020788e <integer_test_task+0x28>
    502078be:	fcc42783          	lw	a5,-52(s0)
    502078c2:	85be                	mv	a1,a5
    502078c4:	4505                	li	a0,1
    502078c6:	8e6ff0ef          	jal	ra,502069ac <sys_move_cursor>
    502078ca:	fe442603          	lw	a2,-28(s0)
    502078ce:	fdc42703          	lw	a4,-36(s0)
    502078d2:	6789                	lui	a5,0x2
    502078d4:	71078693          	addi	a3,a5,1808 # 2710 <_start-0x501fe8f0>
    502078d8:	85ba                	mv	a1,a4
    502078da:	00001517          	auipc	a0,0x1
    502078de:	6e650513          	addi	a0,a0,1766 # 50208fc0 <__FUNCTION__.1403+0x2d0>
    502078e2:	8f9fe0ef          	jal	ra,502061da <printf>
    502078e6:	fe442783          	lw	a5,-28(s0)
    502078ea:	2785                	addiw	a5,a5,1
    502078ec:	fef42223          	sw	a5,-28(s0)
    502078f0:	fe442783          	lw	a5,-28(s0)
    502078f4:	0007871b          	sext.w	a4,a5
    502078f8:	6789                	lui	a5,0x2
    502078fa:	70f78793          	addi	a5,a5,1807 # 270f <_start-0x501fe8f1>
    502078fe:	f8e7d5e3          	bge	a5,a4,50207888 <integer_test_task+0x22>
    50207902:	ef5fe0ef          	jal	ra,502067f6 <sys_exit>
    50207906:	0001                	nop
    50207908:	70e2                	ld	ra,56(sp)
    5020790a:	7442                	ld	s0,48(sp)
    5020790c:	6121                	addi	sp,sp,64
    5020790e:	8082                	ret

0000000050207910 <test_barrier>:
    50207910:	7139                	addi	sp,sp,-64
    50207912:	fc06                	sd	ra,56(sp)
    50207914:	f822                	sd	s0,48(sp)
    50207916:	0080                	addi	s0,sp,64
    50207918:	c7cff0ef          	jal	ra,50206d94 <clock>
    5020791c:	87aa                	mv	a5,a0
    5020791e:	2781                	sext.w	a5,a5
    50207920:	853e                	mv	a0,a5
    50207922:	83fff0ef          	jal	ra,50207160 <srand>
    50207926:	458d                	li	a1,3
    50207928:	00004517          	auipc	a0,0x4
    5020792c:	cf050513          	addi	a0,a0,-784 # 5020b618 <barrier>
    50207930:	cc9fe0ef          	jal	ra,502065f8 <mthread_barrier_init>
    50207934:	00000797          	auipc	a5,0x0
    50207938:	0aa78793          	addi	a5,a5,170 # 502079de <barrier_task>
    5020793c:	fcf43c23          	sd	a5,-40(s0)
    50207940:	4789                	li	a5,2
    50207942:	fef42023          	sw	a5,-32(s0)
    50207946:	fe042623          	sw	zero,-20(s0)
    5020794a:	a825                	j	50207982 <test_barrier+0x72>
    5020794c:	fec42783          	lw	a5,-20(s0)
    50207950:	2785                	addiw	a5,a5,1
    50207952:	2781                	sext.w	a5,a5
    50207954:	873e                	mv	a4,a5
    50207956:	fd840793          	addi	a5,s0,-40
    5020795a:	4605                	li	a2,1
    5020795c:	85ba                	mv	a1,a4
    5020795e:	853e                	mv	a0,a5
    50207960:	e5dfe0ef          	jal	ra,502067bc <sys_spawn>
    50207964:	87aa                	mv	a5,a0
    50207966:	873e                	mv	a4,a5
    50207968:	fec42783          	lw	a5,-20(s0)
    5020796c:	078a                	slli	a5,a5,0x2
    5020796e:	ff040693          	addi	a3,s0,-16
    50207972:	97b6                	add	a5,a5,a3
    50207974:	fce7ac23          	sw	a4,-40(a5)
    50207978:	fec42783          	lw	a5,-20(s0)
    5020797c:	2785                	addiw	a5,a5,1
    5020797e:	fef42623          	sw	a5,-20(s0)
    50207982:	fec42783          	lw	a5,-20(s0)
    50207986:	0007871b          	sext.w	a4,a5
    5020798a:	4789                	li	a5,2
    5020798c:	fce7d0e3          	bge	a5,a4,5020794c <test_barrier+0x3c>
    50207990:	fe042423          	sw	zero,-24(s0)
    50207994:	a00d                	j	502079b6 <test_barrier+0xa6>
    50207996:	fe842783          	lw	a5,-24(s0)
    5020799a:	078a                	slli	a5,a5,0x2
    5020799c:	ff040713          	addi	a4,s0,-16
    502079a0:	97ba                	add	a5,a5,a4
    502079a2:	fd87a783          	lw	a5,-40(a5)
    502079a6:	853e                	mv	a0,a5
    502079a8:	ec1fe0ef          	jal	ra,50206868 <sys_waitpid>
    502079ac:	fe842783          	lw	a5,-24(s0)
    502079b0:	2785                	addiw	a5,a5,1
    502079b2:	fef42423          	sw	a5,-24(s0)
    502079b6:	fe842783          	lw	a5,-24(s0)
    502079ba:	0007871b          	sext.w	a4,a5
    502079be:	4789                	li	a5,2
    502079c0:	fce7dbe3          	bge	a5,a4,50207996 <test_barrier+0x86>
    502079c4:	00004517          	auipc	a0,0x4
    502079c8:	c5450513          	addi	a0,a0,-940 # 5020b618 <barrier>
    502079cc:	cb5fe0ef          	jal	ra,50206680 <mthread_barrier_destroy>
    502079d0:	e27fe0ef          	jal	ra,502067f6 <sys_exit>
    502079d4:	0001                	nop
    502079d6:	70e2                	ld	ra,56(sp)
    502079d8:	7442                	ld	s0,48(sp)
    502079da:	6121                	addi	sp,sp,64
    502079dc:	8082                	ret

00000000502079de <barrier_task>:
    502079de:	7179                	addi	sp,sp,-48
    502079e0:	f406                	sd	ra,40(sp)
    502079e2:	f022                	sd	s0,32(sp)
    502079e4:	1800                	addi	s0,sp,48
    502079e6:	87aa                	mv	a5,a0
    502079e8:	fcf42e23          	sw	a5,-36(s0)
    502079ec:	fe042623          	sw	zero,-20(s0)
    502079f0:	a059                	j	50207a76 <barrier_task+0x98>
    502079f2:	f90ff0ef          	jal	ra,50207182 <rand>
    502079f6:	87aa                	mv	a5,a0
    502079f8:	873e                	mv	a4,a5
    502079fa:	478d                	li	a5,3
    502079fc:	02f767bb          	remw	a5,a4,a5
    50207a00:	2781                	sext.w	a5,a5
    50207a02:	2785                	addiw	a5,a5,1
    50207a04:	fef42423          	sw	a5,-24(s0)
    50207a08:	fdc42783          	lw	a5,-36(s0)
    50207a0c:	85be                	mv	a1,a5
    50207a0e:	4505                	li	a0,1
    50207a10:	f9dfe0ef          	jal	ra,502069ac <sys_move_cursor>
    50207a14:	fec42783          	lw	a5,-20(s0)
    50207a18:	85be                	mv	a1,a5
    50207a1a:	00001517          	auipc	a0,0x1
    50207a1e:	5c650513          	addi	a0,a0,1478 # 50208fe0 <__FUNCTION__.1403+0x2f0>
    50207a22:	fb8fe0ef          	jal	ra,502061da <printf>
    50207a26:	00004517          	auipc	a0,0x4
    50207a2a:	bf250513          	addi	a0,a0,-1038 # 5020b618 <barrier>
    50207a2e:	c1ffe0ef          	jal	ra,5020664c <mthread_barrier_wait>
    50207a32:	fdc42783          	lw	a5,-36(s0)
    50207a36:	85be                	mv	a1,a5
    50207a38:	4505                	li	a0,1
    50207a3a:	f73fe0ef          	jal	ra,502069ac <sys_move_cursor>
    50207a3e:	fe842703          	lw	a4,-24(s0)
    50207a42:	fec42783          	lw	a5,-20(s0)
    50207a46:	863a                	mv	a2,a4
    50207a48:	85be                	mv	a1,a5
    50207a4a:	00001517          	auipc	a0,0x1
    50207a4e:	5c650513          	addi	a0,a0,1478 # 50209010 <__FUNCTION__.1403+0x320>
    50207a52:	f88fe0ef          	jal	ra,502061da <printf>
    50207a56:	fe842783          	lw	a5,-24(s0)
    50207a5a:	853e                	mv	a0,a5
    50207a5c:	db9fe0ef          	jal	ra,50206814 <sys_sleep>
    50207a60:	fdc42783          	lw	a5,-36(s0)
    50207a64:	85be                	mv	a1,a5
    50207a66:	4505                	li	a0,1
    50207a68:	f45fe0ef          	jal	ra,502069ac <sys_move_cursor>
    50207a6c:	fec42783          	lw	a5,-20(s0)
    50207a70:	2785                	addiw	a5,a5,1
    50207a72:	fef42623          	sw	a5,-20(s0)
    50207a76:	fec42783          	lw	a5,-20(s0)
    50207a7a:	0007871b          	sext.w	a4,a5
    50207a7e:	47a5                	li	a5,9
    50207a80:	f6e7d9e3          	bge	a5,a4,502079f2 <barrier_task+0x14>
    50207a84:	d73fe0ef          	jal	ra,502067f6 <sys_exit>
    50207a88:	0001                	nop
    50207a8a:	70a2                	ld	ra,40(sp)
    50207a8c:	7402                	ld	s0,32(sp)
    50207a8e:	6145                	addi	sp,sp,48
    50207a90:	8082                	ret

0000000050207a92 <ready_to_exit_task>:
    50207a92:	1101                	addi	sp,sp,-32
    50207a94:	ec06                	sd	ra,24(sp)
    50207a96:	e822                	sd	s0,16(sp)
    50207a98:	1000                	addi	s0,sp,32
    50207a9a:	fe042623          	sw	zero,-20(s0)
    50207a9e:	4785                	li	a5,1
    50207aa0:	fef42423          	sw	a5,-24(s0)
    50207aa4:	00006517          	auipc	a0,0x6
    50207aa8:	d5050513          	addi	a0,a0,-688 # 5020d7f4 <lock1>
    50207aac:	b05fe0ef          	jal	ra,502065b0 <mthread_mutex_lock>
    50207ab0:	00006517          	auipc	a0,0x6
    50207ab4:	d4850513          	addi	a0,a0,-696 # 5020d7f8 <lock2>
    50207ab8:	af9fe0ef          	jal	ra,502065b0 <mthread_mutex_lock>
    50207abc:	fe042623          	sw	zero,-20(s0)
    50207ac0:	a835                	j	50207afc <ready_to_exit_task+0x6a>
    50207ac2:	fe842783          	lw	a5,-24(s0)
    50207ac6:	85be                	mv	a1,a5
    50207ac8:	4505                	li	a0,1
    50207aca:	ee3fe0ef          	jal	ra,502069ac <sys_move_cursor>
    50207ace:	de5fe0ef          	jal	ra,502068b2 <sys_getpid>
    50207ad2:	87aa                	mv	a5,a0
    50207ad4:	86be                	mv	a3,a5
    50207ad6:	fec42783          	lw	a5,-20(s0)
    50207ada:	0017871b          	addiw	a4,a5,1
    50207ade:	fee42623          	sw	a4,-20(s0)
    50207ae2:	863e                	mv	a2,a5
    50207ae4:	85b6                	mv	a1,a3
    50207ae6:	00001517          	auipc	a0,0x1
    50207aea:	55a50513          	addi	a0,a0,1370 # 50209040 <__FUNCTION__.1403+0x350>
    50207aee:	eecfe0ef          	jal	ra,502061da <printf>
    50207af2:	fec42783          	lw	a5,-20(s0)
    50207af6:	2785                	addiw	a5,a5,1
    50207af8:	fef42623          	sw	a5,-20(s0)
    50207afc:	fec42783          	lw	a5,-20(s0)
    50207b00:	0007871b          	sext.w	a4,a5
    50207b04:	67e1                	lui	a5,0x18
    50207b06:	69f78793          	addi	a5,a5,1695 # 1869f <_start-0x501e8961>
    50207b0a:	fae7dce3          	bge	a5,a4,50207ac2 <ready_to_exit_task+0x30>
    50207b0e:	00006517          	auipc	a0,0x6
    50207b12:	cea50513          	addi	a0,a0,-790 # 5020d7f8 <lock2>
    50207b16:	abffe0ef          	jal	ra,502065d4 <mthread_mutex_unlock>
    50207b1a:	00006517          	auipc	a0,0x6
    50207b1e:	cda50513          	addi	a0,a0,-806 # 5020d7f4 <lock1>
    50207b22:	ab3fe0ef          	jal	ra,502065d4 <mthread_mutex_unlock>
    50207b26:	cd1fe0ef          	jal	ra,502067f6 <sys_exit>
    50207b2a:	0001                	nop
    50207b2c:	60e2                	ld	ra,24(sp)
    50207b2e:	6442                	ld	s0,16(sp)
    50207b30:	6105                	addi	sp,sp,32
    50207b32:	8082                	ret

0000000050207b34 <wait_lock_task>:
    50207b34:	7179                	addi	sp,sp,-48
    50207b36:	f406                	sd	ra,40(sp)
    50207b38:	f022                	sd	s0,32(sp)
    50207b3a:	1800                	addi	s0,sp,48
    50207b3c:	fca43c23          	sd	a0,-40(s0)
    50207b40:	4789                	li	a5,2
    50207b42:	fef42623          	sw	a5,-20(s0)
    50207b46:	fec42783          	lw	a5,-20(s0)
    50207b4a:	85be                	mv	a1,a5
    50207b4c:	4505                	li	a0,1
    50207b4e:	e5ffe0ef          	jal	ra,502069ac <sys_move_cursor>
    50207b52:	fd843583          	ld	a1,-40(s0)
    50207b56:	00001517          	auipc	a0,0x1
    50207b5a:	53250513          	addi	a0,a0,1330 # 50209088 <__FUNCTION__.1403+0x398>
    50207b5e:	e7cfe0ef          	jal	ra,502061da <printf>
    50207b62:	00006517          	auipc	a0,0x6
    50207b66:	c9250513          	addi	a0,a0,-878 # 5020d7f4 <lock1>
    50207b6a:	a47fe0ef          	jal	ra,502065b0 <mthread_mutex_lock>
    50207b6e:	fec42783          	lw	a5,-20(s0)
    50207b72:	85be                	mv	a1,a5
    50207b74:	4505                	li	a0,1
    50207b76:	e37fe0ef          	jal	ra,502069ac <sys_move_cursor>
    50207b7a:	fd843583          	ld	a1,-40(s0)
    50207b7e:	00001517          	auipc	a0,0x1
    50207b82:	54a50513          	addi	a0,a0,1354 # 502090c8 <__FUNCTION__.1403+0x3d8>
    50207b86:	e54fe0ef          	jal	ra,502061da <printf>
    50207b8a:	00006517          	auipc	a0,0x6
    50207b8e:	c6a50513          	addi	a0,a0,-918 # 5020d7f4 <lock1>
    50207b92:	a43fe0ef          	jal	ra,502065d4 <mthread_mutex_unlock>
    50207b96:	c61fe0ef          	jal	ra,502067f6 <sys_exit>
    50207b9a:	0001                	nop
    50207b9c:	70a2                	ld	ra,40(sp)
    50207b9e:	7402                	ld	s0,32(sp)
    50207ba0:	6145                	addi	sp,sp,48
    50207ba2:	8082                	ret

0000000050207ba4 <wait_exit_task>:
    50207ba4:	7139                	addi	sp,sp,-64
    50207ba6:	fc06                	sd	ra,56(sp)
    50207ba8:	f822                	sd	s0,48(sp)
    50207baa:	0080                	addi	s0,sp,64
    50207bac:	00000797          	auipc	a5,0x0
    50207bb0:	ee678793          	addi	a5,a5,-282 # 50207a92 <ready_to_exit_task>
    50207bb4:	fcf43823          	sd	a5,-48(s0)
    50207bb8:	4789                	li	a5,2
    50207bba:	fcf42c23          	sw	a5,-40(s0)
    50207bbe:	00000797          	auipc	a5,0x0
    50207bc2:	f7678793          	addi	a5,a5,-138 # 50207b34 <wait_lock_task>
    50207bc6:	fcf43023          	sd	a5,-64(s0)
    50207bca:	4789                	li	a5,2
    50207bcc:	fcf42423          	sw	a5,-56(s0)
    50207bd0:	00006517          	auipc	a0,0x6
    50207bd4:	c2450513          	addi	a0,a0,-988 # 5020d7f4 <lock1>
    50207bd8:	9a7fe0ef          	jal	ra,5020657e <mthread_mutex_init>
    50207bdc:	00006517          	auipc	a0,0x6
    50207be0:	c1c50513          	addi	a0,a0,-996 # 5020d7f8 <lock2>
    50207be4:	99bfe0ef          	jal	ra,5020657e <mthread_mutex_init>
    50207be8:	fd040793          	addi	a5,s0,-48
    50207bec:	4605                	li	a2,1
    50207bee:	4581                	li	a1,0
    50207bf0:	853e                	mv	a0,a5
    50207bf2:	bcbfe0ef          	jal	ra,502067bc <sys_spawn>
    50207bf6:	87aa                	mv	a5,a0
    50207bf8:	fef42623          	sw	a5,-20(s0)
    50207bfc:	450d                	li	a0,3
    50207bfe:	c17fe0ef          	jal	ra,50206814 <sys_sleep>
    50207c02:	fec42783          	lw	a5,-20(s0)
    50207c06:	873e                	mv	a4,a5
    50207c08:	fc040793          	addi	a5,s0,-64
    50207c0c:	4601                	li	a2,0
    50207c0e:	85ba                	mv	a1,a4
    50207c10:	853e                	mv	a0,a5
    50207c12:	babfe0ef          	jal	ra,502067bc <sys_spawn>
    50207c16:	87aa                	mv	a5,a0
    50207c18:	fef42423          	sw	a5,-24(s0)
    50207c1c:	478d                	li	a5,3
    50207c1e:	fef42223          	sw	a5,-28(s0)
    50207c22:	fe442783          	lw	a5,-28(s0)
    50207c26:	85be                	mv	a1,a5
    50207c28:	4505                	li	a0,1
    50207c2a:	d83fe0ef          	jal	ra,502069ac <sys_move_cursor>
    50207c2e:	fec42783          	lw	a5,-20(s0)
    50207c32:	85be                	mv	a1,a5
    50207c34:	00001517          	auipc	a0,0x1
    50207c38:	4d450513          	addi	a0,a0,1236 # 50209108 <__FUNCTION__.1403+0x418>
    50207c3c:	d9efe0ef          	jal	ra,502061da <printf>
    50207c40:	fec42783          	lw	a5,-20(s0)
    50207c44:	853e                	mv	a0,a5
    50207c46:	c23fe0ef          	jal	ra,50206868 <sys_waitpid>
    50207c4a:	fe442783          	lw	a5,-28(s0)
    50207c4e:	85be                	mv	a1,a5
    50207c50:	4505                	li	a0,1
    50207c52:	d5bfe0ef          	jal	ra,502069ac <sys_move_cursor>
    50207c56:	fec42783          	lw	a5,-20(s0)
    50207c5a:	85be                	mv	a1,a5
    50207c5c:	00001517          	auipc	a0,0x1
    50207c60:	4dc50513          	addi	a0,a0,1244 # 50209138 <__FUNCTION__.1403+0x448>
    50207c64:	d76fe0ef          	jal	ra,502061da <printf>
    50207c68:	b8ffe0ef          	jal	ra,502067f6 <sys_exit>
    50207c6c:	0001                	nop
    50207c6e:	70e2                	ld	ra,56(sp)
    50207c70:	7442                	ld	s0,48(sp)
    50207c72:	6121                	addi	sp,sp,64
    50207c74:	8082                	ret

0000000050207c76 <atomic_compare_exchange>:
    50207c76:	7179                	addi	sp,sp,-48
    50207c78:	f422                	sd	s0,40(sp)
    50207c7a:	1800                	addi	s0,sp,48
    50207c7c:	fca43c23          	sd	a0,-40(s0)
    50207c80:	87ae                	mv	a5,a1
    50207c82:	8732                	mv	a4,a2
    50207c84:	fcf42a23          	sw	a5,-44(s0)
    50207c88:	87ba                	mv	a5,a4
    50207c8a:	fcf42823          	sw	a5,-48(s0)
    50207c8e:	fd843603          	ld	a2,-40(s0)
    50207c92:	fd442783          	lw	a5,-44(s0)
    50207c96:	fd042703          	lw	a4,-48(s0)
    50207c9a:	fd843683          	ld	a3,-40(s0)
    50207c9e:	1006252f          	lr.w	a0,(a2)
    50207ca2:	00f51763          	bne	a0,a5,50207cb0 <atomic_compare_exchange+0x3a>
    50207ca6:	1ae625af          	sc.w.rl	a1,a4,(a2)
    50207caa:	f9f5                	bnez	a1,50207c9e <atomic_compare_exchange+0x28>
    50207cac:	0330000f          	fence	rw,rw
    50207cb0:	86aa                	mv	a3,a0
    50207cb2:	fed42623          	sw	a3,-20(s0)
    50207cb6:	fec42783          	lw	a5,-20(s0)
    50207cba:	853e                	mv	a0,a5
    50207cbc:	7422                	ld	s0,40(sp)
    50207cbe:	6145                	addi	sp,sp,48
    50207cc0:	8082                	ret

0000000050207cc2 <adler32>:
    50207cc2:	7179                	addi	sp,sp,-48
    50207cc4:	f422                	sd	s0,40(sp)
    50207cc6:	1800                	addi	s0,sp,48
    50207cc8:	fca43c23          	sd	a0,-40(s0)
    50207ccc:	fcb43823          	sd	a1,-48(s0)
    50207cd0:	4785                	li	a5,1
    50207cd2:	fef42623          	sw	a5,-20(s0)
    50207cd6:	fe042423          	sw	zero,-24(s0)
    50207cda:	fe043023          	sd	zero,-32(s0)
    50207cde:	a0b1                	j	50207d2a <adler32+0x68>
    50207ce0:	fd843703          	ld	a4,-40(s0)
    50207ce4:	fe043783          	ld	a5,-32(s0)
    50207ce8:	97ba                	add	a5,a5,a4
    50207cea:	0007c783          	lbu	a5,0(a5)
    50207cee:	2781                	sext.w	a5,a5
    50207cf0:	fec42703          	lw	a4,-20(s0)
    50207cf4:	9fb9                	addw	a5,a5,a4
    50207cf6:	0007871b          	sext.w	a4,a5
    50207cfa:	67c1                	lui	a5,0x10
    50207cfc:	17c5                	addi	a5,a5,-15
    50207cfe:	02f777bb          	remuw	a5,a4,a5
    50207d02:	fef42623          	sw	a5,-20(s0)
    50207d06:	fe842703          	lw	a4,-24(s0)
    50207d0a:	fec42783          	lw	a5,-20(s0)
    50207d0e:	9fb9                	addw	a5,a5,a4
    50207d10:	0007871b          	sext.w	a4,a5
    50207d14:	67c1                	lui	a5,0x10
    50207d16:	17c5                	addi	a5,a5,-15
    50207d18:	02f777bb          	remuw	a5,a4,a5
    50207d1c:	fef42423          	sw	a5,-24(s0)
    50207d20:	fe043783          	ld	a5,-32(s0)
    50207d24:	0785                	addi	a5,a5,1
    50207d26:	fef43023          	sd	a5,-32(s0)
    50207d2a:	fe043703          	ld	a4,-32(s0)
    50207d2e:	fd043783          	ld	a5,-48(s0)
    50207d32:	faf767e3          	bltu	a4,a5,50207ce0 <adler32+0x1e>
    50207d36:	fe842783          	lw	a5,-24(s0)
    50207d3a:	0107979b          	slliw	a5,a5,0x10
    50207d3e:	0007871b          	sext.w	a4,a5
    50207d42:	fec42783          	lw	a5,-20(s0)
    50207d46:	8fd9                	or	a5,a5,a4
    50207d48:	2781                	sext.w	a5,a5
    50207d4a:	853e                	mv	a0,a5
    50207d4c:	7422                	ld	s0,40(sp)
    50207d4e:	6145                	addi	sp,sp,48
    50207d50:	8082                	ret

0000000050207d52 <clientInitReq>:
    50207d52:	7179                	addi	sp,sp,-48
    50207d54:	f422                	sd	s0,40(sp)
    50207d56:	1800                	addi	s0,sp,48
    50207d58:	fca43c23          	sd	a0,-40(s0)
    50207d5c:	87ae                	mv	a5,a1
    50207d5e:	fcf42a23          	sw	a5,-44(s0)
    50207d62:	4739                	li	a4,14
    50207d64:	fd442783          	lw	a5,-44(s0)
    50207d68:	2781                	sext.w	a5,a5
    50207d6a:	00e78463          	beq	a5,a4,50207d72 <clientInitReq+0x20>
    50207d6e:	4781                	li	a5,0
    50207d70:	a0a9                	j	50207dba <clientInitReq+0x68>
    50207d72:	fe042623          	sw	zero,-20(s0)
    50207d76:	a81d                	j	50207dac <clientInitReq+0x5a>
    50207d78:	fec42783          	lw	a5,-20(s0)
    50207d7c:	fd843703          	ld	a4,-40(s0)
    50207d80:	97ba                	add	a5,a5,a4
    50207d82:	0007c683          	lbu	a3,0(a5) # 10000 <_start-0x501f1000>
    50207d86:	00001717          	auipc	a4,0x1
    50207d8a:	3ea70713          	addi	a4,a4,1002 # 50209170 <initReq>
    50207d8e:	fec42783          	lw	a5,-20(s0)
    50207d92:	97ba                	add	a5,a5,a4
    50207d94:	0007c783          	lbu	a5,0(a5)
    50207d98:	8736                	mv	a4,a3
    50207d9a:	00f70463          	beq	a4,a5,50207da2 <clientInitReq+0x50>
    50207d9e:	4781                	li	a5,0
    50207da0:	a829                	j	50207dba <clientInitReq+0x68>
    50207da2:	fec42783          	lw	a5,-20(s0)
    50207da6:	2785                	addiw	a5,a5,1
    50207da8:	fef42623          	sw	a5,-20(s0)
    50207dac:	4739                	li	a4,14
    50207dae:	fec42783          	lw	a5,-20(s0)
    50207db2:	2781                	sext.w	a5,a5
    50207db4:	fce7c2e3          	blt	a5,a4,50207d78 <clientInitReq+0x26>
    50207db8:	4785                	li	a5,1
    50207dba:	853e                	mv	a0,a5
    50207dbc:	7422                	ld	s0,40(sp)
    50207dbe:	6145                	addi	sp,sp,48
    50207dc0:	8082                	ret

0000000050207dc2 <strServer>:
    50207dc2:	7135                	addi	sp,sp,-160
    50207dc4:	ed06                	sd	ra,152(sp)
    50207dc6:	e922                	sd	s0,144(sp)
    50207dc8:	1100                	addi	s0,sp,160
    50207dca:	4605                	li	a2,1
    50207dcc:	4581                	li	a1,0
    50207dce:	87418513          	addi	a0,gp,-1932 # 502096d4 <visit_init>
    50207dd2:	ea5ff0ef          	jal	ra,50207c76 <atomic_compare_exchange>
    50207dd6:	87aa                	mv	a5,a0
    50207dd8:	e399                	bnez	a5,50207dde <strServer+0x1c>
    50207dda:	fd3fe0ef          	jal	ra,50206dac <mbox_init>
    50207dde:	fe043423          	sd	zero,-24(s0)
    50207de2:	fe043023          	sd	zero,-32(s0)
    50207de6:	fc043c23          	sd	zero,-40(s0)
    50207dea:	4785                	li	a5,1
    50207dec:	f6f42623          	sw	a5,-148(s0)
    50207df0:	00001517          	auipc	a0,0x1
    50207df4:	39050513          	addi	a0,a0,912 # 50209180 <initReq+0x10>
    50207df8:	80eff0ef          	jal	ra,50206e06 <mbox_open>
    50207dfc:	fca43823          	sd	a0,-48(s0)
    50207e00:	00001517          	auipc	a0,0x1
    50207e04:	39850513          	addi	a0,a0,920 # 50209198 <initReq+0x28>
    50207e08:	ffffe0ef          	jal	ra,50206e06 <mbox_open>
    50207e0c:	fca43423          	sd	a0,-56(s0)
    50207e10:	4581                	li	a1,0
    50207e12:	4501                	li	a0,0
    50207e14:	b99fe0ef          	jal	ra,502069ac <sys_move_cursor>
    50207e18:	00001517          	auipc	a0,0x1
    50207e1c:	39850513          	addi	a0,a0,920 # 502091b0 <initReq+0x40>
    50207e20:	bbafe0ef          	jal	ra,502061da <printf>
    50207e24:	4505                	li	a0,1
    50207e26:	9effe0ef          	jal	ra,50206814 <sys_sleep>
    50207e2a:	f7040793          	addi	a5,s0,-144
    50207e2e:	4631                	li	a2,12
    50207e30:	85be                	mv	a1,a5
    50207e32:	fd043503          	ld	a0,-48(s0)
    50207e36:	a86ff0ef          	jal	ra,502070bc <mbox_recv>
    50207e3a:	87aa                	mv	a5,a0
    50207e3c:	873e                	mv	a4,a5
    50207e3e:	fd843783          	ld	a5,-40(s0)
    50207e42:	97ba                	add	a5,a5,a4
    50207e44:	fcf43c23          	sd	a5,-40(s0)
    50207e48:	f7042703          	lw	a4,-144(s0)
    50207e4c:	f8040793          	addi	a5,s0,-128
    50207e50:	863a                	mv	a2,a4
    50207e52:	85be                	mv	a1,a5
    50207e54:	fd043503          	ld	a0,-48(s0)
    50207e58:	a64ff0ef          	jal	ra,502070bc <mbox_recv>
    50207e5c:	87aa                	mv	a5,a0
    50207e5e:	873e                	mv	a4,a5
    50207e60:	fd843783          	ld	a5,-40(s0)
    50207e64:	97ba                	add	a5,a5,a4
    50207e66:	fcf43c23          	sd	a5,-40(s0)
    50207e6a:	f7042783          	lw	a5,-144(s0)
    50207e6e:	873e                	mv	a4,a5
    50207e70:	f8040793          	addi	a5,s0,-128
    50207e74:	85ba                	mv	a1,a4
    50207e76:	853e                	mv	a0,a5
    50207e78:	e4bff0ef          	jal	ra,50207cc2 <adler32>
    50207e7c:	87aa                	mv	a5,a0
    50207e7e:	fcf42223          	sw	a5,-60(s0)
    50207e82:	f7442703          	lw	a4,-140(s0)
    50207e86:	fc442783          	lw	a5,-60(s0)
    50207e8a:	2781                	sext.w	a5,a5
    50207e8c:	00e79b63          	bne	a5,a4,50207ea2 <strServer+0xe0>
    50207e90:	f7042783          	lw	a5,-144(s0)
    50207e94:	873e                	mv	a4,a5
    50207e96:	fe843783          	ld	a5,-24(s0)
    50207e9a:	97ba                	add	a5,a5,a4
    50207e9c:	fef43423          	sd	a5,-24(s0)
    50207ea0:	a809                	j	50207eb2 <strServer+0xf0>
    50207ea2:	f7042783          	lw	a5,-144(s0)
    50207ea6:	873e                	mv	a4,a5
    50207ea8:	fe043783          	ld	a5,-32(s0)
    50207eac:	97ba                	add	a5,a5,a4
    50207eae:	fef43023          	sd	a5,-32(s0)
    50207eb2:	4581                	li	a1,0
    50207eb4:	4501                	li	a0,0
    50207eb6:	af7fe0ef          	jal	ra,502069ac <sys_move_cursor>
    50207eba:	f7842783          	lw	a5,-136(s0)
    50207ebe:	fe043703          	ld	a4,-32(s0)
    50207ec2:	fe843683          	ld	a3,-24(s0)
    50207ec6:	fd843603          	ld	a2,-40(s0)
    50207eca:	85be                	mv	a1,a5
    50207ecc:	00001517          	auipc	a0,0x1
    50207ed0:	2fc50513          	addi	a0,a0,764 # 502091c8 <initReq+0x58>
    50207ed4:	b06fe0ef          	jal	ra,502061da <printf>
    50207ed8:	f7042703          	lw	a4,-144(s0)
    50207edc:	f8040793          	addi	a5,s0,-128
    50207ee0:	85ba                	mv	a1,a4
    50207ee2:	853e                	mv	a0,a5
    50207ee4:	e6fff0ef          	jal	ra,50207d52 <clientInitReq>
    50207ee8:	87aa                	mv	a5,a0
    50207eea:	cf99                	beqz	a5,50207f08 <strServer+0x146>
    50207eec:	f6c40793          	addi	a5,s0,-148
    50207ef0:	4611                	li	a2,4
    50207ef2:	85be                	mv	a1,a5
    50207ef4:	fc843503          	ld	a0,-56(s0)
    50207ef8:	90cff0ef          	jal	ra,50207004 <mbox_send>
    50207efc:	f6c42783          	lw	a5,-148(s0)
    50207f00:	2785                	addiw	a5,a5,1
    50207f02:	2781                	sext.w	a5,a5
    50207f04:	f6f42623          	sw	a5,-148(s0)
    50207f08:	4505                	li	a0,1
    50207f0a:	90bfe0ef          	jal	ra,50206814 <sys_sleep>
    50207f0e:	bf31                	j	50207e2a <strServer+0x68>

0000000050207f10 <clientSendMsg>:
    50207f10:	7175                	addi	sp,sp,-144
    50207f12:	e506                	sd	ra,136(sp)
    50207f14:	e122                	sd	s0,128(sp)
    50207f16:	0900                	addi	s0,sp,144
    50207f18:	f8a43423          	sd	a0,-120(s0)
    50207f1c:	f8b43023          	sd	a1,-128(s0)
    50207f20:	87b2                	mv	a5,a2
    50207f22:	f6f42e23          	sw	a5,-132(s0)
    50207f26:	f8043c23          	sd	zero,-104(s0)
    50207f2a:	fa043023          	sd	zero,-96(s0)
    50207f2e:	fa043423          	sd	zero,-88(s0)
    50207f32:	fa043823          	sd	zero,-80(s0)
    50207f36:	fa043c23          	sd	zero,-72(s0)
    50207f3a:	fc043023          	sd	zero,-64(s0)
    50207f3e:	fc043423          	sd	zero,-56(s0)
    50207f42:	fc043823          	sd	zero,-48(s0)
    50207f46:	f9840793          	addi	a5,s0,-104
    50207f4a:	fef43023          	sd	a5,-32(s0)
    50207f4e:	f9840793          	addi	a5,s0,-104
    50207f52:	07b1                	addi	a5,a5,12
    50207f54:	fcf43c23          	sd	a5,-40(s0)
    50207f58:	fe043783          	ld	a5,-32(s0)
    50207f5c:	f7c42703          	lw	a4,-132(s0)
    50207f60:	c398                	sw	a4,0(a5)
    50207f62:	f7c42783          	lw	a5,-132(s0)
    50207f66:	85be                	mv	a1,a5
    50207f68:	f8043503          	ld	a0,-128(s0)
    50207f6c:	d57ff0ef          	jal	ra,50207cc2 <adler32>
    50207f70:	87aa                	mv	a5,a0
    50207f72:	0007871b          	sext.w	a4,a5
    50207f76:	fe043783          	ld	a5,-32(s0)
    50207f7a:	c3d8                	sw	a4,4(a5)
    50207f7c:	937fe0ef          	jal	ra,502068b2 <sys_getpid>
    50207f80:	87aa                	mv	a5,a0
    50207f82:	873e                	mv	a4,a5
    50207f84:	fe043783          	ld	a5,-32(s0)
    50207f88:	c798                	sw	a4,8(a5)
    50207f8a:	fe042623          	sw	zero,-20(s0)
    50207f8e:	a025                	j	50207fb6 <clientSendMsg+0xa6>
    50207f90:	fec42783          	lw	a5,-20(s0)
    50207f94:	f8043703          	ld	a4,-128(s0)
    50207f98:	973e                	add	a4,a4,a5
    50207f9a:	fec42783          	lw	a5,-20(s0)
    50207f9e:	fd843683          	ld	a3,-40(s0)
    50207fa2:	97b6                	add	a5,a5,a3
    50207fa4:	00074703          	lbu	a4,0(a4)
    50207fa8:	00e78023          	sb	a4,0(a5)
    50207fac:	fec42783          	lw	a5,-20(s0)
    50207fb0:	2785                	addiw	a5,a5,1
    50207fb2:	fef42623          	sw	a5,-20(s0)
    50207fb6:	fec42703          	lw	a4,-20(s0)
    50207fba:	f7c42783          	lw	a5,-132(s0)
    50207fbe:	2701                	sext.w	a4,a4
    50207fc0:	2781                	sext.w	a5,a5
    50207fc2:	fcf747e3          	blt	a4,a5,50207f90 <clientSendMsg+0x80>
    50207fc6:	f7c42783          	lw	a5,-132(s0)
    50207fca:	27b1                	addiw	a5,a5,12
    50207fcc:	2781                	sext.w	a5,a5
    50207fce:	0007871b          	sext.w	a4,a5
    50207fd2:	f9840793          	addi	a5,s0,-104
    50207fd6:	863a                	mv	a2,a4
    50207fd8:	85be                	mv	a1,a5
    50207fda:	f8843503          	ld	a0,-120(s0)
    50207fde:	826ff0ef          	jal	ra,50207004 <mbox_send>
    50207fe2:	87aa                	mv	a5,a0
    50207fe4:	853e                	mv	a0,a5
    50207fe6:	60aa                	ld	ra,136(sp)
    50207fe8:	640a                	ld	s0,128(sp)
    50207fea:	6149                	addi	sp,sp,144
    50207fec:	8082                	ret

0000000050207fee <generateRandomString>:
    50207fee:	7179                	addi	sp,sp,-48
    50207ff0:	f406                	sd	ra,40(sp)
    50207ff2:	f022                	sd	s0,32(sp)
    50207ff4:	1800                	addi	s0,sp,48
    50207ff6:	fca43c23          	sd	a0,-40(s0)
    50207ffa:	87ae                	mv	a5,a1
    50207ffc:	fcf42a23          	sw	a5,-44(s0)
    50208000:	fd442783          	lw	a5,-44(s0)
    50208004:	37f9                	addiw	a5,a5,-2
    50208006:	fef42623          	sw	a5,-20(s0)
    5020800a:	fd442783          	lw	a5,-44(s0)
    5020800e:	17fd                	addi	a5,a5,-1
    50208010:	fd843703          	ld	a4,-40(s0)
    50208014:	97ba                	add	a5,a5,a4
    50208016:	00078023          	sb	zero,0(a5)
    5020801a:	a83d                	j	50208058 <generateRandomString+0x6a>
    5020801c:	966ff0ef          	jal	ra,50207182 <rand>
    50208020:	87aa                	mv	a5,a0
    50208022:	873e                	mv	a4,a5
    50208024:	81818793          	addi	a5,gp,-2024 # 50209678 <alphaSz.1319>
    50208028:	439c                	lw	a5,0(a5)
    5020802a:	02f767bb          	remw	a5,a4,a5
    5020802e:	0007871b          	sext.w	a4,a5
    50208032:	fec42783          	lw	a5,-20(s0)
    50208036:	fd843683          	ld	a3,-40(s0)
    5020803a:	97b6                	add	a5,a5,a3
    5020803c:	00001697          	auipc	a3,0x1
    50208040:	22c68693          	addi	a3,a3,556 # 50209268 <alpha.1318>
    50208044:	9736                	add	a4,a4,a3
    50208046:	00074703          	lbu	a4,0(a4)
    5020804a:	00e78023          	sb	a4,0(a5)
    5020804e:	fec42783          	lw	a5,-20(s0)
    50208052:	37fd                	addiw	a5,a5,-1
    50208054:	fef42623          	sw	a5,-20(s0)
    50208058:	fec42783          	lw	a5,-20(s0)
    5020805c:	2781                	sext.w	a5,a5
    5020805e:	fa07dfe3          	bgez	a5,5020801c <generateRandomString+0x2e>
    50208062:	0001                	nop
    50208064:	0001                	nop
    50208066:	70a2                	ld	ra,40(sp)
    50208068:	7402                	ld	s0,32(sp)
    5020806a:	6145                	addi	sp,sp,48
    5020806c:	8082                	ret

000000005020806e <strGenerator>:
    5020806e:	716d                	addi	sp,sp,-272
    50208070:	e606                	sd	ra,264(sp)
    50208072:	e222                	sd	s0,256(sp)
    50208074:	0a00                	addi	s0,sp,272
    50208076:	4605                	li	a2,1
    50208078:	4581                	li	a1,0
    5020807a:	87418513          	addi	a0,gp,-1932 # 502096d4 <visit_init>
    5020807e:	bf9ff0ef          	jal	ra,50207c76 <atomic_compare_exchange>
    50208082:	87aa                	mv	a5,a0
    50208084:	e399                	bnez	a5,5020808a <strGenerator+0x1c>
    50208086:	d27fe0ef          	jal	ra,50206dac <mbox_init>
    5020808a:	00001517          	auipc	a0,0x1
    5020808e:	0f650513          	addi	a0,a0,246 # 50209180 <initReq+0x10>
    50208092:	d75fe0ef          	jal	ra,50206e06 <mbox_open>
    50208096:	fca43c23          	sd	a0,-40(s0)
    5020809a:	00001517          	auipc	a0,0x1
    5020809e:	0fe50513          	addi	a0,a0,254 # 50209198 <initReq+0x28>
    502080a2:	d65fe0ef          	jal	ra,50206e06 <mbox_open>
    502080a6:	fca43823          	sd	a0,-48(s0)
    502080aa:	fc042623          	sw	zero,-52(s0)
    502080ae:	47b9                	li	a5,14
    502080b0:	863e                	mv	a2,a5
    502080b2:	00001597          	auipc	a1,0x1
    502080b6:	0be58593          	addi	a1,a1,190 # 50209170 <initReq>
    502080ba:	fd843503          	ld	a0,-40(s0)
    502080be:	e53ff0ef          	jal	ra,50207f10 <clientSendMsg>
    502080c2:	ee042a23          	sw	zero,-268(s0)
    502080c6:	ef440793          	addi	a5,s0,-268
    502080ca:	4611                	li	a2,4
    502080cc:	85be                	mv	a1,a5
    502080ce:	fd043503          	ld	a0,-48(s0)
    502080d2:	febfe0ef          	jal	ra,502070bc <mbox_recv>
    502080d6:	fe042623          	sw	zero,-20(s0)
    502080da:	fe043023          	sd	zero,-32(s0)
    502080de:	ef442783          	lw	a5,-268(s0)
    502080e2:	85be                	mv	a1,a5
    502080e4:	4501                	li	a0,0
    502080e6:	8c7fe0ef          	jal	ra,502069ac <sys_move_cursor>
    502080ea:	ef442783          	lw	a5,-268(s0)
    502080ee:	85be                	mv	a1,a5
    502080f0:	00001517          	auipc	a0,0x1
    502080f4:	12850513          	addi	a0,a0,296 # 50209218 <initReq+0xa8>
    502080f8:	8e2fe0ef          	jal	ra,502061da <printf>
    502080fc:	4505                	li	a0,1
    502080fe:	f16fe0ef          	jal	ra,50206814 <sys_sleep>
    50208102:	880ff0ef          	jal	ra,50207182 <rand>
    50208106:	87aa                	mv	a5,a0
    50208108:	873e                	mv	a4,a5
    5020810a:	47e9                	li	a5,26
    5020810c:	02f777b3          	remu	a5,a4,a5
    50208110:	2781                	sext.w	a5,a5
    50208112:	2785                	addiw	a5,a5,1
    50208114:	2781                	sext.w	a5,a5
    50208116:	fcf42623          	sw	a5,-52(s0)
    5020811a:	fcc42703          	lw	a4,-52(s0)
    5020811e:	ef840793          	addi	a5,s0,-264
    50208122:	85ba                	mv	a1,a4
    50208124:	853e                	mv	a0,a5
    50208126:	ec9ff0ef          	jal	ra,50207fee <generateRandomString>
    5020812a:	fcc42703          	lw	a4,-52(s0)
    5020812e:	ef840793          	addi	a5,s0,-264
    50208132:	863a                	mv	a2,a4
    50208134:	85be                	mv	a1,a5
    50208136:	fd843503          	ld	a0,-40(s0)
    5020813a:	dd7ff0ef          	jal	ra,50207f10 <clientSendMsg>
    5020813e:	87aa                	mv	a5,a0
    50208140:	873e                	mv	a4,a5
    50208142:	fec42783          	lw	a5,-20(s0)
    50208146:	9fb9                	addw	a5,a5,a4
    50208148:	fef42623          	sw	a5,-20(s0)
    5020814c:	fcc42783          	lw	a5,-52(s0)
    50208150:	fe043703          	ld	a4,-32(s0)
    50208154:	97ba                	add	a5,a5,a4
    50208156:	fef43023          	sd	a5,-32(s0)
    5020815a:	ef442783          	lw	a5,-268(s0)
    5020815e:	85be                	mv	a1,a5
    50208160:	4501                	li	a0,0
    50208162:	84bfe0ef          	jal	ra,502069ac <sys_move_cursor>
    50208166:	ef442783          	lw	a5,-268(s0)
    5020816a:	fec42703          	lw	a4,-20(s0)
    5020816e:	86ba                	mv	a3,a4
    50208170:	fe043603          	ld	a2,-32(s0)
    50208174:	85be                	mv	a1,a5
    50208176:	00001517          	auipc	a0,0x1
    5020817a:	0c250513          	addi	a0,a0,194 # 50209238 <initReq+0xc8>
    5020817e:	85cfe0ef          	jal	ra,502061da <printf>
    50208182:	4505                	li	a0,1
    50208184:	e90fe0ef          	jal	ra,50206814 <sys_sleep>
    50208188:	bfad                	j	50208102 <strGenerator+0x94>

000000005020818a <test_multicore>:
    5020818a:	7131                	addi	sp,sp,-192
    5020818c:	fd06                	sd	ra,184(sp)
    5020818e:	f922                	sd	s0,176(sp)
    50208190:	0180                	addi	s0,sp,192
    50208192:	4585                	li	a1,1
    50208194:	4505                	li	a0,1
    50208196:	817fe0ef          	jal	ra,502069ac <sys_move_cursor>
    5020819a:	00001517          	auipc	a0,0x1
    5020819e:	12650513          	addi	a0,a0,294 # 502092c0 <alpha.1318+0x58>
    502081a2:	838fe0ef          	jal	ra,502061da <printf>
    502081a6:	fa042623          	sw	zero,-84(s0)
    502081aa:	00000797          	auipc	a5,0x0
    502081ae:	26878793          	addi	a5,a5,616 # 50208412 <add_task>
    502081b2:	f8f43c23          	sd	a5,-104(s0)
    502081b6:	4789                	li	a5,2
    502081b8:	faf42023          	sw	a5,-96(s0)
    502081bc:	4785                	li	a5,1
    502081be:	f8f42023          	sw	a5,-128(s0)
    502081c2:	f8042223          	sw	zero,-124(s0)
    502081c6:	004c57b7          	lui	a5,0x4c5
    502081ca:	b4078793          	addi	a5,a5,-1216 # 4c4b40 <_start-0x4fd3c4c0>
    502081ce:	f8f42423          	sw	a5,-120(s0)
    502081d2:	fac40793          	addi	a5,s0,-84
    502081d6:	f8f43823          	sd	a5,-112(s0)
    502081da:	bbbfe0ef          	jal	ra,50206d94 <clock>
    502081de:	fca43823          	sd	a0,-48(s0)
    502081e2:	f8040713          	addi	a4,s0,-128
    502081e6:	f9840793          	addi	a5,s0,-104
    502081ea:	4605                	li	a2,1
    502081ec:	85ba                	mv	a1,a4
    502081ee:	853e                	mv	a0,a5
    502081f0:	dccfe0ef          	jal	ra,502067bc <sys_spawn>
    502081f4:	87aa                	mv	a5,a0
    502081f6:	fcf42623          	sw	a5,-52(s0)
    502081fa:	fcc42783          	lw	a5,-52(s0)
    502081fe:	853e                	mv	a0,a5
    50208200:	e68fe0ef          	jal	ra,50206868 <sys_waitpid>
    50208204:	b91fe0ef          	jal	ra,50206d94 <clock>
    50208208:	fca43023          	sd	a0,-64(s0)
    5020820c:	4599                	li	a1,6
    5020820e:	4505                	li	a0,1
    50208210:	f9cfe0ef          	jal	ra,502069ac <sys_move_cursor>
    50208214:	fc043703          	ld	a4,-64(s0)
    50208218:	fd043783          	ld	a5,-48(s0)
    5020821c:	40f707b3          	sub	a5,a4,a5
    50208220:	fac42703          	lw	a4,-84(s0)
    50208224:	863a                	mv	a2,a4
    50208226:	85be                	mv	a1,a5
    50208228:	00001517          	auipc	a0,0x1
    5020822c:	0c050513          	addi	a0,a0,192 # 502092e8 <alpha.1318+0x80>
    50208230:	fabfd0ef          	jal	ra,502061da <printf>
    50208234:	f4043023          	sd	zero,-192(s0)
    50208238:	fe042623          	sw	zero,-20(s0)
    5020823c:	a06d                	j	502082e6 <test_multicore+0x15c>
    5020823e:	fec42783          	lw	a5,-20(s0)
    50208242:	2785                	addiw	a5,a5,1
    50208244:	0007869b          	sext.w	a3,a5
    50208248:	fec42703          	lw	a4,-20(s0)
    5020824c:	87ba                	mv	a5,a4
    5020824e:	0786                	slli	a5,a5,0x1
    50208250:	97ba                	add	a5,a5,a4
    50208252:	078e                	slli	a5,a5,0x3
    50208254:	ff040713          	addi	a4,s0,-16
    50208258:	97ba                	add	a5,a5,a4
    5020825a:	f6d7a023          	sw	a3,-160(a5)
    5020825e:	fec42703          	lw	a4,-20(s0)
    50208262:	002627b7          	lui	a5,0x262
    50208266:	5a07879b          	addiw	a5,a5,1440
    5020826a:	02f707bb          	mulw	a5,a4,a5
    5020826e:	0007869b          	sext.w	a3,a5
    50208272:	fec42703          	lw	a4,-20(s0)
    50208276:	87ba                	mv	a5,a4
    50208278:	0786                	slli	a5,a5,0x1
    5020827a:	97ba                	add	a5,a5,a4
    5020827c:	078e                	slli	a5,a5,0x3
    5020827e:	ff040713          	addi	a4,s0,-16
    50208282:	97ba                	add	a5,a5,a4
    50208284:	f6d7a223          	sw	a3,-156(a5) # 261f64 <_start-0x4ff9f09c>
    50208288:	fec42783          	lw	a5,-20(s0)
    5020828c:	2785                	addiw	a5,a5,1
    5020828e:	0007871b          	sext.w	a4,a5
    50208292:	002627b7          	lui	a5,0x262
    50208296:	5a07879b          	addiw	a5,a5,1440
    5020829a:	02f707bb          	mulw	a5,a4,a5
    5020829e:	0007869b          	sext.w	a3,a5
    502082a2:	fec42703          	lw	a4,-20(s0)
    502082a6:	87ba                	mv	a5,a4
    502082a8:	0786                	slli	a5,a5,0x1
    502082aa:	97ba                	add	a5,a5,a4
    502082ac:	078e                	slli	a5,a5,0x3
    502082ae:	ff040713          	addi	a4,s0,-16
    502082b2:	97ba                	add	a5,a5,a4
    502082b4:	f6d7a423          	sw	a3,-152(a5) # 261f68 <_start-0x4ff9f098>
    502082b8:	f4040713          	addi	a4,s0,-192
    502082bc:	fec42783          	lw	a5,-20(s0)
    502082c0:	078a                	slli	a5,a5,0x2
    502082c2:	00f706b3          	add	a3,a4,a5
    502082c6:	fec42703          	lw	a4,-20(s0)
    502082ca:	87ba                	mv	a5,a4
    502082cc:	0786                	slli	a5,a5,0x1
    502082ce:	97ba                	add	a5,a5,a4
    502082d0:	078e                	slli	a5,a5,0x3
    502082d2:	ff040713          	addi	a4,s0,-16
    502082d6:	97ba                	add	a5,a5,a4
    502082d8:	f6d7b823          	sd	a3,-144(a5)
    502082dc:	fec42783          	lw	a5,-20(s0)
    502082e0:	2785                	addiw	a5,a5,1
    502082e2:	fef42623          	sw	a5,-20(s0)
    502082e6:	fec42783          	lw	a5,-20(s0)
    502082ea:	0007871b          	sext.w	a4,a5
    502082ee:	4785                	li	a5,1
    502082f0:	f4e7d7e3          	bge	a5,a4,5020823e <test_multicore+0xb4>
    502082f4:	aa1fe0ef          	jal	ra,50206d94 <clock>
    502082f8:	faa43c23          	sd	a0,-72(s0)
    502082fc:	fe042423          	sw	zero,-24(s0)
    50208300:	a089                	j	50208342 <test_multicore+0x1b8>
    50208302:	f5040693          	addi	a3,s0,-176
    50208306:	fe842703          	lw	a4,-24(s0)
    5020830a:	87ba                	mv	a5,a4
    5020830c:	0786                	slli	a5,a5,0x1
    5020830e:	97ba                	add	a5,a5,a4
    50208310:	078e                	slli	a5,a5,0x3
    50208312:	00f68733          	add	a4,a3,a5
    50208316:	f9840793          	addi	a5,s0,-104
    5020831a:	4605                	li	a2,1
    5020831c:	85ba                	mv	a1,a4
    5020831e:	853e                	mv	a0,a5
    50208320:	c9cfe0ef          	jal	ra,502067bc <sys_spawn>
    50208324:	87aa                	mv	a5,a0
    50208326:	873e                	mv	a4,a5
    50208328:	fe842783          	lw	a5,-24(s0)
    5020832c:	078a                	slli	a5,a5,0x2
    5020832e:	ff040693          	addi	a3,s0,-16
    50208332:	97b6                	add	a5,a5,a3
    50208334:	f4e7ac23          	sw	a4,-168(a5)
    50208338:	fe842783          	lw	a5,-24(s0)
    5020833c:	2785                	addiw	a5,a5,1
    5020833e:	fef42423          	sw	a5,-24(s0)
    50208342:	fe842783          	lw	a5,-24(s0)
    50208346:	0007871b          	sext.w	a4,a5
    5020834a:	4785                	li	a5,1
    5020834c:	fae7dbe3          	bge	a5,a4,50208302 <test_multicore+0x178>
    50208350:	fe042223          	sw	zero,-28(s0)
    50208354:	a00d                	j	50208376 <test_multicore+0x1ec>
    50208356:	fe442783          	lw	a5,-28(s0)
    5020835a:	078a                	slli	a5,a5,0x2
    5020835c:	ff040713          	addi	a4,s0,-16
    50208360:	97ba                	add	a5,a5,a4
    50208362:	f587a783          	lw	a5,-168(a5)
    50208366:	853e                	mv	a0,a5
    50208368:	d00fe0ef          	jal	ra,50206868 <sys_waitpid>
    5020836c:	fe442783          	lw	a5,-28(s0)
    50208370:	2785                	addiw	a5,a5,1
    50208372:	fef42223          	sw	a5,-28(s0)
    50208376:	fe442783          	lw	a5,-28(s0)
    5020837a:	0007871b          	sext.w	a4,a5
    5020837e:	4785                	li	a5,1
    50208380:	fce7dbe3          	bge	a5,a4,50208356 <test_multicore+0x1cc>
    50208384:	fe042023          	sw	zero,-32(s0)
    50208388:	fc042e23          	sw	zero,-36(s0)
    5020838c:	a82d                	j	502083c6 <test_multicore+0x23c>
    5020838e:	fdc42783          	lw	a5,-36(s0)
    50208392:	078a                	slli	a5,a5,0x2
    50208394:	ff040713          	addi	a4,s0,-16
    50208398:	97ba                	add	a5,a5,a4
    5020839a:	f507a783          	lw	a5,-176(a5)
    5020839e:	fe042703          	lw	a4,-32(s0)
    502083a2:	9fb9                	addw	a5,a5,a4
    502083a4:	fef42023          	sw	a5,-32(s0)
    502083a8:	fe042703          	lw	a4,-32(s0)
    502083ac:	000f47b7          	lui	a5,0xf4
    502083b0:	2477879b          	addiw	a5,a5,583
    502083b4:	02f767bb          	remw	a5,a4,a5
    502083b8:	fef42023          	sw	a5,-32(s0)
    502083bc:	fdc42783          	lw	a5,-36(s0)
    502083c0:	2785                	addiw	a5,a5,1
    502083c2:	fcf42e23          	sw	a5,-36(s0)
    502083c6:	fdc42783          	lw	a5,-36(s0)
    502083ca:	0007871b          	sext.w	a4,a5
    502083ce:	4785                	li	a5,1
    502083d0:	fae7dfe3          	bge	a5,a4,5020838e <test_multicore+0x204>
    502083d4:	9c1fe0ef          	jal	ra,50206d94 <clock>
    502083d8:	faa43823          	sd	a0,-80(s0)
    502083dc:	459d                	li	a1,7
    502083de:	4505                	li	a0,1
    502083e0:	dccfe0ef          	jal	ra,502069ac <sys_move_cursor>
    502083e4:	fb043703          	ld	a4,-80(s0)
    502083e8:	fb843783          	ld	a5,-72(s0)
    502083ec:	40f707b3          	sub	a5,a4,a5
    502083f0:	fe042703          	lw	a4,-32(s0)
    502083f4:	863a                	mv	a2,a4
    502083f6:	85be                	mv	a1,a5
    502083f8:	00001517          	auipc	a0,0x1
    502083fc:	f2850513          	addi	a0,a0,-216 # 50209320 <alpha.1318+0xb8>
    50208400:	ddbfd0ef          	jal	ra,502061da <printf>
    50208404:	bf2fe0ef          	jal	ra,502067f6 <sys_exit>
    50208408:	0001                	nop
    5020840a:	70ea                	ld	ra,184(sp)
    5020840c:	744a                	ld	s0,176(sp)
    5020840e:	6129                	addi	sp,sp,192
    50208410:	8082                	ret

0000000050208412 <add_task>:
    50208412:	7139                	addi	sp,sp,-64
    50208414:	fc06                	sd	ra,56(sp)
    50208416:	f822                	sd	s0,48(sp)
    50208418:	0080                	addi	s0,sp,64
    5020841a:	fca43423          	sd	a0,-56(s0)
    5020841e:	fc843783          	ld	a5,-56(s0)
    50208422:	439c                	lw	a5,0(a5)
    50208424:	fef42223          	sw	a5,-28(s0)
    50208428:	fc843783          	ld	a5,-56(s0)
    5020842c:	43dc                	lw	a5,4(a5)
    5020842e:	fef42023          	sw	a5,-32(s0)
    50208432:	fc843783          	ld	a5,-56(s0)
    50208436:	479c                	lw	a5,8(a5)
    50208438:	fcf42e23          	sw	a5,-36(s0)
    5020843c:	fe042623          	sw	zero,-20(s0)
    50208440:	fe442783          	lw	a5,-28(s0)
    50208444:	85be                	mv	a1,a5
    50208446:	4505                	li	a0,1
    50208448:	d64fe0ef          	jal	ra,502069ac <sys_move_cursor>
    5020844c:	fdc42703          	lw	a4,-36(s0)
    50208450:	fe042783          	lw	a5,-32(s0)
    50208454:	863a                	mv	a2,a4
    50208456:	85be                	mv	a1,a5
    50208458:	00001517          	auipc	a0,0x1
    5020845c:	f0050513          	addi	a0,a0,-256 # 50209358 <alpha.1318+0xf0>
    50208460:	d7bfd0ef          	jal	ra,502061da <printf>
    50208464:	fe042783          	lw	a5,-32(s0)
    50208468:	fef42423          	sw	a5,-24(s0)
    5020846c:	a02d                	j	50208496 <add_task+0x84>
    5020846e:	fec42703          	lw	a4,-20(s0)
    50208472:	fe842783          	lw	a5,-24(s0)
    50208476:	9fb9                	addw	a5,a5,a4
    50208478:	2781                	sext.w	a5,a5
    5020847a:	873e                	mv	a4,a5
    5020847c:	000f47b7          	lui	a5,0xf4
    50208480:	2477879b          	addiw	a5,a5,583
    50208484:	02f767bb          	remw	a5,a4,a5
    50208488:	fef42623          	sw	a5,-20(s0)
    5020848c:	fe842783          	lw	a5,-24(s0)
    50208490:	2785                	addiw	a5,a5,1
    50208492:	fef42423          	sw	a5,-24(s0)
    50208496:	fe842703          	lw	a4,-24(s0)
    5020849a:	fdc42783          	lw	a5,-36(s0)
    5020849e:	2701                	sext.w	a4,a4
    502084a0:	2781                	sext.w	a5,a5
    502084a2:	fcf746e3          	blt	a4,a5,5020846e <add_task+0x5c>
    502084a6:	00001517          	auipc	a0,0x1
    502084aa:	eda50513          	addi	a0,a0,-294 # 50209380 <alpha.1318+0x118>
    502084ae:	d2dfd0ef          	jal	ra,502061da <printf>
    502084b2:	fc843783          	ld	a5,-56(s0)
    502084b6:	6b9c                	ld	a5,16(a5)
    502084b8:	fec42703          	lw	a4,-20(s0)
    502084bc:	c398                	sw	a4,0(a5)
    502084be:	b38fe0ef          	jal	ra,502067f6 <sys_exit>
    502084c2:	0001                	nop
    502084c4:	70e2                	ld	ra,56(sp)
    502084c6:	7442                	ld	s0,48(sp)
    502084c8:	6121                	addi	sp,sp,64
    502084ca:	8082                	ret

00000000502084cc <semaphore_add_task1>:
    502084cc:	715d                	addi	sp,sp,-80
    502084ce:	e486                	sd	ra,72(sp)
    502084d0:	e0a2                	sd	s0,64(sp)
    502084d2:	0880                	addi	s0,sp,80
    502084d4:	4785                	li	a5,1
    502084d6:	fef42223          	sw	a5,-28(s0)
    502084da:	4585                	li	a1,1
    502084dc:	00003517          	auipc	a0,0x3
    502084e0:	14450513          	addi	a0,a0,324 # 5020b620 <semaphore>
    502084e4:	9dcfe0ef          	jal	ra,502066c0 <mthread_semaphore_init>
    502084e8:	00000797          	auipc	a5,0x0
    502084ec:	11e78793          	addi	a5,a5,286 # 50208606 <semaphore_add_task2>
    502084f0:	fcf43823          	sd	a5,-48(s0)
    502084f4:	4789                	li	a5,2
    502084f6:	fcf42c23          	sw	a5,-40(s0)
    502084fa:	00000797          	auipc	a5,0x0
    502084fe:	1ac78793          	addi	a5,a5,428 # 502086a6 <semaphore_add_task3>
    50208502:	fcf43023          	sd	a5,-64(s0)
    50208506:	4789                	li	a5,2
    50208508:	fcf42423          	sw	a5,-56(s0)
    5020850c:	fd040793          	addi	a5,s0,-48
    50208510:	4601                	li	a2,0
    50208512:	4581                	li	a1,0
    50208514:	853e                	mv	a0,a5
    50208516:	aa6fe0ef          	jal	ra,502067bc <sys_spawn>
    5020851a:	87aa                	mv	a5,a0
    5020851c:	faf42c23          	sw	a5,-72(s0)
    50208520:	fc040793          	addi	a5,s0,-64
    50208524:	4601                	li	a2,0
    50208526:	4581                	li	a1,0
    50208528:	853e                	mv	a0,a5
    5020852a:	a92fe0ef          	jal	ra,502067bc <sys_spawn>
    5020852e:	87aa                	mv	a5,a0
    50208530:	faf42e23          	sw	a5,-68(s0)
    50208534:	fe042623          	sw	zero,-20(s0)
    50208538:	a88d                	j	502085aa <semaphore_add_task1+0xde>
    5020853a:	00003517          	auipc	a0,0x3
    5020853e:	0e650513          	addi	a0,a0,230 # 5020b620 <semaphore>
    50208542:	a06fe0ef          	jal	ra,50206748 <mthread_semaphore_down>
    50208546:	00003797          	auipc	a5,0x3
    5020854a:	0e278793          	addi	a5,a5,226 # 5020b628 <global_count>
    5020854e:	439c                	lw	a5,0(a5)
    50208550:	2785                	addiw	a5,a5,1
    50208552:	0007871b          	sext.w	a4,a5
    50208556:	00003797          	auipc	a5,0x3
    5020855a:	0d278793          	addi	a5,a5,210 # 5020b628 <global_count>
    5020855e:	c398                	sw	a4,0(a5)
    50208560:	00003517          	auipc	a0,0x3
    50208564:	0c050513          	addi	a0,a0,192 # 5020b620 <semaphore>
    50208568:	9acfe0ef          	jal	ra,50206714 <mthread_semaphore_up>
    5020856c:	fe442783          	lw	a5,-28(s0)
    50208570:	85be                	mv	a1,a5
    50208572:	4505                	li	a0,1
    50208574:	c38fe0ef          	jal	ra,502069ac <sys_move_cursor>
    50208578:	00003797          	auipc	a5,0x3
    5020857c:	0b078793          	addi	a5,a5,176 # 5020b628 <global_count>
    50208580:	4398                	lw	a4,0(a5)
    50208582:	fec42783          	lw	a5,-20(s0)
    50208586:	2785                	addiw	a5,a5,1
    50208588:	2781                	sext.w	a5,a5
    5020858a:	863e                	mv	a2,a5
    5020858c:	85ba                	mv	a1,a4
    5020858e:	00001517          	auipc	a0,0x1
    50208592:	dfa50513          	addi	a0,a0,-518 # 50209388 <alpha.1318+0x120>
    50208596:	c45fd0ef          	jal	ra,502061da <printf>
    5020859a:	4505                	li	a0,1
    5020859c:	a78fe0ef          	jal	ra,50206814 <sys_sleep>
    502085a0:	fec42783          	lw	a5,-20(s0)
    502085a4:	2785                	addiw	a5,a5,1
    502085a6:	fef42623          	sw	a5,-20(s0)
    502085aa:	fec42783          	lw	a5,-20(s0)
    502085ae:	0007871b          	sext.w	a4,a5
    502085b2:	47a5                	li	a5,9
    502085b4:	f8e7d3e3          	bge	a5,a4,5020853a <semaphore_add_task1+0x6e>
    502085b8:	fe042423          	sw	zero,-24(s0)
    502085bc:	a00d                	j	502085de <semaphore_add_task1+0x112>
    502085be:	fe842783          	lw	a5,-24(s0)
    502085c2:	078a                	slli	a5,a5,0x2
    502085c4:	ff040713          	addi	a4,s0,-16
    502085c8:	97ba                	add	a5,a5,a4
    502085ca:	fc87a783          	lw	a5,-56(a5)
    502085ce:	853e                	mv	a0,a5
    502085d0:	a98fe0ef          	jal	ra,50206868 <sys_waitpid>
    502085d4:	fe842783          	lw	a5,-24(s0)
    502085d8:	2785                	addiw	a5,a5,1
    502085da:	fef42423          	sw	a5,-24(s0)
    502085de:	fe842783          	lw	a5,-24(s0)
    502085e2:	0007871b          	sext.w	a4,a5
    502085e6:	4785                	li	a5,1
    502085e8:	fce7dbe3          	bge	a5,a4,502085be <semaphore_add_task1+0xf2>
    502085ec:	00003517          	auipc	a0,0x3
    502085f0:	03450513          	addi	a0,a0,52 # 5020b620 <semaphore>
    502085f4:	988fe0ef          	jal	ra,5020677c <mthread_semaphore_destroy>
    502085f8:	9fefe0ef          	jal	ra,502067f6 <sys_exit>
    502085fc:	0001                	nop
    502085fe:	60a6                	ld	ra,72(sp)
    50208600:	6406                	ld	s0,64(sp)
    50208602:	6161                	addi	sp,sp,80
    50208604:	8082                	ret

0000000050208606 <semaphore_add_task2>:
    50208606:	1101                	addi	sp,sp,-32
    50208608:	ec06                	sd	ra,24(sp)
    5020860a:	e822                	sd	s0,16(sp)
    5020860c:	1000                	addi	s0,sp,32
    5020860e:	4789                	li	a5,2
    50208610:	fef42423          	sw	a5,-24(s0)
    50208614:	fe042623          	sw	zero,-20(s0)
    50208618:	a88d                	j	5020868a <semaphore_add_task2+0x84>
    5020861a:	00003517          	auipc	a0,0x3
    5020861e:	00650513          	addi	a0,a0,6 # 5020b620 <semaphore>
    50208622:	926fe0ef          	jal	ra,50206748 <mthread_semaphore_down>
    50208626:	00003797          	auipc	a5,0x3
    5020862a:	00278793          	addi	a5,a5,2 # 5020b628 <global_count>
    5020862e:	439c                	lw	a5,0(a5)
    50208630:	2785                	addiw	a5,a5,1
    50208632:	0007871b          	sext.w	a4,a5
    50208636:	00003797          	auipc	a5,0x3
    5020863a:	ff278793          	addi	a5,a5,-14 # 5020b628 <global_count>
    5020863e:	c398                	sw	a4,0(a5)
    50208640:	00003517          	auipc	a0,0x3
    50208644:	fe050513          	addi	a0,a0,-32 # 5020b620 <semaphore>
    50208648:	8ccfe0ef          	jal	ra,50206714 <mthread_semaphore_up>
    5020864c:	fe842783          	lw	a5,-24(s0)
    50208650:	85be                	mv	a1,a5
    50208652:	4505                	li	a0,1
    50208654:	b58fe0ef          	jal	ra,502069ac <sys_move_cursor>
    50208658:	00003797          	auipc	a5,0x3
    5020865c:	fd078793          	addi	a5,a5,-48 # 5020b628 <global_count>
    50208660:	4398                	lw	a4,0(a5)
    50208662:	fec42783          	lw	a5,-20(s0)
    50208666:	2785                	addiw	a5,a5,1
    50208668:	2781                	sext.w	a5,a5
    5020866a:	863e                	mv	a2,a5
    5020866c:	85ba                	mv	a1,a4
    5020866e:	00001517          	auipc	a0,0x1
    50208672:	d1a50513          	addi	a0,a0,-742 # 50209388 <alpha.1318+0x120>
    50208676:	b65fd0ef          	jal	ra,502061da <printf>
    5020867a:	4505                	li	a0,1
    5020867c:	998fe0ef          	jal	ra,50206814 <sys_sleep>
    50208680:	fec42783          	lw	a5,-20(s0)
    50208684:	2785                	addiw	a5,a5,1
    50208686:	fef42623          	sw	a5,-20(s0)
    5020868a:	fec42783          	lw	a5,-20(s0)
    5020868e:	0007871b          	sext.w	a4,a5
    50208692:	47cd                	li	a5,19
    50208694:	f8e7d3e3          	bge	a5,a4,5020861a <semaphore_add_task2+0x14>
    50208698:	95efe0ef          	jal	ra,502067f6 <sys_exit>
    5020869c:	0001                	nop
    5020869e:	60e2                	ld	ra,24(sp)
    502086a0:	6442                	ld	s0,16(sp)
    502086a2:	6105                	addi	sp,sp,32
    502086a4:	8082                	ret

00000000502086a6 <semaphore_add_task3>:
    502086a6:	1101                	addi	sp,sp,-32
    502086a8:	ec06                	sd	ra,24(sp)
    502086aa:	e822                	sd	s0,16(sp)
    502086ac:	1000                	addi	s0,sp,32
    502086ae:	478d                	li	a5,3
    502086b0:	fef42423          	sw	a5,-24(s0)
    502086b4:	fe042623          	sw	zero,-20(s0)
    502086b8:	a88d                	j	5020872a <semaphore_add_task3+0x84>
    502086ba:	00003517          	auipc	a0,0x3
    502086be:	f6650513          	addi	a0,a0,-154 # 5020b620 <semaphore>
    502086c2:	886fe0ef          	jal	ra,50206748 <mthread_semaphore_down>
    502086c6:	00003797          	auipc	a5,0x3
    502086ca:	f6278793          	addi	a5,a5,-158 # 5020b628 <global_count>
    502086ce:	439c                	lw	a5,0(a5)
    502086d0:	2785                	addiw	a5,a5,1
    502086d2:	0007871b          	sext.w	a4,a5
    502086d6:	00003797          	auipc	a5,0x3
    502086da:	f5278793          	addi	a5,a5,-174 # 5020b628 <global_count>
    502086de:	c398                	sw	a4,0(a5)
    502086e0:	00003517          	auipc	a0,0x3
    502086e4:	f4050513          	addi	a0,a0,-192 # 5020b620 <semaphore>
    502086e8:	82cfe0ef          	jal	ra,50206714 <mthread_semaphore_up>
    502086ec:	fe842783          	lw	a5,-24(s0)
    502086f0:	85be                	mv	a1,a5
    502086f2:	4505                	li	a0,1
    502086f4:	ab8fe0ef          	jal	ra,502069ac <sys_move_cursor>
    502086f8:	00003797          	auipc	a5,0x3
    502086fc:	f3078793          	addi	a5,a5,-208 # 5020b628 <global_count>
    50208700:	4398                	lw	a4,0(a5)
    50208702:	fec42783          	lw	a5,-20(s0)
    50208706:	2785                	addiw	a5,a5,1
    50208708:	2781                	sext.w	a5,a5
    5020870a:	863e                	mv	a2,a5
    5020870c:	85ba                	mv	a1,a4
    5020870e:	00001517          	auipc	a0,0x1
    50208712:	c7a50513          	addi	a0,a0,-902 # 50209388 <alpha.1318+0x120>
    50208716:	ac5fd0ef          	jal	ra,502061da <printf>
    5020871a:	4505                	li	a0,1
    5020871c:	8f8fe0ef          	jal	ra,50206814 <sys_sleep>
    50208720:	fec42783          	lw	a5,-20(s0)
    50208724:	2785                	addiw	a5,a5,1
    50208726:	fef42623          	sw	a5,-20(s0)
    5020872a:	fec42783          	lw	a5,-20(s0)
    5020872e:	0007871b          	sext.w	a4,a5
    50208732:	47f5                	li	a5,29
    50208734:	f8e7d3e3          	bge	a5,a4,502086ba <semaphore_add_task3+0x14>
    50208738:	8befe0ef          	jal	ra,502067f6 <sys_exit>
    5020873c:	0001                	nop
    5020873e:	60e2                	ld	ra,24(sp)
    50208740:	6442                	ld	s0,16(sp)
    50208742:	6105                	addi	sp,sp,32
    50208744:	8082                	ret

0000000050208746 <waiting_task1>:
    50208746:	1101                	addi	sp,sp,-32
    50208748:	ec06                	sd	ra,24(sp)
    5020874a:	e822                	sd	s0,16(sp)
    5020874c:	1000                	addi	s0,sp,32
    5020874e:	4785                	li	a5,1
    50208750:	fef42623          	sw	a5,-20(s0)
    50208754:	fec42783          	lw	a5,-20(s0)
    50208758:	85be                	mv	a1,a5
    5020875a:	4505                	li	a0,1
    5020875c:	a50fe0ef          	jal	ra,502069ac <sys_move_cursor>
    50208760:	fec42783          	lw	a5,-20(s0)
    50208764:	85be                	mv	a1,a5
    50208766:	00001517          	auipc	a0,0x1
    5020876a:	c4a50513          	addi	a0,a0,-950 # 502093b0 <alpha.1318+0x148>
    5020876e:	a6dfd0ef          	jal	ra,502061da <printf>
    50208772:	450d                	li	a0,3
    50208774:	8f4fe0ef          	jal	ra,50206868 <sys_waitpid>
    50208778:	fec42783          	lw	a5,-20(s0)
    5020877c:	85be                	mv	a1,a5
    5020877e:	4505                	li	a0,1
    50208780:	a2cfe0ef          	jal	ra,502069ac <sys_move_cursor>
    50208784:	00001517          	auipc	a0,0x1
    50208788:	c5c50513          	addi	a0,a0,-932 # 502093e0 <alpha.1318+0x178>
    5020878c:	a4ffd0ef          	jal	ra,502061da <printf>
    50208790:	866fe0ef          	jal	ra,502067f6 <sys_exit>
    50208794:	0001                	nop
    50208796:	60e2                	ld	ra,24(sp)
    50208798:	6442                	ld	s0,16(sp)
    5020879a:	6105                	addi	sp,sp,32
    5020879c:	8082                	ret

000000005020879e <waiting_task2>:
    5020879e:	1101                	addi	sp,sp,-32
    502087a0:	ec06                	sd	ra,24(sp)
    502087a2:	e822                	sd	s0,16(sp)
    502087a4:	1000                	addi	s0,sp,32
    502087a6:	4789                	li	a5,2
    502087a8:	fef42623          	sw	a5,-20(s0)
    502087ac:	fec42783          	lw	a5,-20(s0)
    502087b0:	85be                	mv	a1,a5
    502087b2:	4505                	li	a0,1
    502087b4:	9f8fe0ef          	jal	ra,502069ac <sys_move_cursor>
    502087b8:	fec42783          	lw	a5,-20(s0)
    502087bc:	85be                	mv	a1,a5
    502087be:	00001517          	auipc	a0,0x1
    502087c2:	bf250513          	addi	a0,a0,-1038 # 502093b0 <alpha.1318+0x148>
    502087c6:	a15fd0ef          	jal	ra,502061da <printf>
    502087ca:	450d                	li	a0,3
    502087cc:	89cfe0ef          	jal	ra,50206868 <sys_waitpid>
    502087d0:	fec42783          	lw	a5,-20(s0)
    502087d4:	85be                	mv	a1,a5
    502087d6:	4505                	li	a0,1
    502087d8:	9d4fe0ef          	jal	ra,502069ac <sys_move_cursor>
    502087dc:	00001517          	auipc	a0,0x1
    502087e0:	c0450513          	addi	a0,a0,-1020 # 502093e0 <alpha.1318+0x178>
    502087e4:	9f7fd0ef          	jal	ra,502061da <printf>
    502087e8:	80efe0ef          	jal	ra,502067f6 <sys_exit>
    502087ec:	0001                	nop
    502087ee:	60e2                	ld	ra,24(sp)
    502087f0:	6442                	ld	s0,16(sp)
    502087f2:	6105                	addi	sp,sp,32
    502087f4:	8082                	ret

00000000502087f6 <waited_task>:
    502087f6:	1101                	addi	sp,sp,-32
    502087f8:	ec06                	sd	ra,24(sp)
    502087fa:	e822                	sd	s0,16(sp)
    502087fc:	1000                	addi	s0,sp,32
    502087fe:	478d                	li	a5,3
    50208800:	fef42623          	sw	a5,-20(s0)
    50208804:	fec42783          	lw	a5,-20(s0)
    50208808:	85be                	mv	a1,a5
    5020880a:	4505                	li	a0,1
    5020880c:	9a0fe0ef          	jal	ra,502069ac <sys_move_cursor>
    50208810:	00001517          	auipc	a0,0x1
    50208814:	c1050513          	addi	a0,a0,-1008 # 50209420 <alpha.1318+0x1b8>
    50208818:	9c3fd0ef          	jal	ra,502061da <printf>
    5020881c:	4515                	li	a0,5
    5020881e:	ff7fd0ef          	jal	ra,50206814 <sys_sleep>
    50208822:	fd5fd0ef          	jal	ra,502067f6 <sys_exit>
    50208826:	0001                	nop
    50208828:	60e2                	ld	ra,24(sp)
    5020882a:	6442                	ld	s0,16(sp)
    5020882c:	6105                	addi	sp,sp,32
    5020882e:	8082                	ret
