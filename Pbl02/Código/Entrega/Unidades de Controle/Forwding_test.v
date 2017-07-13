`timescale 1ns / 1ps

module forwding_test();

parameter Halfcycle = 5; //half period is 5ns
    
localparam Cycle = 2*Halfcycle;
    
reg Clock;
    
    // Clock Signal generation:
initial Clock = 0; 
always #(Halfcycle) Clock = ~Clock;


  reg [4:0] IDEX_rt, IDEX_rs, EXMEM_rd, MEMWB_rd;
  reg  EXMEM_regWrite, MEMWB_regWrite, MEMWB_MemtoReg, EXMEM_MemWrite;
  wire [1:0] fwdSignalA, fwdSignalB;
  wire fwdSignalC;
  
    
  reg [1:0] REFoutfwdSignalA, REFoutfwdSignalB;
  reg REFoutfwdSignalC;
  
 task checkOutput;
    input [4:0] IDEX_rt, IDEX_rs, EXMEM_rd, MEMWB_rd;
    input  EXMEM_regWrite, MEMWB_regWrite, MEMWB_MemtoReg, EXMEM_MemWrite,Clock;
    if(REFoutfwdSignalA == fwdSignalA && REFoutfwdSignalB == fwdSignalB) begin
      $display("Passou: REFoutfwdSignalA: %b ,fwdA: %b, REFoutfwdSignalB: %b,  fwdB: %b, REFoutfwdSignalC: %d, fwdC %b", REFoutfwdSignalA, fwdSignalA, REFoutfwdSignalB,fwdSignalB, REFoutfwdSignalC,fwdSignalC);
    end
    else begin
      $display("Errou: REFoutfwdSignalA: %b ,fwdA: %b, REFoutfwdSignalB: %b,  fwdB: %b, REFoutfwdSignalC: %d, fwdC %b", REFoutfwdSignalA, fwdSignalA, REFoutfwdSignalB,fwdSignalB, REFoutfwdSignalC,fwdSignalC);
    end
  endtask 
  
  
  
Fowarding test(
    .IDEX_rt(IDEX_rt),
    .IDEX_rs(IDEX_rs),
    .EXMEM_rd(EXMEM_rd),
    .MEMWB_rd(MEMWB_rd),
    .EXMEM_regWrite(EXMEM_regWrite),
    .MEMWB_regWrite(EXMEM_regWrite),
    .MEMWB_MemtoReg(MEMWB_MemtoReg),
    .EXMEM_MemWrite(EXMEM_MemWrite),
    .fwdSignalA(fwdSignalA),
    .fwdSignalB(fwdSignalB),
    .fwdSignalC(fwdSignalC)
    );

	initial begin
	  
	  EXMEM_regWrite = 1;
      MEMWB_regWrite = 1;
      MEMWB_MemtoReg = 1;
      EXMEM_MemWrite = 1;

      IDEX_rt = 5'b00001;
      IDEX_rs = 5'b00001;
      EXMEM_rd = 5'b00001;
      MEMWB_rd = 5'b00001;
		//EXMEM_rd == IDEX_rs
		
      REFoutfwdSignalA = 2'b10;
      REFoutfwdSignalB = 2'b01;
      REFoutfwdSignalC = 1;
      #1;
      checkOutput(IDEX_rt, IDEX_rs, EXMEM_rd, MEMWB_rd, EXMEM_regWrite, MEMWB_regWrite, MEMWB_MemtoReg, EXMEM_MemWrite,Clock);
	
	  EXMEM_regWrite = 0;
      MEMWB_regWrite = 0;
      MEMWB_MemtoReg = 1;
      EXMEM_MemWrite = 1;

      IDEX_rt = 5'b00001;
      IDEX_rs = 5'b00001;
      EXMEM_rd = 5'b00001;
      MEMWB_rd = 5'b00001;
		//EXMEM_rd == IDEX_rs
		
      REFoutfwdSignalA = 2'b00;
      REFoutfwdSignalB = 2'b00;
      REFoutfwdSignalC = 1;
      #1;
      checkOutput(IDEX_rt, IDEX_rs, EXMEM_rd, MEMWB_rd, EXMEM_regWrite, MEMWB_regWrite, MEMWB_MemtoReg, EXMEM_MemWrite,Clock);
	  
	  EXMEM_regWrite = 1;
      MEMWB_regWrite = 1;
      MEMWB_MemtoReg = 1;
      EXMEM_MemWrite = 1;

      IDEX_rt = 5'b00001;
      IDEX_rs = 5'b00001;
      EXMEM_rd = 5'b000011;
      MEMWB_rd = 5'b00001;
		//EXMEM_rd == IDEX_rs
		
      REFoutfwdSignalA = 2'b01;
      REFoutfwdSignalB = 2'b10;
      REFoutfwdSignalC = 1;
      #1;
      checkOutput(IDEX_rt, IDEX_rs, EXMEM_rd, MEMWB_rd, EXMEM_regWrite, MEMWB_regWrite, MEMWB_MemtoReg, EXMEM_MemWrite,Clock);
	
	end

endmodule