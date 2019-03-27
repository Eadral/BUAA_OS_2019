#ifndef __MEOW_H_
#define __MEOW_H_

void meow() {
    return;
}

#define PRINTX(X) printf("@%d: %x\n", __LINE__, X);
#define PRINTD(X) printf("@%d: %d\n", __LINE__, X);
#define STOP while(1);


#define MEOW_ON

#ifdef MEOW_ON
#define MEOW 
#else 
#define MEOW if (false)
#endif

#endif
