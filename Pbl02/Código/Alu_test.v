module alu_test();
  
  
    reg [31:0] A_in,B_in;
    reg [4:0] ALUop_in;
    wire [31:0] Out_in;

ALU utt(.A(A_in),.B(B_in), .ALUop(ALUop_in), .Out(Out_in));
initial begin 

A_in=10; B_in=11; ALUop_in=5'd0;  

$display("A_in= %d,B_in= %d,ALUop_in= %d, Out_in= %d",A_in,B_in,ALUop_in, Out_in);
#10;

//testa todas as outras ... AluOp
end  


endmodule