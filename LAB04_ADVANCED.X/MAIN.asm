List p=18f4520
    #include<p18f4520.inc>
	CONFIG OSC = INTIO67
	CONFIG WDT = OFF
	org 0x00
	
	LOAD_BYTE MACRO DES, LITERAL
	MOVLW LITERAL
	MOVWF DES
	ENDM
	
	LOAD_MATRIX MACRO E1, E2, E3, E4, D1, D2, D3, D4
	LOAD_BYTE D1, E1
	LOAD_BYTE D2, E2
	LOAD_BYTE D3, E3
	LOAD_BYTE D4, E4
	ENDM
	
	MUL MACRO DES, M1, M2
	MOVF M1, 0
	MULWF M2
	MOVF PRODL, 0
	ADDWF DES, 1
	ENDM
	
	initial:
	CLRF 0X00
	CLRF 0X01
	CLRF 0X02
	CLRF 0X03
	LOAD_MATRIX 0X25, 0X1f, 0X1d, 0X30, 0X10, 0X11, 0X12, 0X13
	LOAD_MATRIX 0X4, 0x3, 0X2, 0X1, 0X20, 0X21, 0X22, 0X23
	RCALL multiply
	NOP
	
	multiply:
	MUL 0X00, 0X10, 0X20
	MUL 0X00, 0X11, 0X22
	
	MUL 0X01, 0X10, 0X21
	MUL 0X01, 0X11, 0X23
	
	MUL 0X02, 0X12, 0X20
	MUL 0X02, 0X13, 0X22
	
	MUL 0X03, 0X12, 0X21
	MUL 0X03, 0X13, 0X23
	RETURN
	
	END
	
	
	
	
	


