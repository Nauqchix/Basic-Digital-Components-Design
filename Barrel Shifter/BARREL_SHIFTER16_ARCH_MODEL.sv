// Shift with control L or R shift
module BARREL_SHIFTER16_ARCH_MODEL (Y,D,S, LnR);
  // output list
  output [15:0] Y;
  // input list
  input [15:0] D;
  input [3:0] S;
  input LnR;

  //TBD
  wire [15:0] Lw, Rw;
  SHIFT16_R right_dir (.Y(Rw), .D(D), .S(S));
  SHIFT16_L left_dir (.Y(Lw), .D(D), .S(S));
  MUX16_2x1 result_inst (.Y(Y), .I0(Rw), .I1(Lw), .S(LnR));

endmodule

// Right shifter
module SHIFT16_R(Y,D,S);
  // output list
  output [15:0] Y;
  // input list
  input [15:0] D;
  input [3:0] S;

  //TBD
  wire [15:0] b1, b2, b3;
  genvar i;
  
  generate 
    for (i = 0; i < 16; i = i + 1) begin: bit_0
      MUX1_2x1 inst_1 (.Y(b1[i]), .I0(D[i]), .I1((i + 1 < 16) ? D[i + 1] : 1'b0), .S(S[0]));
    end
  endgenerate

  generate
    for (i = 0; i < 16; i = i + 1) begin: bit_1
      MUX1_2x1 inst_2 (.Y(b2[i]), .I0(b1[i]), .I1((i + 2 < 16) ? b1[i + 2] : 1'b0), .S(S[1]));
    end
  endgenerate
  
  generate
    for (i = 0; i < 16; i = i + 1) begin: bit_2
      MUX1_2x1 inst_3 (.Y(b3[i]), .I0(b2[i]), .I1((i + 4 < 16) ? b2[i + 4] : 1'b0), .S(S[2]));
    end
  endgenerate
  
  generate
    for (i = 0; i < 16; i = i + 1) begin: bit_3
      MUX1_2x1 inst_4 (.Y(Y[i]), .I0(b3[i]), .I1((i + 8 < 16) ? b3[i + 8] : 1'b0), .S(S[3]));
    end
  endgenerate
    


endmodule

// Left shifter
module SHIFT16_L(Y,D,S);
  // output list
  output [15:0] Y;
  // input list
  input [15:0] D;
  input [3:0] S;
  
  //TBD	
  wire [15:0] b1, b2, b3;
  genvar i;
  
  generate 
    for (i = 0; i < 16; i = i + 1) begin: bit_0_loop
      MUX1_2x1 inst_5 (.Y(b1[i]), .I0(D[i]), .I1((i >= 1) ? D[i - 1] : 1'b0), .S(S[0]));
    end
  endgenerate

  generate
    for (i = 0; i < 16; i = i + 1) begin: bit_1_loop
      MUX1_2x1 inst_6 (.Y(b2[i]), .I0(b1[i]), .I1((i >= 2) ? b1[i - 2] : 1'b0), .S(S[1]));
    end
  endgenerate
  
  generate
    for (i = 0; i < 16; i = i + 1) begin: bit_2_loop
      MUX1_2x1 inst_7 (.Y(b3[i]), .I0(b2[i]), .I1((i >= 4) ? b2[i - 4] : 1'b0), .S(S[2]));
    end
  endgenerate
  
  generate
    for (i = 0; i < 16; i = i + 1) begin: bit_3_loop
      MUX1_2x1 inst_8 (.Y(Y[i]), .I0(b3[i]), .I1((i >= 8) ? b3[i - 8] : 1'b0), .S(S[3]));
    end
  endgenerate
  

endmodule

// 16-bit mux
module MUX16_2x1(Y, I0, I1, S);
  // output list
  output [15:0] Y;
  //input list
  input [15:0] I0;
  input [15:0] I1;
  input S;

  genvar i;
  generate 
    for (i=0; i<16; i=i+1) begin : MUX1_2x1_gen_loop
      MUX1_2x1 MUX1_2x1_inst (Y[i],I0[i], I1[i], S);
    end
  endgenerate

endmodule

// 1-bit 16x1 mux
module MUX1_16x1 (Y, I0, I1, I2, I3, I4, I5, I6, I7,
                     I8, I9, I10, I11, I12, I13, I14, I15, S);
  // output list
  output  Y;
  //input list
  input I0;
  input I1;
  input I2;
  input I3;
  input I4;
  input I5;
  input I6;
  input I7;
  input I8;
  input I9;
  input I10;
  input I11;
  input I12;
  input I13;
  input I14;
  input I15;
  input [3:0] S;

  wire MUX1_8x1_0_Y;
  wire MUX1_8x1_1_Y;

  MUX1_2x1 MUX1_2x1_inst   (Y, MUX1_8x1_0_Y, MUX1_8x1_1_Y, S[3]);
  MUX1_8x1 MUX1_8x1_0_inst (MUX1_8x1_0_Y, I0, I1, I2, I3, I4, I5, I6, I7, S[2:0]);
  MUX1_8x1 MUX1_8x1_1_inst (MUX1_8x1_1_Y, I8, I9, I10, I11, I12, I13, I14, I15, S[2:0]);

endmodule

// 1-bit 8x1 mux
module MUX1_8x1 (Y, I0, I1, I2, I3, I4, I5, I6, I7, S);
  // output list
  output Y;
  //input list
  input I0;
  input I1;
  input I2;
  input I3;
  input I4;
  input I5;
  input I6;
  input I7;
  input [2:0] S;

  wire MUX1_4x1_0_Y;
  wire MUX1_4x1_1_Y;

  MUX1_2x1 MUX1_2x1_inst   (Y, MUX1_4x1_0_Y, MUX1_4x1_1_Y, S[2]);
  MUX1_4x1 MUX1_4x1_0_inst (MUX1_4x1_0_Y, I0, I1, I2, I3, S[1:0]);
  MUX1_4x1 MUX1_4x1_1_inst (MUX1_4x1_1_Y, I4, I5, I6, I7, S[1:0]);

endmodule

// 1-bit 4x1 mux
module MUX1_4x1 (Y, I0, I1, I2, I3, S);
  // output list
  output Y;
  //input list
  input I0;
  input I1;
  input I2;
  input I3;
  input [1:0] S;

  wire MUX1_2x1_S1_I0;
  wire MUX1_2x1_S1_I1;

  MUX1_2x1 MUX1_2x1_S1   (Y, MUX1_2x1_S1_I0, MUX1_2x1_S1_I1, S[1]);
  MUX1_2x1 MUX1_2x1_S0_0 (MUX1_2x1_S1_I0, I0, I1, S[0]);
  MUX1_2x1 MUX1_2x1_S0_1 (MUX1_2x1_S1_I1, I2, I3, S[0]);

endmodule

// 1-bit mux
module MUX1_2x1(Y,I0, I1, S);
  //output list
  output Y;
  //input list
  input I0, I1, S;

  wire not_S;
  wire not_S_and_I0;
  wire S_and_I1;

  not not_S_inst (not_S, S);
  and not_S_and_I0_inst (not_S_and_I0, not_S, I0);
  and S_and_I1_inst (S_and_I1, S, I1);
  or or_y_inst (Y, not_S_and_I0, S_and_I1);

endmodule