// 32-bit 16x1 mux
module MUX32_16x1(Y, I0, I1, I2, I3, I4, I5, I6, I7,
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

wire [31:0] MUX32_8x1_0_Y;
wire [31:0] MUX32_8x1_1_Y;

MUX32_2x1 MUX32_2x1_inst (Y, MUX32_8x1_0_Y, MUX32_8x1_1_Y, S[3]);
MUX32_8x1 MUX32_8x1_0_inst (MUX32_8x1_0_Y, I0, I1, I2, I3, I4, I5, I6, I7, S[2:0]);
MUX32_8x1 MUX32_8x1_1_inst (MUX32_8x1_1_Y, I8, I9, I10, I11, I12, I13, I14, I15, S[2:0]);

endmodule

// 32-bit 8x1 mux
module MUX32_8x1(Y, I0, I1, I2, I3, I4, I5, I6, I7, S);
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

wire [31:0] MUX32_4x1_0_Y;
wire [31:0] MUX32_4x1_1_Y;

MUX32_2x1 MUX32_2x1_inst (Y, MUX32_4x1_0_Y, MUX32_4x1_1_Y, S[2]);
MUX32_4x1 MUX32_4x1_0_inst (MUX32_4x1_0_Y, I0, I1, I2, I3, S[1:0]);
MUX32_4x1 MUX32_4x1_1_inst (MUX32_4x1_1_Y, I4, I5, I6, I7, S[1:0]);

endmodule

// 32-bit 4x1 mux
module MUX32_4x1(Y, I0, I1, I2, I3, S);
// output list
output [31:0] Y;
//input list
input [31:0] I0;
input [31:0] I1;
input [31:0] I2;
input [31:0] I3;
input [1:0] S;

wire [31:0] MUX32_2x1_S1_I0;
wire [31:0] MUX32_2x1_S1_I1;

MUX32_2x1 MUX32_2x1_S1 (Y, MUX32_2x1_S1_I0, MUX32_2x1_S1_I1, S[1]);
MUX32_2x1 MUX32_2x1_S0_0 (MUX32_2x1_S1_I0, I0, I1, S[0]);
MUX32_2x1 MUX32_2x1_S0_1 (MUX32_2x1_S1_I1, I2, I3, S[0]);

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
// 32-bit NOR Gate (Pure Gate-Level Modeling)
// ======================================
module NOR32_2x1(output [31:0] Y, input [31:0] A, input [31:0] B);
  genvar i;
  generate
    for (i = 0; i < 32; i = i + 1) begin: nor_gate
      nor nor_inst (Y[i], A[i], B[i]);  // Using primitive NOR gate
    end
  endgenerate
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

// ======================================
// 32-bit Inverter (NOT Gate) (Pure Gate-Level Modeling)
// ======================================
module INV32_1x1(output [31:0] Y, input [31:0] A);
  genvar i;
  generate
    for (i = 0; i < 32; i = i + 1) begin: inv_gate
      not not_inst (Y[i], A[i]);  // Using primitive NOT gate
    end
  endgenerate
endmodule

// ======================================
// 32-bit OR Gate (Pure Gate-Level Modeling)
// ======================================
module OR32_2x1(output [31:0] Y, input [31:0] A, input [31:0] B);
  genvar i;
  generate
    for (i = 0; i < 32; i = i + 1) begin: or_gate
      or or_inst (Y[i], A[i], B[i]);  // Using primitive OR gate
    end
  endgenerate
endmodule

// 32-bit shift amount shifter
module SHIFT32(Y,D,S, LnR);
// output list
output [31:0] Y;
// input list
input [31:0] D;
input [31:0] S;
input LnR;

wire or_S_31_5;
wire [31:0] BARREL_SHIFTER32_Y;

or or_inst (or_S_31_5, S[31], S[30], S[29], S[28], S[27], S[26], S[25], S[24], S[23], S[22], S[21], S[20], S[19], S[18], S[17], S[16], S[15], S[14], S[13], S[12], S[11], S[10], S[9], S[8], S[7], S[6], S[5]);

BARREL_SHIFTER32 BARREL_SHIFTER32_inst (BARREL_SHIFTER32_Y,D,S[4:0],LnR);

MUX32_2x1 MUX32_2x1_inst (Y, BARREL_SHIFTER32_Y, 32'd0, or_S_31_5);

endmodule

// Shift with control L or R shift
module BARREL_SHIFTER32(Y,D,S, LnR);
// output list
output [31:0] Y;
// input list
input [31:0] D;
input [4:0] S;
input LnR;

wire [31:0] SHIFT32_R_Y;
wire [31:0] SHIFT32_L_Y;

SHIFT32_R SHIFT32_R_inst (SHIFT32_R_Y,D,S);
SHIFT32_L SHIFT32_L_inst (SHIFT32_L_Y,D,S);

MUX32_2x1 MUX32_2x1_inst (Y, SHIFT32_R_Y, SHIFT32_L_Y, LnR);


endmodule

// Right shifter
module SHIFT32_R(Y,D,S);
// output list
output [31:0] Y;
// input list
input [31:0] D;
input [4:0] S;

wire [31:0] MUX1_2x1_S0_Y ;
wire [31:0] MUX1_2x1_S0_I0 ;
wire [31:0] MUX1_2x1_S0_I1 ;
wire [31:0] MUX1_2x1_S1_Y ;
wire [31:0] MUX1_2x1_S1_I0 ;
wire [31:0] MUX1_2x1_S1_I1 ;
wire [31:0] MUX1_2x1_S2_Y ;
wire [31:0] MUX1_2x1_S2_I0 ;
wire [31:0] MUX1_2x1_S2_I1 ;
wire [31:0] MUX1_2x1_S3_Y ;
wire [31:0] MUX1_2x1_S3_I0 ;
wire [31:0] MUX1_2x1_S3_I1 ;
wire [31:0] MUX1_2x1_S4_Y ;
wire [31:0] MUX1_2x1_S4_I0 ;
wire [31:0] MUX1_2x1_S4_I1 ;

genvar i;
generate 
    for (i=0; i<32; i=i+1)
    begin : MUX1_2x1_S0_gen_loop
        MUX1_2x1 MUX1_2x1_S0_inst  (MUX1_2x1_S0_Y[i ],MUX1_2x1_S0_I0[i ], MUX1_2x1_S0_I1[i], S[0]);
    end
endgenerate

generate 
    for (i=0; i<32; i=i+1)
    begin : MUX1_2x1_S1_gen_loop
        MUX1_2x1 MUX1_2x1_S1_inst  (MUX1_2x1_S1_Y[i ],MUX1_2x1_S1_I0[i ], MUX1_2x1_S1_I1[i], S[1]);
    end
endgenerate

generate 
    for (i=0; i<32; i=i+1)
    begin : MUX1_2x1_S2_gen_loop
        MUX1_2x1 MUX1_2x1_S2_inst  (MUX1_2x1_S2_Y[i ],MUX1_2x1_S2_I0[i ], MUX1_2x1_S2_I1[i], S[2]);
    end
endgenerate

generate 
    for (i=0; i<32; i=i+1)
    begin : MUX1_2x1_S3_gen_loop
        MUX1_2x1 MUX1_2x1_S3_inst  (MUX1_2x1_S3_Y[i ],MUX1_2x1_S3_I0[i ], MUX1_2x1_S3_I1[i], S[3]);
    end
endgenerate

generate 
    for (i=0; i<32; i=i+1)
    begin : MUX1_2x1_S4_gen_loop
        MUX1_2x1 MUX1_2x1_S4_inst  (MUX1_2x1_S4_Y[i ],MUX1_2x1_S4_I0[i ], MUX1_2x1_S4_I1[i], S[4]);
    end
endgenerate

generate 
    for (i=0; i<32; i=i+1)
    begin : buf_S0_I0_gen_loop
        buf buf_S0_I0_inst (MUX1_2x1_S0_I0[i] , D[i]);
    end
endgenerate


buf buf_S0_I1_inst_31  (MUX1_2x1_S0_I1[31] , 1'b0);
generate 
    for (i=30; i>=0; i=i-1)
    begin : buf_S0_I1_gen_loop
        buf buf_S0_I1_inst  (MUX1_2x1_S0_I1[i] , D[i+1]);
    end
endgenerate

generate 
    for (i=0; i<32; i=i+1)
    begin : buf_S1_I0_gen_loop
        buf buf_S1_I0_inst (MUX1_2x1_S1_I0[i] , MUX1_2x1_S0_Y[i]);
    end
endgenerate

buf buf_S1_I1_inst_31  (MUX1_2x1_S1_I1[31] , 1'b0);
buf buf_S1_I1_inst_30  (MUX1_2x1_S1_I1[30] , 1'b0);
generate 
    for (i=29; i>=0; i=i-1)
    begin : buf_S1_I1_gen_loop
        buf buf_S1_I1_inst  (MUX1_2x1_S1_I1[i] , MUX1_2x1_S0_Y[i+2])  ;
    end
endgenerate

generate 
    for (i=0; i<32; i=i+1)
    begin : buf_S2_I0_gen_loop
        buf buf_S2_I0_inst (MUX1_2x1_S2_I0[i] , MUX1_2x1_S1_Y[i]);
    end
endgenerate

buf buf_S2_I1_inst_31  (MUX1_2x1_S2_I1[31] , 1'b0);
buf buf_S2_I1_inst_30  (MUX1_2x1_S2_I1[30] , 1'b0);
buf buf_S2_I1_inst_29  (MUX1_2x1_S2_I1[29] , 1'b0);
buf buf_S2_I1_inst_28  (MUX1_2x1_S2_I1[28] , 1'b0);
generate 
    for (i=27; i>=0; i=i-1)
    begin : buf_S2_I1_gen_loop
        buf buf_S2_I1_inst  (MUX1_2x1_S2_I1[i] , MUX1_2x1_S1_Y[i+4])  ;
    end
endgenerate


generate 
    for (i=0; i<32; i=i+1)
    begin : buf_S3_I0_gen_loop
        buf buf_S3_I0_inst (MUX1_2x1_S3_I0[i] , MUX1_2x1_S2_Y[i]);
    end
endgenerate

buf buf_S3_I1_inst_31  (MUX1_2x1_S3_I1[31] , 1'b0);
buf buf_S3_I1_inst_30  (MUX1_2x1_S3_I1[30] , 1'b0);
buf buf_S3_I1_inst_29  (MUX1_2x1_S3_I1[29] , 1'b0);
buf buf_S3_I1_inst_28  (MUX1_2x1_S3_I1[28] , 1'b0);
buf buf_S3_I1_inst_27  (MUX1_2x1_S3_I1[27] , 1'b0);
buf buf_S3_I1_inst_26  (MUX1_2x1_S3_I1[26] , 1'b0);
buf buf_S3_I1_inst_25  (MUX1_2x1_S3_I1[25] , 1'b0);
buf buf_S3_I1_inst_24  (MUX1_2x1_S3_I1[24] , 1'b0);
generate 
    for (i=23; i>=0; i=i-1)
    begin : buf_S3_I1_gen_loop
        buf buf_S3_I1_inst  (MUX1_2x1_S3_I1[i] , MUX1_2x1_S2_Y[i+8])  ;
    end
endgenerate


generate 
    for (i=0; i<32; i=i+1)
    begin : buf_S4_I0_gen_loop
        buf buf_S4_I0_inst (MUX1_2x1_S4_I0[i] , MUX1_2x1_S3_Y[i]);
    end
endgenerate

buf buf_S4_I1_inst_31   (MUX1_2x1_S4_I1[31] , 1'b0);
buf buf_S4_I1_inst_30   (MUX1_2x1_S4_I1[30] , 1'b0);
buf buf_S4_I1_inst_29   (MUX1_2x1_S4_I1[29] , 1'b0);
buf buf_S4_I1_inst_28   (MUX1_2x1_S4_I1[28] , 1'b0);
buf buf_S4_I1_inst_27   (MUX1_2x1_S4_I1[27] , 1'b0);
buf buf_S4_I1_inst_26   (MUX1_2x1_S4_I1[26] , 1'b0);
buf buf_S4_I1_inst_25   (MUX1_2x1_S4_I1[25] , 1'b0);
buf buf_S4_I1_inst_24   (MUX1_2x1_S4_I1[24] , 1'b0);
buf buf_S4_I1_inst_23   (MUX1_2x1_S4_I1[23] , 1'b0);
buf buf_S4_I1_inst_22   (MUX1_2x1_S4_I1[22] , 1'b0);
buf buf_S4_I1_inst_21   (MUX1_2x1_S4_I1[21] , 1'b0);
buf buf_S4_I1_inst_20   (MUX1_2x1_S4_I1[20] , 1'b0);
buf buf_S4_I1_inst_19   (MUX1_2x1_S4_I1[19] , 1'b0);
buf buf_S4_I1_inst_18   (MUX1_2x1_S4_I1[18] , 1'b0);
buf buf_S4_I1_inst_17   (MUX1_2x1_S4_I1[17] , 1'b0);
buf buf_S4_I1_inst_16   (MUX1_2x1_S4_I1[16] , 1'b0);
generate 
    for (i=15; i>=0; i=i-1)
    begin : buf_S4_I1_gen_loop
        buf buf_S4_I1_inst  (MUX1_2x1_S4_I1[i] , MUX1_2x1_S3_Y[i+16])  ;
    end
endgenerate


buf buf_Y_0_inst  (Y[0] , MUX1_2x1_S4_Y[0])  ; 
buf buf_Y_1_inst  (Y[1] , MUX1_2x1_S4_Y[1])  ; 
buf buf_Y_2_inst  (Y[2] , MUX1_2x1_S4_Y[2])  ; 
buf buf_Y_3_inst  (Y[3] , MUX1_2x1_S4_Y[3])  ; 
buf buf_Y_4_inst  (Y[4] , MUX1_2x1_S4_Y[4])  ; 
buf buf_Y_5_inst  (Y[5] , MUX1_2x1_S4_Y[5])  ; 
buf buf_Y_6_inst  (Y[6] , MUX1_2x1_S4_Y[6])  ; 
buf buf_Y_7_inst  (Y[7] , MUX1_2x1_S4_Y[7])  ; 
buf buf_Y_8_inst  (Y[8] , MUX1_2x1_S4_Y[8])  ; 
buf buf_Y_9_inst  (Y[9] , MUX1_2x1_S4_Y[9])  ; 
buf buf_Y_10_inst (Y[10], MUX1_2x1_S4_Y[10]); 
buf buf_Y_11_inst (Y[11], MUX1_2x1_S4_Y[11]); 
buf buf_Y_12_inst (Y[12], MUX1_2x1_S4_Y[12]); 
buf buf_Y_13_inst (Y[13], MUX1_2x1_S4_Y[13]); 
buf buf_Y_14_inst (Y[14], MUX1_2x1_S4_Y[14]); 
buf buf_Y_15_inst (Y[15], MUX1_2x1_S4_Y[15]); 
buf buf_Y_16_inst (Y[16], MUX1_2x1_S4_Y[16]); 
buf buf_Y_17_inst (Y[17], MUX1_2x1_S4_Y[17]); 
buf buf_Y_18_inst (Y[18], MUX1_2x1_S4_Y[18]); 
buf buf_Y_19_inst (Y[19], MUX1_2x1_S4_Y[19]); 
buf buf_Y_20_inst (Y[20], MUX1_2x1_S4_Y[20]); 
buf buf_Y_21_inst (Y[21], MUX1_2x1_S4_Y[21]); 
buf buf_Y_22_inst (Y[22], MUX1_2x1_S4_Y[22]); 
buf buf_Y_23_inst (Y[23], MUX1_2x1_S4_Y[23]); 
buf buf_Y_24_inst (Y[24], MUX1_2x1_S4_Y[24]); 
buf buf_Y_25_inst (Y[25], MUX1_2x1_S4_Y[25]); 
buf buf_Y_26_inst (Y[26], MUX1_2x1_S4_Y[26]); 
buf buf_Y_27_inst (Y[27], MUX1_2x1_S4_Y[27]); 
buf buf_Y_28_inst (Y[28], MUX1_2x1_S4_Y[28]); 
buf buf_Y_29_inst (Y[29], MUX1_2x1_S4_Y[29]); 
buf buf_Y_30_inst (Y[30], MUX1_2x1_S4_Y[30]); 
buf buf_Y_31_inst (Y[31], MUX1_2x1_S4_Y[31]); 


endmodule

// Left shifter
module SHIFT32_L(Y,D,S);
// output list
output [31:0] Y;
// input list
input [31:0] D;
input [4:0] S;


wire [31:0] MUX1_2x1_S0_Y ;
wire [31:0] MUX1_2x1_S0_I0 ;
wire [31:0] MUX1_2x1_S0_I1 ;
wire [31:0] MUX1_2x1_S1_Y ;
wire [31:0] MUX1_2x1_S1_I0 ;
wire [31:0] MUX1_2x1_S1_I1 ;
wire [31:0] MUX1_2x1_S2_Y ;
wire [31:0] MUX1_2x1_S2_I0 ;
wire [31:0] MUX1_2x1_S2_I1 ;
wire [31:0] MUX1_2x1_S3_Y ;
wire [31:0] MUX1_2x1_S3_I0 ;
wire [31:0] MUX1_2x1_S3_I1 ;
wire [31:0] MUX1_2x1_S4_Y ;
wire [31:0] MUX1_2x1_S4_I0 ;
wire [31:0] MUX1_2x1_S4_I1 ;

genvar i;
generate 
    for (i=0; i<32; i=i+1)
    begin : MUX1_2x1_S0_gen_loop
        MUX1_2x1 MUX1_2x1_S0_inst  (MUX1_2x1_S0_Y[i ],MUX1_2x1_S0_I0[i ], MUX1_2x1_S0_I1[i], S[0]);
    end
endgenerate

generate 
    for (i=0; i<32; i=i+1)
    begin : MUX1_2x1_S1_gen_loop
        MUX1_2x1 MUX1_2x1_S1_inst  (MUX1_2x1_S1_Y[i ],MUX1_2x1_S1_I0[i ], MUX1_2x1_S1_I1[i], S[1]);
    end
endgenerate

generate 
    for (i=0; i<32; i=i+1)
    begin : MUX1_2x1_S2_gen_loop
        MUX1_2x1 MUX1_2x1_S2_inst  (MUX1_2x1_S2_Y[i ],MUX1_2x1_S2_I0[i ], MUX1_2x1_S2_I1[i], S[2]);
    end
endgenerate

generate 
    for (i=0; i<32; i=i+1)
    begin : MUX1_2x1_S3_gen_loop
        MUX1_2x1 MUX1_2x1_S3_inst  (MUX1_2x1_S3_Y[i ],MUX1_2x1_S3_I0[i ], MUX1_2x1_S3_I1[i], S[3]);
    end
endgenerate

generate 
    for (i=0; i<32; i=i+1)
    begin : MUX1_2x1_S4_gen_loop
        MUX1_2x1 MUX1_2x1_S4_inst  (MUX1_2x1_S4_Y[i ],MUX1_2x1_S4_I0[i ], MUX1_2x1_S4_I1[i], S[4]);
    end
endgenerate

generate 
    for (i=0; i<32; i=i+1)
    begin : buf_S0_I0_gen_loop
        buf buf_S0_I0_inst (MUX1_2x1_S0_I0[i] , D[i]);
    end
endgenerate


buf buf_S0_I1_inst_0  (MUX1_2x1_S0_I1[0] , 1'b0);
generate 
    for (i=1; i<32; i=i+1)
    begin : buf_S0_I1_gen_loop
        buf buf_S0_I1_inst  (MUX1_2x1_S0_I1[i] , D[i-1]);
    end
endgenerate

generate 
    for (i=0; i<32; i=i+1)
    begin : buf_S1_I0_gen_loop
        buf buf_S1_I0_inst (MUX1_2x1_S1_I0[i] , MUX1_2x1_S0_Y[i]);
    end
endgenerate

buf buf_S1_I1_inst_0  (MUX1_2x1_S1_I1[0] , 1'b0);
buf buf_S1_I1_inst_1  (MUX1_2x1_S1_I1[1] , 1'b0);
generate 
    for (i=2; i<32; i=i+1)
    begin : buf_S1_I1_gen_loop
        buf buf_S1_I1_inst  (MUX1_2x1_S1_I1[i] , MUX1_2x1_S0_Y[i-2])  ;
    end
endgenerate

generate 
    for (i=0; i<32; i=i+1)
    begin : buf_S2_I0_gen_loop
        buf buf_S2_I0_inst (MUX1_2x1_S2_I0[i] , MUX1_2x1_S1_Y[i]);
    end
endgenerate

buf buf_S2_I1_inst_0  (MUX1_2x1_S2_I1[0] , 1'b0);
buf buf_S2_I1_inst_1  (MUX1_2x1_S2_I1[1] , 1'b0);
buf buf_S2_I1_inst_2  (MUX1_2x1_S2_I1[2] , 1'b0);
buf buf_S2_I1_inst_3  (MUX1_2x1_S2_I1[3] , 1'b0);
generate 
    for (i=4; i<32; i=i+1)
    begin : buf_S2_I1_gen_loop
        buf buf_S2_I1_inst  (MUX1_2x1_S2_I1[i] , MUX1_2x1_S1_Y[i-4])  ;
    end
endgenerate


generate 
    for (i=0; i<32; i=i+1)
    begin : buf_S3_I0_gen_loop
        buf buf_S3_I0_inst (MUX1_2x1_S3_I0[i] , MUX1_2x1_S2_Y[i]);
    end
endgenerate

buf buf_S3_I1_inst_0  (MUX1_2x1_S3_I1[0] , 1'b0);
buf buf_S3_I1_inst_1  (MUX1_2x1_S3_I1[1] , 1'b0);
buf buf_S3_I1_inst_2  (MUX1_2x1_S3_I1[2] , 1'b0);
buf buf_S3_I1_inst_3  (MUX1_2x1_S3_I1[3] , 1'b0);
buf buf_S3_I1_inst_4  (MUX1_2x1_S3_I1[4] , 1'b0);
buf buf_S3_I1_inst_5  (MUX1_2x1_S3_I1[5] , 1'b0);
buf buf_S3_I1_inst_6  (MUX1_2x1_S3_I1[6] , 1'b0);
buf buf_S3_I1_inst_7  (MUX1_2x1_S3_I1[7] , 1'b0);
generate 
    for (i=8; i<32; i=i+1)
    begin : buf_S3_I1_gen_loop
        buf buf_S3_I1_inst  (MUX1_2x1_S3_I1[i] , MUX1_2x1_S2_Y[i-8])  ;
    end
endgenerate


generate 
    for (i=0; i<32; i=i+1)
    begin : buf_S4_I0_gen_loop
        buf buf_S4_I0_inst (MUX1_2x1_S4_I0[i] , MUX1_2x1_S3_Y[i]);
    end
endgenerate

buf buf_S4_I1_inst_0   (MUX1_2x1_S4_I1[0] , 1'b0);
buf buf_S4_I1_inst_1   (MUX1_2x1_S4_I1[1] , 1'b0);
buf buf_S4_I1_inst_2   (MUX1_2x1_S4_I1[2] , 1'b0);
buf buf_S4_I1_inst_3   (MUX1_2x1_S4_I1[3] , 1'b0);
buf buf_S4_I1_inst_4   (MUX1_2x1_S4_I1[4] , 1'b0);
buf buf_S4_I1_inst_5   (MUX1_2x1_S4_I1[5] , 1'b0);
buf buf_S4_I1_inst_6   (MUX1_2x1_S4_I1[6] , 1'b0);
buf buf_S4_I1_inst_7   (MUX1_2x1_S4_I1[7] , 1'b0);
buf buf_S4_I1_inst_8   (MUX1_2x1_S4_I1[8] , 1'b0);
buf buf_S4_I1_inst_9   (MUX1_2x1_S4_I1[9] , 1'b0);
buf buf_S4_I1_inst_10  (MUX1_2x1_S4_I1[10] , 1'b0);
buf buf_S4_I1_inst_11  (MUX1_2x1_S4_I1[11] , 1'b0);
buf buf_S4_I1_inst_12  (MUX1_2x1_S4_I1[12] , 1'b0);
buf buf_S4_I1_inst_13  (MUX1_2x1_S4_I1[13] , 1'b0);
buf buf_S4_I1_inst_14  (MUX1_2x1_S4_I1[14] , 1'b0);
buf buf_S4_I1_inst_15  (MUX1_2x1_S4_I1[15] , 1'b0);
generate 
    for (i=16; i<32; i=i+1)
    begin : buf_S4_I1_gen_loop
        buf buf_S4_I1_inst  (MUX1_2x1_S4_I1[i] , MUX1_2x1_S3_Y[i-16])  ;
    end
endgenerate


buf buf_Y_0_inst  (Y[0] , MUX1_2x1_S4_Y[0])  ; 
buf buf_Y_1_inst  (Y[1] , MUX1_2x1_S4_Y[1])  ; 
buf buf_Y_2_inst  (Y[2] , MUX1_2x1_S4_Y[2])  ; 
buf buf_Y_3_inst  (Y[3] , MUX1_2x1_S4_Y[3])  ; 
buf buf_Y_4_inst  (Y[4] , MUX1_2x1_S4_Y[4])  ; 
buf buf_Y_5_inst  (Y[5] , MUX1_2x1_S4_Y[5])  ; 
buf buf_Y_6_inst  (Y[6] , MUX1_2x1_S4_Y[6])  ; 
buf buf_Y_7_inst  (Y[7] , MUX1_2x1_S4_Y[7])  ; 
buf buf_Y_8_inst  (Y[8] , MUX1_2x1_S4_Y[8])  ; 
buf buf_Y_9_inst  (Y[9] , MUX1_2x1_S4_Y[9])  ; 
buf buf_Y_10_inst (Y[10], MUX1_2x1_S4_Y[10]); 
buf buf_Y_11_inst (Y[11], MUX1_2x1_S4_Y[11]); 
buf buf_Y_12_inst (Y[12], MUX1_2x1_S4_Y[12]); 
buf buf_Y_13_inst (Y[13], MUX1_2x1_S4_Y[13]); 
buf buf_Y_14_inst (Y[14], MUX1_2x1_S4_Y[14]); 
buf buf_Y_15_inst (Y[15], MUX1_2x1_S4_Y[15]); 
buf buf_Y_16_inst (Y[16], MUX1_2x1_S4_Y[16]); 
buf buf_Y_17_inst (Y[17], MUX1_2x1_S4_Y[17]); 
buf buf_Y_18_inst (Y[18], MUX1_2x1_S4_Y[18]); 
buf buf_Y_19_inst (Y[19], MUX1_2x1_S4_Y[19]); 
buf buf_Y_20_inst (Y[20], MUX1_2x1_S4_Y[20]); 
buf buf_Y_21_inst (Y[21], MUX1_2x1_S4_Y[21]); 
buf buf_Y_22_inst (Y[22], MUX1_2x1_S4_Y[22]); 
buf buf_Y_23_inst (Y[23], MUX1_2x1_S4_Y[23]); 
buf buf_Y_24_inst (Y[24], MUX1_2x1_S4_Y[24]); 
buf buf_Y_25_inst (Y[25], MUX1_2x1_S4_Y[25]); 
buf buf_Y_26_inst (Y[26], MUX1_2x1_S4_Y[26]); 
buf buf_Y_27_inst (Y[27], MUX1_2x1_S4_Y[27]); 
buf buf_Y_28_inst (Y[28], MUX1_2x1_S4_Y[28]); 
buf buf_Y_29_inst (Y[29], MUX1_2x1_S4_Y[29]); 
buf buf_Y_30_inst (Y[30], MUX1_2x1_S4_Y[30]); 
buf buf_Y_31_inst (Y[31], MUX1_2x1_S4_Y[31]); 

endmodule
