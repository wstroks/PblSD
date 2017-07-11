`ifndef OPCODE
`define OPCODE

// Opcode
`define RTYPE   6'b000000
`define MULTYPE 6'b011100
`define SEB/SEH 6'b011111
// Load/store
`define LB      6'b100000
`define LH      6'b100001
`define LW      6'b100011
`define LBU     6'b100100
`define LHU     6'b100101
`define SB      6'b101000
`define SH      6'b101001
`define SW      6'b101011
// I-type
`define ADDI    6'b001000 //signed
`define ADDIU   6'b001001
`define SLTI    6'b001010 //signed
`define SLTIU   6'b001011
`define ANDI    6'b001100
`define ORI     6'b001101
`define XORI    6'b001110
`define LUI     6'b001111
`define BEQ     6'b000100
`define BNE     6'b000101
//JUMP
`define J       6'b000010
`define JAL     6'b000011
// Funct (R-type)
`define ADD     6'b100000 //signed
`define ADDU    6'b100001
`define SLL     6'b000000
`define SRL     6'b000010
`define SRA     6'b000011
`define SLLV    6'b000100
`define SRLV    6'b000110
`define SRAV    6'b000111
`define SUB     6'b100010 //signed
`define SUBU    6'b100011
`define AND     6'b100100
`define OR      6'b100101
`define XOR     6'b100110
`define NOR     6'b100111
`define SLT     6'b101010 //signed
`define SLTU    6'b101011
`define MOVZ    6'b001010
`define MOVN    6'b001011
`define JR      6'b001001
`define MUL     6'b000010
`define MULT    6'b011000
`define DIV     6'b011010
`define MFHI    6'b010000
`define MFLO    6'b010010
`define MTHI    6'b010001
`define MTLO    6'b010011

`endif //OPCODE

