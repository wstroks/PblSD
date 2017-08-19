module EX(

    input [31:0] RSd, RTd,Memoria,registrado, emediato,
    input controle1P,controle2P,controle1S,controle2S,controleDoMUx2, regDest,
    input [5:0] opcode,
    input [4:0] rt, rd,
    output reg [4:0] destinoReg,
    output wire [31:0] MuxS, registradorDest
);
  
wire [4:0] ALUop;
wire [31:0] MuxP, Mux2Saida,ffinal;

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

Mux2_1 registradorDestino(
  .entradaA(rt),
  .entradaB(rd),
  .controle(regDest),
  .saida(registradorDest)); 
  
Alu_decodica dec(
  .funct(emediato[5:0]), 
  .opcode(opcode),
  .ALUop(ALUop)
); 

ALU aluVai(
    .A(MuxP),
    .B(Mux2Saida),
    .ALUop(ALUop),
    .Out(ffinal)
);

endmodule
