#include "p16F887.inc"   ; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
 	__CONFIG	_CONFIG1,	_INTRC_OSC_NOCLKOUT & _WDT_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOR_OFF & _IESO_ON & _FCMEN_ON & _LVP_OFF 
 	__CONFIG	_CONFIG2,	_BOR40V & _WRT_OFF

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

    BCF PORTC,0		;reset
    MOVLW 0x01
    MOVWF PORTD
    
    BSF PORTC,1		;exec
    CALL TIME
    BCF PORTC,1
    CALL TIME
  
    GOTO    START

MAIN_PROG CODE                      ; let linker place main program

START

i equ 0x30
j equ 0x31
k equ 0x32
N0 equ 0x40
N1 equ 0x41
N2 equ 0x42
N3 equ 0x43
N4 equ 0x44
N5 equ 0x45
N6 equ 0x46
N7 equ 0x47
INDX equ 0x48
M equ 0x49 ;APUNTA A CASILLA DONDE TE QUEDAS ESCRIBIENDO

START

    BANKSEL PORTA ;
    CLRF PORTA ;Init PORTA
    BANKSEL ANSEL ;
    CLRF ANSEL ;digital I/O
    CLRF ANSELH
    BANKSEL TRISA ;
    MOVLW d'0'
    MOVWF TRISA 
    CLRF TRISB
    CLRF TRISC
    CLRF TRISD
    MOVLW b'11111100'
    CLRF TRISE
    BCF STATUS,RP1
    BCF STATUS,RP0
    BCF PORTC,1
    BCF PORTC,0
    
INITLCD
        
    MOVLW 0X3F ;APUNTAMOS A UNA CASILLA ANTES DE NUESTRA VARIABLE
    MOVWF INDX ;
    
    MOVLW 0XD8       ;0XD8
    MOVWF M ;APUNTA A LA PRIMERA LOCALIDAD DE MEMORIA

    BCF PORTC,0		;reset
    MOVLW 0x01
    MOVWF PORTD
    
    BSF PORTC,1		;exec
    CALL TIME
    BCF PORTC,1
    CALL TIME
    
    MOVLW 0x0C		;first line
    MOVWF PORTD
    
    BSF PORTC,1		;exec
    CALL TIME
    BCF PORTC,1
    CALL TIME
         
    MOVLW 0x3C		;cursor mode
    MOVWF PORTD
    
    BSF PORTC,1		;exec
    CALL TIME
    BCF PORTC,1
    CALL TIME
    
INICIO	
    BCF PORTE, 0
    BCF PORTE, 1
    BCF PORTC,0		;command mode
    CALL TIME
    
    MOVLW 0x80		;LCD position
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL TIME
    
    ;MENSAJE DE CONTRASEÑA
    MOVLW 'P'
    MOVWF PORTD
    CALL exec
    MOVLW 'A'
    MOVWF PORTD
    CALL exec
    MOVLW 'S'
    MOVWF PORTD
    CALL exec
    MOVLW 'S'
    MOVWF PORTD
    CALL exec
    MOVLW 'W'
    MOVWF PORTD
    CALL exec
    MOVLW 'O'
    MOVWF PORTD
    CALL exec
    MOVLW 'R'
    MOVWF PORTD
    CALL exec
    MOVLW 'D'
    MOVWF PORTD
    CALL exec
    MOVLW ':'
    MOVWF PORTD
    CALL exec
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BCF PORTC,0		;command mode
    CALL TIME
    
    MOVLW 0xC8		;LCD position    C8
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL TIME
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;CONTRASEÑA 35642040
    MOVLW '3'
    MOVWF PORTD
    CALL exec
    MOVLW '5'
    MOVWF PORTD
    CALL exec
    MOVLW '6'
    MOVWF PORTD
    CALL exec
    MOVLW '4'
    MOVWF PORTD
    CALL exec
    MOVLW '2'
    MOVWF PORTD
    CALL exec
    MOVLW '0'
    MOVWF PORTD
    CALL exec
    MOVLW '4'
    MOVWF PORTD
    CALL exec
    MOVLW '0'
    MOVWF PORTD
    CALL exec
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BCF PORTC,0		;command mode
    CALL TIME
    
    MOVLW 0x90		;LCD position 
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL TIME
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;MENSAJE PARA INGRESAR
    MOVLW 'I'
    MOVWF PORTD
    CALL exec
    MOVLW 'N'
    MOVWF PORTD
    CALL exec
    MOVLW 'G'
    MOVWF PORTD
    CALL exec
    MOVLW 'R'
    MOVWF PORTD
    CALL exec
    MOVLW 'E'
    MOVWF PORTD
    CALL exec
    MOVLW 'S'
    MOVWF PORTD
    CALL exec
    MOVLW 'E'
    MOVWF PORTD
    CALL exec
    MOVLW ' '
    MOVWF PORTD
    CALL exec
    MOVLW 'P'
    MOVWF PORTD
    CALL exec
    MOVLW 'A'
    MOVWF PORTD
    CALL exec
    MOVLW 'S'
    MOVWF PORTD
    CALL exec
    MOVLW 'S'
    MOVWF PORTD
    CALL exec
    MOVLW 'W'
    MOVWF PORTD
    CALL exec
    MOVLW 'O'
    MOVWF PORTD
    CALL exec
    MOVLW 'R'
    MOVWF PORTD
    CALL exec
    MOVLW 'D'
    MOVWF PORTD
    CALL exec
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BCF PORTC,0		;command mode
    CALL TIME
    
    MOVLW 0xD8		;LCD position  D8
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL TIME
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    CALL INGRESO  
    ;sintaxis de el if de resta de 0
    BCF PORTC,0		;command mode
    CALL TIME
    MOVLW 0x81		;LCD position
    MOVWF PORTD
    CALL exec
    GOTO INICIO

    ;LECTURA     
INGRESO
    BSF PORTA,6
    BSF PORTA,5
    BSF PORTA,4
    BSF PORTA,3
    BSF PORTA,2
    BSF PORTA,1
    BSF PORTA,0
    
    BCF PORTA,3
    CALL RA
    CALL TIME
    BSF PORTA,3
    
    BCF PORTA,2
    CALL RB
    CALL TIME
    BSF PORTA,2
    
    BCF PORTA,1
    CALL RC
    CALL TIME
    BSF PORTA,1
    
    BCF PORTA,0
    CALL DD
    CALL TIME
    BCF PORTA,0
    GOTO INGRESO

    
;MATRIZ    
RA
    BTFSS PORTA,4
    CALL NUM1
    BTFSS PORTA,5
    CALL NUM2
    BTFSS PORTA,6
    CALL NUM3
    RETURN
    
RB
    BTFSS PORTA,4
    CALL NUM4
    BTFSS PORTA,5
    CALL NUM5
    BTFSS PORTA,6
    CALL NUM6
    RETURN
    
RC
    BTFSS PORTA,4
    CALL NUM7
    BTFSS PORTA,5
    CALL NUM8
    BTFSS PORTA,6
    CALL NUM9
    RETURN
    
DD
    BTFSS PORTA,4
    CALL REGRESAR
    BTFSS PORTA,5
    CALL NUM0
    BTFSS PORTA,6
    CALL ENTER
    RETURN

;GUARDADO DE NÚMERO INGRESADO
NUM1
    INCF INDX ;LOCALIDAD 0X40
    MOVFW INDX
    MOVWF FSR ;APUNTA A LA LOCALIDAD 0X40
    MOVLW '1'
    MOVWF INDF ;SE PASA EL VALOR DE W A F
    MOVWF PORTD
    CALL exec
    BSF PORTA,4
    CALL TIMENUM
    return    
NUM2
    INCF INDX
    MOVFW INDX
    MOVWF FSR
    MOVLW '2'
    MOVWF INDF
    MOVWF PORTD
    CALL exec
    BSF PORTA,5
    CALL TIMENUM
    return  
NUM3
    INCF INDX
    MOVFW INDX
    MOVWF FSR
    MOVLW '3'
    MOVWF INDF
    MOVWF PORTD
    CALL exec
    BSF PORTA,6
    CALL TIMENUM
    return  
NUM4
    INCF INDX
    MOVFW INDX
    MOVWF FSR
    MOVLW '4'
    MOVWF INDF
    MOVWF PORTD
    CALL exec
    BSF PORTA,4
    CALL TIMENUM
    return  
NUM5
    INCF INDX
    MOVFW INDX
    MOVWF FSR
    MOVLW '5'
    MOVWF INDF
    MOVWF PORTD
    CALL exec
    BSF PORTA,5
    CALL TIMENUM
    return  
NUM6
    INCF INDX
    MOVFW INDX
    MOVWF FSR
    MOVLW '6'
    MOVWF INDF
    MOVWF PORTD
    CALL exec
    BSF PORTA,6
    CALL TIMENUM
    return  
NUM7
    INCF INDX
    MOVFW INDX
    MOVWF FSR
    MOVLW '7'
    MOVWF INDF
    MOVWF PORTD
    CALL exec
    BSF PORTA,4
    CALL TIMENUM
    return 
NUM8
    INCF INDX
    MOVFW INDX
    MOVWF FSR
    MOVLW '8'
    MOVWF INDF
    MOVWF PORTD
    CALL exec
    BSF PORTA,5
    CALL TIMENUM
    return 
NUM9
    INCF INDX
    MOVFW INDX
    MOVWF FSR
    MOVLW '9'
    MOVWF INDF
    MOVWF PORTD
    CALL exec
    BSF PORTA,6
    CALL TIMENUM
    return  
NUM0
    INCF INDX
    MOVFW INDX
    MOVWF FSR
    MOVLW '0'
    MOVWF INDF
    MOVWF PORTD
    CALL exec
    BSF PORTA,5
    CALL TIMENUM
    return  

REGRESAR
    MOVLW 0x40
    SUBWF INDX, 0
    ADDWF M, 1
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BCF PORTC, 0	;command mode
    CALL TIME
    
    MOVFW M		;LCD position
    MOVWF PORTD
    CALL exec
    
    BSF PORTC, 0	;data mode
    CALL TIME
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    MOVLW ' '
    MOVWF PORTD
    CALL exec
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BCF PORTC, 0	;command mode
    CALL TIME
    
    MOVFW M		;LCD position
    MOVWF PORTD
    CALL exec
    
    BSF PORTC, 0	;data mode
    CALL TIME
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    MOVLW 0xD8
    MOVWF M
    DECF INDX, 1
    
    BSF PORTA, 5
    CALL TIMENUM
    
    RETURN

;CONTRASEÑA 35642040
ENTER
    MOVLW '3'
    XORWF N0, 1
    INCF N0, 1
    DECFSZ N0
    GOTO ER
    
    MOVLW '5'
    XORWF N1, 1
    INCF N1, 1
    DECFSZ N1
    GOTO ER
    
    MOVLW '6'
    XORWF N2, 1
    INCF N2, 1
    DECFSZ N2
    GOTO ER
    
    MOVLW '4'
    XORWF N3, 1
    INCF N3, 1
    DECFSZ N3
    GOTO ER
    
    MOVLW '2'
    XORWF N4, 1
    INCF N4, 1
    DECFSZ N4
    GOTO ER
    
    MOVLW '0'
    XORWF N5, 1
    INCF N5, 1
    DECFSZ N5
    GOTO ER
    
    MOVLW '4'
    XORWF N6, 1
    INCF N6, 1
    DECFSZ N6
    GOTO ER
    
    MOVLW '0'
    XORWF N7, 1
    INCF N7, 1
    DECFSZ N7
    GOTO ER
    GOTO CORRECT

    BSF PORTA, 6
    CALL TIME   ;TIM3
    RETURN

exec
    BSF PORTC,1		;exec
    CALL TIME
    BCF PORTC,1
    CALL TIME
    RETURN 
ER
    BCF PORTC, 0
    MOVLW 0x01
    MOVWF PORTD
    CALL exec
    BCF PORTC,0		;command mode
    CALL TIME
    
    MOVLW 0xC3		;LCD position
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL TIME
    ;MENSAJE DE ERROR
    MOVLW '*'
    MOVWF PORTD
    CALL exec
    MOVLW ' '
    MOVWF PORTD
    CALL exec
    MOVLW 'A'
    MOVWF PORTD
    CALL exec
    MOVLW 'C'
    MOVWF PORTD
    CALL exec
    MOVLW 'C'
    MOVWF PORTD
    CALL exec
    MOVLW 'E'
    MOVWF PORTD
    CALL exec
    MOVLW 'S'
    MOVWF PORTD
    CALL exec
    MOVLW 'O'
    MOVWF PORTD
    CALL exec   
    
    BCF PORTC,0		;command mode
    CALL TIME
    
    MOVLW 0x93		;LCD position
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL TIME
    
    MOVLW 'B'
    MOVWF PORTD
    CALL exec
    MOVLW 'L'
    MOVWF PORTD
    CALL exec
    MOVLW 'O'
    MOVWF PORTD
    CALL exec
    MOVLW 'Q'
    MOVWF PORTD
    CALL exec
    MOVLW 'U'
    MOVWF PORTD
    CALL exec
    MOVLW 'E'
    MOVWF PORTD
    CALL exec
    MOVLW 'A'
    MOVWF PORTD
    CALL exec
    MOVLW 'D'
    MOVWF PORTD
    CALL exec
    MOVLW 'O'
    MOVWF PORTD
    CALL exec
    MOVLW ' '
    MOVWF PORTD
    CALL exec
    MOVLW '*'
    MOVWF PORTD
    CALL exec
ROJO
    BCF PORTE, 0
    BSF PORTE, 1
    GOTO ROJO

CORRECT
    BCF PORTC, 0
    MOVLW 0x01
    MOVWF PORTD
    CALL exec
    
    BCF PORTC,0		;command mode
    CALL TIME
    
    MOVLW 0xC4		;LCD position
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL TIME
    
    ;MENSAJE DE INGRESO CORRECTO
    MOVLW 'I'
    MOVWF PORTD
    CALL exec
    MOVLW 'N'
    MOVWF PORTD
    CALL exec
    MOVLW 'G'
    MOVWF PORTD
    CALL exec
    MOVLW 'R'
    MOVWF PORTD
    CALL exec
    MOVLW 'E'
    MOVWF PORTD
    CALL exec
    MOVLW 'S'
    MOVWF PORTD
    CALL exec
    MOVLW 'O'
    MOVWF PORTD
    CALL exec
    
    BCF PORTC,0		;command mode
    CALL TIME
    MOVLW 0x94		;LCD position
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL TIME
    
    ;MENSAJE DE INGRESO CORRECTO
    MOVLW 'E'
    MOVWF PORTD
    CALL exec
    MOVLW 'X'
    MOVWF PORTD
    CALL exec
    MOVLW 'I'
    MOVWF PORTD
    CALL exec
    MOVLW 'T'
    MOVWF PORTD
    CALL exec
    MOVLW 'O'
    MOVWF PORTD
    CALL exec
    MOVLW 'S'
    MOVWF PORTD
    CALL exec
    MOVLW '0'
    MOVWF PORTD
    CALL exec
    MOVLW ' '
    MOVWF PORTD
    CALL exec
    MOVLW ' '
    MOVWF PORTD
    CALL exec
    MOVLW ':'
    MOVWF PORTD
    CALL exec
    MOVLW ')'
    MOVWF PORTD
    CALL exec
VERDE
    BSF PORTE, 0
    BCF PORTE, 1
    GOTO VERDE
   
TIME
    CLRF i
    MOVLW d'10'
    MOVWF j
CICLO    
    MOVLW d'80'
    MOVWF i
    DECFSZ i
    GOTO $-1
    DECFSZ j
    GOTO CICLO
    RETURN

TIMENUM
    MOVLW d'10'
    MOVWF i
loopj:
    MOVLW d'20'
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