module comparador_ID(
  input[31:0] A, B,
  output reg saida
  );

  always @ ( * ) begin
    if (A == B)
      saida = 1;

    else
      saida = 0;
  end
  
  endmodule

