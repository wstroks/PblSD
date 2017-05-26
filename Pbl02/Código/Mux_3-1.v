module Mux3_1(
  input [31:0] entradaA, entradaB, entradaC,
  input controle1,controle2,
  output reg [31:0] saida
);

  always @(*) begin

    case ({controle1,controle2})
       2'b00 : saida = entradaA;
       2'b01 : saida = entradaB;
       2'b10 : saida = entradaC;
       
     endcase

   

  end

endmodule
