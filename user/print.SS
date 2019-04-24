   1              		.section .mdebug.abi32
   2              		.previous
  10              	$Ltext0:
  11              		.rdata
  12              		.align	2
  15              	user_theFatalMsg:
  16 0000 66617461 		.ascii	"fatal error in user_lp_Print!\000"
  16      6C206572 
  16      726F7220 
  16      696E2075 
  16      7365725F 
  17 001e 0000     		.align	2
  18              	$LC0:
  19 0020 0000     		.ascii	"\000\000"
  20              		.text
  21              		.align	2
  22              		.globl	user_lp_Print
  23              		.ent	user_lp_Print
  25              	user_lp_Print:
  26              	$LFB2:
  27              		.file 1 "print.c"
   1:print.c       **** /*
   2:print.c       ****  * Copyright (C) 2001 MontaVista Software Inc.
   3:print.c       ****  * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
   4:print.c       ****  *
   5:print.c       ****  * This program is free software; you can redistribute  it and/or modify it
   6:print.c       ****  * under  the terms of  the GNU General  Public License as published by the
   7:print.c       ****  * Free Software Foundation;  either version 2 of the  License, or (at your
   8:print.c       ****  * option) any later version.
   9:print.c       ****  *
  10:print.c       ****  */
  11:print.c       **** 
  12:print.c       **** #include	<print.h>
  13:print.c       **** 
  14:print.c       **** /* macros */
  15:print.c       **** #define		IsDigit(x)	( ((x) >= '0') && ((x) <= '9') )
  16:print.c       **** #define		Ctod(x)		( (x) - '0')
  17:print.c       **** 
  18:print.c       **** /* forward declaration */
  19:print.c       **** extern int user_PrintChar(char *, char, int, int);
  20:print.c       **** extern int user_PrintString(char *, char *, int, int);
  21:print.c       **** extern int user_PrintNum(char *, unsigned long, int, int, int, int, char, int);
  22:print.c       **** 
  23:print.c       **** /* private variable */
  24:print.c       **** static const char user_theFatalMsg[] = "fatal error in user_lp_Print!";
  25:print.c       **** 
  26:print.c       **** /* -*-
  27:print.c       ****  * A low level printf() function.
  28:print.c       ****  */
  29:print.c       **** void
  30:print.c       **** user_lp_Print(void (*output)(void *, const char *, int),
  31:print.c       **** 			  void *arg,
  32:print.c       **** 			  const char *fmt,
  33:print.c       **** 			  va_list ap)
  34:print.c       **** {
  28              		.loc 1 34 0
  29              		.frame	$sp,1064,$31		# vars= 1000, regs= 7/0, args= 32, gp= 0
  30              		.mask	0x803f0000,-8
  31              		.fmask	0x00000000,0
  32              		.set	noreorder
  33              		.set	nomacro
  34              		
  35              	$LVL0:
  36 0000 27BDFBD8 		addiu	$sp,$sp,-1064
  37              	$LCFI0:
  38              	$LVL1:
  39 0004 AFBF0420 		sw	$31,1056($sp)
  40              	$LCFI1:
  41 0008 AFB5041C 		sw	$21,1052($sp)
  42              	$LCFI2:
  43 000c AFB40418 		sw	$20,1048($sp)
  44              	$LCFI3:
  45 0010 AFB30414 		sw	$19,1044($sp)
  46              	$LCFI4:
  47 0014 AFB20410 		sw	$18,1040($sp)
  48              	$LCFI5:
  49 0018 AFB1040C 		sw	$17,1036($sp)
  50              	$LCFI6:
  51 001c AFB00408 		sw	$16,1032($sp)
  52              	$LCFI7:
  53 0020 0080A821 		move	$21,$4
  54 0024 00A09021 		move	$18,$5
  55 0028 00C02821 		move	$5,$6
  56              	$LVL2:
  57 002c 00E09821 		move	$19,$7
  58              	$LVL3:
  59              	$L3:
  60              	$LBB2:
  35:print.c       **** 
  36:print.c       **** #define 	OUTPUT(arg, s, l)  \
  37:print.c       **** { if (((l) < 0) || ((l) > LP_MAX_BUF)) { \
  38:print.c       **** 			(*output)(arg, (char*)user_theFatalMsg, sizeof(user_theFatalMsg)-1); for(;;); \
  39:print.c       **** 		} else { \
  40:print.c       **** 			(*output)(arg, s, l); arg+=l;\
  41:print.c       **** 		} \
  42:print.c       **** 	}
  43:print.c       **** 
  44:print.c       **** 	char buf[LP_MAX_BUF];
  45:print.c       **** 
  46:print.c       **** 	char c;
  47:print.c       **** 	char *s;
  48:print.c       **** 	long int num;
  49:print.c       **** 
  50:print.c       **** 	int longFlag;
  51:print.c       **** 	int negFlag;
  52:print.c       **** 	int width;
  53:print.c       **** 	int prec;
  54:print.c       **** 	int ladjust;
  55:print.c       **** 	char padc;
  56:print.c       **** 
  57:print.c       **** 	int length;
  58:print.c       **** 
  59:print.c       **** 	for (;;) {
  60:print.c       **** 		{
  61:print.c       **** 			/* scan for the next '%' */
  62:print.c       **** 			const char *fmtStart = fmt;
  63:print.c       **** 
  64:print.c       **** 			while ( (*fmt != '\0') && (*fmt != '%')) {
  61              		.loc 1 64 0
  62 0030 80A30000 		lb	$3,0($5)
  63 0034 1060000C 		beq	$3,$0,$L4
  64 0038 00A08021 		move	$16,$5
  65              	
  66 003c 10000156 		b	$L93
  67 0040 24020025 		li	$2,37			# 0x25
  68              	
  69              	$L6:
  70 0044 00A08021 		move	$16,$5
  65:print.c       **** 				fmt ++;
  71              		.loc 1 65 0
  72 0048 26100001 		addiu	$16,$16,1
  73              	$L94:
  74              		.loc 1 64 0
  75 004c 82020000 		lb	$2,0($16)
  66:print.c       **** 			}
  67:print.c       **** 
  68:print.c       **** 			/* flush the string found so far */
  69:print.c       **** 			OUTPUT(arg, fmtStart, fmt - fmtStart);
  76              		.loc 1 69 0
  77              		.loc 1 64 0
  78 0050 10400006 		beq	$2,$0,$L95
  79 0054 02058823 		subu	$17,$16,$5
  80              	
  81              		.loc 1 69 0
  82              		.loc 1 64 0
  83 0058 10430005 		beq	$2,$3,$L96
  84 005c 2E2203E9 		sltu	$2,$17,1001
  85              	
  86              		.loc 1 65 0
  87 0060 1000FFFA 		b	$L94
  88 0064 26100001 		addiu	$16,$16,1
  89              	
  90              	$L4:
  91              	$L8:
  92              		.loc 1 69 0
  93 0068 02058823 		subu	$17,$16,$5
  94              	$LVL4:
  95              	$L95:
  96 006c 2E2203E9 		sltu	$2,$17,1001
  97              	$L96:
  98 0070 14400008 		bne	$2,$0,$L10
  99 0074 02203021 		move	$6,$17
 100              	
 101 0078 02402021 		move	$4,$18
 102              	$LVL5:
 103 007c 3C050000 		lui	$5,%hi(user_theFatalMsg)
 104              	$LVL6:
 105 0080 24A50000 		addiu	$5,$5,%lo(user_theFatalMsg)
 106 0084 02A0F809 		jal	$21
 107 0088 2406001D 		li	$6,29			# 0x1d
 108              	
 109              	$LVL7:
 110              	$L12:
 111 008c 1000FFFF 		b	$L12
 112 0090 00000000 		nop
 113              	
 114              	$LVL8:
 115              	$L10:
 116              	$LVL9:
 117 0094 02A0F809 		jal	$21
 118 0098 02402021 		move	$4,$18
 119              	
 120              	$LVL10:
  70:print.c       **** 
  71:print.c       **** 			/* are we hitting the end? */
  72:print.c       **** 			if (*fmt == '\0') {
 121              		.loc 1 72 0
 122 009c 82020000 		lb	$2,0($16)
 123              		.loc 1 69 0
 124              		.loc 1 72 0
 125 00a0 1040012F 		beq	$2,$0,$L13
 126 00a4 02519021 		addu	$18,$18,$17
 127              	
 128              	$LVL11:
 129              	$LBE2:
  73:print.c       **** 				break;
  74:print.c       **** 			}
  75:print.c       **** 		}
  76:print.c       **** 
  77:print.c       **** 		/* we found a '%' */
  78:print.c       **** 		fmt ++;
  79:print.c       **** 
  80:print.c       **** 		/* check for long */
  81:print.c       **** 		if (*fmt == 'l') {
 130              		.loc 1 81 0
 131 00a8 82030001 		lb	$3,1($16)
 132 00ac 2402006C 		li	$2,108			# 0x6c
 133              		.loc 1 78 0
 134              		.loc 1 81 0
 135 00b0 10620003 		beq	$3,$2,$L15
 136 00b4 26110001 		addiu	$17,$16,1
 137              	
 138              	$LVL12:
 139 00b8 10000003 		b	$L17
 140 00bc 00002021 		move	$4,$0
 141              	
 142              	$LVL13:
 143              	$L15:
  82:print.c       **** 			longFlag = 1;
  83:print.c       **** 			fmt ++;
 144              		.loc 1 83 0
 145 00c0 26110002 		addiu	$17,$16,2
 146 00c4 24040001 		li	$4,1			# 0x1
 147              	$LVL14:
 148              	$L17:
  84:print.c       **** 		} else {
  85:print.c       **** 			longFlag = 0;
  86:print.c       **** 		}
  87:print.c       **** 
  88:print.c       **** 		/* check for other prefixes */
  89:print.c       **** 		width = 0;
  90:print.c       **** 		prec = -1;
  91:print.c       **** 		ladjust = 0;
  92:print.c       **** 		padc = ' ';
  93:print.c       **** 
  94:print.c       **** 		if (*fmt == '-') {
 149              		.loc 1 94 0
 150 00c8 82230000 		lb	$3,0($17)
 151 00cc 2402002D 		li	$2,45			# 0x2d
 152 00d0 14620004 		bne	$3,$2,$L99
 153 00d4 00003821 		move	$7,$0
 154              	
 155              	$LVL15:
  95:print.c       **** 			ladjust = 1;
  96:print.c       **** 			fmt ++;
 156              		.loc 1 96 0
 157 00d8 26310001 		addiu	$17,$17,1
 158 00dc 24070001 		li	$7,1			# 0x1
 159              	$LVL16:
  97:print.c       **** 		}
  98:print.c       **** 
  99:print.c       **** 		if (*fmt == '0') {
 160              		.loc 1 99 0
 161 00e0 82230000 		lb	$3,0($17)
 162              	$L99:
 163 00e4 24020030 		li	$2,48			# 0x30
 164 00e8 14620003 		bne	$3,$2,$L23
 165 00ec 24090020 		li	$9,32			# 0x20
 166              	
 167              	$LVL17:
 100:print.c       **** 			padc = '0';
 101:print.c       **** 			fmt++;
 168              		.loc 1 101 0
 169 00f0 26310001 		addiu	$17,$17,1
 170 00f4 24090030 		li	$9,48			# 0x30
 171              	$LVL18:
 172              	$L23:
 102:print.c       **** 		}
 103:print.c       **** 
 104:print.c       **** 		if (IsDigit(*fmt)) {
 173              		.loc 1 104 0
 174 00f8 82260000 		lb	$6,0($17)
 175 00fc 24C2FFD0 		addiu	$2,$6,-48
 176 0100 304200FF 		andi	$2,$2,0x00ff
 177 0104 2C42000A 		sltu	$2,$2,10
 178 0108 1040000D 		beq	$2,$0,$L26
 179 010c 00004021 		move	$8,$0
 180              	
 181              	$LVL19:
 182              	$LVL20:
 105:print.c       **** 			while (IsDigit(*fmt)) {
 106:print.c       **** 				width = 10 * width + Ctod(*fmt++);
 183              		.loc 1 106 0
 184 0110 00081040 		sll	$2,$8,1
 185              	$L97:
 186 0114 000818C0 		sll	$3,$8,3
 187 0118 00431021 		addu	$2,$2,$3
 188 011c 00461021 		addu	$2,$2,$6
 189 0120 2448FFD0 		addiu	$8,$2,-48
 190 0124 26310001 		addiu	$17,$17,1
 191              		.loc 1 105 0
 192 0128 82260000 		lb	$6,0($17)
 193 012c 24C2FFD0 		addiu	$2,$6,-48
 194 0130 304200FF 		andi	$2,$2,0x00ff
 195 0134 2C42000A 		sltu	$2,$2,10
 196              		.loc 1 106 0
 197              		.loc 1 105 0
 198 0138 1440FFF6 		bne	$2,$0,$L97
 199 013c 00081040 		sll	$2,$8,1
 200              	
 201              	$L26:
 107:print.c       **** 			}
 108:print.c       **** 		}
 109:print.c       **** 
 110:print.c       **** 		if (*fmt == '.') {
 202              		.loc 1 110 0
 203 0140 82230000 		lb	$3,0($17)
 204 0144 2402002E 		li	$2,46			# 0x2e
 111:print.c       **** 			fmt ++;
 112:print.c       **** 
 113:print.c       **** 			if (IsDigit(*fmt)) {
 114:print.c       **** 				prec = 0;
 115:print.c       **** 
 116:print.c       **** 				while (IsDigit(*fmt)) {
 117:print.c       **** 					prec = prec * 10 + Ctod(*fmt++);
 118:print.c       **** 				}
 119:print.c       **** 			}
 120:print.c       **** 		}
 121:print.c       **** 
 122:print.c       **** 
 123:print.c       **** 		/* check format flag */
 124:print.c       **** 		negFlag = 0;
 125:print.c       **** 
 126:print.c       **** 		switch (*fmt) {
 205              		.loc 1 126 0
 206              		.loc 1 110 0
 207 0148 14620011 		bne	$3,$2,$L98
 208 014c 2C620079 		sltu	$2,$3,121
 209              	
 210              		.loc 1 111 0
 211 0150 26310001 		addiu	$17,$17,1
 212              		.loc 1 113 0
 213 0154 92220000 		lbu	$2,0($17)
 214 0158 2442FFD0 		addiu	$2,$2,-48
 215 015c 304200FF 		andi	$2,$2,0x00ff
 216 0160 2C42000A 		sltu	$2,$2,10
 217 0164 10400008 		beq	$2,$0,$L28
 218 0168 00000000 		nop
 219              	
 220              	$L89:
 221              		.loc 1 117 0
 222 016c 26310001 		addiu	$17,$17,1
 223              		.loc 1 116 0
 224 0170 92220000 		lbu	$2,0($17)
 225 0174 2442FFD0 		addiu	$2,$2,-48
 226 0178 304200FF 		andi	$2,$2,0x00ff
 227 017c 2C42000A 		sltu	$2,$2,10
 228 0180 1440FFFA 		bne	$2,$0,$L89
 229 0184 00000000 		nop
 230              	
 231              	$L28:
 232              		.loc 1 126 0
 233 0188 82230000 		lb	$3,0($17)
 234 018c 2C620079 		sltu	$2,$3,121
 235              	$L98:
 236 0190 104000EC 		beq	$2,$0,$L31
 237 0194 00031080 		sll	$2,$3,2
 238              	
 239 0198 3C030000 		lui	$3,%hi($L41)
 240 019c 24630024 		addiu	$3,$3,%lo($L41)
 241 01a0 00431021 		addu	$2,$2,$3
 242 01a4 8C420000 		lw	$2,0($2)
 243 01a8 00400008 		j	$2
 244 01ac 00000000 		nop
 245              	
 246              		.rdata
 247 0022 0000     		.align	2
 248              		.align	2
 249              	$L41:
 250 0024 0000053C 		.word	$L32
 251 0028 00000544 		.word	$L31
 252 002c 00000544 		.word	$L31
 253 0030 00000544 		.word	$L31
 254 0034 00000544 		.word	$L31
 255 0038 00000544 		.word	$L31
 256 003c 00000544 		.word	$L31
 257 0040 00000544 		.word	$L31
 258 0044 00000544 		.word	$L31
 259 0048 00000544 		.word	$L31
 260 004c 00000544 		.word	$L31
 261 0050 00000544 		.word	$L31
 262 0054 00000544 		.word	$L31
 263 0058 00000544 		.word	$L31
 264 005c 00000544 		.word	$L31
 265 0060 00000544 		.word	$L31
 266 0064 00000544 		.word	$L31
 267 0068 00000544 		.word	$L31
 268 006c 00000544 		.word	$L31
 269 0070 00000544 		.word	$L31
 270 0074 00000544 		.word	$L31
 271 0078 00000544 		.word	$L31
 272 007c 00000544 		.word	$L31
 273 0080 00000544 		.word	$L31
 274 0084 00000544 		.word	$L31
 275 0088 00000544 		.word	$L31
 276 008c 00000544 		.word	$L31
 277 0090 00000544 		.word	$L31
 278 0094 00000544 		.word	$L31
 279 0098 00000544 		.word	$L31
 280 009c 00000544 		.word	$L31
 281 00a0 00000544 		.word	$L31
 282 00a4 00000544 		.word	$L31
 283 00a8 00000544 		.word	$L31
 284 00ac 00000544 		.word	$L31
 285 00b0 00000544 		.word	$L31
 286 00b4 00000544 		.word	$L31
 287 00b8 00000544 		.word	$L31
 288 00bc 00000544 		.word	$L31
 289 00c0 00000544 		.word	$L31
 290 00c4 00000544 		.word	$L31
 291 00c8 00000544 		.word	$L31
 292 00cc 00000544 		.word	$L31
 293 00d0 00000544 		.word	$L31
 294 00d4 00000544 		.word	$L31
 295 00d8 00000544 		.word	$L31
 296 00dc 00000544 		.word	$L31
 297 00e0 00000544 		.word	$L31
 298 00e4 00000544 		.word	$L31
 299 00e8 00000544 		.word	$L31
 300 00ec 00000544 		.word	$L31
 301 00f0 00000544 		.word	$L31
 302 00f4 00000544 		.word	$L31
 303 00f8 00000544 		.word	$L31
 304 00fc 00000544 		.word	$L31
 305 0100 00000544 		.word	$L31
 306 0104 00000544 		.word	$L31
 307 0108 00000544 		.word	$L31
 308 010c 00000544 		.word	$L31
 309 0110 00000544 		.word	$L31
 310 0114 00000544 		.word	$L31
 311 0118 00000544 		.word	$L31
 312 011c 00000544 		.word	$L31
 313 0120 00000544 		.word	$L31
 314 0124 00000544 		.word	$L31
 315 0128 00000544 		.word	$L31
 316 012c 00000544 		.word	$L31
 317 0130 00000544 		.word	$L31
 318 0134 00000228 		.word	$L33
 319 0138 00000544 		.word	$L31
 320 013c 00000544 		.word	$L31
 321 0140 00000544 		.word	$L31
 322 0144 00000544 		.word	$L31
 323 0148 00000544 		.word	$L31
 324 014c 00000544 		.word	$L31
 325 0150 00000544 		.word	$L31
 326 0154 00000544 		.word	$L31
 327 0158 00000544 		.word	$L31
 328 015c 00000544 		.word	$L31
 329 0160 000002B0 		.word	$L34
 330 0164 00000544 		.word	$L31
 331 0168 00000544 		.word	$L31
 332 016c 00000544 		.word	$L31
 333 0170 00000544 		.word	$L31
 334 0174 00000544 		.word	$L31
 335 0178 00000328 		.word	$L35
 336 017c 00000544 		.word	$L31
 337 0180 00000544 		.word	$L31
 338 0184 00000418 		.word	$L36
 339 0188 00000544 		.word	$L31
 340 018c 00000544 		.word	$L31
 341 0190 00000544 		.word	$L31
 342 0194 00000544 		.word	$L31
 343 0198 00000544 		.word	$L31
 344 019c 00000544 		.word	$L31
 345 01a0 00000544 		.word	$L31
 346 01a4 00000544 		.word	$L31
 347 01a8 00000544 		.word	$L31
 348 01ac 000001B0 		.word	$L37
 349 01b0 00000494 		.word	$L38
 350 01b4 00000228 		.word	$L33
 351 01b8 00000544 		.word	$L31
 352 01bc 00000544 		.word	$L31
 353 01c0 00000544 		.word	$L31
 354 01c4 00000544 		.word	$L31
 355 01c8 00000544 		.word	$L31
 356 01cc 00000544 		.word	$L31
 357 01d0 00000544 		.word	$L31
 358 01d4 00000544 		.word	$L31
 359 01d8 00000544 		.word	$L31
 360 01dc 00000544 		.word	$L31
 361 01e0 000002B0 		.word	$L34
 362 01e4 00000544 		.word	$L31
 363 01e8 00000544 		.word	$L31
 364 01ec 00000544 		.word	$L31
 365 01f0 000004E8 		.word	$L39
 366 01f4 00000544 		.word	$L31
 367 01f8 00000328 		.word	$L35
 368 01fc 00000544 		.word	$L31
 369 0200 00000544 		.word	$L31
 370 0204 000003A0 		.word	$L40
 371 0208 00000000 		.text
 371      00000000 
 372              	$L37:
 127:print.c       **** 			case 'b':
 128:print.c       **** 				if (longFlag) {
 373              		.loc 1 128 0
 374 01b0 10800004 		beq	$4,$0,$L42
 375 01b4 00000000 		nop
 376              	
 129:print.c       **** 					num = va_arg(ap, long int);
 377              		.loc 1 129 0
 378 01b8 8E650000 		lw	$5,0($19)
 379              	$LVL21:
 380 01bc 10000003 		b	$L44
 381 01c0 26730004 		addiu	$19,$19,4
 382              	
 383              	$LVL22:
 384              	$L42:
 130:print.c       **** 				} else {
 131:print.c       **** 					num = va_arg(ap, int);
 385              		.loc 1 131 0
 386 01c4 8E650000 		lw	$5,0($19)
 387              	$LVL23:
 388 01c8 26730004 		addiu	$19,$19,4
 389              	$L44:
 132:print.c       **** 				}
 133:print.c       **** 
 134:print.c       **** 				length = user_PrintNum(buf, num, 2, 0, width, ladjust, padc, 0);
 390              		.loc 1 134 0
 391 01cc AFA80010 		sw	$8,16($sp)
 392 01d0 AFA70014 		sw	$7,20($sp)
 393 01d4 AFA90018 		sw	$9,24($sp)
 394 01d8 AFA0001C 		sw	$0,28($sp)
 395 01dc 27A40020 		addiu	$4,$sp,32
 396              	$LVL24:
 397 01e0 24060002 		li	$6,2			# 0x2
 398              	$LVL25:
 399 01e4 0C000000 		jal	user_PrintNum
 400 01e8 00003821 		move	$7,$0
 401              	
 402              	$LVL26:
 403 01ec 00408021 		move	$16,$2
 404              	$LVL27:
 135:print.c       **** 				OUTPUT(arg, buf, length);
 405              		.loc 1 135 0
 406 01f0 00403021 		move	$6,$2
 407              	$LVL28:
 408 01f4 2C4203E9 		sltu	$2,$2,1001
 409 01f8 14400007 		bne	$2,$0,$L45
 410 01fc 02402021 		move	$4,$18
 411              	
 412 0200 3C050000 		lui	$5,%hi(user_theFatalMsg)
 413 0204 24A50000 		addiu	$5,$5,%lo(user_theFatalMsg)
 414              	$LVL29:
 415 0208 02A0F809 		jal	$21
 416 020c 2406001D 		li	$6,29			# 0x1d
 417              	
 418              	$L47:
 419 0210 1000FFFF 		b	$L47
 420 0214 00000000 		nop
 421              	
 422              	$LVL30:
 423              	$L45:
 424 0218 02A0F809 		jal	$21
 425 021c 27A50020 		addiu	$5,$sp,32
 426              	
 427              	$LVL31:
 428 0220 100000CD 		b	$L48
 429 0224 02509021 		addu	$18,$18,$16
 430              	
 431              	$LVL32:
 432              	$L33:
 136:print.c       **** 				break;
 137:print.c       **** 
 138:print.c       **** 			case 'd':
 139:print.c       **** 			case 'D':
 140:print.c       **** 				if (longFlag) {
 433              		.loc 1 140 0
 434 0228 10800004 		beq	$4,$0,$L49
 435 022c 00000000 		nop
 436              	
 141:print.c       **** 					num = va_arg(ap, long int);
 437              		.loc 1 141 0
 438 0230 8E650000 		lw	$5,0($19)
 439              	$LVL33:
 440 0234 10000003 		b	$L51
 441 0238 26730004 		addiu	$19,$19,4
 442              	
 443              	$LVL34:
 444              	$L49:
 142:print.c       **** 				} else {
 143:print.c       **** 					num = va_arg(ap, int);
 445              		.loc 1 143 0
 446 023c 8E650000 		lw	$5,0($19)
 447              	$LVL35:
 448 0240 26730004 		addiu	$19,$19,4
 449              	$L51:
 144:print.c       **** 				}
 145:print.c       **** 
 146:print.c       **** 				if (num < 0) {
 450              		.loc 1 146 0
 451 0244 04A10003 		bgez	$5,$L54
 452 0248 00001021 		move	$2,$0
 453              	
 454              	$LVL36:
 147:print.c       **** 					num = - num;
 455              		.loc 1 147 0
 456 024c 00052823 		subu	$5,$0,$5
 457 0250 24020001 		li	$2,1			# 0x1
 458              	$LVL37:
 459              	$L54:
 148:print.c       **** 					negFlag = 1;
 149:print.c       **** 				}
 150:print.c       **** 
 151:print.c       **** 				length = user_PrintNum(buf, num, 10, negFlag, width, ladjust, padc, 0);
 460              		.loc 1 151 0
 461 0254 AFA80010 		sw	$8,16($sp)
 462 0258 AFA70014 		sw	$7,20($sp)
 463 025c AFA90018 		sw	$9,24($sp)
 464 0260 AFA0001C 		sw	$0,28($sp)
 465 0264 27A40020 		addiu	$4,$sp,32
 466              	$LVL38:
 467 0268 2406000A 		li	$6,10			# 0xa
 468              	$LVL39:
 469 026c 0C000000 		jal	user_PrintNum
 470 0270 00403821 		move	$7,$2
 471              	
 472              	$LVL40:
 473 0274 00408021 		move	$16,$2
 474              	$LVL41:
 152:print.c       **** 				OUTPUT(arg, buf, length);
 475              		.loc 1 152 0
 476 0278 00403021 		move	$6,$2
 477              	$LVL42:
 478 027c 2C4203E9 		sltu	$2,$2,1001
 479 0280 14400007 		bne	$2,$0,$L55
 480 0284 02402021 		move	$4,$18
 481              	
 482 0288 3C050000 		lui	$5,%hi(user_theFatalMsg)
 483 028c 24A50000 		addiu	$5,$5,%lo(user_theFatalMsg)
 484              	$LVL43:
 485 0290 02A0F809 		jal	$21
 486 0294 2406001D 		li	$6,29			# 0x1d
 487              	
 488              	$L57:
 489 0298 1000FFFF 		b	$L57
 490 029c 00000000 		nop
 491              	
 492              	$LVL44:
 493              	$L55:
 494 02a0 02A0F809 		jal	$21
 495 02a4 27A50020 		addiu	$5,$sp,32
 496              	
 497              	$LVL45:
 498 02a8 100000AB 		b	$L48
 499 02ac 02509021 		addu	$18,$18,$16
 500              	
 501              	$LVL46:
 502              	$L34:
 153:print.c       **** 				break;
 154:print.c       **** 
 155:print.c       **** 			case 'o':
 156:print.c       **** 			case 'O':
 157:print.c       **** 				if (longFlag) {
 503              		.loc 1 157 0
 504 02b0 10800004 		beq	$4,$0,$L58
 505 02b4 00000000 		nop
 506              	
 158:print.c       **** 					num = va_arg(ap, long int);
 507              		.loc 1 158 0
 508 02b8 8E650000 		lw	$5,0($19)
 509              	$LVL47:
 510 02bc 10000003 		b	$L60
 511 02c0 26730004 		addiu	$19,$19,4
 512              	
 513              	$LVL48:
 514              	$L58:
 159:print.c       **** 				} else {
 160:print.c       **** 					num = va_arg(ap, int);
 515              		.loc 1 160 0
 516 02c4 8E650000 		lw	$5,0($19)
 517              	$LVL49:
 518 02c8 26730004 		addiu	$19,$19,4
 519              	$L60:
 161:print.c       **** 				}
 162:print.c       **** 
 163:print.c       **** 				length = user_PrintNum(buf, num, 8, 0, width, ladjust, padc, 0);
 520              		.loc 1 163 0
 521 02cc AFA80010 		sw	$8,16($sp)
 522 02d0 AFA70014 		sw	$7,20($sp)
 523 02d4 AFA90018 		sw	$9,24($sp)
 524 02d8 AFA0001C 		sw	$0,28($sp)
 525 02dc 27A40020 		addiu	$4,$sp,32
 526              	$LVL50:
 527 02e0 24060008 		li	$6,8			# 0x8
 528              	$LVL51:
 529 02e4 0C000000 		jal	user_PrintNum
 530 02e8 00003821 		move	$7,$0
 531              	
 532              	$LVL52:
 533 02ec 00408021 		move	$16,$2
 534              	$LVL53:
 164:print.c       **** 				OUTPUT(arg, buf, length);
 535              		.loc 1 164 0
 536 02f0 00403021 		move	$6,$2
 537              	$LVL54:
 538 02f4 2C4203E9 		sltu	$2,$2,1001
 539 02f8 14400007 		bne	$2,$0,$L61
 540 02fc 02402021 		move	$4,$18
 541              	
 542 0300 3C050000 		lui	$5,%hi(user_theFatalMsg)
 543 0304 24A50000 		addiu	$5,$5,%lo(user_theFatalMsg)
 544              	$LVL55:
 545 0308 02A0F809 		jal	$21
 546 030c 2406001D 		li	$6,29			# 0x1d
 547              	
 548              	$L63:
 549 0310 1000FFFF 		b	$L63
 550 0314 00000000 		nop
 551              	
 552              	$LVL56:
 553              	$L61:
 554 0318 02A0F809 		jal	$21
 555 031c 27A50020 		addiu	$5,$sp,32
 556              	
 557              	$LVL57:
 558 0320 1000008D 		b	$L48
 559 0324 02509021 		addu	$18,$18,$16
 560              	
 561              	$LVL58:
 562              	$L35:
 165:print.c       **** 				break;
 166:print.c       **** 
 167:print.c       **** 			case 'u':
 168:print.c       **** 			case 'U':
 169:print.c       **** 				if (longFlag) {
 563              		.loc 1 169 0
 564 0328 10800004 		beq	$4,$0,$L64
 565 032c 00000000 		nop
 566              	
 170:print.c       **** 					num = va_arg(ap, long int);
 567              		.loc 1 170 0
 568 0330 8E650000 		lw	$5,0($19)
 569              	$LVL59:
 570 0334 10000003 		b	$L66
 571 0338 26730004 		addiu	$19,$19,4
 572              	
 573              	$LVL60:
 574              	$L64:
 171:print.c       **** 				} else {
 172:print.c       **** 					num = va_arg(ap, int);
 575              		.loc 1 172 0
 576 033c 8E650000 		lw	$5,0($19)
 577              	$LVL61:
 578 0340 26730004 		addiu	$19,$19,4
 579              	$L66:
 173:print.c       **** 				}
 174:print.c       **** 
 175:print.c       **** 				length = user_PrintNum(buf, num, 10, 0, width, ladjust, padc, 0);
 580              		.loc 1 175 0
 581 0344 AFA80010 		sw	$8,16($sp)
 582 0348 AFA70014 		sw	$7,20($sp)
 583 034c AFA90018 		sw	$9,24($sp)
 584 0350 AFA0001C 		sw	$0,28($sp)
 585 0354 27A40020 		addiu	$4,$sp,32
 586              	$LVL62:
 587 0358 2406000A 		li	$6,10			# 0xa
 588              	$LVL63:
 589 035c 0C000000 		jal	user_PrintNum
 590 0360 00003821 		move	$7,$0
 591              	
 592              	$LVL64:
 593 0364 00408021 		move	$16,$2
 594              	$LVL65:
 176:print.c       **** 				OUTPUT(arg, buf, length);
 595              		.loc 1 176 0
 596 0368 00403021 		move	$6,$2
 597              	$LVL66:
 598 036c 2C4203E9 		sltu	$2,$2,1001
 599 0370 14400007 		bne	$2,$0,$L67
 600 0374 02402021 		move	$4,$18
 601              	
 602 0378 3C050000 		lui	$5,%hi(user_theFatalMsg)
 603 037c 24A50000 		addiu	$5,$5,%lo(user_theFatalMsg)
 604              	$LVL67:
 605 0380 02A0F809 		jal	$21
 606 0384 2406001D 		li	$6,29			# 0x1d
 607              	
 608              	$L69:
 609 0388 1000FFFF 		b	$L69
 610 038c 00000000 		nop
 611              	
 612              	$LVL68:
 613              	$L67:
 614 0390 02A0F809 		jal	$21
 615 0394 27A50020 		addiu	$5,$sp,32
 616              	
 617              	$LVL69:
 618 0398 1000006F 		b	$L48
 619 039c 02509021 		addu	$18,$18,$16
 620              	
 621              	$LVL70:
 622              	$L40:
 177:print.c       **** 				break;
 178:print.c       **** 
 179:print.c       **** 			case 'x':
 180:print.c       **** 				if (longFlag) {
 623              		.loc 1 180 0
 624 03a0 10800004 		beq	$4,$0,$L70
 625 03a4 00000000 		nop
 626              	
 181:print.c       **** 					num = va_arg(ap, long int);
 627              		.loc 1 181 0
 628 03a8 8E650000 		lw	$5,0($19)
 629              	$LVL71:
 630 03ac 10000003 		b	$L72
 631 03b0 26730004 		addiu	$19,$19,4
 632              	
 633              	$LVL72:
 634              	$L70:
 182:print.c       **** 				} else {
 183:print.c       **** 					num = va_arg(ap, int);
 635              		.loc 1 183 0
 636 03b4 8E650000 		lw	$5,0($19)
 637              	$LVL73:
 638 03b8 26730004 		addiu	$19,$19,4
 639              	$L72:
 184:print.c       **** 				}
 185:print.c       **** 
 186:print.c       **** 				length = user_PrintNum(buf, num, 16, 0, width, ladjust, padc, 0);
 640              		.loc 1 186 0
 641 03bc AFA80010 		sw	$8,16($sp)
 642 03c0 AFA70014 		sw	$7,20($sp)
 643 03c4 AFA90018 		sw	$9,24($sp)
 644 03c8 AFA0001C 		sw	$0,28($sp)
 645 03cc 27A40020 		addiu	$4,$sp,32
 646              	$LVL74:
 647 03d0 24060010 		li	$6,16			# 0x10
 648              	$LVL75:
 649 03d4 0C000000 		jal	user_PrintNum
 650 03d8 00003821 		move	$7,$0
 651              	
 652              	$LVL76:
 653 03dc 00408021 		move	$16,$2
 654              	$LVL77:
 187:print.c       **** 				OUTPUT(arg, buf, length);
 655              		.loc 1 187 0
 656 03e0 00403021 		move	$6,$2
 657              	$LVL78:
 658 03e4 2C4203E9 		sltu	$2,$2,1001
 659 03e8 14400007 		bne	$2,$0,$L73
 660 03ec 02402021 		move	$4,$18
 661              	
 662 03f0 3C050000 		lui	$5,%hi(user_theFatalMsg)
 663 03f4 24A50000 		addiu	$5,$5,%lo(user_theFatalMsg)
 664              	$LVL79:
 665 03f8 02A0F809 		jal	$21
 666 03fc 2406001D 		li	$6,29			# 0x1d
 667              	
 668              	$L75:
 669 0400 1000FFFF 		b	$L75
 670 0404 00000000 		nop
 671              	
 672              	$LVL80:
 673              	$L73:
 674 0408 02A0F809 		jal	$21
 675 040c 27A50020 		addiu	$5,$sp,32
 676              	
 677              	$LVL81:
 678 0410 10000051 		b	$L48
 679 0414 02509021 		addu	$18,$18,$16
 680              	
 681              	$LVL82:
 682              	$L36:
 188:print.c       **** 				break;
 189:print.c       **** 
 190:print.c       **** 			case 'X':
 191:print.c       **** 				if (longFlag) {
 683              		.loc 1 191 0
 684 0418 10800004 		beq	$4,$0,$L76
 685 041c 00000000 		nop
 686              	
 192:print.c       **** 					num = va_arg(ap, long int);
 687              		.loc 1 192 0
 688 0420 8E650000 		lw	$5,0($19)
 689              	$LVL83:
 690 0424 10000003 		b	$L78
 691 0428 26730004 		addiu	$19,$19,4
 692              	
 693              	$LVL84:
 694              	$L76:
 193:print.c       **** 				} else {
 194:print.c       **** 					num = va_arg(ap, int);
 695              		.loc 1 194 0
 696 042c 8E650000 		lw	$5,0($19)
 697              	$LVL85:
 698 0430 26730004 		addiu	$19,$19,4
 699              	$L78:
 195:print.c       **** 				}
 196:print.c       **** 
 197:print.c       **** 				length = user_PrintNum(buf, num, 16, 0, width, ladjust, padc, 1);
 700              		.loc 1 197 0
 701 0434 AFA80010 		sw	$8,16($sp)
 702 0438 AFA70014 		sw	$7,20($sp)
 703 043c AFA90018 		sw	$9,24($sp)
 704 0440 24020001 		li	$2,1			# 0x1
 705 0444 AFA2001C 		sw	$2,28($sp)
 706 0448 27A40020 		addiu	$4,$sp,32
 707              	$LVL86:
 708 044c 24060010 		li	$6,16			# 0x10
 709              	$LVL87:
 710 0450 0C000000 		jal	user_PrintNum
 711 0454 00003821 		move	$7,$0
 712              	
 713              	$LVL88:
 714 0458 00408021 		move	$16,$2
 715              	$LVL89:
 198:print.c       **** 				OUTPUT(arg, buf, length);
 716              		.loc 1 198 0
 717 045c 00403021 		move	$6,$2
 718              	$LVL90:
 719 0460 2C4203E9 		sltu	$2,$2,1001
 720 0464 14400007 		bne	$2,$0,$L79
 721 0468 02402021 		move	$4,$18
 722              	
 723 046c 3C050000 		lui	$5,%hi(user_theFatalMsg)
 724 0470 24A50000 		addiu	$5,$5,%lo(user_theFatalMsg)
 725              	$LVL91:
 726 0474 02A0F809 		jal	$21
 727 0478 2406001D 		li	$6,29			# 0x1d
 728              	
 729              	$L81:
 730 047c 1000FFFF 		b	$L81
 731 0480 00000000 		nop
 732              	
 733              	$LVL92:
 734              	$L79:
 735 0484 02A0F809 		jal	$21
 736 0488 27A50020 		addiu	$5,$sp,32
 737              	
 738              	$LVL93:
 739 048c 10000032 		b	$L48
 740 0490 02509021 		addu	$18,$18,$16
 741              	
 742              	$LVL94:
 743              	$L38:
 199:print.c       **** 				break;
 200:print.c       **** 
 201:print.c       **** 			case 'c':
 202:print.c       **** 				c = (char)va_arg(ap, int);
 744              		.loc 1 202 0
 745 0494 26740004 		addiu	$20,$19,4
 746              	$LVL95:
 203:print.c       **** 				length = user_PrintChar(buf, c, width, ladjust);
 747              		.loc 1 203 0
 748 0498 27A40020 		addiu	$4,$sp,32
 749              	$LVL96:
 750 049c 82650003 		lb	$5,3($19)
 751 04a0 0C000000 		jal	user_PrintChar
 752 04a4 01003021 		move	$6,$8
 753              	
 754              	$LVL97:
 755 04a8 00408021 		move	$16,$2
 756              	$LVL98:
 204:print.c       **** 				OUTPUT(arg, buf, length);
 757              		.loc 1 204 0
 758 04ac 00403021 		move	$6,$2
 759              	$LVL99:
 760 04b0 2C4203E9 		sltu	$2,$2,1001
 761 04b4 14400007 		bne	$2,$0,$L82
 762 04b8 02402021 		move	$4,$18
 763              	
 764 04bc 3C050000 		lui	$5,%hi(user_theFatalMsg)
 765 04c0 24A50000 		addiu	$5,$5,%lo(user_theFatalMsg)
 766              	$LVL100:
 767 04c4 02A0F809 		jal	$21
 768 04c8 2406001D 		li	$6,29			# 0x1d
 769              	
 770              	$L84:
 771 04cc 1000FFFF 		b	$L84
 772 04d0 00000000 		nop
 773              	
 774              	$LVL101:
 775              	$L82:
 776 04d4 02A0F809 		jal	$21
 777 04d8 27A50020 		addiu	$5,$sp,32
 778              	
 779              	$LVL102:
 780 04dc 02509021 		addu	$18,$18,$16
 781 04e0 1000001D 		b	$L48
 782 04e4 02809821 		move	$19,$20
 783              	
 784              	$LVL103:
 785              	$L39:
 205:print.c       **** 				break;
 206:print.c       **** 
 207:print.c       **** 			case 's':
 208:print.c       **** 				s = (char *)va_arg(ap, char *);
 786              		.loc 1 208 0
 787 04e8 26740004 		addiu	$20,$19,4
 788              	$LVL104:
 209:print.c       **** 				length = user_PrintString(buf, s, width, ladjust);
 789              		.loc 1 209 0
 790 04ec 27A40020 		addiu	$4,$sp,32
 791              	$LVL105:
 792 04f0 8E650000 		lw	$5,0($19)
 793 04f4 0C000000 		jal	user_PrintString
 794 04f8 01003021 		move	$6,$8
 795              	
 796              	$LVL106:
 797 04fc 00408021 		move	$16,$2
 798              	$LVL107:
 210:print.c       **** 				OUTPUT(arg, buf, length);
 799              		.loc 1 210 0
 800 0500 00403021 		move	$6,$2
 801              	$LVL108:
 802 0504 2C4203E9 		sltu	$2,$2,1001
 803 0508 14400007 		bne	$2,$0,$L85
 804 050c 02402021 		move	$4,$18
 805              	
 806 0510 3C050000 		lui	$5,%hi(user_theFatalMsg)
 807 0514 24A50000 		addiu	$5,$5,%lo(user_theFatalMsg)
 808              	$LVL109:
 809 0518 02A0F809 		jal	$21
 810 051c 2406001D 		li	$6,29			# 0x1d
 811              	
 812              	$L87:
 813 0520 1000FFFF 		b	$L87
 814 0524 00000000 		nop
 815              	
 816              	$LVL110:
 817              	$L85:
 818 0528 02A0F809 		jal	$21
 819 052c 27A50020 		addiu	$5,$sp,32
 820              	
 821              	$LVL111:
 822 0530 02509021 		addu	$18,$18,$16
 823 0534 10000008 		b	$L48
 824 0538 02809821 		move	$19,$20
 825              	
 826              	$LVL112:
 827              	$L32:
 211:print.c       **** 				break;
 212:print.c       **** 
 213:print.c       **** 			case '\0':
 214:print.c       **** 				fmt --;
 828              		.loc 1 214 0
 829 053c 10000006 		b	$L48
 830 0540 2631FFFF 		addiu	$17,$17,-1
 831              	
 832              	$L31:
 215:print.c       **** 				break;
 216:print.c       **** 
 217:print.c       **** 			default:
 218:print.c       **** 				/* output this char as it is */
 219:print.c       **** 				OUTPUT(arg, fmt, 1);
 833              		.loc 1 219 0
 834 0544 02402021 		move	$4,$18
 835              	$LVL113:
 836 0548 02202821 		move	$5,$17
 837 054c 02A0F809 		jal	$21
 838 0550 24060001 		li	$6,1			# 0x1
 839              	
 840              	$LVL114:
 841 0554 26520001 		addiu	$18,$18,1
 842              	$LVL115:
 843              	$L48:
 844              	$LVL116:
 220:print.c       **** 		}	/* switch (*fmt) */
 221:print.c       **** 
 222:print.c       **** 		fmt ++;
 845              		.loc 1 222 0
 846 0558 1000FEB5 		b	$L3
 847 055c 26250001 		addiu	$5,$17,1
 848              	
 849              	$LVL117:
 850              	$L13:
 223:print.c       **** 	}		/* for(;;) */
 224:print.c       **** 
 225:print.c       **** 	/* special termination call */
 226:print.c       **** 	OUTPUT(arg, "\0", 1);
 851              		.loc 1 226 0
 852 0560 02402021 		move	$4,$18
 853 0564 3C050000 		lui	$5,%hi($LC0)
 854 0568 24A50020 		addiu	$5,$5,%lo($LC0)
 855 056c 02A0F809 		jal	$21
 856 0570 24060001 		li	$6,1			# 0x1
 857              	
 227:print.c       **** }
 858              		.loc 1 227 0
 859 0574 8FBF0420 		lw	$31,1056($sp)
 860 0578 8FB5041C 		lw	$21,1052($sp)
 861              	$LVL118:
 862 057c 8FB40418 		lw	$20,1048($sp)
 863              	$LVL119:
 864 0580 8FB30414 		lw	$19,1044($sp)
 865              	$LVL120:
 866 0584 8FB20410 		lw	$18,1040($sp)
 867              	$LVL121:
 868 0588 8FB1040C 		lw	$17,1036($sp)
 869 058c 8FB00408 		lw	$16,1032($sp)
 870              	$LVL122:
 871 0590 03E00008 		j	$31
 872 0594 27BD0428 		addiu	$sp,$sp,1064
 873              	
 874              	$LVL123:
 875              	$L93:
 876              	$LBB3:
 877              		.loc 1 64 0
 878 0598 1462FEAA 		bne	$3,$2,$L6
 879 059c 24030025 		li	$3,37			# 0x25
 880              	
 881 05a0 1000FEB1 		b	$L8
 882 05a4 00A08021 		move	$16,$5
 883              	
 884              	$LBE3:
 885              		.set	macro
 886              		.set	reorder
 887              	$LFE2:
 888              		.end	user_lp_Print
 889              		.align	2
 890              		.globl	user_PrintChar
 891              		.ent	user_PrintChar
 893              	user_PrintChar:
 894              	$LFB3:
 228:print.c       **** 
 229:print.c       **** 
 230:print.c       **** /* --------------- local help functions --------------------- */
 231:print.c       **** int
 232:print.c       **** user_PrintChar(char *buf, char c, int length, int ladjust)
 233:print.c       **** {
 895              		.loc 1 233 0
 896              		.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
 897              		.mask	0x00000000,0
 898              		.fmask	0x00000000,0
 899              		.set	noreorder
 900              		.set	nomacro
 901              		
 902              	$LVL124:
 903 05a8 00052E00 		sll	$5,$5,24
 904 05ac 00052E03 		sra	$5,$5,24
 234:print.c       **** 	int i;
 235:print.c       **** 
 236:print.c       **** 	if (length < 1) {
 905              		.loc 1 236 0
 906 05b0 0006182A 		slt	$3,$0,$6
 907 05b4 24020001 		li	$2,1			# 0x1
 237:print.c       **** 		length = 1;
 238:print.c       **** 	}
 239:print.c       **** 
 240:print.c       **** 	if (ladjust) {
 908              		.loc 1 240 0
 909 05b8 10E00015 		beq	$7,$0,$L103
 910 05bc 0043300A 		movz	$6,$2,$3
 911              	
 241:print.c       **** 		*buf = c;
 242:print.c       **** 
 243:print.c       **** 		for (i = 1; i < length; i++) {
 912              		.loc 1 243 0
 913 05c0 28C20002 		slt	$2,$6,2
 914              		.loc 1 241 0
 915              		.loc 1 243 0
 916 05c4 14400016 		bne	$2,$0,$L105
 917 05c8 A0850000 		sb	$5,0($4)
 918              	
 919 05cc 24030001 		li	$3,1			# 0x1
 920              	$LVL125:
 921 05d0 24050020 		li	$5,32
 922              	$LVL126:
 244:print.c       **** 			buf[i] = ' ';
 923              		.loc 1 244 0
 924 05d4 00831021 		addu	$2,$4,$3
 925              	$L114:
 926              		.loc 1 243 0
 927 05d8 24630001 		addiu	$3,$3,1
 928              		.loc 1 244 0
 929              		.loc 1 243 0
 930 05dc 10C30010 		beq	$6,$3,$L105
 931 05e0 A0450000 		sb	$5,0($2)
 932              	
 933              		.loc 1 244 0
 934 05e4 1000FFFC 		b	$L114
 935 05e8 00831021 		addu	$2,$4,$3
 936              	
 937              	$LVL127:
 938              	$L108:
 939              		.loc 1 243 0
 940 05ec 00001821 		move	$3,$0
 941              	$LVL128:
 942 05f0 24080020 		li	$8,32
 943              	$L109:
 245:print.c       **** 		}
 246:print.c       **** 	} else {
 247:print.c       **** 		for (i = 0; i < length - 1; i++) {
 248:print.c       **** 			buf[i] = ' ';
 944              		.loc 1 248 0
 945 05f4 00641021 		addu	$2,$3,$4
 946              		.loc 1 247 0
 947 05f8 24630001 		addiu	$3,$3,1
 948              		.loc 1 248 0
 949              		.loc 1 247 0
 950 05fc 1467FFFD 		bne	$3,$7,$L109
 951 0600 A0480000 		sb	$8,0($2)
 952              	
 249:print.c       **** 		}
 250:print.c       **** 
 251:print.c       **** 		buf[length - 1] = c;
 953              		.loc 1 251 0
 954 0604 00C41021 		addu	$2,$6,$4
 955 0608 10000005 		b	$L105
 956 060c A045FFFF 		sb	$5,-1($2)
 957              	
 958              	$LVL129:
 959              	$L103:
 960              		.loc 1 247 0
 961 0610 24C7FFFF 		addiu	$7,$6,-1
 962              	$LVL130:
 963 0614 1CE0FFF5 		bgtz	$7,$L108
 964 0618 00C41021 		addu	$2,$6,$4
 965              	
 966 061c A045FFFF 		sb	$5,-1($2)
 967              	$LVL131:
 968              	$L105:
 252:print.c       **** 	}
 253:print.c       **** 
 254:print.c       **** 	return length;
 255:print.c       **** }
 969              		.loc 1 255 0
 970 0620 03E00008 		j	$31
 971 0624 00C01021 		move	$2,$6
 972              	
 973              		.set	macro
 974              		.set	reorder
 975              	$LFE3:
 976              		.end	user_PrintChar
 977              		.align	2
 978              		.globl	user_PrintString
 979              		.ent	user_PrintString
 981              	user_PrintString:
 982              	$LFB4:
 256:print.c       **** 
 257:print.c       **** int
 258:print.c       **** user_PrintString(char *buf, char *s, int length, int ladjust)
 259:print.c       **** {
 983              		.loc 1 259 0
 984              		.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
 985              		.mask	0x00000000,0
 986              		.fmask	0x00000000,0
 987              		.set	noreorder
 988              		.set	nomacro
 989              		
 990              	$LVL132:
 991              	$LVL133:
 260:print.c       **** 	int i;
 261:print.c       **** 	int len = 0;
 262:print.c       **** 	char *s1 = s;
 263:print.c       **** 
 264:print.c       **** 	while (*s1++) {
 992              		.loc 1 264 0
 993 0628 80A20000 		lb	$2,0($5)
 994 062c 14400003 		bne	$2,$0,$L118
 995 0630 24A30001 		addiu	$3,$5,1
 996              	
 997              	$LVL134:
 998 0634 10000006 		b	$L120
 999 0638 00004021 		move	$8,$0
 1000              	
 1001              	$LVL135:
 1002              	$L118:
 1003 063c 00004021 		move	$8,$0
 1004              	$LVL136:
 1005              	$L121:
 265:print.c       **** 		len++;
 1006              		.loc 1 265 0
 1007 0640 25080001 		addiu	$8,$8,1
 1008              		.loc 1 264 0
 1009 0644 80620000 		lb	$2,0($3)
 1010 0648 1440FFFD 		bne	$2,$0,$L121
 1011 064c 24630001 		addiu	$3,$3,1
 1012              	
 1013              	$L120:
 266:print.c       **** 	}
 267:print.c       **** 
 268:print.c       **** 	if (length < len) {
 1014              		.loc 1 268 0
 1015 0650 00C8102A 		slt	$2,$6,$8
 269:print.c       **** 		length = len;
 270:print.c       **** 	}
 271:print.c       **** 
 272:print.c       **** 	if (ladjust) {
 1016              		.loc 1 272 0
 1017 0654 14E00030 		bne	$7,$0,$L124
 1018 0658 0102300B 		movn	$6,$8,$2
 1019              	
 273:print.c       **** 		for (i = 0; i < len; i++) {
 274:print.c       **** 			buf[i] = s[i];
 275:print.c       **** 		}
 276:print.c       **** 
 277:print.c       **** 		for (i = len; i < length; i++) {
 278:print.c       **** 			buf[i] = ' ';
 279:print.c       **** 		}
 280:print.c       **** 	} else {
 281:print.c       **** 		for (i = 0; i < length - len; i++) {
 1020              		.loc 1 281 0
 1021 065c 1000002A 		b	$L143
 1022 0660 00C83823 		subu	$7,$6,$8
 1023              	
 1024              	$L126:
 1025              		.loc 1 272 0
 1026 0664 00003821 		move	$7,$0
 1027              	$LVL137:
 1028              	$L127:
 1029              		.loc 1 274 0
 1030 0668 00871021 		addu	$2,$4,$7
 1031 066c 00A71821 		addu	$3,$5,$7
 1032              	$LVL138:
 1033 0670 90630000 		lbu	$3,0($3)
 1034              		.loc 1 273 0
 1035 0674 24E70001 		addiu	$7,$7,1
 1036              		.loc 1 274 0
 1037              		.loc 1 273 0
 1038 0678 1507FFFB 		bne	$8,$7,$L127
 1039 067c A0430000 		sb	$3,0($2)
 1040              	
 1041              	$LVL139:
 1042              		.loc 1 277 0
 1043 0680 0106102A 		slt	$2,$8,$6
 1044              	$L147:
 1045 0684 10400028 		beq	$2,$0,$L129
 1046 0688 00001821 		move	$3,$0
 1047              	
 1048 068c 00881021 		addu	$2,$4,$8
 1049              	$LVL140:
 1050 0690 24050020 		li	$5,32
 1051              	$LVL141:
 1052 0694 00C82023 		subu	$4,$6,$8
 1053              	$LVL142:
 1054              		.loc 1 278 0
 1055 0698 A0450000 		sb	$5,0($2)
 1056              	$L144:
 1057 069c 24630001 		addiu	$3,$3,1
 1058              		.loc 1 277 0
 1059 06a0 10640021 		beq	$3,$4,$L129
 1060 06a4 24420001 		addiu	$2,$2,1
 1061              	
 1062              		.loc 1 278 0
 1063 06a8 1000FFFC 		b	$L144
 1064 06ac A0450000 		sb	$5,0($2)
 1065              	
 1066              	$LVL143:
 1067              	$L132:
 1068              		.loc 1 277 0
 1069 06b0 00001821 		move	$3,$0
 1070              	$LVL144:
 1071 06b4 24090020 		li	$9,32
 1072              	$L133:
 282:print.c       **** 			buf[i] = ' ';
 1073              		.loc 1 282 0
 1074 06b8 00831021 		addu	$2,$4,$3
 1075              		.loc 1 281 0
 1076 06bc 24630001 		addiu	$3,$3,1
 1077              		.loc 1 282 0
 1078              		.loc 1 281 0
 1079 06c0 1467FFFD 		bne	$3,$7,$L133
 1080 06c4 A0490000 		sb	$9,0($2)
 1081              	
 1082              	$LVL145:
 283:print.c       **** 		}
 284:print.c       **** 
 285:print.c       **** 		for (i = length - len; i < length; i++) {
 1083              		.loc 1 285 0
 1084 06c8 00E6102A 		slt	$2,$7,$6
 1085              	$L146:
 1086 06cc 10400016 		beq	$2,$0,$L129
 1087 06d0 00872021 		addu	$4,$4,$7
 1088              	
 1089 06d4 00E61023 		subu	$2,$7,$6
 1090 06d8 01021021 		addu	$2,$8,$2
 1091 06dc 00A21821 		addu	$3,$5,$2
 1092              	$LVL146:
 1093 06e0 00002821 		move	$5,$0
 1094              	$LVL147:
 1095 06e4 00C73823 		subu	$7,$6,$7
 1096              	$LVL148:
 286:print.c       **** 			buf[i] = s[i - length + len];
 1097              		.loc 1 286 0
 1098 06e8 90620000 		lbu	$2,0($3)
 1099              	$L145:
 1100 06ec A0820000 		sb	$2,0($4)
 1101 06f0 24A50001 		addiu	$5,$5,1
 1102 06f4 24630001 		addiu	$3,$3,1
 1103              		.loc 1 285 0
 1104 06f8 10A7000B 		beq	$5,$7,$L129
 1105 06fc 24840001 		addiu	$4,$4,1
 1106              	
 1107              		.loc 1 286 0
 1108 0700 1000FFFA 		b	$L145
 1109 0704 90620000 		lbu	$2,0($3)
 1110              	
 1111              	$LVL149:
 1112              	$L143:
 1113              	$LVL150:
 1114              		.loc 1 281 0
 1115 0708 1CE0FFE9 		bgtz	$7,$L132
 1116 070c 00E6102A 		slt	$2,$7,$6
 1117              	
 1118 0710 1000FFEE 		b	$L146
 1119 0714 00000000 		nop
 1120              	
 1121              	$LVL151:
 1122              	$L124:
 1123              		.loc 1 273 0
 1124 0718 1D00FFD2 		bgtz	$8,$L126
 1125 071c 0106102A 		slt	$2,$8,$6
 1126              	
 1127 0720 1000FFD8 		b	$L147
 1128 0724 00000000 		nop
 1129              	
 1130              	$LVL152:
 1131              	$L129:
 287:print.c       **** 		}
 288:print.c       **** 	}
 289:print.c       **** 
 290:print.c       **** 	return length;
 291:print.c       **** }
 1132              		.loc 1 291 0
 1133 0728 03E00008 		j	$31
 1134 072c 00C01021 		move	$2,$6
 1135              	
 1136              		.set	macro
 1137              		.set	reorder
 1138              	$LFE4:
 1139              		.end	user_PrintString
 1140              		.align	2
 1141              		.globl	user_PrintNum
 1142              		.ent	user_PrintNum
 1144              	user_PrintNum:
 1145              	$LFB5:
 292:print.c       **** 
 293:print.c       **** int
 294:print.c       **** user_PrintNum(char *buf, unsigned long u, int base, int negFlag,
 295:print.c       **** 			  int length, int ladjust, char padc, int upcase)
 296:print.c       **** {
 1146              		.loc 1 296 0
 1147              		.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
 1148              		.mask	0x00000000,0
 1149              		.fmask	0x00000000,0
 1150              		.set	noreorder
 1151              		.set	nomacro
 1152              		
 1153              	$LVL153:
 1154 0730 8FA90010 		lw	$9,16($sp)
 1155 0734 8FAC0014 		lw	$12,20($sp)
 1156 0738 8FAB001C 		lw	$11,28($sp)
 1157              	$LVL154:
 1158 073c 83AA001B 		lb	$10,27($sp)
 1159              		.loc 1 296 0
 1160 0740 00804021 		move	$8,$4
 1161              	$LVL155:
 1162              	$LVL156:
 1163              	$L149:
 1164              	$LVL157:
 1165              	$LBB4:
 297:print.c       **** 	/* algorithm :
 298:print.c       **** 	 *  1. prints the number from left to right in reverse form.
 299:print.c       **** 	 *  2. fill the remaining spaces with padc if length is longer than
 300:print.c       **** 	 *     the actual length
 301:print.c       **** 	 *     TRICKY : if left adjusted, no "0" padding.
 302:print.c       **** 	 *		    if negtive, insert  "0" padding between "0" and number.
 303:print.c       **** 	 *  3. if (!ladjust) we reverse the whole string including paddings
 304:print.c       **** 	 *  4. otherwise we only reverse the actual string representing the num.
 305:print.c       **** 	 */
 306:print.c       **** 
 307:print.c       **** 	int actualLength = 0;
 308:print.c       **** 	char *p = buf;
 309:print.c       **** 	int i;
 310:print.c       **** 
 311:print.c       **** 	do {
 312:print.c       **** 		int tmp = u % base;
 1166              		.loc 1 312 0
 1167 0744 00A6001B 		divu	$0,$5,$6
 1168 0748 00C001F4 		teq	$6,$0,7
 1169 074c 00001810 		mfhi	$3
 1170              	$LVL158:
 1171              	$LVL159:
 313:print.c       **** 
 314:print.c       **** 		if (tmp <= 9) {
 1172              		.loc 1 314 0
 1173 0750 2862000A 		slt	$2,$3,10
 315:print.c       **** 			*p++ = '0' + tmp;
 1174              		.loc 1 315 0
 1175              		.loc 1 314 0
 1176 0754 10400004 		beq	$2,$0,$L150
 1177 0758 24620030 		addiu	$2,$3,48
 1178              	
 1179              		.loc 1 315 0
 1180 075c A1020000 		sb	$2,0($8)
 1181 0760 1000000B 		b	$L188
 1182 0764 25080001 		addiu	$8,$8,1
 1183              	
 1184              	$L150:
 316:print.c       **** 		} else if (upcase) {
 317:print.c       **** 			*p++ = 'A' + tmp - 10;
 318:print.c       **** 		} else {
 319:print.c       **** 			*p++ = 'a' + tmp - 10;
 1185              		.loc 1 319 0
 1186              		.loc 1 316 0
 1187 0768 11600005 		beq	$11,$0,$L153
 1188 076c 24620057 		addiu	$2,$3,87
 1189              	
 1190              		.loc 1 317 0
 1191 0770 24620037 		addiu	$2,$3,55
 1192 0774 A1020000 		sb	$2,0($8)
 1193 0778 10000003 		b	$L152
 1194 077c 25080001 		addiu	$8,$8,1
 1195              	
 1196              	$L153:
 1197              		.loc 1 319 0
 1198 0780 A1020000 		sb	$2,0($8)
 1199 0784 25080001 		addiu	$8,$8,1
 1200              	$L152:
 320:print.c       **** 		}
 321:print.c       **** 
 322:print.c       **** 		u /= base;
 1201              		.loc 1 322 0
 1202 0788 00A6001B 		divu	$0,$5,$6
 1203 078c 00C001F4 		teq	$6,$0,7
 1204              	$L188:
 1205 0790 00002812 		mflo	$5
 1206              	$LVL160:
 1207              	$LVL161:
 1208              	$LBE4:
 323:print.c       **** 	} while (u != 0);
 1209              		.loc 1 323 0
 1210 0794 14A0FFEB 		bne	$5,$0,$L149
 1211 0798 00000000 		nop
 1212              	
 324:print.c       **** 
 325:print.c       **** 	if (negFlag) {
 326:print.c       **** 		*p++ = '-';
 327:print.c       **** 	}
 328:print.c       **** 
 329:print.c       **** 	/* figure out actual length and adjust the maximum length */
 330:print.c       **** 	actualLength = p - buf;
 1213              		.loc 1 330 0
 1214              		.loc 1 325 0
 1215 079c 10E00005 		beq	$7,$0,$L186
 1216 07a0 01043023 		subu	$6,$8,$4
 1217              	
 1218              		.loc 1 326 0
 1219 07a4 2402002D 		li	$2,45
 1220 07a8 A1020000 		sb	$2,0($8)
 1221 07ac 25080001 		addiu	$8,$8,1
 1222              		.loc 1 330 0
 1223 07b0 01043023 		subu	$6,$8,$4
 1224              	$LVL162:
 1225              	$L186:
 331:print.c       **** 
 332:print.c       **** 	if (length < actualLength) {
 1226              		.loc 1 332 0
 1227 07b4 0126102A 		slt	$2,$9,$6
 1228 07b8 00C2480B 		movn	$9,$6,$2
 333:print.c       **** 		length = actualLength;
 334:print.c       **** 	}
 335:print.c       **** 
 336:print.c       **** 	/* add padding */
 337:print.c       **** 	if (ladjust) {
 1229              		.loc 1 337 0
 1230 07bc 24020020 		li	$2,32			# 0x20
 338:print.c       **** 		padc = ' ';
 339:print.c       **** 	}
 340:print.c       **** 
 341:print.c       **** 	if (negFlag && !ladjust && (padc == '0')) {
 1231              		.loc 1 341 0
 1232 07c0 10E00032 		beq	$7,$0,$L162
 1233 07c4 004C500B 		movn	$10,$2,$12
 1234              	
 342:print.c       **** 		for (i = actualLength - 1; i < length - 1; i++) {
 343:print.c       **** 			buf[i] = padc;
 344:print.c       **** 		}
 345:print.c       **** 
 346:print.c       **** 		buf[length - 1] = '-';
 347:print.c       **** 	} else {
 348:print.c       **** 		for (i = actualLength; i < length; i++) {
 1235              		.loc 1 348 0
 1236              		.loc 1 341 0
 1237 07c8 15800031 		bne	$12,$0,$L187
 1238 07cc 00C9102A 		slt	$2,$6,$9
 1239              	
 1240 07d0 24020030 		li	$2,48			# 0x30
 1241              		.loc 1 348 0
 1242              		.loc 1 341 0
 1243 07d4 1542002E 		bne	$10,$2,$L187
 1244 07d8 00C9102A 		slt	$2,$6,$9
 1245              	
 1246              		.loc 1 342 0
 1247 07dc 24C6FFFF 		addiu	$6,$6,-1
 1248              	$LVL163:
 1249 07e0 2528FFFF 		addiu	$8,$9,-1
 1250              	$LVL164:
 1251 07e4 00C8102A 		slt	$2,$6,$8
 1252 07e8 10400008 		beq	$2,$0,$L166
 1253 07ec 01061023 		subu	$2,$8,$6
 1254              	
 1255 07f0 00861821 		addu	$3,$4,$6
 1256              	$LVL165:
 1257 07f4 00002821 		move	$5,$0
 1258              	$LVL166:
 1259 07f8 24070030 		li	$7,48
 1260              	$LVL167:
 1261              	$L168:
 1262              		.loc 1 343 0
 1263 07fc A0670000 		sb	$7,0($3)
 1264 0800 24A50001 		addiu	$5,$5,1
 1265              		.loc 1 342 0
 1266 0804 14A2FFFD 		bne	$5,$2,$L168
 1267 0808 24630001 		addiu	$3,$3,1
 1268              	
 1269              	$LVL168:
 1270              	$L166:
 1271              		.loc 1 346 0
 1272 080c 00891821 		addu	$3,$4,$9
 1273              	$LVL169:
 1274 0810 2402002D 		li	$2,45
 1275 0814 1000000D 		b	$L169
 1276 0818 A062FFFF 		sb	$2,-1($3)
 1277              	
 1278              	$LVL170:
 1279              	$L170:
 349:print.c       **** 			buf[i] = padc;
 1280              		.loc 1 349 0
 1281 081c A0AA0000 		sb	$10,0($5)
 1282 0820 24630001 		addiu	$3,$3,1
 1283              		.loc 1 348 0
 1284 0824 01261023 		subu	$2,$9,$6
 1285              		.loc 1 349 0
 1286              		.loc 1 348 0
 1287 0828 1462FFFC 		bne	$3,$2,$L170
 1288 082c 24A50001 		addiu	$5,$5,1
 1289              	
 1290              	$LVL171:
 1291              	$L171:
 1292              	$LBB5:
 350:print.c       **** 		}
 351:print.c       **** 	}
 352:print.c       **** 
 353:print.c       **** 
 354:print.c       **** 	/* prepare to reverse the string */
 355:print.c       **** 	{
 356:print.c       **** 		int begin = 0;
 357:print.c       **** 		int end;
 358:print.c       **** 
 359:print.c       **** 		if (ladjust) {
 1293              		.loc 1 359 0
 1294 0830 11800006 		beq	$12,$0,$L169
 1295 0834 00000000 		nop
 1296              	
 360:print.c       **** 			end = actualLength - 1;
 1297              		.loc 1 360 0
 1298 0838 24C6FFFF 		addiu	$6,$6,-1
 1299              	$LVL172:
 1300              	$L173:
 361:print.c       **** 		} else {
 362:print.c       **** 			end = length - 1;
 1301              		.loc 1 362 0
 363:print.c       **** 		}
 364:print.c       **** 
 365:print.c       **** 		while (end > begin) {
 1302              		.loc 1 365 0
 1303 083c 1CC00005 		bgtz	$6,$L174
 1304 0840 00003821 		move	$7,$0
 1305              	
 366:print.c       **** 			char tmp = buf[begin];
 367:print.c       **** 			buf[begin] = buf[end];
 368:print.c       **** 			buf[end] = tmp;
 369:print.c       **** 			begin ++;
 370:print.c       **** 			end --;
 371:print.c       **** 		}
 372:print.c       **** 	}
 373:print.c       **** 
 374:print.c       **** 	/* adjust the string pointer */
 375:print.c       **** 	return length;
 376:print.c       **** }
 1306              		.loc 1 376 0
 1307 0844 03E00008 		j	$31
 1308 0848 01201021 		move	$2,$9
 1309              	
 1310              	$LVL173:
 1311              	$L169:
 1312              	$LVL174:
 1313              		.loc 1 362 0
 1314 084c 1000FFFB 		b	$L173
 1315 0850 2526FFFF 		addiu	$6,$9,-1
 1316              	
 1317              	$L174:
 1318 0854 00802821 		move	$5,$4
 1319              	$LVL175:
 1320 0858 00862021 		addu	$4,$4,$6
 1321              	$LVL176:
 1322              	$LBB6:
 1323              		.loc 1 366 0
 1324 085c 80A20000 		lb	$2,0($5)
 1325              	$LVL177:
 1326              	$L185:
 1327              		.loc 1 367 0
 1328 0860 90830000 		lbu	$3,0($4)
 1329              	$LVL178:
 1330 0864 A0A30000 		sb	$3,0($5)
 1331              		.loc 1 368 0
 1332 0868 A0820000 		sb	$2,0($4)
 1333              		.loc 1 369 0
 1334 086c 24E70001 		addiu	$7,$7,1
 1335              		.loc 1 370 0
 1336 0870 24C6FFFF 		addiu	$6,$6,-1
 1337 0874 24A50001 		addiu	$5,$5,1
 1338              	$LBE6:
 1339              		.loc 1 365 0
 1340 0878 00E6102A 		slt	$2,$7,$6
 1341              	$LVL179:
 1342              		.loc 1 370 0
 1343              		.loc 1 365 0
 1344 087c 10400009 		beq	$2,$0,$L175
 1345 0880 2484FFFF 		addiu	$4,$4,-1
 1346              	
 1347              		.loc 1 366 0
 1348 0884 1000FFF6 		b	$L185
 1349 0888 80A20000 		lb	$2,0($5)
 1350              	
 1351              	$LVL180:
 1352              	$L162:
 1353              	$LBE5:
 1354              		.loc 1 348 0
 1355 088c 00C9102A 		slt	$2,$6,$9
 1356              	$L187:
 1357 0890 1040FFE7 		beq	$2,$0,$L171
 1358 0894 00000000 		nop
 1359              	
 1360 0898 00862821 		addu	$5,$4,$6
 1361              	$LVL181:
 1362 089c 1000FFDF 		b	$L170
 1363 08a0 00001821 		move	$3,$0
 1364              	
 1365              	$LVL182:
 1366              	$L175:
 1367              		.loc 1 376 0
 1368 08a4 01201021 		move	$2,$9
 1369 08a8 03E00008 		j	$31
 1370 08ac 00000000 		nop
 1371              	
 1372              		.set	macro
 1373              		.set	reorder
 1374              	$LFE5:
 1375              		.end	user_PrintNum
 1446              	$Letext0:
