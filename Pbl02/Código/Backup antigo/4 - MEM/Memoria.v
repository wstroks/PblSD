module memoriaBloco
(
	
	input [31:0] memEndereco,
	input [31:0] memValor,
	input escreverMemoria,
	input lerMemoria,
	output reg [31:0] saida
);
	reg [31:0] Bloco [31:0];

	
	
	
  always @(*) begin
		if (escreverMemoria) 
			
			Bloco[memEndereco] = memValor;
		
		else if (lerMemoria) 
			
			saida = Bloco[memEndereco];
		
	end
 endmodule
