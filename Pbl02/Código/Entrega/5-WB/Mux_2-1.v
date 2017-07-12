/*
 Alunos: Washington Pagotto Batista, Pedro kenndy e Ivan Rios
 Universidade Estadual de Feira de Santana 2017.1
 TEC499 - MI - Sistemas Digitais

 Modulo: Mux_2-1.v
 Descrição: Modulo criado para escolher um determinada saida, determinado como MUX
 Entradas:
    entradaA: 32-bit value
    entradaB: 32-bit value
	  controle: 1 bit
 Saida:
    C: entradaA ou entradaB
*/
module Mux2_1(
        input [31:0] entradaA,
        input [31:0] entradaB,
        input controle,
        output reg [31:0] saida
);

  always @(*) begin

      if (~controle)
        saida <= entradaA;

      else
        saida <= entradaB;

    end


endmodule

