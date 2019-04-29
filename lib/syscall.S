#include <asm/regdef.h>
#include <asm/cp0regdef.h>
#include <asm/asm.h>
#include <stackframe.h>
#include <unistd.h>

NESTED(handle_sys,TF_SIZE, sp)
    SAVE_ALL                            // Macro used to save trapframe
    CLI                                 // Clean Interrupt Mask
    nop
    .set at                             // Resume use of $at

    // TODO: Fetch EPC from Trapframe, calculate a proper value and store it back to trapframe.
    lw      t0, TF_EPC(sp)
    addu    t0, 4
    sw      t0, TF_EPC(sp)
    // TODO: Copy the syscall number into $a0.
    lw      a0, TF_REG4(sp)

    addiu   a0, a0, -__SYSCALL_BASE     // a0 <- relative syscall number
    sll     t0, a0, 2                   // t0 <- relative syscall number times 4
    la      t1, sys_call_table          // t1 <- syscall table base
    addu    t1, t1, t0                  // t1 <- table entry of specific syscall
    lw      t7, 0(t1)                   // t2 <- function entry of specific syscall
    
    

    lw      t0, TF_REG29(sp)            // t0 <- user's stack pointer
    lw      t3, 16(t0)                  // t3 <- the 5th argument of msyscall
    
    //lw      t4, 20(t0)                  // t4 <- the 6th argument of msyscall
    //lw      t5, 24(t0)

    lw      a0, TF_REG4(sp)
    lw      t6, TF_REG5(sp)
    lw      a1, TF_REG6(sp)
    lw      a2, TF_REG7(sp)
    move    a3, t3
    
     
    addu s5, t6, 2
    sll s5, s5, 2
    subu    sp, sp, s5
    
    ble t6, 3, end_for
    nop
    addu t8, t6, 2
    nop
    li t1, 5 
    for:
    bge t1, t8, end_for
    nop
    
    sll t2, t1, 2
    addu t3, t2, t0
    lw t4, 0(t3)

    subu t2, t2, 4
    addu t3, t2, sp
    sw t4, 0(t3)
    
    addu t1, t1, 1
    j for
    nop
    end_for:
    
    //sw      t4, 16(sp)
    //sw      t5, 20(sp)
    
    jalr    t7                          // Invoke sys_* function
    nop
    
    // TODO: Resume current kernel stack
    addu    sp, sp, s5
    sw      v0, TF_REG2(sp)             // Store return value of function sys_* (in $v0) into trapframe

    j       ret_from_exception          // Return from exeception
    nop
END(handle_sys)

sys_call_table:                         // Syscall Table
.align 2
    .word sys_putchar
    .word sys_getenvid
    .word sys_yield
    .word sys_env_destroy
    .word sys_set_pgfault_handler
    .word sys_mem_alloc
    .word sys_mem_map
    .word sys_mem_unmap
    .word sys_env_alloc
    .word sys_set_env_status
    .word sys_set_trapframe
    .word sys_panic
    .word sys_ipc_can_send
    .word sys_ipc_recv
    .word sys_cgetc
    .word sys_smp
