module memoria_test();
  

	reg [31:0] memEndereco_in;
	reg [31:0] memValor_in;
	reg escreverMemoria_in;
	reg lerMemoria_in;
	wire [31:0] saida_in;
	
	memoriaBloco uut(.memEndereco(memEndereco_in), .memValor(memValor_in), .escreverMemoria(escreverMemoria_in),.lerMemoria(lerMemoria_in),.saida(saida_in));
	

initial begin
memEndereco_in=1; memValor_in=100; escreverMemoria_in=1; lerMemoria_in=0;

$display("memEndereco_in= %d, memValor_in = %d , escreverMemoria_in = %d, lerMemoria_in = %d, saida_in = %d",memEndereco_in, memValor_in  , escreverMemoria_in , lerMemoria_in , saida_in);
#1;


memEndereco_in=1; memValor_in=100; escreverMemoria_in=0; lerMemoria_in=1;

$display("memEndereco_in= %d, memValor_in = %d , escreverMemoria_in = %d, lerMemoria_in = %d, saida_in = %d",memEndereco_in, memValor_in  , escreverMemoria_in , lerMemoria_in , saida_in);
#1;

end 

endmodule
