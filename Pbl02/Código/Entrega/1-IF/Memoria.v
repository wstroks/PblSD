/*
 Alunos: Washington Pagotto Batista, Pedro kenndy e Ivan
 Universidade Estadual de Feira de Santana 2017.1
 TEC499 - MI - Sistemas Digitais

 Modulo: PcAdder.v
 Descri��o: Modulo criado para quinto estagio da pipeline 
 Entradas:
    memEndereco,memValor: 32-bit value
    controle: bit value
	
 Saida:
    saidaAdder: saida ser� um valor armazenado em na memoria, seja um escrita n�o gera uma saida
*/
module memoriaBloco
(
	
	input [31:0] memEndereco,
	input [31:0] memValor,
	input controle,
	output reg [31:0] saida
);
	wire [31:0] Bloco [31:0];
	
	integer i;
	initial
	begin
	    
	for(i=0; i<31;i=i+1)begin
		//Bloco[i]=i;
	end
	end

	
	
	
  always @(*) begin
		if (~controle)			
		//assign	Bloco[memEndereco] = memValor;
		
				
			saida = Bloco[memEndereco];
		
	end
 endmodule
