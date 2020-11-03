#include "p16F628a.inc"
 __CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF        
RES_VECT  CODE 0x0000
GOTO START
MAIN_PROG CODE

resultado equ 0x30
lectura equ 0x31
contador equ 0x32
m equ 0x33
band equ 0x34

START:
MOVLW 0x07 ;Apagar comparadores
MOVWF CMCON
BCF STATUS, RP1 ;Cambiar al banco 1
BSF STATUS, RP0
MOVLW b'11111111'
MOVWF TRISA
MOVLW b'00000000'
MOVWF TRISB
BCF STATUS, RP0 ;Regresar al banco 0
GOTO INICIAL

INICIAL:
;Se lee el número.
MOVFW PORTA
MOVWF lectura
;Se inicializa el contador en 1.
MOVLW d'0'
MOVWF contador
;Comprobar que no se tenga el valor 0.
MOVFW lectura
XORLW d'0'
MOVWF band
    
BTFSC band, 0 ;Si es 0, salta a la siguiente instrucción.
GOTO CICLO
BTFSC band, 1
GOTO CICLO
BTFSC band, 2
GOTO CICLO
BTFSC band, 3
GOTO CICLO
BTFSC band, 4
GOTO CICLO
BTFSC band, 5
GOTO CICLO
BTFSC band, 6
GOTO CICLO
BTFSC band, 7
GOTO CICLO
GOTO FINAL
    
CICLO:
INCF contador, 1
;Inicializamos m en el valor que tenga contador
MOVFW contador
MOVWF m
;Inicializamos W
MOVLW d'0'
;Hacemos la multiplicacion
MULTI
ADDWF contador, 0
DECFSZ m
GOTO MULTI
;Almacenamos en resultado
MOVWF resultado

;Comprobar si son iguales
MOVFW lectura
XORWF resultado, 0
MOVWF band

BTFSC band, 0 ;Si es 0 salta a la siguiente instruccion
GOTO CICLO
BTFSC band, 1
GOTO CICLO
BTFSC band, 2
GOTO CICLO
BTFSC band, 3
GOTO CICLO
BTFSC band, 4
GOTO CICLO
BTFSC band, 5
GOTO CICLO
BTFSC band, 6
GOTO CICLO
BTFSC band, 7
GOTO CICLO

FINAL:
MOVFW contador ;Guardamos el valor de resultado en W
MOVWF PORTB ;Mandamos al puerto B el valor de W / Resultado
CLEAR
END