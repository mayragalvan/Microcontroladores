#include "p16F887.inc"   ; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
 	__CONFIG	_CONFIG1,	_INTRC_OSC_NOCLKOUT & _WDT_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOR_OFF & _IESO_ON & _FCMEN_ON & _LVP_OFF 
 	__CONFIG	_CONFIG2,	_BOR40V & _WRT_OFF

RES_VECT CODE 0x0000            ; processor reset vector
    GOTO VEC
    
INT_VECT CODE 0x0004
    GOTO INTERRUPCION

MAIN_PROG CODE                      ; let linker place main program

VEC
    GOTO    START                   ; go to beginning of program

    BCF PORTC,0		;reset
    MOVLW 0x01
    MOVWF PORTD
    
    BSF PORTC,1		;exec
    CALL time
    BCF PORTC,1
    CALL time
    
    GOTO    START 
 
INTERRUPCION
    BCF INTCON, GIE ;Disable all interrupts inside interrupt service routine
    
    INCF SEG_0X
    MOVFW SEG_0X
    XORLW b'00111010'
    BTFSC STATUS,Z
    CALL ceroSEG_0X
    MOVFW SEG_X0
    XORLW b'00110110'
    BTFSC STATUS,Z
    CALL ceroSEG_X0
    MOVFW MIN_0X
    XORLW b'00111010'
    BTFSC STATUS,Z
    CALL cerosMIN_0X
    MOVFW MIN_X0
    XORLW b'00110110'
    BTFSC STATUS,Z
    CALL cerosMIN_X0
    MOVFW HORA_0X
    XORLW b'00111010'
    BTFSC STATUS,Z
    CALL cerosHORA_0X
    MOVFW HORA_X0
    XORLW b'00110010'
    BTFSC STATUS,Z
    CALL cerosHORA_X0
    
    
    BCF INTCON,INTF ;Clear external interrupt flag bit
    BSF INTCON, GIE ;Enable all interrupts on exit
    RETFIE

START

i equ 0x30
j equ 0x31
k equ 0x32

SEG_0X equ 0x33
SEG_X0 equ 0x34
MIN_0X equ 0x35
MIN_X0 equ 0x36
HORA_0X equ 0x37
HORA_X0 equ 0x38
 
START
    ;Inicializacion del reloj 
    
    MOVLW b'00110101'
    MOVWF SEG_0X
    MOVLW b'00110101'
    MOVWF SEG_X0
    MOVLW b'00111001'
    MOVWF MIN_0X
    MOVLW b'00110101'
    MOVWF MIN_X0
    MOVLW b'00110011'
    MOVWF HORA_0X
    MOVLW b'00110010'
    MOVWF HORA_X0
    
    ;-------------------------------------
    
    MOVLW 0x07 ;Apagar comparadores
    MOVWF CCP1CON
    MOVLW b'10010000'
    MOVWF INTCON
    BANKSEL PORTB ;
    CLRF PORTB ;Init PORTA
    BANKSEL ANSEL ;
    CLRF ANSEL ;digital I/O
    CLRF ANSELH
    BANKSEL TRISB ;
    MOVLW d'255'
    MOVWF TRISB
    CLRF TRISA
    CLRF TRISC
    CLRF TRISD
    CLRF TRISE
    BCF STATUS,RP1
    BCF STATUS,RP0
    BCF PORTC,1
    BCF PORTC,0
    
    
INITLCD
    
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
        
INICIO	  
   
    BCF PORTC,0		;command mode
    CALL time
    
    MOVLW 0x80		;LCD position
    MOVWF PORTD
    CALL exec
    
    BSF PORTC,0		;data mode
    CALL time
    
    MOVLW 'H'		;message1
    MOVWF PORTD
    CALL exec
    MOVLW 'O'
    MOVWF PORTD
    CALL exec
    MOVLW 'R'
    MOVWF PORTD
    CALL exec
    MOVLW 'A'
    MOVWF PORTD
    CALL exec
    MOVLW ':'
    MOVWF PORTD
    CALL exec

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    BCF PORTC,0		;command mode
    CALL time
    
    MOVLW 0x94		;LCD position
    MOVWF PORTD
    CALL exec

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BSF PORTC,0		;data mode
    CALL time
    
  
    MOVFW HORA_X0	
    MOVWF PORTD
    CALL exec
    MOVFW HORA_0X
    MOVWF PORTD
    CALL exec
    MOVLW ':'
    MOVWF PORTD
    CALL exec
    MOVFW MIN_X0
    MOVWF PORTD
    CALL exec
    MOVFW MIN_0X
    MOVWF PORTD
    CALL exec
    MOVLW ':'
    MOVWF PORTD
    CALL exec
    MOVFW SEG_X0
    MOVWF PORTD
    CALL exec
    MOVFW SEG_0X
    MOVWF PORTD
    CALL exec
    
    
    BCF PORTC,0		;command mode
    CALL time
    
    MOVLW 0x81		;LCD position
    MOVWF PORTD
    CALL exec
        
    GOTO INICIO

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
    
ceroSEG_0X
    MOVLW b'00110000'
    MOVWF SEG_0X
    INCF SEG_X0
    return
    
ceroSEG_X0
    MOVLW b'00110000'
    MOVWF SEG_X0
    INCF MIN_0X
    return
    
cerosMIN_0X
    MOVLW b'00110000'
    MOVWF MIN_0X
    INCF MIN_X0
    return
    
cerosMIN_X0
    MOVLW b'00110000'
    MOVWF MIN_X0
    INCF HORA_0X
    return
    
cerosHORA_0X
    MOVLW b'00110000'
    MOVWF HORA_0X
    INCF HORA_X0
    return
    
cerosHORA_X0
    MOVFW HORA_0X
    XORLW b'00110100'
    BTFSC STATUS,Z
    CALL cerosHORA_24hrs
    return
    
cerosHORA_24hrs
    MOVLW b'00110000'
    MOVWF HORA_X0
    MOVLW b'00110000'
    MOVWF HORA_0X
    return
			
    END