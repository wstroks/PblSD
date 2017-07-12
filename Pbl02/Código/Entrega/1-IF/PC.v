/*
 Alunos: Washington Pagotto Batista, Pedro kenndy e Ivan Rios
 Universidade Estadual de Feira de Santana 2017.1
 TEC499 - MI - Sistemas Digitais

 Modulo: PC.v
 Descrição: Modulo criado para quinto estagio da pipeline 
 Entradas:
    entrada: 32-bit value
    PCescreve,clock: 1 bit
 Saida:
    saida: saida = entrada
*/
module PC(
  input [31:0] entrada,
  input PCescreve, clock,
  output reg [31:0] Pcsaida
  );
 

  always @ (posedge clock) begin
    if(PCescreve) begin
		
      Pcsaida <= entrada;
    end
  end
  endmodule
