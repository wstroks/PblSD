`include "Opcode.v"

module Control(
  input cmp_eq,
  input [5:0] opcode,
  output reg [1:0] PCsrc,
  output reg IFflush, signExt, IorD, noDest,
  output reg regWrite, memToReg,          //wb signals
  output reg memRead, memWrite,                 //mem signals
  output reg ALUsrc, regDst,     	          //ex signals
  output reg [5:0] opcodeOut,
  output reg branch
  );

  reg divOP;

  always @ ( * ) begin
    
    PCsrc     <= 2'b0;
    IFflush   <= 0;
    branch    <= 0;
    signExt   <= 0;

    regWrite  <= 0;
    memToReg  <= 0;

    IorD      <= 0;
    memRead   <= 0;
    memWrite  <= 0;

    ALUsrc    <= 0;
    regDst    <= 0;
    noDest    <= 0;
    opcodeOut <= opcode;
    divOP <= 0;

    if (opcode == `DIV) begin

      divOP <= 1;

    end

    case (opcode)
      
	   `RTYPE: begin
                
			if(~divOP) begin //tipo r comum

                   regWrite  <= 1;
                   regDst    <= 1;

            end 
      end
    `ADDI: begin
                regWrite    <= 1;
                ALUsrc      <= 1;
      end

      `ORI: begin
                regWrite    <= 1;
                ALUsrc      <= 1;
            end
      `LUI: begin
                regWrite    <= 1;
                ALUsrc      <= 1;
                signExt     <= 1;
            end
      
	 `BEQ: begin
                
			branch      <= 1;
                
			if(cmp_eq) begin
                PCsrc     <= 2'b10;
                IFflush   <= 1;
            end

       end
	
      `BNE: begin
                branch      <= 1;
                if(~cmp_eq) begin
                    PCsrc     <= 2'b10;
                    IFflush   <= 1;
                end
            end
      `J:
           PCsrc <= 2'b01;

      `JAL: begin
                PCsrc     <= 2'b01;
                noDest    <= 1;
            end
      
	`LW:  begin
                regWrite  <= 1;
                IorD      <= 1;
                memToReg  <= 1;
                memRead   <= 1;
                ALUsrc    <= 1;
            end
      
	`SW:  begin
                IorD      <= 1;
                memWrite  <= 1;
                ALUsrc    <= 1;
            end
      
	`MULTYPE: begin
                regWrite  <= 1;
                regDst    <= 1;
       end

    endcase
  end
endmodule
