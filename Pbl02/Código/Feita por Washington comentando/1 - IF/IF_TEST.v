`timescale  1ns/ 1ps
module if_test();

/*
 Alunos: Washington Pagotto Batista, Pedro kenndy e Ivan Rios
 Universidade Estadual de Feira de Santana 2017.1
 TEC499 - MI - Sistemas Digitais

 Modulo: IF_Test.v
 
 Entradas:
    entradaPC,ALu,data1,data2: 32 bits
    PCescreve, clock, c1,c2,ler,escreve: 1 bit
	Controle: 1 bit
 Saida:
   DUToutPcsaida, DUToutSaidaDadosInstruc,DUToutwriteDataMemWB,DUToutsaidaAdder,DUToutsaidaMemoria: 32 bit
*/
parameter Halfcycle = 5; //half period is 5ns
    
localparam Cycle = 2*Halfcycle;
    
reg Clock;
    
    // Clock Signal generation:
initial Clock = 0; 
always #(Halfcycle) Clock = ~Clock;

		//variaveis que vão receber do modulo IF
        reg [31:0] entradaPC,ALu,data1,data2;
		reg PCescreve, clock, c1,c2,ler,escreve;
		wire [31:0] DUToutPcsaida, DUToutSaidaDadosInstruc,DUToutwriteDataMemWB,DUToutsaidaAdder,DUToutsaidaMemoria;
		reg [31:0] REFoutPCSaida,REFoutSaidaDadaosInstruc,REFoutwriteDataMemWB,REFoutsaidaMemoria,REFoutsaidaAdder;
	    reg [30:0] rand_31;
		reg[31:0] um= 32'h00000001;
	    reg[31:0] x= 32'h00000001;
		reg[31:0] y= 32'h00000000;
		reg[31:0] d= 32'h00000001;
		
//insta do modulo if	
IF DUT1(

	 .entradaPC(entradaPC),.ALu(ALu),.data1(data1),.data2(data2),
	 .PCescreve(PCescreve), .clock(clock), .c1(c1),.c2(c2),.ler(ler),.escreve(escreve),
	 .Pcsaida(DUToutPcsaida), .SaidaDadosInstruc(DUToutSaidaDadosInstruc),.writeDataMemWB(DUToutwriteDataMemWB),.saidaAdder(DUToutsaidaAdder),.saidaMemoria(DUToutsaidaMemoria)


);		
		
	
		
task checkOutput;
        input[31:0] entradaPC,ALu,data1,data2;
		input PCescreve, clock, c1,c2,ler,escreve;
        input Clock;
        if ( REFoutPCSaida !== DUToutPcsaida || REFoutSaidaDadaosInstruc!==DUToutSaidaDadosInstruc || REFoutwriteDataMemWB!==DUToutwriteDataMemWB || REFoutsaidaAdder!==DUToutsaidaAdder || REFoutsaidaMemoria!== DUToutsaidaMemoria) begin
	    
            $display("Erro: \tentradaPC: %D, ALu: %D, data1: %D, data2: %D, PCescreve: %D,clock: %D,c1: %D,c2: %D,ler: %D,escreve: %D", entradaPC, ALu , data1 , data2 , PCescreve,clock,c1,c2,ler,escreve);
			$display("DUToutPcsaida: %D,REFoutPCSaida: %D,DUToutSaidaDadosInstruc: %D,REFoutSaidaDadaosInstruc: %D,DUToutwriteDataMemWB: %D,\nREFoutwriteDataMemWB: %D,DUToutsaidaAdder: %D,REFoutsaidaAdder: %D,REFoutsaidaMemoria: %D,DUToutsaidaMemoria: %D",DUToutPcsaida,REFoutPCSaida,DUToutSaidaDadosInstruc,REFoutSaidaDadaosInstruc,DUToutwriteDataMemWB,REFoutwriteDataMemWB,DUToutsaidaAdder,REFoutsaidaAdder,REFoutsaidaMemoria,DUToutsaidaMemoria);
			$finish();
        end
        else begin
			$display("Passou: \tentradaPC: %D, ALu: %D, data1: %D, data2: %D, PCescreve: %D,clock: %D,c1: %D,c2: %D,ler: %D,escreve: %D", entradaPC, ALu , data1 , data2 , PCescreve,clock,c1,c2,ler,escreve);
			$display("DUToutPcsaida: %D,REFoutPCSaida: %D,DUToutSaidaDadosInstruc: %D,REFoutSaidaDadaosInstruc: %D,DUToutwriteDataMemWB: %D, \nREFoutwriteDataMemWB: %D,DUToutsaidaAdder: %D,REFoutsaidaAdder: %D,REFoutsaidaMemoria: %D,DUToutsaidaMemoria: %D",DUToutPcsaida,REFoutPCSaida,DUToutSaidaDadosInstruc,REFoutSaidaDadaosInstruc,DUToutwriteDataMemWB,REFoutwriteDataMemWB,DUToutsaidaAdder,REFoutsaidaAdder,REFoutsaidaMemoria,DUToutsaidaMemoria);
        end
    endtask

integer i;
    localparam loops = 5; 
	
	
	 // Testing logic:
    initial begin
	for(i = 0; i < loops; i = i + 1)
        begin
            #1;
            /*
				Nesse primeiro teste, Está sendo salvo randomicamente na memória as saidas recebidas da Alu. Assim sucessivamente, vale ressaltar que o dado gerado no PC é random entao
				não apresenta logica de 4 em 4, mas é verificado se a logica está corretar no adder. Outro detalhe por ser uma escrita na memoria não é gerado uma saida para esse modulo.
			*/
			
			
            rand_31 = {$random} & 31'h7FFFFFFF;
            entradaPC = {1'b1, rand_31};
            rand_31 = {$random} & 31'h7FFFFFFF;
            ALu= {1'b1, rand_31};
			rand_31 = {$random} & 31'h7FFFFFFF;
            data1= {1'b1, rand_31};
			rand_31 = {$random} & 31'h7FFFFFFF;
            data2= {1'b1, rand_31};
			PCescreve=1;
			clock=1;
			c1=0;
			c2=0;
			ler=0;
			escreve=1;
			REFoutPCSaida=entradaPC;
			REFoutSaidaDadaosInstruc=ALu;
			REFoutwriteDataMemWB=data1;
			//REFoutsaidaMemoria=,
			REFoutsaidaAdder= entradaPC +32'h00000004;
			
	        
            
            #1;
			clock=0;
            	checkOutput(entradaPC, ALu , data1 , data2 , PCescreve,clock,c1,c2,ler,escreve,Clock);
	end
	
for(i = 0; i < loops; i = i + 1)
        begin
            #1;
            /*
				Como no primeiro caso foi escrito randomicamente na memoria é necessário faze uma escrita manualmente para ser lido.
			*/
			
			
            rand_31 = {$random} & 31'h7FFFFFFF;
            entradaPC = {1'b1, rand_31};
            rand_31 = {$random} & 31'h7FFFFFFF;
            ALu= um;
			data1= 32'h00000000 +um ;
			x= 32'h00000001 +um;
			um=x;
			
			rand_31 = {$random} & 31'h7FFFFFFF;
            data2= {1'b1, rand_31};
			PCescreve=1;
			clock=1;
			c1=0;
			c2=0;
			ler=0;
			escreve=1;
			REFoutPCSaida=entradaPC;
			REFoutSaidaDadaosInstruc=ALu;
			REFoutwriteDataMemWB=data1;
			//REFoutsaidaMemoria=,
			REFoutsaidaAdder= entradaPC+32'h00000004;
			
	        
            
            #1;
			clock=0;
            	checkOutput(entradaPC, ALu , data1 , data2 , PCescreve,clock,c1,c2,ler,escreve,Clock);
	end
	
	um=32'h00000001;
	x=32'h00000001;
	for(i = 0; i < loops; i = i + 1)
        begin
            #1;
            /*
				Como ja foi escrito na memoria manualmente e eu sei a posição de cada endereço. Esse teste basicamente verifica se o que foi escrito realmente esta na memoria
			*/
			
		
            rand_31 = {$random} & 31'h7FFFFFFF;
            entradaPC = {1'b1, rand_31};
            ALu= um;
			data1= 32'h00000000 +um ;
			x= 32'h00000001 +um;
			um=x;
			rand_31 = {$random} & 31'h7FFFFFFF;
            data2= {1'b1, rand_31};
			PCescreve=1;
			clock=1;
			c1=0;
			c2=0;
			ler=1;
			escreve=0;
			
			REFoutPCSaida=entradaPC;
			REFoutSaidaDadaosInstruc=ALu;
			REFoutwriteDataMemWB=data1;
			REFoutsaidaMemoria=ALu;
			REFoutsaidaAdder= entradaPC+32'h00000004;
			
	        
            
            #1;
			clock=0;
            	checkOutput(entradaPC, ALu , data1 , data2 , PCescreve,clock,c1,c2,ler,escreve,Clock);
	end
	
        ///////////////////////////////
        // Hard coded tests go here
        ///////////////////////////////

        $display("\n\nADD YOUR ADDITIONAL TEST CASES HERE\n"); 
       
        $display("\n\nALL TESTS PASSED!");
        $finish();
    end




endmodule
