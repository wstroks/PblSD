/*
 Alunos: Washington Pagotto Batista, Pedro kenndy e Ivan Rios
 Universidade Estadual de Feira de Santana 2017.1
 TEC499 - MI - Sistemas Digitais

 Modulo: Mux_4-1.v
 Descrição: Modulo criado para escolher um determinada saida, determinado como MUX
 Entradas:
    entradaA: 32-bit value
    entradaB: 32-bit value
    entradaC: 32-bit value
    entradaD: 32-bit value
	  controle: 1 bit
 Saida:
    saida: entradaA ou entradaB ou entradaC ou entradaD
*/
module Mux4_1(
  input [31:0] entradaA, entradaB, entradaC, entradaD,
  input [1:0] controle,
  output reg [31:0] saidaMux4_1
);

  always @(*) begin

    if(controle == 2'b00)
      saidaMux4_1 = entradaA;

    else if(controle == 2'b01)
     saidaMux4_1 = entradaB;

    else if(controle == 2'b10)
      saidaMux4_1 = entradaC;

    else
	   saidaMux4_1 = entradaD;

  end

endmodule