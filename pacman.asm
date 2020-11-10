#include "p16F887.inc"   ; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
 	__CONFIG	_CONFIG1,	_INTRC_OSC_NOCLKOUT & _WDT_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOR_OFF & _IESO_ON & _FCMEN_ON & _LVP_OFF 
 	__CONFIG	_CONFIG2,	_BOR40V & _WRT_OFF

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

MAIN_PROG CODE                      ; let linker place main program

i equ 0x30
j equ 0x31
k equ 0x32
c equ 0x33

START

    BANKSEL PORTA ;
    CLRF PORTA ;Init PORTA
    BANKSEL ANSEL ;
    CLRF ANSEL ;digital I/O
    CLRF ANSELH
    BANKSEL TRISA ;
    CLRF TRISA
    CLRF TRISB
    CLRF TRISC
    CLRF TRISD
    CLRF TRISE
    BCF STATUS,RP1
    BCF STATUS,RP0
    CLRF PORTA
    CLRF PORTB
    CLRF PORTC
    CLRF PORTD
    CLRF PORTE
    MOVLW D'30'
    MOVWF c
    
INICIO
    PACMANC:
    ;CERRADO
    MOVLW B'01111110'
    MOVWF PORTB
    MOVLW B'00111100'
    MOVWF PORTD
    CALL TIEMPO
    
    MOVLW B'10111101'
    MOVWF PORTB
    MOVLW B'01111110'
    MOVWF PORTD
    CALL TIEMPO
   
    MOVLW B'11101011'
    MOVWF PORTB
    MOVLW B'11111111'
    MOVWF PORTD
    CALL TIEMPO
    
    MOVLW B'11110111'
    MOVWF PORTB
    MOVLW B'11110000' ;11110000
    MOVWF PORTD
    CALL TIEMPO

    MOVLW B'11011111'
    MOVWF PORTB
    MOVLW B'11011111'
    MOVWF PORTD
    CALL TIEMPO
    
    DECFSZ c, 1
    GOTO PACMANC
    MOVLW D'30'
    MOVWF c
    
    PACMANA:
    ;ABIERTO
    MOVLW B'01111110'
    MOVWF PORTB
    MOVLW B'00111100'
    MOVWF PORTD
    CALL TIEMPO
    
    MOVLW B'10111101'
    MOVWF PORTB
    MOVLW B'01111110'
    MOVWF PORTD
    CALL TIEMPO
    
    MOVLW B'11011111'
    MOVWF PORTB
    MOVLW B'11011100'
    MOVWF PORTD
    CALL TIEMPO
    
    MOVLW B'11111011'
    MOVWF PORTB
    MOVLW B'11111100'
    MOVWF PORTD
    CALL TIEMPO
    
    MOVLW B'11100111'
    MOVWF PORTB
    MOVLW B'11111000'
    MOVWF PORTD
    CALL TIEMPO
    
    DECFSZ c, 1
    GOTO PACMANA
    MOVLW D'30'
    MOVWF c
    GOTO INICIO
    
TIEMPO
    MOVLW d'1'
    MOVWF i
loopj:
    MOVLW d'2'
    MOVWF j
loopk:
    MOVLW d'200'
    MOVWF k
loopi:
    NOP
    NOP
    DECFSZ k, 1
    GOTO loopi
    DECFSZ j, 1
    GOTO loopk
    DECFSZ i, 1
    GOTO loopj
    RETURN
    
END