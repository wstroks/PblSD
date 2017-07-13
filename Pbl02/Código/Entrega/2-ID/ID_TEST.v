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
reg [3:0] rand_4;

reg [31:0] REFoutPRsdata, REFoutPRTdata, REFoutPPCOut, REFoutPimm_valueOut, REFoutPpcmultiplexed;
reg [4:0] REFoutPaddrRsOut, REFoutPaddrRtOut, REFoutPaddrRdOut;
reg REFoutPcmp_eq;



ID DUT1(
  .pc(pc), .inst(inst), .writeData(writeData), .exOut(exOut), 
  .forbranchA(forbranchA), .forbranchB(forbranchB), .PCsrc(PCsrc),
  .writeRegister(writeRegister),
  .signExtendControl(signExtendControl), .clk(clk), .regWrite(regWrite),
  .Rsdata(Rsdata), .RTdata(RTdata), .PCOut(PCOut), .imm_valueOut(imm_valueOut), .pcmultiplexed(pcmultiplexed),
  .addrRsOut(addrRsOut), .addrRtOut(addrRtOut), .addrRdOut(addrRdOut),
  .cmp_eq(cmp_eq)
  );
  
  
  task checkOutput;
    input [31:0] pc, inst, writeData, exOut; 
		input [1:0] forbranchA, forbranchB, PCsrc;
		input [4:0] writeRegister;
		input signExtendControl, regWrite,Clock;
		
		
if ( REFoutPcmp_eq!== cmp_eq|| REFoutPaddrRdOut!== addrRdOut ||REFoutPaddrRtOut!==addrRtOut ||REFoutPaddrRsOut!== addrRsOut ||Rsdata!==REFoutPRsdata || REFoutPRTdata!== RTdata || REFoutPPCOut!== PCOut  || REFoutPpcmultiplexed!==pcmultiplexed) begin
			
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
	
	
	
	 localparam testcases = 1; //aumentar584

   

    integer i; // integer used for looping in non-generate statement

    initial 
    begin
	      
	      /*
	      esse Primeiro teste verifica se a distribuição do inst está sendo feita
	      de maneira correta. As entradas são geradas randomicamente, apenas 
	      as os controles são fixos e o local de onde é salvo no registrador. Ocorreu um flush
	      e é enviado zero.
	      
	      */
	  
      for(i = 0; i < testcases; i = i + 1)
      begin
	  
                
            rand_31 = {$random} & 31'h7FFFFFFF;
			      pc={1'b1, rand_31};
			      rand_31 = {$random} & 31'h7FFFFFFF; 
			      inst={1'b1, rand_31};
			      rand_31 = {$random} & 31'h7FFFFFFF;
			      
            writeData= {1'b1, rand_31};
            rand_31 = {$random} & 31'h7FFFFFFF;
            exOut=  {1'b1, rand_31};
            rand_4 = 5'b10;
	          writeRegister={1'b1, rand_4};
            Clock=1;
            signExtendControl=1;
            regWrite=1;
            forbranchA=2'b11;
            forbranchB=2'b11;
            PCsrc=2'b11;
            REFoutPRsdata=32'b0;
            REFoutPRTdata=32'b0;
            REFoutPcmp_eq=1;
            REFoutPPCOut=pc;
            REFoutPimm_valueOut={{16{1'b0}},inst[15:0]};
            REFoutPpcmultiplexed=32'h00000000;
            REFoutPaddrRsOut = inst[25:21];
            REFoutPaddrRtOut = inst[20:16];
            REFoutPaddrRdOut = inst[15:11];
            
           
            
            #1;
		   
		       checkOutput(pc,inst,writeData,exOut,forbranchA,forbranchB, PCsrc,writeRegister,signExtendControl,regWrite,Clock);
      end
      /*
        verifica se foi um brach
      
      */
       for(i = 0; i < testcases; i = i + 1)
      begin
	  
                
            rand_31 = {$random} & 31'h7FFFFFFF;
			      pc={1'b1, rand_31};
			      rand_31 = {$random} & 31'h7FFFFFFF; 
			      inst={1'b1, rand_31};
			      rand_31 = {$random} & 31'h7FFFFFFF;
			      
            writeData= {1'b1, rand_31};
            rand_31 = {$random} & 31'h7FFFFFFF;
            exOut=  {1'b1, rand_31};
            rand_4 = 5'b10;
	          writeRegister={1'b1, rand_4};
            Clock=1;
            signExtendControl=0;
            regWrite=1;
            forbranchA=2'b10;
            forbranchB=2'b10;
            PCsrc=2'b10;
            REFoutPRsdata=exOut;
            REFoutPRTdata=exOut;
            REFoutPcmp_eq=1;
            REFoutPPCOut=pc;
            REFoutPimm_valueOut={{16{1'b0}},inst[15:0]};
            REFoutPpcmultiplexed=pc+REFoutPimm_valueOut;
            REFoutPaddrRsOut = inst[25:21];
            REFoutPaddrRtOut = inst[20:16];
            REFoutPaddrRdOut = inst[15:11];
            
           
            
            #1;
		   
		       checkOutput(pc,inst,writeData,exOut,forbranchA,forbranchB, PCsrc,writeRegister,signExtendControl,regWrite,Clock);
      end
      
        /*
         Terceiro teste verifica se realmente está dando um jump
        
        */
          for(i = 0; i < testcases; i = i + 1)
      begin
	  
                
            rand_31 = {$random} & 31'h7FFFFFFF;
			      pc={1'b1, rand_31};
			      rand_31 = {$random} & 31'h7FFFFFFF; 
			      inst={1'b1, rand_31};
			      rand_31 = {$random} & 31'h7FFFFFFF;
			      
            writeData= {1'b1, rand_31};
            rand_31 = {$random} & 31'h7FFFFFFF;
            exOut=  {1'b1, rand_31};
            rand_4 = 5'b10;
	          writeRegister={1'b1, rand_4};
            Clock=1;
            signExtendControl=0;
            regWrite=1;
            forbranchA=2'b01;
            forbranchB=2'b01;
            PCsrc=2'b01;
            REFoutPRsdata=writeData;
            REFoutPRTdata=writeData;
            REFoutPcmp_eq=1;
            REFoutPPCOut=pc;
            REFoutPimm_valueOut={{16{1'b0}},inst[15:0]};
            REFoutPpcmultiplexed={{6'b0},inst[25:0]};
            REFoutPaddrRsOut = inst[25:21];
            REFoutPaddrRtOut = inst[20:16];
            REFoutPaddrRdOut = inst[15:11];
            
           
            
            #1;
		   
		       checkOutput(pc,inst,writeData,exOut,forbranchA,forbranchB, PCsrc,writeRegister,signExtendControl,regWrite,Clock);
      end
      
      /*
        não ocorreu nd e percorre normalmente PC
      */
      
           for(i = 0; i < testcases; i = i + 1)
      begin
	  
                
            rand_31 = {$random} & 31'h7FFFFFFF;
			      pc={1'b1, rand_31};
			      rand_31 = {$random} & 31'h7FFFFFFF; 
			      inst={1'b1, rand_31};
			      rand_31 = {$random} & 31'h7FFFFFFF;
			      
            writeData= {1'b1, rand_31};
            rand_31 = {$random} & 31'h7FFFFFFF;
            exOut=  {1'b1, rand_31};
            rand_4 = 5'b10;
	          writeRegister={1'b1, rand_4};
            Clock=1;
            signExtendControl=0;
            regWrite=0;
            forbranchA=2'b00;
            forbranchB=2'b00;
            PCsrc=2'b00;
            REFoutPRsdata=32'd4;
            REFoutPRTdata=32'd4;
            REFoutPcmp_eq=1;
            REFoutPPCOut=pc;
            REFoutPimm_valueOut={{16{1'b0}},inst[15:0]};
            REFoutPpcmultiplexed=pc;
            REFoutPaddrRsOut = inst[25:21];
            REFoutPaddrRtOut = inst[20:16];
            REFoutPaddrRdOut = inst[15:11];
            
           
            
            #1;
		   
		       checkOutput(pc,inst,writeData,exOut,forbranchA,forbranchB, PCsrc,writeRegister,signExtendControl,regWrite,Clock);
      end
       //$display("NO TESTS WRITTEN - FILL THIS OUT\n"); //delete this after you write your test cases
       
       $display("\n\nALL TESTS PASSED!");
       $finish();
    end
  
 endmodule