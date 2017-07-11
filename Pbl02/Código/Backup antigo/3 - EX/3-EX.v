module EX(
    input [31:0] EntradaA, EntradaB,Memoria,registrado, emediato,
    input controle1P,controle2P,controle1S,controle2S,controleDoMUx2,
    input [5:0] funct, opcode,
    output reg [4:0] ALUop,
    output reg [31:0] MuxP, MuxS, Mux2Saida,final
);
  

Mux3_1 primeira(
  .entradaA(EntradaA), 
  .entradaB(Memoria), 
  .entradaC(registrado),
  .controle1(controle1P),
  .controle2(controle2P),
  .saida(MuxP)
);  
  
Mux3_1 segunda(
  .entradaA(EntradaB), 
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
  .funct(funct), 
  .opcode(opcode),
  .ALUop(ALUop)
); 

ALU aluVai(
    .A(MuxP),
    .B(Mux2Saida),
    .ALUop(ALUop),
    .Out(final)
);

endmodule
