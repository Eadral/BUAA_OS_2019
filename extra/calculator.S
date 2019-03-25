#include <asm/regdef.h>
#include <asm/cp0regdef.h>
#include <asm/asm.h>



.text

LEAF(calculator)

calculator:
    li s0, 0x90000000
    
    loop:
        lb s1, (s0)
        
        li t0, 81
        beq s1, t0, return 
        nop
            
        
        
        


        break:
        echo: sb s1, (s0)
            j loop
            nop


    return:
         
        quit:
            sw s1, 0x10(s0)
        jr ra
        nop


END(calculator)

