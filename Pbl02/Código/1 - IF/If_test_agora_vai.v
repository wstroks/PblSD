`timescale  1ns/ 1ps
module if_test_agora_vai();

		reg [31:0] entradaPC,entradaMux;
		reg PCescreve, clock, controle;
		wire [31:0] Pcsaida, MuxSaida,saidaAdder;

 IF  maroto( .entradaPC(entradaPC),.entradaMux(entradaMux), .PCescreve(PCescreve), .clock(clock), .controle(controle), .Pcsaida(Pcsaida), .MuxSaida(MuxSaida),.saidaAdder(saidaAdder));

initial begin

entradaPC=32'b0; entradaMux=10;  PCescreve=1; clock=1; controle=1;
$display("entradaPC = %d, entradaMux= %d,  PCescreve = %d, clock=%d,  controle = %d, Pcsaida = %d,MuxSaida= %d, saidaAdder = %d", entradaPC , entradaMux,  PCescreve , clock,  controle , Pcsaida,MuxSaida, saidaAdder);
#10;

entradaPC=32'b100; entradaMux=10;  PCescreve=0; clock=0; controle=1;
$display("entradaPC = %d, entradaMux= %d,  PCescreve = %d, clock=%d,  controle = %d, Pcsaida = %d,MuxSaida= %d, saidaAdder = %d", entradaPC , entradaMux,  PCescreve , clock,  controle , Pcsaida,MuxSaida, saidaAdder);
#10;

entradaPC=32'b100; entradaMux=10;  PCescreve=1; clock=1; controle=1;
$display("entradaPC = %d, entradaMux= %d,  PCescreve = %d, clock=%d,  controle = %d, Pcsaida = %d,MuxSaida= %d, saidaAdder = %d", entradaPC , entradaMux,  PCescreve , clock,  controle , Pcsaida,MuxSaida, saidaAdder);
#10;
end


endmodule
