// Ping-pong a counter between two processes.
// Only need to start one of these -- splits into two with fork.

#include "lib.h"

void
umain(void)
{
    int f;
    // THIS IS pingpong2 
    
    writef("START!\n");

    f = open("/motd", O_WRONLY);

    char s[] = "Meow!"; 
    write(f, s, strlen(s));


    close(f);
    

    f = open("/motd", O_RDONLY);

    char c;

    char s2[256];
    read(f, s2, 6);

    close(f);

    writef("o: %s\n", s2);


}

