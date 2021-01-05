#include "p16F887.inc"   ; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
 	__CONFIG	_CONFIG1,	_INTRC_OSC_NOCLKOUT & _WDT_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOR_OFF & _IESO_ON & _FCMEN_ON & _LVP_OFF 
 	__CONFIG	_CONFIG2,	_BOR40V & _WRT_OFF

counter equ 0x20
i equ 0x21
j equ 0x22
 
ANALOG equ 0x23
cent equ 0x24
dece equ 0x25
unid equ 0x26
 
num equ 0x28

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

MAIN_PROG CODE                      ; let linker place main program

START

INITIATION 

    BANKSEL ANSEL ;
    MOVLW b'00000001'
    MOVWF ANSEL ;Analog A0
    CLRF ANSELH
    BANKSEL TRISA ;
    MOVLW b'11111111'
    MOVWF TRISA ; Configuration of PORT A as input 
    CLRF TRISB ; Configuration of PORT B as output (To show ADC convertion with LEDs) 
    CLRF TRISD ; Configuration of PORT D as output (To show ADC convertion with LEDs)
    CLRF TRISC
     
    MOVLW b'10000000' ; A/D Result Format (Right justified)
    MOVWF ADCON1
 
    BCF STATUS,RP0 ; Selection of memory bank 0
    CLRF PORTB ; Setting PORTB to "0000000"

    MOVLW b'11000001' ; Selection of conversion clock (11: Internal Oscillator), analog channel (AN0), A/D conversion not in progress
    MOVWF ADCON0 
    
    CLRF PORTB
    CLRF PORTD 
    BCF PORTC,1
    BCF PORTC,0
    
INITLCD ;--------------------------INIT LCD
    BCF PORTC,0		;reset
    MOVLW 0x01
    MOVWF PORTD
    
    BSF PORTC,1		;exec
    CALL time
    BCF PORTC,1
    CALL time
    
    MOVLW 0x0C		;first line
    MOVWF PORTD
    
    BSF PORTC,1		;exec
    CALL time
    BCF PORTC,1
    CALL time
         
    MOVLW 0x3C		;cursor mode
    MOVWF PORTD
    
    BSF PORTC,1		;exec
    CALL time
    BCF PORTC,1
    CALL time 

    
    ;----------Temperatura
    BCF PORTC,0		;command mode
    CALL time
    
    MOVLW 0x80		;LCD position 
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL time

    MOVLW 'T'
    MOVWF PORTD
    CALL exec
    MOVLW 'e'
    MOVWF PORTD
    CALL exec
    MOVLW 'm'
    MOVWF PORTD
    CALL exec
    MOVLW 'p'
    MOVWF PORTD
    CALL exec
    MOVLW 'e'
    MOVWF PORTD
    CALL exec
    MOVLW 'r'
    MOVWF PORTD
    CALL exec
    MOVLW 'a'
    MOVWF PORTD
    CALL exec
    MOVLW 't'
    MOVWF PORTD
    CALL exec
    MOVLW 'u'
    MOVWF PORTD
    CALL exec
    MOVLW 'r'
    MOVWF PORTD
    CALL exec
    MOVLW 'a'
    MOVWF PORTD
    CALL exec
    MOVLW ':'
    MOVWF PORTD
    CALL exec
    ;----------------------------------
    
DELAY_INIT 
    MOVLW d'19'
    MOVWF counter 

DELAY_LOOP 
    DECFSZ counter,f 
    GOTO DELAY_LOOP 
 
    BSF ADCON0,1 ; Set A/D conversion in progress

ADC_CONVERT 
    BTFSC ADCON0,1
    GOTO ADC_CONVERT 
    
    
     
    banksel ADRESL ; Select the bank where the ADRESL resides
    MOVF ADRESL,W  ; Move the result of ADRESL to working register 
    banksel ADRESH ; Select the bank where the PORTB, PORTD and ADRESH reside

;    MOVWF PORTB    ; Move to PORTB what it is in the working register
;    MOVF ADRESH,W  ; Move the result of ADRESH to working register
; 
;    MOVWF PORTD    ; Move to PORTD what it is in the working register
    
    MOVWF ANALOG
    ;----------------Obtener la mitad del resultado
    MOVLW 2
    CLRF num

DIV
    INCF num,f
    SUBWF ANALOG,f
    BTFSC STATUS,C
    GOTO DIV
    DECF num,f
    MOVFW num
    MOVWF ANALOG  
    ;----------------------------------------------------
    
    MOVWF PORTB
    
    ;----------------Convertir a BCD
    CLRF cent
    CLRF dece
    CLRF unid

    
CENTENAS1
    movlw d'100'      ;Asignación de valor d a 'w' 
    subwf ANALOG,W     ;Subtracción de 'd' (W)
    btfss STATUS,C    ;Resto menor que d'100'?
    goto DECENAS1     ;SI
    movwf ANALOG      ;NO, Salvar
    incf cent,1	      ;Incrementa el contador de centenas BCD
    goto CENTENAS1    ;Realiza otra resta

DECENAS1
    movlw d'10'       
    subwf ANALOG,W    
    btfss STATUS,C    
    goto UNIDADES1    
    movwf ANALOG      
    incf dece,1        
    goto DECENAS1     

UNIDADES1
    movf ANALOG,W      ;El resto son la Unidades BCD
    movwf unid
    ;clrf Resto
	
    
    
    
;Rutina que obtiene el equivalente en ASCII	   
OBTEN_ASCII
    movlw h'30' 
    iorwf unid,f      
    iorwf dece,f
    iorwf cent,f   
    ;----------------------------------------------------
    
    ;-----------------Imprimir Temperatura---------------
    BCF PORTC,0		;command mode
    CALL time
    
    MOVLW 0xC9		;LCD position 
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL time

    MOVFW cent
    MOVWF PORTD
    CALL exec
    MOVFW dece
    MOVWF PORTD
    CALL exec
    MOVFW unid
    MOVWF PORTD
    CALL exec
    MOVLW b'11011111'
    MOVWF PORTD
    CALL exec
    MOVLW 'C'
    MOVWF PORTD
    CALL exec
    ;----------------------------------------------------
    GOTO DELAY_INIT
;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
exec
    BSF PORTC,1		;exec
    CALL time
    BCF PORTC,1
    CALL time
    RETURN
    
time
    CLRF i
    MOVLW d'10'
    MOVWF j
ciclo    
    MOVLW d'80'
    MOVWF i
    DECFSZ i
    GOTO $-1
    DECFSZ j
    GOTO ciclo
    RETURN    
    
    END