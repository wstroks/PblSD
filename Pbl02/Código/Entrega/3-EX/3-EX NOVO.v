module EX(
    input [31:0] RSd, RTd, exOut, wbOut, emediato,
    input [1:0] rsMux, rtMux, 
    input [5:0] opcode,
    output reg [4:0] ALUop,
    output reg [31:0] MuxP, MuxS, Mux2Saida,f
);
  

Mux3_1 rsData(
  .entradaA(RSd), 
  .entradaB(Memoria), 
  .entradaC(registrado),
  .controle1(controle1P),
  .controle2(controle2P),
  .saida(MuxP)
);  
  
Mux3_1 rtData(
  .entradaA(RTd), 
  .entradaB(Memoria), 
  .entradaC(registrado),
  .controle1(controle1S),
  .controle2(controle2S),
  .saida(MuxS)
); 

Mux2_1 SegundaMUx2(
  .entradaA(MuxS),
  .entradaB(emediato),
  .controle(controleDoMUx2),
  .saida(Mux2Saida));
  
 Alu_decodica dec(
  .funct(emediato[5:0]), 
  .opcode(opcode),
  .ALUop(ALUop)
); 

ALU aluVai(
    .A(MuxP),
    .B(Mux2Saida),
    .ALUop(ALUop),
    .Out(f)
);

endmodule
