#include <printf.h>

void prt_exam(u_int instr, u_int rs, u_int rt) {
    printf("Instr: 0x%x\n", instr);
    printf("reg %d and reg %d\n", rs, rt);
}

