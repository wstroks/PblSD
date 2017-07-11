module jump(
	input [25:0] recebeExtend,
	output reg [31:0] saida
);

	always @(*) begin
	    		 saida[31:0] <= {{6'b0},recebeExtend[25:0]};
	end

endmodule 

