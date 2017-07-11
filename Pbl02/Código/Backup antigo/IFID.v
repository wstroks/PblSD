module IFID(
	input Clock,
	input [31:0] pc, instrucao,
	input sinalHazard, sinalControle,
	output reg [31:0] saidaPC, saidaInstrucao
);

	always @(posedge Clock) begin

		if(sinalControle == 1) begin
			saidaInstrucao <= 32'b0;
			saidaPC <=32'b0;
		end

		if(sinalHazard == 1) begin
			saidaPC <= pc;
			saidaInstrucao <= instrucao;
		end

	end


endmodule