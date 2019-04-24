	.file	1 "printf.c"
	.section .mdebug.abi32
	.previous
	.text
	.align	2
	.ent	user_myoutput
	.type	user_myoutput, @function
user_myoutput:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, gp= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	li	$2,1			# 0x1
	bne	$6,$2,$L2
	move	$18,$6

	lb	$2,0($5)
	bne	$2,$0,$L12
	move	$16,$5

	b	$L11
	lw	$31,28($sp)

$L6:
	jal	syscall_putchar
	lb	$4,0($16)

	lb	$3,0($16)
	li	$2,10			# 0xa
	bne	$3,$2,$L7
	nop

	jal	syscall_putchar
	li	$4,10			# 0xa

$L7:
	addiu	$17,$17,1
	beq	$18,$17,$L9
	addiu	$16,$16,1

	b	$L6
	nop

$L2:
	blez	$6,$L11
	lw	$31,28($sp)

	move	$16,$5
$L12:
	b	$L6
	move	$17,$0

$L9:
	lw	$31,28($sp)
$L11:
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	j	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	user_myoutput
	.align	2
	.globl	writef
	.ent	writef
	.type	writef, @function
writef:
	.frame	$sp,32,$31		# vars= 8, regs= 1/0, args= 16, gp= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-32
	sw	$31,24($sp)
	sw	$5,36($sp)
	sw	$6,40($sp)
	sw	$7,44($sp)
	move	$6,$4
	addiu	$7,$sp,36
	sw	$7,16($sp)
	lui	$4,%hi(user_myoutput)
	addiu	$4,$4,%lo(user_myoutput)
	jal	user_lp_Print
	move	$5,$0

	lw	$31,24($sp)
	j	$31
	addiu	$sp,$sp,32

	.set	macro
	.set	reorder
	.end	writef
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align	2
$LC0:
	.ascii	"panic at %s:%d: \000"
	.align	2
$LC1:
	.ascii	"\012\000"
	.text
	.align	2
	.globl	_user_panic
	.ent	_user_panic
	.type	_user_panic, @function
_user_panic:
	.frame	$sp,32,$31		# vars= 8, regs= 2/0, args= 16, gp= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$16,24($sp)
	move	$3,$4
	move	$8,$5
	sw	$7,44($sp)
	move	$16,$6
	addiu	$2,$sp,44
	sw	$2,16($sp)
	lui	$4,%hi($LC0)
	addiu	$4,$4,%lo($LC0)
	move	$5,$3
	jal	writef
	move	$6,$8

	lui	$4,%hi(user_myoutput)
	addiu	$4,$4,%lo(user_myoutput)
	move	$5,$0
	move	$6,$16
	jal	user_lp_Print
	lw	$7,16($sp)

	lui	$4,%hi($LC1)
	jal	writef
	addiu	$4,$4,%lo($LC1)

$L16:
	b	$L16
	nop

	.set	macro
	.set	reorder
	.end	_user_panic
	.ident	"GCC: (GNU) 4.0.0 (DENX ELDK 4.1 4.0.0)"
