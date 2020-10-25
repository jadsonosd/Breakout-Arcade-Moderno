; ////////////////////////
; Programa exemplo ASM x86
; ////////////////////////

; Utilizaremos uma pilha com 1024 palavras (16bits)

.stack 2048d ; Define o tamanho do segmento de pilha (SS)

.data ; Define o segmento de dados (DS)
     
     a db 01h ; Cria variavel BYTE (8bits) de nome a com valor 01h
     b db 2d ; Cria variavel BYTE (8bits) de nome b com valor 2d
     
     c dw 0Ah ; Cria variavel WORD (16bits) de nome c com valor 0Ah
     d dw 4d ; Cria variavel WORD (16bits) de nome d com valor 4d
     
     e db ? ; Cria variavel BYTE (8bits) de nome e sem valor inicial
     f dw ? ; Cria variavel WORD (16bits) de nome f sem valor inicial

	nome db 'raffael bottoli schemmer' ; Cria variavel BYTE (8bits) de nome e com valor inicial
	
	v db 1,2,3 ; Vetor com 3 valores estáticos
	
	m db sup (9); Cria vetor com 9 bytes (3 linhas com 3 colunas)
	
.code ; Define o segmento de codigo (CS)
    
    
    ; || -- SEGMENTOS DE UM PROGRAMA ASM -- || 
    
        ; -- Segmento CS (Code Segment)
    
           ; [CS] Guarda o ponteiro para o bloco (segmento) do codigo
           
           ; Quem manipula este segmento?
           
                ; CS + IP Aponta para a instrucao que o CPU esta executando
           
           ; Onde ele eh implementado?
           
                ; Na estrutura .data do programa
                
        ; -- Segmento DS (Data Segment)
    
           ; [DS] Guarda o ponteiro para o bloco (segmento) dos dados
           
           ; Quem manipula este segmento?
           
                ; DS + offset (deslocamento) informado pelo usuario
                         
           ; Onde ele eh implementado?
           
                ; Na estrutura .code do programa
                  
        ; -- Segmento SS (Stack Segment)
          
           ; [SS] Guarda o ponteiro para o bloco (segmento) da pilha
           
           ; Quem manipula este segmento?
           
                ; SS + SP Calculado SP - 2 quando o usuario coloca na pilha com PUSH
                ; SS + SP Calculado SP + 2 quando o usuario retira da pilha com POP
                         
           ; Onde ele eh implementado?
           
                ; Na estrutura .stack do programa
           
            
        ; -- Segmento de codigo extra ES (Extra Segment)
        
           ; [ES] Guarda o ponteiro para o bloco (segmento) dos dados extras
           
           ; Quem manipula este segmento?
           
                ; ES + offset (deslocamento) informado pelo usuario
                         
           ; Onde ele eh implementado?
           
                ; ES + offset (deslocamento) informado pelo usuario
                ; O segmento ES precisa ser inicializado conforme segue:
                
                    MOV DX,400h ; Define que 400h como endereco
                    MOV ES,DX ; Define que ES deve apontar para DX (400h)                                                           
        
        ; -- Inicializando segmento de dados
        
           mov ax, @data ; Inicializa a pilha de dados
           mov ds, ax
           
    ; ////////////////////////////////////////////////////////////////////
    ; ////////////////////////////////////////////////////////////////////
        
    ; || -- Modos de enderecamento -- ||
    
        ; [1] Imediato
        ; [Func] : Utiliza constantes absolutas
    
           MOV AX,02h ; Carrega constante 2h para o registrador AX
           ADD AX,5d ; Soma constante 5d com conteudo de AX (AX <- AX + 5)
           SUB AX,-02h ; Subtrai constante -2h com conteudo de AX (AX <- AX - -2)
           
        ;[2] Indireto
        ; [Func] : Um dos operandos eh um endereco de memoria
        
            MOV BYTE PTR DS:01h:02h ; Move (BYTE) para o END de MEM DS:[1h] o valor 2h
            MOV AL,04h ; Move para o registrador (BYTE) AL o valor 4h
            
            MOV SI,01h ; Move para o registrador (WORD) SI o valor 1h
            
            ADD AL,DS:[SI] ; Soma em AL os operandos (AL + DS:[SI]) MEM <- REG + MEM 
            ADD DS:[SI],AL ; Soma em DS:[SI] os operandos (DS:[SI] + AL) MEM <- MEM + REG
        
        ;[3] Direto
        ; [Func] : Utiliza enderecos (rotulos) da memoria de dados
        
            x db 2d ; Cria (BYTE) no endereco DS:0
            y dw 8d ; Cria (WORD) no endereco DS:1 e DS:2
            
            MOV AX,02h ; Carrega constante 2h para AX
            MOV BL,02h ; Carrega constante 2h para BL
            MOV CX,0Ah ; Carrega constante Ah para CX
            ADD CX,y ; Soma CX + DS:y (DS:0)
            XCHG BL,x ; Troca o valor de (BL por DS:0) e (DS:0 por BL)     
            
            
            
            
            .MODEL SMALL
.STACK
.DATA

msg1 db 13,10, "Insira numero: $"
msg2 db 13,10, "O Factorial e: $"

                         
        ;[4] Via Registrador
        ; [Func] : Utiliza os registradores como endereco
.code
mov ax, @data
mov ds, ax          ;Carrega o byte da MEM apontado por DS:[BX+SI+5]
lea dx, msg1
mov ah, 09h
int 21h
mov bx, 0

start:
mov ah, 01
int 21h
cmp al, 0dh
je next
mov ah, 0
sub al, 30h
push ax
mov ax, 10d
mul bx
pop bx
add bx, ax
jmp start

next:
mov cx, bx
mov ax, 1

top:
mul cx
loop top
mov bx,10d
mov dx, 0

break:
div bx
push dx
inc cx
mov dx, 0
or ax, ax
jnz break
mov ah, 09
lea dx, msg2
int 21h
mov dx, 0

print:
pop dx
mov ah, 02
add dl, 03h
int 21h
loop print
mov ah, 4ch
int 21h
end 
            
        
        ;[4] Via Registrador
        ; [Func] : Utiliza os registradores como endereco
        
          MOV AX,01h ; Carrega constante 1h para o registrador AX
          MOV BX,02h ; Carrega constante 2h para o registrador BX
          ADD AX,BX ; Utiliza o conteudo dos registradores AX e BX
        
        ;[5] Indireto com base
        ; [Func] : Um dos operandos eh um endereco de memoria com uma base (constante)
          
          ; Carrega o byte da MEM apontado por DS:[BX+5]
          ; DS eh o segmento de dados da memoria
          ; BX eh um registrador especial com um valor
          ; 5 eh uma constante adicionada ao endereco (valor a ser saltado)
          
             MOV BX,01h ; Carrega 1h em BX 
             MOV AX,020h ; Carrega 20h em AX
             MOV DS:06h,020h ; Move 20h para DS:06h
             MOV AL,0h ; Carrega 0h em AL
             MOV AL, DS:[BX+5] ; Move DS:[BX+5] para AL 
          
        ;[6] Imediato com (base + indice)
        ; [Func] : Um dos operandos eh um endereco de memoria com uma base (constante + indice)
          
          
          ; Carrega o byte da MEM apontado por DS:[BX+SI+5]
          ; DS eh o segmento de dados da memoria
          ; BX eh um registrador especial com um valor
          ; SI eh uma base
          ; 5 eh uma constante adicionada ao endereco (valor a ser saltado)
          
             MOV BX,01h ; Carrega 1h em BX
             
             MOV AX,020h ; Carrega 20h em AX
             MOV DS:06h,020h ; Move 20h para DS:06h
             
             MOV SI,0h ; Carrega 0h em SI
             MOV AL, DS:[BX+SI+5] ; MOVE ds>[BX+SI+5] para AL 
             
          
    ; ////////////////////////////////////////////////////////////////////
    ; ////////////////////////////////////////////////////////////////////
            
    ; || -- Instrucoes de TRANSFERENCIA DE MEMORIA -- ||
    
        ;[1] MOV (Movimentacao em memoria)
        
            ; [O que faz?] MOV move algo no destido destino <- origem
            ; Exemplo: MOV AX,1h AX <- 1h
            
            ; MOV suporta inumeras formas de enderecar o destino e a origem
            ; A unica operacao nao suportada eh trabalhar memoria com memoria
            
            ; Seguem exemplos de MOV <DEST> <ORIG>
            
                MOV AX, 01h ; Registrador AX <- 1h [Enderecamento Imediato]
                MOV AX, BX ; Registrador AX <- BX [Enderecamento Via Registrador]
                
                ; Carga de WORD em memoria utilizando enderecamento Indireto
                
                MOV BX,01h ; Registrador BX <- 1h
                MOV AX, [BX] ; Registrador AX recebe enderecedo MEM DS:BX (DS + 1h)
                MOV AX, DS:[BX] ; Registrador AX recebe enderecedo MEM DS:BX (DS + 1h)
                
                ; Carga de BYTE em memoria utilizando enderecamento Indireto
                
                MOV BX,01h
                MOV AL, [BX]
                MOV AL, DS:[BX]
                                        
                ; Carrega o conteudo (WORD) BX em AX
                MOV AX,BX                           
                
                ; Carrega o conteudo (BYTE) BL em AL
                MOV BL,AL                           
                        
                        
        ;[2] PUSH (Empilha valor em SS) 
        
            ; [O que faz?] Carrega um valor para o topo da pilha (SS)
            
                ; Diferentes formas de empilhas em SS (SP - 2)
                
                PUSH 01h ; Empilha a constante 1h na posicao SS:SP e faz SP <- SP - 2
                PUSH AX ; Empilha o conteudo de AX na posicao SS:SP e faz SP <- SP - 2
                PUSH DS:[AX] ; Empilha o endereco de mem DS:[AX] na posicao SS:SP e faz SP <- SP - 2
                 
                                          
              .model small
.stack 64
.data

num db 3d
vet db 10 dup (0)
maior db ?

.code

mov ax,@data
mov ds,ax


;||||||||||||||||||||||||||||||||||||||||||||

; 4 - Modos de enderecamentos avancados
;
; 4.1 indireto (Carrega o endereco da memoria)

MOV SI,0d
MOV AL,DS:[SI]

; 4.2 indireto por base [SI+BX] (BX eh a base)

MOV CX,10d
MOV BX,0d      

LEA SI,vet
MOV AL,DS:[SI]
MOV maior,AL
    
inicializavetor:  
    
    ; INT 1A GERAR NUMEROS ALEATORIOS
    
    LEA SI,vet
    MOV DS:[SI+BX],BL
    INC BX
    
loop inicializavetor 

MOV CX,10d
MOV BX,0d 

procuramaiorelemento:  
    
    ; INT 1A GERAR NUMEROS ALEATORIOS
    
    LEA SI,vet
    MOV DL,DS:[SI+BX]
    CMP DL,maior
    
    JGE trocamaior
    
        jmp fimse
        
    trocamaior:
          
        MOV maior,DL
          
    fimse:
    
    INC BX
    
loop procuramaiorelemento 


; 4.3 imediato com base [SI+BX] + indice

MOV CX,5d
MOV BX,0d      

inicializa2:  

    LEA SI,vet
    MOV DS:[SI+(BX+5)],CL
    INC BX
    
loop inicializa2

;||||||||||||||||||||||||||||||||||||||||||||


.exit
                                                                      
                                                                                                                                                                            
                                          
                                          
                                          
                                          
        ;[3] POP (Desempilha valor em SS)  
        
    
        
            ; [O que faz?] Carrega um valor para o topo da pilha (SS)
            
                ; Diferentes formas de empilhas em SS (SP - 2)
                
                POP AX ; Desempilha o topo da pilha para AX na posicao SS:SP e faz SP <- SP + 2
                POP DS:[AX] ; Desempilha o topo da pilha para mem DS:[AX] na posicao SS:SP e faz SP <- SP + 2
             
        ;[4] PUSHA
        
            ; [O que faz?] Carrega todos os registradores GPP para a pilha (SS)
                
                
                MOV AX,01234h 
                MOV BX,05678h
                MOV CX,0AAAAh
                MOV DX,0BBBBh
                MOV SI,0CCCCh
                MOV DI,0DDDDh
                PUSHA ; Carrega AX,BX,CX,DX,BP,SI,DI para a pilha (SS) 
            
        ;[5] POPA
            
            ; [O que faz?] Restaura todos os registradores GPP da pilha (SS)
            
                MOV AX,01234h 
                MOV BX,05678h
                MOV CX,0AAAAh
                MOV DX,0BBBBh
                MOV SI,0CCCCh
                MOV DI,0DDDDh
                POPA ; Restaura AX,BX,CX,DX,BP,SI,DI para a pilha (SS) 
        
        ;[6] XCHG
            
            ; [O que faz?] Realiza a troca do conteudo entre dois registradores
            
              MOV AX,02h ; Carrega o hexa 2h para AX
              MOV BX,04h ; Carrega o hexa 4h para BX
              XCHG AX,BX ; Troca o conteudo de AX por BX e BX por AX
              
              MOV CX,Ah  ; Carrega o hexa Ah para CX            
              MOV DS:01h,CX ; Carrega CX (Ah) para END MEM DS:1h
              MOV CX,01h    ; Carrega 1h para CX
              XCHG CX,DS:01h ; Compara CX com END MEM DS:1h
            
            
        ;[7] LEA
        
            ; [O que faz?] Carrega a posicao de um offset (END inicial) da memoria de dados (DS)
            
            .data
            
                x db 1d
                y dw 2d
                z dw 3d
            
            .code
                
                LEA AX,x ; Carrega para AX 0 (pois x esta na posicao 0)
                LEA BX,y ; Carrega para BX 1 (pois y esta na posicao 1)
                LEA CX,z ; Carrega para CX 3 (pois z esta na posicao 3)
            
            .exit
            
        
         ;[8] XLAT
         
            ; [O que faz?] Permite pesquisar em uma tabela (variavel unidimensional)
            
            .data
            
            ; Variavel tabela possui os indices [0] com 30d [1] com 20d e [2] com 10d
            tabela db 30d, 20d, 10d
            
            .code
            
            MOV AL,0d ; Carrega o valor 0d para AL
            LEA BX,tabela ; Carrega o offset (inicio) de tabela em BX
            XLAT ; Consulta e retorna em AX o valor presente na tabela indice apontado por [AL]
            
            
            .exit
            

            
           
    ; ////////////////////////////////////////////////////////////////////
    ; ////////////////////////////////////////////////////////////////////
            
    ; || -- Instrucoes logicas -- ||
    
        ; [1] AND
            
            ; Realiza a operacao de AND (bit a bit) em registradores e END MEM
            ; Pode afetar os FLAGs : OF(overflow), SF(sinal), ZF(zero), PF(par), CF(carry)
            ; Utilidade maior (resetar bits)
            ; xxxx 0011 fara com que os dois primeiros bits de xxxx sempre sejam zero
            
            .data
            
            x db 1d
            
            .code
                
                MOV AL,2d ; Carrega constante 2 para AL (Imediato)
                AND AL,x ; AND bit a bit de 00000010 (AL) por (x) 00000001 gerando (00000000)
            
            .exit  
            
            
        ; [2] OR
            
            ; Realiza a operacao de OR (bit a bit) em registradores e END MEM
            ; Pode afetar os FLAGs : OF(overflow), SF(sinal), ZF(zero), PF(par), CF(carry)
            ; Utilidade maior (mascarar bits)
            ; xxxx 0011 fara com que os dois primeiros bits de xxxx sempre sejam zero
            
            .data
            
            x db 1d
            
            .code
            
                MOV AL,2d ; Carrega constante 2 para AL (Imediato)
                OR AL,x ; OR bit a bit de 00000010 (AL) por (x) 00000001 gerando (00000011)
            
            .exit
            
            
        ; [3] XOR
            
            ; Realiza a operacao de XOR (bit a bit) em registradores e END MEM
            ; Pode afetar os FLAGs : OF(overflow), SF(sinal), ZF(zero), PF(par), CF(carry)
            ; Utilidade maior (Comparador de valores)
            ; Util para (zerar registrador fazendo XOR AX,AX)
            
            .data
            
            x db 1d
            
            .code
            
                MOV AL,2d ; Carrega constante 2 para AL (Imediato)
                XOR AL,2d ; OR bit a bit de 00000010 (AL) por (x) 00000001 gerando (00000011)
                MOV AL,2d ; Caso der zero significa que AL e 2d sao iguais
                XOR AL,AL ; Zera o valor de AL
            
            .exit
            
        
        ; [4] NOT    
        
            ; Realiza a operacao de NOT em registradores e END MEM
            ; Pode afetar os FLAGs : OF(overflow), SF(sinal), ZF(zero), PF(par), CF(carry)
            ; Utilidade maior (Inversao de bits)
            
            .code
            
                MOV AL,2d ; Carrega constante 2 para AL (Imediato)
                NOT AL ; NOT bit a bit de 00000010 (AL) gerando (11111101)
                
            .exit
            
        ; [5] SHL
            
            ; Realiza a operacao de SHL (deslocamento de bit a esquerda em registradores)
            ; Pode afetar os FLAGs : OF(overflow), SF(sinal), ZF(zero), PF(par), CF(carry)
            ; Utilidade maior (Multiplicar por N em alta velocidade)
            
            .code
            
                MOV AL,2d ; Carrega constante 2 para AL (Imediato)
                SHL AL,2 ; Realiza a SHL de AL (2) (00000010) gerando (8) (00001000)
                
            .exit
            
        ; [6] SHR
           
            ; Realiza a operacao de SHL (deslocamento de bit a esquerda em registradores)
            ; Pode afetar os FLAGs : OF(overflow), SF(sinal), ZF(zero), PF(par), CF(carry)
            ; Utilidade maior (Multiplicar por N em alta velocidade)
            
            .code
            
                MOV AL,8d ; Carrega constante 8 para AL (Imediato)
                SHR AL,2 ; Realiza a SHR de AL (8) (00001000) gerando (8) (00000010)
                
            .exit
           
        ; [7] RCL
        
            ; Realiza a operacao de RCL (rotacao de bit a esquerda em registradores)
            ; Pode afetar os FLAGs : OF(overflow), SF(sinal), ZF(zero), PF(par), CF(carry)
            
            .code
            
                MOV AL,80H ; Carrega constante 2 para AL (Imediato)
                ROL AL,1d ; Realiza a ROL de AL (8) (10000000) gerando (1) (00000001)

            .exit
        
        ; [8] RCR
        
            ; Realiza a operacao de SHL (rotacao de bit a direita em registradores)
            ; Pode afetar os FLAGs : OF(overflow), SF(sinal), ZF(zero), PF(par), CF(carry)
            
            .code
            
                MOV AL,1d ; Carrega constante 2 para AL (Imediato)
                ROR AL,1d ; Realiza a ROL de AL (8) (00000001) gerando (1) (10000000)
                                
            .exit    
            
             .model small
.stack 64
.data

msg1 db '|| -- Os numeros de 1 ate 20 -- ||',10d,13d,'$'
msg2 db 'Informe o segundo numero: $'
msg3 db 'Resultado da soma: $'

x db ?
y db ?
resultado db ?

.code

MOV AX,@data
MOV DS,AX

MOV CX,20d
MOV BX,1d

LEA DX,msg1
MOV AH,9h
INT 21h

loopx:

	PUSHA
	MOV AL,BL
	CALL PRINTF
	POPA
	
	MOV AH,2h
	MOV DL,' '
	INT 21h
	
	INC BX
	
loop loopx

.exit

SCANF PROC
    
mov dl, 10  
mov bl, 0
            
            
            
        
        
    ; ////////////////////////////////////////////////////////////////////
    ; ////////////////////////////////////////////////////////////////////
            
    ; || -- Instrucoes aritmeticas -- ||
    
        ; ADD
        
            ; Realiza a soma de dois valores (registradores ou memoria)
            
            .data
            
            x db 1d
                        
            .code
                        
            MOV AX,2d ; Carrega 2d para AX
            MOV BX,4d ; Carrega 4d para BX
            ADD AX,BX ; Soma AX <- AX + BX
            ADD BL,x  ; Soma BX <- BX + DS:0
                        
            .exit
           
            
        ; ADC 
        
            ; Realiza a soma de dois valores + carry (registradores ou memoria)
            
            .data
            
            x db 1d
                        
            .code
                        
            MOV AX,2d ; Carrega 2d para AX
            MOV BX,4d ; Carrega 4d para BX
                        
            STC ; Sobe o flag de carry para 1
                     
            ADC AX,BX ; Soma AX <- AX + BX + Carry
            
            .exit
           
        
        ; SUB
        
            ; Realiza a subtracao de dois valores (registradores ou memoria)
            
            .data
            
            x db 1d
                        
            .code
                        
            MOV AX,2d ; Carrega 2d para AX
            MOV BX,4d ; Carrega 4d para BX
            SUB AX,BX ; Subtrai AX <- AX - BX
            SUB BL,x  ; Subtrai BX <- BX - DS:0
                        
            .exit
           
        ; SBB
        
            ; Realiza a subtracao de dois valores + carry (registradores ou memoria)
            
            .data
            
            x db 1d
                        
            .code
                        
            MOV AX,4d ; Carrega 2d para AX
            MOV BX,2d ; Carrega 4d para BX
            
            STC ; Sobe o flag de carry para 1
            SBB AX,BX ; Subtrai AX <- AX - BX
                        
            .exit
        
        ; MUL 
            
            ; Realiza a multiplicacao de dois registradores
            ; A multiplicacao possui varias regras:
            
            ; [1] 8bits (AL) * 8bits (BL) = 16bits (AX)  
            MOV AL,2
			MOV BL,2
			MUL BL
            
            ; [2] 16bits (AX) * 16bits (CX) = 32bits (DX + AX)
            MOV AX,2
			MOV CX,2
			MUL CX
            
        ; IMUL
            
            ; Realiza a multiplicacao de dois registradores positivos
            ; A multiplicacao possui varias regras:
            
            ; [1] 8bits (AL) * 8bits (BL) = 16bits (AX)  
            MOV AL,2
			MOV BL,2
			IMUL BL
            
            ; [2] 16bits (AX) * 16bits (CX) = 32bits (DX + AX)
            MOV AX,2
			MOV CX,2
			IMUL CX
            
            
        ; DIV
        
            ; Realiza a divisao de dois registradores
            ; A multiplicacao possui varias regras:
            
            ; [1] 8bits (AL) * 8bits (BL) = 16bits (AX)  
            MOV AL,4
			MOV BL,2
			DIV BL
            
            ; [2] 16bits (AX) * 16bits (CX) = 32bits (DX + AX)
            MOV AX,4
			MOV CX,2
			DIV CX
            
        ; IDIV
            
            ; Realiza a divisao de dois registradores positivos
            ; A multiplicacao possui varias regras:
            
            ; [1] 8bits (AL) * 8bits (BL) = 16bits (AX)  
            MOV AL,4
			MOV BL,2
			IDIV BL
            
            ; [2] 16bits (AX) * 16bits (CX) = 32bits (DX + AX)
            MOV AX,4
			MOV CX,2
			IDIV CX
            
        ; INC
        
            ; Realiza o incremento de um registrador em uma unidade
            
            .data
            
            x db 1d
                        
            .code
                        
            MOV AX,2d ; Carrega 2d para AX
            MOV BL,4d ; Carrega 4d para BX
            INC AX    ; Incrementa AX em uma unidade
            INC BL    ; Incrementa BL em uma unidade
                        
            .exit
            
        ; DEC 
            
            ; Realiza o decremento de um registrador em uma unidade
            
            .data
            
            x db 1d
                        
            .code
                        
            MOV AX,2d ; Carrega 2d para AX
            MOV BL,4d ; Carrega 4d para BX
            DEC AX    ; Decrementa AX em uma unidade
            DEC BL    ; Decrementa BL em uma unidade
                        
            .exit
            
            
        ; NEG
            
            ; Realiza o complemento de 2 de um registradors
            
            .data
            
            x db 1d
                        
            .code
                        
            MOV AX,2d ; Carrega 2d para AX
            MOV BL,4d ; Carrega 4d para BX
            NEG AX    ; Realiza o complemento de 2 do numero 2 para (-2)
                        
            .exit
            
        ; CBW
            
            ; Converte um byte para uma word (Utilize sempre AX)
            ; Quando um byte esta em low o proprio registrador eh utilizado
            ; Quando um byte esta em high o registrador DX sempre eh utilizado
            
            MOV AL,128   ; AL = 10000000B
            CBW	; AX = 1111111110000000B
            
            MOV AX,8000H ; AX = 1000000000000000B
            CWD	    ; DX = 1111111111111111B

            
    ; ////////////////////////////////////////////////////////////////////
    ; ////////////////////////////////////////////////////////////////////
            
    ; || -- Instrucoes de comparacao -- ||
        
        ; Servem para comparar coisas (registradores e endereco de MEM)
        
        ; [1] CMP
        
            ; Excita o registrador de Zero FLAGs (ZF)
            ; Zero se forem diferentes e Um se forem iguais
            
            CMP AX,BX ; Compara se o conteudo de AX eh igual a BX
            CMP AX,DS:01h ; Compara se o conteudo de AX eh igual ao endereco MEM DS:1h
            CMP AX,02h ; Compara se a constante 2h eh igual a AX
            CMP AX,x ; Compara se a variavel x de DS eh igual a AX
            
            
        ; [2] TEST
        
            ; Excita o registrador de Zero FLAGs (ZF)
            ; Zero se forem diferentes e Um se forem iguais
            ; Implementa o mesmo comportamento que CMP
             
            
            MOV AX,01h ; Carrega constante (Imediato) para registrador AX
            MOV BX,01h ; Carrega constante (Imediato) para registrador AX
            TEST AX,BX ; Testa se o conteudo de AX eh igual a BX (Via Registrador)
            
    ; ////////////////////////////////////////////////////////////////////
    ; ////////////////////////////////////////////////////////////////////

    ; || -- Instrucoes de salto incondicional e condicional -- ||
        
        ; JMP
           
		   func:
		    
			MOV AH,2       
            MOV DL,'-'       
            INT 21h
           
		   JMP func
            
        ; JZ "label": Salta se flag ZERO=1
           
		   MOV AX,0
		   ADD AX,0
		   JZ fim
		   
		     MOV AX,2
			 
		   fim:
		   
			 MOV AX,3
		   
        ; JNZ "label": Salta se flag ZERO=0
           
           MOV AX,0
		   ADD AX,1
		   JZ else
		   
		     MOV AX,2
			 jmp fim
			 
		   else:
		   
			 MOV AX,3
		   
		   fim:
        
		; JE "label": Jump if Equal (igual a JZ) 
        
           MOV AX,0
		   MOV BX,0
		   CMP AX,BX
		   JE if
		   
		     MOV AX,2
			 jmp fim
			 
		   if:
		   
			 MOV AX,3
		   
		   fim:
        
        
        ; JNE "label": Jump if Not Equal (não igual a JNZ) 
        
           MOV AX,0
		   MOV BX,0
		   CMP AX,BX
		   JNE else
		   
		     MOV AX,2
			 jmp fim
			 
		   else:
		   
			 MOV AX,3
		   
		   fim:
        
        ; JG "label": Jump if Greater than (salta se >) 
           
		   MOV AL,4
		   MOV BL,2
		   
           func:
		  
            DEC AL ; Decrementa AL em uma unidade
			CMP AL,BL			
		    
		   JG func
        
        ; JGE "label": Jump if Greater than or Equal (salta se >=) 
        
           MOV AL,4
		   MOV BL,2
		   
           func:
		  
            DEC AL ; Decrementa AL em uma unidade
			CMP AL,BL ;  			
		    
		   JGE func 
        
        ; JL "label": Jump if Less than (salta se <) 
        
           MOV AL,2
		   MOV BL,4
		   
           func:
		  
            DEC BL
			CMP AL,BL			
		    
		   JL func
        
        ; JLE "label": Jump if Less or Equal (salta se <=)
        
           MOV AL,2
		   MOV BL,4
		   
           func:
		  
            DEC BL
			CMP AL,BL			
		    
		   JLE func
        
 
        ; JC "label": Salta se flag CARRY=1 
        
           ; Não documentado
           
        ; JNC "label": Salta se flag CARRY=0 
        
            ; Não documentado
        
        ; JO "label": Salta se flag OVERFLOW=1 
        
            ; Não documentado
        
        ; JNO "label": Salta se flag OVERFLOW=0 
        
            ; Não documentado
        
        ; JPO "label": Salta se flag PARITY=0 
        
            ; Não documentado
        
        ; JPE "label": Salta se flag PARITY=1 
        
            ; Não documentado
        
        ; JS "label": Salta se flag SIGNAL=1 
        
            ; Não documentado
        
        ; JNS "label": Salta se flag SIGNAL=0
        
            ; Não documentado
        
        ; JA "label": Jump if Above (salta se acima) 
        
            ; Não documentado
        
        ; JB "label": Jump if Below (salta se abaixo) 
        
            ; Não documentado
       
        ; JAE "label": Jump if Above or Equal (salta se acima ou =) 
        
            ; Não documentado
        
        ; JBE "label": Jump if Below of Equal (salta se abaixo ou =) 
        
            ; Não documentado
        
    ; ////////////////////////////////////////////////////////////////////
    ; ////////////////////////////////////////////////////////////////////      
    
        .model small
.stack 64
.data

msg1 db 'Informe o primeiro numero: $'
msg2 db 'Informe o segundo numero: $'
msg3 db 'Resultado da soma: $'

x db ?
y db ?
resultado db ?

.code

MOV AX,@data
MOV DS,AX

; Entrada do primeiro numero  

LEA DX,msg1
MOV AH,9h
INT 21h

CALL SCANF
MOV x,AL

; Entrada do segundo numero

LEA DX,msg2
MOV AH,9h
INT 21h

CALL SCANF
MOV y,AL

; Processamento

MOV AL,x
MOV BL,y
ADD AL,BL
MOV resultado,AL

; Saida

LEA DX,msg3
MOV AH,9h
INT 21h

MOV AL,resultado
CALL PRINTF

.exit
    
    
    ; || -- Instrucoes de laco (loop) -- ||
    
        ; [1] LOOP
            
            ; Implementa um laco de repeticao utilizando "label"
            ; Utiliza o CX como contador do laco
            ; Repete enquanto CX for diferente de ZERO
            ; Laco de repeticao de 10 ate 0
            
            MOV CX,10d
            laco:
                DEC CX
            loop laco
        
            
        ; [2] LOOPZ (CX != 0 E ZF = 0)
            
            ; Implementa um laco de repeticao utilizando "label"
            ; Utiliza o CX como contador do laco
            ; Repete enquanto CX for diferente de ZERO
            ; Laco de repeticao de 10 ate 0
            
			MOV CX,10d
            laco:
                DEC CX
				TEST CX,0
				
            loopz laco
        	
        ; [3] LOOPNZ (CX != 0 E ZF = 1)
            
			
			MOV CX,10d
            laco:
                DEC CX
				CMP CX,0
				
            loopnz laco
        
            
        ; [4] LOOPE 
        
            ; Não documentado
            
        ; [5] LOOPNE
            
            ; Não documentado
           
    ; ////////////////////////////////////////////////////////////////////
    ; ////////////////////////////////////////////////////////////////////
    
    ; || -- Entrada e Saida -- ||
    
        ; ENTRADA (TECLADO)   
        
    		; ENTRADA
            ; Realiza leitura do teclado em AL
            ; Registrador AH deve ser colocado em 1
            MOV AH,1       
            MOV AL,0       
            INT 21h 
        
        ; SAIDA (VIDEO)
            
            ; SAIDA
            ; Realiza escrita no monitor de video do conteudo de DL '-' em AL
            ; Registrador AH deve ser colocado em 2
            MOV AH,2       
            MOV DL,'-'       
            INT 21h
            
     ; || -- Estilizacao da Saida -- ||
     
            ; COR DO CARACTER
            ; AL deve ser o caracter a ser escrito 
            ; AH deve estar em 9h (resolucao padrao)
            ; BL define a cor do caracter
              ; 2h - verde
              ; 9h - azul 
              ; 8h - cinza
              ; 7h - branca
              ; 5h - roxa
              ; 4h - vermelha  
            
            ; DEFININDO UMA COR
            mov ah, 09h
            mov bl, 11h 
            int 10h
            
            ; ESCREVENDO UM CARACTER
            MOV AH,2       
            MOV DL,'-'       
            INT 21h
            
            ; COR DA TELA + CARACTER
            ; BH define a cor
              ; 2A : Amarelo sobre o azul
              ; 8Fh : dark gray
              ; 9F: light blue
              ; AF : light green
              ; BF : light cyan
              ; CF : light red
              ; DF : light magenta
            
            ; EXEMPLO DE MUDANCA DE COR DE TELA + CARACTER
            MOV AH, 06h    
            XOR AL, AL ; Limpa toda tela     
            XOR CX, CX     
            MOV DX, 184FH    
            MOV BH, 2Ah    
            INT 10h

 
       ; || -- Limpando a Saida (Tela) -- ||
 

            ; LIMPANDO A TELA
            mov AX,2h
            int 10h
       
       ; || -- Geracao de Semente -- ||
       
            ; CLOCK DO SISTEMA
            ; Captura o clock do sistema em DX
            ; Voce pode utilizar o clock como semente       
            MOV AH,0       
            INT 1Ah

       ; || -- Definindo a Posicao do cursor na tela -- ||

            ; DEFINE A POSICAO DO CURSOR
            ; AH deve estar em 2
            ; DL e DH devem ser linha e coluna
            MOV AH,2       
            MOV DL,5
            MOV DH,5
            INT 10h
            
       ; || -- Impressao de uma string de caracteres na tela -- ||
       
            LEA dx,msg2
            MOV ah, 9h
            INT 21h    
            
                    
    ; ////////////////////////////////////////////////////////////////////
    ; ////////////////////////////////////////////////////////////////////

    ; || -- Instrucoes de chamada de procedimentos (funcoes e macros ) -- ||
     
        ; Criacao de macro que popula valores
        MACRO POPULA
            POP AX,2 ; Move 2d para AX
            POP BX,4 ; Move 4d para BX
        ENDM
        
        ; Criacao de procedimento soma    
        SOMA PROC
            
            POPULA 
            ADD AX,BX ; Soma AX + BX    
        
        RET
        
        ENDP
        
        CALL SOMA
        
   
    ; ////////////////////////////////////////////////////////////////////
    ; ////////////////////////////////////////////////////////////////////
    
    ; || -- Exemplo de instrucoes de controle -- ||
    
        
        ; STD
            ; Coloca o FLAG DF (Flag de Direcao) em um
            
            STD
            
        ; CLD			
            ; Coloca o FLAG DF (Flag de Direcao) em zero 
            
            CLD
             
        ; STC
            ; Coloca o FLAG CF (Flag de Carry) em um
            
            STC
            
        ; CLC			
            ; Coloca o FLAG CF (Flag de Carry) em zero
            
            CLC
            
        
        ; STI			
            ; Coloca o FLAG IF (Flag de Interrupcao) em um
            
            STI
            
        ; CLI Coloca o FLAG IF (Flag de Interrupcao) em zero
            ;  
            
            CLI
            
        ; NOP
            ; Nao faz nada por um ciclo de instrucao (3 periodos de clock)
            
            NOP
            
    ; ////////////////////////////////////////////////////////////////////
    ; ////////////////////////////////////////////////////////////////////
    
    ; || -- Trabalhando com vetores -- ||
    ;
    ; Alocando memoria
    ; Leitura dos valores do vetor
    ; Processamento do vetor
    ; Escrita dos valores do vetor
    
    ; ////////////////////////////////////////////////////////////////////
    ; ////////////////////////////////////////////////////////////////////
    
    ; || -- Trabalhando com matrizes -- ||
    ;
    ; Alocando memoria
    ; Leitura dos valores da matriz
    ; Processamento da matriz
    ; Escrita dos valores da matriz
    
    
    ; ////////////////////////////////////////////////////////////////////
    ; ////////////////////////////////////////////////////////////////////
    
    ; Funcao de leitura de valores (numeros)
    ; Nao se esqueca de salvar os valores
    
    SCANF PROC
    
    mov dl, 10  
    mov bl, 0
      
    scanNum:
    
    	mov ah, 01h
    	int 21h
    	cmp al, 13   
    	je  f 
    	mov ah, 0  
    	sub al, 48   
    	mov cl, al
    	mov al, bl   
    	mul dl       
    	add al, cl   
    	mov bl, al
    	jmp scanNum
    	f:
    	mov ax,2h
    	int 10h
    	mov al,bl
    	mov ah,0
    	ret
    
    SCANF endp 
    
    PRINTF PROC

	mov dx,0
	mov ah,0
	cmp ax, 0
	jne print_ax_r
	push ax
	mov al, '0'
	mov ah, 0Eh
	int 10h
	pop ax
	ret 
	print_ax_r:
	pusha
	mov dx, 0
	cmp ax, 0
	je pn_done
	mov bx, 10
	div bx    
	call print_ax_r
	mov ax, dx
	add al, 30h
	mov ah, 0eh
	int 10h    
	jmp pn_done
	pn_done:
	popa  
	ret  
	
PRINTF endp
        
.exit ; Marca o fim do bloco de codigo (CS)      

