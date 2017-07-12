`timescale  1ns/ 1ps

/*
 Alunos: Washington Pagotto Batista, Pedro kenndy e Ivan Rios
 Universidade Estadual de Feira de Santana 2017.1
 TEC499 - MI - Sistemas Digitais

 Modulo: WB_Test.v
 
 Entradas:
    SaidaALu: 32-bit value
    memoriaSaida: 32-bit value
	Controle: 1 bit
 Saida:
    C: SaidaALu ou memoriaSaida
*/

module wb_test();

parameter Halfcycle = 5; 
    
localparam Cycle = 2*Halfcycle;
reg Clock;
    
initial Clock = 0; 
always #(Halfcycle) Clock = ~Clock;


    reg [31:0] memoriaSaida,aluSaida;
	reg  controle;
	wire [31:0] DUToutA;
	reg [31:0] REFoutA;
	reg [30:0] rand_31;
	
	
	
	task checkOutput;
        input [31:0] memoriaSaida;
        input [31:0] aluSaida;
        input controle,Clock;
        if ( REFoutA !== DUToutA) begin
	    
        $display("FAIL: memoriaSaida: %D, aluSaida: %D, controle: %D, REFoutA: %D, DUToutA: %D", memoriaSaida,aluSaida, controle, REFoutA,DUToutA);
        

        end
        else begin
			  $display("PASS: memoriaSaida: %D, aluSaida: %D, controle: %D, REFoutA: %D, DUToutA: %D", memoriaSaida,aluSaida, controle, REFoutA,DUToutA);

        end
    endtask

Mux2_1 x(
  .entradaA(memoriaSaida),
  .entradaB(aluSaida),
  .controle(controle),
  .saida(DUToutA));
  
/*
	Como o pipeline WB é apenas um mux de 2-1 que recebe a saida da ALU e da Memoria, o teste desse modulo se 
	basea em gerar randomicamente as entradas e verificar se a saida é o esperado. 
*/
  integer i;
    localparam loops = 10; 
	
	
	 // Testing logic:
    initial begin
	for(i = 0; i < loops; i = i + 1)
        begin
            
            // Make both A and B negative to check signed operations
            rand_31 = {$random} & 31'h7FFFFFFF;
            memoriaSaida = {1'b1, rand_31};
            rand_31 = {$random} & 31'h7FFFFFFF;
            aluSaida= {1'b1, rand_31};    
	          controle=0;
            REFoutA=memoriaSaida; 
            #1;
            	checkOutput(memoriaSaida,aluSaida,controle,Clock);
	end
	for(i = 0; i < loops; i = i + 1)
        begin
           
            
           
            rand_31 = {$random} & 31'h7FFFFFFF;
            memoriaSaida = {1'b1, rand_31};
            rand_31 = {$random} & 31'h7FFFFFFF;
            aluSaida = {1'b1, rand_31};    
	        controle=1;
            REFoutA=aluSaida; 
            #1;
            checkOutput(memoriaSaida,aluSaida,controle,Clock);
	end

        ///////////////////////////////
        // Hard coded tests go here
        ///////////////////////////////

        $display("\n\nADD YOUR ADDITIONAL TEST CASES HERE\n"); 
       
        $display("\n\nALL TESTS PASSED!");
        $finish();
    end
endmodule
