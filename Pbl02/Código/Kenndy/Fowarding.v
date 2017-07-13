module Fowarding(
  input [4:0] IDEX_rt, IDEX_rs, EXMEM_rd, MEMWB_rd,
  input  EXMEM_regWrite, MEMWB_regWrite, MEMWB_MemtoReg, EXMEM_MemWrite,
  output reg [1:0] fwdSignalA, fwdSignalB,
  output reg fwdSignalC
  );

  always@(EXMEM_regWrite or EXMEM_rd or IDEX_rs or MEMWB_regWrite or MEMWB_rd)
   begin
      if(EXMEM_regWrite && (EXMEM_rd != 0) && (EXMEM_rd == IDEX_rs))
         fwdSignalA = 2'b10;
      else if(MEMWB_regWrite && (MEMWB_rd != 0) && (MEMWB_rd == IDEX_rs) && (EXMEM_rd != IDEX_rs))
         fwdSignalA = 2'b01;
      else
         fwdSignalA = 2'b00;
   end

   always@(MEMWB_regWrite or MEMWB_rd or IDEX_rt or EXMEM_rd or EXMEM_regWrite)
   begin
      if(MEMWB_regWrite && (MEMWB_rd != 0) && (MEMWB_rd == IDEX_rt) && (EXMEM_rd != IDEX_rt))
         fwdSignalB = 2'b10;
      else if(EXMEM_regWrite && (EXMEM_rd != 0) && (EXMEM_rd == IDEX_rt))
         fwdSignalB = 2'b01;
      else
         fwdSignalB = 2'b00;
   end

   always @ (MEMWB_MemtoReg) begin
     if (MEMWB_MemtoReg && EXMEM_MemWrite && MEMWB_rd == IDEX_rt)
        fwdSignalC = 1;
   end
   
endmodule