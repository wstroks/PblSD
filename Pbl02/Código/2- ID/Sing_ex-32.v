
module SignExtend(
	input [15:0] imediato,
	input controle,
	output reg [31:0] saida
);

	always @(*) begin
		if(controle==1)begin
      			saida[31:0] <= {{16{1'b0}},imediato[15:0]};
		end
	end
endmodule 
