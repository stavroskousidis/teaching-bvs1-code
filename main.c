#include <stdint.h>

#define UART0_BASE 0x10000000UL
#define UART_THR    0
#define UART_LSR    5
#define UART_LSR_THRE 0x20

static volatile uint8_t *const uart0 = (volatile uint8_t *)UART0_BASE;

static void uart_putc(char c)
{
    while ((uart0[UART_LSR] & UART_LSR_THRE) == 0) {
    }

    uart0[UART_THR] = (uint8_t)c;
}

static void uart_puts(const char *s)
{
    while (*s != '\0') {
        if (*s == '\n') {
            uart_putc('\r');
        }

        uart_putc(*s++);
    }
}

static void uart_put_u32(uint32_t value)
{
    char digits[10];
    unsigned int count = 0;

    if (value == 0) {
        uart_putc('0');
        return;
    }

    while (value != 0) {
        digits[count++] = (char)('0' + (value % 10u));
        value /= 10u;
    }

    while (count != 0) {
        uart_putc(digits[--count]);
    }
}

void main(void)
{
    uart_puts("Hello BVS1\n");

    /*
     * Checkpoint 1:
     * Reuse the seeded Exercise 02 process experiment as your application
     * test, but implement the process abstraction yourself.
     *
     * No process API implementation is provided on this branch.
     */
    (void)uart_put_u32;

    for (;;) {
    }
}
