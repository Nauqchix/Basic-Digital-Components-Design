module MULT32_ARCH_MODEL (HI, LO, A, B);
  // output list
  output [31:0] HI;
  output [31:0] LO;
  // input list
  input [31:0] A;
  input [31:0] B;
  
  wire [31:0] opposit_A;
  wire [31:0] opposit_B;
  wire [31:0] MULT32_U_In0;
  wire [31:0] MULT32_U_In1;
  wire [31:0] MULT32_U_HI;
  wire [31:0] MULT32_U_LO;
  wire [63:0] opposit_MULT32_U_res;
  wire not_A_msb;
  wire not_B_msb;
  wire and_gate_0;
  wire and_gate_1;
  wire or_gate_0;
  
  
  TWOSCOMP32 TWOSCOMP32_A_inst (opposit_A, A);
  TWOSCOMP32 TWOSCOMP32_B_inst (opposit_B, B);
  
  MUX32_2x1 MUX32_2x1_inst_A (MULT32_U_In0, A, opposit_A, A[31]);
  MUX32_2x1 MUX32_2x1_inst_B (MULT32_U_In1, B, opposit_B, B[31]);
  
  MULT32_U MULT32_U_inst (MULT32_U_HI, MULT32_U_LO, MULT32_U_In0, MULT32_U_In1);
  
  TWOSCOMP64 TWOSCOMP64_inst (opposit_MULT32_U_res, {MULT32_U_HI, MULT32_U_LO});
  
  not not_inst_0 (not_A_msb, A[31]);
  not not_inst_1 (not_B_msb, B[31]);
  and and_gate_0_inst (and_gate_0, A[31], not_B_msb);
  and and_gate_1_inst (and_gate_1, B[31], not_A_msb);
  or or_gate_inst (or_gate_0, and_gate_0, and_gate_1);
  
  MUX32_2x1 MUX32_2x1_inst_LO (LO, MULT32_U_LO, opposit_MULT32_U_res[31:0], or_gate_0);
  MUX32_2x1 MUX32_2x1_inst_HI (HI, MULT32_U_HI, opposit_MULT32_U_res[63:32], or_gate_0);

endmodule

module MULT32_U(HI, LO, A, B);
  // output list
  output [31:0] HI;
  output [31:0] LO;
  // input list
  input [31:0] A;
  input [31:0] B;
  
  wire [31:0] and32_0_out ;
  wire [31:0] and32_1_out ;
  wire [31:0] and32_2_out ;
  wire [31:0] and32_3_out ;
  wire [31:0] and32_4_out ;
  wire [31:0] and32_5_out ;
  wire [31:0] and32_6_out ;
  wire [31:0] and32_7_out ;
  wire [31:0] and32_8_out ;
  wire [31:0] and32_9_out ;
  wire [31:0] and32_10_out;
  wire [31:0] and32_11_out;
  wire [31:0] and32_12_out;
  wire [31:0] and32_13_out;
  wire [31:0] and32_14_out;
  wire [31:0] and32_15_out;
  wire [31:0] and32_16_out;
  wire [31:0] and32_17_out;
  wire [31:0] and32_18_out;
  wire [31:0] and32_19_out;
  wire [31:0] and32_20_out;
  wire [31:0] and32_21_out;
  wire [31:0] and32_22_out;
  wire [31:0] and32_23_out;
  wire [31:0] and32_24_out;
  wire [31:0] and32_25_out;
  wire [31:0] and32_26_out;
  wire [31:0] and32_27_out;
  wire [31:0] and32_28_out;
  wire [31:0] and32_29_out;
  wire [31:0] and32_30_out;
  wire [31:0] and32_31_out;
  
  wire [30:0] co;
  
  wire [31:0] sum_0 ;
  wire [31:0] sum_1 ;
  wire [31:0] sum_2 ;
  wire [31:0] sum_3 ;
  wire [31:0] sum_4 ;
  wire [31:0] sum_5 ;
  wire [31:0] sum_6 ;
  wire [31:0] sum_7 ;
  wire [31:0] sum_8 ;
  wire [31:0] sum_9 ;
  wire [31:0] sum_10;
  wire [31:0] sum_11;
  wire [31:0] sum_12;
  wire [31:0] sum_13;
  wire [31:0] sum_14;
  wire [31:0] sum_15;
  wire [31:0] sum_16;
  wire [31:0] sum_17;
  wire [31:0] sum_18;
  wire [31:0] sum_19;
  wire [31:0] sum_20;
  wire [31:0] sum_21;
  wire [31:0] sum_22;
  wire [31:0] sum_23;
  wire [31:0] sum_24;
  wire [31:0] sum_25;
  wire [31:0] sum_26;
  wire [31:0] sum_27;
  wire [31:0] sum_28;
  wire [31:0] sum_29;
  wire [31:0] sum_30;
  
  
  
  
  AND32_2x1 AND32_2x1_inst_0  (and32_0_out , A, {32{B[0]}});
  AND32_2x1 AND32_2x1_inst_1  (and32_1_out , A, {32{B[1]}});
  AND32_2x1 AND32_2x1_inst_2  (and32_2_out , A, {32{B[2]}});
  AND32_2x1 AND32_2x1_inst_3  (and32_3_out , A, {32{B[3]}});
  AND32_2x1 AND32_2x1_inst_4  (and32_4_out , A, {32{B[4]}});
  AND32_2x1 AND32_2x1_inst_5  (and32_5_out , A, {32{B[5]}});
  AND32_2x1 AND32_2x1_inst_6  (and32_6_out , A, {32{B[6]}});
  AND32_2x1 AND32_2x1_inst_7  (and32_7_out , A, {32{B[7]}});
  AND32_2x1 AND32_2x1_inst_8  (and32_8_out , A, {32{B[8]}});
  AND32_2x1 AND32_2x1_inst_9  (and32_9_out , A, {32{B[9]}});
  AND32_2x1 AND32_2x1_inst_10 (and32_10_out, A, {32{B[10]}});
  AND32_2x1 AND32_2x1_inst_11 (and32_11_out, A, {32{B[11]}});
  AND32_2x1 AND32_2x1_inst_12 (and32_12_out, A, {32{B[12]}});
  AND32_2x1 AND32_2x1_inst_13 (and32_13_out, A, {32{B[13]}});
  AND32_2x1 AND32_2x1_inst_14 (and32_14_out, A, {32{B[14]}});
  AND32_2x1 AND32_2x1_inst_15 (and32_15_out, A, {32{B[15]}});
  AND32_2x1 AND32_2x1_inst_16 (and32_16_out, A, {32{B[16]}});
  AND32_2x1 AND32_2x1_inst_17 (and32_17_out, A, {32{B[17]}});
  AND32_2x1 AND32_2x1_inst_18 (and32_18_out, A, {32{B[18]}});
  AND32_2x1 AND32_2x1_inst_19 (and32_19_out, A, {32{B[19]}});
  AND32_2x1 AND32_2x1_inst_20 (and32_20_out, A, {32{B[20]}});
  AND32_2x1 AND32_2x1_inst_21 (and32_21_out, A, {32{B[21]}});
  AND32_2x1 AND32_2x1_inst_22 (and32_22_out, A, {32{B[22]}});
  AND32_2x1 AND32_2x1_inst_23 (and32_23_out, A, {32{B[23]}});
  AND32_2x1 AND32_2x1_inst_24 (and32_24_out, A, {32{B[24]}});
  AND32_2x1 AND32_2x1_inst_25 (and32_25_out, A, {32{B[25]}});
  AND32_2x1 AND32_2x1_inst_26 (and32_26_out, A, {32{B[26]}});
  AND32_2x1 AND32_2x1_inst_27 (and32_27_out, A, {32{B[27]}});
  AND32_2x1 AND32_2x1_inst_28 (and32_28_out, A, {32{B[28]}});
  AND32_2x1 AND32_2x1_inst_29 (and32_29_out, A, {32{B[29]}});
  AND32_2x1 AND32_2x1_inst_30 (and32_30_out, A, {32{B[30]}});
  AND32_2x1 AND32_2x1_inst_31 (and32_31_out, A, {32{B[31]}});
  
  
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_0  (sum_0 , co[0 ], and32_1_out, {1'b0,and32_0_out[31:1]}, 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_1  (sum_1 , co[1 ], and32_2_out , {co[0 ],sum_0[31:1]} , 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_2  (sum_2 , co[2 ], and32_3_out , {co[1 ],sum_1[31:1]} , 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_3  (sum_3 , co[3 ], and32_4_out , {co[2 ],sum_2[31:1]} , 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_4  (sum_4 , co[4 ], and32_5_out , {co[3 ],sum_3[31:1]} , 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_5  (sum_5 , co[5 ], and32_6_out , {co[4 ],sum_4[31:1]} , 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_6  (sum_6 , co[6 ], and32_7_out , {co[5 ],sum_5[31:1]} , 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_7  (sum_7 , co[7 ], and32_8_out , {co[6 ],sum_6[31:1]} , 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_8  (sum_8 , co[8 ], and32_9_out , {co[7 ],sum_7[31:1]} , 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_9  (sum_9 , co[9 ], and32_10_out, {co[8 ],sum_8[31:1]} , 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_10 (sum_10, co[10], and32_11_out, {co[9 ],sum_9[31:1]} , 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_11 (sum_11, co[11], and32_12_out, {co[10],sum_10[31:1]}, 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_12 (sum_12, co[12], and32_13_out, {co[11],sum_11[31:1]}, 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_13 (sum_13, co[13], and32_14_out, {co[12],sum_12[31:1]}, 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_14 (sum_14, co[14], and32_15_out, {co[13],sum_13[31:1]}, 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_15 (sum_15, co[15], and32_16_out, {co[14],sum_14[31:1]}, 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_16 (sum_16, co[16], and32_17_out, {co[15],sum_15[31:1]}, 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_17 (sum_17, co[17], and32_18_out, {co[16],sum_16[31:1]}, 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_18 (sum_18, co[18], and32_19_out, {co[17],sum_17[31:1]}, 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_19 (sum_19, co[19], and32_20_out, {co[18],sum_18[31:1]}, 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_20 (sum_20, co[20], and32_21_out, {co[19],sum_19[31:1]}, 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_21 (sum_21, co[21], and32_22_out, {co[20],sum_20[31:1]}, 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_22 (sum_22, co[22], and32_23_out, {co[21],sum_21[31:1]}, 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_23 (sum_23, co[23], and32_24_out, {co[22],sum_22[31:1]}, 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_24 (sum_24, co[24], and32_25_out, {co[23],sum_23[31:1]}, 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_25 (sum_25, co[25], and32_26_out, {co[24],sum_24[31:1]}, 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_26 (sum_26, co[26], and32_27_out, {co[25],sum_25[31:1]}, 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_27 (sum_27, co[27], and32_28_out, {co[26],sum_26[31:1]}, 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_28 (sum_28, co[28], and32_29_out, {co[27],sum_27[31:1]}, 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_29 (sum_29, co[29], and32_30_out, {co[28],sum_28[31:1]}, 1'b0);
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst_30 (sum_30, co[30], and32_31_out, {co[29],sum_29[31:1]}, 1'b0);
  
  
  buf buf_inst_0   (LO[0 ],and32_0_out[0]);         
  buf buf_inst_1   (LO[1 ],sum_0[0]); 
  buf buf_inst_2   (LO[2 ],sum_1[0]); 
  buf buf_inst_3   (LO[3 ],sum_2[0]); 
  buf buf_inst_4   (LO[4 ],sum_3[0]); 
  buf buf_inst_5   (LO[5 ],sum_4[0]); 
  buf buf_inst_6   (LO[6 ],sum_5[0]); 
  buf buf_inst_7   (LO[7 ],sum_6[0]);   
  buf buf_inst_8   (LO[8 ],sum_7[0]);         
  buf buf_inst_9   (LO[9 ],sum_8[0]); 
  buf buf_inst_10  (LO[10],sum_9[0]); 
  buf buf_inst_11  (LO[11],sum_10[0]); 
  buf buf_inst_12  (LO[12],sum_11[0]); 
  buf buf_inst_13  (LO[13],sum_12[0]); 
  buf buf_inst_14  (LO[14],sum_13[0]); 
  buf buf_inst_15  (LO[15],sum_14[0]); 
  buf buf_inst_16  (LO[16],sum_15[0]);         
  buf buf_inst_17  (LO[17],sum_16[0]); 
  buf buf_inst_18  (LO[18],sum_17[0]); 
  buf buf_inst_19  (LO[19],sum_18[0]); 
  buf buf_inst_20  (LO[20],sum_19[0]); 
  buf buf_inst_21  (LO[21],sum_20[0]); 
  buf buf_inst_22  (LO[22],sum_21[0]); 
  buf buf_inst_23  (LO[23],sum_22[0]); 
  buf buf_inst_24  (LO[24],sum_23[0]);         
  buf buf_inst_25  (LO[25],sum_24[0]); 
  buf buf_inst_26  (LO[26],sum_25[0]); 
  buf buf_inst_27  (LO[27],sum_26[0]); 
  buf buf_inst_28  (LO[28],sum_27[0]); 
  buf buf_inst_29  (LO[29],sum_28[0]); 
  buf buf_inst_30  (LO[30],sum_29[0]); 
  buf buf_inst_31  (LO[31],sum_30[0]); 
  buf buf_inst_32  (HI[0 ],sum_30[1 ]);         
  buf buf_inst_33  (HI[1 ],sum_30[2 ]); 
  buf buf_inst_34  (HI[2 ],sum_30[3 ]); 
  buf buf_inst_35  (HI[3 ],sum_30[4 ]); 
  buf buf_inst_36  (HI[4 ],sum_30[5 ]); 
  buf buf_inst_37  (HI[5 ],sum_30[6 ]); 
  buf buf_inst_38  (HI[6 ],sum_30[7 ]); 
  buf buf_inst_39  (HI[7 ],sum_30[8 ]); 
  buf buf_inst_40  (HI[8 ],sum_30[9 ]);         
  buf buf_inst_41  (HI[9 ],sum_30[10]); 
  buf buf_inst_42  (HI[10],sum_30[11]); 
  buf buf_inst_43  (HI[11],sum_30[12]); 
  buf buf_inst_44  (HI[12],sum_30[13]); 
  buf buf_inst_45  (HI[13],sum_30[14]); 
  buf buf_inst_46  (HI[14],sum_30[15]); 
  buf buf_inst_47  (HI[15],sum_30[16]); 
  buf buf_inst_48  (HI[16],sum_30[17]);         
  buf buf_inst_49  (HI[17],sum_30[18]); 
  buf buf_inst_50  (HI[18],sum_30[19]); 
  buf buf_inst_51  (HI[19],sum_30[20]); 
  buf buf_inst_52  (HI[20],sum_30[21]); 
  buf buf_inst_53  (HI[21],sum_30[22]); 
  buf buf_inst_54  (HI[22],sum_30[23]); 
  buf buf_inst_55  (HI[23],sum_30[24]); 
  buf buf_inst_56  (HI[24],sum_30[25]);         
  buf buf_inst_57  (HI[25],sum_30[26]); 
  buf buf_inst_58  (HI[26],sum_30[27]); 
  buf buf_inst_59  (HI[27],sum_30[28]); 
  buf buf_inst_60  (HI[28],sum_30[29]); 
  buf buf_inst_61  (HI[29],sum_30[30]); 
  buf buf_inst_62  (HI[30],sum_30[31]); 
  buf buf_inst_63  (HI[31],co[30]);                                                              
endmodule

module TWOSCOMP32(Y,A);
  // Output list
  output [31:0] Y;
  // Input list
  input [31:0] A;
  
  wire [31:0] notA;
  wire carry;
  
  // Invert A
  genvar i;
  generate
      for (i = 0; i < 32; i = i + 1) begin: not_loop
          not not_inst (notA[i], A[i]);
      end
  endgenerate
  
  // Add 1 using a rippl
  RC_ADD_SUB_32 adder(Y, carry, notA, 32'b1, 1'b0);

endmodule


module TWOSCOMP64(Y,A);

  output [63:0] Y;
  // Input list
  input [63:0] A;
  
  wire [63:0] notA;
  wire carry;
  
  
  genvar i;
  generate
      for (i = 0; i < 64; i = i + 1) begin: not_loop
          not not_inst (notA[i], A[i]);
      end
  endgenerate
  
  // Add 1 using a ripple carry adder
  RC_ADD_SUB_64 adder(Y, carry, notA, 64'b1, 1'b0);

endmodule

// 32-bit mux
module MUX32_2x1(Y, I0, I1, S);
  // output list
  output [31:0] Y;
  //input list
  input [31:0] I0;
  input [31:0] I1;
  input S;
  
  genvar i;
  generate 
      for (i=0; i<32; i=i+1)
      begin : MUX1_2x1_gen_loop
          MUX1_2x1 MUX1_2x1_inst (Y[i],I0[i], I1[i], S);
      end
endgenerate

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

// ======================================
// 32-bit AND Gate (Pure Gate-Level Modeling)
// ======================================
module AND32_2x1(output [31:0] Y, input [31:0] A, input [31:0] B);
  genvar i;
  generate
    for (i = 0; i < 32; i = i + 1) begin: and_gate
      and and_inst (Y[i], A[i], B[i]);  // Using primitive AND gate
    end
  endgenerate
endmodule

module RC_ADD_SUB_32(Y, CO, A, B, SnA);
  output [31:0] Y;
  output CO;
    
  // Input list
  input [31:0] A;
  input [31:0] B;
  input SnA;
    
  // Internal wires
  wire [31:0] B_xor;   // B ⊕ SnA
  wire [31:0] C;       // Carry chain

  genvar i;
  generate
    for (i = 0; i <= 31; i = i + 1) begin: xor_B
          xor xor_inst (B_xor[i], B[i], SnA);
      end
  endgenerate


  FULL_ADDER FA_0(Y[0], C[0], A[0], B_xor[0], SnA);
    
  generate
    for (i = 1; i <= 31; i = i + 1) begin: adders
        FULL_ADDER FA(Y[i], C[i], A[i], B_xor[i], C[i-1]);
    end
  endgenerate

  // Replace 'assign' with a buffer to model CO output
  buf (CO, C[31]); 

endmodule


// adding sub 64

module RC_ADD_SUB_64(SUM, COUT, A, B, SUB);
  output [63:0] SUM;
  output COUT;
  input [63:0] A, B;
  input SUB;

  wire [63:0] B_in;
  wire [63:0] carry;

  // XOR each bit of B with SUB
  genvar i;
  generate
    for (i = 0; i < 64; i = i + 1) begin: twos_comp
      xor xor_inst (B_in[i], B[i], SUB);
    end
  endgenerate


  FULL_ADDER FA0(SUM[0], carry[0], A[0], B_in[0], SUB);

  generate
    for (i = 1; i < 64; i = i + 1) begin: rca_loop
      FULL_ADDER FA(SUM[i], carry[i], A[i], B_in[i], carry[i-1]);
    end
  endgenerate

  // Replace 'assign' with a buffer to model COUT output
  buf (COUT, carry[63]);

endmodule

module FULL_ADDER(S, CO, A, B, CI);
    output S, CO;
    input A, B, CI;

    // Internal signals
    wire sum1, c1, c2;


    HALF_ADDER HA1(sum1, c1, A, B);
    HALF_ADDER HA2(S, c2, sum1, CI);
    or (CO, c1, c2);  // Carry out calculation the ore i put can get for fianl carry out
endmodule

module HALF_ADDER(Y, C, A, B);  // Changed SUM → Y and COUT → C to match testbench
    output Y, C;
    input A, B;

    // Gate level modelng usig  
    xor (Y, A, B);   // SUM = A ⊕ B
    and (C, A, B);   // C = A & B
endmodule

