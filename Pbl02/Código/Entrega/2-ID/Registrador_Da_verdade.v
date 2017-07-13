/*
 Alunos: Washington Pagotto Batista, Pedro kenndy e Ivan Rios
 Universidade Estadual de Feira de Santana 2017.1
 TEC499 - MI - Sistemas Digitais

 Modulo: registrador_Da_verdade.v
 Descrição: Modulo criado para quinto estagio da pipeline 
 Entradas:
    registrador1,registrador2,destinoDoescreverData: 5-bit value
    wdataValor,saida1,saida1: 32-bit value
	VaiEscrever: 1 bit
	
 Saida:
    saida 1 e saida 2: r
*/
module registerBank
(
	input clk,	//clock
	input [4:0] registrador1,
	input [4:0] registrador2,
	input [4:0] destinoDoescreverData,
	input [31:0] wdataValor,
	input VaiEscrever,
	output reg [31:0] saida1,
	output reg [31:0] saida2

);
	reg [31:0] registrador_32 [1500:0];
	



	integer i;

	initial
	begin
	    for(i = 0; i < 32; i = i+1)
		begin
	        registrador_32[i] = 32'd4;
		end
	end
	
 	always @(clk, destinoDoescreverData, wdataValor, VaiEscrever) begin
		if (VaiEscrever && clk) begin
			
			registrador_32[destinoDoescreverData] <= wdataValor;
		end
	end

	always @(clk, registrador1, registrador2, VaiEscrever) begin
		if(~VaiEscrever) begin
			saida1<= registrador_32[registrador1];
  			saida2 <= registrador_32[registrador2];
		end
	end

 endmodule
