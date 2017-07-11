module ID(
  
	
  input VaiEscrever,
  input [31:0] pc, inst, writeData, exOut, 
  input [1:0] forbranchA, forbranchB, PCsrc,
  input [4:0] writeRegister,
  input signExtendControl, clk, regWrite,
  output wire [31:0] Rsdata, RTdata, PCOut, imm_valueOut, pcmultiplexed,
  output wire [4:0] addrRsOut, addrRtOut, addrRdOut,
  output wire cmp_eq
);
  
  wire [31:0] rdata0out, rdata1out, extendedOut, jump, muxOut1, muxOut2, branch;
  wire [31:0] zero = 32'b0; // flush

  assign addrRsOut = inst[25:21];
  assign addrRtOut = inst[20:16];
  assign addrRdOut = inst[15:11];
  assign imm_valueOut = extendedOut;
  assign PCOut = pc;
  assign RSdata = muxOut1;
  assign RTdata = muxOut2;

  
  
registerBank armazena(
	.clk(clk),	
	.registrador1(inst[25:21]),
	.registrador2(inst[20:16]),
	.destinoDoescreverData(writeRegister),
	.wdataValor(writeData),
	.VaiEscrever(VaiEscrever),
	.saida1(rdata0out),
	.saida2(rdata1out)
);
  
  
saidaAdder adderId(
  .A(pc), //pc + 4 da merda aqui
  .B(extendedOut),
  .saidaAdder(branch)
  );

SignExtend extende32(
  .imediato(inst[15:0]),
  .controle(signExtendControl),
  .saida(extendedOut)
  );

jump jumpExtend(
  .recebeExtend(inst[25:0]),
  .saida(jump)
  );

Mux4_1 forA(
  .A(rdata0out),
  .B(writeData),
  .C(exOut),
  .D(zero),
  .control(forbranchA),
  .Out(muxOut1)
  );

Mux4_1 forB(
  .A(rdata1out),
  .B(writeData),
  .C(exOut),
  .D(zero),
  .control(forbranchB),
  .Out(muxOut2)
  );

comparador_ID comparador (
  .A(muxOut1),
  .B(muxOut2),
  .saida(cmp_eq)
  );

Mux4_1 PCsource(
  .A(pc),
  .B(jump),
  .C(branch),
  .D(muxOut1),
  .control(PCsrc),
  .Out(pcmultiplexed)
  );
endmodule
