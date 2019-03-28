INCLUDES	:= -I./ -I../ -I../include/

%.o: %.c
	$(CC) $(CFLAGS) $(INCLUDES) -c $<

%.o: %.S
	$(CC) $(CFLAGS) $(INCLUDES) -c $<

%.ss: %.c
	$(CC) $(CFLAGS) $(INCLUDES) -c -g -Wa,-adlhn $< > $@
	# $(CC) $(CFLAGS) $(INCLUDES) -S $< 
	
.PHONY: clean

all: pmap.o tlb_asm.o pmap.ss

clean:
	rm -rf *~ *.o *.ss


include ../include.mk
