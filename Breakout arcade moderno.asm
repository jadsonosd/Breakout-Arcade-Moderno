; Iniciando  Breakout jogo de arcade moderno


; ______   _______  _______  _______  _        _______          _________
;(  ___ \ (  ____ )(  ____ \(  ___  )| \    /\(  ___  )|\     /|\__   __/
;| (   ) )| (    )|| (    \/| (   ) ||  \  / /| (   ) || )   ( |   ) (   
;| (__/ / | (____)|| (__    | (___) ||  (_/ / | |   | || |   | |   | |   
;|  __ (  |     __)|  __)   |  ___  ||   _ (  | |   | || |   | |   | |   
;| (  \ \ | (\ (   | (      | (   ) ||  ( \ \ | |   | || |   | |   | |   
;| )___) )| ) \ \__| (____/\| )   ( ||  /  \ \| (___) || (___) |   | |   /
;|/ \___/ |/   \__/(_______/|/     \||_/    \/(_______)(_______)   )_(   
 
                                                                       
;                                 Jadson


;                                Jogar       -> controlador [ ]
;                                Sair


; come?ando o jogo fazendo a tela inicial,...
; dicas para escrever os strings com cor

;AH = 13h
;AL = modo
    ;bit 0: 1- atualiza a posi??o do cursor ap?s a escrita
    ;bit 1: 1- string ocnt?m caracteres e atributos
;BL = atributo do caractere se o bit 1 em AL for 0
;BH = n?mero da p?gina de v?deo
;DH,DL = linha, coluna da posi??o de impress?o
;CX = tamanho, em caracteres, da string
;ES:BP = endere?o do in?cio da string

;Nota: esta interrup??o reconhece os c?digos CR, LF, e backspace.


.model small

.stack 100h