module WB(
	input [31:0] memoriaSaida,aluSaida,
	input  controle,
	output wire[31:0] writeDataSaida // usa wire pq ele ja seta saida ... verificar mux <= ou =
);

Mux2_1 dataMux(
  .entradaA(memoriaSaida),
  .entradaB(aluSaida),
  .controle(controle),
  .saida(writeDataSaida));

endmodule
