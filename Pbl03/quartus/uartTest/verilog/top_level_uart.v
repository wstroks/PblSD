module uart(
	input wire [7:0] din, // dado transmitido em tx
	input wire clock_50MHZ,
	input wire enable, //ativa o dado de transmissão de tx
	output wire tx,  // interface para placa
	output wire tx_busy, // tx ocupado
	input wire rx, // da placa para interface
	output wire rdy, // dado pronto para ser jogado na memoria
	input wire rdy_clr, // reiniciar rx 
	output wire [7:0] dout // dado recebebido
);

	wire rxclk_en, txclk_en;

	baud_rate_gen uart_baud(
		.clk_50m(clock_50MHZ),
		.rxclk_en(rxclk_en),
		.txclk_en(txclk_en)
	);

	tx transmissao(
				
		.dados_transmissao(din),
        .wr_en(enable),
        .clock_50(clock_50MHZ),
        .tick(txclk_en),
        .tx(tx),
        .tx_busy(tx_busy)
	);
	 rx recebe(
	  
	  .rx(rx),
      .reinicia(rdy_clr),
      .clock(clock_50MHZ),
	  .tick(rxclk_en),
      .rdy(rdy),
      .saida_rx(dout)
		
	);
endmodule
