// Implemented by Tho Lam Chip
// Facebook: facebook.com/tholamchip
// Facebook Group: facebook.com/groups/tholamchip
// Youtube Channel: youtube.com/@ThoLamChip


module RC_ADD_SUB_32_BEH_MODEL (Y, CO, A, B, SnA);
  output [31:0] Y;
  output CO;
    
  // Input list
  input [31:0] A;
  input [31:0] B;
  input SnA;

  reg [31:0] Y;
  reg CO;
  
  always @(A or B or SnA) begin
    if (SnA)
    {CO,Y} = {1'b0,A} + {1'b0,~B} + 1'b1;
    //{CO,Y} = A + ~B + 1'b1;   //Wrong
    else
    {CO,Y} = {1'b0,A} + {1'b0,B};
  end

endmodule


