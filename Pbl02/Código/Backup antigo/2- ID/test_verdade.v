`timescale  1ns/ 1ps
module test_verdade_banco();
  

	reg clk;	//clock
	reg [4:0] registrador1;
	reg [4:0] registrador2;
	reg [4:0] destinoDoescreverData;
	reg [31:0] wdataValor;
	reg VaiEscrever;
	wire [31:0] saida1;
	wire [31:0] saida2;


registerBank m(
	.clk(clk),	
	.registrador1(registrador1),
	.registrador2(registrador2),
	.destinoDoescreverData(destinoDoescreverData),
	.wdataValor(wdataValor),
	 .VaiEscrever(VaiEscrever),
	.saida1(saida1),
	.saida2(saida2)
);

initial begin
clk=1; registrador1=5'b00001; registrador2=5'b00010; destinoDoescreverData=5'b00010; wdataValor=100; VaiEscrever=1;

$display("clk= %d, registrador1= %d, registrador2= %d, destinoDoescreverData= %d, wdataValor=%d, VaiEscrever=%d, saida1= %d, saida2=%d",clk, registrador1, registrador2, destinoDoescreverData, wdataValor, VaiEscrever, saida1, saida2);
#10;

clk=1; registrador1=5'b00001; registrador2=5'b00010; destinoDoescreverData=5'b00010; wdataValor=50; VaiEscrever=1;

$display("clk= %d, registrador1= %d, registrador2= %d, destinoDoescreverData= %d, wdataValor=%d, VaiEscrever=%d, saida1= %d, saida2=%d",clk, registrador1, registrador2, destinoDoescreverData, wdataValor, VaiEscrever, saida1, saida2);
#10;

clk=1; registrador1=5'b00001; registrador2=5'b00010; destinoDoescreverData=5'b00001; wdataValor=30; VaiEscrever=1;

$display("clk= %d, registrador1= %d, registrador2= %d, destinoDoescreverData= %d, wdataValor=%d, VaiEscrever=%d, saida1= %d, saida2=%d",clk, registrador1, registrador2, destinoDoescreverData, wdataValor, VaiEscrever, saida1, saida2);
#10;

clk=0; registrador1=5'b00001; registrador2=5'b00010; destinoDoescreverData=5'b00001; wdataValor=30; VaiEscrever=0;

$display("clk= %d, registrador1= %d, registrador2= %d, destinoDoescreverData= %d, wdataValor=%d, VaiEscrever=%d, saida1= %d, saida2=%d",clk, registrador1, registrador2, destinoDoescreverData, wdataValor, VaiEscrever, saida1, saida2);
#10;
end 
  
endmodule
