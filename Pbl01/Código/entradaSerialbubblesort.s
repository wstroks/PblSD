## Teste bubblesort - PBL de SD 2017.1
## Grupo: Washington Pagotto Batista, Pedro Kenndy e Ivan

.data

.equ UART0, 0x860   #Porta serial uart0


msg: 
.asciz "Resultado:"  #asc para printar resultado

msg1:
.asciz " "

resultado:  
.word 1,2,3,4,5   #Esse é o vetor que criado para receber as operações, sendo um vetor definido em 5


.text
main:
                movia r13, resultado    #recebe o vetor 

portaSerial:	movia r5, UART0
		call nr_uart_rxchar  #macro que ler o que é enviado pelo uart0
		blt r2, r0, portaSerial
		
	        subi r6, r2, 48      #pega o valor que foi digitado e subtrai por -48( por causa da tabela asc)
	        movia r8, 46         #armazena o primeiro valor inserido 
		
loop:         	movia r9,46          #em asc o numero 46 representa um Ponto " . "
	      	beq r9, r2, valorADD    #caso exista o valor digitado seje 46 terminou o valor da base
              	movia r4, UART0
	      	call nr_uart_rxchar  #macro que ler o que é enviado ... 0 a 9
	      	blt r2, r0, loop     
	       	movia r10,35	     # em asc o numero 35 representa o #
	       	beq r9, r2, valorADD   
	      	beq r10, r2, valorADD    
	      
ascParaDec:     mov r7, r2           #passa o valor atual para o r7 temporario
	        muli r6, r6, 10      #Pegar o valor inserido e multiplica por 10 para aceita a concatenação de outro numero
	        subi r7, r7, 48      #vamos que irá concatenar -48 por causa da tabela asc
	        add r6, r6, r7       #cocatena os valores atraves da soma 
	        br loop              # retorna para o br e verifica se tem algum numero para cocatenar
	      
     

valorADD:           mov r11, r6         #registrador irá está armazenado o valor da base
		
	        stw  r11, 0(r13) 
	        addi r13,r13, 4
	        
	        mov r6,r0
	        beq r10, r2, inicia  #termina a leitura do vetor pela porta serial 
                br  portaSerial            


inicia:		movi r7, 5		          #Definindo o tamanho do vector .... tem que ter na porta serial
		subi r10, r7, 2
		mov r8, r7
		movi r6, 16	                  #Quantidade de comparações que tem que ser feitas visto que 
	      
	                                         
LoopInicio:
		
		movia r11, resultado	          #Inicia o vetor
			
LoopCondicaoDeTroca:
		ldw r12, 0(r11) 	          #Pega o primeiro elemento ou o atual a depender do resete 
		ldw r13, 4(r11) 	          #Pega o proximo valor
		
		cmpgt r15, r12, r13 	          #Verifica de posicao atual é maior que o proximo( r13>r14) se for verdade retorna 1
		beq r15, r0, NaoAlteraValor       #se igual a 0, nao troca os valores
		bne r15, r0, AlteraValor          # se for diferente deve ir para a proxima comparação
			


			
NaoAlteraValor:	addi r11, r11, 4		   #Contador que irá incrementar a posicao no vetor pro proximo
		bge r9, r10, resetadeira	   #como já foi verificado dois vetores das 5, se chega a 3 verificações reseta tudo para verificar de novo o vetor
		addi r9, r9, 1		           #Contador na condicao de troca
		br LoopCondicaoDeTroca
			
			
AlteraValor: 
		stw r12, 4(r11)               #salvar as alterações
		stw r13, 0(r11)
			
		br NaoAlteraValor
				
resetadeira:		
		subi r8, r8, 1		  #caso o vetor ainda precise rodar novamente ele reseta e retorna tudo	        
		mov r9, r0			       
		bne r8, r0, LoopInicio
			
			
PritandoResultado: 
		movia r11, resultado
			
		movia r4, msg  #printa a mensagem para o resultado
		movia r5, UART0		
		call nr_uart_txstring	#Macro que ler uma string 
		
repete:           
		movia r4, msg1  #printa a mensagem para o resultado
		movia r5, UART0		
		call nr_uart_txstring	#Macro que ler uma string 
		beq r7,r0,fim
		ldw r15, 0(r11)
		mov r4, r15		
		movia r5, UART0		
		call nr_uart_txhex32  #Pega o resultado e joga para macro que ler em hexadecimal
		addi r11,r11,4
		subi r7,r7,1
		br repete


		
fim:             
