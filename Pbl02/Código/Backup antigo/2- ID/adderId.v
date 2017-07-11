module PCAdder_id(
  input [31:0] A,B,
  output reg [31:0] saidaAdder
);

  always @(*)begin

    saidaAdder <=  B + A;

  end
endmodule

