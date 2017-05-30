module PCAdder(
  input [31:0] A,
  output reg [31:0] saidaAdder
);

  always @(*)begin

    saidaAdder <=  32'b00000000000000000000000000000100 +A;

  end
endmodule
