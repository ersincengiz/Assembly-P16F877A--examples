LIST P = 16F877A
INCLUDE "P16F877A.INC"
__CONFIG H'3F31'
DONGU1 EQU h'21'
DONGU2 EQU h'22'
ADCH EQU h'23'
ADCL EQU h'24'
SAYAC EQU h'25'
KAT EQU h'26'
SAG EQU H'27'
ORG 0X00
GOTO BASLA
ORG 0X04

	KESME
BANKSEL PIR1
BTFSS PIR1,ADIF
RETFIE

BANKSEL PIR1
BCF PIR1,ADIF
BANKSEL ADRESH
MOVF ADRESH,0
;MOVLW d'160'
;MOVWF ADRESH
MOVWF ADCH
BANKSEL ADRESL
;MOVLW d'185'
MOVF ADRESL,0
;MOVLW d'20'
;MOVWF ADRESL
BANKSEL ADCL
;MOVLW d'185'
MOVWF ADCL

BANKSEL ADRESH
BTFSS ADRESH,0
GOTO GIT
CALL ARTTIR
GIT
BTFSS ADRESH,1
GOTO KONTROL
CLRF PORTB
CALL GECIKME
BANKSEL ADCON0
BSF ADCON0,GO

RETFIE

	BASLA
BANKSEL TRISE
MOVLW d'255'
MOVWF TRISE
CLRF TRISB
BANKSEL ADCON1
MOVLW b'10000000'
MOVWF ADCON1
BANKSEL ADCON0
MOVLW b'10101001'
MOVWF ADCON0
BANKSEL PORTB
CLRF PORTA
CLRF PORTB
BANKSEL KAT
MOVLW d'10'
MOVWF KAT
CLRF SAYAC
CLRF SAG
BSF STATUS,0
BANKSEL ADRESH
CLRF ADRESH
BANKSEL ADRESL
CLRF ADRESL
BANKSEL PIR1
BCF PIR1,ADIF
BSF INTCON,PEIE
BSF INTCON,GIE
BANKSEL PIE1
BSF PIE1,ADIE
BANKSEL ADCON0
BSF ADCON0,GO
	GOTO DONGU
KONTROL
BANKSEL ADRESH
BTFSS ADRESH,1
GOTO ISLEM
CALL TEKRAR
CLRF PORTB
RETFIE

	KONTROL1
BANKSEL ADCL
BTFSC STATUS,C
GOTO ISLEM
GOTO YAZ

	ISLEM
MOVF KAT,0;0.00488mv DE B�R ARTI� OLUR 10 KG DA B�R DE 0.0488mv OLUR
SUBWF ADCL,1;EN FAZLA 2,443voltda DE 500 KG OLUR 
BTFSC STATUS,C
GOTO TOPLA
GOTO KONTROL1
	
TOPLA
movlw D'10'
ADDWF SAYAC,1
;INCF SAYAC,1
BSF STATUS,C
GOTO KONTROL1

	YAZ
BANKSEL SAYAC
bsf STATUS,0

;DECF SAYAC,1
MOVF SAYAC,0
MOVWF PORTB
CALL GECIKME
CALL GECIKME
CALL GECIKME
MOVF SAG,0
MOVWF PORTB
CALL GECIKME
CALL TEKRAR
BANKSEL SAYAC
CLRF SAYAC
CLRF SAG
RETFIE
ARTTIR
BANKSEL SAYAC;
INCF SAG,1
movlw H'6'
subwf SAYAC,1
BANKSEL ADRESH
RETURN
 TEKRAR
BANKSEL ADCON0
BSF ADCON0,GO
CALL GECIKME
BANKSEL PORTB
RETURN

DONGU 
GOTO DONGU
GECIKME

MOVLW h'A0'
MOVWF DONGU1
DONGU11
 MOVLW h'A0'
MOVWF DONGU2
DONGU22
DECFSZ DONGU2,F
GOTO DONGU22
DECFSZ DONGU1,F
GOTO DONGU11
RETURN
END

