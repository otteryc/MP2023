List p=18f4520
    #include<p18f4520.inc>
	CONFIG OSC = INTIO67
	CONFIG WDT = OFF
	org 0x00
	
	MOVLB 0X01
	MOVLW 0X15
	MOVWF 0X00, 1
	MOVLW 0X12
	MOVWF 0X01, 1
	
	LFSR 0, 0X100
	LFSR 1, 0X101
	LFSR 2, 0X102 ;START POS
	
	MOVLW 0X02
	MOVWF 0X09, 1
	
	LOOP:
	    MOVF POSTINC1, W
	    MOVWF INDF2
	    MOVF POSTINC0, W
	    
	    BTFSS 0X09, 0, 1
		ADDWF POSTINC2
	    BTFSC 0X09, 0, 1
		SUBWF POSTINC2
	    MOVLW 0X09
	    INCF 0X09, 1, 1
	    CPFSEQ 0X09, 1
		GOTO LOOP
	
	END
	    
