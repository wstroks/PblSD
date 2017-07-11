`timescale 1ns / 1ps
module text();

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
  
  
  // //////////////////////////////////////////////////////////////
    localparam testcases = 14; //aumentar584

    reg [31:0] testvector [0:testcases-1]; // Each testcase has 108 bits:
    // 64 for A and B, 32 for REFout, 6 for
    // opcode, 6 for funct

    integer i; // integer used for looping in non-generate statement

    initial 
    begin
	
	  $readmemb("../PBL-Final/x.input" , testvector);
      for(i = 0; i < testcases; i = i + 1)
      begin
	  
           entradaA = testvector[i][31:0];
                   
            rand_31 = {$random} & 31'h7FFFFFFF;
            entradaB = {1'b1, rand_31};    
	       controle=0;
            REFoutA=entradaA; 
           #1;
           checkOutput(entradaA,entradaB,controle,Clock);
      end
       //$display("NO TESTS WRITTEN - FILL THIS OUT\n"); //delete this after you write your test cases
       
       $display("\n\nALL TESTS PASSED!");
       $finish();
    end
  
endmodule
