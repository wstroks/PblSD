# Calcula o fibonacci de r4
# Resultado final vai estar salvo em r4
# r4 = fib(r4)
.data
		.equ UART0, 0x860       #porta Serial Uart0
                
                resultado:  
		.word 0
		
		
		msgResultado:
		.asciz "Resultado: "
.text

main:	        

		movia r5, UART0
		call nr_uart_rxchar  #macro que ler o que é enviado pelo uart0
		blt r2, r0, main
		
	        subi r6, r2, 48      #pega o valor que foi digitado e subtrai por -48( por causa da tabela asc)
	        movia r8, 46         #armazena o primeiro valor inserido 
		
loop:         	movia r9,46          #em asc o numero 46 representa um Ponto " . "
	      	beq r9, r2, inicia     #caso exista o valor digitado seja 46 terminou o numero inserido e inicia o calculo
              	movia r4, UART0
	      	call nr_uart_rxchar  #macro que ler o que é enviado ... 0 a 9
	      	blt r2, r0, loop     
	       
	       	beq r9, r2, inicia   
	     
	      
ascParaDec:     mov r7, r2           #passa o valor atual para o r7 temporario
	        muli r6, r6, 10      #Pegar o valor inserido e multiplica por 10 para aceita a concatenação de outro numero
	        subi r7, r7, 48      #vamos que irá concatenar -48 por causa da tabela asc
	        add r6, r6, r7       #cocatena os valores atraves da soma 
	        br loop



inicia:

  
    mov r4,r6                   # r4 = x ,  coloque o valor de n desejado nesta linha
    call fib                         # fib(r4)
    br exit                          # pula para o fim do programa
   
fib:
    addi r9,r0, 1                      # r9 = 1
    cmplt  r10, r9, r4                 # if (r9 < r4) r10 = 1 else r10 = 0
    bne    r10, r0, fib_recurse        # if (r10 != 0) goto fib_recuse
    mov    r2, r4                      # r2 = r4
    jmp  ra                            # goto endereco de retorno
 
fib_recurse:
    addi sp, sp, -12                # libera 3 espacos na pilha
    stw ra, 0(sp)                    # salva endereco de retorno na pilha
    stw  r4, 4(sp)                  # salva n na pilha
 
    addi     r4, r4, -1           # r4 = r4 - 1
    call     fib                    # fib(r4-1)
    ldw      r4, 4(sp)              # carrega r4 da pilha
    stw  r2, 8(sp)                 # salva o resultado de fib(r4-1) na pilha
   
    addi r4, r4, -2               # r4 = r4 - 2
    call fib                         # fib(r4-2)
 
    ldw  r8, 8(sp)                 # carrega o resultado de fib(r4-1) da pilha
    add r2, r8, r2               # soma o resultado de fib(r4-2) com fib(r4-1) e guarda o resultado em r2
 
    ldw  ra, 0(sp)                 # carrega o endereco de retorno da pilha
    addi sp, sp, 12               # restaura o ponteiro da pilha
    jmp  ra                         # goto endereco de retorno
 
exit:		mov r14, r2
		movia r9, resultado     #move a word
		     
		movia r4, msgResultado  #printa a mensagem para o resultado
		movia r5, UART0		
		call nr_uart_txstring	#Macro que ler uma string 
		stw r14, 0(r9)
		mov r4, r14
		
		movia r5, UART0		
		call nr_uart_txhex32  #Pega o resultado e joga para macro que ler em hexadecimal
			

			
