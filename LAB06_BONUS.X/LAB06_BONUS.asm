LIST p=18f4520
#include<p18f4520.inc>
    CONFIG OSC = INTIO67 ; 1 MHZ
    CONFIG WDT = OFF
    CONFIG LVP = OFF

    L1	EQU 0x14
    L2	EQU 0x15
    org 0x00
	
; Total_cycles = 2 + (2 + 7 * num1 + 2) * num2 cycles
; num1 = 200, num2 = 180, Total_cycles = 252360
; Total_delay ~= Total_cycles/1M = 0.25s
DELAY macro num1, num2 
    local LOOP1         ; innerloop
    local LOOP2         ; outerloop
    MOVLW num2          ; 2 cycles
    MOVWF L2
    LOOP2:
	MOVLW num1          ; 2 cycles
	MOVWF L1
    LOOP1:
	NOP                 ; 7 cycles
	NOP
	NOP
	NOP
	NOP
	DECFSZ L1, 1
	BRA LOOP1
	DECFSZ L2, 1        ; 2 cycles
	BRA LOOP2
endm

	
_main:
int:
; let pin can receive digital signal 
MOVLW 0X60
MOVWF OSCCON
    
MOVLW 0x0f
MOVWF ADCON1            ;set digital IO
CLRF PORTB
BSF TRISB, 0            ;set RB0 as input TRISB = 0000 0001
CLRF LATA
MOVLW 0XF
CLRF TRISA

STAT0:
    BSF PORTB, 0
    MOVLW 0X00
    MOVWF LATA
    DELAY 200, 180
    BTFSC PORTB, 0
    BRA STAT0
    GOTO _STATE1
    

    
_STATE1:
    
    _STAT1:
    BSF PORTB, 0
    MOVLW 0X01
    MOVWF LATA
    DELAY 200, 180
    DELAY 200, 180
    BTFSS PORTB, 0
    BRA STAT1
    
    _STAT2:
    BSF PORTB, 0
    MOVLW 0X02
    MOVWF LATA
    DELAY 200, 180
    DELAY 200, 180
    BTFSS PORTB, 0
    BRA STAT2
    
    _STAT3:
    BSF PORTB, 0
    MOVLW 0X04
    MOVWF LATA
    DELAY 200, 180
    DELAY 200, 180
    BTFSS PORTB, 0
    BRA STAT3
    
    _STAT4:
    BSF PORTB, 0
    MOVLW 0X08
    MOVWF LATA
    DELAY 200, 180
    DELAY 200, 180
    GOTO _STATE1
    BTFSS PORTB, 0
    BRA STAT4

_STATE2:
    STAT4:
    BSF PORTB, 0
    MOVLW 0X08
    MOVWF LATA
    DELAY 200, 180
    DELAY 200, 180
    BTFSS PORTB, 0
    BRA STAT0
    
    STAT3:
    BSF PORTB, 0
    MOVLW 0X04
    MOVWF LATA
    DELAY 200, 180
    DELAY 200, 180
    BTFSS PORTB, 0
    BRA STAT0
    
    STAT2:
    BSF PORTB, 0
    MOVLW 0X02
    MOVWF LATA
    DELAY 200, 180
    DELAY 200, 180
    BTFSS PORTB, 0
    BRA STAT0
    
    STAT1:
    BSF PORTB, 0
    MOVLW 0X01
    MOVWF LATA
    DELAY 200, 180
    DELAY 200, 180
    BTFSS PORTB, 0
    BRA STAT0
    
    GOTO _STATE2
end


