module Harzard(
    input [4:0] IFID_rs, IFID_rt, IDEX_rt,
    input IDEX_memRead, EXMEM_iord, branchFWD,
    output reg PCWrite, IFIDWrite, HazMuxCtrl
  );

  always@(IFID_rs, IFID_rt, IDEX_rt, IDEX_memRead)
    if((IDEX_memRead && ((IDEX_rt == IFID_rs) || (IDEX_rt == IFID_rt))) || EXMEM_iord || branchFWD)
       begin//bolha
           PCWrite = 0;
           IFIDWrite = 0;
           HazMuxCtrl = 1;
       end
    else
       begin//não bolha
           PCWrite = 1;
           IFIDWrite = 1;
           HazMuxCtrl = 0;
       end
endmodule
