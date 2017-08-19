module arbitro(

	input [31:0] endereco,
	input readyRx0, readyRx1, busyTX0, busyTX1,ocupadoPC,
	output enableTx0, enableTx1, reseta0, reseta1,DadoProntoMem0,DadoProntoMem1
);

assign enableTx0 = (!busyTX0 & !ocupadoPC & (endereco == 32'd50))? 1:0; //informa dado pronto 
assign DadoProntoMem0 = (!ocupadoPC & readyRx0)? 1:0; //verifica se o dado ta pronto 

assign reseta0 = (DadoProntoMem0)? 1:0; //reseta apos o arbitro tiver ok


assign enableTx1 = (!busyTX1 & !ocupadoPC & (endereco == 32'd60))? 1:0;
assign DadoProntoMem1 = (!ocupadoPC &!readyRx0 &readyRx1)? 1:0; //dado pronto veriicar se ata ocupado

assign reseta1 = (DadoProntoMem1)? 1:0; //reseta

endmodule


