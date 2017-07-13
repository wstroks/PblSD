/*
 Alunos: Washington Pagotto Batista, Pedro kenndy e Ivan Rios
 Universidade Estadual de Feira de Santana 2017.1
 TEC499 - MI - Sistemas Digitais

 Modulo: PcAdder.v
 Descrição: Modulo criado para quinto estagio da pipeline 
 Entradas:
    memEndereco,memValor: 32-bit value
    controle: bit value
	
 Saida:
    saidaAdder: saida será um valor armazenado em na memoria, seja um escrita não gera uma saida
*/
module memoriaBloco
(
	
	input [31:0] memEndereco,
	input [31:0] memValor,
	input controle,
	output reg [31:0] saida
);
	reg [31:0] Bloco [1500:0];
	 localparam  testcases = 500;
	integer i;
	reg [31:0] testvector [0:1500-1];
	
	initial
	begin
	     $readmemb("../x/testvectors.input" , testvector);
	for(i=0; i<testcases;i=i+4)begin
		Bloco[i]=testvector[i][31:0];
	end
	end

	
	
	
  always @(*) begin
		if (~controle)			
			Bloco[memEndereco] = memValor;
		
		else 			
			saida = Bloco[memEndereco];
		
	end
 endmodule
