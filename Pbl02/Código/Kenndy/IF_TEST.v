`timescale  1ns/ 1ps
module if_test();


parameter Halfcycle = 5; //half period is 5ns
    
localparam Cycle = 2*Halfcycle;
    
reg Clock;
    
    // Clock Signal generation:
initial Clock = 0; 
always #(Halfcycle) Clock = ~Clock;

		//variaveis que vão receber do modulo IF
        reg [31:0] entradaPC,ALu,data1,data2;
		reg PCescreve, clock, c1,c2,ler,escreve;
		wire [31:0] Pcsaida, SaidaDadosInstruc,writeDataMemWB,saidaAdder,saidaMemoria;
		
//insta do modulo if	
IF DUT1(

	 .entradaPC(entradaPC),.ALu(ALu),.data1(data1),.data2(data2),
	 .PCescreve(PCescreve), .clock(clock), .c1(c1),.c2(c2),.ler(ler),.escreve(escreve),
	 .Pcsaida(Pcsaida), .SaidaDadosInstruc(SaidaDadosInstruc),.writeDataMemWB(writeDataMemWB),.saidaAdder(saidaAdder),.saidaMemoria(saidaMemoria)


);		
		
	
		
initial begin

//primeiro teste recebe o endereço 0 
entradaPC=32'b0;  PCescreve=1; clock=1;  ALu=32'b10; c1=0; c2=0; data1=32'b100; data2=32'b1000; escreve=1; ler=0;
$display("entradaPC= %d, PCescreve= %d, clock=%d, Pcsaida= %d,saidaAdder = %d",entradaPC, PCescreve, clock, Pcsaida,saidaAdder );
$display("ALu= %d,saidaAdder= %d, c1 = %d,SaidaDadosInstruc = %d ",ALu,saidaAdder, c1,SaidaDadosInstruc);
$display("data1 = %d ,data2 = %d, c2 = %d, writeDataMemWB = %d", data1,data2 , c2 , writeDataMemWB);
$display("escreve = %d, ler = %d,saidaMemoria= %d", escreve , ler,saidaMemoria);
#1;


//primeiro teste recebe o endereço 0 
entradaPC=32'b100;  PCescreve=1; clock=0;  ALu=32'b10; c1=1; c2=0; data1=32'b100; data2=32'b1000; escreve=0; ler=1;
$display("entradaPC= %d, PCescreve= %d, clock=%d, Pcsaida= %d,saidaAdder = %d",entradaPC, PCescreve, clock, Pcsaida,saidaAdder );
$display("ALu= %d,saidaAdder= %d, c1 = %d,SaidaDadosInstruc = %d ",ALu,saidaAdder, c1,SaidaDadosInstruc);
$display("data1 = %d ,data2 = %d, c2 = %d, writeDataMemWB = %d", data1,data2 , c2 , writeDataMemWB);
$display("escreve = %d, ler = %d,saidaMemoria= %d", escreve , ler,saidaMemoria);
#1;


entradaPC=32'b100;  PCescreve=1; clock=1;  ALu=32'b10; c1=1; c2=0; data1=32'b100; data2=32'b1000; escreve=0; ler=1;
$display("entradaPC= %d, PCescreve= %d, clock=%d, Pcsaida= %d,saidaAdder = %d",entradaPC, PCescreve, clock, Pcsaida,saidaAdder );
$display("ALu= %d,saidaAdder= %d, c1 = %d,SaidaDadosInstruc = %d ",ALu,saidaAdder, c1,SaidaDadosInstruc);
$display("data1 = %d ,data2 = %d, c2 = %d, writeDataMemWB = %d", data1,data2 , c2 , writeDataMemWB);
$display("escreve = %d, ler = %d,saidaMemoria= %d", escreve , ler,saidaMemoria);
#1;
end






endmodule
