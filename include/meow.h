#ifndef __MEOW_H_
#define __MEOW_H_


#define PRINTX(X) printf("@%d: %x\n", __LINE__, X);
#define PRINTD(X) printf("@%d: %d\n", __LINE__, X);
#define STOP()                  \
    do {                        \
        printf("MEOW!");        \
        while(1);               \
    } while(0)      


#define ERR(x)                                                      \
    do {                                                            \
        if ((x) < 0) {                                              \
            panic("@%d: retrun %d\n", __LINE__, x);                 \
            return x;                                               \
        }                                                           \
    } while(0)                                                        



#define ERRR(x)                                                      \
    do {                                                            \
        if ((x) < 0)                                                \
            return x;                                               \
    } while(0)                                                        



#endif
