// 32-bit mux
module MUX32_2x1_ARCH_MODEL(Y, I0, I1, S);
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
        MUX1_2x1_ARCH_MODEL MUX1_2x1_ARCH_MODEL_inst (Y[i],I0[i], I1[i], S);
    end
  endgenerate

endmodule

// 1-bit mux
module MUX1_2x1_ARCH_MODEL(Y,I0, I1, S);
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