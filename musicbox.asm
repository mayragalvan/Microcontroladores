#include "p16F628a.inc"	    ;incluir librerias relacionadas con el dispositivo
__CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF
; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR

RES_VECT CODE 0x0000	; processor reset vector
GOTO START  ; go to beginning of program
 
INT_VECT CODE 0x004 ; interrupt vector
	;ISR code
 
	DECFSZ CNT
	GOTO $+7
	CALL melody ;llamado de rutina.
	INCF note
	MOVLW D'4' ; 50mS * value notas de cuartos, partitura de 16° nota negra 1seg
	MOVWF CNT
	    ; 256uS * 195 =~ 50mS
	    ; 255 - 195 = 60
	MOVLW D'190' ; preload value
	MOVWF TMR0
	bcf INTCON, T0IF ; clr TMR0 interrupt flag
	retfie ; return from interrupt
	    
MAIN_PROG CODE ; let linker place main program
 
CNT equ 0x20 ;variable contador
note equ 0x21 ;variable contador
i equ 0x30
j equ 0x31
k equ 0x32
ii equ 0x33
jj equ 0x34
kk equ 0x35
 
 
START
 
			    ; setup registers
			    ; setp TMR0 operation
			    ; internal clock, pos edge, prescale 256
			    
    MOVLW 0x07 ;Apagar comparadores
    MOVWF CMCON
    BSF STATUS, RP0
    MOVLW 0x00
    MOVWF TRISA ;se borra
    MOVWF TRISB ;se borra
    MOVLW b'10000111' ;configuración de interrupción temporizada
    MOVWF OPTION_REG
    BCF STATUS, RP0 ; BANK 0
    
			; setup TMR0 INT
    bsf INTCON, GIE	; enable global interrupt
    bsf INTCON, T0IE	; enable TMR0 interrupt
    bcf INTCON, T0IF	; clr TMR0 interrupt flag to turn on,
			; must be cleared after interrupt
			; 256uS * 195 =~ 50mS
			; 255 - 195 = 60
   
    MOVLW D'60'		; preload value
    MOVWF TMR0
    MOVLW D'10'		; 50mS * 20 = 1 Sec.
    MOVWF CNT
    CLRF PORTA
    CLRF PORTB
    CLRF note
    
    
    inicio: ;blink
	
	bcf PORTB,7 ;apagado
	call tiempo
	nop
	nop
	nop
	nop
	bsf PORTB,7 ; encendido
	call tiempo ; rutina de tiempo
	nop
	nop
	goto inicio
	
	
	
    ;rutina de tiempo
    tiempo:
	    movfw i ;calculo de i para la nota
	    movwf ii ; respaldo
    iloop:  movfw j ;calculo de j
	    movwf jj
    jloop:  decfsz jj,f
	    goto jloop
	    decfsz ii,f
	    goto iloop
	    movfw k 
	    movwf kk
	    decfsz kk
	    goto $-1
	    return
	    
	    
    melody:
    
    
	MOVFW note
	XORLW d'197'
	BTFSS STATUS,Z
	GOTO $+2
	CLRF note
	;---------------------------------------------------------------------------------
	;sol3
	MOVFW note 
	XORLW d'0'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14' 
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'1'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;sol3
	MOVFW note
	XORLW d'2'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'3'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;sol3
	MOVFW note
	XORLW d'4'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;sol3
	MOVFW note
	XORLW d'5'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;sol3
	MOVFW note
	XORLW d'6'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'7'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;sol3
	MOVFW note
	XORLW d'8'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'9'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;sol3
	MOVFW note
	XORLW d'10'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'11'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;sol3
	MOVFW note
	XORLW d'12'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;sol3
	MOVFW note
	XORLW d'13'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;sol3
	MOVFW note
	XORLW d'14'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'15'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;-----------------------------------------------------------------------
	;do4
	MOVFW note
	XORLW d'16'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'26'
	MOVWF j
	MOVLW d'14'
	MOVWF k
	RETURN
	;do4
	MOVFW note
	XORLW d'17'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'26'
	MOVWF j
	MOVLW d'14'
	MOVWF k
	RETURN
	;do4
	MOVFW note
	XORLW d'18'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'26'
	MOVWF j
	MOVLW d'14'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'19'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;-----------------------------------------------------------------------
	;si3
	MOVFW note
	XORLW d'20'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'12'
	MOVWF i
	MOVLW d'25'
	MOVWF j
	MOVLW d'18'
	MOVWF k
	RETURN
	;si3
	MOVFW note
	XORLW d'21'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'12'
	MOVWF i
	MOVLW d'25'
	MOVWF j
	MOVLW d'18'
	MOVWF k
	RETURN
	;si3
	MOVFW note
	XORLW d'22'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'12'
	MOVWF i
	MOVLW d'25'
	MOVWF j
	MOVLW d'18'
	MOVWF k
	RETURN
	;si3
	MOVFW note
	XORLW d'23'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'12'
	MOVWF i
	MOVLW d'25'
	MOVWF j
	MOVLW d'18'
	MOVWF k
	RETURN
	;si3
	MOVFW note
	XORLW d'24'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'12'
	MOVWF i
	MOVLW d'25'
	MOVWF j
	MOVLW d'18'
	MOVWF k
	RETURN
	;si3
	MOVFW note
	XORLW d'25'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'12'
	MOVWF i
	MOVLW d'25'
	MOVWF j
	MOVLW d'18'
	MOVWF k
	RETURN
	;si3
	MOVFW note
	XORLW d'26'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'12'
	MOVWF i
	MOVLW d'25'
	MOVWF j
	MOVLW d'18'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'27'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;-----------------------------------------------------------------------
	;fa3
	MOVFW note
	XORLW d'28'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'16'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'4'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'29'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;sol3
	MOVFW note
	XORLW d'30'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'31'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;la3
	MOVFW note
	XORLW d'32'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'13'
	MOVWF i
	MOVLW d'27'
	MOVWF j
	MOVLW d'7'
	MOVWF k
	RETURN
	;la3
	MOVFW note
	XORLW d'33'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'13'
	MOVWF i
	MOVLW d'27'
	MOVWF j
	MOVLW d'7'
	MOVWF k
	RETURN
	;la3
	MOVFW note
	XORLW d'34'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'13'
	MOVWF i
	MOVLW d'27'
	MOVWF j
	MOVLW d'7'
	MOVWF k
	RETURN
	;la3
	MOVFW note
	XORLW d'35'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'13'
	MOVWF i
	MOVLW d'27'
	MOVWF j
	MOVLW d'7'
	MOVWF k
	RETURN
	;la3
	MOVFW note
	XORLW d'36'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'13'
	MOVWF i
	MOVLW d'27'
	MOVWF j
	MOVLW d'7'
	MOVWF k
	RETURN
	;la3
	MOVFW note
	XORLW d'37'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'13'
	MOVWF i
	MOVLW d'27'
	MOVWF j
	MOVLW d'7'
	MOVWF k
	RETURN
	;la3
	MOVFW note
	XORLW d'38'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'13'
	MOVWF i
	MOVLW d'27'
	MOVWF j
	MOVLW d'7'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'39'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;-----------------------------------------------------------------------
	;si3
	MOVFW note
	XORLW d'40'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'12'
	MOVWF i
	MOVLW d'25'
	MOVWF j
	MOVLW d'18'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'41'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;la3
	MOVFW note
	XORLW d'42'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'13'
	MOVWF i
	MOVLW d'27'
	MOVWF j
	MOVLW d'7'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'43'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;sol3
	MOVFW note
	XORLW d'44'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'45'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;fa3
	MOVFW note
	XORLW d'46'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'16'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'4'
	MOVWF k
	RETURN
	;fa3
	MOVFW note
	XORLW d'47'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'16'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'4'
	MOVWF k
	RETURN
	;fa3
	MOVFW note
	XORLW d'48'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'16'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'4'
	MOVWF k
	RETURN
	;fa3
	MOVFW note
	XORLW d'49'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'16'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'4'
	MOVWF k
	RETURN
	;fa3
	MOVFW note
	XORLW d'50'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'16'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'4'
	MOVWF k
	RETURN
	;fa3
	MOVFW note
	XORLW d'51'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'16'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'4'
	MOVWF k
	RETURN
	;fa3
	MOVFW note
	XORLW d'52'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'16'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'4'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'53'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;-----------------------------------------------------------------------
	;sol3
	MOVFW note
	XORLW d'54'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'55'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;sol3
	MOVFW note
	XORLW d'56'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'57'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;sol3
	MOVFW note
	XORLW d'58'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;sol3
	MOVFW note
	XORLW d'59'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;sol3
	MOVFW note
	XORLW d'60'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'61'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;sol3
	MOVFW note
	XORLW d'62'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'63'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;sol3
	MOVFW note
	XORLW d'64'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'65'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;sol3
	MOVFW note
	XORLW d'66'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;sol3
	MOVFW note
	XORLW d'67'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;sol3
	MOVFW note
	XORLW d'68'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'69'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;-----------------------------------------------------------------------
	;do4
	MOVFW note
	XORLW d'70'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'26'
	MOVWF j
	MOVLW d'14'
	MOVWF k
	RETURN
	;do4
	MOVFW note
	XORLW d'71'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'26'
	MOVWF j
	MOVLW d'14'
	MOVWF k
	RETURN
	;do4
	MOVFW note
	XORLW d'72'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'26'
	MOVWF j
	MOVLW d'14'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'73'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;re4
	MOVFW note
	XORLW d'74'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'23'
	MOVWF j
	MOVLW d'12'
	MOVWF k
	RETURN
	;re4
	MOVFW note
	XORLW d'75'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'23'
	MOVWF j
	MOVLW d'12'
	MOVWF k
	RETURN
	;re4
	MOVFW note
	XORLW d'76'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'23'
	MOVWF j
	MOVLW d'12'
	MOVWF k
	RETURN
	;re4
	MOVFW note
	XORLW d'77'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'23'
	MOVWF j
	MOVLW d'12'
	MOVWF k
	RETURN
	;re4
	MOVFW note
	XORLW d'78'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'23'
	MOVWF j
	MOVLW d'12'
	MOVWF k
	RETURN
	;re4
	MOVFW note
	XORLW d'79'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'23'
	MOVWF j
	MOVLW d'12'
	MOVWF k
	RETURN
	;re4
	MOVFW note
	XORLW d'80'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'23'
	MOVWF j
	MOVLW d'12'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'81'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;-----------------------------------------------------------------------
	;si3
	MOVFW note
	XORLW d'82'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'12'
	MOVWF i
	MOVLW d'25'
	MOVWF j
	MOVLW d'18'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'83'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;do4
	MOVFW note
	XORLW d'84'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'26'
	MOVWF j
	MOVLW d'14'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'85'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;re4
	MOVFW note
	XORLW d'86'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'23'
	MOVWF j
	MOVLW d'12'
	MOVWF k
	RETURN
	;re4
	MOVFW note
	XORLW d'87'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'23'
	MOVWF j
	MOVLW d'12'
	MOVWF k
	RETURN
	;re4
	MOVFW note
	XORLW d'88'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'23'
	MOVWF j
	MOVLW d'12'
	MOVWF k
	RETURN
	;re4
	MOVFW note
	XORLW d'89'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'23'
	MOVWF j
	MOVLW d'12'
	MOVWF k
	RETURN
	;re4
	MOVFW note
	XORLW d'90'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'23'
	MOVWF j
	MOVLW d'12'
	MOVWF k
	RETURN
	;re4
	MOVFW note
	XORLW d'91'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'23'
	MOVWF j
	MOVLW d'12'
	MOVWF k
	RETURN
	;re4
	MOVFW note
	XORLW d'92'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'23'
	MOVWF j
	MOVLW d'12'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'93'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;-----------------------------------------------------------------------
	;mi4
	MOVFW note
	XORLW d'94'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'20'
	MOVWF j
	MOVLW d'14'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'95'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;re4
	MOVFW note
	XORLW d'96'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'23'
	MOVWF j
	MOVLW d'12'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'97'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;do4
	MOVFW note
	XORLW d'98'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'26'
	MOVWF j
	MOVLW d'14'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'99'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;si3
	MOVFW note
	XORLW d'100'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'12'
	MOVWF i
	MOVLW d'25'
	MOVWF j
	MOVLW d'18'
	MOVWF k
	RETURN
	;si3
	MOVFW note
	XORLW d'101'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'12'
	MOVWF i
	MOVLW d'25'
	MOVWF j
	MOVLW d'18'
	MOVWF k
	RETURN
	;si3
	MOVFW note
	XORLW d'102'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'12'
	MOVWF i
	MOVLW d'25'
	MOVWF j
	MOVLW d'18'
	MOVWF k
	RETURN
	;si3
	MOVFW note
	XORLW d'103'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'12'
	MOVWF i
	MOVLW d'25'
	MOVWF j
	MOVLW d'18'
	MOVWF k
	RETURN
	;si3
	MOVFW note
	XORLW d'104'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'12'
	MOVWF i
	MOVLW d'25'
	MOVWF j
	MOVLW d'18'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'105'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;-----------------------------------------------------------------------
	;sol4
	MOVFW note
	XORLW d'106'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'16'
	MOVWF j
	MOVLW d'18'
	MOVWF k
	RETURN
	;sol4
	MOVFW note
	XORLW d'107'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'16'
	MOVWF j
	MOVLW d'18'
	MOVWF k
	RETURN
	;sol4
	MOVFW note
	XORLW d'108'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'16'
	MOVWF j
	MOVLW d'18'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'109'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;fa4
	MOVFW note
	XORLW d'110'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'19'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;fa4
	MOVFW note
	XORLW d'111'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'19'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;fa4
	MOVFW note
	XORLW d'112'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'19'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;fa4
	MOVFW note
	XORLW d'113'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'19'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;fa4
	MOVFW note
	XORLW d'114'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'19'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'115'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;re4
	MOVFW note
	XORLW d'116'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'23'
	MOVWF j
	MOVLW d'12'
	MOVWF k
	RETURN
	;re4
	MOVFW note
	XORLW d'117'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'23'
	MOVWF j
	MOVLW d'12'
	MOVWF k
	RETURN
	;re4
	MOVFW note
	XORLW d'118'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'23'
	MOVWF j
	MOVLW d'12'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'119'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;si3
	MOVFW note
	XORLW d'120'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'12'
	MOVWF i
	MOVLW d'25'
	MOVWF j
	MOVLW d'18'
	MOVWF k
	RETURN
	;si3
	MOVFW note
	XORLW d'121'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'12'
	MOVWF i
	MOVLW d'25'
	MOVWF j
	MOVLW d'18'
	MOVWF k
	RETURN
	;si3
	MOVFW note
	XORLW d'122'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'12'
	MOVWF i
	MOVLW d'25'
	MOVWF j
	MOVLW d'18'
	MOVWF k
	RETURN
	;si3
	MOVFW note
	XORLW d'123'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'12'
	MOVWF i
	MOVLW d'25'
	MOVWF j
	MOVLW d'18'
	MOVWF k
	RETURN
	;si3
	MOVFW note
	XORLW d'124'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'12'
	MOVWF i
	MOVLW d'25'
	MOVWF j
	MOVLW d'18'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'125'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;si3
	MOVFW note
	XORLW d'126'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'12'
	MOVWF i
	MOVLW d'25'
	MOVWF j
	MOVLW d'18'
	MOVWF k
	RETURN
	;si3
	MOVFW note
	XORLW d'127'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'12'
	MOVWF i
	MOVLW d'25'
	MOVWF j
	MOVLW d'18'
	MOVWF k
	RETURN
	;si3
	MOVFW note
	XORLW d'128'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'12'
	MOVWF i
	MOVLW d'25'
	MOVWF j
	MOVLW d'18'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'129'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;sol3
	MOVFW note
	XORLW d'130'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;sol3
	MOVFW note
	XORLW d'131'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;sol3
	MOVFW note
	XORLW d'132'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;sol3
	MOVFW note
	XORLW d'133'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;sol3
	MOVFW note
	XORLW d'134'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;sol3
	MOVFW note
	XORLW d'135'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;sol3
	MOVFW note
	XORLW d'136'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'14'
	MOVWF i
	MOVLW d'28'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'137'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;-----------------------------------------------------------------------xDDD
	;la3
	MOVFW note
	XORLW d'138'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'13'
	MOVWF i
	MOVLW d'27'
	MOVWF j
	MOVLW d'7'
	MOVWF k
	RETURN
	;la3
	MOVFW note
	XORLW d'139'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'13'
	MOVWF i
	MOVLW d'27'
	MOVWF j
	MOVLW d'7'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'140'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;re4
	MOVFW note
	XORLW d'141'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'23'
	MOVWF j
	MOVLW d'12'
	MOVWF k
	RETURN
	;re4
	MOVFW note
	XORLW d'142'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'23'
	MOVWF j
	MOVLW d'12'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'143'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;fa4
	MOVFW note
	XORLW d'144'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'19'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;fa4
	MOVFW note
	XORLW d'145'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'19'
	MOVWF j
	MOVLW d'11'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'146'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;re4
	MOVFW note
	XORLW d'147'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'23'
	MOVWF j
	MOVLW d'12'
	MOVWF k
	RETURN
	;re4
	MOVFW note
	XORLW d'148'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'23'
	MOVWF j
	MOVLW d'12'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'149'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;sol4
	MOVFW note
	XORLW d'150'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'16'
	MOVWF j
	MOVLW d'18'
	MOVWF k
	RETURN
	;sol4
	MOVFW note
	XORLW d'151'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'16'
	MOVWF j
	MOVLW d'18'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'152'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	;si4
	MOVFW note
	XORLW d'153'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'12'
	MOVWF j
	MOVLW d'19'
	MOVWF k
	RETURN
	;si4
	MOVFW note
	XORLW d'154'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'12'
	MOVWF j
	MOVLW d'19'
	MOVWF k
	RETURN
	;si4
	MOVFW note
	XORLW d'155'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'12'
	MOVWF j
	MOVLW d'19'
	MOVWF k
	RETURN
	;si4
	MOVFW note
	XORLW d'156'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'12'
	MOVWF j
	MOVLW d'19'
	MOVWF k
	RETURN
	;si4
	MOVFW note
	XORLW d'157'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'11'
	MOVWF i
	MOVLW d'12'
	MOVWF j
	MOVLW d'19'
	MOVWF k
	RETURN
	;esp
	MOVFW note
	XORLW d'158'
	BTFSS STATUS,Z 
	GOTO $+8
	MOVLW d'0'
	MOVWF i
	MOVLW d'0'
	MOVWF j
	MOVLW d'0'
	MOVWF k
	RETURN
	
	;-----------------------------------------------------------------------chidooo
    END