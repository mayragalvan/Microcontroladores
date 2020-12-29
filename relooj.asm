#include "p16F628a.inc" ;incluir librerias relacionadas con el dispositivo
__CONFIG _FOSC_INTOSCCLK & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _CP_OFF
; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR

RES_VECT CODE 0x0000 ; processor reset vector
GOTO START ; go to beginning of program
    
    BCF PORTA,0		;reset
    MOVLW 0x01
    MOVWF PORTB
    
INT_VECT CODE 0x004 ; interrupt vector
;ISR code
DECFSZ CNT
GOTO A ;RUTINA DE INTERRUPCION
MOVLW '9' ;LIMITACIÓN DE DIGITOS
XORWF SEG_0X, 0 
BTFSC STATUS, Z
CALL SEG1 ;LLAMA DE LA FUNCIÓN
INCF SEG_0X 
;MOVLW B'00000001'
;XORWF PORTB, F
MOVLW D'8' ; 50mS * value
MOVWF CNT
; 256uS * 195 =~ 50mS
; 255 - 195 = 60
MOVLW D'95' ; preload value
MOVWF TMR0
A: bcf INTCON, T0IF ; clr TMR0 interrupt flag
retfie ; return from interrupt
MAIN_PROG CODE ; let linker place main program
CNT equ 0x20
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
;setup registers
; setp TMR0 operation
; internal clock, pos edge, prescale 256
MOVLW 0x07 ;Apagar comparadores
MOVWF CMCON
BSF STATUS, RP0
MOVLW 0x00
MOVWF TRISA
MOVWF TRISB
movlw b'10000111'
movwf OPTION_REG
BCF STATUS, RP0 ; BANK 0
 ; setup TMR0 INT
bsf INTCON, GIE ; enable global interrupt
bsf INTCON, T0IE ; enable TMR0 interrupt
bcf INTCON, T0IF ; clr TMR0 interrupt flag to turn on,
; must be cleared after interrupt
; 256uS * 195 =~ 50mS
; 255 - 195 = 60
MOVLW D'60' ; preload value
MOVWF TMR0
MOVLW D'10' ; 50mS * 20 = 1 Sec.
MOVWF CNT
CLRF PORTA
CLRF PORTB
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
    
;-------------------------------------------------
INITLCD
    BCF PORTA,0		;reset
    MOVLW 0x01
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
    MOVLW 0x0C		;first line
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
         
    MOVLW 0x3C		;cursor mode
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
;--------------------------------------------------------------
INICIO	  
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x80		;LCD position
    MOVWF PORTB
    CALL exec
    
   BSF PORTA,0		;data mode
    CALL time
    
    MOVLW 'H'		;message1
    MOVWF PORTB
    CALL exec
    MOVLW 'O'
    MOVWF PORTB
    CALL exec
    MOVLW 'R'
    MOVWF PORTB
    CALL exec
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
    MOVLW ':'
    MOVWF PORTB
    CALL exec
    
    BCF PORTA,0		;command mode
    CALL time
    
    MOVLW 0x97		;LCD position
    MOVWF PORTB
    CALL exec
    
   BSF PORTA,0		;data mode
    CALL time
    
    
    MOVFW HORA_X0	
    MOVWF PORTB
    CALL exec
    MOVFW HORA_0X
    MOVWF PORTB
    CALL exec
    MOVLW ':'
    MOVWF PORTB
    CALL exec
    MOVFW MIN_X0
    MOVWF PORTB
    CALL exec
    MOVFW MIN_0X
    MOVWF PORTB
    CALL exec
    MOVLW ':'
    MOVWF PORTB
    CALL exec
    MOVFW SEG_X0
    MOVWF PORTB
    CALL exec
    MOVFW SEG_0X
    MOVWF PORTB
    CALL exec
    GOTO INICIO
    
    BCF INTCON, GIE ;Disable all interrupts inside interrupt service routine   
SEG1 ;FUNCION UNIDADES DE SEGUNDO
    MOVLW d'47'  
    MOVWF SEG_0X
    MOVLW '5'
    XORWF SEG_X0, 0 ;OPERACIÓN DE XOR ESCLUSICA ENTRE REGISTRO DE W Y F 
    BTFSC STATUS, Z
    CALL SEG2 ;LLAMADA DE FUNCIÓN DE DECIMAS DE SEGUNDO
    INCF SEG_X0 ;INCREMENTACION EN 
    RETURN

SEG2
    MOVLW d'47'
    MOVWF SEG_X0
    MOVLW '9'
    XORWF MIN_0X, 0
    BTFSC STATUS, Z
    CALL MIN1
    INCF MIN_0X
    RETURN
    
MIN1
    MOVLW d'47'
    MOVWF MIN_0X
    MOVLW '5'
    XORWF MIN_X0, 0
    BTFSC STATUS, Z
    CALL MIN2
    INCF MIN_X0
    RETURN
    
MIN2
    MOVLW d'47'
    MOVWF MIN_X0
    MOVLW '3'
    XORWF HORA_0X, 0
    BTFSC STATUS, Z
    CALL HOR1
    MOVLW '9'
    XORWF HORA_0X, 0
    BTFSC STATUS, Z
    CALL HOR2
    INCF HORA_0X
    RETURN

HOR1
    MOVLW '2'
    XORWF HORA_X0, 0
    BTFSS STATUS, Z
    GOTO r
    MOVLW d'47'
    MOVWF HORA_0X
    MOVLW d'48'
    MOVWF HORA_X0
r:  RETURN
    
HOR2
    MOVLW d'47'
    MOVWF HORA_0X
    MOVLW '2'
    XORWF HORA_X0, 0
    BTFSC STATUS, Z
    CALL UH
    INCF HORA_X0
    RETURN
    
UH
    MOVLW d'47'
    MOVWF HORA_X0
    RETURN
    
    BCF INTCON,INTF ;Clear external interrupt flag bit
    BSF INTCON, GIE ;Enable all interrupts on exit
    RETFIE

;-----------------------------------------------------------------------------
exec
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    RETURN
    
time
    CLRF i
    MOVLW d'60'
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
