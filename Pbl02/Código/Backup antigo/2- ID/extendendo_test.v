`timescale  1ns/ 1ps
module extend_test_();
  
  reg [15:0] imediato;
	reg controle;
	wire [31:0] saida; 
  
  
SignExtend tt(
	.imediato(imediato),
	.controle(controle),
	.saida(saida)
);
initial begin
imediato=16'b1010; controle=1; 
$display("imediato = %d, controle = %d, saida = %d",imediato , controle , saida );
#10;

imediato=16'b0; controle=1; 
$display("imediato = %d, controle = %d, saida = %d",imediato , controle , saida );
#10;

imediato=16'b1011; controle=1; 
$display("imediato = %d, controle = %d, saida = %d",imediato , controle , saida );
#10;
 
end
endmodule
