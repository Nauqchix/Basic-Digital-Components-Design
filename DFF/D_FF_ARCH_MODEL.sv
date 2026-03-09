// 1 bit flipflop +ve edge, 
// Preset on nP=0, nR=1, reset on nP=1, nR=0;
// Undefined nP=0, nR=0
// normal operation nP=1, nR=1
module D_FF_ARCH_MODEL (Q, Qbar, D, C, nP, nR);
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