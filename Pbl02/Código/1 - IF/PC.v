module PC(
  input [31:0] entrada,
  input PCescreve, clock,
  output reg [31:0] Pcsaida
  );
 

  always @ (posedge clock) begin
    if(PCescreve) begin
		
      Pcsaida <= entrada;
    end
  end
  endmodule
