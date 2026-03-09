module D_FF_DATA_FLOW_MODEL (Q, Qbar, D, C, nP, nR);
  input D, C;
  input nP, nR;
  output Q,Qbar;
  
  //TBD
  assign not_C = ~C;
  assign not_D = ~D;
  
  wire D_out, C_out;
  assign D_out = ~(D & not_C);
  assign C_out = ~(not_D & not_C);
  
  wire DL_out_1, DL_out_2;
  assign DL_out_1 = ~(nP & D_out & DL_out_2);
  assign DL_out_2 = ~(nR & C_out & DL_out_1);
  
  wire SR_out_1, SR_out_2;
  assign SR_out_1 = ~(DL_out_1 & C);
  assign SR_out_2 = ~(DL_out_2 & C);
  
  wire SRL_out_1, SRL_out_2;
  assign SRL_out_1 = ~(nP & SR_out_1 & SRL_out_2);
  assign SRL_out_2 = ~(nR & SR_out_2 & SRL_out_1);
  
  assign Q = SRL_out_1;
  assign Qbar = SRL_out_2;

endmodule