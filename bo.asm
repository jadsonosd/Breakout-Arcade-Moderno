.model small ;Indica o modelo de mem?ria que mostra o programa

.stack 100h ;Modelo de tipo de pilha

.data ;Indica o in?cio do segmento de datas (dados)
    
    CR equ 13
    NL equ 10
    
    
    msg      db '___  ____ ____ ____ _  _ ____ _  _ ___ ', CR, NL
             db '|__] |__/ |___ |__| |_/  |  | |  |  |  ', CR, NL
             db '|__] |  \ |___ |  | | \_ |__| |__|  |  ', CR, NL,NL,NL,'$'

 
   nomes     db '    Jadson Charles Pawlowski', CR, NL
             db '        Felipe de Rossi', CR, NL,NL,NL, '$'
             
   menu_up   db '            [JOGAR]', CR, NL
             db '              SAIR', CR, NL, '$' 
             
   
   menu_dw   db '             JOGAR', CR, NL
             db '            [ SAIR]', CR, NL, '$'            
             
    ;trecho de c?digo de v?deo espa?ol
.code ;In?cio do segmento de c?digo
    
    
    ; Escreve uma string terminada por '$' na tela, cujo endereço esta no registrador DX
    ESC_STR proc 
        push AX        
                    
        mov AH, 9
        int 21H
        
        pop AX
        ret
        
    endp
    
    LER_CHAR proc
   	  mov AH, 00
   	  int 16H 
   	  ret
    endp  
           
    
   CONFIG_TELA proc
      push ax 
      mov al, 01h                   ;modo texto 40x25 16 cores 8 paginas
      mov ah, 13h                   ;modo de video
      int 10h
      pop ax
      ret
   endp         
   
   CONFIG_PAG proc
      push ax
      mov al, 01                    ;numero da pagina definido em al   
      mov ah, 05h                   ;numero do servico de BIOS
      int 10h
      pop ax
      ret
   endp
    
    TELA_UP proc
        
      ;call LIMPAR_MENU   
      
      push ax
      push bx
      push cx
      push dx 
        
    
      xor dx,dx         
      mov bl, 33h
      mov dx, offset menu_dw
      call ESC_STR   
      mov ah, 09h  
      
      pop dx
      pop cx
      pop bx
      pop ax
      
      ret
    endp  
    
    TELA_DW proc 
        
        
      ;call LIMPAR_MENU
      
      push ax
      push bx
      push cx
      push dx 
        
    
      xor dx,dx         
      mov bl, 33h
      mov dx, offset menu_dw
      call ESC_STR   
      mov ah, 09h  
      
      pop dx
      pop cx
      pop bx
      pop ax
      
      ret
    endp         
    
    
   LIMPAR_TELA proc 
      push ax
      push bx
      push cx
      push dx 
      
      mov ah, 00h
      mov al, 03h
      int 10h 
      
      pop dx
      pop cx
      pop bx
      pop ax
      ret
   endp
          
    
    main:  
    
      call CONFIG_TELA
      call CONFIG_PAG
      
      mov ax, @data ;Se linka a localiza??o ds dados al registrador acumulador
      mov ds, ax        ;Mover o resultado de ax em dx.(sauda??o mensagem)
;    mov cx, bx
      xor dx,dx          
      mov bl, 10h
      mov dx, offset msg
      call ESC_STR   
    
      xor dx,dx         
      mov bl, 15h
      mov dx, offset nomes 
      call ESC_STR   
      mov ah, 09h
    
      xor dx,dx         
      mov bl, 33h
      mov dx, offset menu_dw
      call ESC_STR   
      mov ah, 09h 
      
 
 
    NEXT: 
        call LER_CHAR  
        
        mov DL, AL          
        cmp AL, 'e'       
        je call TELA_up
        je NEXT
         
        
        mov DL, 's' 
        cmp AL, 50       
        je call TELA_UP 
        
        ;je SAIR           
        jmp NEXT
 
    
 
    mov ah, 4ch  
        ;mostrar o acumulador (sair do programa carregada pelo registro acumulador)
        ;mov bx, 4c0h
        ;mov cs, 4c0h
        ;mov dx, 4c0h
        
    int 21h           
    
           ;saido do processo
  
  
end main              ;Saindo do metodo principal