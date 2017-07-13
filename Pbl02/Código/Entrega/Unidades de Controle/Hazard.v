module Harzard(
    input [4:0] IFID_rs, IFID_rt, IDEX_rt,
    input IDEX_memRead, EXMEM_iord, branch,
    output reg PCEscreve, IFIDEscreve, HazMuxControle
  );

  always@(IFID_rs, IFID_rt, IDEX_rt, IDEX_memRead)
    if((IDEX_memRead && ((IDEX_rt == IFID_rs) || (IDEX_rt == IFID_rt))) || EXMEM_iord || branch)
       begin
	   
	       PCEscreve = 0;
           IFIDEscreve = 0;
           HazMuxControle = 1;
           
       end
    else
       begin
		   
		   
		   
		   
		   //não bolha
           PCEscreve = 1;
           IFIDEscreve = 1;
           HazMuxControle = 0;
       end
endmodule
