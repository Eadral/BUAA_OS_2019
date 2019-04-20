	.file	1 "pmap.c"
	.section .mdebug.abi32
	.previous
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
$LC0:
	.ascii	"Physical memory: %dK available, \000"
	.align	2
$LC1:
	.ascii	"base = %dK, extended = %dK\012\000"
	.text
	.align	2
	.globl	mips_detect_memory
	.ent	mips_detect_memory
	.type	mips_detect_memory, @function
mips_detect_memory:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-32
	sw	$31,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	li	$3,67108864			# 0x4000000
	lui	$2,%hi(maxpa)
	sw	$3,%lo(maxpa)($2)
	lui	$17,%hi(basemem)
	sw	$3,%lo(basemem)($17)
	li	$3,16384			# 0x4000
	lui	$2,%hi(npage)
	sw	$3,%lo(npage)($2)
	lui	$16,%hi(extmem)
	sw	$0,%lo(extmem)($16)
	lui	$4,%hi($LC0)
	addiu	$4,$4,%lo($LC0)
	jal	printf
	li	$5,65536			# 0x10000

	lw	$5,%lo(basemem)($17)
	lw	$6,%lo(extmem)($16)
	lui	$4,%hi($LC1)
	addiu	$4,$4,%lo($LC1)
	srl	$5,$5,10
	jal	printf
	srl	$6,$6,10

	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	j	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	mips_detect_memory
	.section	.rodata.str1.4
	.align	2
$LC2:
	.ascii	"pmap.c\000"
	.align	2
$LC3:
	.ascii	"PADDR called with invalid kva %08lx\000"
	.align	2
$LC4:
	.ascii	"out of memorty\012\000"
	.text
	.align	2
	.ent	alloc
	.type	alloc, @function
alloc:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-24
	sw	$31,20($sp)
	sw	$16,16($sp)
	move	$7,$4
	lui	$4,%hi(freemem)
	lw	$2,%lo(freemem)($4)
	bne	$2,$0,$L13
	addu	$2,$5,$2

	lui	$2,%hi(end)
	addiu	$2,$2,%lo(end)
	sw	$2,%lo(freemem)($4)
	lui	$4,%hi(freemem)
	lw	$2,%lo(freemem)($4)
	addu	$2,$5,$2
$L13:
	addiu	$2,$2,-1
	subu	$3,$0,$5
	and	$16,$2,$3
	addu	$2,$16,$7
	beq	$6,$0,$L6
	sw	$2,%lo(freemem)($4)

	move	$4,$16
	jal	bzero
	move	$5,$7

$L6:
	lui	$2,%hi(freemem)
	lw	$7,%lo(freemem)($2)
	bltz	$7,$L8
	li	$2,-2147483648			# 0xffffffff80000000

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,72			# 0x48
	lui	$6,%hi($LC3)
	jal	_panic
	addiu	$6,$6,%lo($LC3)

$L8:
	addu	$2,$7,$2
	lui	$3,%hi(maxpa)
	lw	$3,%lo(maxpa)($3)
	sltu	$2,$2,$3
	bne	$2,$0,$L10
	move	$2,$16

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,73			# 0x49
	lui	$6,%hi($LC4)
	jal	_panic
	addiu	$6,$6,%lo($LC4)

$L10:
	lw	$31,20($sp)
	lw	$16,16($sp)
	j	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	alloc
	.section	.rodata.str1.4
	.align	2
$LC5:
	.ascii	"KADDR called with invalid pa %08lx\000"
	.align	2
$LC6:
	.ascii	"boot_pgdir_failed\000"
	.text
	.align	2
	.ent	boot_pgdir_walk
	.type	boot_pgdir_walk, @function
boot_pgdir_walk:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-32
	sw	$31,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	srl	$2,$5,22
	sll	$2,$2,2
	addu	$16,$2,$4
	lw	$7,0($16)
	andi	$2,$7,0x200
	beq	$2,$0,$L15
	move	$17,$5

	li	$2,-4096			# 0xfffffffffffff000
	and	$7,$7,$2
	srl	$2,$7,12
	lui	$3,%hi(npage)
	lw	$3,%lo(npage)($3)
	sltu	$2,$2,$3
	bne	$2,$0,$L17
	li	$2,-2147483648			# 0xffffffff80000000

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,97			# 0x61
	lui	$6,%hi($LC5)
	jal	_panic
	addiu	$6,$6,%lo($LC5)

$L17:
	b	$L19
	addu	$7,$7,$2

$L15:
	li	$2,1			# 0x1
	bne	$6,$2,$L20
	li	$4,4096			# 0x1000

	li	$5,4096			# 0x1000
	jal	alloc
	li	$6,1			# 0x1

	bltz	$2,$L22
	move	$7,$2

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,107			# 0x6b
	lui	$6,%hi($LC3)
	jal	_panic
	addiu	$6,$6,%lo($LC3)

$L22:
	li	$2,-2147483648			# 0xffffffff80000000
	addu	$2,$7,$2
	ori	$2,$2,0x200
	b	$L19
	sw	$2,0($16)

$L20:
	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,110			# 0x6e
	lui	$6,%hi($LC6)
	jal	_panic
	addiu	$6,$6,%lo($LC6)

$L19:
	srl	$2,$17,10
	andi	$2,$2,0xffc
	addu	$2,$7,$2
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	j	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	boot_pgdir_walk
	.section	.rodata.str1.4
	.align	2
$LC7:
	.ascii	"not multiple of BY2PG\000"
	.text
	.align	2
	.globl	boot_map_segment
	.ent	boot_map_segment
	.type	boot_map_segment, @function
boot_map_segment:
	.frame	$sp,48,$31		# vars= 0, regs= 8/0, args= 16, gp= 0
	.mask	0x807f0000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-48
	sw	$31,44($sp)
	sw	$22,40($sp)
	sw	$21,36($sp)
	sw	$20,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	move	$22,$4
	move	$21,$5
	move	$17,$6
	move	$20,$7
	andi	$2,$6,0xfff
	beq	$2,$0,$L26
	lw	$19,64($sp)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,133			# 0x85
	lui	$6,%hi($LC7)
	jal	_panic
	addiu	$6,$6,%lo($LC7)

$L28:
	move	$16,$0
	move	$4,$22
$L33:
	addu	$5,$16,$21
	jal	boot_pgdir_walk
	li	$6,1			# 0x1

	addu	$3,$16,$20
	or	$3,$3,$19
	ori	$3,$3,0x200
	sw	$3,0($2)
	addiu	$16,$18,4096
	sltu	$2,$16,$17
	beq	$2,$0,$L31
	move	$18,$16

	b	$L33
	move	$4,$22

$L26:
	bne	$6,$0,$L28
	move	$18,$0

$L31:
	lw	$31,44($sp)
	lw	$22,40($sp)
	lw	$21,36($sp)
	lw	$20,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	j	$31
	addiu	$sp,$sp,48

	.set	macro
	.set	reorder
	.end	boot_map_segment
	.section	.rodata.str1.4
	.align	2
$LC8:
	.ascii	"to memory %x for struct page directory.\012\000"
	.align	2
$LC9:
	.ascii	"to memory %x for struct Pages.\012\000"
	.align	2
$LC10:
	.ascii	"pmap.c:\011 mips vm init success\012\000"
	.text
	.align	2
	.globl	mips_vm_init
	.ent	mips_vm_init
	.type	mips_vm_init, @function
mips_vm_init:
	.frame	$sp,48,$31		# vars= 0, regs= 5/0, args= 24, gp= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-48
	sw	$31,40($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	li	$4,4096			# 0x1000
	li	$5,4096			# 0x1000
	jal	alloc
	li	$6,1			# 0x1

	move	$19,$2
	lui	$18,%hi(freemem)
	lui	$4,%hi($LC8)
	addiu	$4,$4,%lo($LC8)
	jal	printf
	lw	$5,%lo(freemem)($18)

	lui	$2,%hi(mCONTEXT)
	sw	$19,%lo(mCONTEXT)($2)
	lui	$2,%hi(boot_pgdir)
	sw	$19,%lo(boot_pgdir)($2)
	lui	$17,%hi(npage)
	lw	$4,%lo(npage)($17)
	sll	$2,$4,2
	sll	$4,$4,4
	subu	$4,$4,$2
	li	$5,4096			# 0x1000
	jal	alloc
	li	$6,1			# 0x1

	lui	$16,%hi(pages)
	sw	$2,%lo(pages)($16)
	lui	$4,%hi($LC9)
	addiu	$4,$4,%lo($LC9)
	jal	printf
	lw	$5,%lo(freemem)($18)

	lw	$2,%lo(npage)($17)
	sll	$3,$2,2
	sll	$2,$2,4
	subu	$2,$2,$3
	addiu	$2,$2,4095
	li	$3,-4096			# 0xfffffffffffff000
	and	$6,$2,$3
	lw	$3,%lo(pages)($16)
	bltz	$3,$L35
	li	$2,1024			# 0x400

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,176			# 0xb0
	lui	$6,%hi($LC3)
	addiu	$6,$6,%lo($LC3)
	jal	_panic
	move	$7,$3

$L35:
	sw	$2,16($sp)
	move	$4,$19
	li	$5,2139095040			# 0x7f800000
	li	$7,-2147483648			# 0xffffffff80000000
	jal	boot_map_segment
	addu	$7,$3,$7

	li	$4,196608			# 0x30000
	ori	$4,$4,0x6000
	li	$5,4096			# 0x1000
	jal	alloc
	li	$6,1			# 0x1

	lui	$3,%hi(envs)
	sw	$2,%lo(envs)($3)
	bltz	$2,$L37
	move	$3,$2

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,182			# 0xb6
	lui	$6,%hi($LC3)
	addiu	$6,$6,%lo($LC3)
	jal	_panic
	move	$7,$2

$L37:
	li	$2,1024			# 0x400
	sw	$2,16($sp)
	move	$4,$19
	li	$5,2134900736			# 0x7f400000
	li	$6,196608			# 0x30000
	ori	$6,$6,0x6000
	li	$7,-2147483648			# 0xffffffff80000000
	jal	boot_map_segment
	addu	$7,$3,$7

	lui	$4,%hi($LC10)
	jal	printf
	addiu	$4,$4,%lo($LC10)

	lw	$31,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	j	$31
	addiu	$sp,$sp,48

	.set	macro
	.set	reorder
	.end	mips_vm_init
	.align	2
	.globl	page_init
	.ent	page_init
	.type	page_init, @function
page_init:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lui	$2,%hi(page_free_list)
	sw	$0,%lo(page_free_list)($2)
	lui	$4,%hi(freemem)
	lw	$2,%lo(freemem)($4)
	addiu	$2,$2,4095
	li	$3,-4096			# 0xfffffffffffff000
	and	$2,$2,$3
	sw	$2,%lo(freemem)($4)
	lui	$2,%hi(npage)
	lw	$2,%lo(npage)($2)
	beq	$2,$0,$L51
	move	$6,$0

	move	$5,$0
	lui	$10,%hi(pages)
	li	$9,-2147483648			# 0xffffffff80000000
	move	$8,$4
	li	$13,1
	lui	$12,%hi(page_free_list)
	addiu	$11,$12,%lo(page_free_list)
	lui	$7,%hi(npage)
$L43:
	lw	$2,%lo(pages)($10)
	addu	$4,$5,$2
	sra	$3,$5,2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$3,$2,8
	addu	$2,$2,$3
	sll	$3,$2,16
	addu	$2,$2,$3
	sll	$2,$2,12
	subu	$2,$9,$2
	lw	$3,%lo(freemem)($8)
	sltu	$2,$2,$3
	beq	$2,$0,$L44
	lui	$3,%hi(page_free_list)

	b	$L46
	sh	$13,8($4)

$L44:
	sh	$0,8($4)
	lw	$2,%lo(page_free_list)($3)
	beq	$2,$0,$L47
	sw	$2,0($4)

	lw	$2,%lo(page_free_list)($3)
	sw	$4,4($2)
$L47:
	sw	$4,%lo(page_free_list)($12)
	sw	$11,4($4)
$L46:
	addiu	$6,$6,1
	lw	$2,%lo(npage)($7)
	sltu	$2,$6,$2
	bne	$2,$0,$L43
	addiu	$5,$5,12

$L51:
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	page_init
	.section	.rodata.str1.4
	.align	2
$LC11:
	.ascii	"../include/pmap.h\000"
	.text
	.align	2
	.globl	page_alloc
	.ent	page_alloc
	.type	page_alloc, @function
page_alloc:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-32
	sw	$31,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	lui	$2,%hi(page_free_list)
	lw	$16,%lo(page_free_list)($2)
	bne	$16,$0,$L53
	move	$17,$4

	b	$L55
	li	$2,-4			# 0xfffffffffffffffc

$L53:
	lw	$3,0($16)
	beq	$3,$0,$L56
	nop

	lw	$2,4($16)
	sw	$2,4($3)
$L56:
	lw	$3,4($16)
	lw	$2,0($16)
	sw	$2,0($3)
	lui	$2,%hi(pages)
	lw	$3,%lo(pages)($2)
	subu	$3,$16,$3
	sra	$3,$3,2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$3,$2,8
	addu	$2,$2,$3
	sll	$3,$2,16
	addu	$2,$2,$3
	subu	$2,$0,$2
	sll	$7,$2,12
	srl	$2,$7,12
	lui	$3,%hi(npage)
	lw	$3,%lo(npage)($3)
	sltu	$2,$2,$3
	bne	$2,$0,$L58
	li	$4,-2147483648			# 0xffffffff80000000

	lui	$4,%hi($LC11)
	addiu	$4,$4,%lo($LC11)
	li	$5,57			# 0x39
	lui	$6,%hi($LC5)
	jal	_panic
	addiu	$6,$6,%lo($LC5)

$L58:
	addu	$4,$7,$4
	jal	bzero
	li	$5,4096			# 0x1000

	sw	$16,0($17)
	move	$2,$0
$L55:
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	j	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	page_alloc
	.align	2
	.globl	page_free
	.ent	page_free
	.type	page_free, @function
page_free:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	lhu	$2,8($4)
	bne	$2,$0,$L67
	lui	$3,%hi(page_free_list)

	lw	$2,%lo(page_free_list)($3)
	beq	$2,$0,$L64
	sw	$2,0($4)

	lw	$2,%lo(page_free_list)($3)
	sw	$4,4($2)
$L64:
	lui	$2,%hi(page_free_list)
	sw	$4,%lo(page_free_list)($2)
	addiu	$2,$2,%lo(page_free_list)
	sw	$2,4($4)
$L67:
	j	$31
	nop

	.set	macro
	.set	reorder
	.end	page_free
	.align	2
	.globl	pgdir_walk
	.ent	pgdir_walk
	.type	pgdir_walk, @function
pgdir_walk:
	.frame	$sp,40,$31		# vars= 8, regs= 4/0, args= 16, gp= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	move	$18,$7
	srl	$2,$5,22
	sll	$2,$2,2
	addu	$16,$2,$4
	lw	$7,0($16)
	andi	$2,$7,0x200
	beq	$2,$0,$L69
	move	$17,$5

	li	$2,-4096			# 0xfffffffffffff000
	and	$7,$7,$2
	srl	$2,$7,12
	lui	$3,%hi(npage)
	lw	$3,%lo(npage)($3)
	sltu	$2,$2,$3
	bne	$2,$0,$L71
	li	$2,-2147483648			# 0xffffffff80000000

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,310			# 0x136
	lui	$6,%hi($LC5)
	jal	_panic
	addiu	$6,$6,%lo($LC5)

$L71:
	b	$L73
	addu	$7,$7,$2

$L69:
	li	$2,1			# 0x1
	bne	$6,$2,$L74
	nop

	jal	page_alloc
	addiu	$4,$sp,16

	beq	$2,$0,$L76
	lw	$3,16($sp)

	b	$L78
	li	$2,-4			# 0xfffffffffffffffc

$L76:
	lui	$2,%hi(pages)
	lw	$2,%lo(pages)($2)
	subu	$3,$3,$2
	sra	$3,$3,2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$3,$2,8
	addu	$2,$2,$3
	sll	$3,$2,16
	addu	$2,$2,$3
	subu	$2,$0,$2
	sll	$7,$2,12
	srl	$2,$7,12
	lui	$3,%hi(npage)
	lw	$3,%lo(npage)($3)
	sltu	$2,$2,$3
	bne	$2,$0,$L79
	li	$2,-2147483648			# 0xffffffff80000000

	lui	$4,%hi($LC11)
	addiu	$4,$4,%lo($LC11)
	li	$5,57			# 0x39
	lui	$6,%hi($LC5)
	jal	_panic
	addiu	$6,$6,%lo($LC5)

$L79:
	addu	$7,$7,$2
	bltz	$7,$L81
	li	$2,-2147483648			# 0xffffffff80000000

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,321			# 0x141
	lui	$6,%hi($LC3)
	jal	_panic
	addiu	$6,$6,%lo($LC3)

$L81:
	addu	$2,$7,$2
	ori	$2,$2,0x600
	sw	$2,0($16)
	lw	$3,16($sp)
	lhu	$2,8($3)
	addiu	$2,$2,1
	b	$L73
	sh	$2,8($3)

$L74:
	sw	$0,0($18)
	b	$L78
	move	$2,$0

$L73:
	srl	$2,$17,10
	andi	$2,$2,0xffc
	addu	$2,$7,$2
	sw	$2,0($18)
	move	$2,$0
$L78:
	lw	$31,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	j	$31
	addiu	$sp,$sp,40

	.set	macro
	.set	reorder
	.end	pgdir_walk
	.section	.rodata.str1.4
	.align	2
$LC12:
	.ascii	"pa2page called with invalid pa: %x\000"
	.text
	.align	2
	.globl	page_insert
	.ent	page_insert
	.type	page_insert, @function
page_insert:
	.frame	$sp,48,$31		# vars= 8, regs= 5/0, args= 16, gp= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-48
	sw	$31,40($sp)
	sw	$19,36($sp)
	sw	$18,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	move	$17,$4
	move	$18,$5
	move	$16,$6
	ori	$19,$7,0x200
	move	$5,$6
	move	$6,$0
	jal	pgdir_walk
	addiu	$7,$sp,16

	lw	$2,16($sp)
	beq	$2,$0,$L96
	move	$4,$17

	lw	$7,0($2)
	andi	$2,$7,0x200
	beq	$2,$0,$L85
	lui	$2,%hi(npage)

	srl	$4,$7,12
	lw	$2,%lo(npage)($2)
	sltu	$2,$4,$2
	bne	$2,$0,$L88
	sll	$3,$4,2

	lui	$4,%hi($LC11)
	addiu	$4,$4,%lo($LC11)
	li	$5,46			# 0x2e
	lui	$6,%hi($LC12)
	jal	_panic
	addiu	$6,$6,%lo($LC12)

$L88:
	sll	$2,$4,4
	subu	$2,$2,$3
	lui	$3,%hi(pages)
	lw	$3,%lo(pages)($3)
	addu	$2,$2,$3
	beq	$18,$2,$L90
	move	$4,$17

	jal	page_remove
	move	$5,$16

	b	$L96
	move	$4,$17

$L90:
	jal	tlb_invalidate
	move	$5,$16

	lui	$2,%hi(pages)
	lw	$3,%lo(pages)($2)
	subu	$3,$18,$3
	sra	$3,$3,2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$3,$2,8
	addu	$2,$2,$3
	sll	$3,$2,16
	addu	$2,$2,$3
	subu	$2,$0,$2
	sll	$2,$2,12
	or	$2,$19,$2
	lw	$3,16($sp)
	sw	$2,0($3)
	b	$L92
	move	$2,$0

$L85:
$L96:
	jal	tlb_invalidate
	move	$5,$16

	move	$4,$17
	move	$5,$16
	li	$6,1			# 0x1
	jal	pgdir_walk
	addiu	$7,$sp,16

	bne	$2,$0,$L92
	li	$2,-4			# 0xfffffffffffffffc

	lui	$2,%hi(pages)
	lw	$3,%lo(pages)($2)
	subu	$3,$18,$3
	sra	$3,$3,2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$3,$2,8
	addu	$2,$2,$3
	sll	$3,$2,16
	addu	$2,$2,$3
	subu	$2,$0,$2
	sll	$2,$2,12
	or	$2,$19,$2
	lw	$3,16($sp)
	sw	$2,0($3)
	lhu	$2,8($18)
	addiu	$2,$2,1
	sh	$2,8($18)
	move	$2,$0
$L92:
	lw	$31,40($sp)
	lw	$19,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	j	$31
	addiu	$sp,$sp,48

	.set	macro
	.set	reorder
	.end	page_insert
	.align	2
	.globl	page_lookup
	.ent	page_lookup
	.type	page_lookup, @function
page_lookup:
	.frame	$sp,32,$31		# vars= 8, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$16,24($sp)
	move	$16,$6
	move	$6,$0
	jal	pgdir_walk
	addiu	$7,$sp,16

	lw	$4,16($sp)
	beq	$4,$0,$L106
	move	$2,$0

	lw	$7,0($4)
	andi	$2,$7,0x200
	beq	$2,$0,$L98
	srl	$5,$7,12

	lui	$2,%hi(npage)
	lw	$2,%lo(npage)($2)
	sltu	$2,$5,$2
	bne	$2,$0,$L101
	sll	$3,$5,2

	lui	$4,%hi($LC11)
	addiu	$4,$4,%lo($LC11)
	li	$5,46			# 0x2e
	lui	$6,%hi($LC12)
	jal	_panic
	addiu	$6,$6,%lo($LC12)

$L101:
	sll	$2,$5,4
	subu	$2,$2,$3
	lui	$3,%hi(pages)
	lw	$3,%lo(pages)($3)
	beq	$16,$0,$L103
	addu	$2,$2,$3

	b	$L103
	sw	$4,0($16)

$L98:
	move	$2,$0
$L103:
$L106:
	lw	$31,28($sp)
	lw	$16,24($sp)
	j	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	page_lookup
	.align	2
	.globl	page_decref
	.ent	page_decref
	.type	page_decref, @function
page_decref:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-24
	sw	$31,16($sp)
	lhu	$2,8($4)
	addiu	$2,$2,-1
	andi	$2,$2,0xffff
	bne	$2,$0,$L110
	sh	$2,8($4)

	jal	page_free
	nop

$L110:
	lw	$31,16($sp)
	j	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	page_decref
	.align	2
	.globl	page_remove
	.ent	page_remove
	.type	page_remove, @function
page_remove:
	.frame	$sp,40,$31		# vars= 8, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-40
	sw	$31,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	move	$16,$4
	move	$17,$5
	jal	page_lookup
	addiu	$6,$sp,16

	beq	$2,$0,$L116
	move	$4,$2

	lhu	$2,8($2)
	addiu	$2,$2,-1
	andi	$2,$2,0xffff
	bne	$2,$0,$L114
	sh	$2,8($4)

	jal	page_free
	nop

$L114:
	lw	$2,16($sp)
	sw	$0,0($2)
	move	$4,$16
	jal	tlb_invalidate
	move	$5,$17

$L116:
	lw	$31,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	j	$31
	addiu	$sp,$sp,40

	.set	macro
	.set	reorder
	.end	page_remove
	.align	2
	.globl	tlb_invalidate
	.ent	tlb_invalidate
	.type	tlb_invalidate, @function
tlb_invalidate:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-24
	sw	$31,16($sp)
	lui	$2,%hi(curenv)
	lw	$3,%lo(curenv)($2)
	beq	$3,$0,$L118
	li	$2,-4096			# 0xfffffffffffff000

	and	$2,$5,$2
	lw	$4,164($3)
	srl	$4,$4,11
	sll	$4,$4,6
	jal	tlb_out
	or	$4,$2,$4

	b	$L122
	lw	$31,16($sp)

$L118:
	li	$4,-4096			# 0xfffffffffffff000
	jal	tlb_out
	and	$4,$5,$4

	lw	$31,16($sp)
$L122:
	j	$31
	addiu	$sp,$sp,24

	.set	macro
	.set	reorder
	.end	tlb_invalidate
	.rdata
	.align	2
	.type	C.80.1528, @object
	.size	C.80.1528, 44
C.80.1528:
	.word	0
	.word	1
	.word	2
	.word	3
	.word	4
	.word	20
	.word	5
	.word	6
	.word	7
	.word	8
	.word	9
	.align	2
	.type	C.78.1522, @object
	.size	C.78.1522, 40
C.78.1522:
	.word	0
	.word	1
	.word	2
	.word	3
	.word	4
	.word	5
	.word	6
	.word	7
	.word	8
	.word	9
	.section	.rodata.str1.4
	.align	2
$LC13:
	.ascii	"assertion failed: %s\000"
	.align	2
$LC14:
	.ascii	"page_alloc(&pp0) == 0\000"
	.align	2
$LC15:
	.ascii	"page_alloc(&pp1) == 0\000"
	.align	2
$LC16:
	.ascii	"page_alloc(&pp2) == 0\000"
	.align	2
$LC17:
	.ascii	"pp0\000"
	.align	2
$LC18:
	.ascii	"pp1 && pp1 != pp0\000"
	.align	2
$LC19:
	.ascii	"pp2 && pp2 != pp1 && pp2 != pp0\000"
	.align	2
$LC20:
	.ascii	"page_alloc(&pp) == -E_NO_MEM\000"
	.align	2
$LC21:
	.ascii	"The number in address temp is %d\012\000"
	.align	2
$LC22:
	.ascii	"temp == (int*)page2kva(pp0)\000"
	.align	2
$LC23:
	.ascii	"*temp == 0\000"
	.align	2
$LC24:
	.ascii	"p!=NULL\000"
	.align	2
$LC25:
	.ascii	"p->pp_ref==answer1[j++]\000"
	.align	2
$LC26:
	.ascii	"p->pp_ref==answer2[j++]\000"
	.align	2
$LC27:
	.ascii	"physical_memory_manage_check() succeeded\012\000"
	.text
	.align	2
	.globl	physical_memory_manage_check
	.ent	physical_memory_manage_check
	.type	physical_memory_manage_check, @function
physical_memory_manage_check:
	.frame	$sp,136,$31		# vars= 104, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-136
	sw	$31,128($sp)
	sw	$17,124($sp)
	sw	$16,120($sp)
	sw	$0,28($sp)
	sw	$0,24($sp)
	sw	$0,20($sp)
	jal	page_alloc
	addiu	$4,$sp,20

	beq	$2,$0,$L124
	lui	$4,%hi($LC2)

	addiu	$4,$4,%lo($LC2)
	li	$5,481			# 0x1e1
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC14)
	jal	_panic
	addiu	$7,$7,%lo($LC14)

$L124:
	jal	page_alloc
	addiu	$4,$sp,24

	beq	$2,$0,$L126
	lui	$4,%hi($LC2)

	addiu	$4,$4,%lo($LC2)
	li	$5,482			# 0x1e2
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC15)
	jal	_panic
	addiu	$7,$7,%lo($LC15)

$L126:
	jal	page_alloc
	addiu	$4,$sp,28

	beq	$2,$0,$L128
	lw	$4,20($sp)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,483			# 0x1e3
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC16)
	jal	_panic
	addiu	$7,$7,%lo($LC16)

$L128:
	bne	$4,$0,$L130
	lw	$3,24($sp)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,485			# 0x1e5
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC17)
	jal	_panic
	addiu	$7,$7,%lo($LC17)

$L130:
	beq	$3,$0,$L132
	nop

	bne	$4,$3,$L134
	lw	$2,28($sp)

$L132:
	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,486			# 0x1e6
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC18)
	jal	_panic
	addiu	$7,$7,%lo($LC18)

$L134:
	beq	$2,$0,$L135
	nop

	beq	$3,$2,$L135
	nop

	bne	$4,$2,$L138
	lui	$2,%hi(page_free_list)

$L135:
	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,487			# 0x1e7
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC19)
	jal	_panic
	addiu	$7,$7,%lo($LC19)

$L138:
	lw	$17,%lo(page_free_list)($2)
	sw	$0,%lo(page_free_list)($2)
	jal	page_alloc
	addiu	$4,$sp,16

	li	$3,-4			# 0xfffffffffffffffc
	beq	$2,$3,$L139
	lui	$2,%hi(pages)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,496			# 0x1f0
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC20)
	jal	_panic
	addiu	$7,$7,%lo($LC20)

$L139:
	lw	$2,%lo(pages)($2)
	lw	$3,20($sp)
	subu	$3,$3,$2
	sra	$3,$3,2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$3,$2,8
	addu	$2,$2,$3
	sll	$3,$2,16
	addu	$2,$2,$3
	subu	$2,$0,$2
	sll	$7,$2,12
	srl	$2,$7,12
	lui	$3,%hi(npage)
	lw	$3,%lo(npage)($3)
	sltu	$2,$2,$3
	bne	$2,$0,$L141
	li	$2,-2147483648			# 0xffffffff80000000

	lui	$4,%hi($LC11)
	addiu	$4,$4,%lo($LC11)
	li	$5,57			# 0x39
	lui	$6,%hi($LC5)
	jal	_panic
	addiu	$6,$6,%lo($LC5)

$L141:
	addu	$16,$7,$2
	li	$2,1000			# 0x3e8
	sw	$2,0($16)
	jal	page_free
	lw	$4,20($sp)

	lui	$4,%hi($LC21)
	addiu	$4,$4,%lo($LC21)
	jal	printf
	lw	$5,0($16)

	jal	page_alloc
	addiu	$4,$sp,20

	beq	$2,$0,$L143
	lw	$4,20($sp)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,506			# 0x1fa
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC14)
	jal	_panic
	addiu	$7,$7,%lo($LC14)

$L143:
	bne	$4,$0,$L145
	lui	$2,%hi(pages)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,507			# 0x1fb
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC17)
	jal	_panic
	addiu	$7,$7,%lo($LC17)

$L145:
	lw	$3,%lo(pages)($2)
	subu	$3,$4,$3
	sra	$3,$3,2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$3,$2,8
	addu	$2,$2,$3
	sll	$3,$2,16
	addu	$2,$2,$3
	subu	$2,$0,$2
	sll	$7,$2,12
	srl	$2,$7,12
	lui	$3,%hi(npage)
	lw	$3,%lo(npage)($3)
	sltu	$2,$2,$3
	bne	$2,$0,$L147
	li	$2,-2147483648			# 0xffffffff80000000

	lui	$4,%hi($LC11)
	addiu	$4,$4,%lo($LC11)
	li	$5,57			# 0x39
	lui	$6,%hi($LC5)
	jal	_panic
	addiu	$6,$6,%lo($LC5)

$L147:
	addu	$2,$7,$2
	beq	$16,$2,$L149
	li	$5,510			# 0x1fe

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC22)
	jal	_panic
	addiu	$7,$7,%lo($LC22)

$L149:
	lw	$2,0($16)
	beq	$2,$0,$L151
	lui	$2,%hi(page_free_list)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,512			# 0x200
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC23)
	jal	_panic
	addiu	$7,$7,%lo($LC23)

$L151:
	jal	page_free
	sw	$17,%lo(page_free_list)($2)

	jal	page_free
	lw	$4,24($sp)

	jal	page_free
	lw	$4,28($sp)

	li	$4,120			# 0x78
	li	$5,4096			# 0x1000
	jal	alloc
	li	$6,1			# 0x1

	move	$17,$2
	move	$4,$2
	move	$5,$0
	move	$16,$0
	li	$7,10			# 0xa
$L153:
	move	$6,$4
	bne	$16,$0,$L154
	sh	$5,8($4)

	b	$L156
	move	$16,$4

$L154:
	move	$3,$16
$L157:
	lw	$2,0($3)
	beq	$2,$0,$L158
	nop

	b	$L157
	move	$3,$2

$L158:
	sw	$0,0($4)
	sw	$6,0($3)
	sw	$3,4($4)
$L156:
	addiu	$5,$5,1
	bne	$5,$7,$L153
	addiu	$4,$4,12

	lui	$2,%hi(C.78.1522)
	addiu	$6,$2,%lo(C.78.1522)
	addiu	$7,$sp,32
	addiu	$8,$6,32
$L161:
	lw	$2,0($6)
	lw	$3,4($6)
	lw	$4,8($6)
	lw	$5,12($6)
	sw	$2,0($7)
	sw	$3,4($7)
	sw	$4,8($7)
	sw	$5,12($7)
	addiu	$6,$6,16
	bne	$6,$8,$L161
	addiu	$7,$7,16

	lw	$2,0($6)
	lw	$3,4($6)
	sw	$2,0($7)
	bne	$16,$0,$L162
	sw	$3,4($7)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,536			# 0x218
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC24)
	jal	_panic
	addiu	$7,$7,%lo($LC24)

$L162:
	move	$4,$16
	addiu	$5,$sp,32
$L164:
	lhu	$3,8($4)
	lw	$2,0($5)
	beq	$3,$2,$L165
	lui	$6,%hi($LC13)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,540			# 0x21c
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC25)
	jal	_panic
	addiu	$7,$7,%lo($LC25)

$L165:
	lw	$4,0($4)
	bne	$4,$0,$L164
	addiu	$5,$5,4

	lui	$2,%hi(C.80.1528)
	addiu	$6,$2,%lo(C.80.1528)
	addiu	$7,$sp,72
	addiu	$8,$6,32
$L168:
	lw	$2,0($6)
	lw	$3,4($6)
	lw	$4,8($6)
	lw	$5,12($6)
	sw	$2,0($7)
	sw	$3,4($7)
	sw	$4,8($7)
	sw	$5,12($7)
	addiu	$6,$6,16
	bne	$6,$8,$L168
	addiu	$7,$7,16

	lw	$2,0($6)
	lw	$3,4($6)
	lw	$4,8($6)
	sw	$2,0($7)
	sw	$3,4($7)
	sw	$4,8($7)
	li	$4,12			# 0xc
	li	$5,4096			# 0x1000
	jal	alloc
	li	$6,1			# 0x1

	move	$3,$2
	li	$2,20
	sh	$2,8($3)
	addiu	$4,$17,48
	lw	$2,48($17)
	beq	$2,$0,$L169
	sw	$2,0($3)

	sw	$3,4($2)
$L169:
	sw	$3,0($4)
	sw	$4,4($3)
	move	$4,$16
	addiu	$5,$sp,72
$L171:
	lhu	$3,8($4)
	lw	$2,0($5)
	beq	$3,$2,$L172
	lui	$6,%hi($LC13)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,558			# 0x22e
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC26)
	jal	_panic
	addiu	$7,$7,%lo($LC26)

$L172:
	lw	$4,0($4)
	bne	$4,$0,$L171
	addiu	$5,$5,4

	lui	$4,%hi($LC27)
	jal	printf
	addiu	$4,$4,%lo($LC27)

	lw	$31,128($sp)
	lw	$17,124($sp)
	lw	$16,120($sp)
	j	$31
	addiu	$sp,$sp,136

	.set	macro
	.set	reorder
	.end	physical_memory_manage_check
	.section	.rodata.str1.4
	.align	2
$LC28:
	.ascii	"page_insert(boot_pgdir, pp1, 0x0, 0) < 0\000"
	.align	2
$LC29:
	.ascii	"page_insert(boot_pgdir, pp1, 0x0, 0) == 0\000"
	.align	2
$LC30:
	.ascii	"PTE_ADDR(boot_pgdir[0]) == page2pa(pp0)\000"
	.align	2
$LC31:
	.ascii	"va2pa(boot_pgdir, 0x0) is %x\012\000"
	.align	2
$LC32:
	.ascii	"page2pa(pp1) is %x\012\000"
	.align	2
$LC33:
	.ascii	"va2pa(boot_pgdir, 0x0) == page2pa(pp1)\000"
	.align	2
$LC34:
	.ascii	"pp1->pp_ref == 1\000"
	.align	2
$LC35:
	.ascii	"page_insert(boot_pgdir, pp2, BY2PG, 0) == 0\000"
	.align	2
$LC36:
	.ascii	"va2pa(boot_pgdir, BY2PG) == page2pa(pp2)\000"
	.align	2
$LC37:
	.ascii	"pp2->pp_ref == 1\000"
	.align	2
$LC38:
	.ascii	"start page_insert\012\000"
	.align	2
$LC39:
	.ascii	"page_insert(boot_pgdir, pp0, PDMAP, 0) < 0\000"
	.align	2
$LC40:
	.ascii	"page_insert(boot_pgdir, pp1, BY2PG, 0) == 0\000"
	.align	2
$LC41:
	.ascii	"va2pa(boot_pgdir, BY2PG) == page2pa(pp1)\000"
	.align	2
$LC42:
	.ascii	"pp1->pp_ref == 2\000"
	.align	2
$LC43:
	.ascii	"pp2->pp_ref %d\012\000"
	.align	2
$LC44:
	.ascii	"pp2->pp_ref == 0\000"
	.align	2
$LC45:
	.ascii	"end page_insert\012\000"
	.align	2
$LC46:
	.ascii	"page_alloc(&pp) == 0 && pp == pp2\000"
	.align	2
$LC47:
	.ascii	"va2pa(boot_pgdir, 0x0) == ~0\000"
	.align	2
$LC48:
	.ascii	"va2pa(boot_pgdir, BY2PG) == ~0\000"
	.align	2
$LC49:
	.ascii	"pp1->pp_ref == 0\000"
	.align	2
$LC50:
	.ascii	"page_alloc(&pp) == 0 && pp == pp1\000"
	.align	2
$LC51:
	.ascii	"pp0->pp_ref == 1\000"
	.align	2
$LC52:
	.ascii	"page_check() succeeded!\012\000"
	.text
	.align	2
	.globl	page_check
	.ent	page_check
	.type	page_check, @function
page_check:
	.frame	$sp,48,$31		# vars= 16, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-48
	sw	$31,40($sp)
	sw	$17,36($sp)
	sw	$16,32($sp)
	sw	$0,28($sp)
	sw	$0,24($sp)
	sw	$0,20($sp)
	jal	page_alloc
	addiu	$4,$sp,20

	beq	$2,$0,$L187
	lui	$4,%hi($LC2)

	addiu	$4,$4,%lo($LC2)
	li	$5,576			# 0x240
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC14)
	jal	_panic
	addiu	$7,$7,%lo($LC14)

$L187:
	jal	page_alloc
	addiu	$4,$sp,24

	beq	$2,$0,$L189
	lui	$4,%hi($LC2)

	addiu	$4,$4,%lo($LC2)
	li	$5,577			# 0x241
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC15)
	jal	_panic
	addiu	$7,$7,%lo($LC15)

$L189:
	jal	page_alloc
	addiu	$4,$sp,28

	beq	$2,$0,$L191
	lw	$4,20($sp)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,578			# 0x242
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC16)
	jal	_panic
	addiu	$7,$7,%lo($LC16)

$L191:
	bne	$4,$0,$L193
	lw	$3,24($sp)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,580			# 0x244
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC17)
	jal	_panic
	addiu	$7,$7,%lo($LC17)

$L193:
	beq	$3,$0,$L195
	nop

	bne	$4,$3,$L197
	lw	$2,28($sp)

$L195:
	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,581			# 0x245
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC18)
	jal	_panic
	addiu	$7,$7,%lo($LC18)

$L197:
	beq	$2,$0,$L198
	nop

	beq	$3,$2,$L198
	nop

	bne	$4,$2,$L201
	lui	$2,%hi(page_free_list)

$L198:
	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,582			# 0x246
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC19)
	jal	_panic
	addiu	$7,$7,%lo($LC19)

$L201:
	lw	$17,%lo(page_free_list)($2)
	sw	$0,%lo(page_free_list)($2)
	jal	page_alloc
	addiu	$4,$sp,16

	li	$3,-4			# 0xfffffffffffffffc
	beq	$2,$3,$L202
	lui	$2,%hi(boot_pgdir)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,590			# 0x24e
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC20)
	jal	_panic
	addiu	$7,$7,%lo($LC20)

$L202:
	lw	$4,%lo(boot_pgdir)($2)
	lw	$5,24($sp)
	move	$6,$0
	jal	page_insert
	move	$7,$0

	bltz	$2,$L204
	lui	$4,%hi($LC2)

	addiu	$4,$4,%lo($LC2)
	li	$5,593			# 0x251
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC28)
	jal	_panic
	addiu	$7,$7,%lo($LC28)

$L204:
	jal	page_free
	lw	$4,20($sp)

	lui	$2,%hi(boot_pgdir)
	lw	$4,%lo(boot_pgdir)($2)
	lw	$5,24($sp)
	move	$6,$0
	jal	page_insert
	move	$7,$0

	beq	$2,$0,$L206
	lui	$2,%hi(boot_pgdir)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,597			# 0x255
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC29)
	jal	_panic
	addiu	$7,$7,%lo($LC29)

$L206:
	lw	$2,%lo(boot_pgdir)($2)
	lw	$4,0($2)
	li	$2,-4096			# 0xfffffffffffff000
	and	$7,$4,$2
	lui	$2,%hi(pages)
	lw	$2,%lo(pages)($2)
	lw	$3,20($sp)
	subu	$3,$3,$2
	sra	$3,$3,2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$3,$2,8
	addu	$2,$2,$3
	sll	$3,$2,16
	addu	$2,$2,$3
	subu	$2,$0,$2
	sll	$2,$2,12
	beq	$7,$2,$L208
	andi	$2,$4,0x200

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,598			# 0x256
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC30)
	jal	_panic
	addiu	$7,$7,%lo($LC30)

$L208:
	beq	$2,$0,$L210
	srl	$2,$7,12

	lui	$3,%hi(npage)
	lw	$3,%lo(npage)($3)
	sltu	$2,$2,$3
	bne	$2,$0,$L212
	li	$2,-2147483648			# 0xffffffff80000000

	lui	$4,%hi($LC11)
	addiu	$4,$4,%lo($LC11)
	li	$5,73			# 0x49
	lui	$6,%hi($LC5)
	jal	_panic
	addiu	$6,$6,%lo($LC5)

$L212:
	addu	$2,$7,$2
	lw	$5,0($2)
	andi	$2,$5,0x200
	beq	$2,$0,$L210
	li	$2,-4096			# 0xfffffffffffff000

	b	$L215
	and	$5,$5,$2

$L210:
	li	$5,-1			# 0xffffffffffffffff
$L215:
	lui	$4,%hi($LC31)
	jal	printf
	addiu	$4,$4,%lo($LC31)

	lui	$2,%hi(pages)
	lw	$3,%lo(pages)($2)
	lw	$2,24($sp)
	subu	$2,$2,$3
	sra	$2,$2,2
	sll	$5,$2,2
	addu	$5,$5,$2
	sll	$2,$5,4
	addu	$5,$5,$2
	sll	$2,$5,8
	addu	$5,$5,$2
	sll	$2,$5,16
	addu	$5,$5,$2
	subu	$5,$0,$5
	lui	$4,%hi($LC32)
	addiu	$4,$4,%lo($LC32)
	jal	printf
	sll	$5,$5,12

	lui	$2,%hi(boot_pgdir)
	lw	$4,%lo(boot_pgdir)($2)
	lw	$7,0($4)
	andi	$2,$7,0x200
	beq	$2,$0,$L216
	li	$2,-4096			# 0xfffffffffffff000

	and	$7,$7,$2
	srl	$2,$7,12
	lui	$3,%hi(npage)
	lw	$3,%lo(npage)($3)
	sltu	$2,$2,$3
	bne	$2,$0,$L218
	li	$2,-2147483648			# 0xffffffff80000000

	lui	$4,%hi($LC11)
	addiu	$4,$4,%lo($LC11)
	li	$5,73			# 0x49
	lui	$6,%hi($LC5)
	jal	_panic
	addiu	$6,$6,%lo($LC5)

$L218:
	addu	$2,$7,$2
	lw	$7,0($2)
	andi	$2,$7,0x200
	beq	$2,$0,$L216
	li	$2,-4096			# 0xfffffffffffff000

	b	$L221
	and	$7,$7,$2

$L216:
	li	$7,-1			# 0xffffffffffffffff
$L221:
	lw	$5,24($sp)
	lui	$2,%hi(pages)
	lw	$3,%lo(pages)($2)
	subu	$3,$5,$3
	sra	$3,$3,2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$3,$2,8
	addu	$2,$2,$3
	sll	$3,$2,16
	addu	$2,$2,$3
	subu	$2,$0,$2
	sll	$2,$2,12
	beq	$7,$2,$L222
	li	$2,1			# 0x1

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,603			# 0x25b
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC33)
	jal	_panic
	addiu	$7,$7,%lo($LC33)

$L222:
	lhu	$3,8($5)
	beq	$3,$2,$L224
	lw	$5,28($sp)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,604			# 0x25c
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC34)
	jal	_panic
	addiu	$7,$7,%lo($LC34)

$L224:
	li	$6,4096			# 0x1000
	jal	page_insert
	move	$7,$0

	beq	$2,$0,$L226
	lui	$2,%hi(boot_pgdir)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,607			# 0x25f
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC35)
	jal	_panic
	addiu	$7,$7,%lo($LC35)

$L226:
	lw	$2,%lo(boot_pgdir)($2)
	lw	$7,0($2)
	andi	$2,$7,0x200
	beq	$2,$0,$L228
	li	$2,-4096			# 0xfffffffffffff000

	and	$7,$7,$2
	srl	$2,$7,12
	lui	$3,%hi(npage)
	lw	$3,%lo(npage)($3)
	sltu	$2,$2,$3
	bne	$2,$0,$L230
	li	$2,-2147483648			# 0xffffffff80000000

	lui	$4,%hi($LC11)
	addiu	$4,$4,%lo($LC11)
	li	$5,73			# 0x49
	lui	$6,%hi($LC5)
	jal	_panic
	addiu	$6,$6,%lo($LC5)

$L230:
	addu	$2,$7,$2
	lw	$7,4($2)
	andi	$2,$7,0x200
	beq	$2,$0,$L228
	li	$2,-4096			# 0xfffffffffffff000

	b	$L233
	and	$7,$7,$2

$L228:
	li	$7,-1			# 0xffffffffffffffff
$L233:
	lw	$4,28($sp)
	lui	$2,%hi(pages)
	lw	$3,%lo(pages)($2)
	subu	$3,$4,$3
	sra	$3,$3,2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$3,$2,8
	addu	$2,$2,$3
	sll	$3,$2,16
	addu	$2,$2,$3
	subu	$2,$0,$2
	sll	$2,$2,12
	beq	$7,$2,$L234
	li	$2,1			# 0x1

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,608			# 0x260
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC36)
	jal	_panic
	addiu	$7,$7,%lo($LC36)

$L234:
	lhu	$3,8($4)
	beq	$3,$2,$L236
	lui	$4,%hi($LC2)

	addiu	$4,$4,%lo($LC2)
	li	$5,609			# 0x261
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC37)
	jal	_panic
	addiu	$7,$7,%lo($LC37)

$L236:
	jal	page_alloc
	addiu	$4,$sp,16

	li	$3,-4			# 0xfffffffffffffffc
	beq	$2,$3,$L238
	li	$5,612			# 0x264

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC20)
	jal	_panic
	addiu	$7,$7,%lo($LC20)

$L238:
	lui	$4,%hi($LC38)
	jal	printf
	addiu	$4,$4,%lo($LC38)

	lui	$2,%hi(boot_pgdir)
	lw	$4,%lo(boot_pgdir)($2)
	lw	$5,28($sp)
	li	$6,4096			# 0x1000
	jal	page_insert
	move	$7,$0

	beq	$2,$0,$L240
	lui	$2,%hi(boot_pgdir)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,616			# 0x268
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC35)
	jal	_panic
	addiu	$7,$7,%lo($LC35)

$L240:
	lw	$2,%lo(boot_pgdir)($2)
	lw	$7,0($2)
	andi	$2,$7,0x200
	beq	$2,$0,$L242
	li	$2,-4096			# 0xfffffffffffff000

	and	$7,$7,$2
	srl	$2,$7,12
	lui	$3,%hi(npage)
	lw	$3,%lo(npage)($3)
	sltu	$2,$2,$3
	bne	$2,$0,$L244
	li	$2,-2147483648			# 0xffffffff80000000

	lui	$4,%hi($LC11)
	addiu	$4,$4,%lo($LC11)
	li	$5,73			# 0x49
	lui	$6,%hi($LC5)
	jal	_panic
	addiu	$6,$6,%lo($LC5)

$L244:
	addu	$2,$7,$2
	lw	$7,4($2)
	andi	$2,$7,0x200
	beq	$2,$0,$L242
	li	$2,-4096			# 0xfffffffffffff000

	b	$L247
	and	$7,$7,$2

$L242:
	li	$7,-1			# 0xffffffffffffffff
$L247:
	lw	$4,28($sp)
	lui	$2,%hi(pages)
	lw	$3,%lo(pages)($2)
	subu	$3,$4,$3
	sra	$3,$3,2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$3,$2,8
	addu	$2,$2,$3
	sll	$3,$2,16
	addu	$2,$2,$3
	subu	$2,$0,$2
	sll	$2,$2,12
	beq	$7,$2,$L248
	li	$2,1			# 0x1

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,617			# 0x269
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC36)
	jal	_panic
	addiu	$7,$7,%lo($LC36)

$L248:
	lhu	$3,8($4)
	beq	$3,$2,$L250
	lui	$4,%hi($LC2)

	addiu	$4,$4,%lo($LC2)
	li	$5,618			# 0x26a
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC37)
	jal	_panic
	addiu	$7,$7,%lo($LC37)

$L250:
	jal	page_alloc
	addiu	$4,$sp,16

	li	$3,-4			# 0xfffffffffffffffc
	beq	$2,$3,$L252
	lui	$2,%hi(boot_pgdir)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,622			# 0x26e
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC20)
	jal	_panic
	addiu	$7,$7,%lo($LC20)

$L252:
	lw	$4,%lo(boot_pgdir)($2)
	lw	$5,20($sp)
	li	$6,4194304			# 0x400000
	jal	page_insert
	move	$7,$0

	bltz	$2,$L254
	lui	$2,%hi(boot_pgdir)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,625			# 0x271
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC39)
	jal	_panic
	addiu	$7,$7,%lo($LC39)

$L254:
	lw	$4,%lo(boot_pgdir)($2)
	lw	$5,24($sp)
	li	$6,4096			# 0x1000
	jal	page_insert
	move	$7,$0

	beq	$2,$0,$L256
	lui	$2,%hi(boot_pgdir)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,628			# 0x274
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC40)
	jal	_panic
	addiu	$7,$7,%lo($LC40)

$L256:
	lw	$2,%lo(boot_pgdir)($2)
	lw	$5,0($2)
	srl	$2,$5,9
	andi	$6,$2,0x1
	beq	$6,$0,$L263
	li	$4,-1			# 0xffffffffffffffff

	li	$2,-4096			# 0xfffffffffffff000
	and	$7,$5,$2
	srl	$2,$7,12
	lui	$3,%hi(npage)
	lw	$3,%lo(npage)($3)
	sltu	$2,$2,$3
	bne	$2,$0,$L260
	li	$2,-2147483648			# 0xffffffff80000000

	lui	$4,%hi($LC11)
	addiu	$4,$4,%lo($LC11)
	li	$5,73			# 0x49
	lui	$6,%hi($LC5)
	jal	_panic
	addiu	$6,$6,%lo($LC5)

$L260:
	addu	$2,$7,$2
	lw	$7,0($2)
	andi	$2,$7,0x200
	beq	$2,$0,$L258
	li	$2,-4096			# 0xfffffffffffff000

	b	$L263
	and	$4,$7,$2

$L258:
	li	$4,-1			# 0xffffffffffffffff
$L263:
	lw	$8,24($sp)
	lui	$2,%hi(pages)
	lw	$3,%lo(pages)($2)
	subu	$3,$8,$3
	sra	$3,$3,2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$3,$2,8
	addu	$2,$2,$3
	sll	$3,$2,16
	addu	$2,$2,$3
	subu	$2,$0,$2
	sll	$2,$2,12
	beq	$4,$2,$L264
	lui	$7,%hi($LC33)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,631			# 0x277
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	jal	_panic
	addiu	$7,$7,%lo($LC33)

$L264:
	beq	$6,$0,$L271
	li	$2,-1			# 0xffffffffffffffff

	li	$2,-4096			# 0xfffffffffffff000
	and	$7,$5,$2
	srl	$2,$7,12
	lui	$3,%hi(npage)
	lw	$3,%lo(npage)($3)
	sltu	$2,$2,$3
	bne	$2,$0,$L268
	li	$2,-2147483648			# 0xffffffff80000000

	lui	$4,%hi($LC11)
	addiu	$4,$4,%lo($LC11)
	li	$5,73			# 0x49
	lui	$6,%hi($LC5)
	jal	_panic
	addiu	$6,$6,%lo($LC5)

$L268:
	addu	$2,$7,$2
	lw	$7,4($2)
	andi	$2,$7,0x200
	beq	$2,$0,$L266
	li	$2,-4096			# 0xfffffffffffff000

	b	$L271
	and	$2,$7,$2

$L266:
	li	$2,-1			# 0xffffffffffffffff
$L271:
	beq	$4,$2,$L272
	li	$2,2			# 0x2

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,632			# 0x278
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC41)
	jal	_panic
	addiu	$7,$7,%lo($LC41)

$L272:
	lhu	$3,8($8)
	beq	$3,$2,$L274
	lui	$4,%hi($LC43)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,634			# 0x27a
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC42)
	jal	_panic
	addiu	$7,$7,%lo($LC42)

$L274:
	addiu	$4,$4,%lo($LC43)
	lw	$2,28($sp)
	jal	printf
	lhu	$5,8($2)

	lw	$2,28($sp)
	lhu	$2,8($2)
	beq	$2,$0,$L276
	li	$5,636			# 0x27c

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC44)
	jal	_panic
	addiu	$7,$7,%lo($LC44)

$L276:
	lui	$4,%hi($LC45)
	jal	printf
	addiu	$4,$4,%lo($LC45)

	jal	page_alloc
	addiu	$4,$sp,16

	bne	$2,$0,$L278
	lw	$3,16($sp)

	lw	$2,28($sp)
	beq	$3,$2,$L280
	lui	$16,%hi(boot_pgdir)

$L278:
	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,640			# 0x280
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC46)
	jal	_panic
	addiu	$7,$7,%lo($LC46)

$L280:
	lw	$4,%lo(boot_pgdir)($16)
	jal	page_remove
	move	$5,$0

	lw	$4,%lo(boot_pgdir)($16)
	lw	$7,0($4)
	andi	$2,$7,0x200
	beq	$2,$0,$L281
	li	$2,-4096			# 0xfffffffffffff000

	and	$8,$7,$2
	srl	$2,$8,12
	lui	$3,%hi(npage)
	lw	$3,%lo(npage)($3)
	sltu	$2,$2,$3
	bne	$2,$0,$L283
	li	$2,-2147483648			# 0xffffffff80000000

	lui	$4,%hi($LC11)
	addiu	$4,$4,%lo($LC11)
	li	$5,73			# 0x49
	lui	$6,%hi($LC5)
	addiu	$6,$6,%lo($LC5)
	jal	_panic
	move	$7,$8

$L283:
	addu	$2,$8,$2
	lw	$3,0($2)
	andi	$2,$3,0x200
	beq	$2,$0,$L323
	li	$2,-4096			# 0xfffffffffffff000

	and	$2,$3,$2
	li	$3,-1			# 0xffffffffffffffff
	beq	$2,$3,$L285
	li	$2,-4096			# 0xfffffffffffff000

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,644			# 0x284
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC47)
	jal	_panic
	addiu	$7,$7,%lo($LC47)

$L285:
$L323:
	and	$7,$7,$2
	srl	$2,$7,12
	lui	$3,%hi(npage)
	lw	$3,%lo(npage)($3)
	sltu	$2,$2,$3
	bne	$2,$0,$L288
	li	$2,-2147483648			# 0xffffffff80000000

	lui	$4,%hi($LC11)
	addiu	$4,$4,%lo($LC11)
	li	$5,73			# 0x49
	lui	$6,%hi($LC5)
	jal	_panic
	addiu	$6,$6,%lo($LC5)

$L288:
	addu	$2,$7,$2
	lw	$7,4($2)
	andi	$2,$7,0x200
	beq	$2,$0,$L281
	li	$2,-4096			# 0xfffffffffffff000

	b	$L291
	and	$7,$7,$2

$L281:
	li	$7,-1			# 0xffffffffffffffff
$L291:
	lw	$5,24($sp)
	lui	$2,%hi(pages)
	lw	$3,%lo(pages)($2)
	subu	$3,$5,$3
	sra	$3,$3,2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$3,$2,8
	addu	$2,$2,$3
	sll	$3,$2,16
	addu	$2,$2,$3
	subu	$2,$0,$2
	sll	$2,$2,12
	beq	$7,$2,$L292
	li	$2,1			# 0x1

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,645			# 0x285
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC41)
	jal	_panic
	addiu	$7,$7,%lo($LC41)

$L292:
	lhu	$3,8($5)
	beq	$3,$2,$L294
	lw	$2,28($sp)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,646			# 0x286
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC34)
	jal	_panic
	addiu	$7,$7,%lo($LC34)

$L294:
	lhu	$2,8($2)
	beq	$2,$0,$L296
	li	$5,647			# 0x287

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC44)
	jal	_panic
	addiu	$7,$7,%lo($LC44)

$L296:
	jal	page_remove
	li	$5,4096			# 0x1000

	lui	$2,%hi(boot_pgdir)
	lw	$2,%lo(boot_pgdir)($2)
	lw	$7,0($2)
	andi	$2,$7,0x200
	beq	$2,$0,$L324
	lw	$2,24($sp)

	li	$2,-4096			# 0xfffffffffffff000
	and	$8,$7,$2
	srl	$2,$8,12
	lui	$3,%hi(npage)
	lw	$3,%lo(npage)($3)
	sltu	$2,$2,$3
	bne	$2,$0,$L300
	li	$2,-2147483648			# 0xffffffff80000000

	lui	$4,%hi($LC11)
	addiu	$4,$4,%lo($LC11)
	li	$5,73			# 0x49
	lui	$6,%hi($LC5)
	addiu	$6,$6,%lo($LC5)
	jal	_panic
	move	$7,$8

$L300:
	addu	$2,$8,$2
	lw	$3,0($2)
	andi	$2,$3,0x200
	beq	$2,$0,$L325
	li	$2,-4096			# 0xfffffffffffff000

	and	$2,$3,$2
	li	$3,-1			# 0xffffffffffffffff
	beq	$2,$3,$L302
	li	$2,-4096			# 0xfffffffffffff000

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,651			# 0x28b
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC47)
	jal	_panic
	addiu	$7,$7,%lo($LC47)

$L302:
$L325:
	and	$7,$7,$2
	srl	$2,$7,12
	lui	$3,%hi(npage)
	lw	$3,%lo(npage)($3)
	sltu	$2,$2,$3
	bne	$2,$0,$L305
	li	$2,-2147483648			# 0xffffffff80000000

	lui	$4,%hi($LC11)
	addiu	$4,$4,%lo($LC11)
	li	$5,73			# 0x49
	lui	$6,%hi($LC5)
	jal	_panic
	addiu	$6,$6,%lo($LC5)

$L305:
	addu	$2,$7,$2
	lw	$7,4($2)
	andi	$2,$7,0x200
	beq	$2,$0,$L324
	lw	$2,24($sp)

	li	$2,-4096			# 0xfffffffffffff000
	and	$2,$7,$2
	li	$3,-1			# 0xffffffffffffffff
	beq	$2,$3,$L298
	lw	$2,24($sp)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,652			# 0x28c
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC48)
	jal	_panic
	addiu	$7,$7,%lo($LC48)

$L298:
$L324:
	lhu	$2,8($2)
	beq	$2,$0,$L309
	lw	$2,28($sp)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,653			# 0x28d
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC49)
	jal	_panic
	addiu	$7,$7,%lo($LC49)

$L309:
	lhu	$2,8($2)
	beq	$2,$0,$L311
	lui	$4,%hi($LC2)

	addiu	$4,$4,%lo($LC2)
	li	$5,654			# 0x28e
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC44)
	jal	_panic
	addiu	$7,$7,%lo($LC44)

$L311:
	jal	page_alloc
	addiu	$4,$sp,16

	bne	$2,$0,$L313
	lw	$3,16($sp)

	lw	$2,24($sp)
	beq	$3,$2,$L315
	nop

$L313:
	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,657			# 0x291
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC50)
	jal	_panic
	addiu	$7,$7,%lo($LC50)

$L315:
	jal	page_alloc
	addiu	$4,$sp,16

	li	$3,-4			# 0xfffffffffffffffc
	beq	$2,$3,$L316
	lui	$2,%hi(boot_pgdir)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,660			# 0x294
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC20)
	jal	_panic
	addiu	$7,$7,%lo($LC20)

$L316:
	lw	$5,%lo(boot_pgdir)($2)
	lw	$4,0($5)
	li	$2,-4096			# 0xfffffffffffff000
	and	$4,$4,$2
	lui	$2,%hi(pages)
	lw	$2,%lo(pages)($2)
	lw	$3,20($sp)
	subu	$3,$3,$2
	sra	$3,$3,2
	sll	$2,$3,2
	addu	$2,$2,$3
	sll	$3,$2,4
	addu	$2,$2,$3
	sll	$3,$2,8
	addu	$2,$2,$3
	sll	$3,$2,16
	addu	$2,$2,$3
	subu	$2,$0,$2
	sll	$2,$2,12
	beq	$4,$2,$L318
	li	$2,1			# 0x1

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,663			# 0x297
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC30)
	jal	_panic
	addiu	$7,$7,%lo($LC30)

$L318:
	sw	$0,0($5)
	lw	$4,20($sp)
	lhu	$3,8($4)
	beq	$3,$2,$L320
	lui	$2,%hi(page_free_list)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,665			# 0x299
	lui	$6,%hi($LC13)
	addiu	$6,$6,%lo($LC13)
	lui	$7,%hi($LC51)
	jal	_panic
	addiu	$7,$7,%lo($LC51)

$L320:
	sh	$0,8($4)
	sw	$17,%lo(page_free_list)($2)
	jal	page_free
	lw	$4,20($sp)

	jal	page_free
	lw	$4,24($sp)

	jal	page_free
	lw	$4,28($sp)

	lui	$4,%hi($LC52)
	jal	printf
	addiu	$4,$4,%lo($LC52)

	lw	$31,40($sp)
	lw	$17,36($sp)
	lw	$16,32($sp)
	j	$31
	addiu	$sp,$sp,48

	.set	macro
	.set	reorder
	.end	page_check
	.section	.rodata.str1.4
	.align	2
$LC53:
	.ascii	"tlb refill and alloc error!\000"
	.align	2
$LC54:
	.ascii	">>>>>>>>>>>>>>>>>>>>>>it's env's zone\000"
	.align	2
$LC55:
	.ascii	"^^^^^^TOO LOW^^^^^^^^^\000"
	.align	2
$LC56:
	.ascii	"pageout:\011@@@___0x%x___@@@  ins a page \012\000"
	.text
	.align	2
	.globl	pageout
	.ent	pageout
	.type	pageout, @function
pageout:
	.frame	$sp,40,$31		# vars= 8, regs= 3/0, args= 16, gp= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-40
	sw	$31,32($sp)
	sw	$17,28($sp)
	sw	$16,24($sp)
	move	$16,$4
	move	$17,$5
	bltz	$5,$L327
	sw	$0,16($sp)

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,685			# 0x2ad
	lui	$6,%hi($LC53)
	jal	_panic
	addiu	$6,$6,%lo($LC53)

$L327:
	li	$2,-2134966272			# 0xffffffff80bf0000
	ori	$2,$2,0xffff
	addu	$2,$4,$2
	li	$3,4128768			# 0x3f0000
	ori	$3,$3,0xfffe
	sltu	$2,$3,$2
	bne	$2,$0,$L329
	li	$2,65535			# 0xffff

	lui	$4,%hi($LC2)
	addiu	$4,$4,%lo($LC2)
	li	$5,689			# 0x2b1
	lui	$6,%hi($LC54)
	jal	_panic
	addiu	$6,$6,%lo($LC54)

$L329:
	slt	$2,$2,$4
	bne	$2,$0,$L331
	lui	$4,%hi($LC2)

	addiu	$4,$4,%lo($LC2)
	li	$5,693			# 0x2b5
	lui	$6,%hi($LC55)
	jal	_panic
	addiu	$6,$6,%lo($LC55)

$L331:
	jal	page_alloc
	addiu	$4,$sp,16

	lw	$3,16($sp)
	lhu	$2,8($3)
	addiu	$2,$2,1
	sh	$2,8($3)
	move	$4,$17
	lw	$5,16($sp)
	li	$6,-4096			# 0xfffffffffffff000
	and	$6,$16,$6
	jal	page_insert
	li	$7,1024			# 0x400

	lui	$4,%hi($LC56)
	addiu	$4,$4,%lo($LC56)
	jal	printf
	move	$5,$16

	lw	$31,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	j	$31
	addiu	$sp,$sp,40

	.set	macro
	.set	reorder
	.end	pageout
	.local	freemem
	.comm	freemem,4,4
	.local	page_free_list
	.comm	page_free_list,4,4

	.comm	npage,4,4

	.comm	pages,4,4

	.comm	maxpa,4,4

	.comm	basemem,4,4

	.comm	extmem,4,4

	.comm	boot_pgdir,4,4
	.ident	"GCC: (GNU) 4.0.0 (DENX ELDK 4.1 4.0.0)"
