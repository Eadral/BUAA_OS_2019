#include "lib.h"
#include "print.h"

char ugetc() {
    u_int dev = 0x10000000;
    char c = 0;
    while (c == 0)
        syscall_read_dev(&c, dev, 1);
    syscall_write_dev(&c, dev, 1);
    return c;

}

void putc(char c) {
    u_int dev = 0x10000000;
    syscall_write_dev(&c, dev, 1);
    
}

void myoutput(void *arg, const char *s, int l)
{
	int i;

	// special termination call
	if ((l == 1) && (s[0] == '\0')) {
		return;
	}

	for (i = 0; i < l; i++) {
		putc(s[i]);

		if (s[i] == '\n') {
			putc('\n');
		}
	}
}
void uwritef(char *fmt, ...) {
    
	va_list ap;
	va_start(ap, fmt);
	user_lp_Print(myoutput, 0, fmt, ap);
	va_end(ap);
    
}


