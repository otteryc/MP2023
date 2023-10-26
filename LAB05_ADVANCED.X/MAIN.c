/*
 * File:   MAIN.c
 * Author: otteryc
 *
 * Created on 2023?10?18?, ?? 11:33
 */


#include <xc.h>
extern unsigned int multi_signed(unsigned char a, unsigned char b);

void main(void) {
    volatile unsigned int result = multi_signed(-30, 4);
    while(1);
    return;
}