/*
 * operations on IDE disk.
 */

#include "fs.h"
#include "lib.h"
#include <mmu.h>

inline int write_dev(u_int v, u_int dev, u_int offset) {
    return syscall_write_dev(&v, dev+offset, 4);
}
inline int read_dev(u_int *v, u_int dev, u_int offset) {
    return syscall_read_dev(v, dev+offset, 4);
}
// Overview:
// 	read data from IDE disk. First issue a read request through
// 	disk register and then copy data from disk buffer
// 	(512 bytes, a sector) to destination array.
//
// Parameters:
//	diskno: disk number.
// 	secno: start sector number.
// 	dst: destination for data read from IDE disk.
// 	nsecs: the number of sectors to read.
//
// Post-Condition:
// 	If error occurred during read the IDE disk, panic. 
// 	
// Hint: use syscalls to access device registers and buffers

int read_sector(u_int diskno, u_int offset) {
    u_int dev = 0x13000000;
    write_dev(diskno, dev, 0x0010); // select the IDE id
    write_dev(offset, dev, 0x0000); // offset
    write_dev(0, dev, 0x0020);  // start read
    int r;
    read_dev(&r, dev, 0x0030);  // get status
    return r ? 0 : -1;
}
    
void
ide_read(u_int diskno, u_int secno, void *dst, u_int nsecs)
{
	// 0x200: the size of a sector: 512 bytes.
	int offset_begin = secno * 0x200;
	int offset_end = offset_begin + nsecs * 0x200;
	int offset = 0;
    int r = 0;
	while (offset_begin + offset < offset_end) {
            // Your code here
            // error occurred, then panic.
        r = read_sector(diskno, offset_begin + offset);
        if (r < 0) 
            user_panic("ide_read failed");
        syscall_read_dev(dst + offset, 0x13004000, 0x200);
        offset += 0x200;
	}
}


// Overview:
// 	write data to IDE disk.
//
// Parameters:
//	diskno: disk number.
//	secno: start sector number.
// 	src: the source data to write into IDE disk.
//	nsecs: the number of sectors to write.
//
// Post-Condition:
//	If error occurred during read the IDE disk, panic.
//	
// Hint: use syscalls to access device registers and buffers

int write_sector(u_int diskno, u_int offset) {
    u_int dev = 0x13000000;
    write_dev(diskno, dev, 0x0010); // select the IDE id
    write_dev(offset, dev, 0x0000); // offset
    write_dev(1, dev, 0x0020);  // write read
    int r;
    read_dev(&r, dev, 0x0030);  // get status
    return r ? 0 : -1;
}
    
void
ide_write(u_int diskno, u_int secno, void *src, u_int nsecs)
{
        // Your code here
	int offset_begin = secno * 0x200;
	int offset_end = offset_begin + nsecs * 0x200;
	int offset = 0;
	//writef("diskno: %d\n", diskno);
	int r = 0;
    while (offset_begin + offset < offset_end) {
	    // copy data from source array to disk buffer.
            // if error occur, then panic.
        syscall_write_dev(src + offset, 0x13004000, 0x200);
        r = write_sector(diskno, offset_begin + offset);
        if (r < 0) 
            user_panic("ide_write failed");
        offset += 0x200;
	}
}

