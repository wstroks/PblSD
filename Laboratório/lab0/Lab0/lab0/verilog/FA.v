//-----------------------------------------------------------------------------
// UEFS TEC 499
// Lab 0, 2016.1
// Module: FA.v
// Desc: 1-bit Full Adder
//       You may only use structural verilog in this module.       
//-----------------------------------------------------------------------------
module FA(
    input A, B, Cin,
    output Sum, Cout
);
   // Structural verilog only!
   /********YOUR CODE HERE********/
	wire A_xor_B,A_and_B, sim;
		
	xor(A_xor_B, A, B);
	xor(Sum,A_xor_B,Cin);
	
	and(A_and_B,A,B);
	and(sim, A_xor_B,Cin);
	or(Cout,sim,A_and_B);
	
	

	//assign Cout= ((A & B) | ((A^B) & Cin));
	//assign Sum = (A^B^Cin);

   /********END CODE********/
endmodule

