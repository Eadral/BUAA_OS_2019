

all: obj
	gcc code/fibo.o code/main.o -o fibo


include code/Makefile



.PHONY: clean



clean:
	rm -r code/*.o
