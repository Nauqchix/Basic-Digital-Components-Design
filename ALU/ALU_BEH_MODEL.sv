module ALU_BEH_MODEL (OUT, ZERO, OP1, OP2, OPRN);
  // input list
  input [31:0] OP1; // operand 1
  input [31:0] OP2; // operand 2
  input [5:0] OPRN; // operation code
  
  // output list
  output reg [31:0] OUT; // result of the operation.
  output reg ZERO;
  
  //TBD
  always @(OPRN or OP1 or OP2) begin
    case(OPRN[3:0])
      4'b0001: OUT = OP1 + OP2;
      4'b0010: OUT = OP1 - OP2;
      4'b0011: OUT = $signed(OP1 * OP2);
      4'b0100: OUT = OP1 >>> OP2;
      4'b0101: OUT = OP1 << OP2;
      4'b0110: OUT = OP1 & OP2;
      4'b0111: OUT = OP1 | OP2;
      4'b1000: OUT = ~(OP1 | OP2);
      4'b1001: OUT = ($signed(OP1) < $signed(OP2)) ? 32'd1 : 32'd0;
      default: OUT = 32'd0;
    endcase
     ZERO = (OUT == 32'd0);
  end
endmodule