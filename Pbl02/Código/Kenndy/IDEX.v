module IDEX(

  input clock,
  input [1:0] WB,
  input [2:0] M, 
  input [7:0] EX, 
  input [31:0] regRS, regRt, imm_value, PC,
  input [4:0] addrRs, addrRt, addrRd,
  output reg [2:0] MOut,
  output reg [7:0] EXOut,
  output reg [31:0] regRsOut, regRtOut, PCOut, imm_valueOut,
  output reg [4:0] addrRsOut, addrRtOut, addrRdOut,
  output reg [1:0] WBOut

  );

 initial begin
  PCOut = 0;
  WBOut = 0;
  MOut = 0;
  EXOut = 0;
  regRsOut = 0;
  regRtOut = 0;
  imm_valueOut = 0;
  addrRsOut = 0;
  addrRtOut = 0;
  addrRdOut = 0;
 end

 always@(posedge clock) begin
    PCOut <= PC;
    WBOut <= WB;
    MOut <= M;
    EXOut <= EX;
    regRsOut <= regRS;
    regRtOut <= regRt;
    imm_valueOut <= imm_value;
    addrRsOut <= addrRs;
    addrRtOut <= addrRt;
    addrRdOut <= addrRd;
 end
endmodule
