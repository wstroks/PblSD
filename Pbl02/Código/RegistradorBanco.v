module RegistradorBanco(
  
  input [4:0] registrador1, //operando 1
  input [4:0] registrador2, //operando dois 
  input [4:0] writeRegistrador,//distino
  input [31:0] writeData,  //escrever no registrador a partir da memoria
  output reg [31:0] outData1, //saida 1
  output reg [31:0] outData2,// saida 2
  input we  //desabilidatador
  
  
);
  
    reg [31:0] registradorBanco [31:0];

//inicializando o registradores 

integer i;

	initial
	begin
	    for(i = 0; i < 32; i = i+1)
		begin
	        registradorBanco[i] = 32'd4;
		end
	end
	
	always@ * begin 
	  
	  if(we)
	     registradorBanco[writeRegistrador]<=writeData;
	  
	
	
	 outData1=registrador1;
	   
	  outData2=registrador2;
	  
	  
	  
	
	  
	end
	
	endmodule
