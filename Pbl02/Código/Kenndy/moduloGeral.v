module moduloGeral(
	input Clock,
  output reg [5:0] registradorSaida,
  output reg [31:0] dadoSaida
);

wire [31:0] saidaMem, saidaPcIF,saidaPc, saidaALU, RS, RT, imEX, aluMEM, entradaPCmult, entradaPcID, entradaInstID, RTdataEXMEM;
wire [31:0] entradaIDEXrs, entradaIDEXrt, entradaIDEX, entradaIDEXpc, entradaIDEXimm, PCidex, RTdataIF;
wire [31:0] memoriaWB, aluWB, saidaWB;
wire OpcodeJump, OpcodeDiv, controleIFID, controlerAddrMem, saidaFwdC, escreveReg, extensorID, cmpControle;
wire [1:0] saidaFwdA, saidaFwdB, seletorPC, saidaWBidex, saidaWBexmem, saidaWBcontrole;
wire [4:0] saidaIDEXrt, saidaIDEXrs, saidaIDEXrd, rsIDEX, rdIDEX, rtIDEX, regDestEXMEM, regDestToMem, regDestMem;
wire saidaEXcontrole, saida2EXcontrole, memToRegEX, escreverMemEx, lerMemEx, branchControle, pcHazard, ifIDhazard, hazardMux;
wire branchA, branchB,controleAddrMem;
wire [5:0] opcodeEX;
wire [2:0] saidaMidex, saidaMexmem;
wire [13:0] muxC;
wire [7:0] entradaEXcon;
	
IF moduloIF(

	.entradaPC(entradaPCmult),
	.ALu(aluMEM),
	.data1(RTdataIF),
	.data2(saidaWB),
	.PCescreve(pcHazard),
	.clock(Clock),
	.c1(controleAddrMem),
	.c2(saidaFwdC),
	.controleMemoria(saidaMexmem[2]),
	.saidaMemoria(saidaMem),
	.saidaAdder(saidaPc)

);

IFID ifID(

	.Clock(Clock),
	.pc(saidaPc),
	.instrucao(saidaMem),
	.sinalHazard(ifIDhazard),
	.sinalControle(controleIFID),
	.saidaPC(entradaPcID), 
	.saidaInstrucao(entradaInstID)

);

ID moduloID(

	.VaiEscrever(escreveReg),
  	.pc(entradaPcID), 
  	.inst(entradaInstID), 
  	.writeData(saidaWB), 
  	.exOut(saidaALU), 
  	.forbranchA(branchA), 
  	.forbranchB(branchB), 
  	.PCsrc(seletorPC),
  	.writeRegister(regDestMem),
  	.signExtendControl(extensorID), 
  	.clk(Clock), 
  	.Rsdata(entradaIDEXrs), 
  	.RTdata(entradaIDEXrt), 
  	.PCOut(entradaIDEXpc), 
  	.imm_valueOut(entradaIDEXimm), 
  	.pcmultiplexed(entradaPCmult),
  	.addrRsOut(rsIDEX), 
  	.addrRtOut(rtIDEX), 
  	.addrRdOut(rdIDEX), 
  	.cmp_eq(cmpControle)	

);

IDEX idEX(

	.clock(Clock),
  	.WB(muxC[1:0]),
  	.M(muxC[4:2]),
  	.EX(muxC[13:5]),
  	.regRS(entradaIDEXrs), 
  	.regRt(entradaIDEXrt), 
  	.imm_value(entradaIDEXimm), 
  	.PC(entradaIDEXpc),
  	.addrRs(rsIDEX), 
  	.addrRt(rtIDEX), 
  	.addrRd(rdIDEX),
  	.MOut(saidaMidex),
  	.EXOut(entradaEXcon),
  	.regRsOut(RS), 
  	.regRtOut(RT), 
  	.PCOut(PCidex), 
  	.imm_valueOut(imEX),
  	.addrRsOut(saidaIDEXrs), 
  	.addrRtOut(saidaIDEXrt), 
  	.addrRdOut(saidaIDEXrd),
  	.WBOut(saidaWBidex)

);

EX moduloEX(

	.RSd(RS), 
	.RTd(RT),
	.Memoria(saidaWB),
	.registrado(aluMEM), 
	.emediato(imEX),
    .controle1P(saidaFwdA[0]),
    .controle2P(saidaFwdA[1]),
    .controle1S(saidaFwdB[0]),
    .controle2S(saidaFwdB[1]),
    .controleDoMUx2(entradaEXcon[1]), 
    .opcode(entradaEXcon[7:2]),
    .destinoReg(regDestEXMEM),
    .regDest(entradaEXcon[0]),
    .MuxS(RTdataEXMEM), 
    .rt(saidaIDEXrt),
    .rd(saidaIDEXrd),
    

);

EXMEM exMEM(

	.Clock(Clock),
  	.WB(saidaWBidex),
  	.M(saidaMidex),
  	.RD(regDestEXMEM),
  	.entradaData(RTdataEXMEM), 
  	.saidaALU(saidaALU),
  	.registradorM(saidaMexmem),
  	.registradorWB(saidaWBexmem),
  	.saidaData(RTdataIF), 
  	.registradorALU(aluMEM),
  	.registradorRD(regDestToMem)

);

MEMWB memWB(

	.Clock(Clock),
	.saidaALU(saidaALU), 
	.dataMEM(saidaMem),
	.registradorDestinoData(regDestToMem),
	.WB(saidaWBexmem),
	.saidaALUwb(aluWB), 
	.saidaMEM(memoriaWB),
	.saidaDestinoData(regDestMem),
	.regWB(saidaWBcontrole)

);

WB moduloWB(

	.memoriaSaida(memoriaWB),
	.aluSaida(aluWB),
	.controle(saidaWBcontrole[0]),
	.writeDataSaida(saidaWB)

);



Control unidadeControle(

	.cmp_eq(cmpControle), 
  	.opcode(saidaMem[31:26]),
  	.PCsrc(seletorPC),
  	.IorD(controleAddrMem),
  	.IFflush(controleIFID), 
  	.signExt(extensorID),
  	.regWrite(escreveReg), 
  	.memToReg(memToRegEX),
  	.memRead(lerMemEx),
  	.memWrite(escreverMemEx),
  	.ALUsrc(saidaEXcontrole), 
  	.regDst(saida2EXcontrole),
  	.opcodeOut(opcodeEX),
  	.branch(branchControle)

);

Fowarding unidadeFowarding(

	.IDEX_rt(saidaIDEXrt), 
	.IDEX_rs(saidaIDEXrs), 
	.EXMEM_rd(regDestToMem), 
	.MEMWB_rd(regDestMem),
  	.EXMEM_regWrite(saidaWBexmem[1]), 
  	.MEMWB_regWrite(saidaWBcontrole[1]),
  	.MEMWB_MemtoReg(saidaWBcontrole[0]), 
  	.EXMEM_MemWrite(saidaMexmem[2]),
  	.fwdSignalA(saidaFwdA), 
  	.fwdSignalB(saidaFwdB),
  	.fwdSignalC(saidaFwdC)

);

Harzard unidadeHazard(

	.IFID_rs(rsIDEX), 
	.IFID_rt(rtIDEX), 
	.IDEX_rt(saidaIDEXrt),
    .IDEX_memRead(saidaMidex[1]), 
    .EXMEM_iord(saidaMexmem[0]), 
    .branchFWD(branchControle),
    .PCWrite(pcHazard), 
    .IFIDWrite(ifIDhazard),
    .HazMuxControle(hazardMux)
);

Branch_Detection xxx(

  .IFID_rs(rsIDEX),
  .IFID_rt(rtIDEX),
  .EXMEM_rd(regDestToMem), 
  .MEMWB_rd(regDestMem),
  .EXMEM_regWrite(saidaWBexmem[1]), 
  .MEMWB_regWrite(saidaWBcontrole[1]),
  .branchFWDA(branchA), 
  .branchFWDB(branchB)

);

Mux2_1 muxControle(

  .entradaA({opcodeEX, saidaEXcontrole, saida2EXcontrole, escreverMemEx, lerMemEx, controleAddrMem, escreveReg, memToRegEX}),
  .entradaB(13'b0),
  .controle(hazardMux),
  .saida(muxC)

);

always@(*) begin

  registradorSaida <= regDestMem;
  dadoSaida <= saidaWB;

end

endmodule