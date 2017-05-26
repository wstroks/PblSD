`timescale  1ns/ 1ps
module wb_test();

  reg [31:0] memoriaSaida,aluSaida;
	reg  controle;
	wire [31:0] writeDataSaida;

Mux2_1 x(
  .entradaA(memoriaSaida),
  .entradaB(aluSaida),
  .controle(controle),
  .saida(writeDataSaida));
  
initial begin
memoriaSaida= 10;   aluSaida=20; controle= 0;  
$display(" memoriaSaida = %d,  aluSaida = %d, controle = %d, writeDataSaida = %d",memoriaSaida ,  aluSaida , controle , writeDataSaida);
#10;


memoriaSaida= 10;   aluSaida=20; controle= 1;  
$display(" memoriaSaida = %d,  aluSaida = %d, controle = %d, writeDataSaida = %d",memoriaSaida ,  aluSaida , controle , writeDataSaida);
#10;   
end
  
endmodule
