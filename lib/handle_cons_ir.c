#include <printf.h>

static int cnt = 0;
static char buffer[256];


void handle_cons_ir(char c, int status) {
    printf("cp0 status: %x\n", status); 
    if (c == '\r') {
        buffer[cnt] = '\0';
        printf("length: %d\n", cnt);
        printf("content: %s\n", buffer); 
        cnt = 0;
    } else {
        buffer[cnt++] = c;
    }
} 



