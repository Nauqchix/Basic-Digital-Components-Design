module FULL_ADDER_BEH_MODEL(S, CO, A, B, CI);
  output reg S, CO;
  input A, B, CI;

 //TBD
  always @(A or B or CI) begin
    {CO, S} = A + B + CI;
  end

endmodule
