#include <asm/regdef.h>
#include <asm/cp0regdef.h>
#include <asm/asm.h>

NESTED(handle_ov)

SAVE_ALL
CLI

mfc0 t0, cp0_epc
move a2, t0
srl s0, t0, 21
and a0, s0, 0x1F
srl s1, t0, 16
and a1, s1, 0x1F
jal prt_r
nop



END(handle_ov)
