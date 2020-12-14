.model small ;Indica o modelo de memoria que mostra o programa

.stack 200h ;Modelo de tipo de pilha

.data ;Indica o inicio do segmento de datas (dados)
    
    CR equ 13
    NL equ 10
    
    
    msg1     db " ___  ____ ____ ____ _  _ ____ _  _ ___ "
    msg2     db " |__] |__/ |___ |__| |_/  |  | |  |  |  "
    msg3     db " |__] |  \ |___ |  | | \_ |__| |__|  |  "

 
   nomes1    db "        Jadson Charles Pawlowski"
   nomes2    db "            Felipe de Rossi"
             
   menu_up1  db "                [Jogar]  "
   menu_up2  db "                 Sair    "
             
   
   menu_dw1  db "                 Jogar   "
   menu_dw2  db "                [Sair ]  "
   
   Blocos    db 178,178,178,178,178
   Raquete   db 178,32,32,32,178 
   Bola      db 254
                                            
              
             
.code  
    
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
       
   ;Numero aleatorio entre 0 e 35    
   RANDOM proc
         push bx
         push cx
      
         mov ah,00h
         int 1Ah        ;Dx parte  baixa do contador do Clock   
      
         mov al, 35                                                
         mul dx         ;realiza o produto entre AL e DX, resultado em AX
         mov cx, 10
         div cx         ;O quociente eh retornado em AX e o resto da divisao, se houver, em DX.
      
         pop cx
         pop bx
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
   
   DESENHA_BLOCOS proc
    
         push ax
         push bx
         push cx
         push dx  
       
      
         mov al,1 
         mov ah,0
         mov cx, 5                     ;tamanho   
      
    LACO_BLOCO:
               
         ; primeira linha de blocos                                                                            
         mov dl, al                    ;coluna                   
         mov dh, ah                    ;linha
         mov bl, 4                     ;cor bloco
         mov bp, offset Blocos   
         call ESC_STRING 
             
       
         ; segunda linha de blocos                       
         add dh, 2                     ;linha
         mov bl, 0dh                   ;cor bloco
         mov bp, offset Blocos   
         call ESC_STRING
       
         ; terceira linha de blocos                       
         add dh, 2                     ;linha
         mov bl, 2                     ;cor bloco
         mov bp, offset Blocos   
         call ESC_STRING
       
         ; quarta linha de blocos                       
         add dh, 2                     ;linha
         mov bl, 0eh                   ;cor bloco
         mov bp, offset Blocos   
         call ESC_STRING                              
                              
         ;add ah, 6  
         add al,6
         cmp al,37 
         jnz LACO_BLOCO    
       
        pop dx
        pop cx
        pop bx
        pop ax    
        
        ret
   endp
   
   DESENHA_BOLA proc
        push ax
        push bx
        push cx
        push dx        
      
        mov cx, 1
        add dl, 1                      ;coluna
        mov dh, 23                     ;linha
        mov bl, 0fh                    ;cor bloco
        mov bp, offset Bola
        call ESC_STRING
      
       
        pop dx
        pop cx
        pop bx
        pop ax
       
        ret
   endp
   
   DESENHA_RAQUETE proc   
    
        push ax
        push bx
        push cx
        push dx        
      
        mov cx, 5
        mov dl, al                     ;coluna
        mov dh, 24                     ;linha
        mov bl, 0dh                    ;cor bloco
        mov bp, offset Raquete  
        call ESC_STRING
                 
                 
        mov cx, 3
        mov bl, 0dh
        mov bl, 0fh                    ;cor bloco          
        inc dl                         ;coluna
        mov bp, offset Blocos   
        call ESC_STRING 
        
        call DESENHA_BOLA
        
        pop dx
        pop cx
        pop bx
        pop ax
       
    
        ret
   endp
  
                          
   
   TELA_JOGO proc
      
        push ax
      
        call LIMPAR_TELA
        call DESENHA_BLOCOS
        call DESENHA_RAQUETE
        ;call DESENHA_BOLA 
          
      
        push ax  
    JOGO2:
        call LER_CHAR
       
        jmp JOGO2  
        pop ax
        ret
    endp 
            
    main:  
    
        call CONFIG_TELA
        call CONFIG_PAG
      

        mov ax, @data                 ;escreve string
        mov es, ax
        mov bl, 0ah                   ;define cor branca nas bordas
        mov cx, 39                    ;tamanho

        mov dl, 0                     ;coluna                     
        mov dh, 6                     ;linha
        mov bp, offset msg1   
        call ESC_STRING
      
        mov dl, 0                     ;coluna                     
        mov dh, 7                     ;linha
        mov bp, offset msg2   
        call ESC_STRING
      
        mov dl, 0                     ;coluna                     
        mov dh, 8                     ;linha
        mov bp, offset msg3   
        call ESC_STRING    
      
     
        mov dl, 0                     ;coluna                     
        mov dh, 11                    ;linha
        mov bl, 4                     
        mov bp, offset nomes1   
        call ESC_STRING
                
               
        mov dl, 0                     ;coluna                     
        mov dh, 12                    ;linha
        mov bp, offset nomes2   
        call ESC_STRING    
                
        mov cx, 23          
        mov dl, 0                     ;coluna                     
        mov bl, 0fh                   ;linha
      
      
 
    NEXT:  
        
                  
        mov dl, 0                     ;coluna                     
        mov dh, 15                    ;linha
        mov bp, offset menu_up1
        call ESC_STRING
      
        mov dl, 0                     ;coluna                     
        mov dh, 16                    ;linha
        mov bp, offset menu_up2
        call ESC_STRING
         
        call LER_CHAR
        mov DL, AL 
        cmp AL, 'a'
        je TELA_DW
        
        cmp AL, 13     
        je JOGO
                    
        jmp NEXT  
        
        
        
    TELA_DW:
        mov dl, 0                     ;coluna                     
        mov dh, 15                    ;linha
        mov bp, offset menu_dw1
        call ESC_STRING
      
        mov dl, 0                     ;coluna                     
        mov dh, 16                    ;linha
        mov bp, offset menu_dw2
        call ESC_STRING
         
        call LER_CHAR
        mov DL, AL 
        cmp AL, 'q'
        je NEXT
        
        cmp AL, 13     
        je Sair
                    
        jmp TELA_DW  
        
        
      JOGO:
      
        call TELA_JOGO
        call LER_CHAR
        ;call TELA_DW
      
     
    Sair:
 
    mov ah, 4ch  
        
    int 21h           
    
    ;saido do processo
  
  
end main              