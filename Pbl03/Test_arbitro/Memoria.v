
module memoria(
    
    input [31:0] Address,
    input MemWrite,
	 input [7:0] WriteData,
    output wire [7:0] ReadData
    );

    
    reg [7:0] memory [0:500];

    reg [31:0] addr_reg = 0;
		
	initial begin
	memory[32'd50] <= 7'd0;
	memory[32'd60] <= 7'd0;
	
	end
	

    // Escrita sequencial ao subir do clock
    // Escrita sequencial ao subir do clock
    always @(*) begin
        if (MemWrite) begin
            memory[Address] <= WriteData;
        end
		  else if(~MemWrite) begin
		  addr_reg <= Address;
		  
		  end
    end

    
   // always @(negedge Clock) begin
      //  addr_reg <= Address;
   // end
    
    assign ReadData = MemWrite ? WriteData : memory[addr_reg];



endmodule
