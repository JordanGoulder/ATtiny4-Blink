#include <avr/io.h>
#include <util/delay.h>

int main(void) {

    DDRB |= _BV(DDB0);

    while (1) {
        PINB = _BV(PINB0);
        _delay_ms(500);
    }

    return 0;
}

