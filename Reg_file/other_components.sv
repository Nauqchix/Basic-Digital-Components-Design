// 32-bit registere +ve edge, Reset on RESET=0
module REG32(Q, D, LOAD, CLK, RESET);
output [31:0] Q;

input CLK, LOAD;
input [31:0] D;
input RESET;

parameter [31:0] P_RST_VAL = 32'd0;

genvar i;
generate
    for (i = 0; i < 32; i = i + 1) begin: not_loop
	    if (P_RST_VAL[i] == 1'b0)
            REG1 REG1_inst(Q[i], , D[i], LOAD, CLK, 1'b1, RESET);
	    else
		    REG1 REG1_inst(Q[i], , D[i], LOAD, CLK, RESET, 1'b1);
    end
endgenerate

endmodule


// 1 bit register +ve edge, 
// Preset on nP=0, nR=1, reset on nP=1, nR=0;
// Undefined nP=0, nR=0
// normal operation nP=1, nR=1
module REG1(Q, Qbar, D, L, C, nP, nR);
input D, C, L;
input nP, nR;
output Q,Qbar;

wire mux_out;

MUX1_2x1 MUX1_2x1_inst (mux_out, Q, D, L);
D_FF D_FF_inst (Q, Qbar, mux_out, C, nP, nR);

endmodule

// 1 bit flipflop +ve edge, 
// Preset on nP=0, nR=1, reset on nP=1, nR=0;
// Undefined nP=0, nR=0
// normal operation nP=1, nR=1
module D_FF(Q, Qbar, D, C, nP, nR);
input D, C;
input nP, nR;
output Q,Qbar;

wire D_LATCH_Q;
wire D_LATCH_Qbar;
wire not_c;

not not_c_inst (not_c, C);

D_LATCH D_LATCH_inst (D_LATCH_Q, D_LATCH_Qbar, D, not_c, nP, nR);
SR_LATCH SR_LATCH (Q, Qbar, D_LATCH_Q, D_LATCH_Qbar, C, nP, nR);

endmodule

// 1 bit D latch
// Preset on nP=0, nR=1, reset on nP=1, nR=0;
// Undefined nP=0, nR=0
// normal operation nP=1, nR=1
module D_LATCH(Q, Qbar, D, C, nP, nR);
input D, C;
input nP, nR;
output Q,Qbar;

wire not_d;
wire nand_d_c;
wire nand_not_d_c;

not not_d_inst (not_d, D);
nand nand_d_c_inst (nand_d_c, D, C);
nand nand_not_d_c_inst (nand_not_d_c, not_d, C);
nand nand_q_inst (Q, Qbar, nand_d_c, nP);
nand nand_q_bar_inst (Qbar, Q, nand_not_d_c, nR);

endmodule

// 1 bit SR latch
// Preset on nP=0, nR=1, reset on nP=1, nR=0;
// Undefined nP=0, nR=0
// normal operation nP=1, nR=1
module SR_LATCH(Q,Qbar, S, R, C, nP, nR);
input S, R, C;
input nP, nR;
output Q,Qbar;

wire nand_s_c;
wire nand_c_r;

nand nand_s_c_inst  (nand_s_c, S, C);
nand nand_c_r_inst  (nand_c_r, C, R);
nand nand_q_inst    (Q, nand_s_c, Qbar, nP);
nand nand_qbar_inst (Qbar, Q, nand_c_r, nR);

endmodule

// 5x32 Line decoder
module DECODER_5x32(D,I);
// output
output [31:0] D;
// input
input [4:0] I;

wire [15:0] DECODER_4x16_D;

not not_I4_inst (not_I4, I[4]);

DECODER_4x16 DECODER_4x16_inst (DECODER_4x16_D,I[3:0]);

and and_D0  (D[0 ], DECODER_4x16_D[0 ], not_I4);
and and_D1  (D[1 ], DECODER_4x16_D[1 ], not_I4);
and and_D2  (D[2 ], DECODER_4x16_D[2 ], not_I4);
and and_D3  (D[3 ], DECODER_4x16_D[3 ], not_I4);
and and_D4  (D[4 ], DECODER_4x16_D[4 ], not_I4);
and and_D5  (D[5 ], DECODER_4x16_D[5 ], not_I4);
and and_D6  (D[6 ], DECODER_4x16_D[6 ], not_I4);
and and_D7  (D[7 ], DECODER_4x16_D[7 ], not_I4);
and and_D8  (D[8 ], DECODER_4x16_D[8 ], not_I4);
and and_D9  (D[9 ], DECODER_4x16_D[9 ], not_I4);
and and_D10 (D[10], DECODER_4x16_D[10], not_I4);
and and_D11 (D[11], DECODER_4x16_D[11], not_I4);
and and_D12 (D[12], DECODER_4x16_D[12], not_I4);
and and_D13 (D[13], DECODER_4x16_D[13], not_I4);
and and_D14 (D[14], DECODER_4x16_D[14], not_I4);
and and_D15 (D[15], DECODER_4x16_D[15], not_I4);
and and_D16 (D[16], DECODER_4x16_D[0 ], I[4]  );
and and_D17 (D[17], DECODER_4x16_D[1 ], I[4]  );
and and_D18 (D[18], DECODER_4x16_D[2 ], I[4]  );
and and_D19 (D[19], DECODER_4x16_D[3 ], I[4]  );
and and_D20 (D[20], DECODER_4x16_D[4 ], I[4]  );
and and_D21 (D[21], DECODER_4x16_D[5 ], I[4]  );
and and_D22 (D[22], DECODER_4x16_D[6 ], I[4]  );
and and_D23 (D[23], DECODER_4x16_D[7 ], I[4]  );
and and_D24 (D[24], DECODER_4x16_D[8 ], I[4]  );
and and_D25 (D[25], DECODER_4x16_D[9 ], I[4]  );
and and_D26 (D[26], DECODER_4x16_D[10], I[4]  );
and and_D27 (D[27], DECODER_4x16_D[11], I[4]  );
and and_D28 (D[28], DECODER_4x16_D[12], I[4]  );
and and_D29 (D[29], DECODER_4x16_D[13], I[4]  );
and and_D30 (D[30], DECODER_4x16_D[14], I[4]  );
and and_D31 (D[31], DECODER_4x16_D[15], I[4]  );

endmodule

// 4x16 Line decoder
module DECODER_4x16(D,I);
// output
output [15:0] D;
// input
input [3:0] I;

wire [7:0] DECODER_3x8_D;

not not_I3_inst (not_I3, I[3]);

DECODER_3x8 DECODER_3x8_inst (DECODER_3x8_D,I[2:0]);

and and_D0  (D[0 ], DECODER_3x8_D[0], not_I3);
and and_D1  (D[1 ], DECODER_3x8_D[1], not_I3);
and and_D2  (D[2 ], DECODER_3x8_D[2], not_I3);
and and_D3  (D[3 ], DECODER_3x8_D[3], not_I3);
and and_D4  (D[4 ], DECODER_3x8_D[4], not_I3);
and and_D5  (D[5 ], DECODER_3x8_D[5], not_I3);
and and_D6  (D[6 ], DECODER_3x8_D[6], not_I3);
and and_D7  (D[7 ], DECODER_3x8_D[7], not_I3);
and and_D8  (D[8 ], DECODER_3x8_D[0], I[3]  );
and and_D9  (D[9 ], DECODER_3x8_D[1], I[3]  );
and and_D10 (D[10], DECODER_3x8_D[2], I[3]  );
and and_D11 (D[11], DECODER_3x8_D[3], I[3]  );
and and_D12 (D[12], DECODER_3x8_D[4], I[3]  );
and and_D13 (D[13], DECODER_3x8_D[5], I[3]  );
and and_D14 (D[14], DECODER_3x8_D[6], I[3]  );
and and_D15 (D[15], DECODER_3x8_D[7], I[3]  );


endmodule

// 3x8 Line decoder
module DECODER_3x8(D,I);
// output
output [7:0] D;
// input
input [2:0] I;

wire [3:0] DECODER_2x4_D;
wire not_I2;

not not_I2_inst (not_I2, I[2]);

DECODER_2x4 DECODER_2x4_inst (DECODER_2x4_D,I[1:0]);

and and_D0 (D[0], DECODER_2x4_D[0], not_I2);
and and_D1 (D[1], DECODER_2x4_D[1], not_I2);
and and_D2 (D[2], DECODER_2x4_D[2], not_I2);
and and_D3 (D[3], DECODER_2x4_D[3], not_I2);
and and_D4 (D[4], DECODER_2x4_D[0], I[2]);
and and_D5 (D[5], DECODER_2x4_D[1], I[2]);
and and_D6 (D[6], DECODER_2x4_D[2], I[2]);
and and_D7 (D[7], DECODER_2x4_D[3], I[2]);

endmodule

// 2x4 Line decoder
module DECODER_2x4(D,I);
// output
output [3:0] D;
// input
input [1:0] I;

wire not_I0;
wire not_I1;

not not_I0_inst (not_I0, I[0]);
not not_I1_inst (not_I1, I[1]);

and and_D0 (D[0], not_I1, not_I0);
and and_D1 (D[1], not_I1, I[0]);
and and_D2 (D[2], I[1], not_I0);
and and_D3 (D[3], I[1], I[0]);

endmodule

// 32-bit mux
module MUX32_32x1(Y, I0, I1, I2, I3, I4, I5, I6, I7,
                     I8, I9, I10, I11, I12, I13, I14, I15,
                     I16, I17, I18, I19, I20, I21, I22, I23,
                     I24, I25, I26, I27, I28, I29, I30, I31, S);
// output list
output [31:0] Y;
//input list
input [31:0] I0, I1, I2, I3, I4, I5, I6, I7;
input [31:0] I8, I9, I10, I11, I12, I13, I14, I15;
input [31:0] I16, I17, I18, I19, I20, I21, I22, I23;
input [31:0] I24, I25, I26, I27, I28, I29, I30, I31;
input [4:0] S;

wire [31:0] MUX32_16x1_0_Y;
wire [31:0] MUX32_16x1_1_Y;

MUX32_2x1 MUX32_2x1_inst (Y, MUX32_16x1_0_Y, MUX32_16x1_1_Y, S[4]);
MUX32_16x1 MUX32_16x1_0_inst (MUX32_16x1_0_Y, I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15, S[3:0]);
MUX32_16x1 MUX32_16x1_1_inst (MUX32_16x1_1_Y, I16, I17, I18, I19, I20, I21, I22, I23, I24, I25, I26, I27, I28, I29, I30, I31, S[3:0]);

endmodule

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