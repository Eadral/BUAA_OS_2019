#include <asm/regdef.h>
#include <asm/cp0regdef.h>
#include <asm/asm.h>
#include <kcons.h>



.macro	setup_c0_status set clr
	.set	push
	mfc0	t0, CP0_STATUS
	or	t0, \set|\clr
	xor	t0, \clr
	mtc0	t0, CP0_STATUS			
	.set	pop
.endm

	.text
LEAF(set_cons)

setup_c0_status STATUSF_IP2 0
	jr ra

	nop
END(set_cons)
