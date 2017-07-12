/*
 Alunos: Washington Pagotto Batista, Pedro kenndy e Ivan Rios
 Universidade Estadual de Feira de Santana 2017.1
 TEC499 - MI - Sistemas Digitais

 Modulo: 1-IF.v
 
 Entradas:
    entradaPC,ALu,data1,data2: 32 bits
    PCescreve, clock, c1,c2,controle: 1 bit
	  Controle: 1 bit
 Saida:
   saidaMemoria, SaidaAdder: 32 bit
*/


module IF(
		input [31:0] entradaPC,ALu,data1,data2,
		input PCescreve, clock, c1,c2,controle,
		output [31:0] saidaMemoria,
		output [31:0] saidaAdder
		 
);

wire um = 32'b100;
wire [31:0] Pcsaida, SaidaDadosInstruc,writeDataMemWB;

/*
	Logica do PC
*/
PC PcPrograma(
	.entrada(entradaPC),
  .PCescreve(PCescreve), 
	.clock(clock),
  .Pcsaida(Pcsaida)


);
/*
	Esse é o PCadder, ele recebe o endereço de PC e soma com +4,ou seja, PC+4
*/
PCAdder adicionar(
   .A(Pcsaida),
   .B(32'h00000004),
   .saidaAdder(saidaAdder)
);
/*
 Na entrada da memoria (ADDR) é necessário um mux de 2-1, para definir se o que tá entradando é dados ou instrução, com isso é feito um mux para identificação do msm
*/
Mux2_1 DadosEndereco(
  .entradaA(ALu),
  .entradaB(Pcsaida),
  .controle(c1),
  .saida(SaidaDadosInstruc));
  
/*
	recebe o write data, tanto do registrador ou do MEM/WB
*/  
  
  Mux2_1 data(
  .entradaA(data1),
  .entradaB(data2),
  .controle(c2),
  .saida(writeDataMemWB));


/*
 o bit de controle � para informar se est� lendo ou escrevendo, caso seja 0 � pra escrita e 1 leitura
*/
  
memoriaBloco memor
(
	.memEndereco(writeDataMemWB),
	.memValor(SaidaDadosInstruc),
	.controle(controle),
	.saida(saidaMemoria)
);
  

always @(*) begin
	
	
  end

endmodule
