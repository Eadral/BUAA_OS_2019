#ifndef __MEOW_H_
#define __MEOW_H_


#define PRINTX(X) printf("@%d: %x\n", __LINE__, X);
#define PRINTD(X) printf("@%d: %d\n", __LINE__, X);


#define UDEBUG(x)               \
    do {                        \
        writef("!!! %s. @%s:%d\n", (x), __FILE__, __LINE__);  \
    } while(0)

#define ULOG(fmt, x)            \
    do {                        \
        writef("!!! ");         \
        writef(fmt, x);         \
        writef(". @%s:%d\n", __FILE__, __LINE__);  \
    } while(0)

#define DEBUG(x)               \
    do {                        \
        printf("!!! %s. @%s:%d\n", (x), __FILE__, __LINE__);  \
    } while(0)

#define LOG(fmt, x)            \
    do {                        \
        printf("!!! ");         \
        printf(fmt, x);         \
        printf(". @%s:%d\n", __FILE__, __LINE__);  \
    } while(0)


#define STOP()                  \
    do {                        \
        printf("MEOW!");        \
        while(1);               \
    } while(0)      

#define USTOP()                  \
    do {                        \
        writef("MEOW!");        \
        while(1);               \
    } while(0)      

#define ERR(x)                                                      \
    do {                                                            \
        if ((x) < 0) {                                              \
            panic("@%d: retrun %d\n", __LINE__, x);                 \
            return x;                                               \
        }                                                           \
    } while(0)                                                        


#define UERR(x)                                                      \
    do {                                                            \
        if ((x) < 0) {                                              \
            user_panic("@%d: retrun %d\n", __LINE__, x);                 \
            return x;                                               \
        }                                                           \
    } while(0)                                                        

#define ERRR(x)                                                      \
    do {                                                            \
        if ((x) < 0)                                                \
            return x;                                               \
    } while(0)                                                        

#endif
