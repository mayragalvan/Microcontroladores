#include "p16F628a.inc" ; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF
 ;configuracion del dispositivo en OFF y la frecuencia de oscilador
 ;es la del "reloj del oscilador interno" (INTOSCCLK)
 
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

; TODO ADD INTERRUPTS HERE IF USED

MAIN_PROG CODE; let linker place main program
 
 dado equ 0x30
 cont equ 0x31

START		;inicio del programa

    
    MOVLW 0X07	         ;Apagar comparadores
    MOVWF CMCON
    BCF STATUS, RP1	;Cambiar al banco 1 apagado el RP1
    BSF STATUS, RP0	;Y encendido el RP0
    MOVLW b'00000001'	;Establecer puerto A como entrada (Solo el primer bit)
    MOVWF TRISA
    MOVLW b'00000000'	;Establecer puerto B como salida (los 8 bits del puerto)
    MOVWF TRISB
    BCF STATUS,RP0	;Regresar al banco 0 apagando el RP0
    
INICIO
 ; Aqui va la rutina principal
 
   MOVLW d'255'
   MOVWF cont
   MOVLW d'6'
   MOVWF dado
   
   
DESPLEGAR
   
   MOVFW dado
   MOVWF PORTB
   
BOTON 
	BTFSS PORTA,0
	GOTO BOTON
DELAY
    DECFSZ cont,f
    GOTO DELAY
    MOVLW d'255'
    MOVWF cont
	
    DECFSZ dado,f
    GOTO DESPLEGAR; 
    GOTO INICIO
    END