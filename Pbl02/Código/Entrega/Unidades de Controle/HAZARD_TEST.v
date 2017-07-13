`timescale  1ns/ 1ps
module hardzard_test();

parameter Halfcycle = 5; //half period is 5ns
    
localparam Cycle = 2*Halfcycle;
    
reg Clock;
    
    // Clock Signal generation:
initial Clock = 0; 
always #(Halfcycle) Clock = ~Clock;


    reg [4:0] IFID_rs, IFID_rt, IDEX_rt;
    reg IDEX_memRead, EXMEM_iord, branch;
    wire PCEscreve, IFIDEscreve, HazMuxControle;

	reg REFoutPCEscreve,REFoutIFIDEscreve,REFoutHazMuxControle;
	
	
	
Harzard DUT1(
	  .IFID_rs(IFID_rs), .IFID_rt(IFID_rt), .IDEX_rt(IDEX_rt),
	  .IDEX_memRead(IDEX_memRead), .EXMEM_iord(EXMEM_iord), .branch(branch),
	  .PCEscreve(PCEscreve), .IFIDEscreve(IFIDEscreve), .HazMuxControle(HazMuxControle) 
	
	);
	
	
	 task checkOutput;
    
		input [4:0] IFID_rs, IFID_rt, IDEX_rt;
		input IDEX_memRead, EXMEM_iord, branch,Clock;
		
		
		
if ( PCEscreve!==REFoutPCEscreve || IFIDEscreve!==REFoutIFIDEscreve || HazMuxControle !==REFoutHazMuxControle) begin
			
            $display("Erro: \tIFID_rs: %D, IFID_rt: %D, IDEX_rt: %D, IDEX_memRead: %D, EXMEM_iord: %D, branch: %D",IFID_rs, IFID_rt, IDEX_rt, IDEX_memRead, EXMEM_iord, branch);
			$display("PCEscreve: %D, REFoutPCEscreve: %D, IFIDEscreve: %D, REFoutIFIDEscreve: %D, HazMuxControle: %D,REFoutHazMuxControle: %D",PCEscreve, REFoutPCEscreve ,IFIDEscreve, REFoutIFIDEscreve, HazMuxControle,REFoutHazMuxControle);
			
			$finish();
        end
        else begin
			$display("Passou: \tIFID_rs: %D, IFID_rt: %D, IDEX_rt: %D, IDEX_memRead: %D, EXMEM_iord: %D, branch: %D",IFID_rs, IFID_rt, IDEX_rt, IDEX_memRead, EXMEM_iord, branch);
			$display("PCEscreve: %D, REFoutPCEscreve: %D, IFIDEscreve: %D, REFoutIFIDEscreve: %D, HazMuxControle: %D,REFoutHazMuxControle: %D",PCEscreve, REFoutPCEscreve, IFIDEscreve, REFoutIFIDEscreve, HazMuxControle,REFoutHazMuxControle);
	  end
    endtask
	
	initial begin
			
		// bolha por causa de leitura
		 IFID_rs=5'd20;
		 IFID_rt=5'd20;
		 IDEX_rt=5'd20;
         IDEX_memRead=1;
	     EXMEM_iord=0; 
	     branch=0;
		 REFoutPCEscreve=0;
	     REFoutIFIDEscreve=0;
         REFoutHazMuxControle=1;

	    
		#1;
		 checkOutput(IFID_rs,IFID_rt,IDEX_rt, IDEX_memRead,EXMEM_iord,  branch,Clock);
		 
		 // bolha por de breach
		 IFID_rs=5'd20;
		 IFID_rt=5'd20;
		 IDEX_rt=5'd20;
         IDEX_memRead=0;
	     EXMEM_iord=0; 
	     branch=1;
		 REFoutPCEscreve=0;
	     REFoutIFIDEscreve=0;
         REFoutHazMuxControle=1;

	    
		#1;
		 checkOutput(IFID_rs,IFID_rt,IDEX_rt, IDEX_memRead,EXMEM_iord,  branch,Clock);
		 
		 // não bolha
		 IFID_rs=5'd11;
		 IFID_rt=5'd11;
		 IDEX_rt=5'd20;
         IDEX_memRead=0;
	     EXMEM_iord=0; 
	     branch=0;
    
		 REFoutPCEscreve=1;
	     REFoutIFIDEscreve=1;
         REFoutHazMuxControle=0;
	     
		#1;
		 checkOutput(IFID_rs,IFID_rt,IDEX_rt, IDEX_memRead,EXMEM_iord,  branch,Clock);
	
	
	end
	
endmodule