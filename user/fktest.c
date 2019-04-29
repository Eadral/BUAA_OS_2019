#include "lib.h"


void umain()
{
    
    writef("%d\n", syscall_super_multi_parameter(1, 2, 3, 4, 5, 6, 7, 8));
    //USTOP();

	int a = 0;
	int id = 0;
    //writef("start");
	if ((id = fork()) == 0) {
		if ((id = fork()) == 0) {
			a += 3;

			for (;;) {
				writef("\t\tthis is child2 :a:%d\n", a);
			}
		}
        
		a += 2;

		for (;;) {
			writef("\tthis is child :a:%d\n", a);
		}
	}

	a++;

	for (;;) {
		writef("this is father: a:%d\n", a);
	}
}
