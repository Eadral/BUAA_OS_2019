#include "lib.h"

int a[100000];
void umain()
{
        int b[10000];
        b[0]=8;
        a[0]=8;
        if(fork()==0){
                b[0]=7;
                a[0]=7;
                if(fork()==0){
                        b[0]=6;
                        a[0]=6;
                        if(fork()==0){
                                b[0]=5;
                                a[0]=5;
                                if(fork()==0){
                                        b[0]=4;
                                        a[0]=4;
                                        if(fork()==0){
                                                b[0]=3;
                                                a[0]=3;
                                                if(fork()==0){
                                                        b[0]=2;
                                                        a[0]=2;
                                                        if(fork()==0){
                                                                b[0]=1;
                                                                a[0]=1;
                                                        }
                                                }
                                        }
                                }
                        }

                }
        }
        int id=fork();
        if(id==0){
                b[1]=10;
                a[1]=20;
        }
        id=fork();
        if(id==0){
                b[2]=30;
                a[2]=40;
        }
	u_int who, i;

	if ((who = fork()) != 0) {
		// get the ball rolling
		writef("\n@@@@@send 0 from %x to %x\n", syscall_getenvid(), who);
		ipc_send(who, 0, 0, 0);
		//user_panic("&&&&&&&&&&&&&&&&&&&&&&&&m");
	}

	for (;;) {
		writef("%x am waiting.....\n", syscall_getenvid());
		i = ipc_recv(&who, 0, 0);

		writef("%x got %d from %x\n", syscall_getenvid(), i, who);

		//user_panic("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
		if (i == 10) {
			return;
		}

		i++;
		writef("\n@@@@@send %d from %x to %x\n",i, syscall_getenvid(), who);
		ipc_send(who, i, 0, 0);

		if (i == 10) {
			return;
		}
	}
        writef("0x%d,with a0:0x%d,b0:0x%d,a1:0x%d,b1:0x%d,a2:0x%d,b2:0x%d\n",syscall_getenvid(),a[0],b[0],a[1],b[1],a[2],b[2]);
}
