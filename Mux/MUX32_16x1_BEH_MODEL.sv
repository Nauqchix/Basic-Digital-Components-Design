// 32-bit 16x1 mux
module MUX32_16x1_BEH_MODEL(Y, I0, I1, I2, I3, I4, I5, I6, I7,
                     I8, I9, I10, I11, I12, I13, I14, I15, S);
  // output list
  output [31:0] Y;
  //input list
  input [31:0] I0;
  input [31:0] I1;
  input [31:0] I2;
  input [31:0] I3;
  input [31:0] I4;
  input [31:0] I5;
  input [31:0] I6;
  input [31:0] I7;
  input [31:0] I8;
  input [31:0] I9;
  input [31:0] I10;
  input [31:0] I11;
  input [31:0] I12;
  input [31:0] I13;
  input [31:0] I14;
  input [31:0] I15;
  input [3:0] S;

  reg [31:0] Y;
  
  always @(*) begin
    case (S)
      4'd0: Y = I0;
      4'd1: Y = I1;
      4'd2: Y = I2;
      4'd3: Y = I3;
      4'd4: Y = I4;
      4'd5: Y = I5;
      4'd6: Y = I6;
      4'd7: Y = I7;
      4'd8: Y = I8;
      4'd9: Y = I9;
      4'd10: Y = I10;
      4'd11: Y = I11;
      4'd12: Y = I12;
      4'd13: Y = I13;
      4'd14: Y = I14;
      4'd15: Y = I15;
      default: Y = 32'd0;
    endcase
  end

endmodule