// 32-bit 16x1 mux
module MUX32_16x1_ARCH_MODEL(Y, I0, I1, I2, I3, I4, I5, I6, I7,
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

  //TBD
  wire [31:0] a5, a6;
  MUX32_8x1_ARCH_MODEL mux_8x1_inst1(.Y(a5), .I0(I0), .I1(I1), .I2(I2), .I3(I3), .I4(I4), .I5(I5), .I6(I6), .I7(I7), .S(S[2:0]));
  MUX32_8x1_ARCH_MODEL mux_8x1_inst2(.Y(a6), .I0(I8), .I1(I9), .I2(I10), .I3(I11), .I4(I12), .I5(I13), .I6(I14), .I7(I15), .S(S[2:0]));
  MUX32_2x1_ARCH_MODEL mux_2x1_inst1 (.Y(Y), .I0(a5), .I1(a6), .S(S[3]));

endmodule

// 32-bit 8x1 mux
module MUX32_8x1_ARCH_MODEL(Y, I0, I1, I2, I3, I4, I5, I6, I7, S);
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
  input [2:0] S;

  //TBD
  wire [31:0] a3, a4;
  MUX32_4x1_ARCH_MODEL mux_4x1_inst1(.Y(a3), .I0(I0), .I1(I1), .I2(I2), .I3(I3), .S(S[1:0]));
  MUX32_4x1_ARCH_MODEL mux_4x1_inst2(.Y(a4), .I0(I4), .I1(I5), .I2(I6), .I3(I7), .S(S[1:0]));
  MUX32_2x1_ARCH_MODEL mux_2x1_inst1 (.Y(Y), .I0(a3), .I1(a4), .S(S[2]));

endmodule

// 32-bit 4x1 mux
module MUX32_4x1_ARCH_MODEL(Y, I0, I1, I2, I3, S);
  // output list
  output [31:0] Y;
  //input list
  input [31:0] I0;
  input [31:0] I1;
  input [31:0] I2;
  input [31:0] I3;
  input [1:0] S;

  //TBD
  wire [31:0] a1, a2;
  MUX32_2x1_ARCH_MODEL mux_2x1_inst1 (.Y(a1), .I0(I0), .I1(I1), .S(S[0]));
  MUX32_2x1_ARCH_MODEL mux_2x1_inst2 (.Y(a2), .I0(I2), .I1(I3), .S(S[0]));
  MUX32_2x1_ARCH_MODEL mux_2x1_inst3 (.Y(Y), .I0(a1), .I1(a2), .S(S[1]));

endmodule