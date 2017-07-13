/*
 Alunos: Washington Pagotto Batista, Pedro kenndy e Ivan Rios
 Universidade Estadual de Feira de Santana 2017.1
 TEC499 - MI - Sistemas Digitais

 Modulo: extend_26.v
 Descrição: Modulo criado para quinto estagio da pipeline 
 Entradas:
   
    recebeExtend: 26-bit value
	
	
 Saida:
    saida: 32 bits
*/
module jump(
	input [25:0] recebeExtend,
	output reg [31:0] saida
);

	always @(*) begin
	    		 saida[31:0] <= {{6'b0},recebeExtend[25:0]};
	end

endmodule 

