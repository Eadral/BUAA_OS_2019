// Ping-pong a counter between two processes.
// Only need to start one of these -- splits into two with fork.

#include "lib.h"

void
umain(void)
{
    // THIS IS pingpong2 
    
    uwritef("what\n");
    
    while (1) {
        ugetc();
        //writef("@get\n");
    }

}

