`timescale 1ns / 1ps
module teste_ar();

parameter Halfcycle = 5; //half period is 5ns
    
localparam Cycle = 2*Halfcycle;
    
reg Clock;
    
    // Clock Signal generation:
initial Clock = 0; 
always #(Halfcycle) Clock = ~Clock;


	reg [31:0] endereco;
	reg readyRx0, readyRx1, busyTX0, busyTX1,ocupadoPC;
	wire enableTx0, enableTx1, reseta0, reseta1,DadoProntoMem0,DadoProntoMem1;
	
	reg REFoutenableTx0, REFoutenableTx1, REFoutreseta0, REFoutreseta1,REFoutDadoProntoMem0,REFoutDadoProntoMem1;
	
	
	
    
    reg [31:0] Address;
    reg MemWrite;
	reg [7:0] WriteData;
    wire [7:0] ReadData;
	
	
	
	reg [7:0] REFoutReadData;
   
	

arbitro DUT1(

	.endereco(endereco),
	.readyRx0(readyRx0), 
	.readyRx1(readyRx1), 
	.busyTX0(busyTX0), 
	.busyTX1(busyTX1),
	.ocupadoPC(ocupadoPC),
	.enableTx0(enableTx0), 
	.enableTx1(enableTx1), 
	.reseta0(reseta0), 
	.reseta1(reseta1),
	.DadoProntoMem0(DadoProntoMem0),
	.DadoProntoMem1(DadoProntoMem1)
);


memoria memo(
    
    .Address(Address),
    .MemWrite(MemWrite),
	.WriteData(WriteData),
    .ReadData(ReadData)
    );
task checkOutput;
        input [31:0] endereco;
	    input readyRx0, readyRx1, busyTX0, busyTX1,ocupadoPC;
        input Clock;
		
		input [31:0] Address;
		input MemWrite;
		input [7:0] WriteData;
        if (REFoutenableTx0 !== enableTx0 || enableTx1!== REFoutenableTx1 || REFoutreseta0 !== reseta0 || reseta1!== REFoutreseta1 || DadoProntoMem0 !== REFoutDadoProntoMem0 || DadoProntoMem1 !==REFoutDadoProntoMem1 || REFoutReadData!==ReadData) begin
	    
            $display("Erro uart0: enableTx0 %d == %d REFoutenableTx0,  REFoutreseta0 %d == %d reseta0,DadoProntoMem0  %d == %d REFoutDadoProntoMem0", enableTx0, REFoutenableTx0,   REFoutreseta0, reseta0,DadoProntoMem0 , REFoutDadoProntoMem0);
			$display("Erro uart1: enableTx1 %d == %d REFoutenableTx1 , REFoutreseta1 %d == %d reseta1 ,DadoProntoMem1  %d == %d REFoutDadoProntoMem1",  enableTx1 , REFoutenableTx1 ,REFoutreseta1 , reseta1 ,DadoProntoMem1  , REFoutDadoProntoMem1);
			$display("Erro memoria: REFoutReadData %d == %d ReadData\n",REFoutReadData,ReadData);
        end
        else begin
			$display("Passou uart0: enableTx0 %d == %d REFoutenableTx0,  REFoutreseta0 %d == %d reseta0,DadoProntoMem0  %d == %d REFoutDadoProntoMem0", enableTx0, REFoutenableTx0,   REFoutreseta0, reseta0,DadoProntoMem0 , REFoutDadoProntoMem0);
			$display("Passou uart1:enableTx1 %d == %d REFoutenableTx1 , REFoutreseta1 %d == %d reseta1 ,DadoProntoMem1  %d == %d REFoutDadoProntoMem1",  enableTx1 , REFoutenableTx1 ,REFoutreseta1 , reseta1 ,DadoProntoMem1  , REFoutDadoProntoMem1);
			$display("Passou memoria: REFoutReadData %d == %d ReadData\n",REFoutReadData,ReadData);
        end
    endtask
	
	
initial begin 
				//primeiro teste simula o pc ocupado 
				endereco=32'd50;
				readyRx0=1;  //uart0 ja tem o dado pronto e quer escrever na memoria
				readyRx1=0;  // uart1 nao tá sendo usada
				busyTX0=1; 
				busyTX1=0;
				ocupadoPC=1;
				REFoutenableTx0=0;
				REFoutenableTx1=0;
				REFoutreseta0=0; 
				REFoutreseta1=0;
				REFoutDadoProntoMem0=0;
				REFoutDadoProntoMem1=0;
				
				// retorna  o que esta sendo lido nessa memoria
				Address=endereco;
                MemWrite=1;
	            WriteData=7'd12;
    	        REFoutReadData=7'd12;
				

				
				#1;
			
			  	checkOutput(endereco, readyRx0, readyRx1, busyTX0, busyTX1,ocupadoPC, Address,MemWrite,WriteData,Clock);

				
				
				// pc desocupado o uso da memoria uart0 e uart1 quer escrever .. mas a prioridade é a 0
				endereco=32'd50;
				readyRx0=1;  //uart0 ja tem o dado pronto e quer escrever na memoria
				readyRx1=1;  // uart1 nao tá sendo usada
				busyTX0=1; 
				busyTX1=0;
				ocupadoPC=0;
				REFoutenableTx0=0;
				REFoutenableTx1=0;
				REFoutreseta0=1; 
				REFoutreseta1=0;
				REFoutDadoProntoMem0=1;
				REFoutDadoProntoMem1=0;
				
				// retorna  o que esta sendo lido nessa memoria
				Address=endereco;
                MemWrite=REFoutDadoProntoMem0;
	            WriteData=7'd40;
    	        REFoutReadData=7'd40;
				

				
				#1;
				
			  	checkOutput(endereco, readyRx0, readyRx1, busyTX0, busyTX1,ocupadoPC, Address,MemWrite,WriteData,Clock);

				
				//teste vai dah um erro pois a saida do dado da uart1 tem que ser zero visto que nao pode usar
				// pc desocupado o uso da memoria uart0 e uart1 quer escrever .. mas a prioridade é a 0
				endereco=32'd60;
				readyRx0=1;  //uart0 ja tem o dado pronto e quer escrever na memoria
				readyRx1=1;  // uart1 nao tá sendo usada
				busyTX0=1; 
				busyTX1=0;
				ocupadoPC=0;
				REFoutenableTx0=0;
				REFoutenableTx1=0;
				REFoutreseta0=1; 
				REFoutreseta1=0;
				REFoutDadoProntoMem0=1;
				REFoutDadoProntoMem1=1;
				
				Address=endereco;
                MemWrite=0;
	            WriteData=7'd40;
    	        REFoutReadData=7'd0;
				

				
				#1;
				
			  	checkOutput(endereco, readyRx0, readyRx1, busyTX0, busyTX1,ocupadoPC, Address,MemWrite,WriteData,Clock);
				//pc ocupado
				endereco=32'd60;
				readyRx0=0;  //uart0 ja tem o dado pronto e quer escrever na memoria
				readyRx1=1;  // uart1 nao tá sendo usada
				busyTX0=0; 
				busyTX1=0;
				ocupadoPC=1;
				REFoutenableTx0=0;
				REFoutenableTx1=0;
				REFoutreseta0=0; 
				REFoutreseta1=0;
				REFoutDadoProntoMem0=0;
				REFoutDadoProntoMem1=1;
				
				Address=endereco;
                MemWrite=0;
	            WriteData=7'd40;
    	        REFoutReadData=7'd0;
				

				
				#1;
				
			  	checkOutput(endereco, readyRx0, readyRx1, busyTX0, busyTX1,ocupadoPC, Address,MemWrite,WriteData,Clock);
				
				// Condição para o uart1 escrever na memoria
				endereco=32'd60;
				readyRx0=0;  //uart0 nao ta usando a memoria
				readyRx1=1;  // uart1 nao tá sendo usada
				busyTX0=0; 
				busyTX1=1;
				ocupadoPC=0;
				REFoutenableTx0=0;
				REFoutenableTx1=0;
				REFoutreseta0=0; 
				REFoutreseta1=1;
				REFoutDadoProntoMem0=0;
				REFoutDadoProntoMem1=1;

				Address=endereco;
                MemWrite=REFoutDadoProntoMem1;
	            WriteData=7'd50;
    	        REFoutReadData=7'd50;
				
				#1;
				
			  	checkOutput(endereco, readyRx0, readyRx1, busyTX0, busyTX1,ocupadoPC, Address,MemWrite,WriteData,Clock);
				
				
				
				
				// Condição para o uart1 escrever na memoria  na memoria  gerando um erro pois deveria ativar Men1
				endereco=32'd60;
				readyRx0=0;  //uart0 nao ta usando a memoria
				readyRx1=1;  // uart1 nao tá sendo usada
				busyTX0=1; 
				busyTX1=0;
				ocupadoPC=0;
				REFoutenableTx0=0;
				REFoutenableTx1=0;
				REFoutreseta0=0; 
				REFoutreseta1=0;
				REFoutDadoProntoMem0=0;
				REFoutDadoProntoMem1=0;
				
				Address=endereco;
                MemWrite=0;
	            WriteData=7'd50;
    	        REFoutReadData=7'd50;
				

				
				#1;
				
			  checkOutput(endereco, readyRx0, readyRx1, busyTX0, busyTX1,ocupadoPC, Address,MemWrite,WriteData,Clock);
			  
			  
			/*  // Condição para o uart1 escrever na memoria  na memoria 
				endereco=32'd50;
				readyRx0=0;  //uart0 nao ta usando a memoria
				readyRx1=0;  // uart1 nao tá sendo usada
				busyTX0=1; 
				busyTX1=0;
				ocupadoPC=0;
				REFoutenableTx0=0;
				REFoutenableTx1=0;
				REFoutreseta0=0; 
				REFoutreseta1=0;
				REFoutDadoProntoMem0=0;
				REFoutDadoProntoMem1=0;
				
				Address=endereco;
                MemWrite=0;
	            WriteData=7'd50;
    	        REFoutReadData=7'd40;
				

				
				#1;
				
			  checkOutput(endereco, readyRx0, readyRx1, busyTX0, busyTX1,ocupadoPC, Address,MemWrite,WriteData,Clock);*/

end

endmodule
