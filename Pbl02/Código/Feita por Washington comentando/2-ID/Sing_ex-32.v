
module SignExtend(
	input [31:0] imediato,
	input controle,
	output reg [31:0] saida
);

	always @(*) begin
			if(controle==1)begin

			if(imediato[15]==1'b0)begin
				saida[31:0] <= {{16'b0},imediato[15:0]};
			end
			else begin
				saida[31:0] <= {{16'b1111111111111111},imediato[15:0]};
			end

		end

		else begin
			saida[31:0] <= {{16{1'b0}},imediato[15:0]};
		end
	end
endmodule 
