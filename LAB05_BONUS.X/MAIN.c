/*
 * File:   MAIN.c
 * Author: otteryc
 *
 * Created on 2023?10?18?, ?? 11:33
 */


#include <xc.h>
extern unsigned int lcm(unsigned int a, unsigned int b);

void main(void) {
    volatile unsigned int result = lcm(40, 140);
    while(1);
    return;
}