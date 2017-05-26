`timescale  1ns/ 1ps
module RegistradorBancoTest();



  reg[4:0] registrador1_in ;
  reg [4:0] registrador2_in; //operando dois 
  reg [4:0] writeRegistrador_in;//distino
  reg [31:0] writeData_in;  //escrever no registrador a partir da memoria
 wire  [31:0] outData1_in; //saida 1
 wire [31:0] outData2_in;// saida 2
 reg we_in;  //desabilidatador
  
RegistradorBanco UUT( .registrador1(registrador1_in),.registrador2(registrador2_in), .writeRegistrador(writeRegistrador_in), .writeData(writeData_in), .outData1(outData1_in), .outData2(outData2_in), .we(we_in));

initial begin
registrador1_in=1; registrador2_in=4; writeRegistrador_in=0; writeData_in=0; we_in=0;

$display("registrador1_in = %d , registrador2_in = %d , writeRegistrador_in = %d , writeData_in = %d , we_in = %d , outData1_in = %d , outData2_in = %d ", registrador1_in , registrador2_in , writeRegistrador_in , writeData_in , we_in , outData1_in , outData2_in);

//segundo teste agora  com we desativado
#10;

registrador1_in=0; registrador2_in=0; writeRegistrador_in=0; writeData_in=2; we_in=0;

//$display("registrador1 = %d , registrador2 = %d , writeRegistrador = %d , writeData = %d , we = %d , outData1 = %d , outData2 = %d ", registrador1 , registrador2 , writeRegistrador , writeData , we , outData1 , outData2);
$display("registrador1_in = %d , registrador2_in = %d , writeRegistrador_in = %d , writeData_in = %d , we_in = %d , outData1_in = %d , outData2_in = %d ", registrador1_in , registrador2_in , writeRegistrador_in , writeData_in , we_in , outData1_in , outData2_in);
#10;

//agora vai we

registrador1_in=0; registrador2_in=0; writeRegistrador_in=0; writeData_in=2; we_in=1;

//$display("registrador1 = %d , registrador2 = %d , writeRegistrador = %d , writeData = %d , we = %d , outData1 = %d , outData2 = %d", registrador1 , registrador2 , writeRegistrador , writeData , we , outData1 , outData2);
$display("registrador1_in = %d , registrador2_in = %d , writeRegistrador_in = %d , writeData_in = %d , we_in = %d , outData1_in = %d , outData2_in = %d ", registrador1_in , registrador2_in , writeRegistrador_in , writeData_in , we_in , outData1_in , outData2_in);
#10;
//agora vai

registrador1_in=0; registrador2_in=0; writeRegistrador_in=0; writeData_in=0; we_in=0;

//$display("registrador1 = %d , registrador2 = %d , writeRegistrador = %d , writeData = %d , we = %d , outData1 = %d , outData2 = %d ", registrador1 , registrador2 , writeRegistrador , writeData , we , outData1 , outData2);
$display("registrador1_in = %d , registrador2_in = %d , writeRegistrador_in = %d , writeData_in = %d , we_in = %d , outData1_in = %d , outData2_in = %d ", registrador1_in , registrador2_in , writeRegistrador_in , writeData_in , we_in , outData1_in , outData2_in);
$display("\n");
#10;
	end
endmodule
