module teste(
    input clock_50MHz,
    input UART_Rx,
	 input Uart_rx1,
    input [3:0] Switch,
    output UART_Tx,
	 output Uart_tx1,
    output LED_R,
    output [7:0] LEDM_R,
    output [4:0] LEDM_C
);

wire Rx_data_ready, tx_busy, rdy;
wire [7:0] Rx_Data,Rx_Data2;
wire [7:0] saida;
wire [7:0] saida2;


wire readyRx0, readyRx1, busyTX0, busyTX1,ocupadoPC,write,ler;
wire enableTx0, enableTx1, clearRx0, clearRx1,DadoPronto0,DadoPronto1;

wire [7:0] LEDM_R_inv;


assign LEDM_R = ~LEDM_R_inv;

assign LEDM_C[0] = 1'b0; // enable col 0
assign LEDM_C[4:1] = 4'b1111; // disable cols 1~5

assign LEDM_R_inv = saida;

assign write = (DadoPronto0 || DadoPronto1)? 1:0;
assign ler =(enableTx0)? 1:0;

arbitro arbitro(

	.endereco(32'd50),
	.readyRx0(readyRx0), 
	.readyRx1(readyRx1), 
	.busyTX0(busyTX0), 
	.busyTX1(busyTX1),
	.ocupadoPC(Switch[1]),
	.enableTx0(enableTx0), 
	.enableTx1(enableTx1),
	.reseta0(clearRx0), 
	.reseta1(clearRx1),
	.DadoProntoMem0(DadoPronto0),
	.DadoProntoMem1(DadoPronto1)
);

uart ut (
	.din(saida),
  	.enable(enableTx0),
	.clock_50MHZ(clock_50MHz),
	.tx(UART_Tx),
	.tx_busy(busyTx0),
	.rdy(readyRx0),
	.rx(UART_Rx),
	.rdy_clr(clearRx0),
	.dout(Rx_Data)
);


uart uart1 (
	.din(saida2),
  	.enable(enableTx1),
	.clock_50MHZ(clock_50MHz),
	.tx(Uart_tx1),
	.tx_busy(busyTx1),
	.rdy(readyRx1),
	.rx(Uart_rx1),
	.rdy_clr(clearRx1),
	.dout(Rx_Data2)
);

memoria aque(
    //.Clock(clock_50MHz),
    .Address(32'd50),
    .MemWrite(write),
	 .ler(ler),
	 .WriteData(Rx_Data),
    .ReadData(saida)
    );


endmodule
