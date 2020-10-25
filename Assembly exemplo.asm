STACK segment para stack
    
    db 64 dup (' ')
    
stack ends

data segment para 'DATA'
    
DATA ENDS

CODE SEGMENT PARA 'CODE'
    
    MAIN PROC PAR
    ;3
       mov AH, 00H ; set the configuration to video mode escolhe o video modo
       MOV AL, 13H ; choose the video mode
       INT 10h ; execute the configuraration
    
    ;    MOV DL, 00h
    ;   MOV AL, 13h
    ;   INT 10h
    mov Ah, 08h ; set the configuration
    mov BH, 0h ; to the backgrgound color
    mov Bl, 00h ;choose black as background color
    int 10h ; execute the configuration
    
    mov ah, 0Ch ; set the configuration to writing a pixel
    mov al, 0Fh ; choose white color
    mov BH, 00h; set the page number 
    mov CX, 0Ah ; set the column (X)
    mov DX, 0Ah ;set the line (Y)
    INT 10H     ; execute the configuration
    
    
    RET
    MAIN ENDP
    
    
CODE ENDS
END