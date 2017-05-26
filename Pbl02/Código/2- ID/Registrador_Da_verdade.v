module registerBank
(
	input clk,	//clock
	input [4:0] registrador1,
	input [4:0] registrador2,
	input [4:0] destinoDoescreverData,
	input [31:0] wdataValor,
	input VaiEscrever,
	output reg [31:0] saida1,
	output reg [31:0] saida2

);
	reg [31:0] registrador_32 [31:0];
	



	integer i;

	initial
	begin
	    for(i = 0; i < 32; i = i+1)
		begin
	        registrador_32[i] = 32'd4;
		end
	end
	
 	always @(clk, destinoDoescreverData, wdataValor, VaiEscrever) begin
		if (VaiEscrever && clk) begin
			
			registrador_32[destinoDoescreverData] <= wdataValor;
		end
	end

	always @(clk, registrador1, registrador2, VaiEscrever) begin
		if(~clk) begin
			saida1<= registrador_32[registrador1];
  			saida2 <= registrador_32[registrador2];
		end
	end

 endmodule
