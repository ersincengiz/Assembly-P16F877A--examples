LIST P = 16F877A
INCLUDE "P16F877A.INC"
__CONFIG H'3F31'
SAYAC EQU H'21'
KARAR EQU H'22'
ORG 0X00
GOTO BASLA
ORG 0X04
BTFSS PIR1,TMR1IF
RETFIE
BCF PIR1,TMR1IF
BANKSEL TMR1H
MOVLW h'3C'
MOVWF TMR1H
MOVLW h'B0'
MOVWF TMR1L
DECFSZ SAYAC,F
RETFIE
MOVLW D'2'
MOVWF SAYAC
BTFSS KARAR,0
GOTO SOL
GOTO SAG
KESMEBIT
RETFIE


BASLA
BANKSEL TRISB
CLRF TRISB
BANKSEL PORTC
CLRF PORTC
CLRF KARAR
MOVLW D'2'
MOVWF SAYAC
BANKSEL INTCON
BSF INTCON,GIE
BSF INTCON,PEIE
BANKSEL PIE1
BSF PIE1,TMR1IE
BANKSEL T1CON
MOVLW h'11'
MOVWF T1CON
BANKSEL PORTC
MOVLW D'1'
MOVWF PORTB
DONGU
GOTO DONGU

SOL
BTFSS PORTB,7
GOTO YAP2
GOTO YAP1
YAP1
INCF KARAR,F
GOTO KESMEBIT

YAP2
RLF PORTB,F
BCF STATUS,C
GOTO KESMEBIT

SAG
BTFSS PORTB,0
GOTO YAP3
GOTO YAP4

YAP3
RRF PORTB,F
BCF STATUS,C
GOTO KESMEBIT
YAP4
CLRF KARAR
GOTO KESMEBIT
END