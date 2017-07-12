/*
 Alunos: Washington Pagotto Batista, Pedro kenndy e Ivan Rios
 Universidade Estadual de Feira de Santana 2017.1
 TEC499 - MI - Sistemas Digitais

 Modulo: 5-WB.v
 
 Entradas:
    memoriaSaida, AluSaida: 32 bits
    Controle: 1 bit
 Saida:
   writeDatasaida: 32 bit
*/
module WB(
	input [31:0] memoriaSaida,aluSaida,
	input  controle,
	output wire[31:0] writeDataSaida 
);

Mux2_1 dataMux(
  .entradaA(memoriaSaida),
  .entradaB(aluSaida),
  .controle(controle),
  .saida(writeDataSaida));




endmodule
