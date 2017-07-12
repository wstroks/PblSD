module Mux4_1(
  input [31:0] entradaA, entradaB, entradaC, entradaD,
  input [1:0] controle,
  output reg [31:0] saidaMux4_1
);

  always @(*) begin

    if(controle == 2'b00)
      saidaMux4_1 = entradaA;

    else if(controle == 2'b01)
     saidaMux4_1 = entradaB;

    else if(controle == 2'b10)
      saidaMux4_1 = entradaC;

    else
	saidaMux4_1 = entradaD;

  end

endmodule