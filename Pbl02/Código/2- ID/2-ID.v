module ID(
  input clk,	//clock
	input [4:0] registrador1,
	input [4:0] registrador2,
	input [4:0] destinoDoescreverData,
	input [31:0] wdataValor,
	input VaiEscrever,
	output reg [31:0] saida1,
	output reg [31:0] saida2
);
  
  
  
  
registerBank armazena(
	.clk(clk),	
	.registrador1(registrador1),
	.registrador2(registrador2),
	.destinoDoescreverData(destinoDoescreverData),
	.wdataValor(wdataValor),
	 .VaiEscrever(VaiEscrever),
	.saida1(saida1),
	.saida2(saida2)
);
  
endmodule
