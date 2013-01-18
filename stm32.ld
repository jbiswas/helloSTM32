/* This will work with STM32 type of microcontrollers.    *
 * The sizes of RAM and flash are specified smaller than  *
 * what most of the STM32 provide to ensure that the demo *
 * program will run on ANY STM32.                         */
MEMORY
{
  sram : ORIGIN = 0x20000000, LENGTH = 0x00010000-4096
  flash : ORIGIN = 0x08000000 + 0x10000, LENGTH = 0x70000
  rom : ORIGIN = 0x08000000, LENGTH = 0x00010000
  ram : ORIGIN = 0x68000000, LENGTH = 0x00100000
  extflash : ORIGIN = 0xC0000000, LENGTH = 0x00200000
}

SECTIONS
{
  .  = 0x0;         /* From 0x00000000 */
  .text :
  {
    *(vectors)    /* Vector table */
    *(.text)      /* Program code */
    *(.rodata)    /* Read only data */
  } >rom

  .  = 0x20000000;  /* From 0x20000000 */
  .data :
  {
    *(.data)      /* Data memory */
  } >ram AT > rom

  .bss :
  {
    *(.bss)       /* Zero-filled run time allocate data memory */
  } >ram AT > rom
}
