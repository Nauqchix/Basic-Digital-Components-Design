module REGISTER_FILE_32x32_ARCH_MODEL(
  // Outputs
  output [31:0] DATA_R1, 
  output [31:0] DATA_R2,
  // Inputs
  input [31:0] DATA_W,
  input [4:0] ADDR_R1, ADDR_R2, ADDR_W,
  input READ, WRITE, CLK, RST
);

  wire [31:0] DECODER_5x32_D;
  wire [31:0] DECODER_5x32_D_and_write;
  wire [31:0] REG32_Q [0:31];
  wire [31:0] MUX32_32x1_ADDR_R1_Y;
  wire [31:0] MUX32_32x1_ADDR_R2_Y;
  
  genvar i;
  
  DECODER_5x32 DECODER_5x32_inst (DECODER_5x32_D, ADDR_W[4:0]);
  
  generate 
      for (i=0; i<32; i=i+1)
      begin : DECODER_5x32_D_and_write_gen_loop
          and DECODER_5x32_D_and_write_inst (DECODER_5x32_D_and_write[i], DECODER_5x32_D[i], WRITE);
      end
  endgenerate
  
  generate 
      for (i=0; i<32; i=i+1)
      begin : REG32_gen_loop
          REG32 REG32_inst (REG32_Q[i], DATA_W, DECODER_5x32_D_and_write[i], CLK, RST);
      end
  endgenerate
  
  MUX32_32x1 MUX32_32x1_ADDR_R1_Y_inst (MUX32_32x1_ADDR_R1_Y, REG32_Q[0], REG32_Q[1], REG32_Q[2], REG32_Q[3], REG32_Q[4], REG32_Q[5], REG32_Q[6], REG32_Q[7], 
                       REG32_Q[8], REG32_Q[9], REG32_Q[10], REG32_Q[11], REG32_Q[12], REG32_Q[13], REG32_Q[14], REG32_Q[15],
                       REG32_Q[16], REG32_Q[17], REG32_Q[18], REG32_Q[19], REG32_Q[20], REG32_Q[21], REG32_Q[22], REG32_Q[23],
                       REG32_Q[24], REG32_Q[25], REG32_Q[26], REG32_Q[27], REG32_Q[28], REG32_Q[29], REG32_Q[30], REG32_Q[31], ADDR_R1[4:0]);
  
  MUX32_32x1 MUX32_32x1_ADDR_R2_Y_inst (MUX32_32x1_ADDR_R2_Y, REG32_Q[0], REG32_Q[1], REG32_Q[2], REG32_Q[3], REG32_Q[4], REG32_Q[5], REG32_Q[6], REG32_Q[7],
                       REG32_Q[8], REG32_Q[9], REG32_Q[10], REG32_Q[11], REG32_Q[12], REG32_Q[13], REG32_Q[14], REG32_Q[15],
                       REG32_Q[16], REG32_Q[17], REG32_Q[18], REG32_Q[19], REG32_Q[20], REG32_Q[21], REG32_Q[22], REG32_Q[23],
                       REG32_Q[24], REG32_Q[25], REG32_Q[26], REG32_Q[27], REG32_Q[28], REG32_Q[29], REG32_Q[30], REG32_Q[31], ADDR_R2[4:0]);
  					 
  MUX32_2x1 MUX32_2x1_ADDR_R1 (DATA_R1, 32'dz, MUX32_32x1_ADDR_R1_Y, READ);					 
  MUX32_2x1 MUX32_2x1_ADDR_R2 (DATA_R2, 32'dz, MUX32_32x1_ADDR_R2_Y, READ);
  
endmodule