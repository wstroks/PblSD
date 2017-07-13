/*
 Alunos: Washington Pagotto Batista, Pedro kenndy e Ivan Rios
 Universidade Estadual de Feira de Santana 2017.1
 TEC499 - MI - Sistemas Digitais

 Modulo: SIng_ex-32.v
 Descrição: Modulo criado para quinto estagio da pipeline 
 Entradas:
    
    imediato: 32-bit value
	controle: 1 bit
	
 Saida:
    saida 1: extend o valor de entrada para 31
*/
module SignExtend(
	input [15:0] imediato,
	input controle,
	output reg [31:0] saida
);

	always @(*) begin
			if(controle==1)begin

			if(imediato[15]==1'b0)begin
				saida[31:0] <= {{16'b0},imediato[15:0]};
			end
			else begin
				saida[31:0] <= {{16'b1111111111111111},imediato[15:0]};
			end

		end

		else begin
			saida[31:0] <= {{16{1'b0}},imediato[15:0]};
		end
	end
endmodule 
