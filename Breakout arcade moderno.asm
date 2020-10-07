.model small ;Indica o modelo de mem?ria que mostra o programa

.stack 100h ;Modelo de tipo de pilha

.data ;Indica o in?cio do segmento de datas (dados)
    
msg      db " ______   _______  _______  _______  _        _______          _________",10, 13,  "$"
msg2     db "(  ___ \ (  ____ )(  ____ \(  ___  )| \    /\(  ___  )|\     /|\__   __/",11, 14, "$"
msg3     db "| (   ) )| (    )|| (    \/| (   ) ||  \  / /| (   ) || )   ( |   ) (   ",12, 15, "$"
msg4     db "| (__/ / | (____)|| (__    | (___) ||  (_/ / | |   | || |   | |   | |   ",13, 16, "$"
msg5     db "|  __ (  |     __)|  __)   |  ___  ||   _ (  | |   | || |   | |   | |   ",14, 17, "$"
msg6     db "| (  \ \ | (\ (   | (      | (   ) ||  ( \ \ | |   | || |   | |   | |   ",15, 18, "$"
msg7     db "| )___) )| ) \ \__| (____/\| )   ( ||  /  \ \| (___) || (___) |   | |   ",16, 19, "$"
msg8     db "|/ \___/ |/   \__/(_______/|/     \||_/    \/(_______)(_______)   )_(   ",17, 20, "$"
    
    ;trecho de código de vídeo español
.code ;In?cio do segmento de c?digo
    
main proc  
    
    mov ax, SEG @data ;Se linka a localiza??o ds dados al registrador acumulador
    mov dx, ax        ;Mover o resultado de ax em dx.(sauda??o mensagem)
;    mov cx, bx
    
    mov ah,09h         ;Com data fun??o imprimimos a cadeia
;    mov 
    
    ;lea dx,mensagem            ;mostrar o lear mensagem
    
    lea dx, msg             ;trecho mentebinario.com.br
    lea dx, msg2 
    lea dx, msg3 
    lea dx, msg4 
    lea dx, msg5 
    lea dx, msg6 
    lea dx, msg7 
    lea dx, msg8
    
    ;mov ah, 09h
    ;int 21h

    ;lea dx, msg2
    ;mov ah, 10h
    ;int 21h

    ;lea dx, msg3
    ;mov ah, 11h
    ;int 21h

    ;lea dx, msg4
    ;mov ah, 12h
    ;int 21h

    ;lea dx, msg5
    ;mov ah, 13h
    ;int 21h

    ;lea dx, msg6
    ;mov ah, 14h
    ;int 21h

    ;lea dx, msg7
    ;mov ah, 015h
    ;int 21h
    
 ;   lea cx,mensagem1
 ;   lea bx,mensagem2
 ;   lea ax,mensagem3
 ;   lea ax,mensagem4
 ;   lea bx,mensagem5
 ;   lea cx,mensagem6
 ;   lea dx,mensagem7bo
    
    
 int 21h           ;fun??o de interrup??o do DOS para mostrar uma cadeia de caracetes para a tela
    
        mov ax, 4c0h  ;mostrar o acumulador (sair do programa carregada pelo registro acumulador)
        ;mov bx, 4c0h
        ;mov cs, 4c0h
        ;mov dx, 4c0h
        
    int 21h           ;Interrup??o do DOS
    
  main endp           ;saido do processo
  
  
end main              ;Saindo do metodo principal
    
