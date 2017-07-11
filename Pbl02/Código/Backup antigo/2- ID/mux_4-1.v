module Mux4_1(
  input [31:0] A, B, C, D,
  input [1:0] controle,
  output reg [31:0] saidaMux4_1
);

  always @(*) begin

    if(controle == 2'b00)
      saidaMux4_1 = A;

    else if(controle == 2'b01)
     saidaMux4_1 = B;

    else if(controle == 2'b10)
      saidaMux4_1 = C;

    else
	saidaMux4_1 = D;

  end

endmodule