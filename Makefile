TOOLCHAIN_FOLDER = $(HOME)/Private/work/endor/niq/platform/ecos/gnutools/arm-eabi/bin/
TOOLCHAIN_PREFIX = $(TOOLCHAIN_FOLDER)arm-eabi-
CC = $(TOOLCHAIN_PREFIX)gcc
LD = $(TOOLCHAIN_PREFIX)ld -v
CP = $(TOOLCHAIN_PREFIX)objcopy -I elf32-littlearm
OD = $(TOOLCHAIN_PREFIX)objdump 
GDBTUI = $(TOOLCHAIN_PREFIX)gdbtui

CFLAGS = -I. -c -fno-common -O0 -g -mcpu=cortex-m3 -mthumb
LFLAGS = -Tstm32.ld -nostartfiles
CPFLAGS = -Obinary
ODFLAGS = -S

all: hello.bin

clean:
	-rm -f hello.lst *.o hello.elf hello.bin

hello.bin: hello.elf
	@echo "...copying"
	$(CP) $(CPFLAGS) $^ $@
	$(OD) $(ODFLAGS) $^ > hello.lst

hello.elf: hello.o stm32.ld
	@echo "..linking"
	$(LD) $(LFLAGS) -o $@ hello.o

hello.o: hello.c
	@echo ".compiling"
	$(CC) $(CFLAGS) $^
