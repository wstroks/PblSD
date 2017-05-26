`include "Aluop.v"

module ALU(
    input [31:0] A,B,
    input [4:0] ALUop,
    output reg [31:0] Out
);

	reg  [31:0] out;
  reg  [63:0] acc;

   always@(*) begin
   		case(ALUop)
   			`ALU_ADDU: out = A + B;
        `ALU_ADD:  out = $signed(A) + $signed(B);
   			`ALU_SUBU: out = A - B;
        `ALU_SUB:  out = $signed(A) - $signed(B);
   			`ALU_SLT:  out = $signed(A) < $signed(B);
   			`ALU_SLTU: out = A < B;
   			`ALU_AND:  out = A & B;
  			`ALU_OR:   out = A | B;
  			`ALU_XOR:  out = A ^ B;
   			`ALU_LUI:  out = A << 16;
        `ALU_SLL:  out = B << A;
  			`ALU_SRL:  out = B >> A;
   			`ALU_SRA:  out = B >>> A;
  			`ALU_NOR:  out = ~(A | B);
        `ALU_MUL:  out = $signed(A) * $signed(B);
        `ALU_MULT: acc = A * B;
        `ALU_DIV:  acc = A / B;
        `ALU_MFHI: out = acc[63:32];
        `ALU_MFLO: out = acc[31:0];
        `ALU_MTHI: acc[63:32] = A;
        `ALU_MTLO: acc[31:0] = A;
   			`ALU_XXX:  out = 32'b0;
   		endcase

      Out = out;

   end
endmodule
