// Ping-pong a counter between two processes.
// Only need to start one of these -- splits into two with fork.

#include "lib.h"

void
umain(void)
{
    int f;
    // THIS IS pingpong2 
    
    writef("START!\n");

    f = get_checksum("/motd");

    struct Fd *fd;
    fd_lookup(f, &fd);

    struct Filefd * filefd = fd;

    writef("*********** check: %d\n", filefd->f_file.f_checksum);

}

