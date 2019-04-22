#include <asm/asm.h>
#include <trap.h>

NESTED(ovov, 0, sp)

li t0, 0x7FFFFFFF
li t1, 0x7FFFFFFF
add t2, t0, t1
jr ra
nop

END(ovov)

