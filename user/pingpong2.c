#include "lib.h"

int x;

void umain()
{
	u_int who, i;
    i = 0; 
    x = 0;

	if ((who = fork()) != 0) {
		// get the ball rolling
		//user_panic("&&&&&&&&&&&&&&&&&&&&&&&&m");
	}

	for (;;) {
        x++;
		writef("x: %d\n", x);

		//user_panic("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
		if (i >= 10) {
			return;
		}

		i++;

		if (i >= 10) {
			return;
		}
	}
}
