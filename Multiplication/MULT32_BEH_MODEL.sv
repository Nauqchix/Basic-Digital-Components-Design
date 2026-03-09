module MULT32_BEH_MODEL (HI, LO, A, B);
  // output list
  output [31:0] HI;
  output [31:0] LO;
  // input list
  input [31:0] A;
  input [31:0] B;
  
  //TBD
  reg [31:0] HI, LO;
  always @(A or B) begin
    {HI, LO} = $signed(A) *$signed(B);
  end
  

endmodule