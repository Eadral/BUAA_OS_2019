#include <asm/regdef.h>
#include <asm/cp0regdef.h>
#include <asm/asm.h>
#include <stackframe.h>

.macro	__build_clear_sti
	STI
.endm

.macro	__build_clear_cli
	CLI
.endm

.macro	BUILD_HANDLER exception handler clear
	.align	5
	NESTED(handle_\exception, TF_SIZE, sp)  
	.set	noat

nop

	SAVE_ALL				
	__build_clear_\clear
	.set	at
	move	a0, sp
	jal	\handler
	nop
	j	ret_from_exception
	nop
	END(handle_\exception)
.endm


//NESTED(do_exam, 0, sp)
NESTED(handle_ov, 0, sp)

CLI
mfc0 t0, CP0_EPC
//lw t0, TF_EPC(sp)
mfc0 t5, CP0_CAUSE
//lw t5, TF_CAUSE(sp)
bgez t5, not_bd
nop

addu t0, t0, 4

not_bd:

lw a0, (t0)
srl a1, a0, 21
and a1, a1, 0x1F
srl a2, a0, 16
and a2, a2, 0x1F
jal prt_exam
nop


li t0, 0
li t1, 0
li t2, 0
li t3, 0
li t4, 0
li t5, 0
li t6, 0
li t7, 0
//sw zero, TF_REG8(sp)
//sw zero, TF_REG9(sp)
//sw zero, TF_REG10(sp)
//sw zero, TF_REG11(sp)
//sw zero, TF_REG12(sp)
//sw zero, TF_REG13(sp)
//sw zero, TF_REG14(sp)
//sw zero, TF_REG15(sp)

jal ov_check
nop

STI

mfc0 k0, CP0_EPC
jr k0
rfe


//END(do_exam)
END(handle_ov)

//BUILD_HANDLER ov do_exam cli
