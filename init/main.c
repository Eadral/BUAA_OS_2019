/*
 * Copyright (C) 2001 MontaVista Software Inc.
 * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 *
 */

#include <printf.h>
#include <pmap.h>

int main()
{
	printf("main.c:\tmain is start ...\n");
    
    int arr[] = {1, 23, -45, 67890};
    printf("%4#4a\n", arr);
    printf("%-4#4a\n", arr);
    printf("%04#4a\n", arr);

    printf("printf test...\n");
    
    //printf("%%\n" );
    //printf("%b %b\n", 123, -123); 
    //printf("%d %D\n", 123, -123);
    //printf("%o %O\n", 123, -123);
    //printf("%x %X\n", 123, -123);
    //printf("%c %c\n", 'x', '@');
    //printf("%s\n", "Hello World!");


    printf("printf test end.\n");
        

	mips_init();
	panic("main is over is error!");

	return 0;
}
