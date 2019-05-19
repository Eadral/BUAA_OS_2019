// Ping-pong a counter between two processes.
// Only need to start one of these -- splits into two with fork.

#include "lib.h"

void
umain(void)
{
    // THIS IS pingpong2 
    
    writef("START!\n");

    int f = open("/meow", O_WRONLY);

    char s[] = "Meow!"; 
    write(f, s, strlen(s));


    close(f);
    
    sync();

    f = open("/meow", O_RDONLY);

    char c;

    char s2[256];
    read(f, s2, strlen(s));

    close(f);

    writef("o: %s\n", s2);


}

