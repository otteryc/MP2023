#include "p18f4520.inc"

; CONFIG1H
  CONFIG  OSC = INTIO67         ; Oscillator Selection bits (Internal oscillator block, port function on RA6 and RA7)
  CONFIG  FCMEN = OFF           ; Fail-Safe Clock Monitor Enable bit (Fail-Safe Clock Monitor disabled)
  CONFIG  IESO = OFF            ; Internal/External Oscillator Switchover bit (Oscillator Switchover mode disabled)

; CONFIG2L
  CONFIG  PWRT = OFF            ; Power-up Timer Enable bit (PWRT disabled)
  CONFIG  BOREN = SBORDIS       ; Brown-out Reset Enable bits (Brown-out Reset enabled in hardware only (SBOREN is disabled))
  CONFIG  BORV = 3              ; Brown Out Reset Voltage bits (Minimum setting)

; CONFIG2H
  CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
  CONFIG  WDTPS = 32768         ; Watchdog Timer Postscale Select bits (1:32768)

; CONFIG3H
  CONFIG  CCP2MX = PORTC        ; CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
  CONFIG  PBADEN = ON           ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as analog input channels on Reset)
  CONFIG  LPT1OSC = OFF         ; Low-Power Timer1 Oscillator Enable bit (Timer1 configured for higher power operation)
  CONFIG  MCLRE = ON            ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)

; CONFIG4L
  CONFIG  STVREN = ON           ; Stack Full/Underflow Reset Enable bit (Stack full/underflow will cause Reset)
  CONFIG  LVP = OFF             ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)
  CONFIG  XINST = OFF           ; Extended Instruction Set Enable bit (Instruction set extension and Indexed Addressing mode disabled (Legacy mode))

; CONFIG5L
  CONFIG  CP0 = OFF             ; Code Protection bit (Block 0 (000800-001FFFh) not code-protected)
  CONFIG  CP1 = OFF             ; Code Protection bit (Block 1 (002000-003FFFh) not code-protected)
  CONFIG  CP2 = OFF             ; Code Protection bit (Block 2 (004000-005FFFh) not code-protected)
  CONFIG  CP3 = OFF             ; Code Protection bit (Block 3 (006000-007FFFh) not code-protected)

; CONFIG5H
  CONFIG  CPB = OFF             ; Boot Block Code Protection bit (Boot block (000000-0007FFh) not code-protected)
  CONFIG  CPD = OFF             ; Data EEPROM Code Protection bit (Data EEPROM not code-protected)

; CONFIG6L
  CONFIG  WRT0 = OFF            ; Write Protection bit (Block 0 (000800-001FFFh) not write-protected)
  CONFIG  WRT1 = OFF            ; Write Protection bit (Block 1 (002000-003FFFh) not write-protected)
  CONFIG  WRT2 = OFF            ; Write Protection bit (Block 2 (004000-005FFFh) not write-protected)
  CONFIG  WRT3 = OFF            ; Write Protection bit (Block 3 (006000-007FFFh) not write-protected)

; CONFIG6H
  CONFIG  WRTC = OFF            ; Configuration Register Write Protection bit (Configuration registers (300000-3000FFh) not write-protected)
  CONFIG  WRTB = OFF            ; Boot Block Write Protection bit (Boot block (000000-0007FFh) not write-protected)
  CONFIG  WRTD = OFF            ; Data EEPROM Write Protection bit (Data EEPROM not write-protected)

; CONFIG7L
  CONFIG  EBTR0 = OFF           ; Table Read Protection bit (Block 0 (000800-001FFFh) not protected from table reads executed in other blocks)
  CONFIG  EBTR1 = OFF           ; Table Read Protection bit (Block 1 (002000-003FFFh) not protected from table reads executed in other blocks)
  CONFIG  EBTR2 = OFF           ; Table Read Protection bit (Block 2 (004000-005FFFh) not protected from table reads executed in other blocks)
  CONFIG  EBTR3 = OFF           ; Table Read Protection bit (Block 3 (006000-007FFFh) not protected from table reads executed in other blocks)

; CONFIG7H
  CONFIG  EBTRB = OFF           ; Boot Block Table Read Protection bit (Boot block (000000-0007FFh) not protected from table reads executed in other blocks)

    org 0x00
    
goto Initial       
ISR:    
    org 0x08                
    BTFSS INTCON, INT0IF
 GOTO Not_Push
    INCF 0x0A     ;for STATE
    CLRF 0x0B
Not_Push:  ;judge 0.25,0.5,1s
    INCF 0x0B
    MOVLW 0x06
    CPFSEQ 0x0A
 GOTO Not_Clear
Not_Clear:
    BTFSC 0x0A,2 ;judge state 5 or 6
 GOTO STATE56
    BTFSS 0x0A,0
        GOTO STATE13 ;judge state 1 or 3
    BTFSS 0x0A,1
 GOTO STATE2
    GOTO STATE4
STATE56:
    BTFSS 0x0A,0
 GOTO STATE5
    GOTO STATE6
STATE13:
    BTFSS 0x0A,1
 GOTO STATE1
    GOTO STATE3
STATE1:
    INCF LATA
    GOTO ENDIT
STATE2:
    BTFSS 0x0B,1
 GOTO ENDIT
    DECF LATA
    CLRF 0x0B
    GOTO ENDIT
STATE3:
    BTFSS 0x0B,2
 GOTO ENDIT
    INCF LATA
    CLRF 0x0B
    GOTO ENDIT
STATE4:
    DECF LATA
    GOTO ENDIT
STATE5:
    BTFSS 0x0B,1
 GOTO ENDIT
    INCF LATA
    CLRF 0x0B
    GOTO ENDIT
STATE6:
    BTFSS 0x0B,2
 GOTO ENDIT
    DECF LATA
    CLRF 0x0B
ENDIT:
    BCF PIR1, TMR2IF        
    BCF INTCON, INT0IF      ;clear Interrupt flag bit
RETFIE
    
    
Initial:   
    MOVLW 0x0F
    MOVWF ADCON1
    CLRF TRISA
    CLRF LATA
    BSF RCON, IPEN
    BSF INTCON, GIE
    BCF PIR1, TMR2IF  
    BSF IPR1, TMR2IP
    BSF PIE1 , TMR2IE
    MOVLW b'11111111'        
    MOVWF T2CON  
    MOVLW D'61'  
    MOVWF PR2   
    MOVLW D'00100000'
    MOVWF OSCCON        
    
main:  
    bra main     
end


