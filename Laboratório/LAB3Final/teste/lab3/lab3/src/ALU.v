// Universidade Estadual de Feira de Santana
// TEC499 - MI - Sistemas Digitais
// Lab 3, 2016.1
//
// Module: ALU.v
// Desc:   32-bit ALU for the MIPS150 Processor
// Inputs:
// 	A: 32-bit value
// 	B: 32-bit value
// 	ALUop: Selects the ALU's operation
//
// Outputs:
// 	Out: The chosen function mapped to A and B.

`include "Opcode.vh"
`include "ALUop.vh"

module ALU(
    input [31:0] A,B,
    input [3:0] ALUop,
    output reg [31:0] Out
);

	reg [31:0] sub_ab;
	reg [31:0] add_ab;
	wire 		    oflow_add;
	wire 		    oflow_sub;
	reg  [31:0] out;
  reg  [63:0] acc;



	// overflow occurs (with 2s complement numbers) when
	// the operands have the same sign, but the sign of the result is
	// different.  The actual sign is the opposite of the result.
	// It is also dependent on whether addition or subtraction is performed.

	assign oflow_add = (A[31] == B[31] && add_ab[31] != A[31]) ? 1 : 0;
	assign oflow_sub = (A[31] == B[31] && sub_ab[31] != A[31]) ? 1 : 0;

   always@(*) begin
      sub_ab = A - B;
      add_ab = A + B;

   		case(ALUop)
   			`ALU_ADDU: out <= add_ab;
        `ALU_ADD:  out <= $signed(A) + $signed(B);
   			`ALU_SUBU: out <= sub_ab;
        `ALU_SUB:  out <= $signed(A) - $signed(B);
   			`ALU_SLT:  out <= $signed(A) < $signed(B);
   			`ALU_SLTU: out <= A < B;
   			`ALU_AND:  out <= A & B;
  			`ALU_OR:   out <= A | B;
  			`ALU_XOR:  out <= A ^ B;
   			`ALU_LUI:  out <= B << 16;
  			`ALU_SLL:  out <= B << A;
  			`ALU_SRL:  out <= B >> A;
   			`ALU_SRA:  out <= $signed(B) >>> A[4:0];
  			`ALU_NOR:  out <= ~(A | B);
        `ALU_MUL:  out <= A * B;
        `ALU_MULT: acc <= A * B;
        `ALU_DIV:  acc <= A / B;
        `ALU_MFHI: out <= acc[63:32];
        `ALU_MFLO: out <= acc[31:0];
        `ALU_MTHI: acc[63:32] = A;
        `ALU_MTLO: acc[31:0] = A;
   			`ALU_XXX:  out <= 32'b0;
   		endcase

      assign Out = out;
   end

//always@* Out <= A + B; //oq eh essa onda?
endmodule
