
module memoria(
    
    input [31:0] Address,
    input MemWrite,ler,
	 input [7:0] WriteData,
    output reg [7:0] ReadData
    );

    
    reg [7:0] memory [0:500];

    reg [31:0] addr_reg = 0;
		
	//initial begin
	//memory[32'd50] <= 7'd6;
	
	//end
	

    // Escrita sequencial ao subir do clock
    // Escrita sequencial ao subir do clock
    always @(*) begin
        if (MemWrite) begin
            memory[Address] <= WriteData;
        end
		  else if(ler) begin
		  addr_reg <= Address;
		 //assign ReadData= memory[Address];
		 ReadData <= memory[addr_reg];
		  
		  end
    end

    
   // always @(negedge Clock) begin
      //  addr_reg <= Address;
   // end
    
    //assign ReadData = MemWrite ? WriteData : memory[addr_reg];



endmodule
