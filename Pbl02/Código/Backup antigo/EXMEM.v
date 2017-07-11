module EXMEM(
  input Clock,
  input [1:0] WB,
  input [2:0] M,
  input [4:0] RD,
  input [31:0] entradaData, saidaALU,
  output reg [2:0] registradorM,
  output reg [1:0] registradorWB,
  output reg [31:0] saidaData, registradorALU,
  output reg [4:0] registradorRD);

 initial begin
 
  registradorWB=0;
  registradorM=0;
  regirstradorALU=0;
  saidaData=0;
  registradorRD=0;

 end

 always@(posedge Clock) begin

  registradorWB <= WB;
  registradorM <= M;
  registradorALU <= saidaALU;
  registradorRD <= RD;
  saidaData <= entradaData;

 end

endmodule
