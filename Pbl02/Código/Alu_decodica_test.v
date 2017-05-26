module Alu_decodica_test();
  
  reg [5:0] funct_in, opcode_in;
  wire [4:0] ALUop_in;

Alu_decodica uut( .funct(funct_in), .opcode(opcode_in), .ALUop(ALUop_in));

initial begin
  
  
  funct_in=6'b100000; opcode_in=6'b000000;  

$display("funct_in= %b,opcode_in= %b,ALUop_in= %d",funct_in,opcode_in,ALUop_in);
#10;

  
end

endmodule