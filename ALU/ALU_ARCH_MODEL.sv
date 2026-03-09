module ALU_ARCH_MODEL (OUT, ZERO, OP1, OP2, OPRN);
  // input list
  input [31:0] OP1; // operand 1
  input [31:0] OP2; // operand 2
  input [5:0] OPRN; // operation code
  
  // output list
  output [31:0] OUT; // result of the operation.
  output ZERO;
  
  wire [31:0] MUX32_16x1_Y;
  wire [31:0] MUX32_16x1_I0;
  wire [31:0] MUX32_16x1_I1;
  wire [31:0] MUX32_16x1_I2;
  wire [31:0] MUX32_16x1_I3;
  wire [31:0] MUX32_16x1_I4;
  wire [31:0] MUX32_16x1_I5;
  wire [31:0] MUX32_16x1_I6;
  wire [31:0] MUX32_16x1_I7;
  wire [31:0] MUX32_16x1_I8;
  wire [31:0] MUX32_16x1_I9;
  wire [31:0] MUX32_16x1_I10;
  wire [31:0] MUX32_16x1_I11;
  wire [31:0] MUX32_16x1_I12;
  wire [31:0] MUX32_16x1_I13;
  wire [31:0] MUX32_16x1_I14;
  wire [31:0] MUX32_16x1_I15;
  wire [31:0] MULT32_LO;
  wire [31:0] SHIFT32_Y;
  wire [31:0] RC_ADD_SUB_32_Y;
  wire        RC_ADD_SUB_32_SnA;
  wire [31:0] NOR32_2x1_Y;
  wire [31:0] AND32_2x1_Y;
  wire [31:0] OR32_2x1_Y;
  wire        not_oprn0;
  wire        oprn0_and_oprn3 ;
  wire        or_sna ;
  wire        or_Y_bits;
  
  
  MUX32_16x1 MUX32_16x1_inst (MUX32_16x1_Y, MUX32_16x1_I0, MUX32_16x1_I1, MUX32_16x1_I2, MUX32_16x1_I3, 
                              MUX32_16x1_I4, MUX32_16x1_I5, MUX32_16x1_I6, MUX32_16x1_I7, MUX32_16x1_I8, 
  			                MUX32_16x1_I9, MUX32_16x1_I10, MUX32_16x1_I11, MUX32_16x1_I12, MUX32_16x1_I13, 
  							MUX32_16x1_I14, MUX32_16x1_I15, OPRN[3:0]);
  							
  MULT32 MULT32_inst (, MULT32_LO, OP1, OP2);
  
  SHIFT32 SHIFT32_inst (SHIFT32_Y, OP1, OP2, OPRN[0]);
  
  RC_ADD_SUB_32 RC_ADD_SUB_32_inst (RC_ADD_SUB_32_Y, , OP1, OP2, RC_ADD_SUB_32_SnA);
  
  NOR32_2x1 NOR32_2x1_inst (NOR32_2x1_Y, OP1, OP2);
  
  AND32_2x1 AND32_2x1_inst (AND32_2x1_Y, OP1, OP2);
  
  OR32_2x1 OR32_2x1_inst (OR32_2x1_Y, OP1, OP2);
  
  not not_inst (not_oprn0, OPRN[0]);
  and and_inst (oprn0_and_oprn3, OPRN[0], OPRN[3]);
  or or_gate (or_sna, not_oprn0, oprn0_and_oprn3);
  buf buf_sna (RC_ADD_SUB_32_SnA, or_sna);
  
  
  genvar i;
  generate 
      for (i=0; i<32; i=i+1)
      begin : MUX32_16x1_I1_gen_loop
          buf buf_inst (MUX32_16x1_I1[i], RC_ADD_SUB_32_Y[i]);
      end
  endgenerate
  
  generate 
      for (i=0; i<32; i=i+1)
      begin : MUX32_16x1_I2_gen_loop
          buf buf_inst (MUX32_16x1_I2[i], RC_ADD_SUB_32_Y[i]);
      end
  endgenerate
  
  buf buf_MUX32_16x1_I9_0 (MUX32_16x1_I9[0], RC_ADD_SUB_32_Y[31]);
  generate 
      for (i=1; i<32; i=i+1)
      begin : MUX32_16x1_I9_gen_loop
          buf buf_inst (MUX32_16x1_I9[i], 1'b0);
      end
  endgenerate
  
  generate 
      for (i=0; i<32; i=i+1)
      begin : MUX32_16x1_I3_gen_loop
          buf buf_inst (MUX32_16x1_I3[i], MULT32_LO[i]);
      end
  endgenerate
  
  generate 
      for (i=0; i<32; i=i+1)
      begin : MUX32_16x1_I4_gen_loop
          buf buf_inst (MUX32_16x1_I4[i], SHIFT32_Y[i]);
      end
  endgenerate
  
  generate 
      for (i=0; i<32; i=i+1)
      begin : MUX32_16x1_I5_gen_loop
          buf buf_inst (MUX32_16x1_I5[i], SHIFT32_Y[i]);
      end
  endgenerate
  
  generate 
      for (i=0; i<32; i=i+1)
      begin : MUX32_16x1_I6_gen_loop
          buf buf_inst (MUX32_16x1_I6[i], AND32_2x1_Y[i]);
      end
  endgenerate
  
  generate 
      for (i=0; i<32; i=i+1)
      begin : MUX32_16x1_I7_gen_loop
          buf buf_inst (MUX32_16x1_I7[i], OR32_2x1_Y[i]);
      end
  endgenerate
  
  generate 
      for (i=0; i<32; i=i+1)
      begin : MUX32_16x1_I8_gen_loop
          buf buf_inst (MUX32_16x1_I8[i], NOR32_2x1_Y[i]);
      end
  endgenerate
  
  generate 
      for (i=0; i<32; i=i+1)
      begin : OUT_gen_loop
          buf buf_inst (OUT[i], MUX32_16x1_Y[i]);
      end
  endgenerate
  
  or or_Y_bits_inst (or_Y_bits, OUT[0 ], OUT[1 ], OUT[2 ], OUT[3 ], OUT[4 ], OUT[5 ], OUT[6 ], OUT[7 ], OUT[8 ], OUT[9 ], 
  							  OUT[10], OUT[11], OUT[12], OUT[13], OUT[14], OUT[15], OUT[16], OUT[17], OUT[18], OUT[19], 
  							  OUT[20], OUT[21], OUT[22], OUT[23], OUT[24], OUT[25], OUT[26], OUT[27], OUT[28], OUT[29], OUT[30], OUT[31]);
  
  not not_inst_zero (ZERO, or_Y_bits);	  

endmodule