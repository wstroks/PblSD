`timescale  1ns/ 1ps
module mem_test();
  
  reg [31:0] memEndereco;
	reg [31:0] memValor;
	reg escreverMemoria;
	reg lerMemoria;
	wire [31:0] saida;
  
MEM ll(	
	.memEndereco(memEndereco),
	.memValor(memValor),
	.escreverMemoria(escreverMemoria),
	.lerMemoria(lerMemoria),
	.saida(saida)
);

  
initial begin 

memEndereco=1; memValor=100; escreverMemoria=1; lerMemoria=0;

$display("memEndereco= %d, memValor = %d , escreverMemoria = %d, lerMemoria = %d, saida = %d",memEndereco, memValor , escreverMemoria , lerMemoria , saida);
#10;


memEndereco=1; memValor=30; escreverMemoria=0; lerMemoria=1;

$display("memEndereco= %d, memValor = %d , escreverMemoria = %d, lerMemoria = %d, saida = %d",memEndereco, memValor , escreverMemoria , lerMemoria , saida);
#10;

  
  
end


endmodule
