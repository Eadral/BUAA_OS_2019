#include <asm/regdef.h>
#include <asm/cp0regdef.h>
#include <asm/asm.h>

.data
sign: .space 4
dig1: .space 4
dig2: .space 4
flag: .space 4

.text

LEAF(calculator)

calculator:
    li s0, 0x90000000
    
    loop:
        lb s1, (s0)
        
        beqz s1, loop
        nop

        li t0, 81
        beq s1, t0, return 
        nop
            
        
        beq s1, 41, plus
        nop
        beq s1, 45, minus
        nop
        beq s1, 68, cd
        nop
        beq s1, 10, cpt
        nop

        j break
        nop

        plus:
            sw s1, sign
            sw zero, dig1
            sw zero, dig2
            li s7, 0
            j echo
            nop

        minus:
            sw s1, sign
            sw zero, dig1
            sw zero, dig2
            li s7, 0
            j echo
            nop
        cd:

            xor s7, s7, 1
            j echo
            nop
        cpt:
            li t0, 10
            sb t0, (s0)

            lw t0, dig1
            move s5, t0
            lw t1, dig2
            move s6, t1
            
            lw t7, sign
            bne t7, 45, not_minus
            nop
            subu t3, t0, t1
            j is_minus
            nop
            not_minus:
            addu t3, t0, t1
            is_minus:


            li t0, 10
            divu t3, t0
            mflo t3
            mfhi t1

            addu t1, t1, 48
            sb t1, (s0)
            
            ploop:
                beqz t3, ploop_end
                
                li t0, 10
                divu t3, t0
                mflo t3
                mfhi t1

                addu t1, t1, 48
                sb t1, (s0)

                j ploop
                nop
            ploop_end:
        
            
            j echo
            nop

        break:
            blt s1, 48, echo
            nop
            bgt s1, 57, echo
            nop
            bnez s7, c2
            nop
            c1:
                lw t5, dig1
                li t3, 10
                multu t5, t3
                mflo t0
                subu t1, s1, 48
                addu t0, t0, t1
                sw t0, dig1
                j echo
                nop
            c2:
                lw t5, dig2
                li t3, 10
                multu t5, t3
                mflo t0
                subu t1, s1, 48
                addu t0, t0, t1
                sw t0, dig2


        echo: sb s1, (s0)
            j loop
            nop


    return:
         
        quit:
            sw s1, 0x10(s0)
        jr ra
        nop


END(calculator)

