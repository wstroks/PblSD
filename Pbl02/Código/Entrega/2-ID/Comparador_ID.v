module comparador_ID(
  input[31:0] entradaA, entradaB,
  output reg saida
  );

  always @ ( * ) begin
    if (entradaA == entradaB)
      saida = 1;

    else
      saida = 0;
  end
  
  endmodule

