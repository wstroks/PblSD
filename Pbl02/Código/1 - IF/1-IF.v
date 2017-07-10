module IF(
		input [31:0] entradaPC,entradaMux,ALu,data1,data2,
		input PCescreve, clock, controle,c1,c2,ler,escreve,
		output wire [31:0] Pcsaida, MuxSaida,MuxSaida2,MuxSaida3,saidaAdder,agora,saidaMemoria

);
/*
	Logica de receber o pc e o  adder PC +4
*/
PC PcPrograma(
	.entrada(entradaPC),
    .PCescreve(PCescreve), 
	.clock(clock),
    .Pcsaida(Pcsaida)


);

PCAdder adicionar(
   .A(Pcsaida),
   .saidaAdder(saidaAdder)
);
/*
 Esse mux separa o que é dados ... no caso saida da ALU -Ex
 Do que é instrução 
*/
Mux2_1 DadosEndereco(
  .entradaA(ALu),
  .entradaB(saidaAdder),
  .controle(c1),
  .saida(MuxSaida2));
  
/*
	recebe o write data, tanto do registrador ou do MEM/WB
*/  
  
  Mux2_1 data(
  .entradaA(data1),
  .entradaB(data2),
  .controle(c2),
  .saida(MuxSaida3));


/*
memoria feita
*/
  
memoriaBloco memor
(
	
	.memEndereco(MuxSaida3),
	.memValor(MuxSaida2),
	.escreverMemoria(escreve),
	.lerMemoria(ler),
	.saida(saidaMemoria)
);
  /*
	esse mux é um seletor para o proximo adder continuar o +4 ou fazer um salto .. exemplo de 4 .. saltao vai 12
  */
Mux2_1 M(
  .entradaA(entradaMux),
  .entradaB(saidaAdder),
  .controle(controle),
  .saida(MuxSaida));

always @(*) begin
	
	
  end

endmodule
