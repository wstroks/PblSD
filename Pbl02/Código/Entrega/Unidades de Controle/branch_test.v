`timescale 1ns / 1ps
module branch_test();

parameter Halfcycle = 5; //half period is 5ns
    
localparam Cycle = 2*Halfcycle;
    
reg Clock;
    
    // Clock Signal generation:
initial Clock = 0; 
always #(Halfcycle) Clock = ~Clock;

	 reg [4:0] IFID_rs, IFID_rt, EXMEM_rd, MEMWB_rd;
     reg EXMEM_regWrite, MEMWB_regWrite;
     wire [1:0] branchFWDA, branchFWDB;

	 reg [1:0] REFoutfbranchFWDA, REFoutfbranchFWDB;

task checkOutput;
     input [4:0] IFID_rs, IFID_rt, EXMEM_rd, MEMWB_rd;
     input EXMEM_regWrite, MEMWB_regWrite,Clock;
    if(REFoutfbranchFWDA == branchFWDA && REFoutfbranchFWDB == branchFWDB) begin
      $display("Passou: REFoutfbranchFWDA: %b ,branchFWDA: %b, REFoutfbranchFWDB: %b,  branchFWDB: %b", REFoutfbranchFWDA ,branchFWDA, REFoutfbranchFWDB,  branchFWDB);
    end
    else begin
      $display("Errou: REFoutfbranchFWDA: %b ,branchFWDA: %b, REFoutfbranchFWDB: %b,  branchFWDB: %b", REFoutfbranchFWDA ,branchFWDA, REFoutfbranchFWDB,  branchFWDB);
    end
  endtask 
  
  
  
Branch Dut1(
    .IFID_rs(IFID_rs), .IFID_rt(IFID_rt), .EXMEM_rd(EXMEM_rd), .MEMWB_rd(MEMWB_rd),
    .EXMEM_regWrite(EXMEM_regWrite), .MEMWB_regWrite(MEMWB_regWrite),
    .branchFWDA(branchFWDA), .branchFWDB(branchFWDB)
    );

	initial begin
	  
	  EXMEM_regWrite = 1;
      MEMWB_regWrite = 1;
    
      IFID_rt = 5'b00001;
      IFID_rs = 5'b00001;
      EXMEM_rd = 5'b00001;
      MEMWB_rd = 5'b00001;
		//EXMEM_rd == IDEX_rs
		
      REFoutfbranchFWDA = 2'b01;
      REFoutfbranchFWDB = 2'b01;
      
      #1;
	  
	  
      checkOutput(IFID_rs, IFID_rt, EXMEM_rd, MEMWB_rd, EXMEM_regWrite, MEMWB_regWrite, Clock);
	
	  EXMEM_regWrite = 0;
      MEMWB_regWrite = 0;
    
      IFID_rt = 5'b00001;
      IFID_rs = 5'b00001;
      EXMEM_rd = 5'b00001;
      MEMWB_rd = 5'b00001;
		//EXMEM_rd == IDEX_rs
		
      REFoutfbranchFWDA = 2'b00;
      REFoutfbranchFWDB = 2'b00;
      
      #1;
	  
	  
      checkOutput(IFID_rs, IFID_rt, EXMEM_rd, MEMWB_rd, EXMEM_regWrite, MEMWB_regWrite, Clock);
	  
	  
	  EXMEM_regWrite = 1;
      MEMWB_regWrite = 1;
    
      IFID_rt = 5'b00001;
      IFID_rs = 5'b00001;
      EXMEM_rd = 5'b00011;
      MEMWB_rd = 5'b00001;
		//EXMEM_rd == IDEX_rs
		
      REFoutfbranchFWDA = 2'b10;
      REFoutfbranchFWDB = 2'b10;
      
      #1;
	  
	  
      checkOutput(IFID_rs, IFID_rt, EXMEM_rd, MEMWB_rd, EXMEM_regWrite, MEMWB_regWrite, Clock);
	
	end


endmodule