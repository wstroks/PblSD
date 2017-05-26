`timescale  1ns/ 1ps
module testBreanchMux();
  
        reg [31:0] entradaA_in;
        reg [31:0] entradaB_in;
        reg controle_in;
        wire [31:0] saida_in;
  
Mux2_1 uut(.entradaA(entradaA_in),.entradaB(entradaB_in), .controle(controle_in), .saida(saida_in));
initial begin

entradaA_in=8; entradaB_in=10;  controle_in=0; 

$display("entradaA_in = %d , entradaB_in = %d, controle_in = %d, saida_in = %d", entradaA_in, entradaB_in, controle_in,saida_in);
#10;

entradaA_in=30; entradaB_in=40;  controle_in=1; 

$display("entradaA_in = %d , entradaB_in = %d, controle_in = %d, saida_in = %d", entradaA_in, entradaB_in, controle_in,saida_in);
#10;

end  
  
 
endmodule
