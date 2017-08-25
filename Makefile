TARGET   = blink

MCU      = attiny4
FREQ     = 1000000

SOURCES  = main.c
OBJECTS  = $(SOURCES:.c=.o)

CROSS    = avr
CC       = $(CROSS)-gcc
SIZE     = $(CROSS)-size
OBJCOPY  = $(CROSS)-objcopy

CFLAGS   = -Wall
CFLAGS  += -Os
CFLAGS  += -mmcu=$(MCU) -DF_CPU=$(FREQ)
CFLAGS  += -ffunction-sections -fdata-sections

LDFLAGS  = -Wl,-Map,$(TARGET).map
LDFLAGS += -Wl,--gc-sections

all: $(TARGET).hex

$(TARGET).hex : $(TARGET).elf
	$(SIZE) -C --mcu=$(MCU) $^
	$(OBJCOPY) -O ihex -j .text $^ $@ 

$(TARGET).elf : $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

.PHONY: clean

clean:
	@rm -f $(TARGET).{hex,elf,map} $(OBJECTS)
