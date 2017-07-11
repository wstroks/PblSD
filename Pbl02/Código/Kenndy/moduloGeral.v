module moduloGeral(
	input Clock
);

wire [31:0] saidaMem, saidaPc, saidaALU, RS, RT, imEX, aluMEM
wire OpcodeJump, OpcodeDiv, controleIFID, controlerAddrMem, saidaFwdC
wire [1:0] saidaFwdA, saidaFwdB
wire [4:0] saidaIDEXrt, saidaIDEXrs
	
1-IF moduloIF(

	.entradaPC(),
	.ALu(aluMEM),
	.data1(),
	.data2(),
	.PCescreve(),
	.clock(Clock),
	.c1(controleAddrMem),
	.c2(saidaFwdC),
	.ler(),
	.escreve(),
	.saidaMemoria(saidaMem),
	.saidaAdder(saidaPc)

);

IFID ifID(

	.Clock(Clock),
	.pc(saidaPc),
	.instrucao(saidaMem),
	.sinalHazard(),
	.sinalControle(controleIFID),
	.saidaPC(), 
	.saidaInstrucao()

);

2-ID moduloID(

	

);

IDEX idEX(

	.clock(Clock),
  	.WB(),
  	.M(),
  	.EX(),
  	.regRS(), 
  	.regRt(), 
  	.imm_value(), 
  	.PC(),
  	.addrRs(), 
  	.addrRt(), 
  	.addrRd(),
  	.MOut(),
  	.EXOut(),
  	.regRsOut(RS), 
  	.regRtOut(RT), 
  	.PCOut(), 
  	.imm_valueOut(imEX),
  	.addrRsOut(saidaIDEXrs), 
  	.addrRtOut(saidaIDEXrt), 
  	.addrRdOut(),
  	.WBOut()

);

3-EX moduloEX(

	.RSd(RS), 
	.RTd(RT),
	.Memoria(),
	.registrado(aluMEM), 
	.emediato(imEX),
    .controle1P(saidaFwdA[0]),
    .controle2P(saidaFwdA[1]),
    .controle1S(saidaFwdB[0]),
    .controle2S(saidaFwdB[1]),
    .controleDoMUx2(), 
    .opcode(),
    .ALUop(),
    .MuxP(),
    .MuxS(), 
    .Mux2Saida(),
    .final(saidaALU)

);

Control unidadeControle(

	.cmp_eq(), 
  	.opcode(saidaMem[31:26]),
  	.PCsrc(),
  	.IorD(controleAddrMem),
  	.IFflush(controleIFID), 
  	.signExt(),
  	.regWrite(), 
  	.memToReg(),
  	.memRead(),
  	.memWrite(),
  	.ALUsrc(), 
  	.regDst()

);

Fowarding unidadeFowarding(

	.IDEX_rt(saidaIDEXrt), 
	.IDEX_rs(saidaIDEXrs), 
	.EXMEM_rd(), 
	.MEMWB_rd(),
  	.EXMEM_regWrite(), 
  	.MEMWB_regWrite(),
  	.MEMWB_MemtoReg(), 
  	.EXMEM_MemWrite(),
  	.fwdSignalA(saidaFwdA), 
  	.fwdSignalB(saidaFwdB),
  	.fwdSignalC(saidaFwdC)

);

EXMEM exMEM(

	.Clock(Clock),
  	.WB(),
  	.M(),
  	.RD(),
  	.entradaData(), 
  	.saidaALU(saidaALU),
  	.registradorM(),
  	.registradorWB(),
  	.saidaData(), 
  	.registradorALU(aluMEM),
  	.registradorRD()

);

endmodule