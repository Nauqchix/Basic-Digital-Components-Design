// 32-bit registere +ve edge, Reset on RESET=0
module REG32_BEH_MODEL (Q, D, LOAD, CLK, RESET);
  output reg [31:0] Q;

  input CLK, LOAD;
  input [31:0] D;
  input RESET;

  parameter [31:0] P_RST_VAL = 32'ha5b9;

  //TBD
  always @(posedge CLK or negedge RESET)
    if (~RESET)
      Q <= P_RST_VAL;        
  	else if (LOAD)
      Q <= D;                
    else
      Q <= Q;

endmodule