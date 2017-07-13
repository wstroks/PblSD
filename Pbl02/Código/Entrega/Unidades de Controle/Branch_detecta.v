module Branch(
  input [4:0] IFID_rs, IFID_rt, EXMEM_rd, MEMWB_rd,
  input EXMEM_regWrite, MEMWB_regWrite,
  output reg [1:0] branchFWDA, branchFWDB
  );

  always@(EXMEM_regWrite or EXMEM_rd or IFID_rs or MEMWB_regWrite or MEMWB_rd)
   begin
      if(EXMEM_regWrite && (EXMEM_rd !== 0) && (EXMEM_rd == IFID_rs))
         branchFWDA = 2'b01;
      else if(MEMWB_regWrite && (MEMWB_rd !== 0) && (MEMWB_rd == IFID_rs) && (EXMEM_rd !== IFID_rs))
         branchFWDA = 2'b10;
      else
         branchFWDA = 2'b00;
   end

   //Forward B
   always@(MEMWB_regWrite or MEMWB_rd or IFID_rt or EXMEM_rd or EXMEM_regWrite)
   begin
      if(MEMWB_regWrite && (MEMWB_rd !== 0) && (MEMWB_rd == IFID_rt) && (EXMEM_rd !== IFID_rt))
         branchFWDB = 2'b10;
      else if(EXMEM_regWrite && (EXMEM_rd !== 0) && (EXMEM_rd == IFID_rt))
         branchFWDB = 2'b01;
      else
         branchFWDB = 2'b00;
    end
endmodule

