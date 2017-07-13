// Universidade Estadual de Feira de Santana
// TEC499 - MI - Sistemas Digitais
// Lab 3, 2016.1
//
// Module: ALUdecoder
// Desc:   Sets the ALU operation
// Inputs:
// 	opcode: the top 6 bits of the instruction
//    funct: the funct, in the case of r-type instructions
// Outputs:
// 	ALUop: Selects the ALU's operation

`include "Opcode.v"
`include "ALUop.v"

module ALUdec(
  input [5:0] funct, opcode,
  output reg [3:0] ALUop
);
	reg [3:0] out;

    always @(opcode or funct) begin
    	if(opcode == `RTYPE) begin
    		case(funct)
	    		`SLL :   out <= `ALU_SLL;
			`SRL :   out <= `ALU_SRL;
			`SRA :   out <= `ALU_SRA;
			`SLLV:   out <= `ALU_SLL;
			`SRLV:   out <= `ALU_SRL;
			`SRAV:   out <= `ALU_SRA;
			`ADDU:   out <= `ALU_ADDU;
			`SUBU:   out <= `ALU_SUBU;
			`AND :   out <= `ALU_AND;
			`OR  :   out <= `ALU_OR;
			`XOR :   out <= `ALU_XOR;
			`NOR :   out <= `ALU_NOR;
			`SLT :   out <= `ALU_SLT;
			`SLTU:   out <= `ALU_SLTU;
		endcase
    	end else begin
	    	case(opcode)
	    		`LB : out <= `ALU_ADDU;
	    		`LH : out <= `ALU_ADDU;
	    		`LW : out <= `ALU_ADDU;
	    		`SB : out <= `ALU_ADDU;
	    		`SH : out <= `ALU_ADDU;
	    		`SH : out <= `ALU_ADDU;
	    		`SW : out <= `ALU_ADDU;
	    		`LBU : out <= `ALU_ADDU;
	    		`LHU : out <= `ALU_ADDU;
	    		`ADDIU:  out <= `ALU_ADDU;
			`SLTI :  out <= `ALU_SLT;
			`SLTIU:  out <= `ALU_SLTU;
			`ANDI :  out <= `ALU_AND;
			`ORI  :  out <= `ALU_OR;
			`XORI :  out <= `ALU_XOR;
			`LUI  :  out <= `ALU_LUI;
	    	endcase
    	end

	assign ALUop = out;
    end
endmodule
