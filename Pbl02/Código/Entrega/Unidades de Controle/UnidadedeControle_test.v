`timescale  1ns/ 1ps
`include "Opcode.v"
module Controle_test();



parameter Halfcycle = 5; //half period is 5ns
    
localparam Cycle = 2*Halfcycle;
    
reg Clock;


  reg cmp_eq;
  reg [5:0] opcode;
  wire [1:0] PCsrc;
  wire IFflush, signExt, IorD, noDest,FIM;
  wire regWrite, memToReg;        
  wire memRead, memWrite;                 
  wire ALUsrc, regDst;  	          
  wire [5:0] opcodeOut;
  wire branch;
  reg [18:0] SaidaREFout;
  reg fish;
  
  
  
  task checkOutput;
  if((SaidaREFout[18:17] == PCsrc) && (SaidaREFout[16] == IFflush) && (SaidaREFout[15] == branch) &&
  (SaidaREFout[14] == signExt) && (SaidaREFout[13] == regWrite) && (SaidaREFout[12] == memToReg) &&
  (SaidaREFout[11] == IorD) && (SaidaREFout[10] == memRead) && (SaidaREFout[9] == memWrite) &&
  (SaidaREFout[8] == ALUsrc) && (SaidaREFout[7] == regDst) && (SaidaREFout[6] == noDest) &&
  (SaidaREFout[5:0] == opcodeOut))begin
      $display("Passou, resultado: %B", opcode);
  end
  else
      $display("Erro, resultado: %B", opcode);
endtask

task getSequence;
  begin
    SaidaREFout <= 19'b0;  //[18:17]PCsrc, [16]IFflush, [15]branch, [14]signExt, [13]regWrite,
                     //[12]memToReg, [11]IorD, [10]memRead, [9]memWrite, [8]ALUsrc, [7]regDst, [6]noDest
                     //[5:0] opcodeOut
    SaidaREFout[5:0] <= opcodeOut;

    case (opcode)
      `RTYPE: begin
                
                  SaidaREFout[13] <= 1;
                  SaidaREFout[7] <= 1;
                
                
              end
      `ADDI: begin
                SaidaREFout[13] <= 1;
                SaidaREFout[8] <= 1;
            end
      `ORI: begin
                SaidaREFout[13] <= 1;
                SaidaREFout[8] <= 1;
            end
      `LUI: begin
                SaidaREFout[13] <= 1;
                SaidaREFout[8] <= 1;
                SaidaREFout[14] <= 1;
            end
      `BEQ: begin
                if(cmp_eq) begin
                  SaidaREFout[18:17] <= 2'b10;
                end
                SaidaREFout[15] <= 1;
            end
      `BNE: begin
                if(~cmp_eq) begin
                  SaidaREFout[18:17] <= 2'b10;
                end
                SaidaREFout[15] <= 1;
            end
      `J:
            SaidaREFout[18:17] <= 2'b01;
      `JAL: begin
                SaidaREFout[18:17] <= 2'b01;
                SaidaREFout[6] <= 1;
            end
      `LW:  begin
                SaidaREFout[13] <= 1;
                SaidaREFout[11] <= 1;
                SaidaREFout[12] <= 1;
                SaidaREFout[10] <= 1;
                SaidaREFout[8] <= 1;
            end
      `SW:  begin
                SaidaREFout[11] <= 1;
                SaidaREFout[9] <= 1;
                SaidaREFout[8] <= 1;
            end
      `MULTYPE: begin
                SaidaREFout[13] <= 1;
                SaidaREFout[7] <= 1;
            end
      `MFHI: begin
                SaidaREFout[13] <= 1;
                SaidaREFout[7] <= 1;
            end
	  `HALT: begin
			
			fish <= 1;
           
	  
	  end
    endcase
  end
endtask

UnidadedeControle uc(
  .cmp_eq(cmp_eq),
  .opcode(opcode),
  .FIM(FIM),
  .PCsrc(PCsrc),
  .IFflush(IFflush),
  .branch(branch),
  .signExt(signExt),
  .regWrite(regWrite),
  .memToReg(memToReg),
  .IorD(IorD),
  .memRead(memRead),
  .memWrite(memWrite),
  .ALUsrc(ALUsrc),
  .regDst(regDst),
  .noDest(noDest),
  .opcodeOut(opcodeOut)
  );

integer i;
initial begin
  

  //RTYPE
  i=1;
  opcode = 6'd0;
  #1;
  getSequence();
  #1;
  checkOutput();

  //ADDI
  i=2;
  opcode = 6'd8;
  #1;
  getSequence();
  #1;
  checkOutput();

  //ORI
  i=3;
  opcode = 6'd13;
  #1;
  getSequence();
  #1;
  checkOutput();

  //LUI
  i=4;
  opcode = 6'd15;
  #1;
  getSequence();
  #1;
  checkOutput();

  //BEQ
  i=5;
  opcode = 6'd4;
  #1;
  getSequence();
  #1;
  checkOutput();

  //BNE
  i=6;
  opcode = 6'd5;
  #1;
  getSequence();
  #1;
  checkOutput();

  //J
  i=7;
  opcode = 6'd2;
  #1;
  getSequence();
  #1;
  checkOutput();

  //JAL
  i=8;
  opcode = 6'd3;
  #1;
  getSequence();
  #1;
  checkOutput();

  //LW
  i=9;
  opcode = 6'd35;
  #1;
  getSequence();
  #1;
  checkOutput();

  //SW
  i=10;
  opcode = 6'd43;
  #1;
  getSequence();
  #1;
  checkOutput();

  //MULTYPE
  i=11;
  opcode = 6'd28;
  #1;
  getSequence();
  #1;
  checkOutput();  
  //HALT
  i=12;
  opcode = 6'b111111;
  #1;
  getSequence();
  #1;
  checkOutput();
  
end



endmodule
