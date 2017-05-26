`include "Opcode.v"
`include "Aluop.v"

module Alu_decodica(
  input [5:0] funct, opcode,
  output reg [4:0] ALUop
);
	reg [4:0] out;

    always @(opcode or funct) begin
    	if(opcode == `RTYPE) begin
    		case(funct)
	    		`SLL :   out = `ALU_SLL;
    			`SRL :   out = `ALU_SRL;
    			`SRA :   out = `ALU_SRA;
    			`SLLV:   out = `ALU_SLL;
    			`SRLV:   out = `ALU_SRL;
    			`SRAV:   out = `ALU_SRA;
    			`ADDU:   out = `ALU_ADDU;
          `ADD:    out = `ALU_ADD;
    			`SUBU:   out = `ALU_SUBU;
          `SUB:    out = `ALU_SUB;
    			`AND :   out = `ALU_AND;
    			`OR  :   out = `ALU_OR;
    			`XOR :   out = `ALU_XOR;
    			`NOR :   out = `ALU_NOR;
    			`SLT :   out = `ALU_SLT;
    			`SLTU:   out = `ALU_SLTU;
          `MULT:   out = `ALU_MULT;
          `MFHI:   out = `ALU_MFHI;
          `MFLO:   out = `ALU_MFLO;
          `MTHI:   out = `ALU_MTHI;
          `MTLO:   out = `ALU_MTLO;
		    endcase
    	end else if(opcode == `MULTYPE) begin
	    	  if(funct == `MUL)
            out = `ALU_MUL;

    	end else begin
        case(opcode)
          `LB : out = `ALU_ADDU;
          `LH : out = `ALU_ADDU;
          `LW : out = `ALU_ADDU;
          `SB : out = `ALU_ADDU;
          `SH : out = `ALU_ADDU;
          `SH : out = `ALU_ADDU;
          `SW : out = `ALU_ADDU;

          `ADDIU:  out = `ALU_ADDU;
          `ADDI:   out = `ALU_ADD;
          `SLTI :  out = `ALU_SLT;
          `SLTIU:  out = `ALU_SLTU;
          `ANDI :  out = `ALU_AND;
          `ORI  :  out = `ALU_OR;
          `XORI :  out = `ALU_XOR;
          `LUI  :  out = `ALU_LUI;
        endcase
      end

	    ALUop = out;
    end
endmodule
