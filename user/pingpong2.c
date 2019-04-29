// Ping-pong a counter between two processes.
// Only need to start one of these -- splits into two with fork.

#include "lib.h"

void
umain(void)
{
    writef("%d\n", syscall_super_multi_parameter(1, 2, 3, 4, 5, 6, 7, 8));
    // THIS IS pingpong2 
	u_int who, i;
    volatile u_int *x;
    u_int addr;

	if ((who = fork()) != 0) {
        // father
		// get the ball rolling
        addr = 0x50000000;
        //syscall_mem_alloc(0, addr, PTE_V | PTE_R);
        x = addr;
        *x = 0;
		ipc_send(who, i, addr, PTE_R);
		//user_panic("&&&&&&&&&&&&&&&&&&&&&&&&m");
	} else {
        // child
        addr = 0x50000000;
        //syscall_mem_alloc(0, addr, PTE_V | PTE_R);
        x = addr;
        *x = 0;
        ipc_recv(&who, addr, 0);

    }
    

	for (;;) {
        
        (*x)++;
        writef("%x add x. x now: %d\n", syscall_getenvid(), *x);

		if (*x >= 4) {
			return;
		}
	}

}

