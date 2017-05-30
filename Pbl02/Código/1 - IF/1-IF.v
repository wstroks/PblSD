module IF(
		input [31:0] entradaPC,entradaMux,
		input PCescreve, clock, controle,
		output wire [31:0] Pcsaida, MuxSaida,saidaAdder,agora

);




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


Mux2_1 M(
  .entradaA(entradaMux),
  .entradaB(saidaAdder),
  .controle(controle),
  .saida(MuxSaida));

always @(*) begin
	
	
  end

endmodule
