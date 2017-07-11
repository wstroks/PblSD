module MEMWB(
	input Clock,
	input [31:0] saidaALU, dataMEM,
	input [4:0] registradorDestinoData,
	input [1:0] WB,
	output reg [31:0]	saidaALUwb, saidaMEM,
	output reg [4:0] saidaDestinoData,
	output reg registradorEscrita, registradorMEM
);

 always @(posedge Clock) begin

	saidaALUwb <= saidaALU;
	saidaMEM <= dataMEM;
	saidaDestinoData <= registradorDestinoData;
	registradorEscrita <= WB[0];
	registradorMEM <= WB[1];

 end

endmodule
