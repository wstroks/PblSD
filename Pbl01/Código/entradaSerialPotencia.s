###############################################
# Teste Potencia - PBL 1 
# Grupo: Washington, Pedro Kennedy e Ivan 
###############################################

		.data
		.equ UART0, 0x860       #porta Serial Uart0
		#armazenando o valor na word e printando uma mensagem
		resultado:  
		.word 0
		msgResultado:
		.asciz "Resultado: "
		.text

main:	        movia r5, UART0
		call nr_uart_rxchar  #macro que ler o que é enviado pelo uart0
		blt r2, r0, main
		
	        subi r6, r2, 48      #pega o valor que foi digitado e subtrai por -48( por causa da tabela asc)
	        movia r8, 46         #armazena o primeiro valor inserido 
		
loop:         	movia r9,46          #em asc o numero 46 representa um Ponto " . "
	      	beq r9, r2, base     #caso exista o valor digitado seje 46 terminou o valor da base
              	movia r4, UART0
	      	call nr_uart_rxchar  #macro que ler o que é enviado ... 0 a 9
	      	blt r2, r0, loop     
	       	movia r10,35	     # em asc o numero 35 representa o #
	       	beq r9, r2, base   
	      	beq r10, r2, expoente # se for igual a 35, o valor para o expoente terminou
	      
ascParaDec:     mov r7, r2           #passa o valor atual para o r7 temporario
	        muli r6, r6, 10      #Pegar o valor inserido e multiplica por 10 para aceita a concatenação de outro numero
	        subi r7, r7, 48      #vamos que irá concatenar -48 por causa da tabela asc
	        add r6, r6, r7       #cocatena os valores atraves da soma 
	        br loop              # retorna para o br e verifica se tem algum numero para cocatenar
	      
     

base:           mov r11, r6         #registrador irá está armazenado o valor da base
                br  main            #retorna tudo para receber o valor do expoente


expoente:    mov r12, r6           #registrador que irá armazenar o valor do expoente
	     movi r14, 1           #registrador que está contido o resultado
	     mov r8, r12           #passa o valor do expoente para decrementar e fazer o calculo

LoopCondicao: subi r8,r8,1         #decrementa quantas vezes precisa multiplicar para chegar ao resultado
	      mul r14,r14, r11
	      bne r8,r0, LoopCondicao		
	
	
PritandoResultado: 
		movia r9, resultado     #move a word
		stw r14, 0(r9)		#pega o enderesso que está no r9 e altera o seu valor para resultado 
		movia r4, msgResultado  #printa a mensagem para o resultado
		movia r5, UART0		
		call nr_uart_txstring	#Macro que ler uma string 
		mov r4, r14		
		movia r5, UART0		
		call nr_uart_txhex32  #Pega o resultado e joga para macro que ler em hexadecimal 
		br fim


		
fim: