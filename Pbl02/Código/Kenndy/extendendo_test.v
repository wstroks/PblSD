`timescale  1ns/ 1ps
module extend_test_();
  
    reg [15:0] imediato_b;
	reg controle;
	wire [31:0] saida; 
  
  
SignExtend xx(
	.imediato(imediato_b),
	.controle(controle),
	.saida(saida)
);

initial begin
imediato_b=16'b1010; controle=1; 
$display("imediato_b = %d, controle = %d, saida = %d",imediato_b , controle , saida );
#10;

imediato_b=16'b0; controle=1; 
$display("imediato_b = %d, controle = %d, saida = %d",imediato_b , controle , saida );
#10;

imediato_b=16'b1011; controle=1; 
$display("imediato_b = %d, controle = %d, saida = %d",imediato_b , controle , saida );
#10;
 
end
endmodule
