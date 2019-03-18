/* This is a simplefied ELF reader.
 * You can contact me if you find any bugs.
 *
 * Luming Wang<wlm199558@126.com>
 */

#include "kerelf.h"
#include <stdio.h>
/* Overview:
 *   Check whether it is a ELF file.
 *
 * Pre-Condition:
 *   binary must longer than 4 byte.
 *
 * Post-Condition:
 *   Return 0 if `binary` isn't an elf. Otherwise
 * return 1.
 */
int is_elf_format(u_char *binary)
{
        Elf32_Ehdr *ehdr = (Elf32_Ehdr *)binary;
        if (ehdr->e_ident[EI_MAG0] == ELFMAG0 &&
                ehdr->e_ident[EI_MAG1] == ELFMAG1 &&
                ehdr->e_ident[EI_MAG2] == ELFMAG2 &&
                ehdr->e_ident[EI_MAG3] == ELFMAG3) {
                return 1;
        }

        return 0;
}

/* Overview:
 *   read an elf format binary file. get ELF's information
 *
 * Pre-Condition:
 *   `binary` can't be NULL and `size` is the size of binary.
 *
 * Post-Condition:
 *   Return 0 if success. Otherwise return < 0.
 *   If success, output address of every section in ELF.
 */

Elf32_Addr tr(Elf32_Addr addr);
Elf32_Half trh(Elf32_Half addr) {
    u_char *c = &addr;
    c[0] ^= c[1];
    c[1] ^= c[0];
    c[0] ^= c[1];
    return addr;
    
}

int readelf(u_char *binary, int size)
{
        Elf32_Ehdr *ehdr = (Elf32_Ehdr *)binary;
            
        int Nr;

        Elf32_Shdr *shdr = NULL;

        u_char *ptr_sh_table = NULL;
        Elf32_Half sh_entry_count;
        Elf32_Half sh_entry_size;


        // check whether `binary` is a ELF file.
        if (size < 4 || !is_elf_format(binary)) {
                printf("not a standard elf format\n");
                return 0;
        }

        // get section table addr, section header number and section header size.
        
        unsigned char *e_dient = binary;
        
        
        int isBig = binary[5] == 2; 
        
        Elf32_Addr offset = ehdr->e_shoff;
        if (isBig) {
            offset = tr(offset);
        }
         
       
        Elf32_Addr sht_addr = binary + offset;
            

        Elf32_Half sht_size = trh(ehdr->e_shentsize);
        Elf32_Half sht_count = trh(ehdr->e_shnum);
        
        printf("%d %d \n", sht_size, sht_count);
        
        // for each section header, output section number and section addr.
        
        int i;
        for (i = 0; i < sht_count; i++) {
            Elf32_Addr sh_addr = sht_addr + i * sht_size;

            Elf32_Shdr* sh = (Elf32_Shdr *)sh_addr;

            printf("%d:0x%x\n", i, tr(sh->sh_addr));
        }


        return 0;
}

Elf32_Addr tr(Elf32_Addr addr) {
    u_char *c = &addr;
    c[0] ^= c[3];
    c[3] ^= c[0];
    c[0] ^= c[3];

    c[1] ^= c[2];
    c[2] ^= c[1];
    c[1] ^= c[2];
    
    return addr;
} 
