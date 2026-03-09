// 32-bit registere +ve edge, Reset on RESET=0
module REG32_ARCH_MODEL (Q, D, LOAD, CLK, RESET);
  output [31:0] Q;

  input CLK, LOAD;
  input [31:0] D;
  input RESET;

  parameter [31:0] P_RST_VAL = 32'ha5b9;

  genvar i;
  generate
    for (i = 0; i < 32; i = i + 1) begin: not_loop
	  if (P_RST_VAL[i] == 1'b0)
        REG1_ARCH_MODEL REG1_ARCH_MODEL_inst (.Q(Q[i]), .D(D[i]), .L(LOAD), .C(CLK), .nP(1'b1), .nR(RESET));
	  else
        REG1_ARCH_MODEL REG1_ARCH_MODEL_inst (.Q(Q[i]), .D(D[i]), .L(LOAD), .C(CLK), .nP(RESET), .nR(1'b1));
    end
  endgenerate

endmodule