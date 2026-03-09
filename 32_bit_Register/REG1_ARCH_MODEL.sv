// 1 bit register +ve edge, 
// Preset on nP=0, nR=1, reset on nP=1, nR=0;
// Undefined nP=0, nR=0
// normal operation nP=1, nR=1
module REG1_ARCH_MODEL (Q, Qbar, D, L, C, nP, nR);
  input D, C, L;
  input nP, nR;
  output Q,Qbar;

  wire mux_out;

  MUX1_2x1 MUX1_2x1_inst (.Y(mux_out), .I0(Q), .I1(D), .S(L));
  D_FF D_FF_inst (.Q(Q), .Qbar(Qbar), .D(mux_out), .C(C), .nP(nP), .nR(nR));

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