`timescale  1ns/ 1ps

module id_test();
/*
 Alunos: Washington Pagotto Batista, Pedro kenndy e Ivan Rios
 Universidade Estadual de Feira de Santana 2017.1
 TEC499 - MI - Sistemas Digitais

 Modulo: ID_Test.v
 
 Entradas:
    entradaPC,ALu,data1,data2: 32 bits
    PCescreve, clock, c1,c2,ler,escreve: 1 bit
	Controle: 1 bit
 Saida:
   DUToutPcsaida, DUToutSaidaDadosInstruc,DUToutwriteDataMemWB,DUToutsaidaAdder,DUToutsaidaMemoria: 32 bit
*/


parameter Halfcycle = 5; //half period is 5ns
    
localparam Cycle = 2*Halfcycle;
    
reg Clock;
    
    // Clock Signal generation:
initial Clock = 0; 
always #(Halfcycle) Clock = ~Clock;

reg [31:0] pc, inst, writeData, exOut; 
reg [1:0] forbranchA, forbranchB, PCsrc;
reg [4:0] writeRegister;
reg signExtendControl, regWrite;
wire [31:0] Rsdata, RTdata, PCOut, imm_valueOut, pcmultiplexed;
wire [4:0] addrRsOut, addrRtOut, addrRdOut;
wire cmp_eq;
reg [30:0] rand_31;

wire [31:0] REFoutPRsdata, REFoutPRTdata, REFoutPPCOut, REFoutPimm_valueOut, REFoutPpcmultiplexed;
wire [4:0] REFoutPaddrRsOut, REFoutPaddrRtOut, REFoutPaddrRdOut;
wire REFoutPcmp_eq;



ID DUT1(
  .pc(pc),
  .inst(inst),
  .writeData(writeData),
  .exOut(exOut),
  .forbranchA(forbranchA),
  .forbranchB(forbranchB),
  .PCsrc(PCsrc),
  .writeRegister(writeRegister),
  .signExtendControl(signExtendControl),
  .clk(Clock),
  .regWrite(regWrite),
  .Rsdata(Rsdata),
  .RTdata(RTdata),
  .PCOut(PCOut),
  .imm_valueOut(imm_valueOut),
  .pcmultiplexed(pcmultiplexed),
  .addrRsOut(addrRsOut),
  .addrRtOut(addrRtOut),
  .addrRdOut(addrRdOut),
  .cmp_eq(cmp_eq)
  );
  
  
  task checkOutput;
        input [31:0] pc, inst, writeData, exOut; 
		input [1:0] forbranchA, forbranchB, PCsrc;
		input [4:0] writeRegister;
		input signExtendControl, regWrite,Clock;
		
		
        if ( REFoutPcmp_eq!== cmp_eq|| REFoutPaddrRdOut!== addrRdOut ||REFoutPaddrRtOut!==addrRtOut ||REFoutPaddrRsOut!== addrRsOut ||Rsdata!==REFoutPRsdata || REFoutPRTdata!== RTdata || REFoutPPCOut!== PCOut || REFoutPimm_valueOut !==imm_valueOut || REFoutPpcmultiplexed!==pcmultiplexed) begin
			
            $display("Erro: \tpc: %D, inst: %D, writeData: %D, exOut: %D, forbranchA: %D,forbranchB: %D, PCsrc: %D, writeRegister: %D, signExtendControl: %D, regWrite: %D", pc, inst, writeData, exOut, forbranchA,forbranchB, PCsrc, writeRegister, signExtendControl, regWrite);
			$display("REFoutPRsdata: %D, Rsdata: %D, REFoutPRTdata: %D, RTdata: %D, REFoutPPCOut: %D,\nPCOut: %D, REFoutPimm_valueOut: %D, imm_valueOut: %D, REFoutPpcmultiplexed: %D,pcmultiplexed: %D",REFoutPRsdata, Rsdata, REFoutPRTdata, RTdata, REFoutPPCOut,PCOut, REFoutPimm_valueOut, imm_valueOut, REFoutPpcmultiplexed,pcmultiplexed);
			$display("REFoutPaddrRsOut: %D, addrRsOut: %D, REFoutPaddrRtOut: %D, addrRtOut:%D, REFoutPaddrRdOut: %D, addrRdOut: %D, REFoutPcmp_eq: %D, cmp_eq: %D ",REFoutPaddrRsOut, addrRsOut, REFoutPaddrRtOut, addrRtOut, REFoutPaddrRdOut, addrRdOut, REFoutPcmp_eq, cmp_eq );
			$finish();
        end
        else begin
			$display("Passou: \tpc: %D, inst: %D, writeData: %D, exOut: %D, forbranchA: %D,forbranchB: %D, PCsrc: %D, writeRegister: %D, signExtendControl: %D, regWrite: %D", pc, inst, writeData, exOut, forbranchA,forbranchB, PCsrc, writeRegister, signExtendControl, regWrite);
			$display("REFoutPRsdata: %D, Rsdata: %D, REFoutPRTdata: %D, RTdata: %D, REFoutPPCOut: %D,\nPCOut: %D, REFoutPimm_valueOut: %D, imm_valueOut: %D, REFoutPpcmultiplexed: %D,pcmultiplexed: %D",REFoutPRsdata, Rsdata, REFoutPRTdata, RTdata, REFoutPPCOut,PCOut, REFoutPimm_valueOut, imm_valueOut, REFoutPpcmultiplexed,pcmultiplexed);
			$display("REFoutPaddrRsOut: %D, addrRsOut: %D, REFoutPaddrRtOut: %D, addrRtOut:%D, REFoutPaddrRdOut: %D, addrRdOut: %D, REFoutPcmp_eq: %D, cmp_eq: %D ",REFoutPaddrRsOut, addrRsOut, REFoutPaddrRtOut, addrRtOut, REFoutPaddrRdOut, addrRdOut, REFoutPcmp_eq, cmp_eq );
	  end
    endtask
	
	
	
	 localparam testcases = 14; //aumentar584

   

    integer i; // integer used for looping in non-generate statement

    initial 
    begin
	
	  
      for(i = 0; i < testcases; i = i + 1)
      begin
	  
                     
            rand_31 = {$random} & 31'h7FFFFFFF;
			pc={1'b1, rand_31}; 
                
	       controle=0;
            REFoutA=entradaA; 
           #1;
		   
		   input [31:0] pc, inst, writeData, exOut; 
		input [1:0] forbranchA, forbranchB, PCsrc;
		input [4:0] writeRegister;
		input signExtendControl, regWrite,Clock;
           checkOutput(pc,inst,writeData,exOut,forbranchA,forbranchB, PCsrc,writeRegister,signExtendControl,regWrite,Clock);
      end
       //$display("NO TESTS WRITTEN - FILL THIS OUT\n"); //delete this after you write your test cases
       
       $display("\n\nALL TESTS PASSED!");
       $finish();
    end
  
 endmodule