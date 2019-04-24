   1              		.section .mdebug.abi32
   2              		.previous
  10              	$Ltext0:
  11              		.align	2
  12              		.globl	user_bcopy
  13              		.ent	user_bcopy
  15              	user_bcopy:
  16              	$LFB8:
  17              		.file 1 "fork.c"
   1:fork.c        **** // implement fork from user space
   2:fork.c        **** 
   3:fork.c        **** #include "lib.h"
   4:fork.c        **** #include <mmu.h>
   5:fork.c        **** #include <env.h>
   6:fork.c        **** #include "meow.h"
   7:fork.c        **** 
   8:fork.c        **** 
   9:fork.c        **** /* ----------------- help functions ---------------- */
  10:fork.c        **** 
  11:fork.c        **** /* Overview:
  12:fork.c        ****  * 	Copy `len` bytes from `src` to `dst`.
  13:fork.c        ****  *
  14:fork.c        ****  * Pre-Condition:
  15:fork.c        ****  * 	`src` and `dst` can't be NULL. Also, the `src` area 
  16:fork.c        ****  * 	 shouldn't overlap the `dest`, otherwise the behavior of this 
  17:fork.c        ****  * 	 function is undefined.
  18:fork.c        ****  */
  19:fork.c        **** void user_bcopy(const void *src, void *dst, size_t len)
  20:fork.c        **** {
  18              		.loc 1 20 0
  19              		.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
  20              		.mask	0x00000000,0
  21              		.fmask	0x00000000,0
  22              		.set	noreorder
  23              		.set	nomacro
  24              		
  25              	$LVL0:
  26              	$LVL1:
  21:fork.c        **** 	void *max;
  22:fork.c        **** 
  23:fork.c        **** 	//	writef("~~~~~~~~~~~~~~~~ src:%x dst:%x len:%x\n",(int)src,(int)dst,len);
  24:fork.c        **** 	max = dst + len;
  25:fork.c        **** 
  26:fork.c        **** 	// copy machine words while possible
  27:fork.c        **** 	if (((int)src % 4 == 0) && ((int)dst % 4 == 0)) {
  27              		.loc 1 27 0
  28 0000 30820003 		andi	$2,$4,0x3
  29              		.loc 1 24 0
  30              		.loc 1 27 0
  31 0004 14400004 		bne	$2,$0,$L2
  32 0008 00C53021 		addu	$6,$6,$5
  33              	
  34 000c 30A20003 		andi	$2,$5,0x3
  28:fork.c        **** 		while (dst + 3 < max) {
  35              		.loc 1 28 0
  36              		.loc 1 27 0
  37 0010 10400016 		beq	$2,$0,$L4
  38 0014 24A20003 		addiu	$2,$5,3
  39              	
  40              	$L2:
  29:fork.c        **** 			*(int *)dst = *(int *)src;
  30:fork.c        **** 			dst += 4;
  31:fork.c        **** 			src += 4;
  32:fork.c        **** 		}
  33:fork.c        **** 	}
  34:fork.c        **** 
  35:fork.c        **** 	// finish remaining 0-3 bytes
  36:fork.c        **** 	while (dst < max) {
  41              		.loc 1 36 0
  42 0018 00A6102B 		sltu	$2,$5,$6
  43              	$L15:
  44              		.loc 1 28 0
  45              		.loc 1 36 0
  46 001c 1440000C 		bne	$2,$0,$L5
  47 0020 00A01821 		move	$3,$5
  48              	
  49              	$L17:
  50 0024 03E00008 		j	$31
  51 0028 00000000 		nop
  52              	
  53              	$L10:
  54              	$LVL2:
  55              	$L13:
  56              		.loc 1 29 0
  57 002c 8C820000 		lw	$2,0($4)
  58 0030 ACA20000 		sw	$2,0($5)
  59              		.loc 1 30 0
  60 0034 24A50004 		addiu	$5,$5,4
  61              		.loc 1 28 0
  62 0038 24630007 		addiu	$3,$3,7
  63              	$LVL3:
  64 003c 0066182B 		sltu	$3,$3,$6
  65              		.loc 1 31 0
  66              		.loc 1 28 0
  67 0040 1060FFF5 		beq	$3,$0,$L2
  68 0044 24840004 		addiu	$4,$4,4
  69              	
  70              		.loc 1 36 0
  71 0048 1000FFF8 		b	$L13
  72 004c 00A01821 		move	$3,$5
  73              	
  74              	$L5:
  75              	$LVL4:
  37:fork.c        **** 		*(char *)dst = *(char *)src;
  76              		.loc 1 37 0
  77 0050 90820000 		lbu	$2,0($4)
  78              	$L14:
  79 0054 A0620000 		sb	$2,0($3)
  38:fork.c        **** 		dst += 1;
  80              		.loc 1 38 0
  81 0058 24630001 		addiu	$3,$3,1
  82              	$LVL5:
  39:fork.c        **** 		src += 1;
  83              		.loc 1 39 0
  84              		.loc 1 36 0
  85 005c 1066FFF1 		beq	$3,$6,$L17
  86 0060 24840001 		addiu	$4,$4,1
  87              	
  88              		.loc 1 37 0
  89 0064 1000FFFB 		b	$L14
  90 0068 90820000 		lbu	$2,0($4)
  91              	
  92              	$LVL6:
  93              	$L4:
  94              		.loc 1 28 0
  95 006c 0046102B 		sltu	$2,$2,$6
  96              		.loc 1 36 0
  97              		.loc 1 28 0
  98 0070 1440FFEE 		bne	$2,$0,$L10
  99 0074 00A01821 		move	$3,$5
 100              	
 101              		.loc 1 36 0
 102 0078 1000FFE8 		b	$L15
 103 007c 00A6102B 		sltu	$2,$5,$6
 104              	
 105              	$LVL7:
 106              		.set	macro
 107              		.set	reorder
 108              	$LFE8:
 109              		.end	user_bcopy
 110              		.align	2
 111              		.globl	user_bzero
 112              		.ent	user_bzero
 114              	user_bzero:
 115              	$LFB9:
  40:fork.c        **** 	}
  41:fork.c        **** 
  42:fork.c        **** 	//for(;;);
  43:fork.c        **** }
  44:fork.c        **** 
  45:fork.c        **** /* Overview:
  46:fork.c        ****  * 	Sets the first n bytes of the block of memory 
  47:fork.c        ****  * pointed by `v` to zero.
  48:fork.c        ****  * 
  49:fork.c        ****  * Pre-Condition:
  50:fork.c        ****  * 	`v` must be valid.
  51:fork.c        ****  *
  52:fork.c        ****  * Post-Condition:
  53:fork.c        ****  * 	the content of the space(from `v` to `v`+ n) 
  54:fork.c        ****  * will be set to zero.
  55:fork.c        ****  */
  56:fork.c        **** void user_bzero(void *v, u_int n)
  57:fork.c        **** {
 116              		.loc 1 57 0
 117              		.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
 118              		.mask	0x00000000,0
 119              		.fmask	0x00000000,0
 120              		.set	noreorder
 121              		.set	nomacro
 122              		
 123              	$LVL8:
  58:fork.c        **** 	char *p;
  59:fork.c        **** 	int m;
  60:fork.c        **** 
  61:fork.c        **** 	p = v;
  62:fork.c        **** 	m = n;
  63:fork.c        **** 
  64:fork.c        **** 	while (--m >= 0) {
 124              		.loc 1 64 0
 125 0080 24A2FFFF 		addiu	$2,$5,-1
 126              	$LVL9:
 127 0084 04400007 		bltz	$2,$L24
 128 0088 00801821 		move	$3,$4
 129              	
 130              	$LVL10:
 131 008c 00821021 		addu	$2,$4,$2
 132              	$LVL11:
 133 0090 24420001 		addiu	$2,$2,1
 134              	$L21:
  65:fork.c        **** 		*p++ = 0;
 135              		.loc 1 65 0
 136 0094 A0600000 		sb	$0,0($3)
 137 0098 24630001 		addiu	$3,$3,1
 138              		.loc 1 64 0
 139 009c 1462FFFD 		bne	$3,$2,$L21
 140 00a0 00000000 		nop
 141              	
 142              	$LVL12:
 143              	$L24:
 144 00a4 03E00008 		j	$31
 145 00a8 00000000 		nop
 146              	
 147              		.set	macro
 148              		.set	reorder
 149              	$LFE9:
 150              		.end	user_bzero
 151              		.section	.rodata.str1.4,"aMS",@progbits,1
 152              		.align	2
 153              	$LC0:
 154 0000 666F726B 		.ascii	"fork.c\000"
 154      2E6300
 155 0007 00       		.align	2
 156              	$LC1:
 157 0008 4025643A 		.ascii	"@%d: retrun %d\012\000"
 157      20726574 
 157      72756E20 
 157      25640A00 
 158              		.text
 159              		.align	2
 160              		.ent	pgfault
 162              	pgfault:
 163              	$LFB10:
  66:fork.c        **** 	}
  67:fork.c        **** }
  68:fork.c        **** /*--------------------------------------------------------------*/
  69:fork.c        **** 
  70:fork.c        **** /* Overview:
  71:fork.c        ****  * 	Custom page fault handler - if faulting page is copy-on-write,
  72:fork.c        ****  * map in our own private writable copy.
  73:fork.c        ****  * 
  74:fork.c        ****  * Pre-Condition:
  75:fork.c        ****  * 	`va` is the address which leads to a TLBS exception.
  76:fork.c        ****  *
  77:fork.c        ****  * Post-Condition:
  78:fork.c        ****  *  Launch a user_panic if `va` is not a copy-on-write page.
  79:fork.c        ****  * Otherwise, this handler should map a private writable copy of 
  80:fork.c        ****  * the faulting page at correct address.
  81:fork.c        ****  */
  82:fork.c        **** static void
  83:fork.c        **** pgfault(u_int va)
  84:fork.c        **** {
 164              		.loc 1 84 0
 165              		.frame	$sp,40,$31		# vars= 0, regs= 3/0, args= 24, gp= 0
 166              		.mask	0x80030000,-8
 167              		.fmask	0x00000000,0
 168              		.set	noreorder
 169              		.set	nomacro
 170              		
 171              	$LVL13:
 172 00ac 27BDFFD8 		addiu	$sp,$sp,-40
 173              	$LCFI0:
 174              	$LVL14:
 175 00b0 AFBF0020 		sw	$31,32($sp)
 176              	$LCFI1:
 177 00b4 AFB1001C 		sw	$17,28($sp)
 178              	$LCFI2:
 179 00b8 AFB00018 		sw	$16,24($sp)
 180              	$LCFI3:
  85:fork.c        ****     //writef("pgfault at %x\n", va);
  86:fork.c        **** 
  87:fork.c        **** 	u_int pte = 0;
  88:fork.c        ****     int r;
  89:fork.c        **** 	//	writef("fork.c:pgfault():\t va:%x\n",va);
  90:fork.c        ****     pte = (*vpt)[VPN(va)]; 
 181              		.loc 1 90 0
 182 00bc 00041302 		srl	$2,$4,12
 183 00c0 00021080 		sll	$2,$2,2
 184 00c4 3C030000 		lui	$3,%hi(vpt)
 185 00c8 8C630000 		lw	$3,%lo(vpt)($3)
 186 00cc 00431021 		addu	$2,$2,$3
 187 00d0 8C420000 		lw	$2,0($2)
 188              	$LVL15:
  91:fork.c        ****     u_int perm = pte & 0xFFF;
  92:fork.c        ****     if (pte & PTE_COW == 0) {
  93:fork.c        ****         user_panic("not a copy-on-write page");
  94:fork.c        ****     }
  95:fork.c        **** 
  96:fork.c        ****     //writef("%x %x %x\n", pte, perm, VPN(va));
  97:fork.c        ****     //return;
  98:fork.c        **** 
  99:fork.c        ****     va = ROUNDDOWN(va, BY2PG);
 189              		.loc 1 99 0
 190 00d4 2402F000 		li	$2,-4096			# 0xfffffffffffff000
 191              	$LVL16:
 192 00d8 00828824 		and	$17,$4,$2
 193              	$LVL17:
 100:fork.c        ****     //map the new page at a temporary place
 101:fork.c        ****     //u_int tmp = UXSTACKTOP - BY2PG;
 102:fork.c        ****     u_int tmp = UTEXT - BY2PG;
 103:fork.c        ****     r = syscall_mem_alloc(0, tmp, PTE_V | PTE_R);
 194              		.loc 1 103 0
 195 00dc 00002021 		move	$4,$0
 196              	$LVL18:
 197 00e0 3C05003F 		li	$5,4128768			# 0x3f0000
 198 00e4 34A5F000 		ori	$5,$5,0xf000
 199 00e8 0C000000 		jal	syscall_mem_alloc
 200 00ec 24060600 		li	$6,1536			# 0x600
 201              	
 202              	$LVL19:
 104:fork.c        **** 	UERR(r);
 105:fork.c        ****     //copy the content
 106:fork.c        ****     user_bcopy(va, tmp, BY2PG);
 203              		.loc 1 106 0
 204              		.loc 1 104 0
 205 00f0 04410009 		bgez	$2,$L26
 206 00f4 02202021 		move	$4,$17
 207              	
 208 00f8 AFA20010 		sw	$2,16($sp)
 209 00fc 3C040000 		lui	$4,%hi($LC0)
 210 0100 24840000 		addiu	$4,$4,%lo($LC0)
 211 0104 24050068 		li	$5,104			# 0x68
 212 0108 3C060000 		lui	$6,%hi($LC1)
 213 010c 24C60000 		addiu	$6,$6,%lo($LC1)
 214 0110 0C000000 		jal	_user_panic
 215 0114 24070068 		li	$7,104			# 0x68
 216              	
 217              	$LVL20:
 218              	$L26:
 219              		.loc 1 106 0
 220 0118 3C10003F 		li	$16,4128768			# 0x3f0000
 221 011c 3605F000 		ori	$5,$16,0xf000
 222 0120 0C000000 		jal	user_bcopy
 223 0124 24061000 		li	$6,4096			# 0x1000
 224              	
 225              	$LVL21:
 107:fork.c        ****     //map the page on the appropriate place
 108:fork.c        ****     r = syscall_mem_map(0, tmp, 0, va, PTE_V | PTE_R);	
 226              		.loc 1 108 0
 227 0128 24020600 		li	$2,1536			# 0x600
 228 012c AFA20010 		sw	$2,16($sp)
 229 0130 00002021 		move	$4,$0
 230 0134 3605F000 		ori	$5,$16,0xf000
 231 0138 00003021 		move	$6,$0
 232 013c 0C000000 		jal	syscall_mem_map
 233 0140 02203821 		move	$7,$17
 234              	
 235              	$LVL22:
 109:fork.c        ****     UERR(r);
 110:fork.c        ****     //unmap the temporary place
 111:fork.c        ****     r = syscall_mem_unmap(0, tmp);
 236              		.loc 1 111 0
 237              		.loc 1 109 0
 238 0144 04410009 		bgez	$2,$L28
 239 0148 00002021 		move	$4,$0
 240              	
 241 014c AFA20010 		sw	$2,16($sp)
 242 0150 3C040000 		lui	$4,%hi($LC0)
 243 0154 24840000 		addiu	$4,$4,%lo($LC0)
 244 0158 2405006D 		li	$5,109			# 0x6d
 245 015c 3C060000 		lui	$6,%hi($LC1)
 246 0160 24C60000 		addiu	$6,$6,%lo($LC1)
 247 0164 0C000000 		jal	_user_panic
 248 0168 2407006D 		li	$7,109			# 0x6d
 249              	
 250              	$LVL23:
 251              	$L28:
 252              		.loc 1 111 0
 253 016c 3C05003F 		li	$5,4128768			# 0x3f0000
 254 0170 0C000000 		jal	syscall_mem_unmap
 255 0174 34A5F000 		ori	$5,$5,0xf000
 256              	
 257              	$LVL24:
 258              	$LVL25:
 112:fork.c        ****     UERR(r);
 113:fork.c        **** 
 114:fork.c        **** }
 259              		.loc 1 114 0
 260              		.loc 1 112 0
 261 0178 04410009 		bgez	$2,$L32
 262 017c 8FBF0020 		lw	$31,32($sp)
 263              	
 264 0180 AFA20010 		sw	$2,16($sp)
 265 0184 3C040000 		lui	$4,%hi($LC0)
 266 0188 24840000 		addiu	$4,$4,%lo($LC0)
 267 018c 24050070 		li	$5,112			# 0x70
 268 0190 3C060000 		lui	$6,%hi($LC1)
 269 0194 24C60000 		addiu	$6,$6,%lo($LC1)
 270 0198 0C000000 		jal	_user_panic
 271 019c 24070070 		li	$7,112			# 0x70
 272              	
 273              	$LVL26:
 274              	$LVL27:
 275              	$L32:
 276              		.loc 1 114 0
 277 01a0 8FB1001C 		lw	$17,28($sp)
 278              	$LVL28:
 279 01a4 8FB00018 		lw	$16,24($sp)
 280              	$LVL29:
 281 01a8 03E00008 		j	$31
 282 01ac 27BD0028 		addiu	$sp,$sp,40
 283              	
 284              		.set	macro
 285              		.set	reorder
 286              	$LFE10:
 287              		.end	pgfault
 288              		.align	2
 289              		.ent	duppage
 291              	duppage:
 292              	$LFB11:
 115:fork.c        **** 
 116:fork.c        **** /* Overview:
 117:fork.c        ****  * 	Map our virtual page `pn` (address pn*BY2PG) into the target `envid`
 118:fork.c        ****  * at the same virtual address. 
 119:fork.c        ****  *
 120:fork.c        ****  * Post-Condition:
 121:fork.c        ****  *  if the page is writable or copy-on-write, the new mapping must be 
 122:fork.c        ****  * created copy on write and then our mapping must be marked 
 123:fork.c        ****  * copy on write as well. In another word, both of the new mapping and
 124:fork.c        ****  * our mapping should be copy-on-write if the page is writable or 
 125:fork.c        ****  * copy-on-write.
 126:fork.c        ****  * 
 127:fork.c        ****  * Hint:
 128:fork.c        ****  * 	PTE_LIBRARY indicates that the page is shared between processes.
 129:fork.c        ****  * A page with PTE_LIBRARY may have PTE_R at the same time. You
 130:fork.c        ****  * should process it correctly.
 131:fork.c        ****  */
 132:fork.c        **** static void
 133:fork.c        **** duppage(u_int envid, u_int pn)
 134:fork.c        **** {
 293              		.loc 1 134 0
 294              		.frame	$sp,40,$31		# vars= 0, regs= 3/0, args= 24, gp= 0
 295              		.mask	0x80030000,-8
 296              		.fmask	0x00000000,0
 297              		.set	noreorder
 298              		.set	nomacro
 299              		
 300              	$LVL30:
 301 01b0 27BDFFD8 		addiu	$sp,$sp,-40
 302              	$LCFI4:
 303              	$LVL31:
 304 01b4 AFBF0020 		sw	$31,32($sp)
 305              	$LCFI5:
 306 01b8 AFB1001C 		sw	$17,28($sp)
 307              	$LCFI6:
 308 01bc AFB00018 		sw	$16,24($sp)
 309              	$LCFI7:
 310 01c0 00803021 		move	$6,$4
 135:fork.c        ****     u_int pte = (*vpt)[pn];
 311              		.loc 1 135 0
 312 01c4 00051080 		sll	$2,$5,2
 313 01c8 3C030000 		lui	$3,%hi(vpt)
 314 01cc 8C630000 		lw	$3,%lo(vpt)($3)
 315 01d0 00431021 		addu	$2,$2,$3
 316 01d4 8C430000 		lw	$3,0($2)
 317              	$LVL32:
 136:fork.c        **** 	u_int addr = pn * BY2PG;
 318              		.loc 1 136 0
 319 01d8 00058B00 		sll	$17,$5,12
 320              	$LVL33:
 321              	$LVL34:
 137:fork.c        **** 	u_int perm = pte & 0xFFF;
 138:fork.c        **** 
 139:fork.c        ****     
 140:fork.c        ****     if ((perm & PTE_V) && ((perm & PTE_COW) || (perm & PTE_R))) {
 322              		.loc 1 140 0
 323 01dc 30620200 		andi	$2,$3,0x200
 324              		.loc 1 137 0
 325              		.loc 1 140 0
 326 01e0 10400014 		beq	$2,$0,$L34
 327 01e4 30700FFF 		andi	$16,$3,0xfff
 328              	
 329              	$LVL35:
 330 01e8 30620001 		andi	$2,$3,0x1
 331 01ec 14400003 		bne	$2,$0,$L36
 332 01f0 30620400 		andi	$2,$3,0x400
 333              	
 334 01f4 1040000F 		beq	$2,$0,$L34
 335 01f8 00000000 		nop
 336              	
 337              	$L36:
 141:fork.c        ****         syscall_mem_map(0, addr, envid, addr, perm | PTE_COW); 
 338              		.loc 1 141 0
 339 01fc 36100001 		ori	$16,$16,0x1
 340              	$LVL36:
 341 0200 AFB00010 		sw	$16,16($sp)
 342 0204 00002021 		move	$4,$0
 343 0208 02202821 		move	$5,$17
 344              	$LVL37:
 345 020c 0C000000 		jal	syscall_mem_map
 346 0210 02203821 		move	$7,$17
 347              	
 348              	$LVL38:
 142:fork.c        ****         syscall_mem_map(0, addr, 0, addr, perm | PTE_COW);
 349              		.loc 1 142 0
 350 0214 AFB00010 		sw	$16,16($sp)
 351 0218 00002021 		move	$4,$0
 352 021c 02202821 		move	$5,$17
 353 0220 00003021 		move	$6,$0
 354 0224 0C000000 		jal	syscall_mem_map
 355 0228 02203821 		move	$7,$17
 356              	
 143:fork.c        ****     } else {
 144:fork.c        ****         syscall_mem_map(0, addr, envid, addr, perm); 
 145:fork.c        ****     }
 146:fork.c        ****     
 147:fork.c        **** 	//	user_panic("duppage not implemented");
 148:fork.c        **** }
 357              		.loc 1 148 0
 358 022c 10000007 		b	$L40
 359 0230 8FBF0020 		lw	$31,32($sp)
 360              	
 361              	$LVL39:
 362              	$L34:
 363              		.loc 1 144 0
 364 0234 AFB00010 		sw	$16,16($sp)
 365 0238 00002021 		move	$4,$0
 366 023c 02202821 		move	$5,$17
 367              	$LVL40:
 368 0240 0C000000 		jal	syscall_mem_map
 369 0244 02203821 		move	$7,$17
 370              	
 371              	$LVL41:
 372              		.loc 1 148 0
 373 0248 8FBF0020 		lw	$31,32($sp)
 374              	$L40:
 375 024c 8FB1001C 		lw	$17,28($sp)
 376              	$LVL42:
 377 0250 8FB00018 		lw	$16,24($sp)
 378              	$LVL43:
 379 0254 03E00008 		j	$31
 380 0258 27BD0028 		addiu	$sp,$sp,40
 381              	
 382              		.set	macro
 383              		.set	reorder
 384              	$LFE11:
 385              		.end	duppage
 386              		.section	.rodata.str1.4
 387              		.align	2
 388              	$LC2:
 389 0018 4D454F57 		.ascii	"MEOW!\000"
 389      2100
 390              		.text
 391              		.align	2
 392              		.globl	fork
 393              		.ent	fork
 395              	fork:
 396              	$LFB12:
 149:fork.c        **** 
 150:fork.c        **** /* Overview:
 151:fork.c        ****  * 	User-level fork. Create a child and then copy our address space
 152:fork.c        ****  * and page fault handler setup to the child.
 153:fork.c        ****  *
 154:fork.c        ****  * Hint: use vpd, vpt, and duppage.
 155:fork.c        ****  * Hint: remember to fix "env" in the child process!
 156:fork.c        ****  * Note: `set_pgfault_handler`(user/pgfault.c) is different from 
 157:fork.c        ****  *       `syscall_set_pgfault_handler`. 
 158:fork.c        ****  */
 159:fork.c        **** extern void __asm_pgfault_handler(void);
 160:fork.c        **** int
 161:fork.c        **** fork(void)
 162:fork.c        **** {
 397              		.loc 1 162 0
 398              		.frame	$sp,48,$31		# vars= 0, regs= 6/0, args= 24, gp= 0
 399              		.mask	0x801f0000,-4
 400              		.fmask	0x00000000,0
 401              		.set	noreorder
 402              		.set	nomacro
 403              		
 404              	$LVL44:
 405 025c 27BDFFD0 		addiu	$sp,$sp,-48
 406              	$LCFI8:
 407              	$LVL45:
 408 0260 AFBF002C 		sw	$31,44($sp)
 409              	$LCFI9:
 410 0264 AFB40028 		sw	$20,40($sp)
 411              	$LCFI10:
 412 0268 AFB30024 		sw	$19,36($sp)
 413              	$LCFI11:
 414 026c AFB20020 		sw	$18,32($sp)
 415              	$LCFI12:
 416 0270 AFB1001C 		sw	$17,28($sp)
 417              	$LCFI13:
 418 0274 AFB00018 		sw	$16,24($sp)
 419              	$LCFI14:
 163:fork.c        **** 	// Your code here.
 164:fork.c        **** 	u_int newenvid;
 165:fork.c        **** 	extern struct Env *envs;
 166:fork.c        **** 	extern struct Env *env;
 167:fork.c        **** 	u_int i;
 168:fork.c        **** 
 169:fork.c        **** 	//The parent installs pgfault using set_pgfault_handler
 170:fork.c        ****     set_pgfault_handler(pgfault);
 420              		.loc 1 170 0
 421 0278 3C040000 		lui	$4,%hi(pgfault)
 422 027c 0C000000 		jal	set_pgfault_handler
 423 0280 248400AC 		addiu	$4,$4,%lo(pgfault)
 424              	
 425              	$LBB2:
 426              	$LBB3:
 427              		.file 2 "lib.h"
   1:lib.h         **** #ifndef LIB_H
   2:lib.h         **** #define LIB_H
   3:lib.h         **** #include "fd.h"
   4:lib.h         **** #include "pmap.h"
   5:lib.h         **** #include <mmu.h>
   6:lib.h         **** #include <trap.h>
   7:lib.h         **** #include <env.h>
   8:lib.h         **** #include <args.h>
   9:lib.h         **** #include <unistd.h>
  10:lib.h         **** #include "meow.h"
  11:lib.h         **** /////////////////////////////////////////////////////head
  12:lib.h         **** extern void umain();
  13:lib.h         **** extern void libmain();
  14:lib.h         **** extern void exit();
  15:lib.h         **** 
  16:lib.h         **** extern struct Env *env;
  17:lib.h         **** 
  18:lib.h         **** 
  19:lib.h         **** #define USED(x) (void)(x)
  20:lib.h         **** //////////////////////////////////////////////////////printf
  21:lib.h         **** #include <stdarg.h>
  22:lib.h         **** //#define		LP_MAX_BUF	80
  23:lib.h         **** 
  24:lib.h         **** void user_lp_Print(void (*output)(void *, const char *, int),
  25:lib.h         **** 				   void *arg,
  26:lib.h         **** 				   const char *fmt,
  27:lib.h         **** 				   va_list ap);
  28:lib.h         **** 
  29:lib.h         **** void writef(char *fmt, ...);
  30:lib.h         **** 
  31:lib.h         **** void _user_panic(const char *, int, const char *, ...)
  32:lib.h         **** __attribute__((noreturn));
  33:lib.h         **** 
  34:lib.h         **** #define user_panic(...) _user_panic(__FILE__, __LINE__, __VA_ARGS__)
  35:lib.h         **** 
  36:lib.h         **** 
  37:lib.h         **** /////////////////////////////////////////////////////fork spawn
  38:lib.h         **** int spawn(char *prog, char **argv);
  39:lib.h         **** int spawnl(char *prot, char *args, ...);
  40:lib.h         **** int fork(void);
  41:lib.h         **** 
  42:lib.h         **** void user_bcopy(const void *src, void *dst, size_t len);
  43:lib.h         **** void user_bzero(void *v, u_int n);
  44:lib.h         **** //////////////////////////////////////////////////syscall_lib
  45:lib.h         **** extern int msyscall(int, int, int, int, int, int);
  46:lib.h         **** 
  47:lib.h         **** void syscall_putchar(char ch);
  48:lib.h         **** u_int syscall_getenvid(void);
  49:lib.h         **** void syscall_yield(void);
  50:lib.h         **** int syscall_env_destroy(u_int envid);
  51:lib.h         **** int syscall_set_pgfault_handler(u_int envid, void (*func)(void),
  52:lib.h         **** 								u_int xstacktop);
  53:lib.h         **** int syscall_mem_alloc(u_int envid, u_int va, u_int perm);
  54:lib.h         **** int syscall_mem_map(u_int srcid, u_int srcva, u_int dstid, u_int dstva,
  55:lib.h         **** 					u_int perm);
  56:lib.h         **** int syscall_mem_unmap(u_int envid, u_int va);
  57:lib.h         **** 
  58:lib.h         **** inline static int syscall_env_alloc(void)
  59:lib.h         **** {
  60:lib.h         ****     return msyscall(SYS_env_alloc, 0, 0, 0, 0, 0);
 428              		.loc 2 60 0
 429 0284 AFA00010 		sw	$0,16($sp)
 430 0288 AFA00014 		sw	$0,20($sp)
 431 028c 2404253F 		li	$4,9535			# 0x253f
 432 0290 00002821 		move	$5,$0
 433 0294 00003021 		move	$6,$0
 434 0298 0C000000 		jal	msyscall
 435 029c 00003821 		move	$7,$0
 436              	
 437              	$LVL46:
 438              	$LBE3:
 439              	$LBE2:
 171:fork.c        **** 	//alloc a new alloc
 172:fork.c        ****     newenvid = syscall_env_alloc();
 173:fork.c        ****     if (newenvid == 0) {
 440              		.loc 1 173 0
 441 02a0 14400013 		bne	$2,$0,$L42
 442 02a4 0040A021 		move	$20,$2
 443              	
 444              	$LVL47:
 174:fork.c        ****         // child
 175:fork.c        ****         env = &envs[ENVX(syscall_getenvid())];
 445              		.loc 1 175 0
 446 02a8 0C000000 		jal	syscall_getenvid
 447 02ac 00000000 		nop
 448              	
 449              	$LVL48:
 450 02b0 304203FF 		andi	$2,$2,0x3ff
 451 02b4 00022080 		sll	$4,$2,2
 452 02b8 00021940 		sll	$3,$2,5
 453 02bc 00641823 		subu	$3,$3,$4
 454 02c0 00621821 		addu	$3,$3,$2
 455 02c4 000318C0 		sll	$3,$3,3
 456 02c8 3C020000 		lui	$2,%hi(envs)
 457 02cc 8C420000 		lw	$2,%lo(envs)($2)
 458 02d0 00621821 		addu	$3,$3,$2
 459 02d4 3C020000 		lui	$2,%hi(env)
 460 02d8 AC430000 		sw	$3,%lo(env)($2)
 176:fork.c        ****         USTOP();
 461              		.loc 1 176 0
 462 02dc 3C040000 		lui	$4,%hi($LC2)
 463 02e0 0C000000 		jal	writef
 464 02e4 24840000 		addiu	$4,$4,%lo($LC2)
 465              	
 466              	$L44:
 467 02e8 1000FFFF 		b	$L44
 468 02ec 00000000 		nop
 469              	
 470              	$LVL49:
 471              	$L42:
 472 02f0 00008021 		move	$16,$0
 473              	$LVL50:
 474 02f4 3C120000 		lui	$18,%hi(vpd)
 475 02f8 3C130000 		lui	$19,%hi(vpt)
 476 02fc 3C027F3F 		li	$2,2134835200			# 0x7f3f0000
 477              	$LVL51:
 478 0300 3451E000 		ori	$17,$2,0xe000
 479              	$LBB4:
 177:fork.c        ****         return 0;
 178:fork.c        ****     } else {
 179:fork.c        ****         // father
 180:fork.c        ****         for (i = 0; i < UTOP - 2*BY2PG; i+=BY2PG) {
 181:fork.c        ****             if(((*vpd)[VPN(i)/1024])!=0 && ((*vpt)[VPN(i)])!=0) {
 480              		.loc 1 181 0
 481 0304 00102B02 		srl	$5,$16,12
 482              	$L59:
 483 0308 00101582 		srl	$2,$16,22
 484 030c 00021080 		sll	$2,$2,2
 485 0310 8E430000 		lw	$3,%lo(vpd)($18)
 486 0314 00431021 		addu	$2,$2,$3
 487 0318 8C420000 		lw	$2,0($2)
 488 031c 10400008 		beq	$2,$0,$L46
 489 0320 00051080 		sll	$2,$5,2
 490              	
 491 0324 8E630000 		lw	$3,%lo(vpt)($19)
 492 0328 00431021 		addu	$2,$2,$3
 493 032c 8C420000 		lw	$2,0($2)
 494 0330 10400003 		beq	$2,$0,$L46
 495 0334 00000000 		nop
 496              	
 182:fork.c        ****                 duppage(newenvid, VPN(i));
 497              		.loc 1 182 0
 498 0338 0C00006C 		jal	duppage
 499 033c 02802021 		move	$4,$20
 500              	
 501              	$L46:
 502              		.loc 1 180 0
 503 0340 26101000 		addiu	$16,$16,4096
 504              		.loc 1 181 0
 505              		.loc 1 180 0
 506 0344 1611FFF0 		bne	$16,$17,$L59
 507 0348 00102B02 		srl	$5,$16,12
 508              	
 183:fork.c        ****             }
 184:fork.c        ****         }
 185:fork.c        ****         int r;
 186:fork.c        ****         r = syscall_mem_alloc(newenvid, UXSTACKTOP - BY2PG, PTE_V | PTE_R);
 509              		.loc 1 186 0
 510 034c 02802021 		move	$4,$20
 511 0350 3C057F3F 		li	$5,2134835200			# 0x7f3f0000
 512 0354 34A5F000 		ori	$5,$5,0xf000
 513 0358 0C000000 		jal	syscall_mem_alloc
 514 035c 24060600 		li	$6,1536			# 0x600
 515              	
 516              	$LVL52:
 187:fork.c        ****         UERR(r);
 188:fork.c        ****         r = syscall_set_pgfault_handler(newenvid, __asm_pgfault_handler, UXSTACKTOP);
 517              		.loc 1 188 0
 518              		.loc 1 187 0
 519 0360 04410009 		bgez	$2,$L50
 520 0364 02802021 		move	$4,$20
 521              	
 522 0368 AFA20010 		sw	$2,16($sp)
 523 036c 3C040000 		lui	$4,%hi($LC0)
 524 0370 24840000 		addiu	$4,$4,%lo($LC0)
 525 0374 240500BB 		li	$5,187			# 0xbb
 526 0378 3C060000 		lui	$6,%hi($LC1)
 527 037c 24C60000 		addiu	$6,$6,%lo($LC1)
 528 0380 0C000000 		jal	_user_panic
 529 0384 240700BB 		li	$7,187			# 0xbb
 530              	
 531              	$LVL53:
 532              	$L50:
 533              		.loc 1 188 0
 534 0388 3C050000 		lui	$5,%hi(__asm_pgfault_handler)
 535 038c 24A50000 		addiu	$5,$5,%lo(__asm_pgfault_handler)
 536 0390 0C000000 		jal	syscall_set_pgfault_handler
 537 0394 3C067F40 		li	$6,2134900736			# 0x7f400000
 538              	
 539              	$LVL54:
 540              	$LVL55:
 189:fork.c        ****         UERR(r);
 190:fork.c        ****         r = syscall_set_env_status(newenvid, ENV_RUNNABLE); 
 541              		.loc 1 190 0
 542              		.loc 1 189 0
 543 0398 04410009 		bgez	$2,$L52
 544 039c 02802021 		move	$4,$20
 545              	
 546 03a0 AFA20010 		sw	$2,16($sp)
 547 03a4 3C040000 		lui	$4,%hi($LC0)
 548 03a8 24840000 		addiu	$4,$4,%lo($LC0)
 549 03ac 240500BD 		li	$5,189			# 0xbd
 550 03b0 3C060000 		lui	$6,%hi($LC1)
 551 03b4 24C60000 		addiu	$6,$6,%lo($LC1)
 552 03b8 0C000000 		jal	_user_panic
 553 03bc 240700BD 		li	$7,189			# 0xbd
 554              	
 555              	$LVL56:
 556              	$L52:
 557              		.loc 1 190 0
 558 03c0 0C000000 		jal	syscall_set_env_status
 559 03c4 24050001 		li	$5,1			# 0x1
 560              	
 561              	$LVL57:
 562              	$LVL58:
 191:fork.c        ****         UERR(r);
 192:fork.c        ****     }
 193:fork.c        **** 
 194:fork.c        **** 
 195:fork.c        **** 	return newenvid;
 196:fork.c        **** }
 563              		.loc 1 196 0
 564              		.loc 1 191 0
 565 03c8 04410009 		bgez	$2,$L54
 566 03cc 8FBF002C 		lw	$31,44($sp)
 567              	
 568 03d0 AFA20010 		sw	$2,16($sp)
 569 03d4 3C040000 		lui	$4,%hi($LC0)
 570 03d8 24840000 		addiu	$4,$4,%lo($LC0)
 571 03dc 240500BF 		li	$5,191			# 0xbf
 572 03e0 3C060000 		lui	$6,%hi($LC1)
 573 03e4 24C60000 		addiu	$6,$6,%lo($LC1)
 574 03e8 0C000000 		jal	_user_panic
 575 03ec 240700BF 		li	$7,191			# 0xbf
 576              	
 577              	$LVL59:
 578              	$L54:
 579              	$LBE4:
 580              		.loc 1 196 0
 581 03f0 02801021 		move	$2,$20
 582              	$LVL60:
 583 03f4 8FB40028 		lw	$20,40($sp)
 584              	$LVL61:
 585 03f8 8FB30024 		lw	$19,36($sp)
 586 03fc 8FB20020 		lw	$18,32($sp)
 587 0400 8FB1001C 		lw	$17,28($sp)
 588 0404 8FB00018 		lw	$16,24($sp)
 589              	$LVL62:
 590 0408 03E00008 		j	$31
 591 040c 27BD0030 		addiu	$sp,$sp,48
 592              	
 593              		.set	macro
 594              		.set	reorder
 595              	$LFE12:
 596              		.end	fork
 597              		.section	.rodata.str1.4
 598 001e 0000     		.align	2
 599              	$LC3:
 600 0020 73666F72 		.ascii	"sfork not implemented\000"
 600      6B206E6F 
 600      7420696D 
 600      706C656D 
 600      656E7465 
 601 0036 0000     		.text
 602              		.align	2
 603              		.globl	sfork
 604              		.ent	sfork
 606              	sfork:
 607              	$LFB13:
 197:fork.c        **** 
 198:fork.c        **** // Challenge!
 199:fork.c        **** int
 200:fork.c        **** sfork(void)
 201:fork.c        **** {
 608              		.loc 1 201 0
 609              		.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, gp= 0
 610              		.mask	0x80000000,-8
 611              		.fmask	0x00000000,0
 612              		.set	noreorder
 613              		.set	nomacro
 614              		
 615              	$LVL63:
 616 0410 27BDFFE8 		addiu	$sp,$sp,-24
 617              	$LCFI15:
 618              	$LVL64:
 619 0414 AFBF0010 		sw	$31,16($sp)
 620              	$LCFI16:
 202:fork.c        **** 	user_panic("sfork not implemented");
 621              		.loc 1 202 0
 622 0418 3C040000 		lui	$4,%hi($LC0)
 623 041c 24840000 		addiu	$4,$4,%lo($LC0)
 624 0420 240500CA 		li	$5,202			# 0xca
 625 0424 3C060000 		lui	$6,%hi($LC3)
 626 0428 0C000000 		jal	_user_panic
 627 042c 24C60000 		addiu	$6,$6,%lo($LC3)
 628              	
 629              		.set	macro
 630              		.set	reorder
 631              	$LFE13:
 632              		.end	sfork
 753              	$Letext0:
