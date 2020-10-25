;Objetivos

;-Download and install dosbox
;-Download 8086 Assembler

; Download and install -notepadd++



STACK SEGMENT PARA STACK
    64 DUP (' ')    
STACK ENDS

DATA SEGMENT PARA 'DATA'
    
DATA ENDS

COD SEGMENT PARA 'CODE'
   
   MAIN PROC FAR
        MOV, DL , 'A'
        MOV AH, 6H
        INT 21h 
   
        RET
   MAIN ENDP
   
CODE ENDS
END