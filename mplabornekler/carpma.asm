LIST P=16F877A
INCLUDE "P16F877A.INC"
__config H'3f31'
SAYI1 EQU h'21'
SAYI2 EQU h'22'
SAYAC EQU h'23'
SONUCL EQU h'24'
SONUCH EQU h'25'
GOSTERGE EQU h'26'


ORG 0X00
CLRF PORTB
BANKSEL TRISB
MOVLW d'0'
MOVWF TRISB

BANKSEL PORTB
CLRF SONUCL
CLRF SONUCH


BANKSEL TRISA
BSF TRISA,0
MOVLW 0X06
MOVWF ADCON1
BANKSEL PORTB

BASLA

MOVLW d'200'
MOVWF SAYI1
MOVWF SONUCL
MOVLW d'2'
MOVWF SAYI2
MOVWF SAYAC


	DONGU
BTFSS STATUS,C 
GOTO DONGU1
GOTO ARTTIR

DONGU1

DECFSZ SAYAC,F
GOTO TOPLA
GOTO BITIR

TOPLA
MOVF SAYI1,0
ADDWF SONUCL,1
GOTO DONGU

ARTTIR 
INCF SONUCH
BCF STATUS,C
GOTO DONGU

 BITIR
BTFSS PORTA,0
GOTO BITIR
GOTO YAK

YAK
BTFSS GOSTERGE,0
GOTO SOL
GOTO SAG
SOL
INCF GOSTERGE
MOVF SONUCL,0
MOVWF PORTB
GOTO BITIR

SAG 
DECF GOSTERGE
MOVF SONUCH,0
MOVWF PORTB
GOTO BITIR
END
