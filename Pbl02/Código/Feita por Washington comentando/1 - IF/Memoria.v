/*
 Alunos: Washington Pagotto Batista, Pedro kenndy e Ivan Rios
 Universidade Estadual de Feira de Santana 2017.1
 TEC499 - MI - Sistemas Digitais

 Modulo: MEmoria.v
 Descrição: Modulo criado para quinto estagio da pipeline 
 Entradas:
    memEndereco: 32-bit value
    memValor: 32-bit value
	lerMemoria,escreverMemoria: 1 bit
 Saida:
   saida: Só é gerar uma saida quando é feito a leitura 
*/

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
