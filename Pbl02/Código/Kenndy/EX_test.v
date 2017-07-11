`timescale  1ns/ 1ps
module ex_test();
    reg [31:0] EntradaA, EntradaB,Memoria,registrado, emediato;
    reg controle1P,controle2P,controle1S,controle2S,controleDoMUx2;
    reg [5:0] funct, opcode;
   wire [4:0] ALUop;
   wire[31:0] MuxP, MuxS, Mux2Saida,final;

  

Mux3_1 a(
  .entradaA(EntradaA), 
  .entradaB(Memoria), 
  .entradaC(registrado),
  .controle1(controle1P),
  .controle2(controle2P),
  .saida(MuxP)
);  
  
Mux3_1 b(
  .entradaA(EntradaB), 
  .entradaB(Memoria), 
  .entradaC(registrado),
  .controle1(controle1S),
  .controle2(controle2S),
  .saida(MuxS)
); 

Mux2_1 y(
  .entradaA(MuxS),
  .entradaB(emediato),
  .controle(controleDoMUx2),
  .saida(Mux2Saida));

 Alu_decodica t(
  .funct(funct), 
  .opcode(opcode),
  .ALUop(ALUop)
); 

ALU q(
    .A(MuxP),
    .B(Mux2Saida),
    .ALUop(ALUop),
    .Out(final)
); 
  
initial begin


EntradaA=10; EntradaB=12; Memoria=5; registrado=15; controle1P=0; controle2P=0; controle1S=0; controle2S=0;


$display("EntradaA=%d, EntradaB=%d, Memoria=%d, registrado=%d, controle1P=%d, controle2P=%d, controle1S=%d, controle2S=%d,MuxP=%d, MuxS=%d",EntradaA, EntradaB, Memoria, registrado, controle1P, controle2P, controle1S, controle2S,MuxP, MuxS);
#10;

EntradaA=10; EntradaB=12; Memoria=5; registrado=15; controle1P=1; controle2P=0; controle1S=0; controle2S=0;
$display("EntradaA=%d, EntradaB=%d, Memoria=%d, registrado=%d, controle1P=%d, controle2P=%d, controle1S=%d, controle2S=%d,MuxP=%d, MuxS=%d",EntradaA, EntradaB, Memoria, registrado, controle1P, controle2P, controle1S, controle2S,MuxP, MuxS);
#10;


EntradaA=10; EntradaB=12; Memoria=5; registrado=15; controle1P=1; controle2P=0; controle1S=0; controle2S=0; emediato=16; controleDoMUx2=0;
$display("EntradaA=%d, EntradaB=%d, Memoria=%d, registrado=%d, controle1P=%d, controle2P=%d, controle1S=%d, controle2S=%d,MuxP=%d, MuxS=%d,emediato= %d,controleDoMUx2=%d,Mux2Saida =%d",EntradaA, EntradaB, Memoria, registrado, controle1P, controle2P, controle1S, controle2S,MuxP, MuxS,emediato,controleDoMUx2,Mux2Saida );
#10;


EntradaA=10; EntradaB=12; Memoria=5; registrado=15; controle1P=1; controle2P=0; controle1S=0; controle2S=0; emediato=16; controleDoMUx2=0; funct=6'b100000; opcode=6'b000000; 
$display("EntradaA=%d, EntradaB=%d, Memoria=%d, registrado=%d, controle1P=%d, controle2P=%d, controle1S=%d, controle2S=%d,MuxP=%d, MuxS=%d,emediato= %d,controleDoMUx2=%d,Mux2Saida =%d,funct = %d, opcode = %d,ALUop = %d,final= %d",EntradaA, EntradaB, Memoria, registrado, controle1P, controle2P, controle1S, controle2S,MuxP, MuxS,emediato,controleDoMUx2,Mux2Saida,funct , opcode ,ALUop ,final);
#10;
end  
  
  
endmodule
