module memoriaBloco
(
	
	input [31:0] memEndereco,
	input [31:0] memValor,
	input escreverMemoria,
	input lerMemoria,
	output reg [31:0] saida
);
	reg [31:0] Bloco [1500:0];
	
	integer i;
	initial
	begin
	    
	for(i=0; i<1500;i=i+1)begin
		Bloco[i]=i;
	end
	end

	
	
	
  always @(*) begin
		if (escreverMemoria) 
			
			Bloco[memEndereco] = memValor;
		
		else if (lerMemoria) 
			
			saida = Bloco[memEndereco];
		
	end
 endmodule
