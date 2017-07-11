/*
 Alunos: Washington Pagotto Batista, Pedro kenndy e Ivan Rios
 Universidade Estadual de Feira de Santana 2017.1
 TEC499 - MI - Sistemas Digitais

 Modulo: PcAdder.v
 Descrição: Modulo criado para quinto estagio da pipeline 
 Entradas:
    A: 32-bit value
    B: 32-bit value
	
 Saida:
    saidaAdder: A+B  visto que b sempre será 4
*/


module PCAdder(
  input [31:0] A,
  input [31:0] B,
  output  [31:0] saidaAdder
);
   
    
assign  saidaAdder =(A + B);
  

endmodule
