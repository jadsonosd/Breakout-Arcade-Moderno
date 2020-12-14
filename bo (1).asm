.model small ;Indica o modelo de mem?ria que mostra o programa

.stack 100h ;Modelo de tipo de pilha

.data ;Indica o in?cio do segmento de datas (dados)
    
    CR equ 13
    NL equ 10
    
    
    msg1     db "___  ____ ____ ____ _  _ ____ _  _ ___ "
    msg2     db "|__] |__/ |___ |__| |_/  |  | |  |  |  "
    msg3     db "|__] |  \ |___ |  | | \_ |__| |__|  |  "

 
   nomes1    db "      Jadson Charles Pawlowski"
   nomes2    db "          Felipe de Rossi"
             
   menu_up1  db "              [JOGAR]"
   menu_up2  db "                SAIR"
             
   
   menu_dw1  db "               JOGAR"
   menu_dw2  db "              [ SAIR]"            
             
    ;trecho de c?digo de v?deo espa?ol
.code ;In?cio do segmento de c?digo
    
    
    ; Escreve uma string terminada por '$' na tela, cujo endereço esta no registrador DX
    ESC_STR proc 
        push AX        
                             
        mov AH, 9h
        int 21H
        
        pop AX
        ret
        
    endp  
    
    ESC_STRING proc
           
         push ax
      push bx
      push cx
      push dx
      
      mov bh, 1    ;pagina
      mov ah, 13h  ;numero do servico de BIOS
      mov al, 00h  ;numero do subservico
      int 10h
      
      pop dx
      pop cx
      pop bx
      pop ax  
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
      
      ;mov ax, @data ;Se linka a localiza??o ds dados al registrador acumulador
      ;mov ds, ax        ;Mover o resultado de ax em dx.(sauda??o mensagem)
;    mov cx, bx        


      mov ax, @data                 ;escreve string
      mov es, ax
      mov bl, 0ah                     ;define cor branca nas bordas
      mov cx, 38                     ;tamanho

      mov dl, 0                     ;coluna                     
      mov dh, 3                     ;linha
      mov bp, offset msg1   
      call ESC_STRING
      
      mov dl, 0                     ;coluna                     
      mov dh, 4                     ;linha
      mov bp, offset msg2   
      call ESC_STRING
      
      mov dl, 0                     ;coluna                     
      mov dh, 5                     ;linha
      mov bp, offset msg3   
      call ESC_STRING    
      
      
      
      mov dl, 0                     ;coluna                     
      mov dh, 9
      mov bl, 4                     ;linha
      mov bp, offset nomes1   
      call ESC_STRING
                
               
      mov dl, 0                     ;coluna                     
      mov dh, 10                    ;linha
      mov bp, offset nomes2   
      call ESC_STRING    
                
      mov cx, 23          
      mov dl, 0                     ;coluna                     
      mov dh, 15
      mov bl, 0fh                    ;linha
      mov bp, offset menu_up1
      call ESC_STRING
      
      mov dl, 0                     ;coluna                     
      mov dh, 16                     ;linha
      mov bp, offset menu_up2
      call ESC_STRING


      ;xor dx,dx          
      ;mov bh, 10h
      ;mov dx, offset msg
      ;call ESC_STR   
    
      ;xor dx,dx         
      ;mov bh, 2
      ;mov dx, offset nomes 
      ;call ESC_STR   
      ;mov ah, 09h
    
      ;xor dx,dx         
      ;mov bh, 33h
      ;mov dx, offset menu_up
      ;call ESC_STR   
      ;mov ah, 09h 
      
 
 
    NEXT: 
        call LER_CHAR  
        
        mov DL, AL          
        cmp AL, 'q'      
        je TELA_UP
        je NEXT
         
        
        mov DL, AL 
        cmp AL, 'a'     
        je TELA_DW 
        
        ;je SAIR           
        jmp NEXT
        
     TELA_DW:
        mov dl, 0                     ;coluna                     
        mov dh, 15                      ;linha
        mov bp, offset menu_dw1
        call ESC_STRING
      
        mov dl, 0                     ;coluna                     
        mov dh, 16                      ;linha
        mov bp, offset menu_dw2
        call ESC_STRING 
        jmp NEXT
     
            
     TELA_UP:
        mov dl, 0                     ;coluna                     
        mov dh, 15                    ;linha
        mov bp, offset menu_up1
        call ESC_STRING
      
        mov dl, 0                     ;coluna                     
        mov dh, 16                    ;linha
        mov bp, offset menu_up2
        call ESC_STRING
        jmp NEXT
 
    mov ah, 4ch  
        ;mostrar o acumulador (sair do programa carregada pelo registro acumulador)
        ;mov bx, 4c0h
        ;mov cs, 4c0h
        ;mov dx, 4c0h
        
    int 21h           
    
           ;saido do processo
  
  
end main              ;Saindo do metodo principal