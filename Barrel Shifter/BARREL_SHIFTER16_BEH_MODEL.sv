// Shift with control L or R shift
module BARREL_SHIFTER16_BEH_MODEL (Y,D,S, LnR);
  // output list
  output [15:0] Y;
  // input list
  input [15:0] D;
  input [3:0] S;
  input LnR;

  reg [15:0] Y;
  
  always @(D or S or LnR) begin
    if (LnR)
      Y = D << S;
    else
      Y = D >> S;
  end

endmodule