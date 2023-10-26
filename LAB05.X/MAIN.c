/*
 * File:   MAIN.c
 * Author: otteryc
 *
 * Created on 2023?10?18?, ?? 11:33
 */


#include <xc.h>
extern unsigned char is_square(unsigned int a);

void main(void) {
    volatile unsigned char result = is_square(9);
    while(1);
    return;
}
