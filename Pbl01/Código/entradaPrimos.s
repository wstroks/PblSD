## Teste bubblesort - PBL de SD 2017.1
## Grupo: Washington Pagotto Batista, Pedro Kenndy e Ivan
.data

	        .equ UART0, 0x860       #porta Serial Uart0
		#armazenando o valor na word e printando uma mensagem
		msg: 
		.asciz "Resultado:"  #asc para printar resultado

		msg1:
		.asciz " "

		resultado:  
		.skip 128    #Esse é o vetor que criado para receber as operações, sendo um vetor definido em 5
		
	
.text
main:	        movia r5, UART0
		call nr_uart_rxchar  #macro que ler o que é enviado pelo uart0
		blt r2, r0, main
		
	        subi r6, r2, 48      #pega o valor que foi digitado e subtrai por -48( por causa da tabela asc)
	        movia r8, 46         #armazena o primeiro valor inserido 
		
deNoVo:         movia r16,46          #em asc o numero 46 representa um Ponto " . "
	      	beq r16, r2, inicia     #caso exista o valor digitado seja 46 terminou o numero inserido e inicia o calculo
              	movia r5, UART0
	      	call nr_uart_rxchar  #macro que ler o que é enviado ... 0 a 9
	      	blt r2, r0, deNoVo    
	       
	       	beq r16, r2, inicia   
	     
	      
ascParaDec:     mov r7, r2           #passa o valor atual para o r7 temporario
	        muli r6, r6, 10      #Pegar o valor inserido e multiplica por 10 para aceita a concatenação de outro numero
	        subi r7, r7, 48      #vamos que irá concatenar -48 por causa da tabela asc
	        add r6, r6, r7       #cocatena os valores atraves da soma 
	        br deNoVo 	

inicia:        
		mov r8,r6
		mov r16,r8
		addi r10, r0, 1
		add r20, sp, r0
		br primos

primos:
		addi r10, r10, 1
		beq r9, r0, adicionarValor
		
		mov r11, r0
		mov sp, r20
		subi sp, sp, 4 
		
		br loop

adicionarValor:
		addi r9, r9 , 1
		addi sp, sp, -4
		stw r10, 0(sp)
		beq r8, r9, exit
		br primos

loop:
		addi r11, r11, 1
		bgt r11, r9, primos

		ldw r12, 0(sp)
		subi sp, sp, 4
		
		div r13, r10, r12
		mul r14, r13, r12
		sub r14, r10, r14
		
		beq r14, r0, primos

		blt r13, r12, reset
		br loop

reset:
		mov sp, r20
		muli r11, r9, 4
		sub sp, sp, r11
		br adicionarValor

exit:         movia r22, resultado
	      mov r7,r16
	      
v:	      beq r7,r0,add
	      ldw r15, 0(sp)
	      mov r18,r15
	      stw r18, 0(r22) 
              addi r22,r22,4
              addi sp,sp,4
              subi r7,r7,1
              br v 
add:              
                movia r23, resultado
               mov r7,r16
			
		movia r4, msg  #printa a mensagem para o resultado
		movia r5, UART0		
		call nr_uart_txstring	#Macro que ler uma string 
		
repete:           
		movia r4, msg1  #printa a mensagem para o resultado
		movia r5, UART0		
		call nr_uart_txstring	#Macro que ler uma string 
		beq r7,r0,fim
		ldw r15, 0(r23)
		mov r4, r15		
		movia r5, UART0		
		call nr_uart_txhex32  #Pega o resultado e joga para macro que ler em hexadecimal
		#addi sp,sp,4
		subi r7,r7,1
		addi r23,r23,4
		br repete
fim:

		