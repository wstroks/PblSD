`timescale  1ns/ 1ps
module testMux3_1();
  
        reg [31:0] entradaA_in;
        reg [31:0] entradaB_in;
        reg [31:0] entradaC_in;
        reg controle1_in,controle2_in;
        wire [31:0] saida_in;
  
Mux3_1 MUX(.entradaA(entradaA_in),.entradaB(entradaB_in),.entradaC(entradaC_in), .controle1(controle1_in), .controle2(controle2_in), .saida(saida_in));
initial begin

entradaA_in=8; entradaB_in=10; entradaC_in = 11; controle1_in=0; controle2_in=0; 

$display("entradaA_in = %d , entradaB_in = %d, entradaC_in = %d, controle1_in = %d, controle2_in = %d, saida_in = %d", entradaA_in, entradaB_in,entradaC_in, controle1_in, controle2_in,saida_in);
#10;


entradaA_in=8; entradaB_in=10; entradaC_in = 11; controle1_in=0; controle2_in=1; 

$display("entradaA_in = %d , entradaB_in = %d, entradaC_in = %d, controle1_in = %d, controle2_in = %d, saida_in = %d", entradaA_in, entradaB_in,entradaC_in, controle1_in, controle2_in,saida_in);
#10;



entradaA_in=40; entradaB_in=13; entradaC_in = 15; controle1_in=1; controle2_in=0; 

$display("entradaA_in = %d , entradaB_in = %d, entradaC_in = %d, controle1_in = %d, controle2_in = %d, saida_in = %d", entradaA_in, entradaB_in,entradaC_in, controle1_in, controle2_in,saida_in);
#10;

end  
  
 
endmodule