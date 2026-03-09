// 5x32 Line decoder
module DECODER_5x32_ARCH_MODEL(D,I);
  // output
  output [31:0] D;
  // input
  input [4:0] I;

  //TBD
  wire [15:0] Y;
  wire not_I4;
  not not_gate5(not_I4, I[4]);
  DECODER_4x16_ARCH_MODEL m_4x16_decoder_inst (.D(Y), .I(I[3:0]));
  genvar i;
  generate
    for (i = 0; i < 16; i = i + 1) begin
      and (D[i], not_I4, Y[i]);
      and (D[i + 16], I[4], Y[i]);
    end
  endgenerate

endmodule

// 4x16 Line decoder
module DECODER_4x16_ARCH_MODEL(D,I);
  // output
  output [15:0] D;
  // input
  input [3:0] I;

  //TBD
  wire [7:0] Y;
  wire not_I3;
  not not_gate4(not_I3, I[3]);
  DECODER_3x8_ARCH_MODEL m_3x8_decoder_inst (.D(Y), .I(I[2:0]));
  genvar i;
  generate
    for (i = 0; i < 8; i = i + 1) begin
      and (D[i], not_I3, Y[i]);
      and (D[i + 8], I[3], Y[i]);
    end
  endgenerate
  
endmodule

// 3x8 Line decoder
module DECODER_3x8_ARCH_MODEL(D,I);
  // output
  output [7:0] D;
  // input
  input [2:0] I;

  //TBD
  wire [3:0] Y;
   wire not_I2;
  not not_gate3(not_I2, I[2]);
  DECODER_2x4_ARCH_MODEL m_2x4_decoder_inst (.D(Y), .I(I[1:0]));
  genvar i;
  generate
    for (i = 0; i < 4; i = i + 1) begin
      and (D[i], not_I2, Y[i]);
      and (D[i + 4], I[2], Y[i]);
    end
  endgenerate
  

endmodule

// 2x4 Line decoder
module DECODER_2x4_ARCH_MODEL(D,I);
  // output
  output [3:0] D;
  // input
  input [1:0] I;

  //TBD
 wire not_I0, not_I1;
 
  not not_gate1(not_I0, I[0]);
  not not_gate2(not_I1, I[1]);
  and(D[0],not_I0,not_I1);
  and(D[1],I[0],not_I1);
  and(D[2],not_I0,I[1]);
  and(D[3],I[0],I[1]);
  
endmodule