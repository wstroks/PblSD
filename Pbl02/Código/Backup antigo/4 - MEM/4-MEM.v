module MEM(
	input [31:0] memEndereco,
	input [31:0] memValor,
	input escreverMemoria,
	input lerMemoria,
	output wire[31:0] saida //asa

);

memoriaBloco bloco(	
	.memEndereco(memEndereco),
	.memValor(memValor),
	.escreverMemoria(escreverMemoria),
	.lerMemoria(lerMemoria),
	.saida(saida)
);




endmodule
