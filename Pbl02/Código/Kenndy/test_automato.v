`timescale 1ns / 1ps
module auto();

  parameter Halfcycle = 5; //half period is 5ns
    
    localparam Cycle = 2*Halfcycle;
    reg Clock;
    // Clock Signal generation:
    initial Clock = 0; 
    always #(Halfcycle) Clock = ~Clock;
	
        reg [31:0] entradaA;
        reg [31:0] entradaB;
        reg controle;
        wire [31:0] DUToutA;
		reg [31:0] REFoutA;
		reg [30:0] rand_31;

task checkOutput;
        input [31:0] entradaA;
        input [31:0] entradaB;
        input controle,Clock;
        if ( REFoutA !== DUToutA) begin
	    
            $display("FAIL: \tentradaA: %D, entradaB: %D, controle: %D, REFoutA: %D, DUToutA: %D", entradaA, entradaB, controle, REFoutA,DUToutA);
        

        end
        else begin
			$display("PASS: \tentradaA: %D, entradaB: %D, controle: %D, REFoutA: %D, DUToutA: %D", entradaA, entradaB, controle,  REFoutA,DUToutA);

        end
    endtask

Mux2_1 DUT1(
  .entradaA(entradaA),
  .entradaB(entradaB),
  .controle(controle),
  .saida(DUToutA));
  
  
  integer i;
    localparam loops = 5; 
	
	
	 // Testing logic:
    initial begin
	for(i = 0; i < loops; i = i + 1)
        begin
            /////////////////////////////////////////////
            // Put your random tests inside of this loop
            // and hard-coded tests outside of the loop
            // (see comment below)
            // //////////////////////////////////////////
            #1;
            // Make both A and B negative to check signed operations
            rand_31 = {$random} & 31'h7FFFFFFF;
            entradaA = {1'b1, rand_31};
            rand_31 = {$random} & 31'h7FFFFFFF;
            entradaB = {1'b1, rand_31};    
	       controle=0;
            REFoutA=entradaA; 
            #1;
            	checkOutput(entradaA,entradaB,controle,Clock);
	end
	for(i = 0; i < loops; i = i + 1)
        begin
            /////////////////////////////////////////////
            // Put your random tests inside of this loop
            // and hard-coded tests outside of the loop
            // (see comment below)
            // //////////////////////////////////////////
            #1;
            // Make both A and B negative to check signed operations
            rand_31 = {$random} & 31'h7FFFFFFF;
            entradaA = {1'b1, rand_31};
            rand_31 = {$random} & 31'h7FFFFFFF;
            entradaB = {1'b1, rand_31};    
	        controle=1;
            REFoutA=entradaB; 
            #1;
            checkOutput(entradaA,entradaB,controle,Clock);
	end

        ///////////////////////////////
        // Hard coded tests go here
        ///////////////////////////////

        $display("\n\nADD YOUR ADDITIONAL TEST CASES HERE\n"); //delete this once you've written your test cases
       
        $display("\n\nALL TESTS PASSED!");
        $finish();
    end
endmodule