module Mux2_1(
        input [31:0] entradaA,
        input [31:0] entradaB,
        input controle,
        output reg [31:0] saida
);

  always @(*) begin

      if (~controle)
        saida <= entradaA;

      else
        saida <= entradaB;

    end


endmodule

